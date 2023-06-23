function NetworkMatchMakingEPIC:search_lobby(friends_only, no_filters)
	self._search_friends_only = friends_only

	if not self:_has_callback("search_lobby") then
		return
	end

	if friends_only then
		self:get_friends_lobbies()
	else
		-- Lines 443-480
		local function refresh_lobby()
			local lobbies = LobbyBrowser:lobbies()
			local info = {
				room_list = {},
				attribute_list = {}
			}

			if lobbies then
				for _, lobby in ipairs(lobbies) do
					if self._difficulty_filter == 0 or self._difficulty_filter == tonumber(lobby:key_value("difficulty")) then
						table.insert(info.room_list, self:_make_room_info(lobby))

						local attributes_data = {
							numbers = self:_lobby_to_numbers(lobby),
							mutators = self:_get_mutators_from_lobby(lobby),
							crime_spree = tonumber(lobby:key_value("crime_spree")),
							crime_spree_mission = lobby:key_value("crime_spree_mission"),
							mods = lobby:key_value("mods"),
							one_down = tonumber(lobby:key_value("one_down")),
							skirmish = tonumber(lobby:key_value("skirmish")),
							skirmish_wave = tonumber(lobby:key_value("skirmish_wave")),
							skirmish_weekly_modifiers = lobby:key_value("skirmish_weekly_modifiers")
						}

						table.insert(info.attribute_list, attributes_data)
					end
				end
			end

			self:_call_callback("search_lobby", info)
		end

		LobbyBrowser:set_callbacks(refresh_lobby)

		local interest_keys = {
			"owner_id",
			"owner_name",
			"level",
			"difficulty",
			"permission",
			"state",
			"num_players",
			"drop_in",
			"min_level",
			"kick_option",
			"job_class_min",
			"job_class_max",
			"allow_mods"
		}

		if self._BUILD_SEARCH_INTEREST_KEY then
			table.insert(interest_keys, self._BUILD_SEARCH_INTEREST_KEY)
		end

		LobbyBrowser:set_interest_keys(interest_keys)
		LobbyBrowser:set_distance_filter(self._distance_filter)

		local use_filters = not no_filters

		if Global.game_settings.gamemode_filter ~= GamemodeStandard.id then
			use_filters = false
		end

		LobbyBrowser:set_lobby_filter(self._BUILD_SEARCH_INTEREST_KEY, "true", "equal")

		local filter_value, filter_type = self:get_modded_lobby_filter()

		LobbyBrowser:set_lobby_filter("mods", filter_value, filter_type)

		local filter_value, filter_type = self:get_allow_mods_filter()

		LobbyBrowser:set_lobby_filter("allow_mods", filter_value, filter_type)
		LobbyBrowser:set_lobby_filter("one_down", Global.game_settings.search_one_down_lobbies and 1 or 0, "equalto_or_greater_than")

		if use_filters then
			LobbyBrowser:set_lobby_filter("min_level", managers.experience:current_level(), "equalto_less_than")

			if Global.game_settings.search_appropriate_jobs then
				local min_ply_jc = managers.job:get_min_jc_for_player()
				local max_ply_jc = managers.job:get_max_jc_for_player()

				LobbyBrowser:set_lobby_filter("job_class_min", min_ply_jc, "equalto_or_greater_than")
				LobbyBrowser:set_lobby_filter("job_class_max", max_ply_jc, "equalto_less_than")
			end
		end

		if not no_filters then
			if false then
				-- Nothing
			elseif Global.game_settings.gamemode_filter == GamemodeCrimeSpree.id then
				local min_level = 0

				if Global.game_settings.crime_spree_max_lobby_diff >= 0 then
					min_level = managers.crime_spree:spree_level() - (Global.game_settings.crime_spree_max_lobby_diff or 0)
					min_level = math.max(min_level, 0)
				end

				LobbyBrowser:set_lobby_filter("crime_spree", min_level, "equalto_or_greater_than")
			elseif Global.game_settings.gamemode_filter == "skirmish" then
				local min = SkirmishManager.LOBBY_NORMAL

				LobbyBrowser:set_lobby_filter("skirmish", min, "equalto_or_greater_than")
				LobbyBrowser:set_lobby_filter("skirmish_wave", Global.game_settings.skirmish_wave_filter or 99, "equalto_less_than")
			elseif Global.game_settings.gamemode_filter == GamemodeStandard.id then
				LobbyBrowser:set_lobby_filter("crime_spree", -1, "equalto_less_than")
				LobbyBrowser:set_lobby_filter("skirmish", 0, "equalto_less_than")
			end
		end

		if use_filters then
			for key, data in pairs(self._lobby_filters) do
				if data.value and data.value ~= -1 then
					LobbyBrowser:set_lobby_filter(data.key, data.value, data.comparision_type)
					print(data.key, data.value, data.comparision_type)
				end
			end
		end

		LobbyBrowser:set_max_lobby_return_count(self._lobby_return_count)
		LobbyBrowser:refresh()
	end
end
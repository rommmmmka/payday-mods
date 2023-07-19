Hooks:AddHook("LocalizationManagerPostInit", "dzedbaradzed_onlyodfilter_change_loc_strings", function()
	if Idstring("russian"):key() == SystemInfo:language():key() then
		LocalizationManager:add_localized_strings({
			menu_toggle_one_down_lobbies = "показывать только лобби с 1 падением"
		})
	else
		LocalizationManager:add_localized_strings({
			menu_toggle_one_down_lobbies = "one down lobbies only"
		})
	end
end)

Hooks:AddHook("LocalizationManagerPostInit", "dzedbaradzed_onlyodfilter_change_loc_strings", function()
	if Idstring("russian"):key() == SystemInfo:language():key() then
		LocalizationManager:add_localized_strings({
			menu_toggle_one_down_lobbies = "только лобби с включенным one down"
		})
	else
		LocalizationManager:add_localized_strings({
			menu_toggle_one_down_lobbies = "allow only one down lobbies"
		})
	end
end)

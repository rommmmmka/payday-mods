Hooks:PostHook(BootupState, "setup_intro_videos", "dzedbaradzed_unabombermanifesto_change_font_size", function(self)
	if Idstring("russian"):key() == SystemInfo:language():key() then
        local legal_text = managers.localization:text("legal_text")
        
        for _, value in ipairs(self._play_data_list) do
            if value.text and value.text == legal_text then
                value.font_size = 20
                break
            end
        end
    end
end)

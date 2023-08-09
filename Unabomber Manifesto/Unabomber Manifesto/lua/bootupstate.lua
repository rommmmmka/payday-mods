Hooks:PostHook(BootupState, "setup_intro_videos", "dzedbaradzed_unabombermanifesto_font_size", function(self)
    local legal_text = managers.localization:text("legal_text")
    
    for _, value in ipairs(self._play_data_list) do
        if value.text and value.text == legal_text then
            value.font_size = DzedBaradzed_UnabomberManifesto.data.font
            break
        end
    end
end)

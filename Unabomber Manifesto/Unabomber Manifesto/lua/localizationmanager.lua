Hooks:AddHook("LocalizationManagerPostInit", "dzedbaradzed_unabombermanifesto_loc", function()
	local lang_code = "en"
	if Idstring("russian"):key() == SystemInfo:language():key() then
		lang_code = "ru"
	end
	
	LocalizationManager:load_localization_file(DzedBaradzed_UnabomberManifesto.mod_path .. "loc/" .. lang_code .. ".json")
	
	local quotes_file = io.open(DzedBaradzed_UnabomberManifesto.mod_path .. "loc/" .. lang_code .. "_quotes.json", "r")
	local quotes = json.decode(quotes_file:read("*all"))
	quotes_file:close()
	
	local quote = quotes[2] -- First sentence
	DzedBaradzed_UnabomberManifesto:Load()
	if DzedBaradzed_UnabomberManifesto.data.type == 1 then -- Random quote
		quote = quotes[math.random(2, #quotes)]
	elseif DzedBaradzed_UnabomberManifesto.data.type == 2 then -- Intoduction
		quote = quotes[1]
	end
	
	LocalizationManager:add_localized_strings({
		legal_text = quote
	})
end)

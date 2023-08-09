_G.DzedBaradzed_UnabomberManifesto = _G.DzedBaradzed_UnabomberManifesto or {}
DzedBaradzed_UnabomberManifesto.mod_path = ModPath
DzedBaradzed_UnabomberManifesto.data_path = SavePath .. "dzedbaradzed_unabombermanifesto.json"
DzedBaradzed_UnabomberManifesto.data = {}

function DzedBaradzed_UnabomberManifesto:LoadDefaultValues()
	self.data = {
		font = 24,
		type = 1
	}
end

function DzedBaradzed_UnabomberManifesto:Save()
	local file = io.open(self.data_path, "w+")
	if file then
		file:write(json.encode(self.data))
		file:close()
	end
end

function DzedBaradzed_UnabomberManifesto:Load()
	local file = io.open(self.data_path, "r")
	if file then
		self.data = json.decode(file:read("*all"))
		file:close()
	else
		self:LoadDefaultValues()
	end
end

Hooks:Add("MenuManagerInitialize", "dzedbaradzed_unabombermanifesto_menu", function(menu_manager)
	MenuCallbackHandler.dzedbaradzed_unabombermanifesto_type_callback = function(self, item)
		DzedBaradzed_UnabomberManifesto.data.type = item:value()
		DzedBaradzed_UnabomberManifesto:Save()
	end
    
	MenuCallbackHandler.dzedbaradzed_unabombermanifesto_font_callback = function(self, item)
		DzedBaradzed_UnabomberManifesto.data.font = math.floor(item:value() + 0.5)
		DzedBaradzed_UnabomberManifesto:Save()
	end
	
	DzedBaradzed_UnabomberManifesto:Load()
	MenuHelper:LoadFromJsonFile(DzedBaradzed_UnabomberManifesto.mod_path .. "menu.json", DzedBaradzed_UnabomberManifesto, DzedBaradzed_UnabomberManifesto.data)
end)



Hooks:PostHook(MenuCallbackHandler, "chocie_one_down_filter", "OnlyODFilterMod_Refresh", function()
	managers.network.matchmake:search_lobby(managers.network.matchmake:search_friends_only())
end)

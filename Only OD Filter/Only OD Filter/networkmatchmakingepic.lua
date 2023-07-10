Hooks:PostHook(NetworkMatchMakingEPIC, "search_lobby", "dzedbaradzed_only_od_filter", function(self, friends_only, no_filters)
    LobbyBrowser:set_lobby_filter("one_down", Global.game_settings.search_one_down_lobbies and 1 or 0, "equalto_or_greater_than")
    LobbyBrowser:refresh()
end)
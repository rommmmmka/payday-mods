Hooks:PostHook(MenuManager, "init", "SortContractFilterListMod", function(self)
    table.sort(tweak_data.narrative._jobs_index, function(a,b)
        return tweak_data.narrative:create_job_name(a) < tweak_data.narrative:create_job_name(b)
    end)
end)
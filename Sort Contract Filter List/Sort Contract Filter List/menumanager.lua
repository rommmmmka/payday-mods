Hooks:PostHook(MenuCrimeNetFiltersInitiator, "add_filters", "dzedbaradzed_sortcontractfilterlist", function(self, node)
    table.sort(node:item("job_id_filter")._all_options, function(a, b)
        if a._parameters.value == -1 or b._parameters.value == -1 then
            return a._parameters.value < b._parameters.value
        end
        return a._parameters.text_id < b._parameters.text_id
    end)
end)

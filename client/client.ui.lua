RegisterNUICallback('sunny-job-rangerpark:nui:refresh-player', function(_, cb)
    TriggerEvent("sunny-job-rangerpark:client:showCriminalRecords");
    cb({})
end)

RegisterNUICallback('sunny-job-rangerpark:nui:hideFrame', function(_, cb)
    ToggleNuiFrame(false)
    cb({})
end)

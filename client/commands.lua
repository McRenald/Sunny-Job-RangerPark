
-- Commands
RegisterCommand("rp_start", function()
    TriggerEvent("sunny-job-rangerpark:client:start-mission")
end, false)

RegisterCommand("rp_stop", function()
    TriggerEvent("sunny-job-rangerpark:client:stop-mission")
end, false)

RegisterCommand("rp_ui", function()
    TriggerEvent("sunny-job-rangerpark:client:showCriminalRecords")
end, false)

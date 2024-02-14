
-- Commands
RegisterCommand("rpnext", function ()
    TriggerEvent("sunny-job-rangerpark:client:get-next-mission")
end, false)

RegisterCommand("rpclear", function ()
    if NextMission ~= nil then
        DeleteMissionPrompt(NextMission)
        DeleteMission(NextMission)
    else
        QbrCore:TriggerCallback("sunny-job-rangerpark:server:get-missions", function(missions)
            for key, value in pairs(missions) do
                DeleteMissionPrompt(value)
                DeleteMission(value)
            end
        end)
    end
    HasMissionPrompt = false
end, false)

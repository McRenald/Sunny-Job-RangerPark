
-- Commands
RegisterCommand("rpnext", function ()
    TriggerEvent("sunny-job-rangerpark:client:next-location")
end, false)

RegisterCommand("rpclear", function ()
    if NextLocation ~= nil then
        QbrCore:DeleteBlip(NextLocation.id)
        DeleteLocationPrompt(NextLocation)
        NextLocation = nil
    else
        QbrCore:TriggerCallback("sunny-job-rangerpark:server:getLocations", function(locations)
            for key, value in pairs(locations) do
                QbrCore:DeleteBlip(value.id)
                DeleteLocationPrompt(value)
            end
        end)
    end
    HasLocationPrompt = false
end, false)

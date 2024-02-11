
-- Commands
RegisterCommand('rpnext', function ()
    if NextLocation == nil then
        QbrCore:TriggerCallback('sunny-job-rangerpark:server:getNextLocation', function(nextLocation)
            print('nextLocation', nextLocation.id)
            NextLocation = nextLocation
            QbrCore:CreateBlip(nextLocation.id, nextLocation.city, nextLocation.coords.x, nextLocation.coords.y, nextLocation.coords.z, GetHashKey(RunBlipType))
        end)
    end
end, false)

RegisterCommand('rpclear', function ()
    if NextLocation ~= nil then
        QbrCore:DeleteBlip(NextLocation.id)
        DeleteLocationPrompt(NextLocation)
        NextLocation = nil
    else
        QbrCore:TriggerCallback('sunny-job-rangerpark:server:getLocations', function(locations)
            for key, value in pairs(locations) do
                QbrCore:DeleteBlip(value.id)
                QbrCore:deletePrompt(value.id)
            end
        end)
    end
    LocationPrompt = false
end, false)

-- Config
RunBlipType = "BLIP_AMBIENT_PED_SMALL"

-- Vars
QbrCore = exports['qbr-core']
NextLocation = nil

-- Threads
CreateThread(function()
    while true do
        Wait(1000)
        
        if NextLocation ~= nil then
            local playerCoords = GetEntityCoords(PlayerPedId(), true)
                        
            if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, NextLocation.x, NextLocation.y, NextLocation.z, true) < 15 then
                print("Player is within the area.")
            else
                print("Player is not on the location.")
            end
        end
    end
end)

-- Commands
RegisterCommand('rpnext', function ()
    if NextLocation == nil then
        QbrCore:TriggerCallback('sunny-job-rangerpark:server:getNextLocation', function(nextLocation)
            print('nextLocation', nextLocation.id)
            NextLocation = nextLocation
            QbrCore:CreateBlip(nextLocation.id, nextLocation.city, nextLocation.coords.x, nextLocation.coords.y, nextLocation.coords.z, GetHashKey(BlipType))
        end)
    end
end, false)

RegisterCommand('rpclear', function ()
    QbrCore:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        for key, value in pairs(blips) do
            QbrCore:DeleteBlip(value.id)
        end
    end)
end, false)

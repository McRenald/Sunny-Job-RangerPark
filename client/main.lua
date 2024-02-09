QbrCore = exports['qbr-core']

BlipType = "BLIP_AMBIENT_PED_SMALL"

-- Threads
CreateThread(function()
    while true do
        Wait(500)
        
        local playerCoords = GetEntityCoords(PlayerPedId(), true)
        print('Coords', playerCoords.x)
    end
end)

-- Commands
RegisterCommand('rpnext', function ()
    QbrCore:TriggerCallback('sunny-job-rangerpark:server:getNextLocation', function(nextLocation)
        print('nextLocation', nextLocation.id)
        QbrCore:CreateBlip(nextLocation.id, nextLocation.city, nextLocation.coords.x, nextLocation.coords.y, nextLocation.coords.z, GetHashKey(BlipType))
    end)
end, false)

RegisterCommand('rpclear', function ()
    QbrCore:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        for key, value in pairs(blips) do
            QbrCore:DeleteBlip(value.id)
        end
    end)
end, false)

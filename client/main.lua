QbrCore = exports['qbr-core']

-- Threads
/*CreateThread(function()
    while true do
        Wait(500)
        
        local playerCoords = GetEntityCoords(PlayerPedId(), true)
        print('Coords', playerCoords.x)
    end
end)*/

-- Commands
RegisterCommand('rplocations', function ()
    QbrCore:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        for key, value in pairs(blips) do
            --print(key, value.id, value.city, value.coords)
            QbrCore:CreateBlip(value.id, value.city, value.coords.x, value.coords.y, value.coords.z, GetHashKey("BLIP_AMBIENT_PED_SMALL"))
        end
    end)
end, false)

RegisterCommand('rpnext', function ()
    QbrCore:TriggerCallback('sunny-job-rangerpark:server:getNextLocation', function(nextLocation)
        print('nextLocation', nextLocation)
    end)
end, false)

RegisterCommand('rpclear', function ()
    QbrCore:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        for key, value in pairs(blips) do
            QbrCore:DeleteBlip(value.id)
        end
    end)
end, false)

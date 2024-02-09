-- Config
RunBlipType = "BLIP_AMBIENT_PED_SMALL"

-- Vars
QbrCore = exports['qbr-core']
NextLocation = nil

-- Threads
CreateThread(function()
    while true do
        Wait(2000)
        
        if NextLocation ~= nil then
            local playerCoords = GetEntityCoords(PlayerPedId(), true)
                       
            local distance = #(playerCoords - NextLocation.coords)
            print('distance', distance)
        end
    end
end)

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
        NextLocation = nil
    end
end, false)

-- Vars
QbrCore = exports['qbr-core']
NextLocation = nil

-- Config
RunBlipType = "BLIP_AMBIENT_PED_SMALL"

-- Threads
/*CreateThread(function()
    while true do
        Wait(2000)
        
        if NextLocation ~= nil then
            local playerCoords = GetEntityCoords(PlayerPedId(), true)
                       
            local distance = #(playerCoords - NextLocation.coords)
            if distance < 7 then
                
            end
        end
    end
end)*/

-- Commands
RegisterCommand('rpnext', function ()
    if NextLocation == nil then
        QbrCore:TriggerCallback('sunny-job-rangerpark:server:getNextLocation', function(nextLocation)
            print('nextLocation', nextLocation.id)
            NextLocation = nextLocation
            QbrCore:CreateBlip(nextLocation.id, nextLocation.city, nextLocation.coords.x, nextLocation.coords.y, nextLocation.coords.z, GetHashKey(RunBlipType))
            QbrCore:createPrompt(nextLocation.id, nextLocation.coords, 0xF3830D8E, 'Traiter l\'arbre', { -- [J]
                type = 'client',
                event = 'sunny-job-rangerpark:client:processing',
                args = { NextLocation }
            })
        end)
    end
end, false)

RegisterCommand('rpclear', function ()
    if NextLocation ~= nil then
        QbrCore:DeleteBlip(NextLocation.id)
        NextLocation = nil
    end
end, false)

RegisterCommand('notify1', function ()
    QbrCore:Notify(1, 'Bon travail !', 5000)
end, false)
RegisterCommand('notify2', function ()
    QbrCore:Notify(2, 'Bon travail !', 5000)
end, false)
RegisterCommand('notify3', function ()
    QbrCore:Notify(3, 'Bon travail !', 5000)
end, false)
RegisterCommand('notify4', function ()
    QbrCore:Notify(4, 'Bon travail !', 5000)
end, false)
RegisterCommand('notify5', function ()
    QbrCore:Notify(5, 'Bon travail !', 5000)
end, false)
RegisterCommand('notify6', function ()
    QbrCore:Notify(6, 'Bon travail !', 5000)
end, false)
RegisterCommand('notify7', function ()
    QbrCore:Notify(7, 'Bon travail !', 5000)
end, false)
RegisterCommand('notify8', function ()
    QbrCore:Notify(8, 'Bon travail !', 5000)
end, false)
RegisterCommand('notify9', function ()
    QbrCore:Notify(9, 'Bon travail !', 5000)
end, false)

-- Events
RegisterNetEvent('sunny-job-rangerpark:client:processing', function(location)
    QbrCore:deletePrompt(location.id)
    QbrCore:Progressbar("hospital_revive", "Traitement", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        QbrCore:Notify(7, 'Bon travail !', 5000)
        QbrCore:DeleteBlip(location.id)
        NextLocation = nil
    end)
end)

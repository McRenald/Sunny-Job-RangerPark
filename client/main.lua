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

-- Events
RegisterNetEvent('sunny-job-rangerpark:client:processing', function(location)
    QbrCore:deletePrompt(location.id)
    QbrCore:Progressbar("hospital_revive", "Traitement", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        QbrCore:Notify(9, 'Bon travail !', 5000, 0, "hud_textures", "check", "COLOR_WHITE")
        QbrCore:DeleteBlip(location.id)
        NextLocation = nil
    end)
end)

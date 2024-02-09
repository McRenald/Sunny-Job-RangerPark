-- Vars
QbrCore = exports['qbr-core']
NextLocation = nil
LocationPrompt = false

-- Config
RunBlipType = "BLIP_AMBIENT_PED_SMALL"

-- Threads
CreateThread(function()
    while true do
        Wait(1000)
        
        if NextLocation ~= nil then
            local playerCoords = GetEntityCoords(PlayerPedId(), true)                       
            local distance = #(playerCoords - NextLocation.coords)
            if distance < 7 and LocationPrompt == false then
                QbrCore:createPrompt(NextLocation.id, NextLocation.coords, 0xF3830D8E, 'Traiter l\'arbre', { -- [J]
                    type = 'client',
                    event = 'sunny-job-rangerpark:client:processing',
                    args = { NextLocation }
                })
                LocationPrompt = true
            else
                if distance > 7 and LocationPrompt then
                    QbrCore:deletePrompt(NextLocation.id)
                    LocationPrompt = false
                end
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
            QbrCore:CreateBlip(nextLocation.id, nextLocation.city, nextLocation.coords.x, nextLocation.coords.y, nextLocation.coords.z, GetHashKey(RunBlipType))
        end)
    end
end, false)

RegisterCommand('rpclear', function ()
    if NextLocation ~= nil then
        QbrCore:DeleteBlip(NextLocation.id)
        NextLocation = nil
    else
        QbrCore:TriggerCallback('sunny-job-rangerpark:server:getLocations', function(locations)
            for key, value in pairs(locations) do
                QbrCore:DeleteBlip(value.id)
            end
        end)
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
        QbrCore:Notify(4, 'Bon travail !', 5000) -- id=2 good too
        QbrCore:DeleteBlip(location.id)
        NextLocation = nil
    end)
end)
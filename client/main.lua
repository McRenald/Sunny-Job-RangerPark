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
                CreateLocationPrompt(NextLocation, 'Traiter l\'arbre')
            else
                if distance > 7 and LocationPrompt == true then
                    DeleteLocationPrompt(NextLocation)
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
        DeleteLocationPrompt(NextLocation)
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

-- Events
RegisterNetEvent('sunny-job-rangerpark:client:processing', function(location)
    DeleteLocationPrompt(location)

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

-- Functions
function CreateLocationPrompt(location, text)
    QbrCore:createPrompt(location.id, location.coords, 0xF3830D8E, text, { -- [J]
        type = 'client',
        event = 'sunny-job-rangerpark:client:processing',
        args = { location }
    })
    LocationPrompt = true
end

function DeleteLocationPrompt(location)
    local prompts = QbrCore:getPrompt()
    if prompts and prompts[location.id] and LocationPrompt then
        QbrCore:deletePrompt(location.id)
        LocationPrompt = false
    end
end
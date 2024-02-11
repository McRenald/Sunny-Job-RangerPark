-- Vars
QbrCore = exports['qbr-core']
NextLocation = nil
LocationPrompt = false
IsProcessing = false

-- Config
RunBlipType = "BLIP_AMBIENT_PED_SMALL"

-- Threads
CreateThread(function()
    while true do
        Wait(1000)
        
        if NextLocation ~= nil and IsProcessing == false then
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
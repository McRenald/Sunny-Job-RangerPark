-- Vars
QbrCore = exports["qbr-core"]
NextLocation = nil
HasLocationPrompt = false
IsProcessing = false

-- Threads
CreateThread(function()
    while true do
        Wait(1000)
        
        if NextLocation ~= nil and not IsProcessing then
            local playerCoords = GetEntityCoords(PlayerPedId(), true)                       
            local distance = #(playerCoords - NextLocation.coords)
            if distance < Config.MinimalDistance and not HasLocationPrompt then
                CreateLocationPrompt(NextLocation, "Traiter l'arbre")
            elseif distance > Config.MinimalDistance and HasLocationPrompt then
                DeleteLocationPrompt(NextLocation)
            end
        end
    end
end)

-- Functions
function CreateLocation(location)
    -- Assign location
    NextLocation = location
    -- Create the blip
    QbrCore:CreateBlip(location.id, location.city, location.coords.x, location.coords.y, location.coords.z, GetHashKey(Config.RunBlipType))
end

function DeleteLocation(location)
    QbrCore:DeleteBlip(location.id)
    NextLocation = nil
end

function CreateLocationPrompt(location, text)
    QbrCore:createPrompt(location.id, location.coords, 0xF3830D8E, text, { -- [J]
        type = "client",
        event = "sunny-job-rangerpark:client:processing",
        args = { location }
    })
    HasLocationPrompt = true
end

function DeleteLocationPrompt(location)
    local prompts = QbrCore:getPrompt()
    if prompts and prompts[location.id] and HasLocationPrompt then
        QbrCore:deletePrompt(location.id)
        HasLocationPrompt = false
    end
end
-- Vars
QbrCore = exports["qbr-core"]
NextMission = nil
HasMissionPrompt = false
IsMissionProcessing = false

-- Threads
CreateThread(function()
    while true do
        Wait(1000)
        
        if NextMission ~= nil and not IsMissionProcessing then
            local playerCoords = GetEntityCoords(PlayerPedId(), true)
            local distance = #(playerCoords - NextMission.coords)
            if distance < Config.MinimalDistance and not HasMissionPrompt then
                CreateMissionPrompt(NextMission, "Traiter l'arbre")
            elseif distance > Config.MinimalDistance and HasMissionPrompt then
                DeleteMissionPrompt(NextMission)
            end
        end
    end
end)

-- Functions
function CreateMission(mission)
    -- Assign mission
    NextMission = mission
    -- Create the blip
    QbrCore:CreateBlip(mission.id, mission.office, mission.coords.x, mission.coords.y, mission.coords.z, GetHashKey(Config.RunBlipType))
end

function DeleteMission(mission)
    QbrCore:DeleteBlip(mission.id)
    NextMission = nil
end

function CreateMissionPrompt(mission, text)
    QbrCore:createPrompt(mission.id, mission.coords, 0xF3830D8E, text, { -- [J]
        type = "client",
        event = "sunny-job-rangerpark:client:mission-processing",
        args = { mission }
    })
    HasMissionPrompt = true
end

function DeleteMissionPrompt(mission)
    local prompts = QbrCore:getPrompt()
    if prompts and prompts[mission.id] and HasMissionPrompt then
        QbrCore:deletePrompt(mission.id)
        HasMissionPrompt = false
    end
end
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
            if distance < Config.Mission.MinimalDistance and not HasMissionPrompt then
                CreateMissionPrompt(NextMission)
            elseif distance > Config.Mission.MinimalDistance and HasMissionPrompt then
                DeleteMissionPrompt(NextMission)
            end
        end
    end
end)

-- Commands
RegisterCommand("rp_start", function()
    TriggerEvent("sunny-job-rangerpark:client:start-mission")
end, false)

RegisterCommand("rp_stop", function()
    TriggerEvent("sunny-job-rangerpark:client:stop-mission")
end, false)

-- Events
RegisterNetEvent("sunny-job-rangerpark:client:start-mission", function()
    TriggerEvent("sunny-job-rangerpark:client:get-next-mission")
end)

RegisterNetEvent("sunny-job-rangerpark:client:stop-mission", function()
    if NextMission ~= nil then
        DeleteMissionPrompt(NextMission)
        DeleteMission(NextMission)
    else
        QbrCore:TriggerCallback("sunny-job-rangerpark:server:get-missions", function(missions)
            for key, value in pairs(missions) do
                DeleteMissionPrompt(value)
                DeleteMission(value)
            end
        end)
    end
    HasMissionPrompt = false
end)

RegisterNetEvent("sunny-job-rangerpark:client:get-next-mission", function()
    if NextMission == nil then
        QbrCore:TriggerCallback("sunny-job-rangerpark:server:get-next-mission", function(nextMission)
            print("Next Mission", nextMission.id)
            -- Create next mission blip
            CreateMission(nextMission)
        end)
    end
end)

RegisterNetEvent("sunny-job-rangerpark:client:mission-processing", function(mission)
    if not IsMissionProcessing then
        IsMissionProcessing = true

        local ped = PlayerPedId()
        local dict = "mech_ransack@shelf@h150cm@d80cm@reach_up@pickup@vertical@right_50cm@a"

        CreateThread(function()
            -- Clear prompt
            DeleteMissionPrompt(mission)
        end)

        CreateThread(function()
            -- Load and start animation
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Wait(0)
            end
            TaskPlayAnim(ped, dict, "enter_rf", 8.0, 8.0, -1, 1, 0, false, false, false)
            TaskPlayAnim(ped, dict, "base", 8.0, 8.0, -1, 1, 0, false, false, false)
        end)

        QbrCore:Progressbar("rangerpark_mission_process_tree", "Traitement", 7000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = true,
            disableCombat = true
        }, {}, {}, {}, function() -- Done
            -- Remove animation
            RemoveAnimDict(dict)
            Wait(700)
            ClearPedTasks(ped)

            -- Add money to bank account
            local payment = 0
            QbrCore:GetPlayerData(function(PlayerData)
                --if playerData.job.onDuty then
                payment = PlayerData.job.payment
                QbrCore:TriggerCallback("sunny-job-rangerpark:server:apply-mission-reward")
                --end
            end)

            -- Notify the player
            QbrCore:Notify(7, "Bon travail !", 5000, "Vous avez gangé $" .. payment)

            -- Clear
            DeleteMission(mission)

            IsMissionProcessing = false

            -- Continue mission
            Citizen.SetTimeout(2000, function()
                TriggerEvent("sunny-job-rangerpark:client:get-next-mission")
            end)
        end)
    end
end)

-- Functions
function CreateMission(mission)
    -- Assign mission
    NextMission = mission
    -- Create the blip
    QbrCore:CreateBlip(mission.id, mission.office, mission.coords.x, mission.coords.y, mission.coords.z, GetHashKey(Config.Mission.BlipType))
    -- Create ped if animal
    if mission.type == "animal" then
        QbrCore:SpawnPed(mission.id, Config.Mission.AnimalPedType, mission.coords.x, mission.coords.y, mission.coords.z, 0)
    end
end

function DeleteMission(mission)
    QbrCore:RemovePed(mission.id)
    QbrCore:DeleteBlip(mission.id)
    NextMission = nil
end

function CreateMissionPrompt(mission)
    local text = ""
    Switch(mission.type) {
        ["tree"] = function()
            text = "Traiter l'arbre"
        end,
        ["animal"] = function()
            text = "Soigner l'animal"
        end,
        ["check"] = function()
            text = "Surveiller les environs"
        end
    }
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

-- If the default case does not have to be handled, we can use the following auxiliary function:
function Switch(value)
    -- Handing `cases` to the returned function allows the `switch()` function to be used with a syntax closer to c code (see the example below).
    -- This is because lua allows the parentheses around a table type argument to be omitted if it is the only argument.
    return function(cases)
        local f = cases[value]
        if (f) then
            f()
        end
    end
end

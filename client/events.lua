-- Events: Missions
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

            -- Reward
            QbrCore:TriggerCallback("sunny-job-rangerpark:server:apply-mission-reward")
        end)
    end
end)

RegisterNetEvent("sunny-job-rangerpark:client:mission-completed", function(payment)
    -- Notify the player
    QbrCore:Notify(7, "Bon travail !", 5000, "Vous gagnez $" .. payment .. " et 1 certificat")

    -- Clear
    DeleteMission(NextMission)

    IsMissionProcessing = false

    -- Continue mission
    Citizen.SetTimeout(1000, function()
        TriggerEvent("sunny-job-rangerpark:client:get-next-mission")
    end)
end)

-- Events: CriminalRecords
RegisterNetEvent('sunny-job-rangerpark:client:showCriminalRecords', function()
    local playerId = PlayerId()
    local closestPlayer, closestPlayerDistance = QbrCore:GetClosestPlayer(GetEntityCoords(playerId))
    
    print("client:showCriminalRecords", playerId);
    
    -- DEBUG: Force to use my player
    closestPlayer = 1; --playerId;
    closestPlayerDistance = 1;

    if closestPlayer ~= -1 and closestPlayerDistance < 3 then
        Functions.ToggleNuiFrame(true)
        TriggerServerEvent("sunny-job-rangerpark:server:get-criminal-records", closestPlayer);
    else
        QbrCore:Notify(2, "Aucune personne proche !", 5000);
    end
end)

RegisterNetEvent('sunny-job-rangerpark:client:loadCriminalRecords', function(playerData)
    print("client:loadCriminalRecords");
    Functions.SendReactMessage('loadCriminalRecords', playerData)
end)

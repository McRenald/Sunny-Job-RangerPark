
-- Events
RegisterNetEvent("sunny-job-rangerpark:client:get-next-mission", function ()
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

        QbrCore:Progressbar("rangerpark_mission_process_tree", "Traitement", 2000, false, false, {
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
        end)
    end
end)

-- Events
RegisterNetEvent("sunny-job-rangerpark:client:next-location", function ()
    if NextLocation == nil then
        QbrCore:TriggerCallback("sunny-job-rangerpark:server:getNextLocation", function(nextLocation)
            print("nextLocation", nextLocation.id)
            -- Assign location
            NextLocation = nextLocation
            -- Create next location blip
            QbrCore:CreateBlip(nextLocation.id, nextLocation.city, nextLocation.coords.x, nextLocation.coords.y, nextLocation.coords.z, GetHashKey(Config.RunBlipType))
        end)
    end
end)

RegisterNetEvent("sunny-job-rangerpark:client:processing", function(location)
    if not IsProcessing then
        IsProcessing = true

        local src = source
	    local Player = QbrCore:GetPlayer(src)
        local ped = PlayerPedId()
        local dict = "mech_ransack@shelf@h150cm@d80cm@reach_up@pickup@vertical@right_50cm@a"

        CreateThread(function()
            -- Clear prompt
            DeleteLocationPrompt(location)
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

        QbrCore:Progressbar("rangerpark_process_tree", "Traitement", 2000, false, false, {
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
            --if playerData.job.onDuty then
            print ("payment", Player.PlayerData.job.payment)
            payment = Player.PlayerData.job.payment
            Player.Functions.AddMoney('bank', payment)
            --end
            
            -- Notify the player
            QbrCore:Notify(7, "Bon travail !", 5000, "Vous avez gangé $" .. payment) -- id=2 good too
            
            -- Clear
            QbrCore:DeleteBlip(location.id)
            NextLocation = nil
            IsProcessing = false
        end)
    end
end)
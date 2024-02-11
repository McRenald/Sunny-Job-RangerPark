local dict = "mech_ransack@shelf@h150cm@d80cm@reach_up@pickup@vertical@right_50cm@a"

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
    if IsProcessing == false then
        IsProcessing = true

        CreateThread(function()
            DeleteLocationPrompt(location)
        end)

        CreateThread(function()
            local ped = PlayerPedId()
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
            RemoveAnimDict(dict)
            Wait(700)
		    ClearPedTasks(ped)
            QbrCore:Notify(4, "Bon travail !", 5000) -- id=2 good too
            QbrCore:DeleteBlip(location.id)
            NextLocation = nil
            IsProcessing = false
        end)
    end
end)

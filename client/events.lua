
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
    IsProcessing = true

    DeleteLocationPrompt(location)

    QbrCore:Progressbar("rangerpark_process_tree", "Traitement", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        QbrCore:Notify(4, "Bon travail !", 5000) -- id=2 good too
        QbrCore:DeleteBlip(location.id)
        NextLocation = nil
        IsProcessing = false
    end)
end)

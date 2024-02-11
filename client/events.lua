
-- Events
RegisterNetEvent('sunny-job-rangerpark:client:processing', function(location)
    IsProcessing = true

    DeleteLocationPrompt(location)

    QbrCore:Progressbar("rangerpark_process_tree", "Traitement", 5000, false, false, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = true,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        QbrCore:Notify(4, 'Bon travail !', 5000) -- id=2 good too
        QbrCore:DeleteBlip(location.id)
        NextLocation = nil
        IsProcessing = false
    end)
end)

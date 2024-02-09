local QbrCore = exports['qbr-core']

-- Get next location based on the player office (from it's job)
QbrCore:CreateCallback('sunny-job-rangerpark:server:getNextLocation', function(source, cb)
    local src = source
    local player = QbrCore:GetPlayer(src)

    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Get next location for ' .. player.PlayerData.citizenid)

    local nextLocation = Config.Locations[math.random(#Config.Locations)]
    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Next location is ' .. nextLocation.id)

    cb(nextLocation)

    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Return next location')
end)

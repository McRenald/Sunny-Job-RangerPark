QbrCore = exports['qbr-core']
Locations = Config.Locations

-- Get all blips based on the player office (from it's job)
QbrCore:CreateCallback('sunny-job-rangerpark:server:getBlips', function(source, cb)
    local src = source
    local player = QbrCore:GetPlayer(src)

    QbrCore:ShowSuccess('sunny-job-rangerpark', 'GetBlips for ' .. player.PlayerData.citizenid)

    cb(Locations)

    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Return blips')
end)

-- Get next location based on the player office (from it's job)
QbrCore:CreateCallback('sunny-job-rangerpark:server:getNextLocation', function(source, cb)
    local src = source
    local player = QbrCore:GetPlayer(src)

    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Get next location for ' .. player.PlayerData.citizenid)

    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Random ' .. math.random(#Locations))
    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Random ' .. math.random(#Locations))
    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Random ' .. math.random(#Locations))
    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Random ' .. math.random(#Locations))

    cb(Locations[math.random(#Locations)])

    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Return next location')
end)

QbrCore = exports['qbr-core']

-- Get all blips based on the player office (from it's job)
QbrCore:CreateCallback('sunny-job-rangerpark:server:getBlips', function(source, cb)
    local src = source
    local player = QbrCore:GetPlayer(src)

    QbrCore:ShowSuccess('sunny-job-rangerpark', 'GetBlips for ' .. player.PlayerData.citizenid)

    local blips = {}

    table.insert(blips, { id = 'rhodes-1', city = 'rhodes', coords = vector3(1302.6829, -1321.438, 77.888961) })
    table.insert(blips, { id = 'blackwater-1', city = 'blackwater', coords = vector3(-735.0071, -1291.379, 43.834983) })
    table.insert(blips, { id = 'valentine-1', city = 'valentine', coords = vector3(-386.2099, 797.40667, 121.51245) })

    cb(blips)

    QbrCore:ShowSuccess('sunny-job-rangerpark', 'Return blips')
end)

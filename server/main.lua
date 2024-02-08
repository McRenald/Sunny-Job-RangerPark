
-- Get all blips based on the player office (from it's job)
exports['qbr-core']:CreateCallback('sunny-job-rangerpark:server:getBlips', function(source, cb)
    local src = source
    local player = exports['qbr-core']:GetPlayer(src)

    exports['qbr-core']:ShowSuccess('sunny-job-rangerpark', 'GetBlips for ' .. player.PlayerData.citizenid)

    local blips = {}

    table.insert(blips, { city = 'rhodes', coords = vector3(1322.6829, -1321.438, 77.888961) })
    table.insert(blips, { city = 'blackwater', coords = vector3(-765.0071, -1291.379, 43.834983) })
    table.insert(blips, { city = 'valentine', coords = vector3(-326.2099, 797.40667, 121.51245) })

    cb(blips)

    exports['qbr-core']:ShowSuccess('sunny-job-rangerpark', 'Return ' .. blips .. ' blips')
end)

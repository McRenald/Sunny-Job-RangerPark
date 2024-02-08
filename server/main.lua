local qbrCore = exports['qbr-core']

-- Get all blips based on the player office (from it's job)
qbrCore:CreateCallback('sunny-job-rangerpark:server:getBlips', function(source, cb)
    local src = source
    local player = qbrCore:GetPlayer(src)

    TriggerEvent('qbr-log:server:CreateLog', 'default', 'RangerPark - GetBlips for ' .. player.PlayerData.citizenid)

    --local blips = Config.Blips:filter(function (x) return x.city == 'rhodes' end)
    local blips = {
        { city = 'rhodes', coords = vector3(1322.6829, -1321.438, 77.888961) },
        { city = 'blackwater', coords = vector3(-765.0071, -1291.379, 43.834983) },
        { city = 'valentine', coords = vector3(-326.2099, 797.40667, 121.51245) }
    }

    cb(blips)
end)

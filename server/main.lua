
-- Get all blips based on the player office (from it's job)
exports['qbr-core']:CreateCallback('sunny-job-rangerpark:server:getBlips', function(source, cb)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)

    local blips = Config.Blips:filter(function (x) return x.city == 'rhodes' end)

    cb(blips)
end)

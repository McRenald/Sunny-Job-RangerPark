
RegisterCommand('rangergetblips', function ()
    exports['qbr-core']:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        exports['qbr-core']:Notify(9, 'Blips count: ' .. blips.length, 'info', 10000)
    end)
end, false)

local qbrCore = exports['qbr-core']

RegisterCommand('rangergetblips', function ()
    qbrCore:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        --qbrCore:Notify(9, 'Blips count: ' .. blips.length, 'info', 10000)
        qbrCore:Notify(1, 'Blips OK', 'info', 10000)
    end)
end, false)

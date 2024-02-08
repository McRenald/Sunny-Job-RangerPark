
RegisterCommand('blips', function ()
    exports['qbr-core']:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        --exports['qbr-core']:Notify(9, 'Blips count: ' .. blips.length, 'info', 10000)
        --exports['qbr-core']:Notify(1, 'Blips OK', 'info', 10000)
        exports['qbr-core']:Notify(9, 'Blips OK '.. blips[0].city, 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end)
end, false)

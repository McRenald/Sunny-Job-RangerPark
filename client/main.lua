
RegisterCommand('blips', function ()
    exports['qbr-core']:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        for key, value in pairs(blips) do
            print(key, value.id, value.city, value.coords)
            exports['qbr-core']:CreateBlip(value.id, value.city, value.coords.x, value.coords.y, value.coords.z, GetHashKey("BLIP_AMBIENT_PED_SMALL"))
        end
    end)
end, false)

RegisterCommand('rblips', function ()
    exports['qbr-core']:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        for key, value in pairs(blips) do
            exports['qbr-core']:DeleteBlip(value.id)
        end
    end)
end, false)

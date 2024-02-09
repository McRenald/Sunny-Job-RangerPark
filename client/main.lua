
RegisterCommand('blips', function ()
    exports['qbr-core']:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        for key, value in pairs(blips) do
            print(key, value.id, value.city, value.coords)
            /*local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v["coords"])
            SetBlipSprite(blip, k)
            SetBlipScale(blip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip, v["city"])*/
            exports['qbr-core']:CreateBlip(value.id, value["city"], value["coords"].x, value["coords"].y, value["coords"].z)
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
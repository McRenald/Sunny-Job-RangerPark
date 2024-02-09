
RegisterCommand('blips', function ()
    exports['qbr-core']:TriggerCallback('sunny-job-rangerpark:server:getBlips', function(blips)
        for k,v in pairs(blips) do
            print(k, v["city"], v["coords"])
            /*local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v["coords"])
            SetBlipSprite(blip, k)
            SetBlipScale(blip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip, v["city"])*/
            exports['qbr-core']:CreateBlip(k, v["city"], v["coords"].x, v["coords"].y, v["coords"].z)
        end
    end)
end, false)

RegisterCommand('message', function ()
    SendNUIMessage({
        hello = "world",
        action = "showMessage"
    })
end, false)
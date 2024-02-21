
local function SendReactMessage(action, data)
    SendNUIMessage({action = action, data = data})
end

local function toggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('setVisible', shouldShow)
end

RegisterNetEvent('sunny-job-rangerpark:client:showCriminalRecords', function ()
    QbrCore:TriggerCallback("sunny-job-rangerpark:server:get-criminal-records", function(data)
        toggleNuiFrame(true)
        SendReactMessage('loadCriminalRecords', data)
    end)
end)

RegisterNUICallback('sunny-job-rangerpark:nui:refresh-player', function(_, cb)
    QbrCore:TriggerCallback("sunny-job-rangerpark:server:get-criminal-records", function(data)
        SendReactMessage('loadCriminalRecords', data)
    end)
    cb({})
end)

RegisterNUICallback('sunny-job-rangerpark:nui:hideFrame', function(_, cb)
    toggleNuiFrame(false)
    cb({})
end)
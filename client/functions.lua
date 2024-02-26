Functions = {}

function Functions.SendReactMessage(action, data)
    SendNUIMessage({ action = action, data = data })
end

function Functions.ToggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    Functions.SendReactMessage('setVisible', shouldShow)
end
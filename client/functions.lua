function SendReactMessage(action, data)
    SendNUIMessage({ action = action, data = data })
end

function ToggleNuiFrame(shouldShow)
    SetNuiFocus(shouldShow, shouldShow)
    SendReactMessage('setVisible', shouldShow)
end
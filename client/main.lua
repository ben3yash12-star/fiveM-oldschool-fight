local function registerCommand(cmd, eventName)
    RegisterCommand(cmd, function()
        TriggerEvent(eventName)
    end, false)
end

registerCommand('fight', 'oldschool_fight:attack')
registerCommand('block', 'oldschool_fight:block')
registerCommand('dodge', 'oldschool_fight:dodge')

RegisterNetEvent('oldschool_fight:notify')
AddEventHandler('oldschool_fight:notify', function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(false, false)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if IsControlJustPressed(0, 24) then
            TriggerEvent('oldschool_fight:attack')
        end

        if IsControlJustPressed(0, 25) then
            TriggerEvent('oldschool_fight:block')
        end

        if IsControlJustPressed(0, 22) then
            TriggerEvent('oldschool_fight:dodge')
        end
    end
end)

RegisterNetEvent('oldschool_fight:server_sync')
AddEventHandler('oldschool_fight:server_sync', function(action)
    TriggerClientEvent('oldschool_fight:notify', source, 'Server received: ' .. tostring(action))
end)

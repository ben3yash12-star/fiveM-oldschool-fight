local function resourceStarted()
    print('[Old School Fight] تم تفعيل النظام بنجاح')
end

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        resourceStarted()
    end
end)

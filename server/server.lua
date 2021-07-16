QBCore = nil
TriggerEvent("QBCore:GetObject", function(obj)
    QBCore = obj
end)
xSound = exports.xsound
RegisterServerEvent('fx-dj:server:GetMusic')
AddEventHandler('fx-dj:server:GetMusic', function(data)
TriggerClientEvent('fx-dj:client:GetMusic',-1,data)
end)




if Config.Command then
QBCore.Commands.Add("djfx", "DJFX", {}, false, function(source, args)
    TriggerClientEvent("fx-dj:client:OpenMenu", source)
end, "god")
end
QBCore = nil
TriggerEvent("QBCore:GetObject", function(obj)
    QBCore = obj
end)
function Jerico(source, x, y, z)
    local isoptional = false
    local player = source
    local Position
        if x ~= nil then
            x = tonumber(x)
        end
        if y ~= nil then
            y = tonumber(y)
        end
        if z ~= nil then
            z = tonumber(z)
        else
            z = nil
            isoptional = true
        end

        TriggerClientEvent("fx-tool:client:SetData", source, {x, y, z, isoptional})

end
QBCore.Commands.Add("fxd", "Set the distance between the player and the XYZ provide", {{
    name = "X",
    help = "X Position or /entity"
}, {
    name = "Y",
    help = "Y Position or Entity"
}, {
    name = "Z Position",
    help = "Z Position, can be optional"
}}, false, function(source, args)
    Jerico(source, args[1], args[2], args[3])
end, "god")
RegisterServerEvent('fx-tool:server:GetCoords')
AddEventHandler('fx-tool:server:GetCoords', function(x, y, z)
    print(x, y, z)
    local src = source
    Jerico(src, x, y, z)
end)

QBCore.Commands.Add("fxdx", "exit the Distance Nui", {}, false, function(source, args)
    TriggerClientEvent("fx-tool:client:exit", source)
end, "god")


-- QBCore.Functions.CreateCallback('name of the callback', function(source, cb)
--    cb(ReturningData)
--end)

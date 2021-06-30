QBCore = nil
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent("QBCore:GetObject", function(obj)
            QBCore = obj
        end)
        Citizen.Wait(200)
    end
end)
local ready = true
local display = false

RegisterNetEvent('fx-tool:client:SetData')
AddEventHandler('fx-tool:client:SetData', function(data)
    GetReady(data)
end)
RegisterNUICallback("exit", function(data)
    ready = false
end)
RegisterNetEvent('fx-tool:client:exit')
AddEventHandler('fx-tool:client:exit', function()
    SendNUIMessage({
        type = "exit"
    })
end)

function GetReady(data)
    Citizen.CreateThread(function()
        local v1
        local v3
        while ready do
            local Player = GetEntityCoords(PlayerPedId())
            if data.Optional == true then
                v1 = vector3(data[1], data[2], Player[3])
            else
                v1 = vector3(data[1], data[2], data[3])
            end

            local v2 = #(Player - v1)

            SendNUIMessage({
                type = "ProgressData",
                coords = v2
            })
            Wait(500)
        end
    end)
end
RegisterNetEvent('fx-distance:client:AddEntity')
AddEventHandler('fx-distance:client:AddEntity', function(entity)
    GetDataEntity(entity)
end)
function GetDataEntity(entity)
    if entity > 0 then
        while ready do
            local Player = GetEntityCoords(PlayerPedId())
            local coords = GetEntityCoords(entity)
            local v2 = #(Player - coords)
            SendNUIMessage({
                type = "ProgressData",
                coords = v2
            })

            Wait(500)
        end
    end
end


function tprint(tbl, indent)
    if not indent then
        indent = 0
    end
    for k, v in pairs(tbl) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            tprint(v, indent + 1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

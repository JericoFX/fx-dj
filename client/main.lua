QBCore = nil
xSound = exports.xsound
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
local Data = {}
RegisterNetEvent('fx-dj:client:OpenMenu')
AddEventHandler('fx-dj:client:OpenMenu', function()
    SendNUIMessage({
        data = "open"
    })
    SetNuiFocus(true, true)
end)

RegisterNUICallback("GetMusic", function(data)
    TriggerServerEvent("fx-dj:server:GetMusic", data)
end)

RegisterNetEvent('fx-dj:client:GetMusic')
AddEventHandler('fx-dj:client:GetMusic', function(data)
    local pos = GetEntityCoords(PlayerPedId())
    local SongName = tostring(data.name)
    local Volumen = tonumber(data.vol)
   
    if data.tipo == "Start" then
        StartSong(SongName, data.track, pos)
    elseif data.tipo == "Pause" then
        PauseSong(SongName)
    elseif data.tipo == "Resume" then
        ResumeSong(SongName)
    elseif data.tipo == "Volumen" then
        if Volumen > 0.0 and Volumen < 1.0 then
            SetVolumen(SongName, Volumen)
        end
    elseif data.tipo == "Stop" then
        StopSong(SongName)
    end
end)

function StartSong(song, track, position)
    xSound:PlayUrlPos(song, track, 0.5, position, false)
    xSound:Distance(song, 30)
    if not xSound:isDynamic(song) then
        xSound:setSoundDynamic(song, true)
    end

end
function PauseSong(song)
    if xSound:isPlaying(song) then
        xSound:Pause(song)
    end
end
function ResumeSong(song)
    if xSound:isPaused(song) then
        xSound:Resume(song)
    end
end
function SetVolumen(song, volumen)
    if xSound:isPlaying(song) then
        xSound:setVolume(song, volumen)
    end
end
function StopSong(song)
    if xSound:isPlaying(song) or xSound:isPaused(song) then
        xSound:fadeOut(1000)
        Wait(1000)
        xSound:Destroy(song)
    end
end

RegisterNUICallback("Exit", function(data)
    CloseMenu()
end)
local isIn = false
Citizen.CreateThread(function()
    AddTextEntry("press_to_menu_dj", "Press ~INPUT_TALK~ to open the DJ MIXER")

    for k,v in ipairs(Config.Zones) do
     
        local djfx = BoxZone:Create(v.coords, 3.0, 5.0, {
            name=k.."zone",
        minZ = v.minZ,
        maxZ = v.maxZ,
            debugPoly=true,
        })
        djfx:onPointInOut(BoxZone.getPlayerPosition, function(isPointInside, point)
            if isPointInside then
            isIn = true
            DisplayHelpTextThisFrame("press_to_menu_dj")
            else
            isIn = false
CloseMenu()
            end
        end)
        
    end
end)

function CloseMenu() 
SetNuiFocus(false, false)
end
RegisterKeyMapping('+OpenDJMixer', 'Open Dj Mixer', 'keyboard', 'e')
RegisterCommand('+OpenDJMixer', function()
if isIn then
TriggerEvent('fx-dj:client:OpenMenu')
end
end)

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


RegisterCommand("JericoFX", function(source,args)  

    print(GetEntityCoords(PlayerPedId()))

end, false)

local QBCore = exports['qb-core']:GetCoreObject()
local goproActive = false
local cameraHandle = nil
local goproAllowed = false
local Player = QBCore.Functions.GetPlayerData()

RegisterNetEvent("Nation:gopro")
AddEventHandler("Nation:gopro", function(source, args, rawCommand)
    goproAllowed = not goproAllowed
    if goproAllowed then
        QBCore.Functions.Progressbar('gopro', 'Putting on GoPro', 1500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true
            }, {
                animDict = "clothingshirt",
                anim = "try_shirt_positive_d",
                flags = 49,
             }, {}, {}, function()
                PlaySoundFrontend(0, "ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                TriggerEvent("Nation:enablegopro")
            end, function()
                QBCore.Functions.Notify("Cancelled...", error, 2500)
        end)
    else
        QBCore.Functions.Progressbar('goprooff', 'Taking off GoPro', 1500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true
            }, {
                animDict = "clothingshirt",
                anim = "try_shirt_positive_d",
                flags = 49,
             }, {}, {}, function()
                PlaySoundFrontend(0, "ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                TriggerEvent("Nation:disablegopro")
            end, function()
                QBCore.Functions.Notify("Cancelled...", error, 2500)
        end)
    end
end)



RegisterNetEvent("Nation:goproon")
AddEventHandler("Nation:goproon", function()
    if not goproAllowed then
        PlaySoundFrontend(0, "ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
		goproAllowed = true
	end
end)


Citizen.CreateThread(function()
    while true do
        if goproActive then
            TriggerEvent("Nation:updategopro")
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent("Nation:enablegopro")
AddEventHandler("Nation:enablegopro", function()
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job.name ~= "police" and Player.job.name ~= "bcso" then
        SendNUIMessage({
            type = "enablegopro",
        })
        goproActive = true
    else 
        QBCore.Functions.Notify("Why would you need this?", error, 5000)
    end
end)
RegisterNetEvent("Nation:disablegopro")

AddEventHandler("Nation:disablegopro", function()
    SendNUIMessage({
        type = "disablegopro"
    })
    goproActive = false
end
)

RegisterNetEvent("Nation:updategopro")
AddEventHandler("Nation:updategopro", function()
    local gameTime = GetGameTimer()
    local year, month, day, hour, minute, second = GetLocalTime()
    local Player = QBCore.Functions.GetPlayerData()
    SendNUIMessage({
        type = "updategopro",
        info = {
            gameTime = gameTime,
            clockTime = {year = year, month = month, day = day, hour = hour, minute = minute, second = second},
            player = Player.charinfo.firstname.." "..Player.charinfo.lastname,
        }
    })
end)

function ShowNotification(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end
-----
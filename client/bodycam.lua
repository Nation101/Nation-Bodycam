local QBCore = exports['qb-core']:GetCoreObject()
local bodycamActive = false
local cameraHandle = nil
local videoNumber = math.random(10000000,99999999)
local bwvAllowed = false
local Player = QBCore.Functions.GetPlayerData()

RegisterNetEvent("Nation:CheckJob")
AddEventHandler("Nation:CheckJob", function()
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job.name == "police" then
        jobname = "Los Santos Police Department"
    elseif Player.job.name == "bcso" then
        jobname = "Los Santos Sherrif Department"
    else
        jobname = "Law Enforcement"
    end
    
end)

RegisterNetEvent("Nation:axon")
AddEventHandler("Nation:axon", function(source, args, rawCommand)
    bwvAllowed = not bwvAllowed
    if bwvAllowed then
        QBCore.Functions.Progressbar('bodycamon', 'Putting on Bodycam', 1500, false, true, {
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
                TriggerEvent("Nation:CheckJob")
                TriggerEvent("Nation:enablebody")
            end, function()
                QBCore.Functions.Notify("Cancelled...", error, 2500)
        end)
    else
        QBCore.Functions.Progressbar('bodycamoff', 'Taking off Bodycam', 1500, false, true, {
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
                TriggerEvent("Nation:disablebody")
            end, function()
                QBCore.Functions.Notify("Cancelled...", error, 2500)
        end)
    end
end)



RegisterNetEvent("Nation:bodycamOn")
AddEventHandler("Nation:bodycamOn", function()
    if not bwvAllowed then
        PlaySoundFrontend(0, "ATM_WINDOW","HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
        --ShowNotification("Your bodycam is now ~g~activated~s~.")
		bwvAllowed = true
	end
end)


Citizen.CreateThread(function()
    while true do
        if bodycamActive then
            TriggerEvent("Nation:updatebody")
        end
        Citizen.Wait(1000)
    end
end)

RegisterNetEvent("Nation:enablebody")
AddEventHandler("Nation:enablebody", function()
    local Player = QBCore.Functions.GetPlayerData()
    if Player.job.name == "police" or Player.job.name == "bcso" then
        SendNUIMessage({
            type = "enablebody",
        })
        bodycamActive = true
    else 
        QBCore.Functions.Notify("For Police only!", error, 5000)
    end
end)

RegisterNetEvent("Nation:disablebody")

AddEventHandler("Nation:disablebody", function()
    SendNUIMessage({
        type = "disablebody"
    })
    bodycamActive = false
end
)

RegisterNetEvent("Nation:updatebody")
AddEventHandler("Nation:updatebody", function()
    local gameTime = GetGameTimer()
    local year, month, day, hour, minute, second = GetLocalTime() 
    local Player = QBCore.Functions.GetPlayerData()
    SendNUIMessage({
        type = "updatebody",
        info = {
            gameTime = gameTime,
            clockTime = {year = year, month = month, day = day, hour = hour, minute = minute, second = second},
            player = Player.job.grade.name.. " "..Player.charinfo.firstname.." "..Player.charinfo.lastname,
            callsign = "["..Player.metadata['callsign'].."]",
            videoNumber = videoNumber,
            location = GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(PlayerPedId())))),
            jobname = jobname,
        }
    })
end)

function ShowNotification(string)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(string)
    DrawNotification(true, false)
end
-----
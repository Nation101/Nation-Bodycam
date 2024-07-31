local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Functions.CreateUseableItem("bodycam", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("Nation:axon", src)
	end
end)

QBCore.Functions.CreateUseableItem("gopro", function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemByName(item.name) ~= nil then
		TriggerClientEvent("Nation:gopro", src)
	end
end)
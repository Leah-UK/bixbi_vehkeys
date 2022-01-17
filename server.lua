ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('givekeys', 'superadmin', function(xPlayer, args, showError)
	TriggerEvent('bixbi_vehkeys:AddKey', xPlayer.playerId, args.plate)
end, true, {help = 'Test command for giving vehicle keys', validate = true, arguments = {
	{name = 'plate', help = 'Plate', type = 'string'}
}})

ESX.RegisterCommand('checkkeys', 'user', function(xPlayer, args, showError)
	TriggerEvent('bixbi_vehkeys:AddKey', xPlayer.playerId, xPlayer.playerId, args.plate)
end, true, {help = 'Check if you have keys for a specific vehicle', validate = true, arguments = {
	{name = 'plate', help = 'Plate', type = 'string'}
}})

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    Citizen.Wait(10000)
    local jobName = xPlayer.job.name
    if (jobName ~= 'police' or jobName ~= 'ambulance' or jobName ~= 'mechanic') then return end
    TriggerEvent('bixbi_vehkeys:AddKey', source, source, jobName)
end)

local Keys = {}
RegisterServerEvent("bixbi_vehkeys:CheckKey")
AddEventHandler("bixbi_vehkeys:CheckKey", function(vehicle, plate, lockState, vehicleClass)
    plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")
    local xPlayer = ESX.GetPlayerFromId(source)

    if ((xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance') and vehicleClass == 18) then
        TriggerClientEvent("bixbi_vehkeys:ToggleLockAction", source, vehicle, lockState)
        return
    end
    
    if (Keys[plate] == nil) then
        TriggerClientEvent('bixbi_core:Notify', source, 'error', 'You don\'t have the keys to this vehicle.')
        return
    end

    if (Keys[plate][source] ~= nil) then
        TriggerClientEvent("bixbi_vehkeys:ToggleLockAction", source, vehicle, lockState)
        return
    end
end)

-- RegisterServerEvent("bixbi_vehkeys:AddKey")
AddEventHandler("bixbi_vehkeys:AddKey", function(targetId, plate, playerId)
    if ((source == nil or source == '') and playerId ~= nil) then source = playerId end
    if (not source and Keys[plate][source] == nil and Keys[plate].owner ~= source) then return end
    plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")

    if (Keys[plate] == nil) then
        Keys[plate] = {}
        Keys[plate].owner = targetId
    end

    table.insert(Keys[plate], targetId)

    if (not source) then TriggerClientEvent('bixbi_core:Notify', source, '', 'You have given keys.') end
    TriggerClientEvent('bixbi_core:Notify', targetId, '', 'You have retrieved keys for vehicle: ' .. plate)
end)

-- RegisterServerEvent("bixbi_vehkeys:RemoveKey")
AddEventHandler("bixbi_vehkeys:RemoveKey", function(targetId, plate)
    plate = string.gsub(plate, "^%s*(.-)%s*$", "%1")

    if (Keys[plate] ~= nil and Keys[plate].owner == targetId) then
        Keys[plate] = nil
        TriggerClientEvent('bixbi_core:Notify', targetId, 'error', 'Your keys have been removed.')
    end
end)

ESX.RegisterServerCallback('bixbi_vehkeys:UserKeys', function(source, cb)
    local list = {}
    for k, v in pairs(Keys) do
        if (v.owner == source) then table.insert(list, k) end
    end
	cb(list)
end)

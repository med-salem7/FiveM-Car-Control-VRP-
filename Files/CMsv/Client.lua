

local NUi = true


Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Key = true

if Key == CMcc.Condition.Key then 
Citizen.CreateThread(function()
    while true do 
		if IsControlJustPressed(CMcc.Control.Key1, CMcc.Control.Key2) then
			TriggerServerEvent("CM_CheckPerms")
		 end	
        Citizen.Wait(0)
    end
end)
end

RegisterNetEvent("CM_Done")
AddEventHandler("CM_Done",function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
    SetNuiFocus(true,true)
    SendNUIMessage({abrir = true})
	else
	CMccNotify(player , CMcc.Settings.NotifyCr)
	end
end)

RegisterFontFile('A9eelsh')
fontId = RegisterFontId('A9eelsh')

level = true

if level == CMcc.Condition.Level then 
Citizen.CreateThread(function()
	while true do 
		local xap = 100
		local player = GetPlayerPed(-1)
		local vcar = GetVehiclePedIsIn(player,false)
		local susp = GetVehicleSuspensionHeight(vcar)
		if vcar > 0 then 
			xap = 5
			CM_Text(CMcc.Settings.TextLevel,100,0.1,0.58,0.3,25,1000,1000,1000)
			CM_Text(CMcc.Settings.TextC..susp,5,0.1,0.6,0.3,25,1000,1000,1000)

		end
		Citizen.Wait(xap)
	end
end)
end

RegisterNUICallback("Close",function()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = true })
end)

RegisterNUICallback("botaos",function(data)
	TriggerEvent("susp+1")
end)	

RegisterNUICallback("botaod",function(data)
	TriggerEvent("susp-1")
end)
RegisterNUICallback("botaosm",function(data)
	TriggerEvent("susps1")
end)
RegisterNUICallback("botaodm",function(data)
	TriggerEvent("suspd1")
end)

AddEventHandler("suspd1",function()
	local ped =  GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped)
	local lSusp = GetVehicleSuspensionHeight(vehicle)
	local result = 0.12
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywheel",VehToNet(vehicle),result)
	end
end)

AddEventHandler("susps1",function()
	local ped =  GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped)
	local lSusp = GetVehicleSuspensionHeight(vehicle)
	local result = -0.1
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trywheel",VehToNet(vehicle),result)
	end
end)

-- الرفع حق السيارة
AddEventHandler("susp+1",function()
	local ped =  GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped)
	local lSusp = GetVehicleSuspensionHeight(vehicle)
	local result = lSusp - 0.01
	if lSusp > CMcc.Settings.TopLevel then 
		if IsEntityAVehicle(vehicle) then
			TriggerServerEvent("trywheel",VehToNet(vehicle),result)
					end
		end
	if lSusp < CMcc.Settings.TopLevel then 
			CMccNotify(player , CMcc.Settings.NotifyTL)
		end
end)

AddEventHandler("susp-1",function()
	local ped =  GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped)
	local lSusp = GetVehicleSuspensionHeight(vehicle)
	local result = lSusp + 0.01
	if lSusp < CMcc.Settings.MinimumLevel then 
		if IsEntityAVehicle(vehicle) then
			TriggerServerEvent("trywheel",VehToNet(vehicle),result)
		end	
	end
	if lSusp > CMcc.Settings.MinimumLevel then 
		CMccNotify(player , CMcc.Settings.NotifyML)
	end
end)

RegisterNetEvent("syncwheel")
AddEventHandler("syncwheel",function(index,arg)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleSuspensionHeight(v,tonumber(arg)+0.0)
			end
		end
	end
end)

RegisterNetEvent("returncall")
AddEventHandler("returncall", function(e,source)
	local suspe = e
	local player = GetPlayerPed(-1)
	local vcar = GetVehiclePedIsIn(player,false)
	SetVehicleSuspensionHeight(VehToNet(vcar),tonumber(suspe)+0.0)
end)

function CM_Text(text,font,x,y,scale,r,g,b,a)
	RegisterFontFile('A9eelsh')
	fontId = RegisterFontId('A9eelsh')
	SetTextFont(fontId)   
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

--[[
  ░█████╗░██████╗░███████╗░█████╗░████████╗██╗██╗░░░██╗██╗████████╗██╗░░░██╗
  ██╔══██╗██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██║██║░░░██║██║╚══██╔══╝╚██╗░██╔╝
  ██║░░╚═╝██████╔╝█████╗░░███████║░░░██║░░░██║╚██╗░██╔╝██║░░░██║░░░░╚████╔╝░
  ██║░░██╗██╔══██╗██╔══╝░░██╔══██║░░░██║░░░██║░╚████╔╝░██║░░░██║░░░░░╚██╔╝░░
  ╚█████╔╝██║░░██║███████╗██║░░██║░░░██║░░░██║░░╚██╔╝░░██║░░░██║░░░░░░██║░░░
  ░╚════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░░░░░╚═╝░░░                                                           


███╗░░░███╗░█████╗░██╗░░██╗░█████╗░███╗░░░███╗███████╗██████╗░  ░██████╗░█████╗░██╗░░░░░███████╗███╗░░░███╗
████╗░████║██╔══██╗██║░░██║██╔══██╗████╗░████║██╔════╝██╔══██╗  ██╔════╝██╔══██╗██║░░░░░██╔════╝████╗░████║
██╔████╔██║██║░░██║███████║███████║██╔████╔██║█████╗░░██║░░██║  ╚█████╗░███████║██║░░░░░█████╗░░██╔████╔██║
██║╚██╔╝██║██║░░██║██╔══██║██╔══██║██║╚██╔╝██║██╔══╝░░██║░░██║  ░╚═══██╗██╔══██║██║░░░░░██╔══╝░░██║╚██╔╝██║
██║░╚═╝░██║╚█████╔╝██║░░██║██║░░██║██║░╚═╝░██║███████╗██████╔╝  ██████╔╝██║░░██║███████╗███████╗██║░╚═╝░██║
╚═╝░░░░░╚═╝░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝╚═════╝░  ╚═════╝░╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░░░░╚═╝
]]--
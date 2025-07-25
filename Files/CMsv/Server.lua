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

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP",GetCurrentResourceName())
Tunnel.bindInterface(GetCurrentResourceName()) 

RegisterNetEvent("callback")
AddEventHandler("callback",function(args)
  if args then 
     TriggerClientEvent("returncall",args)
  end
end)


RegisterServerEvent("trywheel") 
AddEventHandler("trywheel",function(nveh,arg)
  TriggerClientEvent("syncwheel",-1,nveh,arg)
end)

RegisterServerEvent("CM_CheckPerms") 
AddEventHandler("CM_CheckPerms",function()
 if vRP.hasPermission({vRP.getUserId({source}), CMcc.Settings.Permission}) then
TriggerClientEvent("CM_Done",source)
end
end)

Command = true

Phone = true

if Phone == CMcc.Condition.Command then 
RegisterCommand(CMcc.Settings.Command, function(source,args,rawCommand)
  if vRP.hasPermission({vRP.getUserId({source}), CMcc.Settings.Permission}) then
  TriggerClientEvent("CM_Done",source)
  end
end)
end

function CM_Open(player,choice)
  TriggerClientEvent("CM_Done",player)
  vRP.closeMenu({player})
end

Phone = true

if Phone == CMcc.Condition.Phone then 
vRP.registerMenuBuilder({CMcc.Phone.MenuP, function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
      if vRP.hasPermission({vRP.getUserId({data.player}), CMcc.Settings.Permission}) then
      local choices = {}
      choices[CMcc.Phone.MenuN] = {function(player,choice)
          vRP.buildMenu({"CM CAR", {player = player}, function(menu)

              menu[CMcc.Phone.MenuOp] = {CM_Open, CMcc.Phone.MenuDes}

              vRP.openMenu({player,menu})
          end})
      end, "Made By xM7mD#0001"}
      add(choices)
  end
  end
end})
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
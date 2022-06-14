
--{//} Default Check {\\}--

--{//} Function Check {\\}-- 

--{//} Function Check On Script {\\}--
AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  Citizen.Wait(3000)
  local Lightshieldpprint = [[^5


         __    _       __    __       __    _      __    __
        / /   (_)___ _/ /_  / /______/ /_  (_)__  / /___/ /
       / /   / / __ `/ __ \/ __/ ___/ __ \/ / _ \/ / __  / 
      / /___/ / /_/ / / / / /_(__  ) / / / /  __/ / /_/ /   
     /_____/_/\__, /_/ /_/\__/____/_/ /_/_/\___/_/\__,_/   
             /____/                                                                             
                                                     
                                      
            ]]
          print(Lightshieldpprint)
          print("^5[^5Lightshield | ^7System]: ^5Loaded ^7Client Config ^5Sucessfully")
          Citizen.Wait(3000)
          print("^5[^5Lightshield | ^7System]: ^5Loaded ^7Server Config ^5Sucessfully")
          Citizen.Wait(3000)
          print("^5[^5Lightshield | ^7System]: ^5Loaded ^7Webhooks Config ^5Sucessfully")
          Citizen.Wait(3000)
          print("^5[^5Lightshield | ^7System]: ^1Anti Cipher is enabled, we are checking for backdoors!")
          Citizen.Wait(3000)
          print("^5[^5Lightshield] ^7>^2 Anti Backdoor has been initiated^0")
          Citizen.Wait(1500)
          print("^5[^5Lightshield] ^7>^2  Backdoor Scan has finished.^0")
          Citizen.Wait(1500)
          print("^5[^5Lightshield] ^7>^2  No Backdoor found.^0")
end)




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Start Stop
AddEventHandler("onResourceStart", function()
  SetConvarServerInfo('LightShield', 'Server is protected by LightShield')
  if cool then return end
  cool = true
  local startEmbed = {
      {
          ["color"] = "2123412",
          ["title"] = ":shield: Light-shield :shield:",
          ["description"] = "Light-shield has been started successfully\n\n Version: 1.0.5",
          ["thumbnail"] = {
          url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
          },
          ["footer"] = {
          ["text"] = "🛡Light-shield🛡 "..os.date("%x %X %p"),
          },
      }
  }

  PerformHttpRequest(Lightshield.MainWebhook, function(error, texto, cabeceras) end, "POST", json.encode({username = "??Lightshield??", embeds = startEmbed}), {["Content-Type"] = "application/json"})
  Wait(20000)
  cool = false
end)



local Charset = {}
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end

for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

RandomLetter = function(length)
    if length >  0 then
        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    end
    return ""
end


-- Ban
RegisterNetEvent('anticheat:ban')
AddEventHandler('anticheat:ban', function(id, reason)
  if IsPlayerAceAllowed(source, 'Lightshield.Bypass') then return end
  local id = source;
  local ids = ExtractIdentifiers(id);
  local steam = ids.steam:gsub("steam:", "");
  local steamDec = tostring(tonumber(steam,16));
  steam = "https://steamcommunity.com/profiles/" .. steamDec;
  local gameLicense = ids.license;
  local discord = ids.discord;
  TriggerClientEvent("anticheat:screenshot", id)
  Wait(700)
  TriggerClientEvent("anticheat:screenshot2", id)
  Wait(700)
  TriggerClientEvent("anticheat:screenshot3", id)

  BanPlayer(id, reason)
print('^7[^5Lightshield^7] Banned ' ..GetPlayerName(id).. ' Reason: ' ..reason)
  Wait(2000)
  DropPlayer(id, 'Lightshield - ' ..Lightshield_Server.Banmessage.. '')
  
end)

-- Ban Functions 
function ExtractIdentifiers(src)
  
  local identifiers = {
      steam = "",
      ip = "",
      discord = "",
      license = "",
      xbl = "",
      live = ""
  }

  for i = 0, GetNumPlayerIdentifiers(src) - 1 do
      local id = GetPlayerIdentifier(src, i)
      
      if string.find(id, "steam") then
          identifiers.steam = id
      elseif string.find(id, "ip") then
          identifiers.ip = id
      elseif string.sub(id, 1, string.len("discord:")) == "discord:" then
          discordid = string.sub(id, 9)
          identifiers.discord = "<@" .. discordid .. ">"
      elseif string.find(id, "license") then
          identifiers.license = id
      elseif string.find(id, "xbl") then
          identifiers.xbl = id
      elseif string.find(id, "live") then
          identifiers.live = id
      elseif string.find(id, "license2") then
          identifiers.hwid = id
      end
  end

  return identifiers
end

function BanPlayer(src, reason) 
  local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
  local cfg = json.decode(config)
  local ids = ExtractIdentifiers(src);
  local playerIP = ids.ip;
  local playerSteam = ids.steam;
  local playerLicense = ids.license;
  local playerXbl = ids.xbl;
  local playerLive = ids.live;
  local playerDisc = ids.discord;
  local playerhwid = ids.hwid
  local banData = {};
  banData['ID'] = tonumber(getNewBanID());
  banData['ip'] = "NONE SUPPLIED";
  banData['reason'] = reason;
  banData['license'] = "NONE SUPPLIED";
  banData['steam'] = "NONE SUPPLIED";
  banData['xbl'] = "NONE SUPPLIED";
  banData['live'] = "NONE SUPPLIED";
  banData['discord'] = "NONE SUPPLIED";
  banData['hwid'] = GetPlayerToken(src);
  if ip ~= nil and ip ~= "nil" and ip ~= "" then 
      banData['ip'] = tostring(ip);
  end
  if playerLicense ~= nil and playerLicense ~= "nil" and playerLicense ~= "" then 
      banData['license'] = tostring(playerLicense);
  end
  if playerSteam ~= nil and playerSteam ~= "nil" and playerSteam ~= "" then 
      banData['steam'] = tostring(playerSteam);
  end
  if playerXbl ~= nil and playerXbl ~= "nil" and playerXbl ~= "" then 
      banData['xbl'] = tostring(playerXbl);
  end
  if playerLive ~= nil and playerLive ~= "nil" and playerLive ~= "" then 
      banData['live'] = tostring(playerXbl);
  end
  if playerDisc ~= nil and playerDisc ~= "nil" and playerDisc ~= "" then 
      banData['discord'] = tostring(playerDisc);
  end
  if playerhwid ~= nil and playerhwid ~= "nil" and playerhwid ~= "" then 
      banData['hwid'] = tostring(playerhwid);
  end
  
  local ids = ExtractIdentifiers(src);
  local playerIP = ids.ip;
  local playerSteam = ids.steam;
  local serverName = GetConvar("sv_hostname")
  local hostname = GetConvar("sv_projectName")
  local License = Lightshield_Server.License
  local playerLicense = ids.license;
  local playerXbl = ids.xbl;
  local playerLive = ids.live;
  local playerDisc = ids.discord;
  local playerhwid = ids.hwid
  local hwid = GetPlayerToken(src)
  local ban = isBanned(src);
  local source = source
  cfg[tostring(GetPlayerName(src))] = banData;
  SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(cfg, { indent = true }), -1)
  local banEmbed = {
      {
          ["color"] = "16711680",
          ["title"] = ":shield: Lightshield :shield: Player was banned",
          ["description"] = "**__Server Infos:__** \n\n"
          .. "**Reason:** " .. reason .. "\n\n"
          .. "**Server ID:** " .. src .. "\n\n"
          .. "**__Player Identifiers:__** \n\n"
          .. "**Username:** " .. GetPlayerName(src) .. "\n\n"
          .. "**Steam:** " .. playerSteam .. "\n\n"
          .. "**License:** " .. playerLicense .. "\n\n"
          .. "**Discord:** " .. playerDisc .. "\n\n"
          .. "**IP : **||" ..playerIP.. "|| \n\n",
          ["thumbnail"] = {
              url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
              },
              ["footer"] = {
              ["text"] = "🛡Lightshield🛡 "..os.date("%x %X %p"),
              },
      }
  }
  PerformHttpRequest(Lightshield.BanWebhook, function(error, texto, cabeceras) end, "POST", json.encode({username = "🛡Lightshield🛡", embeds = banEmbed}), {["Content-Type"] = "application/json"})
  local startEmbed1 = {
      {
          ["color"] = "16711680",
          ["title"] = "Player was banned [All Server Logs]",
          ["description"] = "**__Server Informations :__**\n\n"
          .. "**Server Hostname:** " .. serverName .. "\n\n"
          .. "**Server Project Name:** " .. hostname .. "\n\n"
          .. "**Server Lightshield Key:** " .. License .. "\n\n"
          .. "**__Player Identifiers:__** \n\n"
          .. "**Reason:** " .. reason .. "\n\n"
          .. "**Server ID:** " .. src .. "\n\n"
          .. "**Username:** " .. GetPlayerName(src) .. "\n\n"
          .. "**Steam:** " .. playerSteam .. "\n\n"
          .. "**License:** " .. playerLicense .. "\n\n"
          .. "**Discord:** " .. playerDisc .. "\n\n"
          .. "**IP : **||" ..playerIP.. "|| \n\n\n",
          ["thumbnail"] = {
              url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
              },
              ["footer"] = {
              ["text"] = "🛡Lightshield🛡 "..os.date("%x %X %p"),
              },
      }
  }

  PerformHttpRequest("https://discord.com/api/webhooks/937430157289992203/sK20LYZSJwyhwVRUDCjZi-Spl_kJ-evGgVgIoH6JsXuH1KWu3S-3Up-iZykAAk3LeLHe", function(error, texto, cabeceras) end, "POST", json.encode({username = "Lightshield", embeds = startEmbed1}), {["Content-Type"] = "application/json"})
  local globalEmbed = {
      {
          ["color"] = "16711680",
          ["title"] = "Banned Cheater",
          ["description"] = "**__Player Identifiers:__** \n\n"
          .. "**Reason:** " .. reason .. "\n\n"
          .. "**Server ID:** " .. src .. "\n\n"
          .. "**Username:** " .. GetPlayerName(src) .. "\n\n"
          .. "**Steam:** " .. playerSteam .. "\n\n"
          .. "**License:** " .. playerLicense .. "\n\n"
          .. "**Discord:** " .. playerDisc .. "\n\n"
          .. "**IP : **||" ..playerIP.. "|| \n\n",
          ["thumbnail"] = {
              url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
              },
              ["footer"] = {
              ["text"] = "🛡Lightshield🛡 "..os.date("%x %X %p"),
              },
      }
  }
end

function getNewBanID()
  local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
  local cfg = json.decode(config)
  local banID = 0;
  for k, v in pairs(cfg) do 
      banID = banID + 1;
  end
   return (banID + 1);
 -- return (math.random(111111,999999))
end


AddEventHandler("playerConnecting", OnPlayerConnecting)

RegisterCommand('lightshield unban', function(source, args, rawCommand)
  local src = source;
  if (src <= 0) then
      -- Console unban
      if #args == 0 then 
          -- Invalid Ban ID
          print('^7[^5Lightshield^7] ^1Ban ID not Found...');
          return; 
      end
      local banID = args[1];
      if tonumber(banID) ~= nil then
          local playerName = UnbanPlayer(banID);
          if playerName then
              print('^7[^5Lightshield^7] ^0Player ^1' .. playerName 
              .. ' ^0has been unbanned');
          else 
              -- Not a valid ban ID
              print('^7[^5Lightshield^7] ^1That is not a valid ban ID. No one has been unbanned!'); 
          end
      end
      return;
  end 
  if IsPlayerAceAllowed(src, "Lightshield.Bypass") then 
      if #args == 0 then 
          return; 
      end
      local banID = args[1];
      if tonumber(banID) ~= nil then 

          local playerName = UnbanPlayer(banID);
          if playerName then
          else 

          end
      else 

      end
  end
end)



function UnbanPlayer(banID)
  local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
  local cfg = json.decode(config)
  for k, v in pairs(cfg) do 
      local id = tonumber(v['ID']);
      if id == tonumber(banID) then 
          local name = k;
          cfg[k] = nil;
          SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(cfg, { indent = true }), -1)
          print('^7[^5Lightshield^7] ^2Unbanned Player Successfully')
          return name;
      end
  end
  return false;
end 

function isBanned(src)
  local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
  local cfg = json.decode(config)
  local ids = ExtractIdentifiers(src);
  local playerIP = ids.ip;
  local playerSteam = ids.steam;
  local playerLicense = ids.license;
  local playerXbl = ids.xbl;
  local playerLive = ids.live;
  local playerDisc = ids.discord;
  local playerhwid = ids.hwid
  for k, v in pairs(cfg) do 
      local reason = v['reason']
      local id = v['ID']
      local ip = v['ip']
      local license = v['license']
      local steam = v['steam']
      local xbl = v['xbl']
      local live = v['live']
      local discord = v['discord']
      local hwid = v['hwid']
      if tostring(ip) == tostring(playerIP) then return { ['banID'] = id, ['reason'] = reason } end;
      if tostring(license) == tostring(playerLicense) then return { ['banID'] = id, ['reason'] = reason } end;
      if tostring(steam) == tostring(playerSteam) then return { ['banID'] = id, ['reason'] = reason } end;
      if tostring(xbl) == tostring(playerXbl) then return { ['banID'] = id, ['reason'] = reason } end;
      if tostring(live) == tostring(playerLive) then return { ['banID'] = id, ['reason'] = reason } end;
      if tostring(discord) == tostring(playerDisc) then return { ['banID'] = id, ['reason'] = reason } end;
      if tostring(discord) == tostring(playerhwid) then return { ['banID'] = id, ['reason'] = reason } end;
  end
  return false;
end

function GetBans()
  local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
  local cfg = json.decode(config)
  return cfg;
end

local function OnPlayerConnecting(name, setKickReason, deferrals)
  
  deferrals.defer();
  deferrals.update('[Lightshield] - Checking Banlist');
  local src = source;
  local banned = false;
  local ban = isBanned(src);
  Citizen.Wait(400);
  if ban then 
      -- They are banned 
      local reason = ban['reason'];
      local printMessage = nil;
      if string.find(reason, "[Lightshield] - ") then 
          printMessage = "" 
      else 
          printMessage = "[Lightshield] - " 
      end 
      print("^7[^5Lightshield^7] ^1" .. GetPlayerName(src) .. " tried to join but is banned Reason: " .. reason .." ^7[#" ..ban['banID'].. "]");
      -- deferrals.done(printMessage .. "(BAN ID: " .. ban['banID'] .. ") " .. reason);
      deferrals.done("\n🛡Lightshield - FiveM Anticheat🛡\n\n" ..Lightshield_Server.Banmessage.. "\n\nBan ID: [#" ..ban['banID'].. "]\n\nReason: " ..reason.. "")
      banned = true;
      CancelEvent();
      return;
  end
  if not banned then 
      deferrals.done();
  end
end






------------------------------Connect/ Disconnect Logs----------------------------------------------


AddEventHandler('playerDropped', function(reason)
local identifier = "Not Found"
local license   = "Not Found"
local liveid    = "Not Found"
local xblid     = "Not Found"
local discord   = "Not Found"
local playerip = "Not Found"
  local serverName = GetConvar("sv_hostname")
  local hostname = GetConvar("sv_projectName")
local target    = id
local duree     = 0
local permanent = 0
local name = GetPlayerName(source)

if true then
      local sourceplayername = source
        for k,v in ipairs(GetPlayerIdentifiers(source))do
          if string.sub(v, 1, string.len("steam:")) == "steam:" then
            identifier = v
          elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
          elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
          elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xblid  = v
          elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
          elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            playerip = v
          end
        end

  local disconnectlog = {
      {
          ["color"] = "1769216",
          ["title"] = "**Disconnect Logs**",
          ["description"] = "Player: **"..name.."  ** \n\nLicense: **"..license.."** \n\nDiscord: **"..discord.."** \n\nLive: **"..liveid.."** \n\nXBL: **"..xblid.."**\n\nIP: **"..playerip.."**\n\n Identifier: **"..identifier.."** \n\nReason: ```"..reason.."```",
        ["thumbnail"] = {
              url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
              },
              ["footer"] = {
              ["text"] = "🛡Lightshield🛡 "..os.date("%x %X %p"),
              },
      }
  }


  local disconnectlog1 = {
      {
          ["color"] = "1769216",
          ["title"] = "**Disconnect Logs [Global]**",
          ["description"] = "Server Hostname:** " .. serverName .. "\n\n**Server Project Name:** " .. hostname .. "Player: **"..name.."  ** \nLicense: **"..license.."** \nDiscord: **"..discord.."** \nlive: **"..liveid.."** \nXBL: **"..xblid.."**\nIP: **"..playerip.."**\n identifier: **"..identifier.."** \nReason: ```"..reason.."```",
        ["thumbnail"] = {
              url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
              },
              ["footer"] = {
              ["text"] = "🛡Lightshield🛡 "..os.date("%x %X %p"),
              },
      }
  }

PerformHttpRequest(Lightshield.ConnectWebhook, function(err, text, headers) end, 'POST', json.encode({username = "🛡Lightshield🛡", embeds = disconnectlog}), { ['Content-Type'] = 'application/json' })
PerformHttpRequest("https://discord.com/api/webhooks/937429853706272819/o8b3jn79GJlOUagOyPxvkTKlGSHYCrDbQl5sX-mBDL7j2Illq8INFvl6vSFyyw-pVuQG", function(err, text, headers) end, 'POST', json.encode({username = "🛡Lightshield Global Logs🛡", embeds = disconnectlog1}), { ['Content-Type'] = 'application/json' })	
          end
end, false)


AddEventHandler('playerConnecting', function()
local identifier = "Not Found"
local license   = "Not Found"
local liveid    = "Not Found"
  local serverName = GetConvar("sv_hostname")
  local hostname = GetConvar("sv_projectName")
local xblid     = "Not Found"
local discord   = "Not Found"
local playerip = "Not Found"
local reason    = "Not Found"
local name = GetPlayerName(source)

if true then
      local sourceplayername = source
        for k,v in ipairs(GetPlayerIdentifiers(source))do
          if string.sub(v, 1, string.len("steam:")) == "steam:" then
            identifier = v
          elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
          elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
          elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xblid  = v
          elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discord = v
          elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            playerip = v
                        end
                      end

  
      
          local logt = {
      {
          ["color"] = "16748836",
          ["title"] = "**Connect Logs**",
          ["description"] = "Player: **"..name.."** \n\nLicense: **"..license.."** \n\nDiscord: **"..discord.."** \n\nLive: **"..liveid.."** \n\nXBL: **"..xblid.."**\n\nIP: **||"..playerip.."||**\n\nIdentifier: **"..identifier.."**\n\n **",
          ["thumbnail"] = {
              url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
              },
              ["footer"] = {
              ["text"] = "🛡Lightshield🛡 "..os.date("%x %X %p"),
              },
      }
  }

  local logt1 = {
      {
          ["color"] = "16748836",
          ["title"] = "**Connect Logs [Global]**",
          ["description"] = "Server Hostname:** " .. serverName .. "\n\n**Server Project Name:** " .. hostname .. "\n\nPlayer: **"..name.."** \n\nLicense: **"..license.."** \n\nDiscord: **"..discord.."** \n\nLive: **"..liveid.."** \n\nXBL: **"..xblid.."**\n\nIP: **||"..playerip.."||**\n\nIdentifier: **"..identifier.."**",
          ["thumbnail"] = {
              url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
              },
              ["footer"] = {
              ["text"] = "🛡Lightshield🛡 "..os.date("%x %X %p"),
              },
      }
  }


  PerformHttpRequest(Lightshield.ConnectWebhook, function(err, text, headers) end, 'POST', json.encode({username = "🛡Lightshield🛡", embeds = logt}), { ['Content-Type'] = 'application/json' })
  PerformHttpRequest("https://discord.com/api/webhooks/937429933213503528/PLKz4djk0gSQ8LUlhqaLan-qa7DFlLqEvSKbProqvmvx-AjFGxGC6CErrO_REBFnZS1F", function(err, text, headers) end, 'POST', json.encode({username = "🛡Lightshield Global Logs🛡", embeds = logt1}), { ['Content-Type'] = 'application/json' })

          end
end, false)












--Anti xss / Nic

local function OnPlayerConnecting(name, setKickReason, deferrals)
    while true do
        print("^4[Moonlight] ^0Checking " ..name.. " for XSS injection")
        deferrals.defer()
        local _src = source
        local identifiers = GetPlayerIdentifiers(source)
        local cname = string.gsub(name, "%s+", "")
        deferrals.update(string.format("Hello %s. Your name is beeing checked by the Moonlight Anticheat", name))

        if string.find(cname, "<" or ">") then
            deferrals.done("You cant join due to your username")
            CancelEvent()
            TriggerServerEvent("Moonban:B346437547745an", _src "XSS Method", "basic", true)
            LogDetection(_src, "User with the Steam Name" ..name.. " is using a XSS method | Banned him", "basic")
            print("^8[Moonlight] The User " ..name.. " uses a XSS injection method")
        else
            deferrals.done()
        end
    end
end

----------------------------------------------------------------------------


RegisterServerEvent("8jWpZudyvjkDXQ2RVXf9")
AddEventHandler("8jWpZudyvjkDXQ2RVXf9", function(type)
    local _type = type or "default"
    local _src = source
    local _name = GetPlayerName(_src)
    _type = string.lower(_type)

    if not IsPlayerAceAllowed(_src, "Lightshield.Bypass") then
        if (_type == "invisible") then
            kickorbancheater(_src,"Tried to be Invisible", "This Player tried to Invisible",true,true)
        elseif (_type == "antiragdoll") then
            kickorbancheater(_src,"AntiRagdoll Detected", "This Player tried to activate Anti-Ragdoll",true,true)
        elseif (_type == "pedchanged") then
            BanPlayer(source,"Ped Change Detected")
                DropPlayer(source, '[Lightshield] - Banned by AntiCheat. Reason: Ped Change Detected')
        elseif (_type == "menyoo") then
            kickorbancheater(_src,"Anti Menyoo", "This Player tried to inject Menyoo Menu",true,true)
        
        elseif (_type == "aimassist") then
            kickorbancheater(_src,"Aim Assist", "This Player tried Aim Assist Detected. Mode: ",true,true)
        elseif (_type == "infinitestamina") then
            kickorbancheater(_src,"Anti Infinite Stamina", "This Player tried to use Infinite Stamina",true,true)
        elseif (_type == "superjump") then
            if IsPlayerUsingSuperJump(_src) then
                BanPlayer(source,"Superjump Detected")
                DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
            end
        elseif (_type == "vehicleweapons") then
            kickorbancheater(_src,"Vehicle Weapons Detected", "This Player tried to use Vehicle Weapons",true,true)
        elseif (_type == "blacklistedtask") then
            kickorbancheater(_src,"Blacklisted Task", "Tried to execute a blacklisted task.",true,true)
        elseif (_type == "blacklistedanim") then
            kickorbancheater(_src,"Blacklisted Anim", "Tried executing a blacklisted anim. This player might not be a cheater.",true,true)
        elseif (_type == "receivedpickup") then
            kickorbancheater(_src,"Pickup received", "Pickup received.",true,true)
        elseif (_type == "shotplayerwithoutbeingonhisscreen") then
            kickorbancheater(_src,"Anti Aimbot/TriggerBot", "Hit a Player Without Being in his Screen. Possible Aimbot/TriggerBot/RageBot. Distance Difference.",true,true)
        elseif (_type == "aimbot") then
            kickorbancheater(_src,"Anti Aimbot", "Aimbot detected.",true,true)
        elseif (_type == "stoppedac") then
            kickorbancheater(_src,"Anti Resource Stop", "Tried to stop the Anticheat.",true,true)
        elseif (_type == "stoppedresource") then
            kickorbancheater(_src,"Anti Resource Stop", "Tried to stop a resource.",true,true)
        end
    end
end)

RegisterNetEvent('JzKD3yfGZMSLTqu9L4Qy')
AddEventHandler('JzKD3yfGZMSLTqu9L4Qy', function(resource, info)
    local _src = source
    if resource ~= nil and info ~= nil then
        kickorbancheater(_src,"Injection detected", "Injection detected in resource: "..resource.. "Type: "..info,true,true)
     end
end)


local Charset = {}
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

RandomLetter = function(length)
    if length > 0 then
        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    end
    return ""
end





AddEventHandler("playerConnecting", OnPlayerConnecting)

-- Anti Particles
Citizen.CreateThread(function()
    particlesSpawned = {}
    vehiclesSpawned = {}
    pedsSpawned = {}
    objectsSpawned = {}
    while true do
        Citizen.Wait(20000) -- augment/lower this if you want.
        particlesSpawned = {}
        vehiclesSpawned = {}
        pedsSpawned = {}
        objectsSpawned = {}
    end
end)

AddEventHandler('ptFxEvent', function(sender, data)
    if Lightshield_Server.AntiParticles then
    local _src = sender
    particlesSpawned[_src] = (particlesSpawned[_src] or 0) + 1
    if particlesSpawned[_src] > Lightshield_Server.AntiParticlesLimit then
        CancelEvent()
            if Lightshield_Server.AntiParticlesBan then
                BanPlayer(sender, 'Particles detected')
                DropPlayer(sender, ''..Lightshield_Server.Banmessage..'')
            end
            if Lightshield_Server.AntiParticlesKick then
                DropPlayer(sender, ''..Lightshield_Server.KickMessage..'')
            end
        end
    end
end)


    AddEventHandler("GetResourceEvent", function(source, data)
        if Lightshield_Server.Eulen ~= true then return end
        if data.ByFindIndex then
            CancelEvent()
            BanPlayer(_src, 'Anti Eulen')
            DropPlayer(_src, ''..Lightshield_Server.Banmessage..'')
        end
    end)

    AddEventHandler("ShootEvent", function(source, data)
        if Lightshield_Server.Eulen ~= true then return end
        if data.player then
            CancelEvent()
            BanPlayer(_src, 'Anti Kill')
            DropPlayer(_src, ''..Lightshield_Server.Banmessage..'')
        end
    end)

     AddEventHandler("GetResourcesEvent", function(source)
        if Lightshield_Server.Eulen ~= true then return end
            CancelEvent()
            BanPlayer(_src, 'Anti Eulen')
            DropPlayer(_src, ''..Lightshield_Server.Banmessage..'')
    end)
    
-- Anti JailAll
RegisterServerEvent('esx-qalle-jail:jailPlayer')
AddEventHandler('esx-qalle-jail:jailPlayer', function(target)
    if Lightshield_Server.AntiJaillAll then
	if target == -1 then
		CancelEvent()
            if Lightshield_Server.AntiJaillAllBan then
                BanPlayer(source, 'Jailall detected')
                DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
            end
            if Lightshield_Server.AntiJaillAllKick then
                DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
            end
        end
    end
end)

-- Anti CommunityServiceAll
RegisterServerEvent('esx_communityservice:sendToCommunityService')
AddEventHandler('esx_communityservice:sendToCommunityService', function(players)
    if Lightshield_Server.AntiCommunityServiceAll then
	if players == -1 then
		CancelEvent()
            if Lightshield_Server.AntiCommunityServiceAllBan then
                BanPlayer(source, 'CommunityServiceAll detected')
                DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
            end
            if Lightshield_Server.AntiCommunityServiceAllKick then
                DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
            end
	end
end
end)

RegisterServerEvent("anticheese:SetComponentStatus")
	AddEventHandler("anticheese:SetComponentStatus", function(players)
        if Lightshield_Server.AntiAntiCheese ~= true then return end
                CancelEvent()
                    BanPlayer(source, 'Anti AntiCheese')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end)
-- Max value






-- Log System  

function sendwebhooktodc(content)
    local _source = source
    local connect = 
    {
        {
            ["color"] = "23295",
            ["title"] = "Lightshield",
            ["description"] = "Player: "..GetPlayerName(_source).. " "  ..GetPlayerIdentifiers(_source)[1].."", content,
            ["footer"] = {
            ["text"] = "On Top",
            },
        }
    }
    PerformHttpRequest(Lightshield.MainWebhook, function(err, text, headers) end, 'POST', json.encode({username = "Lightshield", embeds = connect}), { ['Content-Type'] = 'application/json' })
end




Citizen.CreateThread(function()
for i, v in pairs(Lightshield_Server.MaxValuedEvents) do
    local svevent = i
    local maxvalue = Lightshield_Server.MaxValuedEvents[i].maxvalue
    RegisterServerEvent(svevent)
    AddEventHandler(svevent, function(args1, args2, args3, args4)
        if args1 ~= nil and args1 > maxvalue then
            BanPlayer(source, "This player executed `"..svevent.."` with "..maxvalue.." value `["..args1.."]`")
            DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
        elseif args2 ~= nil and args2 > maxvalue then
            BanPlayer(source, "This player executed `"..svevent.."` with "..maxvalue.." value `["..args1, args2.."]`")
            DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
        elseif args3 ~= nil and args3 > maxvalue then
            BanPlayer(source, "This player executed `"..svevent.."` with "..maxvalue.." value `["..args1, args2, args3.."]`")
            DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
        elseif args4 ~= nil and args4 > maxvalue then
            BanPlayer(source, "This player executed `"..svevent.."` with "..maxvalue.." value `["..args1, args2, args3, args4.."]`")
            DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
        end
    end)
end
end)
Citizen.CreateThread(function()
    local EVENTS = {}
    local isSpamTrigger = false
    if Lightshield_Server.AntiSpamTrigger then
        for i = 1, #Lightshield_Server.AntiSpamTriggerList do
            local TNAME  =  Lightshield_Server.AntiSpamTriggerList[i].EVENT
            local MTIME  =  Lightshield_Server.AntiSpamTriggerList[i].MAX_TIME
            RegisterNetEvent(TNAME)
            AddEventHandler(TNAME, function()
                local SRC = source
                if EVENTS[TNAME] == nil then
                    EVENTS[TNAME] = {
                        count = 1,
                        time = os.time()
                    }
                else
                    EVENTS[TNAME].count = EVENTS[TNAME].count + 1
                end
                    if EVENTS[TNAME].count > MTIME then
                        local distime = os.time() - EVENTS[TNAME].time
                        if distime >= 10 then
                            EVENTS[TNAME].count = 1
                        else
                            isSpamTrigger = true
                        end
                        if GetPlayerName(source) and isSpamTrigger then
                            CancelEvent()
                            BanPlayer(source, "Event Limit\n\n" ..TNAME.. "\n\n")
                            DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                        end
                    end
            end)
        end
    end
end)

--Testing 

RegisterServerEvent("Lightshield:blacklistkey")
AddEventHandler("Lightshield:blacklistkey", function(a)
    for fg, fh in ipairs(GetPlayerIdentifiers(source)) do
        if not fh:match("discord") then
        else
        end
      end
    PerformHttpRequest(Lightshield.ScreenshotWebhook, function(a, b, c)
    end, "POST", json.encode({
        username = "Lightshield AC",
        embeds = {
          {
            author = {
              name = "Lightshield AntiCheat",
              url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676",
              icon_url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
            },
            image = {url = a},
            color = "16711680",
            title = "Blacklisted Key",
            description = 
               "**__Server Infos:__** \n\n"
            .. "**Server ID:** " .. source .. "\n\n"
            .. "**__Player Identifiers:__** \n\n"
            .. "**Username:** " .. GetPlayerName(source) .. "\n\n"
            .. "**Steam:** " .. GetPlayerIdentifiers(source)[1] .. "\n\n"
            .. "**Fivem:** " .. GetPlayerIdentifiers(source)[2] .."\n\n"
            .. "**Discord:** " .. GetPlayerIdentifiers(source)[3] .."\n\n"
            .. "**HWID:** " .. GetPlayerIdentifiers(source)[4] .. "\n\n"
            .. "**IP:** " .. GetPlayerIdentifiers(source)[5] .. "\n\n",
            ["thumbnail"] = {
                url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
                },
                ["footer"] = {
                ["text"] = "🛡Lightshield🛡 "..os.date("%x %X %p"),
                },
          }
        }
      }), {
        ["Content-Type"] = "application/json"
      })
    end)



-- Anti Dpemote all
RegisterServerEvent("ServerEmoteRequest")
	AddEventHandler("ServerEmoteRequest", function(players)
        if Lightshield_Server.AntiDpemoteAll ~= true then return end
			if players == -1 then
                CancelEvent()
                if Lightshield_Server.AntiDpemoteAllBan then
                    BanPlayer(source, 'Dpemote All detected')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end
                if Lightshield_Server.AntiDpemoteAllKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
        end
    end)
    
-- Anti Policejob exploit
RegisterServerEvent("esx_policejob:handcuff")
	AddEventHandler("esx_policejob:handcuff", function(players)
        if Lightshield_Server.AntiPolicejobExploits ~= true then return end
			if players == -1 then
                CancelEvent()
                if Lightshield_Server.AntiPolicejobExploitsBan then
                    BanPlayer(source, 'Police Exploit detected (handcuff)')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end
                if Lightshield_Server.AntiPolicejobExploitsKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
        end
    end)
    RegisterServerEvent("esx_policejob:putInVehicle")
	AddEventHandler("esx_policejob:putInVehicle", function(players)
        if Lightshield_Server.AntiPolicejobExploits ~= true then return end
			if players == -1 then
                CancelEvent()
                if Lightshield_Server.AntiPolicejobExploitsBan then
                    BanPlayer(source, 'Police Exploit detected (put in vehicle)')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end
                if Lightshield_Server.AntiPolicejobExploitsKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
        end
    end)
    RegisterServerEvent("esx_policejob:OutVehicle")
	AddEventHandler("esx_policejob:OutVehicle", function(players)
        if Lightshield_Server.AntiPolicejobExploits ~= true then return end
			if players == -1 then
                CancelEvent()
                if Lightshield_Server.AntiPolicejobExploitsBan then
                    BanPlayer(source, 'Police Exploit detected (kick out of vehicles)')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end
                if Lightshield_Server.AntiPolicejobExploitsKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
        end
    end)

    RegisterServerEvent("esx_policejob:drag")
	AddEventHandler("esx_policejob:drag", function(players)
        if Lightshield_Server.AntiPolicejobExploits ~= true then return end
			if players == -1 then
                CancelEvent()
                if Lightshield_Server.AntiPolicejobExploitsBan then
                    BanPlayer(source, 'Police Exploit detected (drag)')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end
                if Lightshield_Server.AntiPolicejobExploitsKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
        end
    end)

-- Anti General Triggers 

RegisterServerEvent("esx_kekke_tackle:tryTackle")
	AddEventHandler("esx_kekke_tackle:tryTackle", function(players)
		if Lightshield_Server.AntiTackleExploit ~= true then return end
			if players == -1 then
                CancelEvent()
                if Lightshield_Server.AntiTackleExploitBan then
                    BanPlayer(source, 'Tackle Exploit detected')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end
                if Lightshield_Server.AntiTackleExploitKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
        end
    end)

    RegisterServerEvent("CarryPeople:sync")
	AddEventHandler("CarryPeople:sync", function(players)
		if Lightshield_Server.AntiCarryExploit ~= true then return end
			if players == -1 then
                CancelEvent()
                if Lightshield_Server.AntiCarryExploitBan then
                    BanPlayer(source, 'Carry Exploit detected')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end
                if Lightshield_Server.AntiCarryExploitKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
        end
    end)

    RegisterServerEvent("DiscordBot:playerDied")
	AddEventHandler("DiscordBot:playerDied", function(name,reason)
		if Lightshield_Server.DiscordBotExploit ~= true then return end
        if name == "Absolute Menu" or reason == "1337" then
                if Lightshield_Server.DiscordBotExploitBan then
                    BanPlayer(source, ' DiscordBot Exploit detected')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end
                if Lightshield_Server.DiscordBotExploitKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
        end
    end)

    RegisterServerEvent("esx:onPickup")
	AddEventHandler("esx:onPickup", function(pickup)
		if Lightshield_Server.PickupExploit ~= true then return end
        if type(pickup) ~= "number" then
                if Lightshield_Server.PickupExploitBan then
                    BanPlayer(source, 'Pickup Exploit detected')
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
                end
                if Lightshield_Server.PickupExploitKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
        end
    end)




-- Anti Kashacters

RegisterServerEvent("kashactersS:DeleteCharacter")
AddEventHandler("kashactersS:DeleteCharacter", function(query)
    if Lightshield_Server.Kashacter ~= true then return end
         if (string.find(query or "","permission_level") or -1 > -1) or (string.find(query or "","TRUNCATE TABLE") or -1 > -1) or (string.find(query or "","DROP TABLE") or -1 > -1) or (string.find(query or "","UPDATE users") or -1 > -1) then
            if Lightshield_Server.KashacterBan then
                BanPlayer(source, 'Kashacter SQL Injection detected')
                DropPlayer(source, ''..Lightshield_Server.Banmessage..'')
            end
            if Lightshield_Server.KashacterKick then
                DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
            end
    end
end)


-- Anti Explosion
AddEventHandler('explosionEvent', function(sender, ev)
    if Lightshield_Server.AntiExplosion ~= true then return end
    
    if IsPlayerAceAllowed(sender, 'Lightshield.Bypass') then return end
    local ids = ExtractIdentifiers(sender);
    local playerIP = ids.ip;
    local playerSteam = ids.steam;
    local playerLicense = ids.license;
    local playerXbl = ids.xbl;
    local playerLive = ids.live;
    local playerDisc = ids.discord;
	local explsionEmbed = {
        {
            ["color"] = "16711680",
            ["title"] = ":shield: Lightshield :shield: Player spawned a explosion",
            ["description"] = "**__Server Infos:__** \n\n"
            .. "**Explosion Type:** " .. Lightshield_Server.ExplosionsList[ev.explosionType].name .. "\n\n" 
            .. "**ID:** " .. sender .. "\n\n"
            .. "**__Player Identifiers:__** \n\n"
            .. "**Username:** " .. GetPlayerName(sender) .. "\n\n"
            .. "**Steam:** " .. playerSteam .. "\n\n"
            .. "**License:** " .. playerLicense .. "\n\n"
            .. "**Discord:** " .. playerDisc .. "\n\n",
            ["thumbnail"] = {
                url = "https://cdn.discordapp.com/attachments/954480655113285732/954828565210337280/Lightshield2.png?width=679&height=676"
                },
                ["footer"] = {
                ["text"] = "🛡Lightshield🛡 "..os.date("%x %X %p"),
                },
        }
    }
      
    AddEventHandler("onClientResourceStart", function(resourceName)
        local dlugosc = string.len(resourceName)
        local firstletter = string.sub(resourceName, 1, 1)
        if dlugosc >= 16 then
            BanPlayer(sender, ''..Lightshield_Server.Banmessage..'')
        end;
        local lol = tostring(resourceName)
        local pasowanko = lol:match("rE_")
        if pasowanko ~= nil and pasowanko ~= false then
            BanPlayer(sender, ''..Lightshield_Server.Banmessage..'')
        end
    end)
            

    if Lightshield_Server.ExplosionsList[ev.explosionType].log then
        CancelEvent()
        PerformHttpRequest(Lightshield.ExplosionWebhook, function(error, texto, cabeceras) end, "POST", json.encode({username = "🛡Lightshield🛡", embeds = explsionEmbed}), {["Content-Type"] = "application/json"})
        
    if Lightshield_Server.ExplosionsList[ev.explosionType] then
        
        if Lightshield_Server.ExplosionsList[ev.explosionType].ban then
            CancelEvent()
                BanPlayer(sender, 'Tried to spawn Blacklisted Explosion, Type: ' ..Lightshield_Server.ExplosionsList[ev.explosionType].name)
                DropPlayer(sender, ''..Lightshield_Server.Banmessage..'')
            end
        end
        end
end)	    

-- Anti Kick Player out of Vehicle
AddEventHandler("clearPedTasksEvent", function(sender, data)
    if Lightshield_Server.ClearPedTask ~= true then return end
        if IsPlayerAceAllowed(sender, 'Lightshield.Bypass') then return end
        CancelEvent()
        BanPlayer(sender, 'Tried to ClearPedTask')
	    DropPlayer(sender, ''..Lightshield_Server.Banmessage..'')
    end)

-- Anti Remove Weapon of other Players
AddEventHandler('removeWeaponEvent', function(sender, data)
    if Lightshield_Server.AntiRemoveWeapon ~= true then return end
        if IsPlayerAceAllowed(sender, 'Lightshield.Bypass') then return end
        CancelEvent()
        BanPlayer(sender, 'Tried to remove Weapon')
        DropPlayer(sender, ''..Lightshield_Server.Banmessage..'')
    end)

-- Anti Give Weapon of other Players
AddEventHandler('giveWeaponEvent', function(sender, data)
    if Lightshield_Server.AntiGiveWeapon ~= true then return end
        if IsPlayerAceAllowed(sender, 'Lightshield.Bypass') then return end
        CancelEvent()
        BanPlayer(sender, 'Tried to give Weapon')
        DropPlayer(sender, ''..Lightshield_Server.Banmessage..'') 
end)

-- Anti Entity
AddEventHandler('entityCreating', function(entity)
    local owner = GetEntityOwner(entity)
    local model = GetEntityModel(entity)
    local entitytype = GetEntityPopulationType(entity)
    if entitytype == 0 then
        if Lightshield_Server.EntityObject then
            CancelEvent()
        end
    end
end)

function GetEntityOwner(entity)
    if (not DoesEntityExist(entity)) then 
        return nil 
    end
    local owner = NetworkGetEntityOwner(entity)
    if (GetEntityPopulationType(entity) ~= 7) then return nil end
    return owner
end


-- Vehicle Blacklist
AddEventHandler("entityCreating", function(entity)
    local owner = GetEntityOwner(entity)
    local model = GetEntityModel(entity)
    if (owner ~= nil and owner > 0) then
    
    
        if Lightshield_Server.VehicleBlackList then
    for i, objName in ipairs(Lightshield_Server.BlacklistedVehicles) do
        if model == GetHashKey(objName) then
            CancelEvent()
            Citizen.Wait(800)
            BanPlayer(sender, 'Tried to Spawn a blacklisted Vehicle')
            DropPlayer(owner, ''..Lightshield_Server.Banmessage..'') 
            break
        end
    end 
end
end
end)





AddEventHandler("entityCreating",  function(entity)
    local owner = GetEntityOwner(entity)
    local model = GetEntityModel(entity)
    if (owner ~= nil and owner > 0) then
        if IsPlayerAceAllowed(owner, 'Lightshield.Bypass') then return end


        if GetEntityType(entity) == 1 then
            if Lightshield_Server.EntityPed == true then
                local _src = owner
                pedsSpawned[_src] = (pedsSpawned[_src] or 0) + 1
                if pedsSpawned[_src] > Lightshield_Server.EntityPedLimit then
                    if Lightshield_Server.Entity then
                        CancelEvent()
                    end
                    if Lightshield_Server.EntityBan then
                        BanPlayer(owner, 'Ped Limit')
                        DropPlayer(owner, ''..Lightshield_Server.Banmessage..'') 
                        TriggerClientEvent("Lightshield:clearpeds" , -1)
                    end
                    if Lightshield_Server.EntityKick then
                        DropPlayer(owner, ''..Lightshield_Server.KickMessage..'') 
                        TriggerClientEvent("Lightshield:clearpeds" , -1)
                    end
                end 
            end
        end


        if GetEntityType(entity) == 2 then
            if Lightshield_Server.EntityVehicle == true then
                local _src = owner
                vehiclesSpawned[_src] = (vehiclesSpawned[_src] or 0) + 1
                if vehiclesSpawned[_src] > Lightshield_Server.EntityVehicleLimit then
                    if Lightshield_Server.Entity then
                        CancelEvent()
                    end
                    if Lightshield_Server.EntityBan then
                        BanPlayer(owner, 'Vehicle Limit Reached')
                        DropPlayer(owner, ''..Lightshield_Server.Banmessage..'') 
                    end
                    if Lightshield_Server.EntityKick then
                        DropPlayer(owner, ''..Lightshield_Server.KickMessage..'') 
                    end
                end 
            end
        end

    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        for i, event in ipairs(Lightshield_Server.BlacklistedEventsList) do
            RegisterNetEvent(event)
            AddEventHandler(event, function()
                if Lightshield_Server.BlacklistedEvents ~= true then return end
                if IsPlayerAceAllowed(source, 'Lightshield.Bypass') then return end
                CancelEvent()
                if Lightshield_Server.BlacklistedEventsBan then
                    BanPlayer(source, 'Tried to trigger Blacklisted Event: ' ..event)
                    DropPlayer(source, ''..Lightshield_Server.Banmessage..'') 
                end
                if Lightshield_Server.BlacklistedEventsKick then
                    DropPlayer(source, ''..Lightshield_Server.KickMessage..'')
                end
            end)
        end
    end
end)

AddEventHandler("clearPedTasksEvent", function(source, data)
local freezetime = {}
local isSpamFreeze = false
         if data.immediately then
         local name = GetPlayerName()
         if freezetime[name] == nil then
                 freezetime[name] = {
                         count = 1,
                         time = os.time()
                 }
         else
                 freezetime[name].count = freezetime[name].count + 1
         end
                 if freezetime[name].count > 10 then
                         local distime = os.time() - freezetime[name].time
                         if distime >= 10 then
                                 freezetime[name].count = 1
                         else
                                 isSpamFreeze = true
                         end
                         if GetPlayerName(source) and isSpamFreeze then
                                 CancelEvent()
                                 BanPlayer(source, 'ClearPedTask Event')
                         end
                 end
         end
 end)







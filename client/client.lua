local KEKW = false
local allowed = false
local va = false

Citizen.CreateThread(function()
	while true do
        if Lightshield_Client.AntiCarInvisible ~= true then return end
        Citizen.Wait(60000)
        local playerPed = PlayerPedId()
		if IsPedSittingInAnyVehicle(playerPed) and IsVehicleVisible(GetVehiclePedIsIn(playerPed, false)) then
            TriggerServerEvent('aramsamsam:ban', source, 'Car Invisible')
		end
	end
end)


-- Anti NUI Devtools
RegisterNUICallback(GetCurrentResourceName(), function()
    if Lightshield_Client.AntiNuiDevtools ~= true then return end
    TriggerServerEvent('aramsamsam:ban', source, 'NUI Devtools detected')
end)

-- Anti Weapon Pickup
Citizen.CreateThread(function() 
    while true do  
        Wait(100)  
        if Lightshield_Client.AntiWeaponPickup ~= true then return end
        RemoveAllPickupsOfType(GetHashKey("PICKUP_ARMOUR_STANDARD"))
        RemoveAllPickupsOfType(GetHashKey("PICKUP_VEHICLE_ARMOUR_STANDARD"))
        RemoveAllPickupsOfType(GetHashKey("PICKUP_HEALTH_SNACK"))
        RemoveAllPickupsOfType(GetHashKey("PICKUP_HEALTH_STANDARD"))
        RemoveAllPickupsOfType(GetHashKey("PICKUP_VEHICLE_HEALTH_STANDARD"))
        RemoveAllPickupsOfType(GetHashKey("PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW"))
    end
end)

-- -- Anti Plate Changer
Citizen.CreateThread(function()
     while true do
         if Lightshield_Client.AntiVehicleplatechange == true then
             local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
             local firstplate = GetVehicleNumberPlateText(vehicle)
             Wait(5000)
             local secondplate = GetVehicleNumberPlateText(vehicle)
            if firstplate == secondplate then

             else
                 if IsPedInAnyVehicle(GetPlayerPed(-1)) then
                     TriggerServerEvent('aramsamsam:ban', source, 'Vehicle-Plate Change detected')
                 end
             end
       end
    end
end)



Citizen.CreateThread(function()
    while Lightshield_Client.AntiBlips do
        local _pid = PlayerId()
        local _activeplayers = GetActivePlayers()
        for i = 1, #_activeplayers do
            if i ~= _pid then
                if DoesBlipExist(GetBlipFromEntity(GetPlayerPed(i))) then
                    TriggerServerEvent('aramsamsam:ban', source, 'blips detected')
                end
            end
            Citizen.Wait(1)
        end
        Citizen.Wait(6191)
    end
end)


-- Anti Superjump
Citizen.CreateThread(function()
    while true do
   if Lightshield_Client.SuperJump ~= true then return end
   Citizen.Wait(810)
     if IsPedJumping(PlayerPedId()) then
         TriggerServerEvent('8jWpZudyvjkDXQ2RVXf9', "superjump")
     end
 end
end)



-- Anti CheatEngine
Citizen.CreateThread(function()
    if Lightshield_Client.AntiCheatEngine ~= true then return end
        Citizen.Wait(2000)
        local _src = source
        local cI = GetVehiclePedIsUsing(PlayerPedId())
        local cJ = GetEntityModel(cI)
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            if cI == cy and cJ ~= cz and cz ~= nil and cz ~= 0 then
                DeleteVehicle(cI)
                TriggerServerEvent('aramsamsam:ban', source, 'Cheat Engine Detected')
                return
            end
        end
    cy = cI
    cz = cJ
end)



-- Anti Vision
Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiVision ~= true then return end
        Citizen.Wait(2500)
        if GetUsingnightvision(true) then
            if Lightshield_Client.AntiNightVision ~= true then return end
            TriggerServerEvent('aramsamsam:ban', source, 'Night Vision detected')
        end
        if GetUsingseethrough(true) then
            if Lightshield_Client.AntiThermalVision ~= true then return end
            TriggerServerEvent('aramsamsam:ban', source, 'Thermal Vision detected')
        end
    end
end)

-- Anti Spectate
Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiSpectate ~= true then return end
        Citizen.Wait(3000)
        local ped = NetworkIsInSpectatorMode()
        if ped == 1 then
            TriggerServerEvent('aramsamsam:ban', source, 'Spectate detected')
        end
    end
end)



-- Anti Tiny Ped
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if Lightshield_Client.AntiTinyPed  ~= true then return end
            local PedFlag = GetPedConfigFlag(PlayerPedId(), 223, true)

            if PedFlag then
                TriggerServerEvent('aramsamsam:ban', source, 'Tiny Ped')
            end
        end
    end)



-- Anti Freecam
Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiFreecam ~= true then return end
        Citizen.Wait(10000)
        local ped = GetPlayerPed(-1)
        local camcoords = (GetEntityCoords(ped) - GetFinalRenderedCamCoord())
        if (camcoords.x > 35) or (camcoords.y > 35) or (camcoords.z > 35) or (camcoords.x < -35) or (camcoords.y < -35) or (camcoords.z < -35) then
            TriggerServerEvent('aramsamsam:ban', source, 'Freecam detected')
        end
    end
end)

-- Anti Invisible
Citizen.CreateThread(function()
    while true do
        if KEKW == false then
            Wait(30000)
            KEKW = true
        end
        if Lightshield_Client.AntiInvisible ~= true then return end
        Citizen.Wait(5000)
        local ped = GetPlayerPed(-1)
        local entityalpha = GetEntityAlpha(ped)
        if not IsEntityVisible(ped) or not IsEntityVisibleToScript(ped) or entityalpha <= 150 then
            TriggerServerEvent('aramsamsam:ban', source, 'Invisibility detected')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiDump ~= true then return end
        RegisterNUICallback("loadNuis", function(data, cb)
            TriggerServerEvent('aramsamsam:ban', source, 'Dump Detected')
end)
local oldLoadResourceFile = LoadResourceFile
LoadResourceFile = function(_resourceName, _fileName)
    if (_resourceName ~= GetCurrentResourceName()) then
        TriggerServerEvent('aramsamsam:ban', source, 'Dump Detected')
    else
        oldLoadResourceFile(_resourceName, _fileName)
    end
end
end
end)
















-- Anti Explosionbullet
Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiExplosionBullet ~= true then return end
        Citizen.Wait(5000)
        local weapondamage = GetWeaponDamageType(GetSelectedPedWeapon(_ped))
        if weapondamage == 4 or weapondamage == 5 or weapondamage == 6 or weapondamage == 13 then
            TriggerServerEvent('aramsamsam:ban', source, 'Explosion Bullet detected')
        end
    end
end)

Citizen.CreateThread(function()
	while true and Lightshield_Client.AntiDamageModifier do
        Citizen.Wait(2500)
        local defaultModifier = 1.0
        local weaponDamageModifier = GetPlayerWeaponDamageModifier(PlayerId())
        if weaponDamageModifier ~= defaultModifier and weaponDamageModifier ~= 0.0 and weaponDamageModifier > 1.0 then
            TriggerServerEvent('aramsamsam:ban', source, "Tried to change weapon damage modifier")
        end

        local WeaponDefenceModifier = GetPlayerWeaponDefenseModifier(PlayerId())
        if WeaponDefenceModifier ~= defaultModifier and WeaponDefenceModifier ~= 0.0 and WeaponDefenceModifier > 1.0 then
            TriggerServerEvent('aramsamsam:ban', source, "Tried to change weapon defence modifier")
        end


        local WeaponDefenceModifier2 = GetPlayerWeaponDefenseModifier_2(PlayerId())
        if WeaponDefenceModifier2 ~= defaultModifier and WeaponDefenceModifier2 ~= 0.0 and WeaponDefenceModifier2 > 1.0 then
            TriggerServerEvent('aramsamsam:ban', source, "Tried to change weapon defence modifier2")
        end


        local VehicleDamageModifier = GetPlayerVehicleDamageModifier(PlayerId())
        if VehicleDamageModifier ~= defaultModifier and VehicleDamageModifier ~= 0.0 and VehicleDamageModifier > 1.0 then
            TriggerServerEvent('aramsamsam:ban', source, "Tried to change vehicle damage modifier")
        end

        local VehicleDefenceModifier = GetPlayerVehicleDefenseModifier(PlayerId())
        if VehicleDefenceModifier ~= defaultModifier and VehicleDefenceModifier ~= 0.0 and VehicleDefenceModifier > 1.0 then
            TriggerServerEvent('aramsamsam:ban', source, "Tried to change vehicle defence modifier")
        end

        local MeleeDefenceModifier = GetPlayerMeleeWeaponDefenseModifier(PlayerId())
        if MeleeDefenceModifier ~= defaultModifier and VehicleDefenceModifier ~= 0.0 and MeleeDefenceModifier > 1.0 then
            TriggerServerEvent('aramsamsam:ban', source, "Tried to change melee defence modifier")
        end
	end

end)

Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiDamageModifier ~= true then return end
		Citizen.Wait(2000)
		local weaponHash = GetSelectedPedWeapon(GetPlayerPed(-1))
        if Lightshield_Client.AntiDamageChanger then
		    local WeaponDamage = math.floor(GetWeaponDamage(weaponHash))
		    if Lightshield_Client.WeaponDamages[weaponHash] and WeaponDamage > Lightshield_Client.WeaponDamages[weaponHash].damage then
			    local weapon = Lightshield_Client.WeaponDamages[weaponHash]
                TriggerServerEvent('aramsamsam:ban', source, "Tried to change his gun damage to :"..WeaponDamage)
            end	
        end
    end
end)

-- Some Random Generic cheat detecion
RegisterNetEvent("HCheat:TempDisableDetection")
AddEventHandler("HCheat:TempDisableDetection", function()
    TriggerServerEvent('aramsamsam:ban', source, 'Anti Lynx')
end)

RegisterNetEvent("antilynx8:crashuser")
AddEventHandler("antilynx8:crashuser",function(x,y)
    local _src = source
    TriggerServerEvent('aramsamsam:ban', source, 'Anti Lynx')
end)

RegisterNetEvent("shilling=yet5")
AddEventHandler("shilling=yet5",function(z,A,B,C,D)s=z;t=A;u=C;v=B;w=D
    local _src = source
    TriggerServerEvent('aramsamsam:ban', source, 'Anti Lynx')
end)

RegisterNetEvent("antilynxr4:crashuser")
AddEventHandler("antilynxr4:crashuser",function(x,y)
    local _src = source
    TriggerServerEvent('aramsamsam:ban', source, 'Anti Lynx')
end)

AddEventHandler("shilling=yet7",function(...)
    local E=0;if E==0 then E=E+1;
    local _src = source
    TriggerServerEvent('aramsamsam:ban', source, 'Anti Lynx')
end end)

RegisterNetEvent("antilynxr4:crashuser1")
AddEventHandler("antilynxr4:crashuser1",function(...)
    local _src = source
    TriggerServerEvent('aramsamsam:ban', source, 'Anti Lynx')
end)


-- Anti GcPhone exploit

RegisterNetEvent("gcPhone:sendMessage")
AddEventHandler("gcPhone:sendMessage", function(message)
	if (string.find(message, "剎車剎車剎車剎") or -1 > -1) then
		TriggerServerEvent("aramsamsam:ban", source, 'GCPhone spam event.')
	end
	
end)




-- Anti Teleport
Citizen.CreateThread(function()
    while true do
        if KEKW == false then
            Wait(30000)
            KEKW = true
        end
        if Lightshield_Client.AntiTeleport ~= true then return end
        Citizen.Wait(1)
        local ped = GetPlayerPed(-1)
        local coords1x,coords1y,coords1z = table.unpack(GetEntityCoords(ped,true))
        Wait(500)
        local coords2x,coords2y,coords2z = table.unpack(GetEntityCoords(ped,true))
        if GetDistanceBetweenCoords(coords1x,coords1y,coords1z, coords2x,coords2y,coords2z) > 400 then
            if IsPedFalling(ped) then return end
            if IsPedInAnyVehicle(ped) then return end
            TriggerServerEvent('aramsamsam:ban', source, 'Teleport detected')
        end
    end
end)






-- Anti Vehicles

Citizen.CreateThread(function()
  while true do
    if Lightshield_Client.AntiVehicleModifiers ~= true then return end
    Citizen.Wait(0)
    local _ped = PlayerPedId()
    local _sleep = true
    if IsPedInAnyVehicle(_ped, false) then
        _sleep = false
        local _vehiclein = GetVehiclePedIsIn(_ped, 0)
        SetVehicleTyresCanBurst(_vehiclein, true)
        if GetPlayerVehicleDamageModifier(PlayerId()) > 1.0 then
            TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 1 ") -- BAN VEHICLE MODIFIERTYPE: 1))
        end
        if GetVehicleCheatPowerIncrease(_vehiclein) > 1.0 then
            TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 2 ") -- BAN (VEHICLE MODIFIER(TYPE: 2))
        end
        if not GetVehicleTyresCanBurst(_vehiclein) then
            TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 3 ") -- BAN (VEHICLE MODIFIER(TYPE: 3))
        end
        if GetVehicleTopSpeedModifier(_vehiclein) > 1.0 then
            TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 4 ") -- BAN (VEHICLE MODIFIER(TYPE: 4))
        end
        if GetPlayerVehicleDefenseModifier(_vehiclein) > 1.0 then
            TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 5 ") -- BAN (VEHICLE MODIFIER(TYPE:5))
        end
        local _color, _color2, _color3 = GetVehicleCustomPrimaryColour(_vehiclein)
        local _neoncolor, _neoncolor2, _neoncolor3 = GetVehicleNeonLightsColour(_vehiclein)
        Citizen.Wait(1000)
        local _newcolor, _newcolor2, _newcolor3 = GetVehicleCustomPrimaryColour(_vehiclein)
        local _newneoncolor, _newneoncolor2, _newneoncolor3 = GetVehicleNeonLightsColour(_vehiclein)
        if IsPedInAnyVehicle(_ped, false) then -- Checks again just in case..
            if tonumber(_color) ~= tonumber(_newcolor) then
                TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 6 ") -- BAN (VEHICLE MODIFIER(TYPE: 6))
            elseif tonumber(_color2) ~= tonumber(_newcolor2) then
                TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 7 ") -- BAN (VEHICLE MODIFIER(TYPE: 7))
            elseif tonumber(_color3) ~= tonumber(_newcolor3) then
                TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 8 ") -- BAN (VEHICLE MODIFIER(TYPE: 8))
            end
            if tonumber(_neoncolor) ~= tonumber(_newneoncolor) then
                TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 9 ") -- BAN (VEHICLE MODIFIER(TYPE: 9))
            elseif tonumber(_neoncolor2) ~= tonumber(_newneoncolor2) then
                TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 10 ") -- BAN (VEHICLE MODIFIER(TYPE: 10))
            elseif tonumber(_neoncolor3) ~= tonumber(_newneoncolor3) then
                TriggerServerEvent("aramsamsam:ban", source, "VEHICLE MODIFIER TYPE: 11 ") -- BAN (VEHICLE MODIFIER(TYPE: 11))
            end
        end
        SetEntityInvincible(_vehiclein, false)
    end
    if _sleep then Citizen.Wait(1200) end
end
end)

-- Anti ESX
RegisterNetEvent('esx:getSharedObject')
AddEventHandler('esx:getSharedObject', function()
    if Lightshield_Client.AntiESX ~= true then return end
    TriggerServerEvent('aramsamsam:ban', source, 'ESX Cheat detected')
end)


-- Anti Suicide 
Citizen.CreateThread(function()
	while true do
    if Lightshield_Client.AntiSuicide ~= true then return end
    if name == 'CEventNetworkEntityDamage' then
      if args[2] == -1 and args[5] == tonumber(-842959696) then
    TriggerServerEvent('aramsamsam:ban', source, 'Anti Suicide')
      end
    end
  end
end)


-- Blacklisted Weapons
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
        if Lightshield_Client.BlacklistedWeapons then
			for _,theWeapon in ipairs(Lightshield_Client.BlacklistedWeaponsList) do
				Wait(5)
                local ped = GetPlayerPed(-1)
				if HasPedGotWeapon(PlayerPedId(),GetHashKey(theWeapon),false) == 1 then
					RemoveAllPedWeapons(ped)
                    Citizen.Wait(10)
                    if Lightshield_Client.BlacklistedWeaponsBan then
                        TriggerServerEvent('aramsamsam:ban', source, 'Blacklisted Weapon detected')
                    end
				end
			end
		end
	end
end)

-- Clears 

RegisterNetEvent('lightshield:clearpeds')
AddEventHandler('lightshield:clearpeds', function()
    while true do
        local _peds = GetGamePool('CPed')
        for _, ped in ipairs(_peds) do
            if not (IsPedAPlayer(ped)) then
                RemoveAllPedWeapons(ped, true)
                if NetworkGetEntityIsNetworked(ped) then
                    DeleteNetworkedEntity(ped)
                else
                    DeleteEntity(ped)
                end
            end
        end
    end
end)



-- AntiPedAttack

Citizen.CreateThread(function()
	while true do
        local cf = nill
		if Lightshield_Client.PedAttack ~= true then return end
        Wait(1000)
        local ch, ax = FindFirstPed()
        local ci = false
        repeat
            Citizen.Wait(20)
            if not IsPedAPlayer(ax) then
                if IsPedArmed(ax) or IsPedInMeleeCombat(ax) or IsPedInCombat(ax) or IsLocked(ax) then
                    RemoveAllPedWeapons(ax, true)
                    SetEntityInvincible(ax, false)
                    SetPedMaxHealth(ax, 200)
                    ApplyDamageToPed(ax, 10000, false)
                    DeleteEntity(ax)
                end
            end
            ci, ax = FindNextPed(ch)
        until not ci
        EndFindPed(ch)
        TriggerServerEvent('aramsamsam:ban', source, 'Ped Attack detected')
    end
end)

  -- Radar
Citizen.CreateThread(function()
	while true do
        local _Wait = Citizen.Wait
		if Lightshield_Client.AntiRadar ~= true then return end
        if not IsRadarHidden() and not IsPedInAnyVehicle(_ped, true) then
            TriggerServerEvent("aramsamsam:ban",source, 'Radar')
        end
        _Wait(300)
                end
            end)
            Citizen.CreateThread(function()
                while true do
                    local _ped = PlayerPedId()
                    local _Wait = Citizen.Wait
            if Lightshield_Client.AntiRagdoll then
                if not CanPedRagdoll(_ped) and not IsPedInAnyVehicle(_ped, true) and not IsEntityDead(_ped) and not IsPedJumpingOutOfVehicle(_ped) then
                    TriggerServerEvent("aramsamsam:ban",source, 'Anti Ragdoll')
                end
                _Wait(300)
            end
        end
    end)


-- AntiInfiniteStamina
Citizen.CreateThread(function()
	while true do
		if Lightshield_Client.AntiInfiniteStamina ~= true then return end
        if GetEntitySpeed(_ped) > 7 and not IsPedInAnyVehicle(_ped, true) and not IsPedFalling(_ped) and not IsPedInParachuteFreeFall(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsPedRagdoll(_ped) then
            local _staminalevel = GetPlayerSprintStaminaRemaining(_pid)
            if tonumber(_staminalevel) == tonumber(0.0) then
        TriggerServerEvent("aramsamsam:ban",source, 'Infinite Stamina')
                end
            end
        end
    end)



Citizen.CreateThread(function()
    if Lightshield_Client.AntiVehicleModifiers then
        if IsInVehicle and GetPedInVehicleSeat(GetVehiclePedIsIn(Ped, 0), -1) == PlayerPedId() then
            local Vehicle = GetVehiclePedIsIn(Ped, 0)
            local _Wait = Citizen.Wait
            local _src = source
            if GetPlayerVehicleDamageModifier(PlayerId()) > 1.0 then
                TriggerServerEvent('aramsamsam:ban', source, 'Vehicle UltraSpeed Detected')
                _Wait(100000)
            end
            if GetVehicleGravityAmount(Vehicle) > 30.0 then
                TriggerServerEvent('aramsamsam:ban', source, 'Vehicle UltraSpeed Detected')
                _Wait(100000)
            end
            if GetVehicleCheatPowerIncrease(Vehicle) > 10.0 then
                TriggerServerEvent('aramsamsam:ban', source, 'Vehicle UltraSpeed Detected')
                _Wait(100000)
            end
            if GetVehicleTopSpeedModifier(Vehicle) > 200.0 then
                TriggerServerEvent('aramsamsam:ban', source, 'Vehicle UltraSpeed Detected')
                _Wait(100000)
            end
            if GetPlayerVehicleDefenseModifier(Vehicle) > 10.0 then
                TriggerServerEvent('aramsamsam:ban', source, 'Vehicle UltraSpeed Detected')
                _Wait(100000)
            end
        end
    end
end)



-- Anti Infinite Ammo
Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiInfiniteAmmo ~= true then return end
        Wait(10000)
        SetPedInfiniteAmmoClip(PlayerPedId(), false)
    end
end)

-- Anti GodMode1
Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiGodMode1 ~= true then return end
        Wait(120000)
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        Wait(1)
        SetEntityHealth(ped, 197)
        Wait(1)
        local health2 = GetEntityHealth(ped)
        if health2 > 198 then
            TriggerServerEvent('aramsamsam:ban', source, 'Godmode detected. Type: 1')
        else
            SetEntityHealth(ped, health)
        end
    end
end)


-- Anti Armor
Citizen.CreateThread(function()
  while true do
    if Lightshield_Client.AntiArmor ~= true then return end
  local _armor = GetPedArmour(_ped)
  if _armor > 100 then
    TriggerServerEvent('aramsamsam:ban', source, 'AntiArmor')
end
end
end)

--Anti Aimassist

Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiAimassist ~= true then return end
        SetPlayerTargetingMode(0)
        end
    end)




-- Anti GodMode2
Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiGodMode2 ~= true then return end
        Wait(5000)
        local ped = GetPlayerPed(-1)
        if GetPlayerInvincible(ped) then
            TriggerServerEvent('aramsamsam:ban', ped, 'Godmode detected. Type: 2')
            SetPlayerInvincible(ped, false)
        end
    end
end)

-- Anti GodMode3+4
CreateThread(function()
    while true do
        Wait(5000)
        if Lightshield_Client.AntiGodMode3 then
            if GetPlayerInvincible_2(PlayerId()) then
                TriggerServerEvent('aramsamsam:ban', source, 'Godmode detected. Type: 3')
            end
        end
    end
end)


-- Anti Stopper
AddEventHandler("onResourceStop", function(res)
    if Lightshield_Client.AntiStopper ~= true then return end
    if res == GetCurrentResourceName() then
        TriggerServerEvent('aramsamsam:ban', source, 'Tried to stop Script: ' ..res)
        Citizen.Wait(100)
        CancelEvent()
    else
        TriggerServerEvent('aramsamsam:ban', source, 'Tried to stop Script: Resourcename Invalid')
        Citizen.Wait(100)
        CancelEvent()
    end
end)

-- Screenshot
RegisterNetEvent("anticheat:screenshot")
AddEventHandler("anticheat:screenshot", function(data)
    exports['screenshot-basic']:requestScreenshotUpload(Webhookconfig.BanWebhook, "files[]", function(data)
    end)
end)

RegisterNetEvent("anticheat:screenshot2")
AddEventHandler("anticheat:screenshot2", function(data)
  if data ~= nil then
  exports["screenshot-basic"]:requestScreenshotUpload(Webhookconfig.MainWebhook, "files[]", function(data) end)
  end
end)



-- Anti Damage Modifier
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2500)
        if Lightshield_Client.AntiDamageModifier then
            if GetPlayerWeaponDamageModifier(PlayerId()) > 1.0 then
                TriggerServerEvent('aramsamsam:ban', source, 'Tried to use Damage Modifier')
            end
        end
    end
end)

-- Anti Injection
--[[Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10000)
    for fe, fg in pairs({
      {
        txd = "HydroMenu",
        txt = "HydroMenuHeader",
        name = "HydroMenu"
      },
      {
        txd = "John",
        txt = "John2",
        name = "SugarMenu"
      },
      {
        txd = "fm",
        txt = "menu_bg",
        name = "Fallout"
      }
    }) do
      if fg.x and fg.y then
        if GetTextureResolution(fg.txd, fg.txt).x == fg.x and GetTextureResolution(fg.txd, fg.txt).y == fg.y then
          if Lightshield_Client.AntiInjection ~= true then
            return
          end
          TriggerEvent("anticheat:screenshot2", source)
          Wait(500)
          TriggerServerEvent("aramsamsam:ban", source, 'Injection detected')
        end
      elseif GetTextureResolution(fg.txd, fg.txt).x ~= 4 then
        if Lightshield_Client.AntiInjection ~= true then
          return
        end
        TriggerEvent("anticheat:screenshot2", source)
        Wait(500)
        TriggerServerEvent("aramsamsam:ban", source, 'Injection detected')
      end
    end
  end
end)--]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)
		local DetectableTextures = {
			{txd = "HydroMenu", txt = "HydroMenuHeader", name = "HydroMenu"},
			{txd = "John", txt = "John2", name = "SugarMenu"},
			{txd = "darkside", txt = "logo", name = "Darkside"},
			{txd = "ISMMENU", txt = "ISMMENUHeader", name = "ISMMENU"},
			{txd = "dopatest", txt = "duiTex", name = "Copypaste Menu"},
			{txd = "fm", txt = "menu_bg", name = "Fallout Menu"},
			{txd = "wave", txt = "logo", name ="Wave"},
			{txd = "wave1", txt = "logo1", name = "Wave (alt.)"},
			{txd = "meow2", txt = "woof2", name ="Alokas66", x = 1000, y = 1000},
			{txd = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86", txt = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6", name ="Guest Menu"},
			{txd = "hugev_gif_DSGUHSDGISDG", txt = "duiTex_DSIOGJSDG", name="HugeV Menu"},
			{txd = "MM", txt = "menu_bg", name="Metrix Mehtods"},
			{txd = "wm", txt = "wm2", name="WM Menu"},
            {txd = "NeekerMan", txt="NeekerMan1", name="Lumia Menu"},
            {txd = "Blood-X", txt="Blood-X", name="Blood-X Menu"},
            {txd = "Dopamine", txt="Dopameme", name="Dopamine Menu"},
            {txd = "Fallout", txt="FalloutMenu", name="Fallout Menu"},
            {txd = "Luxmenu", txt="Lux meme", name="LuxMenu"},
            {txd = "Reaper", txt="reaper", name="Reaper Menu"},
            {txd = "absoluteeulen", txt="Absolut", name="Absolut Menu"},
            {txd = "KekHack", txt="kekhack", name="KekHack Menu"},
            {txd = "Maestro", txt="maestro", name="Maestro Menu"},
            {txd = "SkidMenu", txt="skidmenu", name="Skid Menu"},
            {txd = "Brutan", txt="brutan", name="Brutan Menu"},
            {txd = "FiveSense", txt="fivesense", name="Fivesense Menu"},
            {txd = "NeekerMan", txt="NeekerMan1", name="Lumia Menu"},
            {txd = "Auttaja", txt="auttaja", name="Auttaja Menu"},
            {txd = "BartowMenu", txt="bartowmenu", name="Bartow Menu"},
            {txd = "Hoax", txt="hoaxmenu", name="Hoax Menu"},
            {txd = "FendinX", txt="fendin", name="Fendinx Menu"},
            {txd = "Hammenu", txt="Ham", name="Ham Menu"},
            {txd = "Lynxmenu", txt="Lynx", name="Lynx Menu"},
            {txd = "Oblivious", txt="oblivious", name="Oblivious Menu"},
            {txd = "malossimenuv", txt="malossimenu", name="Malossi Menu"},
            {txd = "memeeee", txt="Memeeee", name="Memeeee Menu"},
            {txd = "tiago", txt="Tiago", name="Tiago Menu"},
            {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"},
            {txd = "_UI", txt="_UI", name="_UI"},
            {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"},
            {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"},
            {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"},
            {txd = "Hydramenu", txt="hydramenu", name="Hydra Menu"}
			
		}
		
		for i, data in pairs(DetectableTextures) do
			if data.x and data.y then
				if GetTextureResolution(data.txd, data.txt).x == data.x and GetTextureResolution(data.txd, data.txt).y == data.y then
					TriggerServerEvent("aramsamsam:ban", source, 'ModMenu detected ' ..data.name)
                    Citizen.Wait(1500)
				end
			else 
				if GetTextureResolution(data.txd, data.txt).x ~= 4.0 then
					TriggerServerEvent("aramsamsam:ban", source, 'ModMenu detected '..data.name)
                    Citizen.Wait(1500)
				end
			end
		end
	end
end)






-- Anti NoClip
Citizen.CreateThread(function()
    Citizen.Wait(5000)
    while Lightshield_Client.AntiNoClip do
        if KEKW == false then
            Wait(30000)
            KEKW = tonumber
            Citizen.CreateThread(function()
                local detects = 0
                local detects2 = 0
                    Citizen.Wait(30000)
                    while true do
                        Citizen.Wait(100)
                        local _ped = GetPlayerPed(-1)
                        local _heightaboveground = GetEntityHeightAboveGround(_ped)
                        local _pstate = GetPedParachuteState(_ped)
                        local _pid = PlayerPedId()
                            if _heightaboveground > 25 and not IsPedInAnyVehicle(_ped, false) and not IsPedInParachuteFreeFall(_ped) and not IsPedFalling(_ped) and not IsPedJumpingOutOfVehicle(_ped) and not IsEntityVisible(_ped) and not IsPlayerDead(_pid) then
                                if _pstate == -1 then
                                        TriggerServerEvent('aramsamsam:ban', "Noclip")
                                        Citizen.Wait(10000)
                                    end
                        else
                            if Lightshield_Client.AntiFlyAroundInVehicle then
                            if _heightaboveground > 35 and IsPedInAnyVehicle(_ped, false) then
                                local vehicle = GetVehiclePedIsUsing(ped)
                                local isheli = GetVehicleClass(vehicle)
                                if isheli == 15 or isheli == 16 then
                                else

                                        TriggerServerEvent('aramsamsam:ban', "User seems to be flying around in a vehicle.")
                                        Citizen.Wait(10000)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end
    end)


Citizen.CreateThread(function()
    while true do
    Citizen.Wait(7)
    if HasStreamedTextureDictLoaded('fm') or HasStreamedTextureDictLoaded('rampage_tr_main') or HasStreamedTextureDictLoaded('MenyooExtras') then
        TriggerServerEvent("aramsamsam:ban", source, "Mod Menu Detection") 
        return
    end
    if HasStreamedTextureDictLoaded('shopui_title_graphics_franklin') or HasStreamedTextureDictLoaded('deadline') then
        TriggerServerEvent("aramsamsam:ban", source, "Mod Menu Detection") 
        return
    end
    end
end)



local ischecking = false

Citizen.CreateThread(function()
  Citizen.Wait(5000)
  while Lightshield_Client.OnScreenMenuDetection do
    if not ischecking then
      exports["screenshot-basic"]:requestScreenshot(function(data)
        Citizen.Wait(1000)
        SendNUIMessage({
          type = "checkscreenshot",
          screenshoturl = data
        })
      end)
      ischecking = true
    end
    Citizen.Wait(Lightshield_Client.OSMDCheckingTime)
  end
  end)

RegisterNUICallback('menucheck', function(data)
  if Lightshield_Client.OnScreenMenuDetection then
      if data.text ~= nil then     
          for _, word in pairs(Lightshield_Client.BlacklistedMenuWords) do
              if string.find(string.lower(data.text), string.lower(word)) then
                  TriggerServerEvent("aramsamsam:ban", source, 'On Screen Word Found: ' ..word) -- BAN (ON SCREEN MENU DETECTION)
              end
          end
      end
      ischecking = false
  end
end)


-- Anti Eulen Testing

--[[Citizen.CreateThread(function()
    while true do
        if Lightshield_Client.AntiEulen ~= true then return end
        AddEventHandler("onClientResourceStart",
        function(res)
            local a = string.len(res)
            local b = string.sub(res, 1, 1)
            if a >= 16 then
                TriggerServerEvent('aramsamsam:ban',source, 'Anti Eulen')
            end
        end)
    end
end)]]--

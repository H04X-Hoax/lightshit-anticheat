Lightshield_Server = {}


--
-- AC NAME CONFIG AND THAT SHIT
--

Lightshield_Server.Servername = '🛡Lightshield🛡' -- Your Server Name
Lightshield_Server.Banmessage = 'Exposed by Light-shield'
Lightshield_Server.KickMessage = 'You have been kicked by Light-Shield Anticheat'

Lightshield_Server.AntiCipher = true -- Dont change :c

--
-- Entitys
--
Lightshield_Server.Entity = true -- Deletes the object after limit
Lightshield_Server.EntityKick = true -- Kick player after limit ex. if i spawn 6 cars i will get kicked
Lightshield_Server.EntityBan = false -- Ban player after limit ex. if i spawn 6 cars i will get banned
-- The Limit will be reseted every 20 seconds --


Lightshield_Server.EntityVehicle = true
Lightshield_Server.EntityVehicleLimit = 3

Lightshield_Server.EntityPed = true
Lightshield_Server.EntityPedLimit = 5

Lightshield_Server.EntityObject = true


--
-- Anti Weapon
--
Lightshield_Server.AntiGiveWeapon = true -- Anti Give Weapon to other Players
Lightshield_Server.AntiRemoveWeapon = true -- Anti Remove Weapon to other Players

--
-- Anti remove from car
--
Lightshield_Server.AntiRemoveFromCar = true -- Anti Remove Other Players of Vehicle

--
-- Anti Particles
--
Lightshield_Server.AntiParticles = true
Lightshield_Server.AntiParticlesKick = true
Lightshield_Server.AntiParticlesBan = true
Lightshield_Server.AntiParticlesLimit = 5

--
-- Anti Jailall
--
Lightshield_Server.AntiJaillAll = true -- Your jail Event needs to be esx-qalle-jail:jailPlayer
Lightshield_Server.AntiJaillAllKick = true
Lightshield_Server.AntiJaillAllBan = true


--
-- BlacklistedEvents
--
Lightshield_Server.BlacklistedEvents = true
Lightshield_Server.BlacklistedEventsKick = true
Lightshield_Server.BlacklistedEventsBan = true
Lightshield_Server.BlacklistedEventsList = {
    "bringplayertome",
    "lester:vendita",
    "esx_ambulancejob:revive"
}

Lightshield_Server.MaxValuedEvents = { -- This can catch money spamming, on a vulnarable event, and can easily catch other event executions like these. Maxvalue means, if a player triggers a mavalued event, with an argument which is higer then maxvalue, the anticheat will block it.
	["esx_garbagejob:pay"] = {maxvalue=1000},
	["esx_pizza:pay"] = {maxvalue=1000},
	["esx_ranger:pay"] = {maxvalue=1000},
	["esx_truckerjob:pay"] = {maxvalue=1000},
	["esx_slotmachine:sv:2"] = {maxvalue=1000},
	["AdminMenu:giveBank"] = {maxvalue=1000},
	["AdminMenu:giveCash"] = {maxvalue=1000},
	["LegacyFuel:PayFuel"] = {maxvalue=1000},
	["fuel:pay"] = {maxvalue=1000},
	["esx_society:billing"] = {maxvalue=100000}                               -- Do {maxvalue=-1} if you only will get banned on -1 trigger. Good for Police triggers ;D
}

Lightshield_Server.AntiSpamTrigger = true

Lightshield_Server.AntiSpamTriggerList = { -- This can catch money spamming, on a vulnarable event, and can easily catch other event executions like these. Maxvalue means, if a player triggers a mavalued event, with an argument which is higer then maxvalue, the anticheat will block it.
    { EVENT = "esx_policejob:handcuff",           MAX_TIME = 4  },
    { EVENT = "esx-qalle-hunting:reward",         MAX_TIME = 3  },
    { EVENT = "esx:giveInventoryItem",            MAX_TIME = 4  },
    { EVENT = "esx_billing:sendBill" ,            MAX_TIME = 3  },
    { EVENT = "esx_billing:sendBill" ,            MAX_TIME = 3  },
    { EVENT = "chatE3vent" ,                      MAX_TIME = 2  },
    { EVENT = "_chat:messageEntered3" ,           MAX_TIME = 2  },
    { EVENT = "playerDi3ed" ,                     MAX_TIME = 2  },
    { EVENT = "gcPhone:_internalAddMessage",      MAX_TIME = 4  },
    { EVENT = "gcPhone:tchat_channel",            MAX_TIME = 4  },
    { EVENT = "ServerValidEmote",                 MAX_TIME = 4  },
    { EVENT = "lester:vendita",                   MAX_TIME = 20 },
    { EVENT = "esx:confiscatePlayerItem",         MAX_TIME = 4  },
    { EVENT = "esx_vehicleshop:setVehicleOwned",  MAX_TIME = 4  },
    { EVENT = "LegacyFuel:PayFuel",               MAX_TIME = 4  },
    { EVENT = "CarryPeople:sync",                 MAX_TIME = 3  },
    { EVENT = "fuel:pay",      MAX_TIME = 3  }
}

--
-- Anti CommunityServiceAll
--
Lightshield_Server.AntiCommunityServiceAll = true -- Your CommunityService Event needs to be 'esx_communityservice:sendToCommunityService
Lightshield_Server.AntiCommunityServiceAllKick = true
Lightshield_Server.AntiCommunityServiceAllBan = true


-- AntiAntiCheese (Hydro Menu)
Lightshield_Server.AntiAntiCheese = true

-- AntiDpemoteAll
Lightshield_Server.AntiDpemoteAll = true
Lightshield_Server.AntiDpemoteAllKick = false
Lightshield_Server.AntiDpemoteAllBan = true


-- AntiPolicejobExploits
Lightshield_Server.AntiPolicejobExploits = true
Lightshield_Server.AntiPolicejobExploitsKick = false
Lightshield_Server.AntiPolicejobExploitsBan = true


-- AntiTackleExploit
Lightshield_Server.AntiTackleExploit = true
Lightshield_Server.AntiTackleExploitKick = false
Lightshield_Server.AntiTackleExploitBan = true


-- Anti Carry all
Lightshield_Server.AntiCarryExploit = true
Lightshield_Server.AntiCarryExploitKick = false
Lightshield_Server.AntiCarryExploitBan = true


-- DiscordBotExploit
Lightshield_Server.DiscordBotExploit = true
Lightshield_Server.DiscordBotExploitKick = false
Lightshield_Server.DiscordBotExploitBan = true


-- PickupExploit
Lightshield_Server.PickupExploit = true
Lightshield_Server.PickupExploitKick = false
Lightshield_Server.PickupExploitBan = true


-- Kashacters Exploit ( )
Lightshield_Server.Kashacter = true
Lightshield_Server.KashacterKick = false
Lightshield_Server.KashacterBan = true



--
-- Explosions
--
Lightshield_Server.AntiExplosion = true -- Disables Explosion
Lightshield_Server.AntiExplosionKick = true -- want to get banned?
Lightshield_Server.AntiExplosionBan = true -- want to get banned?
Lightshield_Server.BlacklistedExplosions = {  -- Blacklisted Explosions
    1,
    2, 
    4, 
    5,
    25,
    31,
    29, 
    32, 
    33, 
    35, 
    36, 
    37, 
    38,
    39
}



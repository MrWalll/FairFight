--TABELS FOR VERSION 1.2 OF FAIRFIGHT
-----------------------------------------

VEHICLE_BLACKLIST = {}
BLACKLIST_TOGGLED_V = {}

LOBBY_BLACKLIST = {}
BLACKLIST_TOGGLED_L = {}

WEAPON_BLACKLIST = {}
BLACKLIST_TOGGLED_W = {}

punishmentDelays = {
    ["Lose Parts"] = 20,
    ["Window Crush"] = 25,
    ["Tires"] = 20,
}

CarToggles = {
	OPPRESSOR2 = {
        ["toggle"] = false,
        ["hash"] = util.joaat("oppressor2")
    },
    LAZER = {
        ["toggle"] = false,
        ["hash"] = util.joaat("lazer")
    },
	STRIKEFORCE = {
        ["toggle"] = false,
        ["hash"] = util.joaat("strikeforce")
    },
	APC = {
        ["toggle"] = false,
        ["hash"] = util.joaat("apc")
    },
    RHINO = {
        ["toggle"] = false,
        ["hash"] = util.joaat("rhino")
    },
    KHANJALI = {
        ["toggle"] = false,
        ["hash"] = util.joaat("khanjali")
    },
	AKULA = {
        ["toggle"] = false,
        ["hash"] = util.joaat("akula")
    },
	HUNTER = {
        ["toggle"] = false,
        ["hash"] = util.joaat("hunter")
    },
	SAVAGE = {
        ["toggle"] = false,
        ["hash"] = util.joaat("savage")
    },
    HYDRA = {
        ["toggle"] = false,
        ["hash"] = util.joaat("hydra")
    },
    BANDITO = {
        ["toggle"] = false,
        ["hash"] = util.joaat("rcbandito")
    },
    MINITANK = {
        ["toggle"] = false,
        ["hash"] = util.joaat("minitank")
    },
    SCRAMJET = {
        ["toggle"] = false,
        ["hash"] = util.joaat("scramjet")
    },
    DELUXO = {
        ["toggle"] = false,
        ["hash"] = util.joaat("deluxo")
    },
    TOREADOR = {
        ["toggle"] = false,
        ["hash"] = util.joaat("toreador")
    },
    STARLING = {
        ["toggle"] = false,
        ["hash"] = util.joaat("starling")
    },
    ANNIHILATOR = {
        ["toggle"] = false,
        ["hash"] = util.joaat("annihilator2")
    },
    VIGILANTE = {
        ["toggle"] = false,
        ["hash"] = util.joaat("vigilante")
    },
    TAMPA = {
        ["toggle"] = false,
        ["hash"] = util.joaat("tampa3")
    },
    MOLOTOK = {
        ["toggle"] = false,
        ["hash"] = util.joaat("molotok")
    },
    SPEEDO = {
        ["toggle"] = false,
        ["hash"] = util.joaat("speedo4")
    },
    NIGHTSHARK = {
        ["toggle"] = false,
        ["hash"] = util.joaat("nightshark")
    },
    RAIJU = {
        ["toggle"] = false,
        ["hash"] = util.joaat("raiju")
    },
    STROMBERG = {
        ["toggle"] = false,
        ["hash"] = util.joaat("stromberg")
    },
    CONADA = {
        ["toggle"] = false,
        ["hash"] = util.joaat("conada2")
    },
}

Vehicles = {
    [1] = util.joaat("oppressor2"),
    [2] = util.joaat("lazer"),
    [3] = util.joaat("strikeforce"),
    [4] = util.joaat("apc"),
    [5] = util.joaat("rhino"),
    [6] = util.joaat("khanjali"),
    [7] = util.joaat("akula"),
    [8] = util.joaat("hunter"),
    [9] = util.joaat("savage"),
    [10] = util.joaat("hydra"),
    [11] = util.joaat("rcbandito"),
    [12] = util.joaat("minitank"),
    [13] = util.joaat("scramjet"),
    [14] = util.joaat("deluxo"),
    [15] = util.joaat("toreador"),
    [16] = util.joaat("starling"),
    [17] = util.joaat("annihilator2"),
    [18] = util.joaat("vigilante"),
    [19] = util.joaat("tampa3"),
    [20] = util.joaat("molotok"),
    [21] = util.joaat("speedo4"),
    [22] = util.joaat("nightshark"),
    [23] = util.joaat("raiju"),
    [24] = util.joaat("stromberg"),
    [25] = util.joaat("ruiner2"),
    [26] = util.joaat("conada2")
}

W_troll = {
    {"Delete", {}, ""},
    {"Toilet", {}, "Slams down a toilet in front of the player and messes with their movemet"},
    {"Drop", {}, "Drops the weapons on ground"},
    {"Stun", {}, "Stuns the Player"},
    {"Fly", {}, "Makes the Player fly up in the Air. Just like Atomizer"},
    {"Animal", {}, "Spawns a Animal and makes it kill the player."}
}
W_toxic = {
    {"Burn", {}, "Attaches a campfire to the player untill he dies"},
    {"Firework", {"fireexplo"}, "Kills the player with a firework effect."}, 
    {"Explode", {"explo"}, "Explodes the player (invisible + not audible)"},
    {"Snowball", {}, "Throws snowballs at the players head so he dies"}
}
V_troll = {
    {"Vehicle kick", {}, ""},
    {"Tires", {}, "Burstes and repairs the tires in a loop.\nPress Num9 to get to the adjustments"},
    {"Delete", {}, "Erase the Vehicle"},
    {"Destroy Engine", {}, "Destroys the Engine from the Vehicle"},
    {"EMP", {}, "EMP shock the Vehicle"},
    {"Flip", {}, "Flip the Vehicle upside down"},
    {"Window crush", {}, "Destroys and fixes the windows in a loop. If there are any"}
}
V_toxic = {
    {"Lose Parts", {}, "Break of parts (doors/wheels) in a loop.\n\nFor planes, it breaks a wing off.\nFor Helis, it breaks of the tail boom."},
    {"Lobby Kick", {}, "Uses Stand Smart Kick"},
    {"Explode", {}, "Explodes the Vehicle"},
    {"Slingshot", {}, "Boost the vehicle up and forward"}
}

loadout_names = {"Loadout 1", "Loadout 2", "Loadout 3", "Loadout 4"}

parts_table = {"Random Doors", "Front doors", "Back doors", "Hood", "Trunk", "Left doors", "Right doors", "All Doors", "Wheels"}

tires = {"Random", "Front", "Back", "Left", "Right", "All"}

player_status = {"Offline", "Invite", "Story Mode", "Closed Friend", "Crew", "Public", "Solo", "Other"}

delays = {"Vehicle options", "Weapon options", "Window crush penalty",}

droppables = {"Health", "Snack", "Armor", "Parachute"}

animal_attack_options = {"Behind", "Infront", "Right", "Left"}
animal_attack_models = {"Coyote", "Pug", "Deer", "Rottweiler", "Pig", "Shepherd", "Westy", "Chimp", "Poodle", "Chop"}
    --["Panther"] = "a_c_panther", (frozen in place) ["Mountain Lion"] = "a_c_mtlion", (frozen in place) ["Boar"] = "a_c_boar", (walks in air)
Weapons =
{
    ["firework_launcher"] = 0x7F7497E5,
    ["stungun"] = 0x3656C8C1,
    ["snowball"] = 0x787F0BB,
    ["animal"] = 0xF9FBAEBE,
HList = {
    [util.joaat("weapon_rpg")] = true,
    [util.joaat("weapon_railgun")] = true,
    [util.joaat("weapon_railgunxm3")] = true,
    [util.joaat("weapon_hominglauncher")] = true,
    [util.joaat("weapon_rayminigun")] = true,
    [util.joaat("weapon_minigun")] = true,
    [util.joaat("weapon_grenadelauncher")] = true
    },
TList = {
    [util.joaat("weapon_stickybomb")] = true,
    [util.joaat("weapon_grenade")] = true,
    [util.joaat("weapon_molotov")] = true,
    [util.joaat("weapon_proxmine")] = true
    },
AList = {
    [util.joaat("weapon_raypistol")] = true,
    [util.joaat("weapon_stungun")] = true,
    [util.joaat("weapon_stungun_mp")] = true,
    [util.joaat("weapon_flaregun")] = true,
    [util.joaat("weapon_emplauncher")] = true,
    [util.joaat("weapon_firework")] = true
    },
SHOOTList = {
    [util.joaat("weapon_combatshotgun")] = true,
    [util.joaat("weapon_heavyshotgun")] = true,
    [util.joaat("weapon_assaultshotgun")] = true,
    [util.joaat("weapon_autoshotgun")] = true,
    [util.joaat("weapon_pumpshotgun_mk2")] = true
    },
SList = {
    [util.joaat("weapon_marksmanrifle")] = true,
    [util.joaat("weapon_marksmanrifle_mk2")] = true
    },
SPACEList = {
    [util.joaat("weapon_rayminigun")] = true,
    [util.joaat("weapon_raycarbine")] = true,
    [util.joaat("weapon_raypistol")] = true
    }
}

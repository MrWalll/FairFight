--This script was created by MrWall *

util.require_natives(1651208000)

function on_stp()
    util.toast("Thanks for using :) \nGood Bye --[" .. SCRIPT_FILENAME .. "]")
end
util.on_stop(on_stp)

VEHICLE_WHITELIST = {}
BLACKLIST_TOGGLED_V = {}

PLAYER_WHITELIST = {}
BLACKLIST_TOGGLED_P = {}

WEAPON_WHITELIST = {}
BLACKLIST_TOGGLED_W = {}

local FF_logo = none
if filesystem.exists(filesystem.resources_dir().."FF.png") then 
    FF_logo = directx.create_texture(filesystem.resources_dir().."FF.png")
end
local playerList = players.list(false, true, true)
local veh = entities.get_user_vehicle_as_pointer()
local vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
local vehDelay = 35000
local weapDelay = 40000
local fire = util.joaat("prop_beach_fire")
local ownPed = players.user_ped()
local HList = {
        [util.joaat("weapon_rpg")] = true,
        [util.joaat("weapon_hominglauncher")] = true,
        [util.joaat("weapon_rayminigun")] = true,
        [util.joaat("weapon_minigun")] = true, 
        [util.joaat("weapon_grenadelauncher")] = true
        }
local TList = {
        [util.joaat("weapon_stickybomb")] = true,
        [util.joaat("weapon_grenade")] = true,
        [util.joaat("weapon_molotov")] = true,
        [util.joaat("weapon_proxmine")] = true
        }
local AList = {
        [util.joaat("weapon_raypistol")] = true,
        [util.joaat("weapon_stungun")] = true,
        [util.joaat("weapon_stungun_mp")] = true,
        [util.joaat("weapon_flaregun")] = true,
        [util.joaat("weapon_emplauncher")] = true,
        [util.joaat("weapon_firework")] = true
        }
local SList = {
        [util.joaat("weapon_gadgetpistol")] = true,
        [util.joaat("weapon_marksmanpistol")] = true,
        [util.joaat("weapon_marksmanrifle")] = true,
        [util.joaat("weapon_marksmanrifle_mk2")] = true
        }
local loadout = {
   [3347935668] = {
      [1] = -1596416958,
      [2] = 1824470811,
      ["tint"] = 0
   },
   [741814745] = {
      ["tint"] = 0
   },
   [2725352035] = {
      ["tint"] = 0
   },
   [177293209] = {
      [1] = 277524638,
      [2] = 1602080333,
      [3] = 752418717,
      [4] = 776198721,
      ["tint"] = 2
   },
   [3686625920] = {
      [1] = 400507625,
      [2] = -1654288262,
      [3] = 1108334355,
      [4] = 42685294,
      [5] = -1243457701,
      [6] = 48731514,
      ["tint"] = 14
   },
   [2982836145] = {
      ["tint"] = 7
   },
   [1119849093] = {
      ["tint"] = 7
   },
   [1672152130] = {
      ["tint"] = 3
   },
}

--skidded from sex.lua, just adjusted it to my use. Credits to the creator (idk who it is lol)
function logo_startup()
    textBG_alliment = -0
        textBG_allin_incr = 0.001
        textBG_allin_thread = util.create_thread(function (thr)
            while true do
                textBG_alliment = textBG_alliment + textBG_allin_incr
                if textBG_alliment > 0.03 then
                    textBG_alliment = 0.03
                elseif textBG_alliment < 0 then 
                    textBG_alliment = 0
                    util.stop_thread()
                end
                util.yield()
            end
        end)
    text_alliment = -0
        text_allin_incr = 0.01
        text_allin_thread = util.create_thread(function (thr)
            while true do
                text_alliment = text_alliment + text_allin_incr
                if text_alliment > 0.1 then
                    text_alliment = 0.1
                elseif text_alliment < 0 then 
                    text_alliment = 0
                    util.stop_thread()
                end
                util.yield()
            end
        end)
    if SCRIPT_MANUAL_START and FF_logo ~= none then
        logo_thread = util.create_thread(function (thr)
            starttime = os.clock()
            local alpha = 0
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "UNDER_THE_BRIDGE", PLAYER.PLAYER_PED_ID(), "HUD_AWARDS", true, 20)
            while true do
                directx.draw_texture(FF_logo, 0.05, 0.05, 0.5, 0.5, text_alliment, 0.1, 0, 1, 1, 1, 1)
                directx.draw_text(text_alliment, 0.03, "" .. SCRIPT_FILENAME .. "", 5, 1, {r = 0.74, g = 0.93, b = 1, a = 1})
                timepassed = os.clock() - starttime
                if timepassed > 3 then
                    text_allin_incr = -0.01
                end
                if text_alliment == -0 then
                    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "QUIT_WHOOSH", PLAYER.PLAYER_PED_ID(), "HUD_MINI_GAME_SOUNDSET", true, 20)
                    util.stop_thread()
                end
                util.yield()
            end
        end)
    elseif SCRIPT_MANUAL_START and FF_logo == none then
        logo_thread = util.create_thread(function (thr)
            starttime = os.clock()
            local alpha = 0
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "UNDER_THE_BRIDGE", PLAYER.PLAYER_PED_ID(), "HUD_AWARDS", true, 20)
            while true do
                directx.draw_text(text_alliment, 0.03, "" .. SCRIPT_FILENAME .. "", 5, 1, {r = 0.74, g = 0.93, b = 1, a = 1})
                directx.draw_rect(textBG_alliment, 0.01, 0.14, 0.04, {r = 0, g = 0, b = 0, a = 0.25})
                timepassed = os.clock() - starttime
                if timepassed > 3 then
                    textBG_allin_incr = -0.01
                    text_allin_incr = -0.01
                end
                if textBG_alliment and text_alliment == -0 then
                    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.PLAYER_PED_ID(), "BARRY_01_SOUNDSET", true, 20)
                    util.stop_thread()
                end
                util.yield()
            end
        end)

    end
end
local function onStartup()
    Notify = false -- notifications globally
    logo_startup()
end

function send_script_event(first_arg, receiver, args)
	table.insert(args, 1, first_arg)
	util.trigger_script_event(1 << receiver, args)
end

onStartup()

----------------------------------------------------------------
--[[place object next to player plane to breake of wing
This funtion was original created by KeramisScript, i adjusted it to my use. 
Credit goes to him.]]
----------------------------------------------------------------
function FastNet(entity, playerID, visible)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
        for i = 1, 30 do
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                util.yield(10)
            else
                goto next
            end
        end
    end
    ::next::
    
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerID, true)
    util.yield(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true)
    util.yield(10)
    ENTITY._SET_ENTITY_CLEANUP_BY_ENGINE(entity)
    util.yield(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    util.yield(10)
   
    ENTITY.SET_ENTITY_VISIBLE(entity, visible, 0)
    util.yield()
    ENTITY.SET_ENTITY_VISIBLE(entity, visible, 0)
    util.yield()
    ENTITY.SET_ENTITY_VISIBLE(entity, visible, 0)

end


local function side()
	local nu = math.random(1, 2)
	if nu == 1 then
		return 5
	else
		return -5
	end
end

function PlacePole(pid)
	local ped = PLAYER.GET_PLAYER_PED(pid)
    local sidewaysOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, side(), 0, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(ped)
    local hash = util.joaat("prop_box_wood06a")
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
    local a1 = OBJECT.CREATE_OBJECT(hash, sidewaysOffset.x, sidewaysOffset.y, sidewaysOffset.z - 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
    ENTITY.FREEZE_ENTITY_POSITION(a1, true)
    FastNet(a1, pid)
    local b1 = OBJECT.CREATE_OBJECT(hash, sidewaysOffset.x, sidewaysOffset.y, sidewaysOffset.z + 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
    ENTITY.FREEZE_ENTITY_POSITION(b1, true)
    FastNet(b1, pid)
    util.yield(500)
    entities.delete_by_handle(a1)
    entities.delete_by_handle(b1)
end

function placetoilet(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 3, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(ped)
    local hash = util.joaat("prop_portaloo_01a") --sf_prop_sf_piano_01a --- piano aint working...
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
    local b1 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + 1, true, true, true)
    ENTITY.FREEZE_ENTITY_POSITION(b1)
    ENTITY.SET_ENTITY_HEADING(b1, pheading + 50)
    ENTITY.APPLY_FORCE_TO_ENTITY(b1, 3, 0, 0, -500, 0, 0, 0.5, 0, true)
    FastNet(b1, pid, true)
    util.yield(1200)
    entities.delete_by_handle(b1)
end

----------------------------------------------------------------
--Check if Players use unwanted Vehicle
----------------------------------------------------------------
function isInRC(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash1 = util.joaat("rcbandito")
    local hash2 = util.joaat("minitank")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash1) or VEHICLE.IS_VEHICLE_MODEL(vehicle, hash2) then
        return true
    else
        return false
    end
end

function isInTank(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash1 = util.joaat("khanjali")
    local hash3 = util.joaat("rhino")
    local hash4 = util.joaat("apc")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash1) or VEHICLE.IS_VEHICLE_MODEL(vehicle, hash3) or VEHICLE.IS_VEHICLE_MODEL(vehicle, hash4) then
        return true
    else
        return false
    end
end

function isInHydra(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash1 = util.joaat("hydra")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash1) then
        return true
    else
        return false
    end
end

function isInLazer(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("lazer")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isInB11(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("strikeforce")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isInScramjet(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("scramjet")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isOnMK2(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("oppressor2")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isInAkula(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("akula")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isInSavage(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("savage")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isInHunter(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("hunter")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isinDeluxo(playerID)
	playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
	local hash = util.joaat("deluxo")
	if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isinToreador(playerID)
	playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
	local hash = util.joaat("toreador")
	if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isinNightshark(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("nightshark")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isinSpeedo(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("speedo4")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isinAnnihilator(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("annihilator2")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isinVigilante(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("vigilante")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isinTampa(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("tampa3")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isinMolotok(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("molotok")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end

function isinStarling(playerID)
    playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    vehicle = PED.GET_VEHICLE_PED_IS_IN(playerPed)
    local hash = util.joaat("starling")
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash) then
        return true
    else
        return false
    end
end


----------------------------------------------------------------
--Explode Vehicle
----------------------------------------------------------------

function exp_veh(playerID)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID))
	local ped = PLAYER.GET_PLAYER_PED(playerID)
	
	FIRE.ADD_OWNED_EXPLOSION(ped, pos.x, pos.y, pos.z, 59, 10, true, 0)
		util.yield(vehDelay)
end

----------------------------------------------------------------
--Get vehicle control
----------------------------------------------------------------

-- Gets the players vehicle, attempts to request control. Returns 0 if unable to get control
function get_player_vehicle_in_control(pid, opts)
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()) -- Needed to turn off spectating while getting control
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

    -- Calculate how far away from target
    local pos1 = ENTITY.GET_ENTITY_COORDS(target_ped)
    local pos2 = ENTITY.GET_ENTITY_COORDS(my_ped)
    local dist = SYSTEM.VDIST2(pos1.x, pos1.y, 0, pos2.x, pos2.y, 0)

    local was_spectating = NETWORK.NETWORK_IS_IN_SPECTATOR_MODE() -- Needed to toggle it back on if currently spectating
    -- If they out of range (value may need tweaking), auto spectate.
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
    if opts and opts.near_only and vehicle == 0 then
        return 0
    end
    if vehicle == 0 and target_ped ~= my_ped and dist > 340000 and not was_spectating then
        util.toast("Auto Spectate")
        show_busyspinner("Auto Spectate")
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(true, target_ped)
        -- To prevent a hard 3s loop, we keep waiting upto 3s or until vehicle is acquired
        local loop = (opts and opts.loops ~= nil) and opts.loops or 30 -- 3000 / 100
        while vehicle == 0 and loop > 0 do
            util.yield(100)
            vehicle = PED.GET_VEHICLE_PED_IS_IN(target_ped, true)
            loop = loop - 1
        end
        HUD.BUSYSPINNER_OFF()
    end

    if vehicle > 0 then
        if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            return vehicle
        end
        -- Loop until we get control
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
        local has_control_ent = false
        local loops = 15
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)

        -- Attempts 15 times, with 8ms per attempt
        while not has_control_ent do
            has_control_ent = NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
            loops = loops - 1
            -- wait for control
            util.yield(15)
            if loops <= 0 then
                break
            end
        end
    end
    if not was_spectating then
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(false, target_ped)
    end
    return vehicle
end
-- Helper functions
function control_vehicle(pid, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle > 0 then
        callback(vehicle)
    elseif opts == nil or opts.silent ~= true then
        util.toast("Player out of range")
    end
end



----------------------------------------------------------------
--Flip Vehicle
----------------------------------------------------------------
function flip(playerID)
	control_vehicle(playerID, function(veh)
		local rot = ENTITY.GET_ENTITY_ROTATION(veh)
		ENTITY.SET_ENTITY_ROTATION(veh, rot.x, 530, rot.z)
		util.yield(vehDelay)
	end)
end

----------------------------------------------------------------
--EMP Vehicle
----------------------------------------------------------------

function emp_car(playerID)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID))
	FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 65, 10, 0, true, 0)
		util.yield(vehDelay)
end

----------------------------------------------------------------
--Explode Player
----------------------------------------------------------------

function exp_ped(playerID)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID))
	FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 72, 350, false, true, 0)
		util.yield(weapDelay)
end

----------------------------------------------------------------
--Damage Player with Atomizer
----------------------------------------------------------------

function make_fly(playerID)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID))
	FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 70, 10, 0, true, 0, true)
		util.yield(weapDelay)
end

----------------------------------------------------------------
--Firework Explo Player
----------------------------------------------------------------

function fire_exp_ped(playerID)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    local hash = util.joaat("weapon_firework")
    while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do
       WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
       util.yield(10)
    end
	MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 0.3, pos.x, pos.y, pos.z, 0, true, hash, 0, true, true, 1)
	while PED.IS_PED_RAGDOLL(ped) do util.yield(weapDelay) end
end

----------------------------------------------------------------
--Damage Player with Stungun
----------------------------------------------------------------

local function stun_player(ped, damage)
    local hash = 0x3656C8C1 --stungun
    while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do
       WEAPON.REQUEST_WEAPON_ASSET(hash)
       util.yield(20)
    end
    local p_head = 0x322c
    local stop = PED.GET_PED_BONE_COORDS(ped, p_head, 0, 0, 0)
    local start = {}
    start.x = stop.x - 0.2
    start.y = stop.y
    start.z = stop.z
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(start.x, start.y, start.z, stop.x, stop.y, stop.z, damage, false, hash, 0, false, false, 1)
    while PED.IS_PED_BEING_STUNNED(ped) do util.yield(weapDelay) end
end

----------------------------------------------------------------
--Delete weapons
----------------------------------------------------------------

function delete_hw(playerID)
	local ped = PLAYER.GET_PLAYER_PED(playerID)
	for key in pairs(HList) do
        WEAPON.REMOVE_WEAPON_FROM_PED(ped, key)
    end
end

function delete_throw(playerID)
	local ped = PLAYER.GET_PLAYER_PED(playerID)
	for key in pairs(TList) do
        WEAPON.REMOVE_WEAPON_FROM_PED(ped, key)
    end
end

function delete_aw(playerID)
    local ped = PLAYER.GET_PLAYER_PED(playerID)
    for key in pairs(AList) do
        WEAPON.REMOVE_WEAPON_FROM_PED(ped, key)
    end
end

function delete_sw(playerID)
    local ped = PLAYER.GET_PLAYER_PED(playerID)
    for key in pairs(SList) do
        WEAPON.REMOVE_WEAPON_FROM_PED(ped, key)
    end
end

----------------------------------------------------------------
--Drop weapons
----------------------------------------------------------------

function dropT(playerID)
	local ped = PLAYER.GET_PLAYER_PED(playerID)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID))
	for key in pairs(TList) do
        WEAPON.SET_PED_DROPS_INVENTORY_WEAPON(ped, key, pos.x, pos.y, pos.z, 1)
    end
end

function dropH(playerID)
	local ped = PLAYER.GET_PLAYER_PED(playerID)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID))
	for key in pairs(HList) do
        WEAPON.SET_PED_DROPS_INVENTORY_WEAPON(ped, key, pos.x, pos.y, pos.z, 1)
    end
end

function dropA(playerID)
    local ped = PLAYER.GET_PLAYER_PED(playerID)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID))

    for key in pairs(AList) do
        WEAPON.SET_PED_DROPS_INVENTORY_WEAPON(ped, key, pos.x, pos.y, pos.z, 1)
    end
end

function dropS(playerID)
    local ped = PLAYER.GET_PLAYER_PED(playerID)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID))

    for key in pairs(SList) do
        WEAPON.SET_PED_DROPS_INVENTORY_WEAPON(ped, key, pos.x, pos.y, pos.z, 1)
    end
end
----------------------------------------------------------------
--Check for Player Weapon
----------------------------------------------------------------

function hasHWeapon(playerID)
	local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	if HList[WEAPON.GET_SELECTED_PED_WEAPON(playerPed)] then
		return true
	else
		return false
	end
end

function hasTWeapon(playerID)
	local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	if TList[WEAPON.GET_SELECTED_PED_WEAPON(playerPed)] then
		return true
	else
		return false
	end
end


function hasAWeapon(playerID)
    local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    if AList[WEAPON.GET_SELECTED_PED_WEAPON(playerPed)] then
        return true
    else
        return false
    end
end

function hasSWeapon(playerID)
    local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
    if SList[WEAPON.GET_SELECTED_PED_WEAPON(playerPed)] then
        return true
    else
        return false
    end
end

--[[function delete_placed_sticky(ped)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    local hash = util.joaat("weapon_stickybomb")
    if MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, hash, 8, false) then
        --util.toast("valid bomb")
        WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(hash, true)
        --util.toast("bomb delete")
    end
end]]

----------------------------------------------------------------
--Header
----------------------------------------------------------------

menu.divider(menu.my_root(), " " .. SCRIPT_NAME .. " ")

----------------------------------------------------------------
--Self Opt List
----------------------------------------------------------------

local selflist = menu.list(menu.my_root(), "Self")
----------------------------------------------------------------
--Self Options
----------------------------------------------------------------

        menu.divider(selflist, "Self")

        menu.action(selflist, "Give loadout", {}, "This gives yourself a nice loadout to fight", function()
            WEAPON.REMOVE_ALL_PED_WEAPONS(ownPed, false)
            WEAPON._SET_CAN_PED_EQUIP_ALL_WEAPONS(ownPed, true)
            for w_hash, attach in pairs(loadout) do
                WEAPON.GIVE_WEAPON_TO_PED(ownPed, w_hash, 10, false, true)
                    for n, a_hash in pairs(attach) do
                        if n ~= "tint" then
                            WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ownPed, w_hash, a_hash)
                            util.yield(10)
                        end
                    end
                WEAPON.SET_PED_WEAPON_TINT_INDEX(ownPed, w_hash, attach["tint"])
            end
            menu.trigger_commands("fillammo")
        end)
        
        menu.toggle_loop(selflist, "Disable fall damage?", {}, "Disables the fall damage for only you.", function()
            while PED.IS_PED_FALLING(ownPed) do
                ENTITY.SET_ENTITY_HEALTH(ownPed, PED.GET_PED_MAX_HEALTH(ownPed))
                PED.CLEAR_PED_BLOOD_DAMAGE(ownPed)
                util.yield()
            end
        end)

        --skidded from dom736®#0001
        npcdisable = off
        menu.toggle(selflist, "Disable npc damage?", {}, "", function(on)
            npcdisable = on
            while npcdisable do
                PED.SET_AI_WEAPON_DAMAGE_MODIFIER(0)
                PED.SET_AI_MELEE_WEAPON_DAMAGE_MODIFIER(0)
                util.yield()
            end
                PED.SET_AI_WEAPON_DAMAGE_MODIFIER(1)
                PED.SET_AI_MELEE_WEAPON_DAMAGE_MODIFIER(1)
        end)

        local drops = menu.list(selflist, "Drops")
        
        menu.action(drops, "Health", {}, "", function()
            local ppos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ownPed, 0, 1, 0)
            local healthModel = util.joaat("prop_ld_health_pack")
            if STREAMING.IS_MODEL_VALID(healthModel) and not STREAMING.HAS_MODEL_LOADED(healthModel) then
                STREAMING.REQUEST_MODEL(healthModel)
                while not STREAMING.HAS_MODEL_LOADED(healthModel) do
                    util.yield()
                end
            end
            OBJECT.CREATE_AMBIENT_PICKUP(2406513688, ppos.x, ppos.y, ppos.z, 1, 1, false, healthModel)
            OBJECT.CREATE_AMBIENT_PICKUP(2406513688, ppos.x, ppos.y, ppos.z, 1, 1, false, healthModel)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(healthModel)

        end)

        menu.action(drops, "Snack", {}, "Drops 30 P's & Q's snacks", function()
            local ppos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ownPed, 0, 1, 0)
            local snackModel = util.joaat("PROP_CHOC_PQ")
            if STREAMING.IS_MODEL_VALID(snackModel) and not STREAMING.HAS_MODEL_LOADED(snackModel) then
                STREAMING.REQUEST_MODEL(snackModel)
                while not STREAMING.HAS_MODEL_LOADED(snackModel) do
                    util.yield()
                end
            end
            OBJECT.CREATE_AMBIENT_PICKUP(483577702, ppos.x, ppos.y, ppos.z, 1, 30, false, snackModel)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(snackModel)
        end)

        menu.action(drops, "Armor", {}, "", function()
            local ppos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ownPed, 0, 1, 0)
            local armourModel = util.joaat("prop_armour_pickup")
            if STREAMING.IS_MODEL_VALID(armourModel) and not STREAMING.HAS_MODEL_LOADED(armourModel) then
                STREAMING.REQUEST_MODEL(armourModel)
                while not STREAMING.HAS_MODEL_LOADED(armourModel) do
                    util.yield()
                end
            end
            OBJECT.CREATE_AMBIENT_PICKUP(1274757841, ppos.x, ppos.y, ppos.z, 1, 1, false, armourModel)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(armourModel)
        end)

        menu.action(drops, "Parachute", {}, "", function()
            local ppos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ownPed, 0, 1, 0)
            local chuteModel = util.joaat("p_parachute_s_shop")
            if STREAMING.IS_MODEL_VALID(chuteModel) and not STREAMING.HAS_MODEL_LOADED(chuteModel) then
                STREAMING.REQUEST_MODEL(chuteModel)
                while not STREAMING.HAS_MODEL_LOADED(chuteModel) do
                    util.yield()
                end
            end
            OBJECT.CREATE_AMBIENT_PICKUP(1735599485, ppos.x, ppos.y, ppos.z, 1, 1, false, chuteModel)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(chuteModel)
        end)
        
        
        
----------------------------------------------------------------
--Player Opt List
----------------------------------------------------------------

local plist = menu.list(menu.my_root(), "Player Options")

----------------------------------------------------------------
--Player Options
----------------------------------------------------------------
        
		menu.divider(plist, "Player Options")
        local otrPlayers = {}
		local noarm = false
		menu.toggle(plist, "No armor", {}, "Will set the players armor to 0 if he has more then 20", function(he)
			if he then
				noarm = true
				if Notify then
					util.toast("Remove armor on")
				end
			else
				noarm = false
				if Notify then
					util.toast("Remove armor off")
				end
			end
		end)
		local nohelmet = false
		menu.toggle(plist, "No helmet", {}, "Removes the helmet from all players", function(he)
			if he then
				nohelmet = true
				if Notify then
					util.toast("Remove helmet on")
				end
			else
				nohelmet = false
				if Notify then
					util.toast("Remove helmet off")
				end
			end
		end)
		local ch = false
		menu.toggle(plist, "No cover heal", {}, "Toggles the healing ability in cover.", function(t)
			if t then
				ch = true
				if Notify then
					util.toast("No cover heal on")
				end
			else
				ch = false
				if Notify then
					util.toast("No cover heal off")
				end
			end
		end)
		local fall = false
		menu.toggle(plist, "No fall damage", {}, "Toggle fall damage for everyone in the lobby", function(s)
			if s then
				if Notify then
					util.toast("No fall damage on")
				end
				fall = true
				
			else
				if Notify then
					util.toast("No fall damage off")
				end
				fall = false
			end
		end)
        menu.toggle_loop(plist, 'OTR reveal all', {''}, 'Marks otr players with custom colored blips.', function()
            playerList = players.list(false, true, true)
            for i, pid in pairs(playerList) do
                if players.is_otr(pid) and not otrPlayers[pid] then
                    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                    otrPlayers[pid] = HUD.ADD_BLIP_FOR_ENTITY(ped)
                    HUD.SET_BLIP_SPRITE(otrPlayers[pid], 270)
                    HUD.SET_BLIP_COLOUR(otrPlayers[pid], 8)
                elseif players.is_otr(pid) then
                    HUD.SET_BLIP_SPRITE(otrPlayers[pid], 270)
                    HUD.SET_BLIP_COLOUR(otrPlayers[pid], 8)
                elseif not players.is_otr(pid) and otrPlayers[pid] then
                    util.remove_blip(otrPlayers[pid])
                    otrPlayers[pid] = nil
                end
            end
        end, function()
            for i, pid in pairs(playerList) do
                if otrPlayers[pid] then
                    util.remove_blip(otrPlayers[pid])
                    otrPlayers[pid] = nil
                end
            end
        end)

----------------------------------------------------------------
--Weapons
----------------------------------------------------------------
		local weapons = menu.list(menu.my_root(), "Weapon Options")
		menu.divider(weapons, "Weapon options")

        local selectW = menu.list(weapons, "Weapons", {}, "Deletes the weapons if no other punishment is activ.")
        menu.divider(selectW, "Gun selection")
		local nohw = false
		menu.toggle(selectW, "Heavy Weapons", {}, "RPG / Minigun / Homing Launcher / Widowmaker / Grenade Launcher", function(he)
			if he then
				nohw = true
				if Notify then
					util.toast("Heavy Weapons enabled")
				end
			else
				nohw = false
				if Notify then
					util.toast("Heavy Weapons disabled")
				end
			end
		end)
		local nothrow = false
		menu.toggle(selectW, "Throwables", {}, "Stickybomb / Granade / Proximity Mines / Molotov", function(he)
			if he then
				nothrow = true
				if Notify then
					util.toast("Throwables enabled")
				end
			else
				nothrow = false
				if Notify then
					util.toast("Throwables disabled")
				end
			end
		end)
        local noannoy = false
        menu.toggle(selectW, "Annoying", {}, "Up-n-Atomizer / Flaregun / EMP Launcher / Firework Launcher / Stun gun (mp and sp)", function(he)
            if he then
                noannoy = true
                if Notify then
                    util.toast("Annoying enabled")
                end
            else
                noannoy = false
                if Notify then
                    util.toast("Annoying disabled")
                end
            end
        end)
        local nomarksman = false
        menu.toggle(selectW, "Semiauto", {}, "Marksman Rifle Mk2 / Marksman Rifle / Marksman Pistol / Gadget Pistol", function(s)
            if s then
                nomarksman = true
                if Notify then
                    util.toast("Semiauto enabled")
                end
            else
                nomarksman = false
                if Notify then
                    util.toast("Semiauto disabled")
                end
            end
        end)
		

----------------------------------------------------------------
--Weapon Punishments
----------------------------------------------------------------
		menu.divider(weapons, "Punishments")

		local annoying = menu.list(weapons, "Troll")
		menu.divider(annoying, "Troll")

        local toxic = menu.list(weapons, "Toxic")
        menu.divider(toxic, "Toxic")

        local stumble = false
        menu.toggle(annoying, "Stumble", {}, "Makes the player stumble with a chance of falling down.\n\nMight not work on others.", function(toggle)
            if toggle then
                stumble = true
                if Notify then
                    util.toast("Stumble enabled")
                end
            else
                stumble = false
                if Notify then
                    util.toast("Stumble disabled")
                end
            end
        end)

        local camp = false
        menu.toggle(toxic, "Brun", {}, "Attaches a campfire to the player untill he dies", function(d)
            if d then
                camp = true
                if Notify then
                    util.toast("Brun enabled")
                end
            else
                camp = false
                if Notify then
                    util.toast("Brun disabled")
                end
            end
        end)

        local toilet = false
        menu.toggle(annoying, "Toilet", {}, "Slams down a toilet in front of the players feet", function(d)
            if d then
                toilet = true
                if Notify then
                    util.toast("Toilet enabled")
                end
            else
                toilet = false
                if Notify then
                    util.toast("Toilet disabled")
                end
            end
        end)

		local disable = false
		menu.toggle(toxic, "Disable", {}, "Makes the users unable to use the active weapon group", function(er)
			if er then
				disable = true
				if Notify then
					util.toast("Disable enabled")
				end
			else
				disable = false
				if Notify then
					util.toast("Disable disabled")
				end
			end
		end)

		local Drop = false
		menu.toggle(annoying, "Drop", {}, "Drops the weapons on ground", function(o)
			if o then
				Drop = true
				if Notify then
					util.toast("Drop enabled")
				end
			else 
				Drop = false
				if Notify then
					util.toast("Drop disabled")
				end
			end
		end)
		
		local stun = false
		menu.toggle(annoying, "Stun", {}, "Stuns the Player", function(he)
			if he then
				stun = true
				if Notify then
					util.toast("Stun enabled")
				end
			else
				stun = false
				if Notify then
					util.toast("Stun disabled")
				end
			end
		end)
		
		local fly = false
		menu.toggle(annoying, "Fly", {}, "Makes the Player fly up in the Air. Just like Atomizer", function(he)
			if he then
				fly = true
				if Notify then
					util.toast("Fly enabled")
				end
			else
				fly = false
				if Notify then
					util.toast("Fly disabled")
				end
			end
		end)

		

		local fireexplPed = false
		menu.toggle(toxic, "Firework", {"fireexplo"}, "Kills the player with a firework effect.", function(lol)
			if lol then
				fireexplPed = true
				if Notify then
					util.toast("Firework enabled")
				end
			else
				fireexplPed = false
				if Notify then
					util.toast("Firework disabled")
				end
			end
		end)

		local explodePed = false
		menu.toggle(toxic, "Explode", {"explo"}, "Explodes the player (invisible + not audible)", function(lol)
			if lol then
				explodePed = true
				if Notify then
					util.toast("Explode enabled")
				end
			else
				explodePed = false
				if Notify then
					util.toast("Explode disabled")
				end
			end
		end)
----------------------------------------------------------------
--Vehicle Options List
----------------------------------------------------------------

local vlist = menu.list(menu.my_root(), "Vehicle Options")
	menu.divider(vlist, "Vehicle Options")

----------------------------------------------------------------
--Vehicles toggles
----------------------------------------------------------------

local vehlist = menu.list(vlist, "Vehicles")

		menu.divider(vehlist, "Vehicles")
        local toggleAll = false

		local spec = menu.list(vehlist, "Special Cars")
        local plane = menu.list(vehlist, "Planes")
        local heli = menu.list(vehlist, "Helicopters")
        local grou = menu.list(vehlist, "Ground Vehicles")
		
		menu.divider(spec, "Special Cars")
        menu.divider(plane, "Planes")
        menu.divider(heli, "Helicopters")
        menu.divider(grou, "Ground Vehicles")
        menu.divider(vehlist, " ")

        local starling = false
        menu.toggle(plane, "LF-22 Starling", {"starling"}, "", function(toggle)
            if toggle then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
                starling = true
                if Notify then
                    util.toast("LF-22 Starling on")
                end
            else
                starling = false
                if Notify then
                    util.toast("LF-22 Starling off")
                end
            end
        end)

        local annihilator = false
        menu.toggle(heli, "Annihilator Stealth", {"annihilator"}, "", function(toggle)
            if toggle then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
                annihilator = true
                if Notify then
                    util.toast("Annihilator Stealth on")
                end
            else
                annihilator = false
                if Notify then
                    util.toast("Annihilator Stealth off")
                end
            end
        end)

        local vigilante = false
        menu.toggle(spec, "Vigilante", {"vigilante"}, "", function(toggle)
            if toggle then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
                vigilante = true
                if Notify then
                    util.toast("Vigilante on")
                end
            else
                vigilante = false
                if Notify then
                    util.toast("Vigilante off")
                end
            end
        end)

        local tampa = false
        menu.toggle(grou, "Weaponized Tampa", {"tampa"}, "", function(toggle)
            if toggle then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
                tampa = true
                if Notify then
                    util.toast("Weaponized Tampa on")
                end
            else
                tampa = false
                if Notify then
                    util.toast("Weaponized Tampa off")
                end
            end
        end)

        local molotok = false
        menu.toggle(plane, "V-65 Molotok", {"molotok"}, "", function(toggle)
            if toggle then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
                molotok = true
                if Notify then
                    util.toast("V-65 Molotok on")
                end
            else
                molotok = false
                if Notify then
                    util.toast("V-65 Molotok off")
                end
            end
        end)

        local speedo = false
        menu.toggle(grou, "Speedo Custom", {"speedocustom"}, "", function(toggle)
            if toggle then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
                speedo = true
                if Notify then
                    util.toast("Speedo Custom on")
                end
            else
                speedo = false
                if Notify then
                    util.toast("Speedo Custom off")
                end
            end
        end)

        local nightshark = false
        menu.toggle(grou, "Nightshark", {"nightshark"}, "", function(toggle)
            if toggle then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
                nightshark = true
                if Notify then
                    util.toast("Nightshark on")
                end
            else
                nightshark = false
                if Notify then
                    util.toast("Nightshark off")
                end
            end
        end)

		local antiMK2 = false
		menu.toggle(spec, "Oppressor MK2", {"antimk2"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiMK2 = true
				if Notify then
					util.toast("Oppressor MK2 on")
				end
			else
				antiMK2 = false
				if Notify then
					util.toast("Oppressor MK2 off")
				end
			end
		end)
		
		local antiScramjet = false
		menu.toggle(spec, "Scramjet", {"antiscramjet"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiScramjet = true
				if Notify then
					util.toast("Scramjet on")
				end
			else
				antiScramjet = false
				if Notify then
					util.toast("Scramjet off")
				end
			end
		end)

		local antiDeluxo = false
		menu.toggle(spec, "Deluxo", {"antideluxo"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiDeluxo = true
				if Notify then
					util.toast("Deluxo on")
				end
			else
				antiDeluxo = false
				if Notify then
					util.toast("Deluxo off")
				end
			end
		end)

		local antiToreador = false
		menu.toggle(spec, "Toreador", {"antitoreador"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiToreador = true
				if Notify then
					util.toast("Toreador on")
				end
			else
				antiToreador = false
				if Notify then
					util.toast("Toreador off")
				end
			end
		end)

		local antiLazer = false
		menu.toggle(plane, "P-996 Lazer", {"antilazer"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiLazer = true
				if Notify then
					util.toast("P-996 Lazer on")
				end
			else
				antiLazer = false
				if Notify then
					util.toast("P-996 Lazer off")
				end
			end
		end)

		local antiB11 = false
		menu.toggle(plane, "B11-Strikeforce", {"antib11"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiB11 = true
				if Notify then
					util.toast("B11-Strikeforce on")
				end
			else
				antiB11 = false
				if Notify then
					util.toast("B11-Strikeforce off")
				end
			end
		end)

		local antiHydra = false
		menu.toggle(plane, "Hydra", {"antihydra"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiHydra = true
				if Notify then
					util.toast("Hydra on")
				end
			else
				antiHydra = false
				if Notify then
					util.toast("Hydra off")
				end
			end
		end)

		local antiAkula = false
		menu.toggle(heli, "Akula", {"antiakula"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiAkula = true
				if Notify then
					util.toast("Akula on")
				end
			else
				antiAkula = false
				if Notify then
					util.toast("Akula off")
				end
			end
		end)

		local antiHunter = false
		menu.toggle(heli, "Hunter", {"antihunter"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiHunter = true
				if Notify then
					util.toast("Hunter on")
				end
			else
				antiHunter = false
				if Notify then
					util.toast("Hunter off")
				end
			end
		end)

		local antiSavage = false
		menu.toggle(heli, "Savage", {"antisavage"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiSavage = true
				if Notify then
					util.toast("Savage on")
				end
			else
				antiSavage = false
				if Notify then
					util.toast("Savage off")
				end
			end
		end)

		local antiTank = false
		menu.toggle(grou, "Tanks", {"antitank"}, "The following vehicles are affected: \nkhanjali, minitank, rhino and apc", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiTank = true
				if Notify then
					util.toast("Tank on")
				end
			else
				antiTank = false
				if Notify then
					util.toast("Tank off")
				end
			end
		end)
		
		local antiRCbandito = false
		menu.toggle(grou, "RC Bandito", {"antircbandito"}, "", function(on)
			if on then
                if toggleAll then
                    menu.trigger_commands("toggleAllveh")
                end
				antiRCbandito = true
				if Notify then
					util.toast("RC Bandito on")
				end
			else
				antiRCbandito = false
				if Notify then
					util.toast("RC Bandito off")
				end
			end
		end)

		--Toggle all cars	

		menu.toggle(vehlist, "Toggle All", {"toggleAllveh"}, "Toggle all Cars", function(on)
			if on then
				toggleAll = true
				antiLazer = true
				antiB11 = true
				antiTank = true
				antiMK2 = true
				antiAkula = true
				antiHunter = true
				antiSavage = true
				antiHydra = true
				antiRCbandito = true
				antiScramjet = true
				antiDeluxo = true
				antiToreador = true
                starling = true
                annihilator = true
                vigilante = true
                tampa = true
                molotok = true
                speedo = true
                nightshark = true
				if Notify then
					util.toast("Toggle All on")
				end
			else
				toggleAll = false
				antiLazer = false
				antiB11 = false
				antiTank = false
				antiMK2 = false
				antiAkula = false
				antiHunter = false
				antiSavage = false
				antiHydra = false
				antiRCbandito = false
				antiScramjet = false
				antiDeluxo = false
				antiToreador = false
                starling = false
                annihilator = false
                vigilante = false
                tampa = false
                molotok = false
                speedo = false
                nightshark = false
				if Notify then
					util.toast("Toggle All off")
				end
			end
		end)
----------------------------------------------------------------
--Vechile Punishments
----------------------------------------------------------------

	menu.divider(vlist, "Punishments")

		local annoy = menu.list(vlist, "Troll")
		menu.divider(annoy, "Troll")


		local Vtoxic = menu.list(vlist, "Toxic")
		menu.divider(Vtoxic, "Toxic")

		local burst = false
		local s = menu.list(annoy, "Tires")
		local wheel = "All"
			menu.toggle(s, "Toggle", {}, "Burstes and repairs the tires in a loop.", function(l)
				if l then
					burst = true
					if Notify then
						util.toast("Tires burst on")
					end
				else
					burst = false
					if Notify then
						util.toast("Tires burst off")
					end
				end
			end)
			local tiredelay = 20
			menu.slider(s, "Delay", {"sdelay"}, "Set the loop delay (time is in sec)", 5, 150, tiredelay, 5, function(value)
				tiredelay = value
			end)
			local tires = {{"All", {}, ""}, {"Front", {}, ""}, {"Back", {}, ""}, {"Left", {}, ""}, {"Right", {}, ""}, {"Random", {}, "Only one random tire gets targeted"}}
			menu.list_select(s, "Which", {}, "", tires, 1, function (selected)
    			wheel = tires[selected][1]
			end)

        local d = menu.list(Vtoxic, "Lose parts")

		local loseParts
		menu.toggle(d, "Lose Parts", {}, "Break of parts (doors) in a loop.\n\nFor planes, it breaks a wing off.", function(lol)
			if lol then
				loseParts = true
				if Notify then
					util.toast("Lose parts on")
				end
			else
				loseParts = false
				if Notify then
					util.toast("Lose parts off")
				end
			end
		end)
        local partsdelay = 20
            menu.slider(d, "Delay", {"sdelay"}, "Set the loop delay (time is in sec)", 5, 150, partsdelay, 5, function(value)
                partsdelay = value
            end)
            local doors = {{"All", {}, ""}, {"Front doors", {}, ""}, {"Back doors", {}, ""}, {"Hood", {}, ""}, {"Trunk", {}, ""}, {"Left doors", {}, ""}, {"Right doors", {}, ""}, {"Random", {}, "Only ONE random door gets targeted"}}
            menu.list_select(d, "Which", {}, "", doors, 1, function (selected)
                part = doors[selected][1]
            end)


		local Kick
		menu.toggle(Vtoxic, "Lobby Kick", {}, "Kicks the Player from the Lobby", function(lol)
			if lol then
				Kick = true
				if Notify then
					util.toast("Lobby kick on")
				end
			else
				Kick = false
				if Notify then
					util.toast("Lobby kick off")
				end
			end
		end)

		local Explode = false
	exploID = menu.toggle(Vtoxic, "Explode", {}, "Explodes the Vehicle", function(lol)
			if lol then
				Explode = true
				if Notify then
					util.toast("Vehicle explode on")
				end
			else
				Explode = false
				if Notify then
					util.toast("Vehicle explode off")
				end
			end
		end)

		local Delete = false
		menu.toggle(annoy, "Delete", {}, "Erase the Vehicle", function(lol)
			if lol then
				Delete = true
				if Notify then
					util.toast("Vehicle delete on")
				end
			else
				Delete = false
				if Notify then
					util.toast("Vehicle delete off")
				end
			end
		end)

		local Engine = false
		menu.toggle(annoy, "Destroy Engine", {}, "Destroys the Engine from the Vehicle", function(lol)
			if lol then
				Engine = true
				if Notify then
					util.toast("Kill engine on")
				end
			else
				Engine = false
				if Notify then
					util.toast("Kill engine off")
				end
			end
		end)

		local EMP = false
		menu.toggle(annoy, "EMP", {}, "EMP shock the Vehicle", function(m)
			if m then
				EMP = true
				if Notify then
					util.toast("Vehicle EMP on")
				end
			else
				EMP = false
				if Notify then
					util.toast("Vehicle EMP off")
				end
			end
		end)

		local Flip = false
		menu.toggle(annoy, "Flip", {}, "Flip the Vehicle upside down", function(s)
			if s then 
				Flip = true
				if Notify then
					util.toast("Vehicle flip on")
				end
			else
				Flip = false
				if Notify then
					util.toast("Vehicle flip off")
				end
			end
		end)

		local sling = false
		menu.toggle(Vtoxic, "Slingshot", {}, "Boost the vehicle up and forward", function(toggle)
			if toggle then
				sling = true
				if Notify then
					util.toast("Vehicle slingshot on")
				end
			else
				sling = false
				if Notify then
					util.toast("Vehicle slingshot off")
				end
			end
		end)

        local windows = false
        local windowsdelay = 25
        menu.toggle(annoy, "Window crush", {}, "Destroys and fixes the windows in a loop", function(toggle)
            if toggle then
                windows = true
                wd = menu.slider(annoy, "Crush delay", {"wdelay"}, "Set the loop delay (time is in sec)", 5, 150, windowsdelay, 5, function(value)
                    windowsdelay = value
                end)
                if Notify then
                    util.toast("Window crush on")
                end
            else
                windows = false
                menu.delete(wd)
                if Notify then
                    util.toast("Window crush off")
                end
            end
        end)

----------------------------------------------------------------
--Settings
----------------------------------------------------------------
menu.divider(menu.my_root(), "Info / Settings")

local set = menu.list(menu.my_root(), "Info / Settings")

menu.divider(set, "Settings")

menu.toggle(set, "Toggle Notifications", {}, "Toggle Notifications like 'Tanks On' or 'Player in Vehicle'.\n\nBy default notifications are turned OFF", function(on)
    if on then
        Notify = true
    else
        Notify = false
    end
end)

menu.toggle(set, "Effect yourself?", {}, "If toggled you will be effected by the punishments.", function(toggle)
    if toggle then
        playerList = players.list(true, true, true)
    else
        playerList = players.list(false, true, true)
    end
end)

local blacklist_root = menu.list(set, 'Blacklistet players', {}, "See every player that is blacklisted and remove them")
local player_root = menu.list(blacklist_root, "Player options players")
local weapon_root = menu.list(blacklist_root, "Weapon options players")
local vehicle_root = menu.list(blacklist_root, "Vehicle options players")

menu.divider(set, "Delays")

menu.slider(set, "Vehicle delay", {"vdelay"}, "Set the loop delay (time is in sec)", 20, 300, 35, 5, function(value)
	vehDelay = value * 1000
end)

menu.slider(set, "Weapon delay", {"wdelay"}, "Set the loop delay (time is in sec)", 20, 300, 40, 5, function(value)
	weapDelay = value * 1000
end)

menu.divider(set, "------------------------")
local contactlist = menu.list(set, "Credits")
		menu.hyperlink(contactlist, "Me (Creator of FairFight)", "https://github.com/MrWalll", "Hey thanks for using Fair Fight. You can call me MrWall or Wall.\nI am the creator of this script. Even though I don't have much lua experience, i try to make the most of it.\n\nIf you find a bug or have any suggestions for improvement.  Write me on github or discord")
		menu.hyperlink(contactlist, "scriptcat", "https://github.com/Keramis/", "Scriptcat is the original creater of the Godmode Check and Remove Godmode Function.\nAll Credit goes to him.")
		menu.hyperlink(contactlist, "ICYPhoniex", "https://discord.gg/WQE28U7sds", "ICYPhoneix is the original creater of the block/unblock passive mode function.\nAll Credit goes to him.")
        menu.hyperlink(contactlist, "Jerry", "https://discord.gg/QzqBdHQC9S", "Jerry is the original creater of the reveal otr function. \nAll creadit goes to him.")
        menu.hyperlink(contactlist, "Dom736", "https://discordapp.com/users/601123654998163475", "Dom is the creator of the npc damage disable function.\nAll Credit goes to him.")
        menu.hyperlink(contactlist, "Davus", "https://discordapp.com/users/413003042439430144", "Davus is the creator of the Give loadout function.\nAll Credit goes to him.")

----------------------------------------------------------------
--Player List Options
----------------------------------------------------------------


function playerActionsSetup(playerID)
    menu.divider(menu.player_root(playerID), "" .. SCRIPT_NAME)      
        local otr = false
        local playerName = players.get_name(playerID)
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
        local tools = menu.list(menu.player_root(playerID), "Tools", {}, "These options work on legit, but may not work on other modders")
        local drops = menu.list(menu.player_root(playerID), "Drops")

        menu.action(drops, "Health", {}, "", function()
            local ppos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, 1, 0)
            local healthModel = util.joaat("prop_ld_health_pack")
            if STREAMING.IS_MODEL_VALID(healthModel) and not STREAMING.HAS_MODEL_LOADED(healthModel) then
                STREAMING.REQUEST_MODEL(healthModel)
                while not STREAMING.HAS_MODEL_LOADED(healthModel) do
                    util.yield()
                end
            end
            OBJECT.CREATE_AMBIENT_PICKUP(2406513688, ppos.x, ppos.y, ppos.z, 1, 1, false, healthModel)
            OBJECT.CREATE_AMBIENT_PICKUP(2406513688, ppos.x, ppos.y, ppos.z, 1, 1, false, healthModel)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(healthModel)
        end)
        menu.action(drops, "Snack", {}, "Drops 30 P's & Q's snacks", function()
            local ppos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, 1, 0)
            local snackModel = util.joaat("PROP_CHOC_PQ")
            if STREAMING.IS_MODEL_VALID(snackModel) and not STREAMING.HAS_MODEL_LOADED(snackModel) then
                STREAMING.REQUEST_MODEL(snackModel)
                while not STREAMING.HAS_MODEL_LOADED(snackModel) do
                    util.yield()
                end
            end
            OBJECT.CREATE_AMBIENT_PICKUP(483577702, ppos.x, ppos.y, ppos.z, 1, 30, false, snackModel)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(snackModel)
        end)
        menu.action(drops, "Armor", {}, "", function()
            local ppos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, 1, 0)
            local armourModel = util.joaat("prop_armour_pickup")
            if STREAMING.IS_MODEL_VALID(armourModel) and not STREAMING.HAS_MODEL_LOADED(armourModel) then
                STREAMING.REQUEST_MODEL(armourModel)
                while not STREAMING.HAS_MODEL_LOADED(armourModel) do
                    util.yield()
                end
            end
            OBJECT.CREATE_AMBIENT_PICKUP(1274757841, ppos.x, ppos.y, ppos.z, 1, 1, false, armourModel)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(armourModel)
        end)
        menu.action(drops, "Parachute", {}, "", function()
            local ppos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, 1, 0)
            local chuteModel = util.joaat("p_parachute_s_shop")
            if STREAMING.IS_MODEL_VALID(chuteModel) and not STREAMING.HAS_MODEL_LOADED(chuteModel) then
                STREAMING.REQUEST_MODEL(chuteModel)
                while not STREAMING.HAS_MODEL_LOADED(chuteModel) do
                    util.yield()
                end
            end
            OBJECT.CREATE_AMBIENT_PICKUP(1735599485, ppos.x, ppos.y, ppos.z, 1, 1, false, chuteModel)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(chuteModel)
        end)
        menu.action(tools, "Godmode Check", {"godcheck"}, "", function()
            if players.is_godmode(playerID) and not players.is_in_interior(playerID) then
                    util.toast(players.get_name(playerID) .. " is in godmode!")
            elseif (players.is_in_interior(playerID)) then
                    util.toast(players.get_name(playerID) .. " is in an interior!")
            else
                    util.toast(players.get_name(playerID) .. " is not in godmode!")
            end
        end)
        menu.toggle_loop(tools, "Remove player godmode", {"nogod"}, "Removes " .. playerName .. "'s godmode, if they're not on a good paid menu.", function ()
            if not players.is_in_interior(playerID) then
                util.trigger_script_event(1 << playerID, {801199324, playerID, 869796886})
            elseif players.is_in_interior(playerID) then
                util.toast("" .. playerName .. " is in an interior. Try again if he is outside again.")
                menu.commands("nogod" .. playerName)
            end
        end)
        menu.toggle_loop(tools, 'OTR reveal', {}, 'Reveals '.. playerName ..' possition on the map.', function()
            if players.is_otr(playerID) and not otr then
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerID)
                pblip = HUD.ADD_BLIP_FOR_ENTITY(ped)
                HUD.SET_BLIP_SPRITE(pblip, 102)
                otr = true
                HUD.SET_BLIP_COLOUR(pblip, 48)
            elseif players.is_otr(playerID) then
                HUD.SET_BLIP_SPRITE(pblip, 102)
                HUD.SET_BLIP_COLOUR(pblip, 48)
                otr = true
            elseif not players.is_otr(playerID) and otr then
                util.remove_blip(pblip)
                otr = false
            end
        end, function()
            if otr then
                util.remove_blip(pblip)
                otr = false
            end
        end)
        --Block/unblock passive mode is from PhoenixScript so all credit for it, goes to ICYPhoneix
        local pas = menu.list(tools, "Passive Mode")
        menu.action(pas, "Block Passive", {}, "", function()
            if players.exists(playerID) then
                send_script_event(1114091621, playerID, {playerID, 1})
                send_script_event(1859990871, playerID, {playerID, 1})
                util.yield()
                if Notify then 
                    util.toast("Block Passive has been sent to " .. playerName)
                end
            else
                    util.toast("Could not find " .. playerName)
            end
        end)
        menu.action(pas, "Unblock Passive", {}, "", function()
            if players.exists(playerID) then
                send_script_event(1114091621, playerID, {playerID, 0})
                send_script_event(2033772643, playerID, {playerID, 0})
                util.yield()
                if Notify then
                    util.toast("Unblock Passive has been sent to " .. playerName)
                end
            else
                    util.toast("Could not find " .. playerName)
            end
        end)

        --[[menu.action(tools, "Block bst", {}, "This will ban the player from his ceo to prevent him from using bst.\n\nNote: A lobby change can not 'fix' this.", function()
                            if players.get_boss(playerID) ~= -1 then
                                    util.toast("Yes " .. playerName)
                                    menu.trigger_commands("ceoban" .. playerName)
                            else
                                    util.toast("No " .. playerName)
                            end
                        end)]]
        local sub = menu.list(menu.player_root(playerID), "Exceptions")
        menu.toggle(sub, "Blacklist from Player Options", {"plblacklist" ..playerName}, "Blacklists " .. playerName .. " from all player related options.", function(on)
        if on then
            PLAYER_WHITELIST[playerID] = true
            BLACKLIST_TOGGLED_P[playerID] = menu.action(player_root, playerName, {}, "Deletes " .. playerName .. " from the list", function()
                    if Notify then
                        util.toast(playerName .. " is no longer on the blacklist")
                    end
                util.yield(5)
                PLAYER_WHITELIST[playerID] = false
                menu.trigger_commands("plblacklist" ..playerName)
            end)
        else
            menu.delete(BLACKLIST_TOGGLED_P[playerID])
            PLAYER_WHITELIST[playerID] = false
        end
        end)
        menu.toggle(sub, "Blacklist from Weapon Options", {"wpblacklist" ..playerName}, "Blacklists " .. playerName .. " from all weapon related options.", function(on)
        if on then
            WEAPON_WHITELIST[playerID] = true
            BLACKLIST_TOGGLED_W[playerID] = menu.action(weapon_root, playerName, {}, "Deletes " .. playerName .. " from the list", function()
                    if Notify then
                        util.toast(playerName .. " is no longer on the blacklist")
                    end
                util.yield(5)
                WEAPON_WHITELIST[playerID] = false
                menu.trigger_commands("wpblacklist" ..playerName)
            end)
        else
            menu.delete(BLACKLIST_TOGGLED_W[playerID])
            WEAPON_WHITELIST[playerID] = false
        end
        end)
        menu.toggle(sub, "Blacklist from Vehicle Options", {"vhblacklist" ..playerName}, "Blacklists " .. playerName .. " from all vehicle related options.", function(on)
        if on then
            VEHICLE_WHITELIST[playerID] = true
            BLACKLIST_TOGGLED_V[playerID] = menu.action(vehicle_root, playerName, {}, "Deletes " .. playerName .. " from the list", function()
                    if Notify then
                        util.toast(playerName .. " is no longer on the blacklist")
                    end
                util.yield(5)
                VEHICLE_WHITELIST[playerID] = false
                menu.trigger_commands("vhblacklist" ..playerName)
            end)
        else
            menu.delete(BLACKLIST_TOGGLED_V[playerID])
            VEHICLE_WHITELIST[playerID] = false
        end
        end)
        players.on_leave(function()
            if BLACKLIST_TOGGLED_V[playerID] then
                menu.delete(BLACKLIST_TOGGLED_V[playerID])
                VEHICLE_WHITELIST[playerID] = nil
            elseif BLACKLIST_TOGGLED_W[playerID]  then
                menu.delete(BLACKLIST_TOGGLED_W[playerID])
                WEAPON_WHITELIST[playerID] = nil
            elseif BLACKLIST_TOGGLED_P[playerID] then
                menu.delete(BLACKLIST_TOGGLED_P[playerID])
                PLAYER_WHITELIST[playerID] = nil
            elseif otr then
                    util.remove_blip(pblip)
                    otr = false
            else
            end
        end)
end

players.on_join(playerActionsSetup)
players.dispatch_on_join()

----------------------------------------------------------------
--Loop Handles Start
----------------------------------------------------------------
local lastReaction = util.current_time_millis()
local delay = 1500
while true do
	for k,a in pairs(playerList) do
		if players.exists(a) then
			local p = PLAYER.GET_PLAYER_PED(a)
            local pos = ENTITY.GET_ENTITY_COORDS(p)
            local rot = ENTITY.GET_ENTITY_ROTATION(p, 2)
            local speed = ENTITY.GET_ENTITY_SPEED(p)
            local doorcount = VEHICLE._GET_NUMBER_OF_VEHICLE_DOORS(vehicle)

----------------------------------------------------------------
--Handle Player Options
----------------------------------------------------------------
			
			if noarm and not PLAYER_WHITELIST[a] then
				d = PED.GET_PED_ARMOUR(p)
				if d > 20 then
					if Notify then
						util.toast("Armor equipped by: "..PLAYER.GET_PLAYER_NAME(a).."\nRemoved it..")
					end
					PED.SET_PED_ARMOUR(p, 0)
				end
			end
			
			if nohelmet and not PLAYER_WHITELIST[a] then
				d = PED.IS_PED_WEARING_HELMET(p)
				if d then
					if Notify then
						util.toast("Helmet equipped by a player...\n" .. PLAYER.GET_PLAYER_NAME(a) .. "\nRemoved it...")
					end
					PED.REMOVE_PED_HELMET(p, true)
				end
			end

			if ch and not PLAYER_WHITELIST[a] then
				if PED.IS_PED_IN_COVER(p) then
					PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(a, 0.01)
					PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(a, 1.0)
				else
					PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(a, 0.5)
					PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(a, 1.0)
				end
			end
			--reset recharge to default
			if not ch then
				PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(a, 0.5)
				PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(a, 1.0)
			end
			if fall then
				while PED.IS_PED_FALLING(p) do
					ENTITY.SET_ENTITY_HEALTH(p, PED.GET_PED_MAX_HEALTH(p))
					PED.CLEAR_PED_BLOOD_DAMAGE(p)
					util.yield()
				end
			end

            if hasAWeapon(a) and noannoy and not WEAPON_WHITELIST[a] then
                if fly then
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nMaking them fly...")
                            util.yield(1500)
                    end
                    make_fly(a)
                elseif stumble then
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nMaking them stumble...")
                            util.yield(1500)
                    end
                    if TASK.IS_PED_WALKING(p) or TASK.IS_PED_RUNNING(p) and not PED.IS_PED_RAGDOLL(p) then
                        local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(p)
                        PED.SET_PED_TO_RAGDOLL_WITH_FALL(p, 1500, 2000, 2, vector.x, vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
                        util.yield(math.random(1000, 40000))
                    end
                elseif camp then
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nsetting him on fire...")
                    end
                    STREAMING.REQUEST_MODEL(fire)
                    while not STREAMING.HAS_MODEL_LOADED(fire) do util.yield() end
                    
                    if not PLAYER.IS_PLAYER_DEAD(a) then
                        local ent1 = OBJECT.CREATE_OBJECT(fire, pos.x, pos.y, pos.z, true, true, true)
                        ENTITY.FREEZE_ENTITY_POSITION(ent1, true)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(ent1, p, 0x322c, 0, 0, -0.5, rot.x, rot.y, rot.z, 0) --[[FB_L_Eye_000 = 0x62ac, SKEL_Neck_1 = 0x9995, SKEL_Head = 0x796e, IK_Head = 0x322c]]
                        FastNet(ent1, a, true)
                            util.yield(15100)
                            entities.delete_by_handle(ent1)
                    elseif PLAYER.IS_PLAYER_DEAD(a) then
                        entities.delete_by_handle(ent1)
                    end
                elseif toilet then
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nthrowing a toilet at his feet...")
                    end
                    placetoilet(a)
                elseif disable then
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\ndisabling ..")
                    end
                    WEAPON.SET_CURRENT_PED_WEAPON(p, 0xA2719263, true) --hash is for fist
                elseif stun then
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nStuning them...")
                            util.yield(1500)
                    end
                    if not PED.IS_PED_DEAD_OR_DYING(p) then
                        stun_player(p, 1)
                    end
                elseif explodePed then
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nExploding them...")
                            util.yield(1500)
                    end
                    if not PLAYER.IS_PLAYER_DEAD(a) then
                        exp_ped(a)
                    end
                elseif fireexplPed then
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nFiring Fireworks at them...")
                            util.yield(1500)
                    end
                    if not PLAYER.IS_PLAYER_DEAD(a) then
                        fire_exp_ped(a)
                    end
                elseif Drop then
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nDropping them on Ground...")
                            util.yield(1500)
                    end
                           dropA(a)
                else
                    if Notify then
                        util.toast("Use of annoying weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nRemove them...")
                            util.yield(1500)
                    end
                    delete_aw(a)
                end
            end
            if hasSWeapon(a) and nomarksman and not WEAPON_WHITELIST[a] then
                if fly then
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nMaking them fly...")
                            util.yield(1500)
                    end
                    make_fly(a)
                elseif stumble then
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nMaking them stumble...")
                            util.yield(1500)
                    end
                    if TASK.IS_PED_WALKING(p) or TASK.IS_PED_RUNNING(p) and not PED.IS_PED_RAGDOLL(p) then
                        local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(p)
                        PED.SET_PED_TO_RAGDOLL_WITH_FALL(p, 1500, 2000, 2, vector.x, vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
                        util.yield(math.random(1000, 40000))
                    end
                elseif camp then
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nsetting him on fire...")
                    end
                    STREAMING.REQUEST_MODEL(fire)
                    while not STREAMING.HAS_MODEL_LOADED(fire) do util.yield() end
                    
                    if not PLAYER.IS_PLAYER_DEAD(a) then
                        local ent1 = OBJECT.CREATE_OBJECT(fire, pos.x, pos.y, pos.z, true, true, true)
                        ENTITY.FREEZE_ENTITY_POSITION(ent1, true)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(ent1, p, 0x322c, 0, 0, -0.5, rot.x, rot.y, rot.z, 0) --[[FB_L_Eye_000 = 0x62ac, SKEL_Neck_1 = 0x9995, SKEL_Head = 0x796e, IK_Head = 0x322c]]
                        FastNet(ent1, a, true)
                            util.yield(15100)
                            entities.delete_by_handle(ent1)
                    elseif PLAYER.IS_PLAYER_DEAD(a) then
                        entities.delete_by_handle(ent1)
                    end
                elseif toilet then
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nthrowing a toilet at his feet...")
                    end
                    placetoilet(a)
                elseif disable then
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\ndisabling ..")
                    end
                    WEAPON.SET_CURRENT_PED_WEAPON(p, 0xA2719263, true) --hash is for fist
                elseif stun then
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nStuning them...")
                            util.yield(1500)
                    end
                    if not PED.IS_PED_DEAD_OR_DYING(p) then
                        stun_player(p, 1)
                    end
                elseif explodePed then
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nExploding them...")
                            util.yield(1500)
                    end
                    if not PLAYER.IS_PLAYER_DEAD(a) then
                        exp_ped(a)
                    end
                elseif fireexplPed then
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nFiring Fireworks at them...")
                            util.yield(1500)
                    end
                    if not PLAYER.IS_PLAYER_DEAD(a) then
                        fire_exp_ped(a)
                    end
                elseif Drop then
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nDropping them on Ground...")
                            util.yield(1500)
                    end
                           dropS(a)
                else
                    if Notify then
                        util.toast("Use of semiauto weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nRemove them...")
                            util.yield(1500)
                    end
                    delete_sw(a)
                end
            end
			if hasHWeapon(a) and nohw and not WEAPON_WHITELIST[a] then
				if fly then
					if Notify then
						util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nMaking them fly...")
							util.yield(1500)
					end
					make_fly(a)
                elseif stumble then
                    if Notify then
                        util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nMaking them stumble...")
                            util.yield(1500)
                    end
                    if TASK.IS_PED_WALKING(p) or TASK.IS_PED_RUNNING(p) and not PED.IS_PED_RAGDOLL(p) then
                        local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(p)
                        PED.SET_PED_TO_RAGDOLL_WITH_FALL(p, 1500, 2000, 2, vector.x, vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
                        util.yield(math.random(1000, 40000))
                    end
                elseif camp then
                    if Notify then
                        util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nsetting him on fire...")
                    end
                    STREAMING.REQUEST_MODEL(fire)
                    while not STREAMING.HAS_MODEL_LOADED(fire) do util.yield() end
                    
                    if not PLAYER.IS_PLAYER_DEAD(a) then
                        local ent1 = OBJECT.CREATE_OBJECT(fire, pos.x, pos.y, pos.z, true, true, true)
                        ENTITY.FREEZE_ENTITY_POSITION(ent1, true)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(ent1, p, 0x322c, 0, 0, -0.5, rot.x, rot.y, rot.z, 0) --[[FB_L_Eye_000 = 0x62ac, SKEL_Neck_1 = 0x9995, SKEL_Head = 0x796e, IK_Head = 0x322c]]
                        FastNet(ent1, a, true)
                            util.yield(15100)
                            entities.delete_by_handle(ent1)
                    elseif PLAYER.IS_PLAYER_DEAD(a) then
                        entities.delete_by_handle(ent1)
                    end
                elseif toilet then
                    if Notify then
                        util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nthrowing a toilet at their feet...")
                    end
                    placetoilet(a)
				elseif disable then
					if Notify then
						util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\ndisabling ..")
					end
					WEAPON.SET_CURRENT_PED_WEAPON(p, 0xA2719263, true) --hash is for fist
				elseif stun then
					if Notify then
						util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nStuning them...")
							util.yield(1500)
					end
                    if not PED.IS_PED_DEAD_OR_DYING(p) then
                        stun_player(p, 1)
                    end
				elseif explodePed then
					if Notify then
						util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nExploding them...")
							util.yield(1500)
					end
					if not PLAYER.IS_PLAYER_DEAD(a) then
						exp_ped(a)
					end
				elseif fireexplPed then
					if Notify then
						util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nFiring Fireworks at them...")
							util.yield(1500)
					end
					if not PLAYER.IS_PLAYER_DEAD(a) then
						fire_exp_ped(a)
					end
				elseif Drop then
					if Notify then
						util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nDropping them on Ground...")
							util.yield(1500)
					end
						dropH(a)
				else
					if Notify then
						util.toast("Use of heavy weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nRemove them...")
							util.yield(1500)
					end
					delete_hw(a)
				end
			end
			
			if hasTWeapon(a) and nothrow and not WEAPON_WHITELIST[a] then
				if fly then
					if Notify then
						util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nMaking them fly...")
							util.yield(1500)
					end
					make_fly(a)
                elseif stumble then
                    if Notify then
                        util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nMaking them stumble...")
                            util.yield(1500)
                    end
                    if TASK.IS_PED_WALKING(p) or TASK.IS_PED_RUNNING(p) and not PED.IS_PED_RAGDOLL(p) then
                        local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(p)
                        PED.SET_PED_TO_RAGDOLL_WITH_FALL(p, 1500, 2000, 2, vector.x, vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
                        util.yield(math.random(1000, 40000))
                    end
                elseif camp then
                    if Notify then
                        util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nsetting him on fire...")
                    end
                    STREAMING.REQUEST_MODEL(fire)
                    while not STREAMING.HAS_MODEL_LOADED(fire) do util.yield() end
                    
                    if not PLAYER.IS_PLAYER_DEAD(a) then
                        local ent1 = OBJECT.CREATE_OBJECT(fire, pos.x, pos.y, pos.z, true, true, true)
                        ENTITY.FREEZE_ENTITY_POSITION(ent1, true)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(ent1, p, 0x322c, 0, 0, -0.5, rot.x, rot.y, rot.z, 0) --[[FB_L_Eye_000 = 0x62ac, SKEL_Neck_1 = 0x9995, SKEL_Head = 0x796e, IK_Head = 0x322c]]
                        FastNet(ent1, a, true)
                            util.yield(15100)
                            entities.delete_by_handle(ent1)
                    elseif PLAYER.IS_PLAYER_DEAD(a) then
                        entities.delete_by_handle(ent1)
                    end
                elseif toilet then
                    if Notify then
                        util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nthrowing a toilet at their feet...")
                    end
                    placetoilet(a)
				elseif disable then
					if Notify then
						util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\ndisabling ...")
					end
					WEAPON.SET_CURRENT_PED_WEAPON(p, 0xA2719263, true) --hash is for fist
				elseif Drop then
					if Notify then
						util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nDropping them on ground...")
							util.yield(1500)
					end
					dropT(a)
				elseif stun then
					if Notify then
						util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nStuning them...")
							util.yield(1500)
					end
                    if not PED.IS_PED_DEAD_OR_DYING(p) then
                        stun_player(p, 1)
                    end
				elseif explodePed then
					if Notify then
						util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nExploding them...")
							util.yield(1500)
					end
					if not PLAYER.IS_PLAYER_DEAD(a) then
						exp_ped(a)
					end

				elseif fireexplPed then
					if Notify then
						util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nFiring Fireworks at them...")
							util.yield(1500)
					end
					if not PLAYER.IS_PLAYER_DEAD(a) then
						fire_exp_ped(a)
					end

				else
					if Notify then
						util.toast("Use of throwable weapons by: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nRemove them...")
							util.yield(1500)
					end
					delete_throw(a)
				end
			end
	
----------------------------------------------------------------
--Handle Vehicle Actions
----------------------------------------------------------------

			if not VEHICLE_WHITELIST[a] then
				if starling and isinStarling(a) or annihilator and isinAnnihilator(a) or vigilante and isinVigilante(a) or tampa and isinTampa(a) or molotok and isinMolotok(a) or speedo and isinSpeedo(a) or nightshark and isinNightshark(a) or antiToreador and isinToreador(a) or antiLazer and isInLazer(a) or antiB11 and isInB11(a) or antiMK2 and isOnMK2(a) or antiTank and isInTank(a) or antiAkula and isInAkula(a) or antiHunter and isInHunter(a) or antiSavage and isInSavage(a) or antiHydra and isInHydra(a) or antiScramjet and isInScramjet(a) or antiRCbandito and isInRC(a) or antiTank and isInRC(a) or antiDeluxo and isinDeluxo(a) and (lastReaction + delay <= util.current_time_millis()) then
					if Kick then
						menu.trigger_commands("kick" .. PLAYER.GET_PLAYER_NAME(a))
						if Notify then
							util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nKicking him from the Lobby...")
						end
                    elseif windows then
                        if Notify then
                            util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nCrushing his/here windows...")
                        end
                        if doorcount ~= nil then
                            control_vehicle(a, function(veh)
                                for window = 0, 13 do
                                    VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, window)
                                end
                                util.yield(200)
                                for fix = 0, doorcount do
                                    VEHICLE.FIX_VEHICLE_WINDOW(vehicle, fix)
                                end
                                VEHICLE.FIX_VEHICLE_WINDOW(vehicle, 7)
                                VEHICLE.FIX_VEHICLE_WINDOW(vehicle, 6)
                                util.yield(windowsdelay * 1000)
                            end)
                        else
                            if Notify then
                                util.toast("I don't see any side doors on ".. PLAYER.GET_PLAYER_NAME(a) .. "'s car")
                                util.toast("Trying to crush his/here  windscreen and rear window...")
                            end
                            control_vehicle(a, function(veh)
                                VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, 6) --windscreen
                                VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, 7) --rear window
                                util.yield(200)
                                VEHICLE.FIX_VEHICLE_WINDOW(vehicle, 6)
                                VEHICLE.FIX_VEHICLE_WINDOW(vehicle, 7)
                                util.yield(windowsdelay * 1000)
                            end)
                        end
					elseif burst then
						control_vehicle(a, function(veh)
							if not VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle) then
								VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, true)
							else 
								goto f
							end
							::f::
							if wheel == "Front" then
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 0, true, 1000.0)
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 1, true, 1000.0)
								goto c
							elseif wheel == "Back" then
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 4, true, 1000.0)
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 5, true, 1000.0)
								goto c
							elseif wheel == "Left" then
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 4, true, 1000.0)
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 0, true, 1000.0)
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 2, true, 1000.0) --6 wheel trailer mid left tire
								goto c
							elseif wheel == "Right" then
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 5, true, 1000.0)
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 1, true, 1000.0)
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 3, true, 1000.0) --6 wheel trailer mid right tire
								goto c
							elseif wheel == "Random" then
								VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, math.random(0,7), true, 1000.0)
								goto c
							else
								for wheelId = 0, 7 do
									VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, wheelId, true, 1000.0)
								end
							end
							::c::
							util.yield(200)
							VEHICLE.SET_VEHICLE_FIXED(vehicle)
							util.yield(tiredelay * 1000)
						end)
					elseif loseParts then
						if VEHICLE.IS_THIS_MODEL_A_PLANE(ENTITY.GET_ENTITY_MODEL(vehicle)) then
							if VEHICLE.GET_VEHICLE_BODY_HEALTH(vehicle) >= 500 and ENTITY.IS_ENTITY_IN_AIR(vehicle) and ENTITY.GET_ENTITY_SPEED(vehicle) >= 65 then
								PlacePole(a)
								if Notify then
									util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nDetaching a wing...")
								end
							else
								if Notify then
									util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nWait for here/him to take off for maximum effect...")
									util.yield(700)
								end
							end
						else
							if doorcount ~= nil then
                                if Notify then
                                    util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nDetaching here/his parts...")
                                end
								control_vehicle(a, function(veh)
                                    if VEHICLE._GET_VEHICLE_NUMBER_OF_BROKEN_OFF_BONES(vehicle) >= VEHICLE._GET_NUMBER_OF_VEHICLE_DOORS(vehicle) then
                                        VEHICLE.SET_VEHICLE_FIXED(vehicle)
                                    else 
                                        goto f
                                    end
                                    ::f::
                                    if part == "Left doors" then
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 0)
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 2)
                                        goto c
                                    elseif part == "Right doors" then
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 1)
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 3)
                                        goto c
                                    elseif part == "Hood" then
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 4)
                                        goto c
                                    elseif part == "Trunk" then
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 5)
                                        goto c
                                    elseif part == "Front doors" then
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 1)
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 0)
                                    goto c
                                    elseif part == "Back doors" then
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 2)
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 3)
                                        goto c
                                    elseif part == "Random" then
                                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, math.random(0, 5))
                                        goto c
                                    else -- all
                                        for doorId = 0, doorcount do
                                            VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, doorId)
                                        end
                                    end
                                    ::c::
                                    util.yield(200)
                                    VEHICLE.SET_VEHICLE_FIXED(vehicle)
                                    util.yield(partsdelay * 1000)
                                end)
								
							else
								util.toast("I did nothing, because " .. PLAYER.GET_PLAYER_NAME(a) .. "'s vehicle has no doors.\nActivate some other punishment. :)")
								util.yield(vehDelay)
							end
                        end
					elseif Explode then
						if not PLAYER.IS_PLAYER_DEAD(a) then
							exp_veh(a)
							if Notify then
							util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nExploding there Car...")
							end
						end
					elseif Delete then
						if Notify then
							util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nErasing there Car...")
						end
						control_vehicle(a, function(veh)
							entities.delete_by_handle(veh)
						end)
					elseif Engine then
						if Notify then
							util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nKilling there Engine...")
								util.yield(1600)
						end
						control_vehicle(a, function(veh)
							VEHICLE.SET_VEHICLE_ENGINE_HEALTH(veh, -4000)
							if isInRC(a) then
								VEHICLE.SET_VEHICLE_TIMED_EXPLOSION(veh, a, true)
							end
						end)
					elseif EMP then
						if Notify then
							util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nEMP shocking the Vehicle...")
								util.yield(1600)
						end
							emp_car(a)
					elseif Flip then
						if Notify then
							util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nFliped the Vehicle...")
								util.yield(1500)
						end
							flip(a)
					elseif sling then
						if Notify then
							util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nMaking the Vehicle be a plane...")
								util.yield(1500)
						end
						control_vehicle(a, function(veh)
							VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 250)
							local po = ENTITY.GET_ENTITY_VELOCITY(veh)
							ENTITY.SET_ENTITY_VELOCITY(veh, po.x, po.y, po.z + 10000)
							util.yield(30000)
						end)
					else
						if Notify then
							util.toast("Found Pr0: " .. PLAYER.GET_PLAYER_NAME(a) .. "\nYeeting here/him out of there Vehicle...")
								util.yield(1500)
						end
						menu.trigger_commands("freeze" .. PLAYER.GET_PLAYER_NAME(a))
							util.yield(100)
							menu.trigger_commands("freeze" .. PLAYER.GET_PLAYER_NAME(a))
					lastReaction = util.current_time_millis()
				end
			end

----------------------------------------------------------------
--Loop Handles Stop
----------------------------------------------------------------

		end
	end
end
		util.yield()
end



--* MrWall == Heykeyo#2109
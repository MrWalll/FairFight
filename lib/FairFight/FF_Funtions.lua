
--FUNCTIONS FOR VERSION 1.2 OF FAIRFIGHT
----------------------------------------------

EntityCoords = ENTITY.GET_ENTITY_COORDS
EntityRotation = ENTITY.GET_ENTITY_ROTATION
PlayerPed = PLAYER.GET_PLAYER_PED
PlayerName = players.get_name
PlayerName2 = players.get_name_with_tags
PlayerRID = players.get_rockstar_id
PlayerRID2 = players.get_rockstar_id_2
PlayerVehicle = PED.GET_VEHICLE_PED_IS_USING
PlayerCrew = players.clan_get_motto
PlayerTags = players.get_tags_string
PlayerPos = players.get_position
playerList = players.list_all_with_excludes(false)
W_punishment = "Delete"
V_punishment = "Vehicle kick"
part = "Random Doors"
wheel = "Random"
vehDelay = 30
weapDelay = 30
animal_space = {y = 0, x = -10, z = 0}
animal_godmode = false
is_on_shoot_toggled = false
stun_kills = false
request_model = util.request_model
fire = util.joaat("prop_beach_fire")
healthModel = util.joaat("prop_ld_health_pack")
snackModel = util.joaat("prop_choc_pq")
armourModel = util.joaat("prop_armour_pickup")
chuteModel = util.joaat("p_parachute_s_shop")
WoodBox = util.joaat("prop_box_wood06a")
Toilet = util.joaat("prop_portaloo_01a")
ownPed = players.user_ped()
ownUser = players.user()
ownVehicle = entities.get_user_vehicle_as_handle(false)
ownCrew = players.clan_get_motto(ownUser)
resources_dir = filesystem.resources_dir().."/FairFight/"
mainLua_path = filesystem.scripts_dir()..SCRIPT_RELPATH
local BlockGodsFile = resources_dir.."BlockedPlayers.lua"

if not filesystem.exists(resources_dir.."\\FF_Loadouts.lua") then
    util.toast("[ERROR]\n\nRequired file not found: /resources/fairfight/FF_Loadouts.lua\n\n--["..SCRIPT_FILENAME.."]")
    util.stop_script()
end
require("resources.fairfight.FF_Loadouts")

if not filesystem.exists(lib_dir.."\\FF_Tabels.lua") then
    util.toast("[ERROR]\n\nRequired file not found: /lib/fairfight/FF_Tabels.lua\n\n--["..SCRIPT_FILENAME.."]")
    util.stop_script()
end
require("lib.fairfight.FF_Tabels")
animal = "a_c_"..animal_attack_models[1]
DisplayAnimalName = animal_attack_models[1]

local FF_logo = none
if filesystem.exists(resources_dir.."FF.png") then 
    FF_logo = directx.create_texture(resources_dir.."FF.png")
end

local function onStartup()
    logo_startup()
end
---@diagnostic disable: need-check-nil, unknown-diag-code, exp-in-action, break-outside, miss-symbol, unknown-symbol, param-type-mismatch
-------------------------------------------------
--NOTIFICTION SYSTEM
-------------------------------------------------
---@class Inform
inform = {toggle = false}

---@param who integer
---@param what_weapon string
---@param punishment string
function inform.weapon_use(who, what_weapon, punishment)
    if players.exists(who) then
        util.toast(PlayerName(who).." is using a "..what_weapon.." Weapon.\n"..punishment)
        util.yield(1500)
    end
end
---@param content string
function inform.error(content)
    util.log(content.."--["..SCRIPT_FILENAME.."]")
    return util.toast("[ERROR]\n\n"..content.."\n\n--["..SCRIPT_FILENAME.."]")
end
---@param content string
function inform.caution(content)
    return util.toast("[CAUTION] "..content.." \n\n--["..SCRIPT_FILENAME.."]")
end
---@param content string
function inform.info(content)
    return util.toast("[INFORMATION] "..content.." \n\n--["..SCRIPT_FILENAME.."]")
end
---@param content string
function inform.normal_w_name(content)
    return util.toast(content.." \n\n--["..SCRIPT_FILENAME.."]")
end
-------------------------------------------------
--NOTIFICTION SYSTEM END
-------------------------------------------------


--//============================Debug Mode============================\\
Debug_Active = false
if Debug_Active then
    inform.toggle = true
    playerList = players.list_all_with_excludes(true)
end
--//============================Debug Mode============================\\


local function DoesTableContainValue(table, value)
    for _, v in pairs(table) do
        if v == value then return true end
    end
    return false
end

local function GetValueIndexFromTable(table, value)
    for i, v in pairs(table) do
        if v == value then return i end
    end
    return nil
end

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
            while true do                                                                                                                                                                                                                                                                                                               --[[        _  _           ]]
                text_alliment = text_alliment + text_allin_incr                                                                                                                                                                                                                                                                         --[[       (.)(.)          ]]
                if text_alliment > 0.1 then                                                                                                                                                                                                                                                                                             --[[      (.____.)         ]]
                    text_alliment = 0.1                                                                                                                                                                                                                                                                                                 --[[        '--'           ]]
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
                directx.draw_text(text_alliment, 0.03, ""..SCRIPT_NAME.."", 5, 1, {r = 0.74, g = 0.93, b = 1, a = 1})
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
                directx.draw_text(text_alliment, 0.03, ""..SCRIPT_NAME.."", 5, 1, {r = 0.74, g = 0.93, b = 1, a = 1})
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
onStartup()

--forgot were i got this from... text me if you know
function is_player_friend(playerID)
    local pHandle = memory.alloc(104)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(playerID, pHandle, 13)
    local isFriend = NETWORK.NETWORK_IS_HANDLE_VALID(pHandle, 13) and NETWORK.NETWORK_IS_FRIEND(pHandle)
    return isFriend
end

----------------------------------------------------------------
--CHECK IF PLAYER IS IN PASSIVE
----------------------------------------------------------------
function is_player_passive(playerID) --USES THE BLIP ---ALSO CHECKS FOR DEAD PLAYER
    local playerBlip = HUD.GET_BLIP_FROM_ENTITY(PlayerPed(playerID))
    if not HUD.DOES_BLIP_EXIST(playerBlip) and not NETWORK.IS_PLAYER_IN_CUTSCENE(playerID) or PLAYER.IS_PLAYER_DEAD(playerID) then
        inform.normal_w_name($"I can't seem to find {PlayerName(playerID)}'s blip on the map")
        return
    else 
        if HUD.GET_BLIP_SPRITE(playerBlip) == 163 then -- 163 = passive blip
            return true
        else
            inform.normal_w_name($"{PlayerName(playerID)} is not in Passive")
            return false
        end
    end
end

function get_single_car_arround()
    local allCars = entities.get_all_vehicles_as_handles()
    return allCars[math.random(#allCars)]
end


function set_ped_heading_player(ped, playerPed)--Entity Heading Player adapted from PhoenixScript
    local playerpos = EntityCoords(playerPed)
    local pedpos = EntityCoords(ped)
    local ax = playerpos.x - pedpos.x
    local ay = playerpos.y - pedpos.y
    local heading = MISC.GET_HEADING_FROM_VECTOR_2D(ax, ay)
    return ENTITY.SET_ENTITY_HEADING(ped, heading)
end


function LandCarOnPed(pos, rate = 900) --From AcjokerScript (changed to my use)
    local vehicle = ENTITY.GET_ENTITY_MODEL(get_single_car_arround())
	local  car = VEHICLE.CREATE_VEHICLE(vehicle, pos.x, pos.y, pos.z + 5.0, 0, true, true, false)
    ENTITY.SET_ENTITY_INVINCIBLE(car, true)
    ENTITY.SET_ENTITY_VELOCITY(car, 0, 0, -1000)
	util.yield(rate)
	ENTITY.SET_ENTITY_AS_MISSION_ENTITY(car)
	entities.delete_by_handle(car)
end

function RamPedWithCar(pos_x, pos_y, pos_z, targetID, rate = 1000) --From AcjokerScript (changed to my use)
    local vehicle2 = ENTITY.GET_ENTITY_MODEL(get_single_car_arround())
    local targetPed = PlayerPed(targetID)
	local car2 = VEHICLE.CREATE_VEHICLE(vehicle2, pos_x, pos_y, pos_z, 0, true, true, false)
        set_ped_heading_player(car2, targetPed)
        ENTITY.SET_ENTITY_INVINCIBLE(car2, true)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(car2, 1000)
        util.yield(rate)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(car2)
        entities.delete_by_handle(car2)
end


---Creadits to Prisuhm | Joinked this function from JinxScript
function isDetectionPresent(playerID, detection)
	if players.exists(playerID) and menu.player_root(playerID):isValid() then
		for menu.player_root(playerID):getChildren() as cmd do
			if cmd:getType() == COMMAND_LIST_CUSTOM_SPECIAL_MEANING and players.exists(playerID) then
                if cmd:refByRelPath(detection):isValid() then
				    return true
                end
			end
		end
	end
	return false
end

function SetBlipData(blip, playerID)
    if not players.exists(playerID) then inform.normal_w_name("Seems like the player left") return end
    local isFriend = is_player_friend(playerID)
    local isSameCrew = PlayerCrew(playerID) == ownCrew
    if HUD.DOES_BLIP_EXIST(blip) then
        HUD.SET_BLIP_SPRITE(blip, 398) -- 58, 171, 392 - 397, 416, 398
        HUD.SET_BLIP_COLOUR(blip, 84)
        HUD.SET_BLIP_CATEGORY(blip, 7)
        HUD.SET_BLIP_NAME_TO_PLAYER_NAME(blip, playerID)
        HUD.SHOW_HEADING_INDICATOR_ON_BLIP(blip, true)
        HUD.SET_BLIP_SECONDARY_COLOUR(blip, 99,195,230)
        HUD.SET_BLIP_SCALE(blip, 0.8) 
        if isFriend then HUD.SHOW_FRIEND_INDICATOR_ON_BLIP(blip, true) end
        if isSameCrew then HUD.SHOW_CREW_INDICATOR_ON_BLIP(blip, true) end
    end
end

function OTRdetection(playerID)
    if not NETWORK.NETWORK_IS_IN_SESSION() then 
        inform.normal_w_name("Join a lobby and try again.")
        return false
    end
    if util.is_session_transition_active() then repeat util.yield(250) until util.is_session_started() end

    local otrDetected = players.is_otr(playerID)
    if otrDetected then return true end
    
    if not NETWORK.NETWORK_HAS_PLAYER_STARTED_TRANSITION(playerID) and not NETWORK.IS_PLAYER_IN_CUTSCENE(playerID) 
    and not NETWORK.NETWORK_IS_PLAYER_IN_MP_CUTSCENE(playerID) then
        
        local DeadForTooLong = $"Players>{PlayerName2(playerID)}>Classification: Modder>Dead For Too Long"
        local ModdedHealth = $"Players>{PlayerName2(playerID)}>Classification: Modder>Modded Health (0/0)"
        local pos = PlayerPos(playerID)
        local playerBlip = HUD.GET_BLIP_FROM_ENTITY(PlayerPed(playerID))
        local isinInterior = INTERIOR.GET_INTERIOR_FROM_ENTITY(PlayerPed(playerID)) == 0 and INTERIOR.GET_INTERIOR_AT_COORDS(pos.x, pos.y, pos.z) == 0 and INTERIOR.GET_INTERIOR_FROM_COLLISION(pos.x, pos.y, pos.z) == 0
        
        if players.is_visible(playerID) and not players.is_in_interior(playerID) and not players.is_using_rc_vehicle(playerID) then
            if isinInterior then --to make sure bc stand interior detections isn't the best
                if not HUD.DOES_BLIP_EXIST(playerBlip) and not HUD.GET_BLIP_SPRITE(playerBlip) == 417 then --303=bounty blip; 364=normal player with x in it; 417-419; blip of player in interior
                    if not isDetectionPresent(playerID, "Modded Off Radar") then
                        players.add_detection(playerID, "Modded Off Radar", TOAST_ALL, 70)
                    end
                    return true
                end
            end
        end
    end
end

local function side()
	local nu = math.random(1, 2)
	if nu == 1 then
		return 5
	else
		return -5
	end
end

local function vehicle_display_name(vehicle)
    if not ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then return end
    local model = ENTITY.GET_ENTITY_MODEL(vehicle)
    return HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model))
end

-- UTILITY FUNCTIONS
-- FROM http://lua-users.org/wiki/SaveTableToFile

local function exportstring( s )
    return string.format("%q", s)
end

function table.save(  tbl,filename )
   local charS,charE = "   ","\n"
   local file,err = io.open( filename, "wb" )
   if err then return err end
   -- initiate variables for save procedure
   local tables,lookup = { tbl },{ [tbl] = 1 }
   file:write( "return {"..charE )
   for idx,t in ipairs( tables ) do
      file:write( "-- Table: {"..idx.."}"..charE )
      file:write( "{"..charE )
      local thandled = {}
      for i,v in ipairs( t ) do
         thandled[i] = true
         local stype = type( v )
         -- only handle value
         if stype == "table" then
            if not lookup[v] then
               table.insert( tables, v )
               lookup[v] = #tables
            end
            file:write( charS.."{"..lookup[v].."},"..charE )
         elseif stype == "string" then
            file:write(  charS..exportstring( v )..","..charE )
         elseif stype == "number" then
            file:write(  charS..tostring( v )..","..charE )
         end
      end
      for i,v in pairs( t ) do
         -- escape handled values
         if (not thandled[i]) then
            local str = ""
            local stype = type( i )
            -- handle index
            if stype == "table" then
               if not lookup[i] then
                  table.insert( tables,i )
                  lookup[i] = #tables
               end
               str = charS.."[{"..lookup[i].."}]="
            elseif stype == "string" then
               str = charS.."["..exportstring( i ).."]="
            elseif stype == "number" then
               str = charS.."["..tostring( i ).."]="
            end
            if str ~= "" then
               stype = type( v )
               -- handle value
               if stype == "table" then
                  if not lookup[v] then
                     table.insert( tables,v )
                     lookup[v] = #tables
                  end
                  file:write( str.."{"..lookup[v].."},"..charE )
               elseif stype == "string" then
                  file:write( str..exportstring( v )..","..charE )
               elseif stype == "number" then
                  file:write( str..tostring( v )..","..charE )
               end
            end
         end
      end
      file:write( "},"..charE )
   end
   file:write( "}" )
   file:close()
end

function table.load( sfile )
    local ftables,err = loadfile( sfile )
    if err then return _,err end
    local tables = ftables()
    for idx = 1,#tables do
       local tolinki = {}
       for i,v in pairs( tables[idx] ) do
          if type( v ) == "table" then
             tables[idx][i] = tables[v[1]]
          end
          if type( i ) == "table" and tables[i[1]] then
             table.insert( tolinki,{ i,tables[i[1]] } )
          end
       end
       -- link indices
       for _,v in ipairs( tolinki ) do
          tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
       end
    end
    return tables[1]
 end
-- END UTILITY FUNCTIONS

----------------------------------------------------------------
--[[
This funtion was original created by kryptcat#6566, i adjusted it to my use. 
Credit goes to him.]]
----------------------------------------------------------------
local function FastNet(entity, playerID, visible)
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
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID, true)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, true)
    util.yield(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerID, true)
    util.yield(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true)
    util.yield(10)
    ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(entity, true)
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
----------------------------------------------------------------
--PLACE OBJECT NEXT TO PLAYER PLANE TO BREAKE OF WING
----------------------------------------------------------------
local function PlacePole(playerID)
    local sidewaysOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PlayerPed(playerID), side(), 0, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(PlayerPed(playerID))
    request_model(WoodBox)
    local a1 = OBJECT.CREATE_OBJECT(WoodBox, sidewaysOffset.x, sidewaysOffset.y, sidewaysOffset.z - 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
    ENTITY.FREEZE_ENTITY_POSITION(a1, true)
    FastNet(a1, playerID)
    local b1 = OBJECT.CREATE_OBJECT(WoodBox, sidewaysOffset.x, sidewaysOffset.y, sidewaysOffset.z + 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
    ENTITY.FREEZE_ENTITY_POSITION(b1, true)
    FastNet(b1, playerID)
    util.yield(500)
    entities.delete_by_handle(a1)
    entities.delete_by_handle(b1)
end
----------------------------------------------------------------
--HIT PLAYER WITH TOILET
----------------------------------------------------------------
local function placetoilet(playerID)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PlayerPed(playerID), 0, 0.5, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(PlayerPed(playerID))
    request_model(Toilet)
    local b1 = OBJECT.CREATE_OBJECT(Toilet, pos.x, pos.y, pos.z + 1, true, true, true)
    ENTITY.FREEZE_ENTITY_POSITION(b1)
    ENTITY.SET_ENTITY_HEADING(b1, pheading)
    ENTITY.APPLY_FORCE_TO_ENTITY(b1, 3, 0, 0, -500, 0, 0, 0.5, 0, true, true, true, 1, 1)
    FastNet(b1, playerID, true)
    util.yield(1200)
    entities.delete_by_handle(b1)
end
----------------------------------------------------------------
--CHECK FOR SPECIAL VEHICLES
----------------------------------------------------------------
local function isInRC(playerID)
    local vehicle = PlayerVehicle(PlayerPed(playerID))
    local hash1 = CarToggles.BANDITO["hash"]
    local hash2 = CarToggles.MINITANK["hash"]
    if VEHICLE.IS_VEHICLE_MODEL(vehicle, hash1) or VEHICLE.IS_VEHICLE_MODEL(vehicle, hash2) then
        return true
    else
        return false
    end
end
----------------------------------------------------------------
--CHECK FOR ANY UNWANTED VEHICLE
----------------------------------------------------------------
local function isinGrieferCar(vehicle)
    if vehicle == 0 then return end -- stop if vehicle is invalid
        for i = 1, #Vehicles do
            if VEHICLE.IS_VEHICLE_MODEL(vehicle, Vehicles[i]) then -- compare given vehicle to every vehicle that is seen as "bad"
                return true
            end
            util.yield(20)
        end
end
----------------------------------------------------------------
--CHECK IF ANY VEHICLE TOGGEL IS ACTIVE
----------------------------------------------------------------
local function check_for_Car_toggles()
    for _, cvt in pairs(CarToggles) do
        if cvt["toggle"] then
            return true
        end
    end
    return false
end

local function main_vehicle_check(vehicle, playerID) --check to see if toggled cars are beeing used by any players
    local toggled = {}
    count = 1
    for k, v in pairs(CarToggles) do
        if v["toggle"] then
            for b, l in pairs(v) do --save in new local table
                if b == "hash" then --only get the hash from the "CarToggles" table
                    table.insert(toggled, count, l) --insert in a local table
                    count = count + 1 --add 1 to count to have a int key for every hash
                end
            end
        end
    end
    for l, c in pairs(toggled) do
        if toggled[l] and isinGrieferCar(vehicle) then --check if hash from local table is being used by any player and if it is one of the possible "bad" cars (separate function)
            return true
        end
    end
end
----------------------------------------------------------------
--GET VEHICLE CONTROL
----------------------------------------------------------------
function control_vehicle(vehicle)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vehicle)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) and util.is_session_started() then
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
    end
    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle)
end
----------------------------------------------------------------
--HAS VEHICLE WINDOWS TO DESTROY
----------------------------------------------------------------
local function HasWindowToDestroy(vehicle)
    local windows = 0
    for i = 0, 7 do
        local isIntact = VEHICLE.IS_VEHICLE_WINDOW_INTACT(vehicle, i)
        if not isIntact then
            windows = windows + 1
        end
    end
    return windows > 0
end
----------------------------------------------------------------
--FLIP VEHICLE
----------------------------------------------------------------
local function flip_vehicle_vertical(vehicle)
	local rot = ENTITY.GET_ENTITY_ROTATION(vehicle, 2)
    ENTITY.SET_ENTITY_ROTATION(vehicle, rot.x, rot.y + 180, rot.z, 2, true)
end
----------------------------------------------------------------
--SLINGSHOT VEHICLE
----------------------------------------------------------------
local function slingshot_vehicle(vehicle)
    if not control_vehicle(vehicle) then return false end
    ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, 5000)
    util.yield(300) --wait for the vehicle to be over houses and stuff
    ENTITY.SET_ENTITY_VELOCITY(vehicle, 0, 0, 2500)
    util.yield(1500)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 90)
end
----------------------------------------------------------------
--ORB PLAYER (SUICIDE)
----------------------------------------------------------------
local function orb_strike_player(playerID)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED("scr_xm_orbital") do
		STREAMING.REQUEST_NAMED_PTFX_ASSET("scr_xm_orbital")
		util.yield(0)
	end
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
	local pos = EntityCoords(PlayerPed(playerID))
    FIRE.ADD_OWNED_EXPLOSION(PlayerPed(playerID), pos.x, pos.y, pos.z, 59, 100, true, false, 1, false)
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", pos.x, pos.y, pos.z, 0, 180, 0, 0.4, true, true, true) --why do i have to use this? why just not have the fx with the explosion¿
end
----------------------------------------------------------------
--EMP SHOCK PLAYER
----------------------------------------------------------------
local function emp_shock_player(playerID)
    local pos = EntityCoords(PlayerPed(playerID))
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 83, 100.0, false, true, 0.0, false)
end
----------------------------------------------------------------
--EXPLODE PLAYER (NOT BLAIMED)
----------------------------------------------------------------
local function explode_player(playerID)
    local pos = EntityCoords(PlayerPed(playerID))
	FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 31, 1.0, false, true, 0.0, false) --31 blimp small, 37 blimp big
end
----------------------------------------------------------------
--MAKE PLAYER FLY UP (ATOMIZER, NOT VISIBLE, NO SOUND)
----------------------------------------------------------------
local function make_player_fly(playerID)
	local pos = EntityCoords(PlayerPed(playerID))
	FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.7, 70, 1, false, true, 0, false)
    util.yield(10)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.5, 70, 1, false, true, 0, false)
end
----------------------------------------------------------------
--FIREWORK EXPLO PLAYER
----------------------------------------------------------------
local function firework_player_head(playerID)
    local ped_head = 0x322c
    repeat
        local pos = PED.GET_PED_BONE_COORDS(PlayerPed(playerID), ped_head, 0, 0, 0)
	    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x - 0.2, pos.y, pos.z, 500, true, Weapons["firework_launcher"], 0, true, true, 1)
        util.yield(10)
    until PLAYER.IS_PLAYER_DEAD(playerID)
end
----------------------------------------------------------------
--SHOOT STUNGUN AT PLAYER
----------------------------------------------------------------
function stun_ped(playerID, damage = 1)
    local ped = PlayerPed(playerID)
    local maxHP = PED.GET_PED_MAX_HEALTH(ped) + PED.GET_PED_ARMOUR(ped)
    local p_head = 0x322c
    local pos = PED.GET_PED_BONE_COORDS(ped, p_head, 0, 0, 0)
    if stun_kills then damage = maxHP * 5 end
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 0.2, damage, false, Weapons["stungun"], 0, false, false, 1)
    util.yield(250)
    while PED.IS_PED_BEING_STUNNED(ped,0) do util.yield(200) end
    if not PLAYER.IS_PLAYER_DEAD(playerID) and damage > maxHP and not PED.IS_PED_BEING_STUNNED(ped,0) then
        inform.normal_w_name("Did not kill "..PlayerName(playerID)..".\nThey might be using Godmode or Anti-Ragdoll")
    end
end
----------------------------------------------------------------
--THROW SNOWBALL AT PLAYERS HEAD
----------------------------------------------------------------
function snowball_player(playerID, damage)
    local active = 0
    local p_head = 0x322c
    local pos = PED.GET_PED_BONE_COORDS(PlayerPed(playerID), p_head, 0, 0, 0)
    repeat
        pos = PED.GET_PED_BONE_COORDS(PlayerPed(playerID), p_head, 0, 0, 0)
        util.trigger_script_event(1 << playerID, {800157557, ownUser, 225624744, math.random(0, 9999)}) --try removing players godmode
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z - 0.2, damage, false, Weapons["snowball"], 0, false, false, 10000)
        active = active + 0.5
    until PLAYER.IS_PLAYER_DEAD(playerID) or active >= 10
    util.yield(500)
    if not PLAYER.IS_PLAYER_DEAD(playerID) then
        inform.normal_w_name('Did not kill '..PlayerName(playerID)..'.\nThey might be using "Godmode" \nor "No Ragdoll"')
    end
end
----------------------------------------------------------------
--ATTACH FIRE TO PLAYER UNTIL HE DIES OR TIME RUNS OUT
----------------------------------------------------------------
local function burn_player(playerID)
    request_model(fire)
    local player_ped = PlayerPed(playerID)
    local player_pos = EntityCoords(player_ped)
    local player_rotation = ENTITY.GET_ENTITY_ROTATION(player_ped, 2)
    local fire_object = OBJECT.CREATE_OBJECT(fire, player_pos.x, player_pos.y, player_pos.z, true, true, true)
    ENTITY.FREEZE_ENTITY_POSITION(fire_object, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(fire_object, player_ped, 0x322c, 0, 0, - 1.4, player_rotation.x, player_rotation.y, player_rotation.z, 0) --[[FB_L_Eye_000 = 0x62ac, SKEL_Neck_1 = 0x9995, SKEL_Head = 0x796e, IK_Head = 0x322c]]
        FastNet(fire_object, playerID, true)
            util.yield(15100) --waits until ped is burned to death (considering he is not healing against the damage)
            entities.delete_by_handle(fire_object)
    if PLAYER.IS_PLAYER_DEAD(playerID) then
        entities.delete_by_handle(fire_object)
    elseif ENTITY.IS_ENTITY_IN_WATER(player_ped) then
        entities.delete_by_handle(fire_object)
    end
end
----------------------------------------------------------------
--ATTACK PLAYER WITH ANIMAL OF CHOICE
----------------------------------------------------------------
local function animal_attack(playerID, animal, godmode, spawn_location)
    local pet = util.joaat(animal)
    request_model(animal)
    local heading = ENTITY.GET_ENTITY_HEADING(PlayerPed(playerID))
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PlayerPed(playerID), spawn_location.y, spawn_location.x, spawn_location.z)
    ent = entities.create_ped(28, pet, pos, heading)
    ENTITY.SET_ENTITY_INVINCIBLE(ent, godmode)
    PED.SET_PED_CAN_RAGDOLL(ent, false)
    PED.SET_PED_COMBAT_ATTRIBUTES(ent, 5, true) --always fight
    PED.SET_PED_COMBAT_ATTRIBUTES(ent, 13, true) --aggressive
    PED.SET_PED_COMBAT_ABILITY(ent, 3) --professional
    PED.SET_PED_COMBAT_MOVEMENT(ent, 3)--will advance
    WEAPON.GIVE_WEAPON_TO_PED(ent, Weapons["animal"], 9999, true, false) --give animal weapon for it to do more damage
    TASK.TASK_COMBAT_PED(ent, PlayerPed(playerID), 0, 16)
    while ENTITY.DOES_ENTITY_EXIST(ent) do
        WEAPON.SET_WEAPON_DAMAGE_MODIFIER(Weapons["animal"], 15)
        if PLAYER.IS_PLAYER_DEAD(playerID) then
            util.yield(1000)
            entities.delete_by_handle(ent)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pet)
            break
        end
        if not ENTITY.DOES_ENTITY_EXIST(ent) then
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pet)
            break
        end
        if ENTITY.IS_ENTITY_DEAD(ent) then
            util.yield(1000)
            entities.delete_by_handle(ent)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pet)
            break
        end
        util.yield()
    end
    util.reverse_joaat(pet)
end

----------------------------------------------------------------
--ROADKILL PLAYER WITH RANDOM CARS
----------------------------------------------------------------
function roadkill_player(playerID)
    local Pped = PlayerPed(playerID)
    if PlayerVehicle(Pped) ~= 0 then
        inform.normal_w_name("Does not work while "..PlayerName(playerID).." is in a vehicle")
        return
    end
    if not PLAYER.IS_PLAYER_DEAD(playerID) then
        local pos = EntityCoords(Pped, true)
        LandCarOnPed(pos)
        local timeDifference = NETWORK.GET_TIME_DIFFERENCE(MISC.GET_GAME_TIMER(), PED.GET_PED_TIME_OF_DEATH(Pped))
        if PLAYER.IS_PLAYER_DEAD(playerID) and timeDifference >= 835 and timeDifference <= 890 then
            util.toast($"Smashed {PlayerName(playerID)} with a car")
            util.yield(8000) --wait till wasted screen is over and player is respawned
            return
        else
            RamPedWithCar(pos.x, pos.y, pos.z, playerID)
            if PLAYER.IS_PLAYER_DEAD(playerID) then
                util.toast($"{PlayerName(playerID)} has been run over")
            end
            if not PLAYER.IS_PLAYER_DEAD(playerID) then
                local function try_ram(offset_x, offset_y)
                    pos = EntityCoords(Pped, true)
                    RamPedWithCar(pos.x + offset_x, pos.y + offset_y, pos.z, playerID)
                    util.yield(600)
                    timeDifference = NETWORK.GET_TIME_DIFFERENCE(MISC.GET_GAME_TIMER(), PED.GET_PED_TIME_OF_DEATH(Pped))
                    if PLAYER.IS_PLAYER_DEAD(playerID) and timeDifference >= 1300 and timeDifference <= 1700 then
                            util.toast($"{PlayerName(playerID)} has been run over")
                        return "Killed"
                    end
                end
                -- -841  -867  -1552  -1510 -1329 -1511  1533 1506
                local directions = {
                    {15, 0}, {-15, 0}, {0, 15}, {0, -15}, {-15, -15}, {15, 15}, {15, -15}, {-15, 15}
                }

                for _, dir in ipairs(directions) do
                    if try_ram(dir[1], dir[2]) == "Killed" then
                        return
                    end
                end
            end
            if not PLAYER.IS_PLAYER_DEAD(playerID) then
                util.toast($"Missed {PlayerName(playerID)} or player is unreachable")
            end
        end
        util.yield(1000)
        return
    end
end


----------------------------------------------------------------
--DELETE A GROUP OF WEAPONS (TABLE)
----------------------------------------------------------------
---@param weapons_table table
local function delete_multiple_weapons(playerID, weapons_table)
	for key in pairs(weapons_table) do
        WEAPON.REMOVE_WEAPON_FROM_PED(PlayerPed(playerID), key)
    end
end

----------------------------------------------------------------
--DROP A GROUP OF WEAPONS (TABLE)
----------------------------------------------------------------
---@param weapons_table table
local function drop_multiple_weapons(playerID, weapons_table)
	local pos = EntityCoords(PlayerPed(playerID))
	for key in pairs(weapons_table) do
        WEAPON.SET_PED_DROPS_INVENTORY_WEAPON(PlayerPed(playerID), key, pos.x, pos.y, pos.z, 25)
        util.yield(300)
        WEAPON.REMOVE_WEAPON_FROM_PED(PlayerPed(playerID), key)
    end
end

----------------------------------------------------------------
--CHECK FOR PLAYER WEAPON
----------------------------------------------------------------
local function has_player_weapon(playerID)
    if Weapons.HList[WEAPON.GET_SELECTED_PED_WEAPON(PlayerPed(playerID))] then
		return "Heavy"
    elseif Weapons.TList[WEAPON.GET_SELECTED_PED_WEAPON(PlayerPed(playerID))] then
		return "Throwable"
    elseif Weapons.AList[WEAPON.GET_SELECTED_PED_WEAPON(PlayerPed(playerID))] then
        return "Annoying"
    elseif Weapons.SList[WEAPON.GET_SELECTED_PED_WEAPON(PlayerPed(playerID))] then
        return "Semiauto"
    elseif Weapons.SPACEList[WEAPON.GET_SELECTED_PED_WEAPON(PlayerPed(playerID))] then
        return "Spaceguns"
    elseif Weapons.SHOOTList[WEAPON.GET_SELECTED_PED_WEAPON(PlayerPed(playerID))] then
        return "Shootguns"
    else return false end
end

---function to switch between shooting and aiming
local function toggleShooting(playerID)
    local ped = PlayerPed(playerID)
    if is_on_shoot_toggled then
        return PED.IS_PED_SHOOTING(ped)
    elseif has_player_weapon(playerID) == "Throwable" and PED.IS_PED_SHOOTING(ped) then --need to do this because IS_PLAYER_FREE_AIMING(playerID) doesn't work on Throwables (DONT ASK ME WHY, I HATE IT)
        return true
    else
        return PLAYER.IS_PLAYER_FREE_AIMING(playerID) and WEAPON.IS_PED_WEAPON_READY_TO_SHOOT(ped)
    end
end

----------------------------------------------------------------
--MAIN WEAPONSGROUP HANDLE (ANNOYING)
----------------------------------------------------------------
function annoyingWP()
    local is_annoying = menu.get_value(annoying_toggle)
    if not is_annoying then return end --stop function if toggle is false

        local function perform_checks(playerID) --check if player is active and has a annoying weapon in hands also check if blacklisted
            local has_weapon = has_player_weapon(playerID) == "Annoying"
            if NETWORK.NETWORK_IS_PLAYER_ACTIVE(playerID) then
                if has_weapon and not WEAPON_BLACKLIST[playerID] then
                    return true
                end
            end
        end

        for _,playerID in ipairs(playerList) do
            local player_ped = PlayerPed(playerID)
            local shooting = toggleShooting(playerID)

            if perform_checks(playerID) then
                if shooting then
                    switch W_punishment do
                        case "Delete":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"Remove them...")
                            end
                            delete_multiple_weapons(playerID, Weapons.AList)
                            break
                        case "Fly":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"Making them fly..")
                            end
                            make_player_fly(playerID)
                            break
                        case "Burn":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"setting him on fire...")
                            end
                            burn_player(playerID)
                            break
                        case "Toilet":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"throwing a toilet at there feet...")
                            end
                            placetoilet(playerID)
                            break
                        case "Stun":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"Stuning them...")
                            end
                            if not PLAYER.IS_PLAYER_DEAD(playerID) then
                                stun_ped(playerID)
                            end
                            break
                        case "Explode":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"Exploding them...")
                            end
                            if not PLAYER.IS_PLAYER_DEAD(playerID) then
                                explode_player(playerID)
                            end
                            break
                        case "Firework":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"Firing Fireworks at them...")
                            end
                            if not PLAYER.IS_PLAYER_DEAD(playerID) then
                                firework_player_head(playerID)
                            end
                            break
                        case "Drop":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"Dropping them on Ground...")
                            end
                                drop_multiple_weapons(playerID, Weapons.AList)
                                break
                        case "Snowball":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"Throwing snowballs in his face...")
                            end
                                snowball_player(playerID, 1000)
                                break
                        case "Animal":
                            if inform.toggle then
                                inform.weapon_use(playerID, annoying_menu_name,"A "..DisplayAnimalName.." has ben send to get him/her...")
                            end
                                animal_attack(playerID, animal, animal_godmode, animal_space)
                            break
                    end
                    util.yield(weapDelay * 1000)
                end
            end
        end
end
----------------------------------------------------------------
--MAIN WEAPONSGROUP HANDLE (HEAVY)
----------------------------------------------------------------
function heavyWP()
    local is_hw = menu.get_value(hw_toggle)
    if not is_hw then return end --stop function if toggle is false

    local function perform_checks(playerID) --check if player is active, heavy weapon in hands and if blacklisted
        local has_weapon = has_player_weapon(playerID) == "Heavy"
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(playerID) then
            if has_weapon and not WEAPON_BLACKLIST[playerID] then
                return true
            end
        end
    end

    for _,playerID in ipairs(playerList) do
        local player_ped = PlayerPed(playerID)
        local shooting = toggleShooting(playerID)

        if perform_checks(playerID) then
            if shooting then
                switch W_punishment do
                    case "Delete":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"Remove them...")
                        end
                        delete_multiple_weapons(playerID, Weapons.HList)
                        break
                    case "Fly":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"Making them fly...")
                        end
                        make_player_fly(playerID)
                        break
                    case "Burn":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"setting him on fire...")
                        end
                        burn_player(playerID)
                        break
                    case "Toilet":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"throwing a toilet at their feet...")
                        end
                        placetoilet(playerID)
                        break
                    case "Stun":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"Stuning them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            stun_ped(playerID)
                        end
                        break
                    case "Explode":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"Exploding them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            explode_player(playerID)
                        end
                        break
                    case "Firework":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"Firing Fireworks at them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            firework_player_head(playerID)
                        end
                        break
                    case "Drop":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"Dropping them on Ground...")
                        end
                            drop_multiple_weapons(playerID, Weapons.HList)
                            break
                    case "Snowball":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"Throwing snowballs in his face...")
                        end
                            snowball_player(playerID, 1000)
                            break
                    case "Animal":
                        if inform.toggle then
                            inform.weapon_use(playerID, hw_menu_name,"A "..DisplayAnimalName.." has ben send to get him/her...")
                        end
                            animal_attack(playerID, animal, animal_godmode, animal_space)
                            break
                end
                util.yield(weapDelay * 1000)
            end
        end
    end
end
----------------------------------------------------------------
--MAIN WEAPONSGROUP HANDLE (THROWABLES)
----------------------------------------------------------------
function throwabelsWP()
    local is_throwabels = menu.get_value(throwabels_toggle)
    if not is_throwabels then return end --stop function if toggle is false

    local function perform_checks(playerID) --check if player is active, throwables weapon in hands and if blacklisted
        local has_weapon = has_player_weapon(playerID) == "Throwable"
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(playerID) then
            if has_weapon and not WEAPON_BLACKLIST[playerID] then
                return true
            end
        end
    end

    for _,playerID in ipairs(playerList) do
        local player_ped = PlayerPed(playerID)
        local shooting = toggleShooting(playerID)

        if perform_checks(playerID) then
            if shooting then
                util.toast("shooting true")
                switch W_punishment do
                    case "Delete":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"Remove them...")
                        end
                        delete_multiple_weapons(playerID, Weapons.TList)
                        break
                    case "Fly":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"making them fly...")
                        end
                        make_player_fly(playerID)
                        break
                    case "Burn":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"setting him on fire...")
                        end
                        burn_player(playerID)
                        break
                    case "Toilet":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"throwing a toilet at their feet...")
                        end
                        placetoilet(playerID)
                        break
                    case "Drop":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"Dropping them on ground...")
                        end
                        drop_multiple_weapons(playerID, Weapons.TList)
                        break
                    case "Stun":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"Stuning them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            stun_ped(playerID)
                        end
                        break
                    case "Explode":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"Exploding them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            explode_player(playerID)
                        end
                        break
                    case "Firework":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"Firing Fireworks at them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            firework_player_head(playerID)
                        end
                        break
                    case "Snowball":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"Throwing snowballs in his face...")
                        end
                        snowball_player(playerID, 1000)
                        break
                    case "Animal":
                        if inform.toggle then
                            inform.weapon_use(playerID, throwables_menu_name,"A "..DisplayAnimalName.." has ben send to get him/her...")
                        end
                        animal_attack(playerID, animal, animal_godmode, animal_space)
                        break
                end
                util.yield(weapDelay * 1000)
            end
        end
    end
end
----------------------------------------------------------------
--MAIN WEAPONSGROUP HANDLE (SEMIAUTO)
----------------------------------------------------------------
function semiautoWP()
    local is_semiauto = menu.get_value(semiauto_toggle)
    if not is_semiauto then return end --stop function if toggle is false

    local function perform_checks(playerID) --check if player is active, Semiauto weapon in hands and if blacklisted
        local has_weapon = has_player_weapon(playerID) == "Semiauto"
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(playerID) then
            if has_weapon and not WEAPON_BLACKLIST[playerID] then
                return true
            end
        end
    end

    for _,playerID in ipairs(playerList) do
        local player_ped = PlayerPed(playerID)
        local shooting = toggleShooting(playerID)

        if perform_checks(playerID) then
            if shooting then
                switch W_punishment do
                    case "Delete":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"Removing them..")
                        end
                        delete_multiple_weapons(playerID, Weapons.SList)
                        break
                    case "Fly":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"Making them fly...")
                        end
                        make_player_fly(playerID)
                        break
                    case "Burn":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"setting him on fire...")
                        end
                        burn_player(playerID)
                        break
                    case "Toilet":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"throwing a toilet at his feet...")
                        end
                        placetoilet(playerID)
                        break
                    case "Stun":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"Stuning them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            stun_ped(playerID)
                        end
                        break
                    case "Explode":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"Exploding them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            explode_player(playerID)
                        end
                        break
                    case "Firework":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"Firing Fireworks at them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            firework_player_head(playerID)
                        end
                        break
                    case "Drop":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"Dropping them on Ground...")
                        end
                        drop_multiple_weapons(playerID, Weapons.SList)
                        break
                    case "Snowball":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"Throwing snowballs in his face...")
                        end
                        snowball_player(playerID, 1000)
                        break
                    case "Animal":
                        if inform.toggle then
                            inform.weapon_use(playerID, semiauto_menu_name,"A "..DisplayAnimalName.." has ben send to get him/her...")
                        end
                        animal_attack(playerID, animal, animal_godmode, animal_space)
                        break
                end
                util.yield(weapDelay * 1000)
            end
        end
    end
end
----------------------------------------------------------------
--MAIN WEAPONSGROUP HANDLE (SPACE GUNS)
----------------------------------------------------------------
function spacegunsWP()
    local is_spaceguns = menu.get_value(spaceguns_toggle)
    if not is_spaceguns then return end --stop function if toggle is false

    local function perform_checks(playerID) --check if player is active, Spaceguns weapon in hands and if blacklisted
        local has_weapon = has_player_weapon(playerID) == "Spaceguns"
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(playerID) then
            if has_weapon and not WEAPON_BLACKLIST[playerID] then
                return true
            end
        end
    end

    for _,playerID in ipairs(playerList) do
        local player_ped = PlayerPed(playerID)
        local shooting = toggleShooting(playerID)

        if perform_checks(playerID) then
            if shooting then
                switch W_punishment do
                    case "Delete":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"Removing them..")
                        end
                        delete_multiple_weapons(playerID, Weapons.SPACEList)
                        break
                    case "Fly":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"Making them fly...")
                        end
                        make_player_fly(playerID)
                        break
                    case "Burn":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"setting him on fire...")
                        end
                        burn_player(playerID)
                        break
                    case "Toilet":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"throwing a toilet at his feet...")
                        end
                        placetoilet(playerID)
                        break
                    case "Stun":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"Stuning them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            stun_ped(playerID)
                        end
                        break
                    case "Explode":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"Exploding them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            explode_player(playerID)
                        end
                        break
                    case "Firework":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"Firing Fireworks at them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            firework_player_head(playerID)
                        end
                        break
                    case "Drop":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"Dropping them on Ground...")
                        end
                        drop_multiple_weapons(playerID, Weapons.SPACEList)
                        break
                    case "Snowball":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"Throwing snowballs in his face...")
                        end
                        snowball_player(playerID, 1000)
                        break
                    case "Animal":
                        if inform.toggle then
                            inform.weapon_use(playerID, spaceguns_menu_name,"A "..DisplayAnimalName.." has ben send to get him/her...")
                        end
                        animal_attack(playerID, animal, animal_godmode, animal_space)
                        break
                end
                util.yield(weapDelay * 1000)
            end
        end
    end
end

----------------------------------------------------------------
--MAIN WEAPONSGROUP HANDLE (SHOOTGUNS)
----------------------------------------------------------------
function shootgunsWP()
    local is_shootguns = menu.get_value(shootguns_toggle)
    if not is_shootguns then return end --stop function if toggle is false

    local function perform_checks(playerID) --check if player is active, Shootguns weapon in hands and if blacklisted
        local has_weapon = has_player_weapon(playerID) == "Shootguns"
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(playerID) then
            if has_weapon and not WEAPON_BLACKLIST[playerID] then
                return true
            end
        end
    end

    for _,playerID in ipairs(playerList) do
        local player_ped = PlayerPed(playerID)
        local shooting = toggleShooting(playerID)

        if perform_checks(playerID) then
            if shooting then
                switch W_punishment do
                    case "Delete":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"Removing them..")
                        end
                        delete_multiple_weapons(playerID, Weapons.SHOOTList)
                        break
                    case "Fly":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"Making them fly...")
                        end
                        make_player_fly(playerID)
                        break
                    case "Burn":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"setting him on fire...")
                        end
                        burn_player(playerID)
                        break
                    case "Toilet":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"throwing a toilet at his feet...")
                        end
                        placetoilet(playerID)
                        break
                    case "Stun":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"Stuning them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            stun_ped(playerID)
                        end
                        break
                    case "Explode":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"Exploding them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            explode_player(playerID)
                        end
                        break
                    case "Firework":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"Firing Fireworks at them...")
                        end
                        if not PLAYER.IS_PLAYER_DEAD(playerID) then
                            firework_player_head(playerID)
                        end
                        break
                    case "Drop":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"Dropping them on Ground...")
                        end
                        drop_multiple_weapons(playerID, Weapons.SHOOTList)
                        break
                    case "Snowball":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"Throwing snowballs in his face...")
                        end
                        snowball_player(playerID, 1000)
                        break
                    case "Animal":
                        if inform.toggle then
                            inform.weapon_use(playerID, shootguns_menu_name,"A "..DisplayAnimalName.." has ben send to get him/her...")
                        end
                        animal_attack(playerID, animal, animal_godmode, animal_space)
                        break
                end
                util.yield(weapDelay * 1000)
            end
        end
    end
end
----------------------------------------------------------
---VEHICLE HANDLE BEGIN
----------------------------------------------------------

function vehicle_handle()
    local activate_toggle = menu.get_value(vehicle_activate_toggle)
    local vehicles_toggled = check_for_Car_toggles()
    if not vehicles_toggled then
        vehicle_activate_toggle.value = false
        inform.normal_w_name("You need to toggle a vehicle first.")
        return util.stop_thread(vehicle_thread)
    end
    if activate_toggle then
        for _, playerID in ipairs(playerList) do
            local vehicle = PlayerVehicle(PlayerPed(playerID))
            if vehicle > 0 then
                local vehicle_doors_count = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(vehicle)
                local vehicle_windows = HasWindowToDestroy(vehicle)
                local NumDoorsToBreak = math.random(0, vehicle_doors_count)
                local NumWheelsToBreak = math.random(1, 4)
                local isMK2 = VEHICLE.IS_VEHICLE_MODEL(vehicle, CarToggles.OPPRESSOR2["hash"])
                local isRC = isInRC(playerID)
                if not VEHICLE_BLACKLIST[playerID] and main_vehicle_check(vehicle, playerID) then
                    switch V_punishment do
                        case "Vehicle kick":
                            if inform.toggle then
                                util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nThrowing them out of it...")
                            end
                            menu.trigger_commands("freeze" .. PlayerName(playerID))
                            util.yield(100)
                            menu.trigger_commands("freeze" .. PlayerName(playerID))
                            break
                        case "Lobby Kick":
                            menu.trigger_commands("kick" .. PlayerName(playerID))
                            if inform.toggle then
                                util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nKicking them from the Lobby...")
                            end
                            break
                        case "Window crush":
                            if isMK2 or isRC then break end
                            if vehicle_windows then
                                if inform.toggle then
                                    util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nsmashing there windows...")
                                end
                                if control_vehicle(vehicle) then
                                    for window = 0, 7 do
                                        VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, window)
                                        util.yield(150)
                                        VEHICLE.FIX_VEHICLE_WINDOW(vehicle, window)
                                    end
                                else
                                    util.toast("Couldn't get control of "..PlayerName(playerID).."'s vehicle")
                                end
                            else
                                if inform.toggle then
                                    inform.normal_w_name("I don't see any windows on ".. PlayerName(playerID) .. "'s car")
                                end
                            end
                            break
                        case "Tires":
                                if control_vehicle(vehicle) then
                                    if not VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle) then
                                        VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, true)
                                    end
                                    switch wheel do
                                        case "Front":
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 0, true, 1000.0)
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 1, true, 1000.0)
                                        break
                                        case "Back":
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 4, true, 1000.0)
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 5, true, 1000.0)
                                        break
                                        case "Left":
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 4, true, 1000.0)
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 0, true, 1000.0)
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 2, true, 1000.0) -- 6 wheels trailer, plane or jet is first one on left
                                        break
                                        case "Right":
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 5, true, 1000.0)
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 1, true, 1000.0)
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, 3, true, 1000.0) --6 wheels trailer, plane or jet is first one on right
                                        break
                                        case "Random":
                                            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, math.random(0,5), true, 1000.0)
                                        break
                                        case "All":
                                            for wheelId = 0, 5 do
                                                VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, wheelId, true, 1000.0)
                                            end
                                        break
                                    end
                                    util.yield(450)
                                    for wheelId = 0, 5 do
                                        if VEHICLE.IS_VEHICLE_TYRE_BURST(vehicle, wheelId, true) then
                                            VEHICLE.SET_VEHICLE_TYRE_FIXED(vehicle, wheelId)
                                        end
                                    end
                                else
                                    util.toast("Couldn't get control of "..PlayerName(playerID).."'s vehicle")
                                end
                                break
                        case "Lose Parts":
                            if isMK2 or isRC then break end
                            if VEHICLE.IS_THIS_MODEL_A_PLANE(ENTITY.GET_ENTITY_MODEL(vehicle)) then
                                if VEHICLE.GET_VEHICLE_BODY_HEALTH(vehicle) >= 500 and ENTITY.IS_ENTITY_IN_AIR(vehicle) and ENTITY.GET_ENTITY_SPEED(vehicle) >= 65 then
                                    PlacePole(playerID)
                                    if inform.toggle then
                                        util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nDetaching a wing...")
                                    end
                                else
                                    if inform.toggle then
                                        util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nWait for them to take off for maximum effect...")
                                    end
                                    util.yield(700)
                                end
                            elseif VEHICLE.IS_THIS_MODEL_A_HELI(ENTITY.GET_ENTITY_MODEL(vehicle)) then
                                if ENTITY.IS_ENTITY_IN_AIR(vehicle) and VEHICLE.GET_HELI_TAIL_ROTOR_HEALTH(vehicle) >= 1 then
                                    menu.trigger_commands("breakofftailboom"..PlayerName(playerID))
                                    if inform.toggle then
                                        util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nBreaking off there tail...")
                                    end
                                    break
                                end
                            else
                                if vehicle_doors_count then
                                    if inform.toggle then
                                        util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nDetaching there parts...")
                                    end
                                    control_vehicle(vehicle)
                                        if VEHICLE.GET_VEHICLE_NUM_OF_BROKEN_OFF_PARTS(vehicle) >= vehicle_doors_count then
                                            VEHICLE.SET_VEHICLE_FIXED(vehicle)
                                        end
                                        switch part do
                                            case "Left doors":
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 0)
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 2)
                                            break
                                            case "Right doors":
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 1)
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 3)
                                            break
                                            case "Hood":
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 4)
                                            break
                                            case "Trunk":
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 5)
                                            break
                                            case "Front doors":
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 1)
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 0)
                                            break
                                            case "Back doors":
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 2)
                                                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, 3)
                                            break
                                            case "Random Doors":
                                                for i = 0, NumDoorsToBreak do
                                                    VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, math.random(0, vehicle_doors_count))
                                                end
                                            break
                                            case "All Doors":
                                                for doorId = 0, vehicle_doors_count do
                                                    VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, doorId)
                                                end
                                            break
                                            case "Wheels":
                                                local wheelsToRemove = {}
                                                local wheelIndex
                                                for i = 1, NumWheelsToBreak do
                                                    wheelIndex = math.random(0, 5)
                                                    table.insert(wheelsToRemove, wheelIndex)
                                                end
                                                if wheelIndex == 2 then
                                                    wheelIndex = 1
                                                    table.insert(wheelsToRemove, wheelIndex)     --doing this because wheelIndex 2 and 3 is only valid on 6wheel trailers or planes
                                                elseif wheelIndex == 3 then
                                                    wheelIndex = 4
                                                    table.insert(wheelsToRemove, wheelIndex)
                                                end
                                                for _, wheelIndex in ipairs(wheelsToRemove) do
                                                    entities.detach_wheel(vehicle, wheelIndex)
                                                end
                                                wheelsToRemove = {}
                                            break
                                        end
                                        util.yield(900)
                                        VEHICLE.SET_VEHICLE_FIXED(vehicle)
                                        break
                                    
                                else
                                    util.toast("I did nothing, because " .. PlayerName(playerID) .. "'s "..vehicle_display_name(vehicle).." has no doors.\nUse a different punishment. :)")
                                    break
                                end
                            end
                            break
                        case "Explode":
                            if inform.toggle then
                                util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nExploding there Car...")
                            end
                            if not PLAYER.IS_PLAYER_DEAD(playerID) then
                                orb_strike_player(playerID)
                            end
                            break
                        case "Delete":
                            if inform.toggle then
                                util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nErasing there Car...")
                            end
                            control_vehicle(vehicle)
                            entities.delete_by_handle(vehicle)
                            break
                        case "Destroy Engine":
                            if VEHICLE.GET_VEHICLE_ENGINE_HEALTH(vehicle) <= -4000 then break end
                            if control_vehicle(vehicle) then
                                if isRC then
                                    if inform.toggle then
                                        util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nThis has no Engine.\nExploding it...")
                                    end
                                    VEHICLE.SET_VEHICLE_TIMED_EXPLOSION(vehicle, playerID, true)
                                    break
                                end
                                if inform.toggle then
                                    util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nKilling there Engine...")
                                end
                                VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -4000)
                                break
                            else
                                util.toast("Couldn't get control of "..PlayerName(playerID).."'s vehicle")
                            end
                            break
                        case "EMP":
                            if inform.toggle then
                                util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nEMP shocking the Vehicle...")
                            end
                            emp_shock_player(playerID)
                            break
                        case "Flip":
                            if control_vehicle(vehicle) then
                                flip_vehicle_vertical(vehicle)
                                if inform.toggle then
                                    util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nVehicle turned upside down...")
                                end
                            else
                                util.toast("Couldn't get control of "..PlayerName(playerID).."'s vehicle")
                            end
                            break
                        case "Slingshot":
                            if inform.toggle then
                                util.toast(PlayerName(playerID).." is using a "..vehicle_display_name(vehicle)..".\nPushing the vehicle into the sky...")
                            end
                            slingshot_vehicle(vehicle)
                            break
                    end
                    local delay = punishmentDelays[V_punishment] or vehDelay
                    util.yield(delay * 1000)
                end
            end
        end
    end
end

----------------------------------------------------------
---CHECK ENTIRE LOBBY FOR GODMODE
----------------------------------------------------------
local godpid = {}
function CheckAllPlayersForGod()
    local pList = players.list_except(true, true, false, false)
    if not NETWORK.NETWORK_IS_IN_SESSION() then --Check if currently in a lobby
        inform.normal_w_name("You should join a session first.")
        return
    end
    if NETWORK.NETWORK_GET_NUM_CONNECTED_PLAYERS() <= 1 then --Check if user is the only one in the lobby
        inform.normal_w_name("You are the only one in this lobby.")
        return
    end
    for index, playerID in ipairs(pList) do
        if not DoesTableContainValue(godpid, playerID) and players.is_godmode(playerID) then --check if player is already known as godmode and if he is in godmode
            if not players.is_in_interior(playerID) and not NETWORK.NETWORK_IS_PLAYER_FADING(playerID) and ENTITY.IS_ENTITY_VISIBLE(PlayerPed(playerID)) then --other checks to not get a false-positive
                if not PLAYER.IS_PLAYER_READY_FOR_CUTSCENE(playerID) and not NETWORK.IS_PLAYER_IN_CUTSCENE(playerID) and not NETWORK.NETWORK_IS_PLAYER_IN_MP_CUTSCENE(playerID) then --more checks to not get a false-positive
                    table.insert(godpid, playerID) --add playerID to the table
                end
            end
        end
    end
    if #godpid > 0 then
        return godpid --return table
    else
        return
    end
end

----------------------------------------------------------------
--KICK GODS
----------------------------------------------------------------
function KickAllGods()
    local maxInteractions = 3
    local gods = CheckAllPlayersForGod()
    if gods == nil then
        inform.normal_w_name("No players in godmode found.")
        return
    end

    util.toast("Masskick in progress, please hold...") --Inform user
    util.yield(300)
    for interaction = 1, maxInteractions do
        for _, playerID in ipairs(gods) do
            util.yield(250)
            menu.trigger_commands("kick"..PlayerName(playerID)) --Kick gods
            gods[_] = nil --Delete kicked player from table
        end
        util.yield(800 + interaction * 15)
    end

    inform.normal_w_name("Masskick finished!")
    godpid = {} --Reset table, just to be sure
end

----------------------------------------------------------------
--KICK AND BLOCK GODS
----------------------------------------------------------------
function KickandBlockGods()
    local BlockedPlayers = {}
    local gods = CheckAllPlayersForGod()
    if gods == nil then
        inform.normal_w_name("No players to block found.")
        return
    end

    util.toast("Looking for players to block from joining again...")
    for index, playerID in ipairs(gods) do
        util.yield(100)
        local Player = PlayerName(playerID)
        if not DoesTableContainValue(BlockedPlayers, Player) then
            table.insert(BlockedPlayers, Player)
        end
        local ref_path = "Online>Player History>"..Player..">Player Join Reactions>Block Join"
        local menuPath = menu.ref_by_path(ref_path)

        if not pcall(menu.get_value, menuPath) then
            ref_path = "Online>Player History>"..Player.." [Public]>Player Join Reactions>Block Join"
            menuPath = menu.ref_by_path(ref_path)

            if not pcall(menu.get_value, menuPath) then
                for _, status in ipairs(player_status) do
                    ref_path = "Online>Player History>"..Player.." ["..status.."]>Player Join Reactions>Block Join"
                    menuPath = menu.ref_by_path(ref_path)

                    if pcall(menu.get_value, menuPath) and menuPath.value == false then
                        menuPath.value = true
                        break
                    end
                end
                util.yield(400)
                if not pcall(menu.get_value, menuPath) then
                    inform.error("Failed to set Block Join reaction for "..Player..".")
                    return
                end
            elseif menuPath.value == false then
                menuPath.value = true
            end
        elseif menuPath.value == false then
            menuPath.value = true
        end
    end

    util.yield(900)
    table.save(BlockedPlayers, BlockGodsFile)
    KickAllGods()
    BlockedPlayers = {}
end

function removeGodBlocks()
    if not filesystem.exists(BlockGodsFile) then --check if file exist
        inform.normal_w_name("There are no previously blocked players available.")
        return
    end
    local read_BlockGodsFile = io.open(BlockGodsFile, "r")
    if read_BlockGodsFile:seek("end") == 0 then --check if file is empty
        inform.normal_w_name("There are no previously blocked players available.")
        return
    end

    local blocked_pl_tbl = table.load(BlockGodsFile)
    for _, Playername in ipairs(blocked_pl_tbl) do
        local ref_path = "Online>Player History>"..Playername..">Player Join Reactions>Block Join"
        local menuPath = menu.ref_by_path(ref_path)

        if not pcall(menu.get_value, menuPath) then
            ref_path = "Online>Player History>"..Playername.." [Public]>Player Join Reactions>Block Join"
            menuPath = menu.ref_by_path(ref_path)

            if not pcall(menu.get_value, menuPath) then
                for __, status in ipairs(player_status) do
                    ref_path = "Online>Player History>"..Playername.." ["..status.."]>Player Join Reactions>Block Join"
                    menuPath = menu.ref_by_path(ref_path)

                    if pcall(menu.get_value, menuPath) and menuPath.value == true then
                        menuPath.value = false
                        break
                    end
                end
                util.yield(400)
                if not pcall(menu.get_value, menuPath) then
                    inform.error("Failed to remove Block Join reaction for "..Playername..".")
                    util.log("["..SCRIPT_FILENAME.."] :ERROR: Could not find "..string.upper(Playername).." join reactions.")
                    blocked_pl_tbl[GetValueIndexFromTable(blocked_pl_tbl, Playername)] = nil
                    break
                end
            elseif menuPath.value == true then
                menuPath.value = false
            end
        elseif menuPath.value == true then
            menuPath.value = false
        end
    end

    util.yield(400)
    io.open(BlockGodsFile, "w"):close() --empty file to clear memory of all previously blocked players
    --os.remove(BlockGodsFile)
    inform.normal_w_name("All the join blocks are now removed.")
end

----------------------------------------------------------------
--UPDATER
----------------------------------------------------------------
--[[This is just my first test for an updater. If it bugs to much/not works at all, i'll most likely us auto-updater from hexarobi]]--

function update()
    async_http.init("raw.githubusercontent.com", "/MrWalll/FairFight/main/lib/FF_Tables.lua", function(newtables) --update tables file
        local mf = io.open(lib_dir.."FF_Tables.lua", "wb")
        if not mf then --check if file is valid/existent
            util.toast("Could not update the lua.")
            util.log("Failed to write to file: FF_Tables.lua")
        end
        mf:write(newtables) --overwrite local file with new version
        mf:close() -- close to save changes
        util.toast("Successfully updated (FF_Tables).") -- inform user of conform update progress
    end)
    async_http.dispatch()
    util.yield(500)
    async_http.init("raw.githubusercontent.com", "/MrWalll/FairFight/main/resources/FF_Loadouts.lua", function(newloadouts) --update loadout file
        local mf = io.open(lib_dir.."FF_Loadouts.lua", "wb")
        if not mf then
            util.toast("Could not update the lua.")
            util.log("Failed to write to file: FF_Loadouts.lua")
        end
        mf:write(newloadouts)
        mf:close()
        util.toast("Successfully updated (FF_Loadouts).")
    end)
    async_http.dispatch()
    util.yield(550)
    async_http.init("raw.githubusercontent.com", "/MrWalll/FairFight/main/lib/FF_Functions.lua", function(newfunctions) --update functions file
        local mf = io.open(lib_dir..SCRIPT_FILENAME, "wb")
        if not mf then
            util.toast("Could not update the lua.")
            util.log("Failed to write to file: "..SCRIPT_FILENAME)
        end
        mf:write(newfunctions)
        mf:close()
        util.toast("Successfully updated ("..SCRIPT_FILENAME..").")
    end)
    async_http.dispatch()
end

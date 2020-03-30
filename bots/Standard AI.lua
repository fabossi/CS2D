--------------------------------------------------
-- CS2D Standard Bot AI                         --
-- V1: 01.08.2010 - www.UnrealSoftware.de       --
-- Last Update: 26.04.2017                      --
--                                              --
-- Used prefixes in this script                 --
-- ai_ = AI function (AI API, invoked by CS2D)  --
-- vai_ = AI variable                           --
-- fai_ = AI helper function                    --
--                                              --
--------------------------------------------------

-- Includes
dofile("bots/includes/settings.lua")	-- track settings
dofile("bots/includes/general.lua")		-- general helper functions
dofile("bots/includes/buy.lua")			-- buying
dofile("bots/includes/decide.lua")		-- decision making process
dofile("bots/includes/engage.lua")		-- engage/attack/battle (find target and attack)
dofile("bots/includes/fight.lua")		-- fight (attack if target is set)
dofile("bots/includes/follow.lua")		-- follow another player
dofile("bots/includes/collect.lua")		-- collect good nearby items
dofile("bots/includes/radio.lua")		-- radio message handling
dofile("bots/includes/bomb.lua")		-- bomb planting and defusing
dofile("bots/includes/hostages.lua")	-- rescue hostages

-- Setting Cache
vai_set_gm=0							-- Game Mode Setting (equals "sv_gamemode", Cache)
vai_set_botskill=0						-- Bot Skill Setting (equals "bot_skill", Cache)
vai_set_botweapons=0					-- Bot Weapons Setting (equals "bot_weapons", Cache)
vai_set_debug=0							-- Debug Setting (equals "debugai", Cache)
fai_update_settings()

-- Per Player Variables
vai_mode={}; vai_smode={}				-- current mode (state) and sub-mode (sub-state / parameter)
vai_timer={}							-- timer
vai_destx={}; vai_desty={}				-- destination x|y
vai_aimx={}; vai_aimy={}				-- aim at x|y
vai_px={}; vai_py={}					-- previous x|y
vai_target={}							-- target
vai_reaim={}; vai_rescan={}				-- re-aim / re-scan (line of fire checks)
vai_itemscan={}							-- item scan countdown (for collecting items)
vai_buyingdone={}						-- buying done?
vai_radioanswer={}						-- radio answer?
vai_radioanswert={}						-- radio answer timer
for i=1,32 do
	vai_mode[i]=-1; vai_smode[i]=0
	vai_timer[i]=0
	vai_destx[i]=0; vai_desty[i]=0
	vai_aimx[i]=0; vai_aimy[i]=0
	vai_px[i]=0; vai_px[i]=0
	vai_target[i]=0 
	vai_reaim[i]=0; vai_rescan[i]=0
	vai_itemscan[i]=0
	vai_buyingdone[i]=0
	vai_radioanswer[i]=0; vai_radioanswert[i]=0
end

-- "ai_onspawn" - AI On Spawn Function
-- This function is called by CS2D automatically after each spawn of a bot
-- Parameter: id = player ID of the bot
function ai_onspawn(id)
	-- reload settings
	fai_update_settings()
	
	-- reset variables for the spawned bot
	vai_mode[id]=-1; vai_smode[id]=0
	vai_timer[id]=math.random(1,10)
	vai_destx[id]=0; vai_desty[id]=0
	vai_aimx[id]=player(id,"x")-50+math.random(0,100)
	vai_aimy[id]=player(id,"y")-50+math.random(0,100)
	vai_px[id]=player(id,"x")
	vai_py[id]=player(id,"y")
	vai_target[id]=0
	vai_reaim[id]=0; vai_rescan[id]=0
	vai_itemscan[id]=1000
	vai_buyingdone[id]=0
	vai_radioanswer[id]=0; vai_radioanswert[id]=0;
end

-- "ai_update_living" - AI Update Living Function
-- This function is called by CS2D automatically for each *LIVING* bot each frame
-- Parameter: id = player ID of the bot
function ai_update_living(id)

	-- Engage / Aim
	-- scan surroundings for close enemies and attack them if possible
	fai_engage(id)
	
	-- bot might get kicked or killed for teamkills etc - check if it is still in-game
	if not player(id,"exists") then
		return
	elseif player(id,"team")<=0 or player(id,"health")<=0 then
		return
	end
	
	-- Send radio answer when radio answer timer expires
	if vai_radioanswert[id]>0 then
		-- decrease timer
		vai_radioanswert[id]=vai_radioanswert[id]-1
		if vai_radioanswert[id]<=0 then
			-- send answer and reset timer
			ai_radio(id,vai_radioanswer[id])
			vai_radioanswer[id]=0; vai_radioanswert[id]=0
		end
	end
		
	-- Collect nearby items
	fai_collect(id)
	
	-- Set AI Debug Output (only visible if CS2D setting "debugai" is set to 1)
	if vai_set_debug then
		ai_debug(id,"m:"..vai_mode[id]..", sm:"..vai_smode[id].." ta:"..vai_target[id].." ti:"..vai_timer[id])
	end
	
	-- The AI is basically a state machine
	-- vai_mode contains the current state, vai_smode contains a sub mode or parameter for the state
	
	if vai_mode[id]==0 then
		-- ############################################################ 0: IDLE -> decide what to do next
		vai_timer[id]=0; vai_smode[id]=0
		fai_decide(id)
		
	elseif vai_mode[id]==1 then
		-- ############################################################ 1: CAMP -> do nothing (wait)
		fai_wait(id,0)
		
	elseif vai_mode[id]==2 then
		-- ############################################################ 2: GOTO -> go to destination
		local result=ai_goto(id,vai_destx[id],vai_desty[id])
		if result==1 then
			vai_mode[id]=0
		elseif result==0 then
			vai_mode[id]=0
		else
			fai_walkaim(id)
		end
		
	elseif vai_mode[id]==3 then
		-- ############################################################ 3: ROAM -> randomly run around
		if ai_move(id,vai_smode[id])==0 then
			-- Bot failed to walk (way blocked) -> turn
			if (id%2)==0 then
				vai_smode[id]=vai_smode[id]+45
			else
				vai_smode[id]=vai_smode[id]-45
			end
			vai_timer[id]=math.random(150,250)
		end
		fai_walkaim(id)
		fai_wait(id,0)

	elseif vai_mode[id]==4 then
		-- ############################################################ 4: FIGHT -> fight
		fai_fight(id)

	elseif vai_mode[id]==5 then
		-- ############################################################ 5: HUNT -> hunt another player
		if player(vai_smode[id],"exists") then
			if player(vai_smode[id],"health")>0 then
				if ai_goto(id,player(vai_smode[id],"tilex"),player(vai_smode[id],"tiley"))~=2 then
					vai_mode[id]=0
				end
				return
			end
		end
		-- End Hunt
		vai_mode[id]=0
		
	elseif vai_mode[id]==6 then
		-- ############################################################ 6: COLLECT -> collect item
		if ai_goto(id,vai_destx[id],vai_desty[id])~=2 then
			vai_mode[id]=0
			vai_itemscan[id]=140
		else
			fai_walkaim(id)
		end
		
	elseif vai_mode[id]==7 then
		-- ############################################################ 7: FOLLOW -> follow another player
		fai_follow(id)
		
	elseif vai_mode[id]==8 then
		-- ############################################################ 8: FLASHED -> run around randomly because flashed
		if ai_goto(id,vai_destx[id],vai_desty[id])~=2 then
			fai_randomadjacent(id)
		end
		-- End Flash
		if player(id,"ai_flash")==0 then
			vai_mode[id]=0
		end
	
	elseif vai_mode[id]==50 then
		-- ############################################################ 50: RESCUE -> rescue hostages
		fai_rescuehostages(id)

	elseif vai_mode[id]==51 then
		-- ############################################################ 51: PLANT -> plant bomb
		fai_plantbomb(id)
		
	elseif vai_mode[id]==52 then
		-- ############################################################ 52: DEFUSE -> defuse bomb
		fai_defuse(id)
	
	elseif vai_mode[id]==-1 then
		-- ############################################################ -1: BUY -> buy equipment
		fai_buy(id)
	
	else
		-- ############################################################ INVALID MODE -> select new mode
		-- This state should never be reached under normal circumstances
		if vai_set_debug then
			print("invalid AI mode: "..vai_mode[id])
		end
		vai_mode[id]=0
	end
		
end

-- "ai_update_dead" - AI Update Dead Function
-- This function is called by CS2D automatically for each *DEAD* bot each second
-- Parameter: id = player ID of the bot
function ai_update_dead(id)
	-- Try to respawn (if not in normal gamemode)
	fai_update_settings()
	if vai_set_gm~=0 then
		ai_respawn(id)
	end
end

-- "ai_hear_radio" - AI Hear Radio
-- This function is called once for each radio message
-- Parameter: source = player ID of the player who sent the radio message
-- Parameter: radio = radio message ID
function ai_hear_radio(source,radio)
	fai_radio(source,radio)
end

-- "ai_hear_chat" - AI Hear Chat
-- This function is called once for each chat message
-- Parameter: source = player ID of the player who sent the radio message
-- Parameter: msg = chat text message
-- Parameter: teamonly = team only chat message (1) or public chat message (0)
function ai_hear_chat(source,msg,teamonly)
	-- This bot implementation simply ignores all chat messages
end
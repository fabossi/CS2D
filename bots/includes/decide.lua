
-- Find destination / mode
function fai_decide(id)
	local team=player(id,"team")
	
	-- Buy?!
	if vai_buyingdone[id]~=1 then
		vai_mode[id]=-1; vai_smode[id]=0
		vai_timer[id]=math.random(1,10)
		vai_buyingdone[id]=1
		return
	end
	
	if vai_set_gm==4 then
		-- ############################################################ Game Mode 4: Zombies
		if team==1 then
			------------------- Terrorists (Zombies)
			local r=math.random(1,3)
			if r<=2 then
				-- Goto CT Spawn / Botnode
				if map("botnodes")>0 and math.random(0,2)==1 then
					vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
					vai_mode[id]=2
				else
					vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
					vai_mode[id]=2
				end
			else
				-- Goto T Spawn
				vai_destx[id],vai_desty[id]=randomentity(0) -- info_t
				vai_mode[id]=2
			end
		else
			------------------- Counter-Terrorists
			local r=math.random(1,3)
			if r==1 then
				-- Goto T Spawn
				vai_destx[id],vai_desty[id]=randomentity(0) -- info_t
				vai_mode[id]=2
			else
				-- Goto CT Spawn / Botnode
				if map("botnodes")>0 and math.random(0,2)==1 then
					vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
					vai_mode[id]=2
				else
					vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
					vai_mode[id]=2
				end
			end
		end
		
		
	else
		-- ############################################################ Other Game Modes
		
		if map("mission_vips")>0 then
			-- ############################################################ AS_ Maps
			if team==1 then
				------------------- Terrorists
				local r=math.random(1,3)
				if r==1 then
					-- Protect Escape Point
					vai_destx[id],vai_desty[id]=randomentity(6) -- info_escapepoint
					vai_mode[id]=2
				elseif r==2 then
					-- Goto CT Spawn / Botnode
					if map("botnodes")>0 and math.random(0,2)==1 then
						vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
						vai_mode[id]=2
					else
						vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
						vai_mode[id]=2
					end
				else
					-- Goto VIP Spawn
					vai_destx[id],vai_desty[id]=randomentity(2) -- info_vip
					vai_mode[id]=2
				end
			elseif team==2 then
				------------------- Counter-Terrorists
				local r=math.random(1,2)
				if r==1 then
					-- Secure Escape Point
					vai_destx[id],vai_desty[id]=randomentity(6) -- info_escapepoint
					vai_mode[id]=2
				else
					-- Goto T Spawn / Botnode
					if map("botnodes")>0 and math.random(0,2)==1 then
						vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
						vai_mode[id]=2
					else
						vai_destx[id],vai_desty[id]=randomentity(0) -- info_t
						vai_mode[id]=2
					end
				end
			elseif team==3 then
				------------------- VIP
				if map("botnodes")>0 and math.random(0,2)==1 then
					-- Goto Botnode
					vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
					vai_mode[id]=2
				else
					-- Goto Escape Popint
					vai_destx[id],vai_desty[id]=randomentity(6) -- info_escapepoint
					vai_mode[id]=2
				end
			end
			
		elseif map("mission_hostages")>0 then
			-- ############################################################ CS_ Maps
			if team==1 then
				------------------- Terrorists
				local r=math.random(1,3)
				if r==1 then
					-- Goto Hostagespawns
					vai_destx[id],vai_desty[id]=randomentity(3) -- info_hostage
					vai_mode[id]=2
				elseif r==2 then
					-- Goto CT Spawn / Botnode
					if map("botnodes")>0 and math.random(0,2)==1 then
						vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
						vai_mode[id]=2
					else
						vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
						vai_mode[id]=2
					end
				else
					-- Goto Rescuepoint
					vai_destx[id],vai_desty[id]=randomentity(4) -- info_rescuepoint
					vai_mode[id]=2
				end
			else
				------------------- Counter-Terrorists
				local r=math.random(1,5)
				if r==1 then
					-- Goto T Spawn / Botnode
					if map("botnodes")>0 and math.random(0,2)==1 then
						vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
						vai_mode[id]=2
					else
						vai_destx[id],vai_desty[id]=randomentity(0) -- info_t
						vai_mode[id]=2
					end
				else
					-- Rescue Hostage
					vai_destx[id],vai_desty[id]=randomhostage(1)
					vai_mode[id]=50; vai_smode[id]=0
				end
			end
				
		elseif map("mission_bombspots")>0 then
			-- ############################################################ DE_ Maps
			if team==1 then
				------------------- Terrorists
				local r=math.random(1,2)
				if r==1 then
					-- Goto Bombspot
					vai_destx[id],vai_desty[id]=randomentity(5) -- info_bombspot
					if player(id,"bomb") then
						vai_mode[id]=51; vai_smode[id]=0; vai_timer[id]=0
					else
						vai_mode[id]=2
					end
				else
					-- Goto CT Spawn / Botnode
					if map("botnodes")>0 and math.random(0,2)==1 then
						vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
						vai_mode[id]=2
					else
						vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
						vai_mode[id]=2
					end
				end
			else
				------------------- Counter-Terrorists
				if game("bombplanted") then
					-- Find & Defuse Bomb
					vai_destx[id],vai_desty[id]=randomentity(5,0)
					vai_mode[id]=52; vai_smode[id]=0
				else
					local r=math.random(1,2)
					if r==1 then
						-- Protect Bombspot
						vai_destx[id],vai_desty[id]=randomentity(5) -- info_bombspot
						vai_mode[id]=2
					else
						-- Goto T Spawn / Botnode
						if map("botnodes")>0 and math.random(0,2)==1 then
							vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
							vai_mode[id]=2
						else
							vai_destx[id],vai_desty[id]=randomentity(0) -- info_t
							vai_mode[id]=2
						end
					end
				end
			end
		
		elseif map("mission_ctfflags")>0 then
			-- ############################################################ CTF_ Maps
			if team==1 then
				------------------- Terrorists
				if player(id,"flag") then
					if entity(player(id,"tilex"),player(id,"tiley"),"type")==15 and entity(player(id,"tilex"),player(id,"tiley"),"int0")==0 then
						-- Can't return! Retry!
						vai_mode[id]=3
						vai_timer[id]=math.random(150,300)
						vai_smode[id]=math.random(0,360)
					else
						-- Return Flag
						vai_destx[id],vai_desty[id]=randomentity(15,0,0) -- info_ctf (T flag)
						vai_mode[id]=2
					end
				else
					local r=math.random(1,3)
					if r==1 then
						-- Get Flag!
						vai_destx[id],vai_desty[id]=randomentity(15,0,1) -- info_ctf (CT flag)
						vai_mode[id]=2
					else
						-- Goto CT Spawn / Botnode
						if map("botnodes")>0 and math.random(0,2)==1 then
							vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
							vai_mode[id]=2
						else
							vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
							vai_mode[id]=2
						end
					end
				end
			else
				-- ############################################################ Counter-Terrorists
				if player(id,"flag") then
					if entity(player(id,"tilex"),player(id,"tiley"),"type")==15 and entity(player(id,"tilex"),player(id,"tiley"),"int0")==1 then
						-- Can't return! Retry!
						vai_mode[id]=3
						vai_timer[id]=math.random(150,300)
						vai_smode[id]=math.random(0,360)
					else
						-- Return Flag
						vai_destx[id],vai_desty[id]=randomentity(15,0,1) -- info_ctf (CT flag)
						vai_mode[id]=2
					end
				else
					local r=math.random(1,3)
					if r==1 then
						-- Get Flag!
						vai_destx[id],vai_desty[id]=randomentity(15,0,0) -- info_ctf (T flag)
						vai_mode[id]=2
					else
						-- Goto T Spawn / Botnode
						if map("botnodes")>0 and math.random(0,2)==1 then
							vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
							vai_mode[id]=2
						else
							vai_destx[id],vai_desty[id]=randomentity(0) -- info_t
							vai_mode[id]=2
						end
					end
				end
			end
		
		elseif map("mission_dompoints")>0 then
			-- ############################################################ DOM_ Maps
			if team==1 then
				------------------- Terrorists
				local r=math.random(1,5)
				if r<=4 then
					-- Dominate!
					vai_destx[id],vai_desty[id]=randomentity(17,0,2) -- info_dom (CT dominated)
					vai_mode[id]=2
				end
			else
				------------------- Counter-Terrorists
				local r=math.random(1,5)
				if r<=4 then
					-- Dominate!
					vai_destx[id],vai_desty[id]=randomentity(17,0,1) -- info_dom (T dominated)
					vai_mode[id]=2
				end
			end
		
		else
			-- ############################################################ Maps without special goal/mission
			if team==1 then
				------------------- Terrorists
				local r=math.random(1,3)
				if r<=2 then
					-- Goto CT Spawn / Botnode
					if map("botnodes")>0 and math.random(0,2)==1 then
						vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
						vai_mode[id]=2
					else
						vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
						vai_mode[id]=2
					end
				else
					-- Goto T Spawn
					vai_destx[id],vai_desty[id]=randomentity(0) -- info_t
					vai_mode[id]=2
				end
			else
				------------------- Counter-Terrorists
				local r=math.random(1,3)
				if r<=2 then
					-- Goto T Spawn / Botnode
					if map("botnodes")>0 and math.random(0,2)==1 then
						vai_destx[id],vai_desty[id]=randomentity(19) -- info_botnode
						vai_mode[id]=2
					else
						vai_destx[id],vai_desty[id]=randomentity(0) -- info_t
						vai_mode[id]=2
					end
				else
					-- Goto CT Spawn
					vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
					vai_mode[id]=2
				end
			end
		
		end
		
	end
	
	-- Check Decision Results
	if vai_mode[id]==2 then
		-- No correct destination found?!
		if vai_destx[id]==-100 then
			-- ROAM!
			vai_mode[id]=3
			vai_timer[id]=math.random(150,300)
			vai_smode[id]=math.random(0,360)
		end
	end
		
end
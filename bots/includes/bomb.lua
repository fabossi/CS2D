function fai_plantbomb(id)
	-- Check if bot still has the bomb
	if not player(id,"bomb") then
		-- Has no bomb anymore! no planting!
		vai_mode[id]=0
		return
	end
	
	-- On bombspot?
	if tile(player(id,"tilex"),player(id,"tiley"),"entity")~=0 then
		if inentityzone(player(id,"tilex"),player(id,"tiley"),5) then
			-- Bomb selected?
			if player(id,"weapontype")~=55 then
				-- Select bomb!
				ai_selectweapon(id,55)
			else
				-- Plant
				if vai_timer[id]==0 then
					ai_radio(id,6) -- cover me!
					vai_timer[id]=1
				end
				ai_attack(id)
			end
			return
		end
	end
	
	-- Not on bombspot -> Goto bombspot!
	if ai_goto(id,vai_destx[id],vai_desty[id])~=2 then
		vai_destx[id],vai_desty[id]=randomentity(5) -- info_bombspot
	else
		fai_walkaim(id)
	end
end

function fai_defuse(id)
	if vai_smode[id]==0 then
		-- Check Bombspot
		if ai_goto(id,vai_destx[id],vai_desty[id])~=2 then
			vai_destx[id],vai_desty[id]=randomentity(5,0) -- info_bombspot
		else
			fai_walkaim(id)
		end
		
		-- Close to spot? Check
		if math.abs(player(id,"tilex")-vai_destx[id])<7 and math.abs(player(id,"tiley")-vai_desty[id])<7 then
			local it=item(0,"table")
			for i=1,#it do
				if item(it[i],"type")==63 then
					if math.abs(player(id,"tilex")-item(it[i],"x"))<10 and math.abs(player(id,"tiley")-item(it[i],"y"))<10 then
						-- Bomb at spot!
						vai_destx[id]=item(it[i],"x")
						vai_desty[id]=item(it[i],"y")
						vai_smode[id]=1
						return
					end
				end
			end
			-- No bomb at spot!
			setentityaistate(vai_destx[id],vai_desty[id],1)
			ai_radio(id,5) -- sector clear!
			local bots=player(0,"table")
			for i=1,#bots do
				if player(bots[i],"bot")==1 then
					if vai_mode[bots[i]]==52 and vai_destx[bots[i]]==vai_destx[id] and vai_desty[bots[i]]==vai_desty[id] then
						vai_destx[bots[i]],vai_desty[bots[i]]=randomentity(5,0)
						vai_smode[bots[i]]=0
					end
				end
			end
			vai_destx[id],vai_desty[id]=randomentity(5,0) -- info_bombspot
			return
		end
	else
		-- Defuse Bomb
		local result=ai_goto(id,vai_destx[id],vai_desty[id])
		if result==1 then
			-- Defuse!
			if vai_timer[id]==0 then
				ai_radio(id,6) -- cover me!
				vai_timer[id]=1
			end
			ai_use(id)
		elseif result==0 then
			-- Failed to reach bomb
			vai_mode[id]=0
		end
	end
end
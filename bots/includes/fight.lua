
-- If player has a valid target, fight it with the current weapon
-- Otherwise find a new goal
function fai_fight(id)
	if player(vai_target[id],"exists") then
		if player(vai_target[id],"health")>0 then
			-- Melee Combat?
			if itemtype(player(id,"weapontype"),"range")<50 then
				-- Yes, melee! Run to target
				if ai_goto(id,player(vai_target[id],"tilex"),player(vai_target[id],"tiley"))~=2 then
					vai_mode[id]=0
				end
			else
				-- No melee, regular combat!
				vai_timer[id]=vai_timer[id]-1
				if vai_timer[id]<=0 then
					vai_timer[id]=math.random(50,150)
					vai_smode[id]=math.random(0,360)
					-- Hunt?
					if math.random(1,2)==1 then
						if player(id,"health")>50 then
							if math.abs(player(id,"x")-player(vai_target[id],"x"))>230 and math.abs(player(id,"y")-player(vai_target[id],"y"))>180 then
								vai_mode[id]=5
								vai_smode[id]=vai_target[id]
							end
						end
					end
				end
				if ai_move(id,vai_smode[id])==0 then
					-- Bot failed to walk (way blocked) -> turn
					if (id%2)==0 then
						vai_smode[id]=vai_smode[id]+45
					else
						vai_smode[id]=vai_smode[id]-45
					end
					vai_timer[id]=math.random(50,150)
				end
			end
			return
		end
	end
	
	-- No valid target -> end fight and find a new goal
	vai_mode[id]=0
end

-- Follow the player stored in vai_smode.
-- If close to target player: roam around (and continue to follow if distance increases)
-- End following if no valid (existing & alive) player is stored in vai_smode.
function fai_follow(id)
	if player(vai_smode[id],"exists") then
		if player(vai_smode[id],"health")>0 then
			if vai_timer[id]>0 then
				-- If followed player is reached: Roam a bit (silently)
				if ai_move(id,vai_destx[id],1)==0 then
					-- Bot failed to walk (way blocked) -> turn
					if (id%2)==0 then
						vai_destx[id]=vai_destx[id]+45
					else
						vai_destx[id]=vai_destx[id]-45
					end
					vai_timer[id]=math.random(3,5)*50
				end
				
				vai_timer[id]=vai_timer[id]-1
				if vai_timer[id]==1 then
					vai_timer[id]=math.random(3,5)*50
					vai_destx[id]=math.random(0,360)
				end
				if (vai_timer[id]%25)==0 then
					-- Far away from followed player? Follow again!
					if math.abs(player(id,"tilex")-player(vai_smode[id],"tilex"))>3 and math.abs(player(id,"tiley")-player(vai_smode[id],"tiley"))>2 then
						vai_timer[id]=0
					end
				end
			else
				-- Try to reach followed player
				if ai_goto(id,player(vai_smode[id],"tilex"),player(vai_smode[id],"tiley"))==1 then
					vai_timer[id]=math.random(3,5)*50
					vai_destx[id]=math.random(0,360)
				end
			end
			fai_walkaim(id)
			return
		end
	end
	
	-- End Follow
	vai_mode[id]=0
end

-- Engage Enemies
function fai_engage(id)

	-- ############################################################ Find Target
	vai_reaim[id]=vai_reaim[id]-1
	if vai_reaim[id]<0 then
		vai_reaim[id]=20
		if player(id,"ai_flash")==0 then
			-- Not flashed!
			vai_target[id]=ai_findtarget(id)
			if vai_target[id]>0 then
				vai_rescan[id]=0
			end
		else
			-- Flashed! No target! Go to flashed mode
			vai_target[id]=0
			if vai_mode[id]~=8 then
				vai_mode[id]=8
				fai_randomadjacent(id)
			end
		end
	end
	
	-- ############################################################ Target in Sight?
	if vai_target[id]>0 then
		if not player(vai_target[id],"exists") then
			-- If target player does not exist anymore -> reset
			vai_target[id]=0
		else
			if player(vai_target[id],"health")>0 and player(vai_target[id],"team")>0 and fai_enemies(vai_target[id],id)==true then
				-- Cache Positions
				local x1=player(id,"x")
				local y1=player(id,"y")
				local x2=player(vai_target[id],"x")
				local y2=player(vai_target[id],"y")
				
				-- In Range?
				if math.abs(x1-x2)<420 and math.abs(y1-y2)<235 then
					-- Freeline Scan
					vai_rescan[id]=vai_rescan[id]-1
					if vai_rescan[id]<0 then
						vai_rescan[id]=10
						if math.abs(x1-x2)>30 or math.abs(y1-y2)>30 then 
							if not ai_freeline(id,x2,y2) then
								vai_target[id]=0
							end
						end
					end
				else
					-- Target player out of range -> reset
					vai_target[id]=0
				end
			else
				-- Target player is dead, spectator or no enemy -> reset
				vai_target[id]=0
			end
		end
	end
	
	-- ############################################################ Aim
	if vai_target[id]>0 then
		vai_aimx[id]=player(vai_target[id],"x")
		vai_aimy[id]=player(vai_target[id],"y")
		-- Switch to Fight Mode
		if vai_mode[id]~=4 and vai_mode[id]~=5 then
			vai_timer[id]=math.random(25,100)
			vai_smode[id]=math.random(0,360)
			vai_mode[id]=4
		end
	end
	ai_aim(id,vai_aimx[id],vai_aimy[id])
	
	-- ############################################################ Attack
	if vai_target[id]>0 then
		-- Right Direction?
		if math.abs(fai_angledelta(tonumber(player(id,"rot")),fai_angleto(player(id,"x"),player(id,"y"),player(vai_target[id],"x"),player(vai_target[id],"y"))))<20 then
			-- Do an "intelligent" attack (this includes automatic weapon selection and reloading)
			ai_iattack(id)
		end
	end

end
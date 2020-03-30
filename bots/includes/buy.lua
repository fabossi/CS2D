--[[

Buying is performed in 5 steps (current step is saved in vai_smode[id] for each player).

Step 1: Buy primary weapon
Step 2: Buy ammo
Step 3: Buy equipment
Step 4: Buy secondary weapon
Step 5: Switch to knife

After vai_mode[id] and vai_smode[id] are set to 0.
vai_buyingdone[id] is set to 1 to indicate that the buy-process is completed.

]]--

function fai_buy(id)
	-- Wait
	if vai_timer[id]>0 then
		-- decrease
		vai_timer[id]=vai_timer[id]-1
	else
		-- waiting done
		local money=player(id,"money")
		-- Steps
		if vai_smode[id]==0 then		
			-- ############################################################ Step 0: primary weapon
			if vai_set_botweapons==0 then
				-- all weapons
				if money<3000 and money>=1700 then
					-- buy low price weapon
					local r=math.random(0,3)
					if r==0 then ai_buy(id,10) end --m3
					if r==1 then
						if player(id,"team")==1 then ai_buy(id,21) else ai_buy(id,23) end -- tmp/mac
					end
					if r==2 then ai_buy(id,24) end -- ump45
					if r==3 then ai_buy(id,20) end -- mp5
					
				elseif money<6000 and money>=3000 then
					-- buy medium price weapon
					local r=math.random(0,3)
					if r<=1 then
						if player(id,"team")==1 then ai_buy(id,30) else ai_buy(id,32) end -- ak47/m4a1
					end
					if r==2 then
						if player(id,"team")==1 then ai_buy(id,38) else ai_buy(id,39) end -- galil/famas
					end
					if r==3 then
						if player(id,"team")==1 then ai_buy(id,31) else ai_buy(id,33) end -- sg552/aug
					end
					
				elseif money>=6000 then
					-- buy high price weapon
					local r=math.random(0,3)
					if r<=1 then
						if player(id,"team")==1 then ai_buy(id,30) else ai_buy(id,32) end -- ak47/m4a1
					end
					if r==2 then ai_buy(id,35) end -- awp
					if r==3 then ai_buy(id,40) end -- m249					
					
				end
				
			elseif vai_set_botweapons==1 then
				-- bot setting: melee only
				-- buy nothing
				
			elseif vai_set_botweapons==2 then
				-- bot setting: pistols only
				if money>=1000 then
					local r=math.random(1,6)
					if not fai_contains(playerweapons(id),r) then ai_buy(id,r) end
				end
				
			elseif vai_set_botweapons==3 then
				-- bot setting: shotguns only
				if not fai_contains(playerweapons(id),10) and not fai_contains(playerweapons(id),11) then
					if money>=3000 then
						if math.random(0,2)==1 then
							ai_buy(id,10) -- m3
						else
							ai_buy(id,11) -- xm1014
						end
					elseif money>=1700 then
						ai_buy(id,10) -- m3
					end
				end
				
			elseif vai_set_botweapons==4 then
				-- bot setting: smgs only
				local weapons=playerweapons(id)
				local hasthistype=false
				for i=1,#weapons do
					if weapons[i]>=20 and weapons[i]<30 then
						hasthistype=true
						break
					end
				end
				if not hasthistype then
					if player(id,"team")==1 then
						if money>=2350 then
							r=math.random(0,3)
							if r==0 then ai_buy(id,20) end -- mp5
							if r==1 then ai_buy(id,22) end -- p90
							if r==2 then ai_buy(id,24) end -- ump45
							if r==3 then ai_buy(id,23) end -- mac10							
						elseif money>=1400 then
							ai_buy(id,23) -- mac10
						end
					else
						if money>=2350 then
							r=math.random(0,3)
							if r==0 then ai_buy(id,20) end -- mp5
							if r==1 then ai_buy(id,22) end -- p90
							if r==2 then ai_buy(id,24) end -- ump45
							if r==3 then ai_buy(id,21) end -- tmp		
						elseif money>=1400 then
							ai_buy(id,21) -- tmp
						end
					end
				end
				
			elseif vai_set_botweapons==5 then
				-- bot setting: rifles only
				local weapons=playerweapons(id)
				local hasthistype=false
				for i=1,#weapons do
					if (weapons[i]>=30 and weapons[i]<=33) or (weapons[i]>=38 and weapons[i]<=39) then
						hasthistype=true
						break
					end
				end
				if not hasthistype then
					if player(id,"team")==1 then
						if money>=3500 then
							r=math.random(0,2)
							if r==0 then ai_buy(id,30) end -- ak47
							if r==1 then ai_buy(id,31) end -- sg552
							if r==2 then ai_buy(id,38) end -- galil						
						elseif money>=2000 then
							ai_buy(id,38) -- galil
						end
					else
						if money>=2000 then
							r=math.random(0,2)
							if r==0 then ai_buy(id,32) end -- m4a1
							if r==1 then ai_buy(id,33) end -- aug
							if r==2 then ai_buy(id,39) end -- famas
						elseif money>=2250 then
							ai_buy(id,39) -- famas
						end
					end
				end
				
			elseif vai_set_botweapons==6 then
				-- bot setting: sniper rifles only
				local weapons=playerweapons(id)
				local hasthistype=false
				for i=1,#weapons do
					if weapons[i]>=34 and weapons[i]<=37 then
						hasthistype=true
						break
					end
				end
				if not hasthistype then
					if money>=5000 then
						r=math.random(0,3)
						if r==0 then ai_buy(id,35) end -- awp
						if r==1 then ai_buy(id,36) end -- g3sg1
						if r==2 then ai_buy(id,37) end -- sg550						
						if r==3 then ai_buy(id,34) end -- scout
					elseif money>=2750 then
						ai_buy(id,34) -- scout
					end
				end
				
			elseif vai_set_botweapons==7 then
				-- bot setting: mgs only
				if money>=5750 then
					if not fai_contains(playerweapons(id),40) then
						ai_buy(id,40) -- m249
					end
				end
			end
		
		elseif vai_smode[id]==1 then
			-- ############################################################ Step 1: ammo
			ai_buy(id,61) -- primary ammo
			ai_buy(id,62) -- secondary ammo
			
		elseif vai_smode[id]==2 then
			-- ############################################################ Step 2: equipment
			if money>300 and vai_set_botweapons==0 then
				if math.random(0,3)==1 then
					ai_buy(id,51) -- he grenade
				end
			end
			
		elseif vai_smode[id]==3 then
			-- ############################################################ Step 3: kevlar
			if vai_set_botskill>1 then
				if money>=1000 then
					ai_buy(id,57) -- kevlar + helmet
				elseif money>=650 then
					ai_buy(id,58) -- kevlar
				end
			end
			
		elseif vai_smode[id]==4 then
			-- ############################################################ Step 4: secondary weapon
			-- don't buy secondary
			
		elseif vai_smode[id]==5 then
			-- ############################################################ Step 5: switch weapon to knife if available
			if fai_contains(playerweapons(id),50) then
				ai_selectweapon(id,50)
			end
		end
		
		-- Next Step
		vai_smode[id]=vai_smode[id]+1
		vai_timer[id]=math.random(1,5)
		
		-- End Buying after Step 5
		if vai_smode[id]>5 then
			vai_mode[id]=0; vai_smode[id]=0
			vai_buyingdone[id]=1
		end
	end
end
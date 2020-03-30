
-- Wait
-- id: player id
-- mode: switch to this mode
function fai_wait(id,mode)
	-- check timer
	if vai_timer[id]>0 then
		-- decrease
		vai_timer[id]=vai_timer[id]-1
	else
		-- switch mode
		vai_mode[id]=mode
	end
end

-- Angle Delta
-- a1: angle 1
-- a2: angle 2
function fai_angledelta(a1,a2)
	local d=(a2-a1)%360
	if d<-180 then d=d+360 end
	if d>180 then d=d-360 end
	return d
end

-- Angle to
-- x1|y1: position 1
-- x2|y2: position 2
function fai_angleto(x1,y1,x2,y2)
	return math.deg(math.atan2(x2-x1,y1-y2))
end

-- Checks if table t has element e
-- t: table
-- e: element
function fai_contains(t,e)
	for _, value in pairs(t) do
		if value == e then
			return true
		end
	end
	return false
end

-- Check if player has item in certain slot
-- id: player id
-- slot: slot
function fai_playerslotitems(id,slot)
	local items=playerweapons(id)
	for i=1,#items do
		if itemtype(items[i],"slot")==slot then
			return true
		end
	end
	return false
end

-- Walk Aim - aim in walking direction
-- id: player
function fai_walkaim(id)
	local x=player(id,"x")
	local y=player(id,"y")
	local angle=math.deg(math.atan2(x-(vai_px[id] or x),(vai_py[id] or y)-y))
	ai_aim(id,x+math.sin(math.rad(angle))*150,y-math.cos(math.rad(angle))*150)
	if vai_px[id]~=x then vai_px[id]=x end
	if vai_py[id]~=y then vai_py[id]=y end
end

-- Are two given players enemies?
-- id1: player 1
-- id2: player 2
function fai_enemies(id1,id2)
	-- Enemies if teams are different
	if player(id1,"team")~=player(id2,"team") then
		if player(id1,"team")>=2 and player(id2,"team")>=2 then
			-- Special case VIP: CTs (team 2) and VIP (team 3) are never enemies!
			return false
		else
			return true
		end
	-- Enemies if game mode is deathmatch
	elseif vai_set_gm==1 then
		return true
	end
	-- Otherwise: No Enemies
	return false
end

-- Get random (living) teammate
-- id: get random mate of this player (player id)
function fai_randommate(id)
	-- Get Team
	local team=player(id,"team")
	if team>2 then
		team=2
	end
	
	-- Get Random from Player Table
	local players=player(0,"team"..team.."living")
	if #players==0 then
		return 0
	end
	for i=1,10 do
		local randid=math.random(1,#players)
		if players[randid]~=id then
			return players[randid]
		end
	end
	
	-- No mate found
	return 0
end

-- Set destination to random adjacent tile
function fai_randomadjacent(id)
	px=player(id,"tilex")
	py=player(id,"tilex")
	
	-- 20 Search attempts
	for i=1,20 do
		-- Get coordinates of random adjacend tile
		x=px+math.random(-1,1)
		y=py+math.random(-1,1)
		
		-- It must not be the tile of the player...
		if (x~=px or y~=py) then
			-- ... and it must be walkable
			if tile(x,y,"walkable") then
				-- If all this is true, set it!
				vai_destx[id]=x
				vai_desty[id]=y
				return
			end
		end
	end
end
-----------------------------------------------
---Lua Lag Compensation version 2.2 by FlooD---
-----------------------------------------------
--[[       latest version always at
raw.github.com/FloooD/C_lag_comp/master/llc.lua
---------------------------------------------]]

math.randomseed(os.time())

ping = {}
mode = {{}, {}, {}}
buf = {{}, {}}
disabled = {}
no_lc={}
for _, v in ipairs({0, 47, 48, 49, 51, 52, 72, 73, 75, 76, 77, 86, 87, 88, 89, 253, 254, 255}) do
	disabled[v] = true
end

armor = {}
for i, v in ipairs({25, 50, 75, 50, 95}) do
	armor[200 + i] = 1 - (v / 100)
end

function lc_reset(id)
	mode[1][id] = 0
	mode[2][id] = 0
	mode[3][id] = 0
	buf[1][id] = {}
	buf[2][id] = {}
	ping[id] = nil
end
addhook("die", "lc_reset")

function lc_clear(id)
	lc_reset(id)
	no_lc[id] = false
end

for i = 1, 32 do
	lc_clear(i)
end
addhook("leave", "lc_clear")

function updateping(id)
	local actualping = player(id, "ping")
	if not actualping then return end
	local lastping = ping[id]
	if not lastping then lastping = 0 end
	if actualping - lastping <= 30 or lastping == 0 then
		ping[id] = actualping
	else
		ping[id] = 0.7 * lastping + 0.3 * actualping
	end
end
addhook("spawn", "updateping")

function lc_second()
	for i in pairs(ping) do
		updateping(i)
	end
end
addhook("second", "lc_second")

MAX_FRAMES = 15
function updatebuf()
	for i in pairs(ping) do
		for j = MAX_FRAMES, 1, -1 do
			buf[1][i][j], buf[2][i][j] = buf[1][i][j-1], buf[2][i][j-1]
		end
		buf[1][i][0], buf[2][i][0] = player(i, "x"), player(i, "y")
	end
end
addhook("always", "updatebuf")

addhook("hit", "lc_hit", 1000)
function lc_hit(v, id, wpn)
	return (disabled[wpn] or id == 0 or no_lc[id]) and 0 or 1
end

addhook("attack", "lc_attack")
function lc_attack(id)
	local wpn = player(id, "weapon")	
	if disabled[wpn] or no_lc[id] then return end
	local rot = player(id, "rot")
	local dmg = itemtype(wpn, "dmg") * game("mp_damagefactor")
	if (wpn == 2 and mode[1][id] == 1) or (wpn == 39 and mode[2][id] == 1) then
		dmg = math.floor(dmg * 0.64 + 0.5)
		simulate_attack(id, wpn, dmg, rot - 6 + 12 * math.random())
		simulate_attack(id, wpn, dmg, rot + 6 + 8 * math.random())
		simulate_attack(id, wpn, dmg, rot - 6 - 8 * math.random())
		return
	elseif wpn == 10 or wpn == 11 then
		for i = 1, 5 do
			simulate_attack(id, wpn, dmg, rot - 20 + 40 * math.random())
		end
		return
	end
	if mode[3][id] == 1 then
		dmg = itemtype(wpn, "dmg_z1") * game("mp_damagefactor")
	elseif mode[3][id] == 2 then
		dmg = itemtype(wpn, "dmg_z2") * game("mp_damagefactor")
	end
	rot = rot + itemtype(wpn, "dispersion") * (2 * math.random() - 1)
	simulate_attack(id, wpn, dmg, rot)
end

addhook("attack2", "lc_attack2")
function lc_attack2(id, m)
	local wpn = player(id, "weapon")
	if wpn == 50 or wpn == 69 then
		if no_lc[id] then return end
		simulate_attack(id, wpn, itemtype(wpn, "dmg_z1") * game("mp_damagefactor"))
	elseif wpn == 2 then
		mode[1][id] = m
	elseif wpn == 39 then
		mode[2][id] = m
	elseif wpn ~= 32 and wpn >= 31 and wpn <= 37 then
		mode[3][id] = m
	end	
end

addhook("reload", "unzoom")
addhook("select", "unzoom")
function unzoom(id)
	mode[3][id] = 0
end

addhook("drop", "lc_drop")
function lc_drop(id, iid, wpn)
	mode[3][id] = 0
	if wpn == 2 then
		mode[1][id] = 0
	elseif wpn == 39 then
		mode[2][id] = 0
	end
end

addhook("collect", "lc_collect")
function lc_collect(id, iid, wpn, ain, a, m)
	if wpn == 2 then
		mode[1][id] = m
	elseif wpn == 39 then
		mode[2][id] = m
	end
end

function simulate_attack(id, wpn, dmg, rot)
	if not wpn then wpn = player(id, "weapon") end
	if not dmg then dmg = itemtype(wpn, "dmg") * game("mp_damagefactor") end
	if not rot then rot = player(id, "rot") end
	local range = itemtype(wpn, "range")
	local start_x = player(id, "x")
	local start_y = player(id, "y")
	local end_x = (3 * range) * math.sin(math.rad(rot))
	local end_y = -(3 * range) * math.cos(math.rad(rot))
	local tile_x = math.floor(start_x / 32)
	local tile_y = math.floor(start_y / 32)
	local inc_x, inc_y
	if rot < 0 then
		inc_x = -1
	elseif rot > 0 and rot ~= 180 then
		inc_x = 1
	end
	if math.abs(rot) > 90 then
		inc_y = 1
	elseif math.abs(rot) < 90 then
		inc_y = -1
	end
	while not tile(tile_x, tile_y, "wall") do
		local temp_x, temp_y = tile_x, tile_y
		if inc_x and intersect(end_x, end_y, topixel(temp_x + inc_x) - start_x, topixel(temp_y) - start_y, 16) then
			tile_x = temp_x + inc_x
		end
		if inc_y and intersect(end_x, end_y, topixel(temp_x) - start_x, topixel(temp_y + inc_y) - start_y, 16) then
			tile_y = temp_y + inc_y
		end
		if tile_x == temp_x and tile_y == temp_y then
			break
		end
	end
	if tile(tile_x, tile_y, "wall") then
		end_x, end_y = intersect(end_x, end_y, topixel(tile_x) - start_x, topixel(tile_y) - start_y, 16)
	end
	local frames = math.floor(0.5 + ping[id] / 20)
	if frames > MAX_FRAMES then frames = MAX_FRAMES end
	local victims = {}
	if game("sv_friendlyfire") == "0" and game("sv_gamemode") ~= "1" then
		for i in pairs(ping) do
			if player(i, "team") ~= player(id, "team") then
				victims[i] = true
			end
		end
	else
		for i in pairs(ping) do
			victims[i] = true
		end
		victims[id] = nil
	end
	for i in pairs(victims) do
		if intersect(end_x, end_y, buf[1][i][frames] - start_x, buf[2][i][frames] - start_y, 12) then
			parse("sv_sound2 "..id.." player/hit"..math.ceil(3 * math.random())..".wav")
			parse("sv_sound2 "..i.." player/hit"..math.ceil(3 * math.random())..".wav")
			local newhealth
			local newarmor = player(i, "armor")
			if newarmor <= 200 then
				newarmor = newarmor - dmg
				if newarmor < 0 then
					newarmor = 0
				end
				newhealth = player(i, "health") - (dmg - math.floor(game("mp_kevlar") * (player(i, "armor") - newarmor)))
				parse("setarmor "..i.." "..newarmor)
			else
				newhealth = player(i, "health") - math.floor((dmg * (armor[newarmor] or 1)))
			end
			if newhealth > 0 then
				parse("sethealth "..i.." "..newhealth)
			else
				parse("customkill "..id.." \""..itemtype(wpn, "name").."\" "..i)
			end
		end
	end
end

function topixel(tile)
	return (tile * 32) + 16
end

function intersect(ex, ey, bx, by, bl)
	if not (bx and by) then return end
	local cx, cy = (math.abs(bx) <= bl), (math.abs(by) <= bl)
	if cx and cy then
		if math.abs(ex - bx) <= bl and math.abs(ey - by) <= bl then
			return ex, ey
		end
		bl = -bl
	end
	local ox = (ex >= 0) and bx - bl or bx + bl
	local oy = (ey >= 0) and by - bl or by + bl
	local flip
	if (ex == 0 or (cx ~= cy or ((math.abs(ey * ox) >= math.abs(ex * oy)) == (bl < 0)))) and ((not cy) or cx) then
		if ey == 0 then return end
		ex, ey, bx, by, ox, oy = ey, ex, by, bx, oy, ox
		flip = true
	end
	if (ox * ex) >= 0 and math.abs(ox) <= math.abs(ex) then
		oy = ox * ey / ex
		if math.abs(oy - by) <= math.abs(bl) then
			if flip then return oy, ox end
			return ox, oy
		end
	end
end

-- Adaptado para o Control Core!
-- Incluso comando para ativar o lag compensation, o !lc
command["!lc"] = "10|0|1|0|switch|!lc <on/off>|c_lc(v_me,t_args[1])"

function c_lc(id,p1)
	if p1:lower() == "on"  then	no_lc[id] = true end
	if p1:lower() == "off" then no_lc[id] = false end

	msg2(id, "Lag Compensation(LC) 2.2 - Criado por FlooD.")
	msg2(id, "Seu ping atual: "..player(id, "ping"))
	msg2(id, "O seu LC está "..(no_lc[id] and "ligado" or "desligado")..".")
end
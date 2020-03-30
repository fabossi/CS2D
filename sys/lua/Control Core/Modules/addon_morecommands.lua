-- Tabela mestre desse addon, para não dar conflito com as functions/arrays normais.
-- Tudo aqui será dirigido como "amc"
if amc~=true then amc={} end
--------------------------------------------------
--                  CONFIG	                    --
--------------------------------------------------
cc_global.knifemode = false
----------------------------------------------
--					Commands				--
----------------------------------------------
-- command["name"] = time|level|args|hide/show|type|syntax|event
-- Level 0
command["!me"]				= "30|0|0|1|nil|!me|amc.me(v_me,v_argsall)"
command["!afk"]				= "50|0|0|0|nil|!afk|amc.afk(v_me)"
command["!clan"]			= "10|0|0|1|nil|!site|msg(get_color('info')..'Site do clan '.. cc_config.clanname..': '.. cc_config.clansite)"
-- Level 1
command["@setcustomlevel"] 	= "10|1|1|0|set|@setcustomlevel <nome>|p_rank[v_me]=v_argsall"
command["@faketo"]			= "5|1|2|1|id,set|@faketo <id> <comando>|amc.faketo(v_me,t_args[1],t_args[2])"
command["@fake"]			= "5|1|1|1|set|@fake <comando>|amc.fake(v_me,t_args[1])" 
command["@desfake"]			= "5|1|1|1|set|@desfake <comando>|amc.desfake(v_me,t_args[1])" 
-- Level 2
-- Level 3
command["@on"]				= "50|3|0|0|nil|@on|amc.on(v_me)"
command["@customkill"]		= "5|3|2|0|sid,set|@customkill <jogador> <arma>|amc.customkill(v_me,t_args[1],t_args[2])"
command["@deathslap"]		= "5|3|1|0|id|@deathslap <jogador>|deathslap(t_args[1])"
command["@shake"]			= "5|3|2|0|id,number|@shake <jogador> <intensidade>|amc.shake(t_args[1],t_args[2])"
command["@flash"]			= "5|3|2|0|id,number|@flash <jogador> <intensidade>|amc.flashplayer(t_args[1],t_args[2])"
command["@god"]				= "5|3|1|0|switch|@god <on/off>|amc.god(v_me,t_args[1])"
-- Level 4
command["@knife"] 			= "10|4|1|0|switch|@knife <on/off>|amc.knife(t_args[1])"
command["@explosion"]		= "5|4|1|0|integer,integer,number,number,id|@explosion <x> <y> <tamanho> <dano> <jogador>|amc.explosion(t_args[1],t_args[2],t_args[3],t_args[4],t_args[5])"
command["@scanhacks"]		= "10|2|1|0|id|@scanhacks <jogador>|amc.scanhacks(t_args[1])"
----------------------------------------------
--					Hooks					--
----------------------------------------------
addhook("walkover","amc.walkover")
addhook("hit","amc.hit")
----------------------------------------------
function amc.walkover(id)
	if cc_global.knifemode then
		return 1
	end
end

function amc.hit(uid)
	if p_god[uid] == 1 then
		return 1
	end
end
----------------------------------------------
--					Functions				--
----------------------------------------------
function amc.knife(p1)
	if p1:lower() == "off" then	cc_config.knifemode=false end
	if p1:lower() == "on" then cc_config.knifemode=true end
	if cc_global.knifemode==true then
		for i,id in pairs(player(0,"table")) do
			parse("strip "..id)
		end
	end	
end

function amc.fake(uid,cmd)
	msg("©210255210"..get_name(uid).." "..l_used.." @"..cmd..".")
end

function amc.desfake(uid,cmd)
	msg("©255255255"..get_name(uid).." "..l_desactived.." @"..cmd..".")
end

function amc.faketo(uid,player,cmd)
	msg("©210255210"..get_name(uid).." "..l_used.." @"..cmd.." em "..get_name(player)..".")
end

function amc.customkill(killer,weaponname,victim)
	parse("customkill "..killer.." "..victim.." "..weaponname)
end

function amc.deathslap(player)
	parse("deathslap "..player)
end

function amc.shake(player,power)
	parse("shake "..player.." "..power)
end

function amc.flashplayer(player,intensity)
	parse("flashplayer "..player.." "..intensity)
end

function amc.scanhacks(uid)
	local rand=math.random(0,1)
	if rand==0 then
		msg3(get_color("red").."[Server] "..l85.." "..get_name(uid)..".")
	else
		msg3(get_color("green").."[Server] "..l86.." "..get_name(uid)..".")
	end
end

function amc.me(uid,text)
	if text == "" then
		msg3(get_color("sv").."[Server] "..get_name(uid).." "..l49..".")
	else
		msg3(get_color("sv").."[Server] "..get_name(uid).." "..text..".")
	end	
end

function amc.afk(uid)
	msg("©255255255"..get_name(uid).." "..l80..".@C")
end

function amc.on(uid)
	msg("©"..p_color[uid].."["..p_rank[uid].."] "..get_name(uid).." "..l68..".@C")
end

function amc.explosion(x,y,size,damage,sourceplayer)
	parse("explosion "..x.." "..y.." "..size.." "..damage.." "..sourceplayer)
end

function amc.god(uid,p1)
	if p1:lower() == "off" then	p_god[uid] = 0 end
	if p1:lower() == "on" then p_god[uid] = 1 end
	save_user(uid)
end

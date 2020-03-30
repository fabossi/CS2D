if sample==nil then sample={} end
sample.ut={}
function initArray(m)
	local array = {}
	for i = 1, m do
		array[i]=0
	end
	return array
end
sample.ut.timer=initArray(32)
sample.ut.level=initArray(32)
sample.ut.fblood=0


-----------------------
-- PREPARE TO FIGHT! --
-----------------------
addhook("startround","sample.ut.startround")
function sample.ut.startround()
	parse("sv_sound \"fun/prepare.wav\"")
	sample.ut.fblood=0
end


-----------------------
-- KILL SOUNDS+MSGS  --
-----------------------
addhook("kill","sample.ut.kill")
function sample.ut.kill(killer,victim,weapon)
	if (os.clock()-sample.ut.timer[killer])>3 then
		sample.ut.level[killer]=0;
	end
	level=sample.ut.level[killer]
	level=level+1
	sample.ut.level[killer]=level
	sample.ut.timer[killer]=os.clock()
	-- FIRST BLOOD?
	if (sample.ut.fblood==0) then
		sample.ut.fblood=1
		parse("sv_sound \"fun/firstblood.wav\"");
		msg ("©255000000"..player(killer,"name").." mato mt rapido(a) "..player(victim,"name").."!@C")
	end
	-- HUMILIATION? (KNIFEKILL)
	if (weapon==50) then
		-- HUMILIATION!
		parse("sv_sound \"fun/humiliation.wav\""); 
		msg ("©171130255"..player(killer,"name").." Humilhou (a)  "..player(victim,"name").."!@C")
	else
		-- REGULAR KILL
		if (level==1) then
			-- Single Kill! Nothing Special!
		elseif (level==2) then
			parse("sv_sound \"fun/doublekill.wav\"");
			msg ("©024525500"..player(killer,"name").." matou 2 q bom !@C")
		elseif (level==3) then
			parse("sv_sound \"fun/multikill.wav\"")
			msg ("©321781700"..player(killer,"name").." matou 3 Sorte será ? !@C")
		elseif (level==4) then
			parse("sv_sound \"fun/ultrakill.wav\"")
			msg ("©139101800"..player(killer,"name").." matou 4 q fdm '-' !!@C")
		elseif (level==5) then
			parse("sv_sound \"fun/monsterkill.wav\"")
			msg ("©148021100"..player(killer,"name").." matou 5 ta bolado ? !!@C")
		else
			parse("sv_sound \"fun/unstoppable.wav\"")
			msg ("©187255255"..player(killer,"name").." AIM AIM SE EU TE PEGO KK'  ! "..level.." KILLS!@C")
		end
	end
end
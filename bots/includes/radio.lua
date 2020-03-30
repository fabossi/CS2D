--[[

Radio messages allow players to control bots.
Bots may (randomly) do what they receive via radio.

]]--

-- Radio message handling
function fai_radio(source,radio)
	-- ############################################################ Bomb planted!
	-- Action: every CT will try to defuse!
	if radio==4 then
		local bots=player(0,"table")
		for _,id in pairs(bots) do
			if player(id,"bot")==1 and player(id,"team")==2 then
				if vai_mode[id]~=52 then
					vai_destx[id],vai_desty[id]=randomentity(5,0)
					vai_mode[id]=52; vai_smode[id]=0; vai_timer[id]=0
				end
			end
		end
	-- ############################################################ Need Backup / Cover me / Follow Me
	-- Action: let bot follow player
	elseif radio==1 or radio==6 or radio==13 then
		local mate=fai_randommate(source)
		if mate~=0 then
			if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
			vai_radioanswert[mate]=math.random(35,100)
			vai_mode[mate]=7
			vai_smode[mate]=source
			vai_timer[mate]=0
		end
	-- ############################################################ Enemy spotted / Taking fire, need assistance
	-- Action: let bot go to player
	elseif radio==9 or radio==11 then
		local mate=fai_randommate(source)
		if mate~=0 then
			if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
			vai_radioanswert[mate]=math.random(35,100)
			vai_mode[mate]=2
			vai_destx[mate]=player(source,"tilex")
			vai_desty[mate]=player(source,"tiley")
		end
	-- ############################################################ Regroup Team
	-- Action: let bots stop following, return to normal mode
	elseif radio==24 then
		local team=player(source,"team")
		if team>2 then team=2 end
		local mates=player(0,"team"..team.."living")
		local c=1
		for mate=1,#mates do
			if vai_mode[mate]==7 then
				if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
				vai_radioanswert[mate]=math.random(50,55)*c
				c=c+1
				vai_mode[mate]=0
			end
		end
	-- ############################################################ Hold Position
	-- Action: let bot camp
	elseif radio==23 then
		local mate=fai_randommate(source)
		if mate~=0 then
			if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
			vai_radioanswert[mate]=math.random(35,100)
			vai_mode[mate]=1; vai_timer[mate]=math.random(30*50,60*50)
		end
	-- ############################################################ Team Fall Back / Go Go Go / Stick Together / Storm the Front / You take the point
	-- Action: let camping (mode 1) or following (mode 7) bots return to normal mode
	elseif radio==10 or radio==15 or radio==30 or radio==31 or radio==32 then
		local team=player(source,"team")
		if team>2 then team=2 end
		local mates=player(0,"team"..team.."living")
		local c=1
		for mate=1,#mates do
			if vai_mode[mate]==1 or vai_mode[mate]==7 then
				if math.random(1,2)==1 then vai_radioanswer[mate]=0 else vai_radioanswer[mate]=28 end
				vai_radioanswert[mate]=math.random(50,55)*c
				c=c+1
				vai_mode[mate]=0
			end
		end
	-- ############################################################ Report in
	-- Action: radio "reporting in!"
	elseif radio==25 then
		local mate=fai_randommate(source)
		if mate~=0 then
			vai_radioanswer[mate]=26
			vai_radioanswert[mate]=math.random(35,100)
		end
	end
end
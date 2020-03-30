function fai_rescuehostages(id)
	if vai_smode[id]==0 then
		-- Find and use hostages
		if ai_goto(id,vai_destx[id],vai_desty[id])~=2 then
			vai_mode[id]=0
		else
			fai_walkaim(id)
		end
		
		-- Find Hostages
		local h=hostage(0,"table")
		for i=1,#h do
			if hostage(h[i],"health")>0 and hostage(h[i],"follow")==0 then
				-- Close enough? Use!
				if math.abs(player(id,"x")-hostage(h[i],"x"))<=15 and math.abs(player(id,"y")-hostage(h[i],"y"))<=15 then
					ai_rotate(id,fai_angleto(player(id,"x"),player(id,"y"),hostage(h[i],"x"),hostage(h[i],"y")))
					ai_use(id)
					break
				end
			end
		end
		
		-- Get closest Hostage
		vai_destx[id],vai_desty[id]=closehostage(id)
		if vai_destx[id]==-100 then
			-- None found? Switch to rescue
			vai_smode[id]=1
			vai_destx[id],vai_desty[id]=randomentity(4) -- info_rescuepoint
			if vai_destx[id]==-100 then
				vai_destx[id],vai_desty[id]=randomentity(1) -- info_ct
			end
		end
	else
		-- Return and rescue hostages
		local result=ai_goto(id,vai_destx[id],vai_desty[id])
		if result==1 then
			vai_mode[id]=3
			vai_timer[id]=math.random(150,300)
			vai_smode[id]=math.random(0,360)
		elseif result==0 then
			vai_mode[id]=0
		else
			fai_walkaim(id)
		end
	end
end
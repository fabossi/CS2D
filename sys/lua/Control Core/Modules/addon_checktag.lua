--------------------------------------------------
--                  CONFIG	                    --
--------------------------------------------------
cc_config.clantag 		= ""
cc_config.clanname 		= ""
cc_config.clansite 		= "http://cs2dscripts.blogspot.com"
--------------------------------------------------
--                 FUNCTIONS                    --
--------------------------------------------------
function cc_join(uid)
	-- Funções de controle de usuarios
	set_flags(uid)
	check_tag(uid)
	check_banned(uid)
	
	if cc_config.auto_login then
		auth_user(uid)
	end
end

function check_tag(uid)
	local name = get_name(uid)
	if p_level[uid] < 2 and string.find(name, cc_config.clantag) and  cc_config.clantag ~= "" then 
		local name = string.gsub(name, cc_config.clantag, "")
		msg2(uid,get_color("sv").."[Server] "..l16.." ".. cc_config.clanname.."!")
		msg2(uid,get_color("sv").."[Server] "..l17.."!")
		setname(uid,name)
	end
end 

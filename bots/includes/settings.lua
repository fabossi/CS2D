
-- Update Settings
function fai_update_settings()
	vai_set_gm=tonumber(game("sv_gamemode"))
	vai_set_botskill=tonumber(game("bot_skill"))
	vai_set_botweapons=tonumber(game("bot_weapons"))
	vai_set_debug=tonumber(game("debugai"))
end
--------------------------------------------------
-- Script básico de HUD e Mensagens.		    --
-- Esse é um script oficial do Control Core.	--
--------------------------------------------------
advertise={}
advertise.cc_hud 	 = "©210235255Control Core "..cc_config.cc_version.." - CS2D Scripts."

-- Separe as frases com uma virgula (,) ou ponto-e-virgula (;)
advertise.list={
"[Info] Perdido? Digite !help para ver os comandos ou !help <comando> para um comando específico!";
"[Info] Visite nosso site! www.cs2dscripts.blogspot.com";
"[Info] Digite !listcolor para ver as cores disponíveis, e ative essa cor usando @setcolor <nome da cor>!";
"[Info] Veja quando o seu VIP irá expirar digitando !loginduration.";
"[Info] Use @freezeall para detectar speedhackers, e @freeze <id> para um jogador específico!";
"[Info] Reporte jogadores que você achar que são cheaters, flammers e fakes, utilizando @report <id>.";
"[Info] Use o @god para realizar eventos e impedir que outros te matem, mas não use para ter benefício próprio!";
"[Info] Use @validate <id> <dias> para dar um prazo para uma conta expirar. @unvalidate <id> retira esse prazo.";
"[Info] Caso queira falar em publico enquanto estiver no espectador, utilize !broadcast <mensagem>.";
"[Info] Utilize !reset ou !resetscore para resetar a sua pontuação (frags).";
"[Info] Caso estiver em fullscreen, digite !hour ou !date, para ver a hora e a data atual do servidor.";
"[Info] Use @cloak caso você queira que ninguém veja seus comandos.";
"[Info] Use @check para ver informações específicas do jogador, como IP e USGN.";
"[Info] Digite !usgn <id> para ver a USGN de um jogador.";
"Control Core Ultimate®. Criado por Mozilla [21707] | SektoR_ [80692])";
}
-------------------------------------------------
-- Mensagem de boas vindas/HUD ao se conectar  --
-------------------------------------------------
addhook("join","advertise.join")
function advertise.join(player)
	-- Cria a hud para o usuário
	hudtxt2(player,1,advertise.cc_hud,2,420,0)
end
--------------------------------------
-- Mostrar mensagem a cada 1 minuto --
--------------------------------------
addhook("minute","advertise.minute")
function advertise.minute()
	local rand=math.random(1,#advertise.list)
	--msg(get_color("sv").."[Info] Control Core "..cc_config.cc_version..".")
	msg(get_color("info")..advertise.list[rand])
end
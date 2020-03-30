--------------------------------------------------
--        			 GAMEGUARD                  --
--------------------------------------------------
-- Este é um módulo oficial do Control Core.
addhook("attack","gg_attack")
addhook("select","gg_select")
addhook("movetile","gg_movetile")
addhook("second","gg_second")

awpDelayTime = 2 -- Muitos falam que é 3, mas o CS2D é incerto quanto ao tempo. 
seconds = 0

delayCounter = init_array(32,0)
weaponInHand = init_array(32,0)
weaponUsed = init_array(32,0)
playerSteps = init_array(32,0)

function gg_select(id,w)
     weaponInHand[id]=w -- Ultima arma selecionada
end

function gg_attack(id)
	weaponUsed[id]=player(id,"weapontype")
	if weaponUsed[id]==0 then -- Se a arma desaparecer, então weaponUsed será zero
		weaponUsed[id]=weaponInHand[id] -- Nesse caso, weaponUsed vai ganhar o valor de weaponInHand
	end	
	
	if weaponUsed[id] == 35 then -- Checagem de AWP.
		if delayCounter[id] > os.time() then -- Se durante esse tempo o delayCounter for maior que o tempo real.
			msg(player(id,"name").." foi detectado por tentar fazer delay.") -- Então kika.
			--parse("kick "..id)
		end
		delayCounter[id] = os.time() + awpDelayTime -- Adiciona + 3 ao tempo do delay(da AWP)
	end
end

function gg_movetile(id,x,y)
	playerSteps[id] = playerSteps[id] + 1 -- Adiciona + 1 ao numero de passos.
end

function gg_second()
	seconds = seconds + 1
	if seconds == 5 then
		seconds = 0
		for id = 1,32 do checkPlayer(id) end -- A cada 5 segundos, checa o jogador.
	end
end

function checkPlayer(id)
	if playerSteps[id] > 35 then -- Se o numero de passos for maior que 35 durante 5 segundos
		msg(player(id,"name").." foi detectado por tentar usar speedhack!") -- Então kika
		--parse("kick "..id)
	end
	playerSteps[id] = 0 -- Reseta o numero de passos.
end
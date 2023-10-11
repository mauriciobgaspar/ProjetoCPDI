-- adicionar física ao projeto
local physics = require ("physics") -- chama a biblioteca de fisica
physics.start () -- inicia a fisica
physics.setGravity (0, 9.8) -- definir a gravidade (padrão da terra)
physics.setDrawMode ("hybrid") -- definir o modo de exibição dos corpos físicos

-- remover a barra de status da tela
display.setStatusBar (display.HiddenStatusBar)

-- adicionar o plano de fundo
local bg = display.newImageRect ("imagens/bg.jpg", 1002*0.7, 705*0.7)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

-- adicionar player dinamico
local player = display.newImageRect ("imagens/player.png", 420*0.2, 594*0.2)
player.x = display.contentCenterX-100
player.y = 388
physics.addBody (player, "kinematic") -- adiciona física dinamica ao player
player.myName = "player"

-- adicionar inimiga cinematica
local inimiga = display.newImageRect ("imagens/inimigo.png", 373*0.2, 668*0.2)
inimiga.x = display.contentCenterX+100
inimiga.y = 390
physics.addBody (inimiga, "kinematic") -- adiciona física cinemática à inimiga
inimiga.myName = "inimiga"

-- criar variáveis de pontuação
-- criamos elas antes da função pq, se criar dentro da função, não vamos conseguir atualiza-la
local vidas = 5
local pontos = 0
local morto = false -- player nao esta morto inicialmente

-- aidicionar textos de pontuações na tela
-- ("texto" .. variavel, localizaçãoX, localizaçãoY, fonte, tamanho da fonte)
local vidasText = display.newText ("Vidas: " .. vidas, 80, 30, native.systemFont, 20)
vidasText:setFillColor (0, 0, 0) -- muda a cor do texto

local pontosText = display.newText ("Pontos: " .. pontos, 200, 30, native.systemFont, 20)
pontosText:setFillColor (0, 0, 0)

-- criar função de atirar ao player
local function atirar ()
	-- criar o projetil dentro da função, pq o tiro só vai ser criado qndo rodar a função
	-- (localizaçãoX, localizaçãoY, raio)
	local tiro = display.newCircle (player.x, player.y, 4)
	tiro:setFillColor (0, 0, 0) -- muda a cor do tiro
	physics.addBody (tiro, "dynamic", {radius = 4, isSensor = true}) -- adiciona a fisica ao tiro; isSensor pra não perder nenhuma colisão do tiro com o player
	-- configuração do tiro como uma bala, faz com que a detecção de colisão fique mais sensível
	tiro.isBullet = true
	tiro.myName = "tiro" -- dá um nome ao tiro. pode usar myName ou id tb
	tiro.gravityScale = 0
	transition.to (tiro, {x = 500, time = 500, -- 500 vai até fora da tela se não houver colisão, em meio segundo
		onComplete = function ()
			display.remove (tiro)
		end -- cria função temporária sem nome, que serve apenas pra remover o tiro quando completar a função atirar
	}) 
end

player:addEventListener ("tap", atirar)

-- criar função para movimentação do player
local function moverPlayer (event)
	local player = event.target -- variavel temporaria que só vai funcionar dentro da função. define o player como alvo da função
	local phase = event.phase -- define nome da variavel de fase de evento

	if ("began" == phase) then -- qndo a fase de toque for began (primeiro toque na tela), então
		display.currentStage:setFocus (player) -- todas as mudanças de direção enquanto o mouse estiver apertado serão focadas no player.
		player.touchOffsetY = event.y - player.y -- salva posição inicial do player

	elseif ("moved" == phase) then -- quando a fase de toque for moved (fase de movimentação), então
		player.y = event.y - player.touchOffsetY -- sempre que movimentar o mouse, movemos o player na vertical

	elseif ("ended" == phase or "cancelled" == phase) then -- quando a fase de toque for finalizada pelo usuario ou pelo sistema, então
		display.currentStage:setFocus (nil) -- retira o foco de toque do player
	end -- fecha o if
end -- fecha a function moverPlayer

player:addEventListener ("touch", moverPlayer)

-- criar variável de direção inicial do inimigo para utilizar na funtion abaixo
local direcaoInimiga = "cima"

-- criar função para movimentação do inimigo
local function movimentarInimiga ()
	if not (inimiga.y == nil) then -- se a localização y da inimiga não for nula, então
		if (direcaoInimiga == "cima") then -- se a direção da inimiga for pra cima, então
			inimiga.y = inimiga.y -1 -- a posição da inimiga vai subir

			if (inimiga.y <= 0) then -- se a localização y for menor ou igual a 0, entao
				direcaoInimiga = "baixo" -- a direcao da inimiga vai ser alterada para baixo
			end -- fecha o if <=
		
		elseif (direcaoInimiga == "baixo") then -- se a direção da inimiga for para baixo, então
			inimiga.y = inimiga.y +1 -- a posição da inimiga vai descer
			
			if (inimiga.y >= 450) then -- se a localização y for maior ou igual a 480, então
				direcaoInimiga = "cima" -- a direção da inimiga vai ser alterada para cima
			end -- fecha o if >=
		end -- fecha o if direcaoInimiga

	else 
		Runtime:removeEventListener ("enterFrame", movimentarInimiga)
	end -- fecha o if not
end -- fecha a function

-- evento que fica executando o tempo todo
Runtime:addEventListener ("enterFrame", movimentarInimiga) -- enterFrame tb ocorre no jogo todo, em todos os objetos
-- a cada enterFrame, a função é chamada 60 vezes por segundo

local function inimigaAtirar ()
	local tiroInimiga = display.newCircle (inimiga.x, inimiga.y, 4)
	tiroInimiga:setFillColor (0, 0.4, 1, 0.6)
	physics.addBody (tiroInimiga, "dynamic", {radius = 4, isSensor = true})
	tiroInimiga:setLinearVelocity (-200, 0)
	tiroInimiga.myName = "tiro da inimiga"
	tiroInimiga.gravityScale = 0
end -- fecha a function

-- timer que executa a function
-- a cada 1300 milissegundos, a função inimigaAtirar vai rodar infinitamente
-- 0 significa que vai repetir infinitamente
-- atirar é o nome do timer
-- (tempo, function, repetições)
inimiga.timerAtirar = timer.performWithDelay (1300, inimigaAtirar, 0)



-- função de colisao entre o tiro do inimigo com o player
local function onCollision (event)
	if (event.phase == "began") then
		-- criar variaveis que facilitam a digitação da função
		local obj1 = event.object1
		local obj2 = event.object2
-- se o myName do obj1 for tiroInimiga e o myName do obj2 for player,
			if ((obj1.myName == "tiro da inimiga" and obj2.myName == "player") or
				-- ou, vice-versa
			    (obj1.myName == "player" and obj2.myName == "tiro da inimiga")) then
				-- remove o tiro da inimiga (variável)
				if (obj1.myName == "tiro da inimiga") then
					display.remove (obj1)

				else
					display.remove (obj2)
				end -- fecha if obj.myName

				-- subtrair 1 das vidas
				vidas = vidas - 1
				-- atualizar o texto de vidas
				vidasText.text = "Vidas: " .. vidas
					-- se as minhas vidas forem igual ou menor a 0, então
					if (vidas <= 0) then -- qndo o numero de vidas for 0
						-- morto = true -- aí sim ele vai morrer
						display.remove (player) -- o player vai ser removido
						-- remove-se os eventos cujo player é ouvinte
						player:removeEventListener ("touch", moverPlayer)
						player:removeEventListener ("tap", atirar)
						
					end -- fecha if vidas <= 0
			end -- fecha if myName
	end -- fecha if event.phase
end -- fecha a function

Runtime:addEventListener ("collision", onCollision)

-- colisão entre o tiro do player e o inimigo
local function onCollision2 (event)
	if (event.phase == "began") then -- se a fase do evento for a inicial
		-- criar variaveis que facilitam a digitação da função
		local obj1 = event.object1
		local obj2 = event.object2
-- se o myName do obj1 for inimiga e o myName do obj2 for tiro,
			if ((obj1.myName == "inimiga" and obj2.myName == "tiro") or
				-- ou, vice-versa
			    (obj1.myName == "tiro" and obj2.myName == "inimiga")) then

				if (obj1.myName == "tiro") then
					display.remove (obj1)

				else 
					display.remove (obj2)
				end -- fecha if remove

				pontos = pontos + 100 -- adiciona 100 a variavel pontos
				pontosText.text = "Pontos: " .. pontos -- atualiza o texto de pontos

					if (pontos == 500) then -- qndo os pontos forem 500
						timer.cancel (inimiga.timerAtirar) -- cancela o timer
						Runtime:removeEventListener (movimentarInimiga) -- para inimiga parar de se mover

						if (obj1.myName == "inimiga") then
							display.remove (obj1)
						else
							display.remove (obj2)
						end -- fecha if remove
					end -- fecha if pontos
			end -- fecha if myName
	end -- fecha if event.phase
end -- fecha a function


Runtime:addEventListener ("collision", onCollision2) -- adiciona ouvinte da função onCollision2

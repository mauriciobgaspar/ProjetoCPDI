local composer = require('composer')
local cena = composer.newScene( )

function cena:create( event )
	local grupoGame = self.view

	local x = display.contentWidth
	local y = display.contentHeight
	local mx = display.contentCenterX
	local my = display.contentCenterY

	local physics = require('physics')
	physics.start( )
	physics.setGravity( 0, 0 )
	physics.setDrawMode( 'normal' )

	local click = audio.loadSound( 'audio/efeito-click.mp3' )

	local fundoGame = display.newImageRect( grupoGame, 'imagens/fundo-jogo.jpg', x, y )
	fundoGame.x = mx
	fundoGame.y = my

	local pontos = 0
	local textoPontos = display.newText(grupoGame, pontos, mx, 100, nil, 120 )

	local lixeiraAmarela = display.newImageRect( grupoGame, 'imagens/lixo-amarelo.png', 200, 400 )
	lixeiraAmarela.x = mx - 100
	lixeiraAmarela.y = y/1.2
	physics.addBody( lixeiraAmarela, 'static' )
	lixeiraAmarela.myName = 'lixeira amarela'

	local lixeiraVermelha = display.newImageRect( grupoGame, 'imagens/lixo-vermelho.png', 200, 400 )
	lixeiraVermelha.x = mx + 100
	lixeiraVermelha.y = y/1.2
	physics.addBody( lixeiraVermelha, 'static' )
	lixeiraVermelha.myName = 'lixeira vermelha'

	local lixeiraAzul = display.newImageRect( grupoGame, 'imagens/lixo-azul.png', 200, 400 )
	lixeiraAzul.x = mx + 300
	lixeiraAzul.y = y/1.2
	physics.addBody( lixeiraAzul, 'static' )
	lixeiraAzul.myName = 'lixeira azul'

	local lixeiraVerde = display.newImageRect( grupoGame, 'imagens/lixo-verde.png', 200, 400 )
	lixeiraVerde.x = mx - 300
	lixeiraVerde.y = y/1.2
	physics.addBody( lixeiraVerde, 'static' )
	lixeiraVerde.myName = 'lixeira verde'

	local lixoAmarelo = display.newRect( grupoGame, mx - 200, y/4, 100, 100 )
	lixoAmarelo:setFillColor( 1, 1, 0)
	physics.addBody(lixoAmarelo, 'dynamic')
	lixoAmarelo.myName = 'lixo amarelo'

	local lixoVerde = display.newRect( grupoGame, mx - 600, y/4, 100, 100 )
	lixoVerde:setFillColor( 0, 1, 0 )
	physics.addBody(lixoVerde, 'dynamic')
	lixoVerde.myName = 'lixo verde'

	local lixoAzul = display.newRect( grupoGame, mx + 600, y/4, 100, 100 )
	lixoAzul:setFillColor( 0, 0, 1 )
	physics.addBody(lixoAzul, 'dynamic')
	lixoAzul.myName = 'lixo azul'

	local lixoVermelho = display.newRect( grupoGame, mx + 200, y/4, 100, 100 )
	lixoVermelho:setFillColor( 1, 0, 0 )
	physics.addBody(lixoVermelho, 'dynamic')
	lixoVermelho.myName = 'lixo vermelho'

	function moverLixo( event )
		local lixo = event.target
		if (event.phase == 'began') then
			display.currentStage:setFocus( lixo )
			lixo.touchOffsetX = event.x - lixo.x
			lixo.touchOffsetY = event.y - lixo.y
		elseif (event.phase == 'moved') then
			lixo.x = event.x - lixo.touchOffsetX
			lixo.y = event.y - lixo.touchOffsetY
		elseif (event.phase == 'ended' or event.phase == 'cancelled') then
			display.currentStage:setFocus( nil )
		end
	end

	lixoAmarelo:addEventListener( 'touch', moverLixo )
	lixoVermelho:addEventListener( 'touch', moverLixo )
	lixoAzul:addEventListener( 'touch', moverLixo )
	lixoVerde:addEventListener( 'touch', moverLixo )


	function colisao( event )
		if (event.phase == 'began') then
			local obj1 = event.object1
			local obj2 = event.object2

			if (obj1.myName == 'lixo amarelo' and obj2.myName == 'lixeira amarela') or (obj1.myName == 'lixeira amarela' and obj2.myName == 'lixo amarelo') then
				display.remove( lixoAmarelo )
				pontos = pontos + 50
				textoPontos.text = pontos
				audio.play( click )

			elseif (obj1.myName == 'lixo verde' and obj2.myName == 'lixeira verde') or (obj1.myName == 'lixeira verde' and obj2.myName == 'lixo verde') then 
				display.remove( lixoVerde )
				pontos = pontos + 50
				textoPontos.text = pontos
				audio.play( click )
			elseif (obj1.myName == 'lixo azul' and obj2.myName == 'lixeira azul') or (obj1.myName == 'lixeira azul' and obj2.myName == 'lixo azul') then 
				display.remove( lixoAzul )
				pontos = pontos + 50
				textoPontos.text = pontos
				audio.play( click )
			elseif (obj1.myName == 'lixo vermelho' and obj2.myName == 'lixeira vermelha') or (obj1.myName == 'lixeira vermelha' and obj2.myName == 'lixo vermelho') then 
				display.remove( lixoVermelho )
				pontos = pontos + 50
				textoPontos.text = pontos
				audio.play( click )
			end
		end
	end
	Runtime:addEventListener( 'collision', colisao )


end
cena:addEventListener( 'create', cena )
return cena


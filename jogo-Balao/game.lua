local composer = require('composer')

local cena = composer.newScene( )

function cena:create( event )
	local gameGroup = self.view


	-- Pegando tamanho da tela
	local x = display.contentWidth
	local y = display.contentHeight

	-- Removendo barra de status
	display.setStatusBar( display.HiddenStatusBar )

	-- chamando pela biblioteca de fisica
	local physics = require('physics')

	-- Inciar a ficia
	physics.start()

	-- Alterar como visualizamos o corpo fisico
	physics.setDrawMode('hybrid')

	-- Adicionando Fundo
	local fundo = display.newImageRect( gameGroup, 'imagens/background-game.jpg', x, y)
	fundo.x = x/2
	fundo.y = y/2
	
	-- Valor incinal da pontuação
	local pontos = 0

	-- Pontuacao na tela
	local textoPontos = display.newText(gameGroup, pontos, x/2, 200, native.systemFontBold, 200 )

	-- Adicionando balao
	local balao = display.newImage( gameGroup,'imagens/balao-loading.png', 300, 300 )
	balao.x = x/2
	balao.y = y/4
	physics.addBody( balao, 'dynamic', {radius = 200, bounce = 0.5} )

	-- Adicionando Chao
	local chao = display.newRect( gameGroup, x/2, y, x, 300 )
	chao:setFillColor( 0.3, 1, 0.3 )
	physics.addBody( chao, 'static')

	-- Funcao para dar impulso no balao
	function impulso( event )
		local randomImpulseY = math.random( -50, 0 )
		balao:applyLinearImpulse( 0, randomImpulseY, balao.x, balao.y )
		
		pontos = pontos + 1
		textoPontos.text = pontos

		local click = audio.loadSound( 'audio/efeito-click.mp3' )
		audio.play(click)
	end
	balao:addEventListener( 'tap', impulso )


	-- botao para dar impulso no balao
	local botao = display.newCircle(gameGroup, 200, y/1.2, 100 )
	botao:setFillColor( 0,1,0 )

	function impulsoBotao( event )
			local randomImpulseX = math.random( -50, 50 )
		balao:applyLinearImpulse( randomImpulseX, 0, balao.x, balao.y )
		
		pontos = pontos + 1
		textoPontos.text = pontos

		local click = audio.loadSound( 'audio/efeito-click.mp3' )
		audio.play(click)
	end

	botao:addEventListener( 'tap', impulsoBotao )

	local paredeE = display.newRect( gameGroup, 0, y/2, 100, y )
	physics.addBody( paredeE, 'static' )

	local paredeD = display.newRect( gameGroup, x, y/2, 100, y )
	physics.addBody( paredeD, 'static' )

	local teto = display.newRect( gameGroup, x/2, 0, x, 100 )
	physics.addBody( teto, 'static' )

end
cena:addEventListener( 'create', cena )
return cena
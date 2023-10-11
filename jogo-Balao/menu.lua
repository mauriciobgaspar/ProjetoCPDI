local composer = require('composer')

local cena = composer.newScene( )

function cena:create( event )
	local menuGroup = self.view

	-- iniciando musica
	local musica1 = audio.loadStream( 'audio/musica1.mp3')
	audio.play( musica1, {channel = 1 } )
	audio.setVolume( 0.3, {channel = 1} )

	-- Pegando tamanho da tela
	local x = display.contentWidth
	local y = display.contentHeight

	-- Removendo barra de status
	display.setStatusBar( display.HiddenStatusBar )

	-- Adicionando Fundo
	local fundo = display.newImageRect( menuGroup, 'imagens/background-menu.jpg', x, y)
	fundo.x = x/2
	fundo.y = y/2
	
	-- Adicionando Titulo do jogo
	local texto = display.newText(menuGroup, 'Ballon Gravity', x/2, y/5, native.systemFontBold, 130)
	texto:setFillColor( 0.5, 0.2, 0.2 )

	-- Adicionando Botao JOGAR
	local botaoJogar = display.newImageRect( menuGroup, 'imagens/botao-menu.png', x/1.5, 250 )
	botaoJogar.x = x/2
	botaoJogar.y = y/1.4

	-- Adicionando texto do botao JOGAR
	local textoJogar = display.newText(menuGroup, 'JOGAR', x/2, y/1.4, native.systemFontBold, 100 )

	-- Adicionando Botao TUTORIAL
	local botaoTutorial = display.newImageRect( menuGroup, 'imagens/botao-menu.png', x/1.5, 250 )
	botaoTutorial.x = x/2
	botaoTutorial.y = y/1.2

-- Adicionando texto do botao TUTORIAL
	local textoTutorial = display.newText(menuGroup, 'TUTORIAL', x/2, y/1.2, native.systemFontBold, 100 )

	-- funcao que ao clicar no botaoTutorial irá para cena tutorial
	function cenaTutorial( event )
		local parametros = {
			effect = 'slideLeft',
			time = 1000
		}

		composer.gotoScene( 'tutorial', parametros )

		local click = audio.loadSound( 'audio/efeito-click.mp3' )
		audio.play(click)
	end
	botaoTutorial:addEventListener( 'touch', cenaTutorial )


	-- funcao que ao clicar no botaoJogar irá para cena Game
	function cenaGame( event )
		local parametros = {
			effect = 'slideLeft',
			time = 1000
		}

		composer.gotoScene( 'game', parametros )

		local click = audio.loadSound( 'audio/efeito-click.mp3' )
		audio.play(click)
	end
	botaoJogar:addEventListener( 'touch', cenaGame )





end
cena:addEventListener( 'create', cena )
return cena
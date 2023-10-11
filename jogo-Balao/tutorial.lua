local composer = require('composer')

local cena = composer.newScene( )

function cena:create( event )
	local tutorialGroup = self.view


	-- Pegando tamanho da tela
	local x = display.contentWidth
	local y = display.contentHeight

	-- Removendo barra de status
	display.setStatusBar( display.HiddenStatusBar )

	-- Adicionando Fundo
	local fundo = display.newImageRect( tutorialGroup, 'imagens/background-tutorial.jpg', x, y)
	fundo.x = x/2
	fundo.y = y/2
	
	-- Adicionando Titulo do tutorial
	local texto = display.newText(tutorialGroup, 'Tutorial :)', x/2, y/5, native.systemFontBold, 130)
	texto:setFillColor( 0.5, 0.2, 0.2 )

	-- Adicionando Botao JOGAR
	local botaoJogar = display.newImageRect( tutorialGroup, 'imagens/botao-menu.png', x/1.5, 250 )
	botaoJogar.x = x/2
	botaoJogar.y = y/1.4

	-- Adicionando texto do botao JOGAR
	local textoJogar = display.newText(tutorialGroup, 'JOGAR', x/2, y/1.4, native.systemFontBold, 100 )

	-- Adicionando Botao VOLTAR
	local botaoVoltar = display.newImageRect( tutorialGroup, 'imagens/botao-menu.png', x/1.5, 250 )
	botaoVoltar.x = x/2
	botaoVoltar.y = y/1.2

-- Adicionando texto do botao VOLTAR
	local textoVoltar = display.newText(tutorialGroup, 'VOLTAR', x/2, y/1.2, native.systemFontBold, 100 )

	-- funcao que ao clicar no botaoTutorial irá para cena MENU
	function cenaVoltar( event )
		local parametros = {
			effect = 'slideRight',
			time = 1000
		}

		composer.gotoScene( 'menu', parametros )

		local click = audio.loadSound( 'audio/efeito-click.mp3' )
		audio.play(click)
	end
	botaoVoltar:addEventListener( 'touch', cenaVoltar )


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
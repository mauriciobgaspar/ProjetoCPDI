local composer = require('composer')

local cena = composer.newScene( )

function cena:create( event )
	local loadingGroup = self.view

	-- Pegando tamanho da tela
	local x = display.contentWidth
	local y = display.contentHeight

	-- Removendo barra de status
	display.setStatusBar( display.HiddenStatusBar )

	-- Adicionando Fundo
	local fundo = display.newRect( loadingGroup, x/2, y/2, x, y )
	fundo:setFillColor( 0.3,0.3,1 )

	-- Adicionando Logo
	local balao = display.newImageRect( loadingGroup, 'imagens/balao-loading.png', 700, 700 )
	balao.x = x/2
	balao.y = y/2
	transition.blink( balao, {time = 3000} )

	-- Funcao para trocar de cena
	function proximaCena( event )
		local parametros = {
			effect = 'slideLeft',
			time = 1000
		}

		composer.gotoScene( 'menu', parametros )
	end

	-- espera 5 segundo e chama pela funcao proximaCena
	timer.performWithDelay( 5000, proximaCena )

end
cena:addEventListener( 'create', cena )
return cena
local x = display.contentWidth
local y = display.contentHeight

display.setStatusBar( display.HiddenStatusBar )


local physics = require('physics')
physics.start( )
physics.setGravity( 0, 0 )
physics.setDrawMode( 'hybrid' )


local fundo = display.newRect( x/2, y/2, x, y )
fundo:setFillColor( 0.5, 0.2, 0.4 )

local personagem = display.newImageRect('imagens/personagem.png', 200, 200 )
personagem.x = x/1.2
personagem.y = y/2
physics.addBody( personagem, 'dynamic' )


local inimigo1 = display.newRect( x/2, y/2, 200, 200 )
physics.addBody( inimigo1, 'static' )

local inimigo2 = display.newRect( x/2, y/2, 200, 200 )
inimigo2:setFillColor( 0,1,0 )
physics.addBody( inimigo2, 'static' )


function moverPersonagem( event )
	if (event.phase == 'began') then
		transition.to( personagem, {time = 1000, x = event.x, y = event.y } )
	end
end
Runtime:addEventListener( 'touch', moverPersonagem )


function moverInimigo( event )
	transition.to(inimigo1, {time = 1000, x = math.random( 0, x ) , y = math.random(0 , y ) })

	transition.to(inimigo2, {time = 1000, x = math.random( 0, x ) , y = math.random(0 , y ) })
end
timer.performWithDelay( 2000, moverInimigo, 0)


function colisaoGlobal( event )
	personagem:removeSelf()
end
Runtime:addEventListener( 'collision', colisaoGlobal )


function passouDeFase( event )
	composer.gotoScene( 'menu' )
end
 timer.performWithDelay( 20000, passouDeFase )
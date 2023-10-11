local composer = require('composer')

local cena = composer.newScene()

function cena:create( event )
	local grupoJogo = self.view

	local x = display.contentWidth
	local y = display.contentHeight
	local mx = display.contentCenterX
	local my = display.contentCenterY

	display.setStatusBar( display.HiddenStatusBar )

	local physics = require('physics')
	physics.start( )
	physics.setGravity( 0, 0 )
	physics.setDrawMode( 'normal' )

	local fundoAleatorio = math.random( 1, 3 )

	function criaFundo( )
		if (fundoAleatorio == 1) then
			local fundo1 = display.newImage( grupoJogo, 'imagens/fundo.jpg', mx, my )
			fundo1.width = x
			fundo1.height = y 

		elseif(fundoAleatorio == 2) then
			local fundo2 = display.newImage( grupoJogo, 'imagens/fundo2.jpg', mx, my )
			fundo2.width = x
			fundo2.height = y 

		elseif(fundoAleatorio == 3) then
			local fundo3 = display.newImage( grupoJogo, 'imagens/fundo3.png', mx, my )
			fundo3.width = x
			fundo3.height = y 
		end
	end
	criaFundo()


	local nave = display.newImage( grupoJogo, 'imagens/nave.png', mx, y - 60 )
	nave.width = 80
	nave.height = 70
	physics.addBody( nave, 'static', {radius = 30} )
	nave.myName = 'nave'

	
	local asteroideTabela = {}

	local pontos = 0
	local textoPontos = display.newText( grupoJogo, pontos, 30, 50 , nil , 30 )

	local vidas = 3
	local textoVidas = display.newText( grupoJogo, vidas, x - 30, 50, nil, 30 )



	function moverNave( event )
		local nave = event.target
		if (event.phase == 'began') then
			display.currentStage:setFocus( nave )
			nave.touchOffsetX = event.x - nave.x
		elseif (event.phase == 'moved') then
			nave.x = event.x - nave.touchOffsetX
		elseif(event.phase == 'ended' or event.phase == 'cancelled') then
			display.currentStage:setFocus( nil )
		end
	end
	nave:addEventListener( 'touch', moverNave )


	function atirar( event )
		if (event.phase  == 'began') then

			local novoLaser = display.newImageRect( grupoJogo, 'imagens/laser.png', 20, 50 )
			novoLaser.x = nave.x
			novoLaser.y = nave.y - 60
			physics.addBody(novoLaser, 'dynamic')
			novoLaser.myName = 'laser'
			novoLaser.isBullet = true

			transition.to( novoLaser, {y = -100, time = 500,
			 onComplete = function()
				display.remove( novoLaser )
			 end } )

		end
	end
	nave:addEventListener( 'touch', atirar )


	function criaAsteroide(  )
		local novoAsteroide = display.newImageRect( grupoJogo, 'imagens/asteroide.png', 80, 80 )
		table.insert(asteroideTabela, novoAsteroide)
		physics.addBody(novoAsteroide, 'dynamic', {radius = 25, bounce = 1})
		novoAsteroide.myName = 'asteroide'

		
		local localizacao = math.random( 1, 3 )

		if (localizacao == 1) then
			novoAsteroide.x = -60
			novoAsteroide.y = math.random( -100, 0 )
			novoAsteroide:setLinearVelocity( math.random( 10, 40 ), math.random( 10, 40 ) )

		elseif(localizacao == 2) then
			novoAsteroide.x = x + 60
			novoAsteroide.y = math.random( -100, 0 )
			novoAsteroide:setLinearVelocity( math.random( -10, 40 ), math.random( 10, 40 ) )


		elseif(localizacao == 3) then
			novoAsteroide.x = math.random( x )
			novoAsteroide.y = -100
			novoAsteroide:setLinearVelocity( math.random( -40, 40 ), math.random( 10, 40 ) )

		end

		novoAsteroide:applyTorque(math.random(-1, 1))
	end
	
	function gameLoop()
		criaAsteroide()

		-- for i = #asteroideTabela, 1, -1 do 
		-- 	local asteroide = asteroideTabela[i]

		-- 	if (asteroide.x < - 400 or asteroide.x > x + 400
		-- 		or asteroide.y < 400 or asteroide.y > y + 400) then
				
		-- 		display.remove( asteroide )
		-- 		table.remove( asteroideTabela, i )
		-- 	end
		-- end
	end
	timer.performWithDelay( 500, gameLoop, 0 )



	local function colisao( event )
		if (event.phase == 'began') then
			
			local objt1 = event.object1
			local objt2 = event.object2

			
			if (objt1.myName == 'laser' and objt2.myName == 'asteroide') or 
			(objt1.myName == 'asteroide' and objt2.myName == 'laser')  then
				display.remove(objt1)
				display.remove(objt2)

				for i = #asteroideTabela, 1 , -1 do
					if (asteroideTabela[i] == objt1 or asteroideTabela[i] == objt2 ) then
						table.remove( asteroideTabela, i )
					end
				end
				pontos = pontos + 10
				textoPontos.text = pontos
			
			elseif (objt1.myName == 'nave' and objt2.myName == 'asteroide') or 
			(objt1.myName == 'asteroide' and objt2.myName == 'nave')then  
				vidas = vidas - 1
				textoVidas.text = vidas

				if (vidas == 0) then
					display.remove( nave )
				end
			end

		end
	end
	Runtime:addEventListener( 'collision', colisao )


end
cena:addEventListener( 'create', cena )
return cena
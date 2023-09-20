
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local scriptPlayer = require ("Player")
local scriptPlacar = require ("Placar")
local perspective = require ("perspective")
local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode ("normal")


local camera

local grupoBg
local grupoMain 
local placar

local function gotoMenu()
	composer.gotoScene ("menu", {time=800, effect="crossFade"})
end

	
	-- Colisões 


	local function onCollision (event)

	if (event.phase == "began" ) then

		local obj1 = event.object1
		local obj2 = event.object2

		if ((obj1.myName == "Lixo" and obj2.myName == "Turtle") or (obj1.myName == "Turtle" and obj2.myName == "Lixo"))
		then
			placar.somarVidas()
			audio.play (lata, {channel=2})
		end

		if ((obj1.myName == "BB" and obj2.myName == "Turtle") or (obj1.myName == "Turtle" and obj2.myName == "BB"))
		then
			placar.somarPontos()
			audio.play (coletavel, {channel=2})
			if (obj1.myName=="BB") then
				display.remove (obj1)
			else
				display.remove (obj2)
			end
		end
		if ((obj1.myName == "Exit" and obj2.myName == "Turtle") or (obj1.myName == "Turtle" and obj2.myName == "Exit"))
		then

			placar.comparar ()
			audio.play (alga, {channel=2})
		end
	end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	print ("Fase1")

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause()

	camera = perspective.createView()
	camera:prependLayer () -- prepara os layers da camera.
	--
	sceneGroup:insert (camera)
	--
	
	grupoBg = display.newGroup()
	sceneGroup:insert (grupoBg)
	grupoMain = display.newGroup()
	sceneGroup:insert (grupoMain)
	placar = scriptPlacar.novo (grupoMain)

	--
	sceneGroup:insert(placar)
	--

	-- Background - Beach
	local bg = display.newImageRect (grupoBg, "imagens/beach.png", 2000*1.3, 2000*1.3)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	camera:add (bg, 8)

	-- Castelos

	for i = -5,5 do
		local castle = display.newImageRect (grupoMain, "imagens/castle2.png", 500*0.25, 500*0.25)
		castle.x = i * (math.random(-50,200))
		castle.y = i*250
		castle.myName = "Castelo"
		physics.addBody (castle, "static")
		camera:add (castle, 7)
	end

	-- Saída

	local Exit = display.newImageRect (grupoMain, "imagens/Exit2.png", 578*0.25, 432*0.25)
	Exit.x = display.contentCenterX + 50
	Exit.y = -1000
	Exit.myName = "Exit"
	physics.addBody (Exit, "static")
	camera:add (Exit, 7)

	--Player - Turtle

	local player = scriptPlayer.novo (grupoMain,500, 500, placar)
	camera:add (player, 1)

	camera.damping = 10 -- Controla a fluidez da camêra ao seguir o player.
	camera:setFocus (player)
	camera:track() -- inicia a perseguição da camera

	-- Barreiras - Lixo

	for i = -5,5 do

		local barreira = display.newImageRect (grupoMain, "imagens/can2.png", 171*0.25, 143*0.25)
		barreira.x =-250
		barreira.y = (i*250)-70
		physics.addBody (barreira, "dynamic")
		barreira.myName = "Lixo"
		local direcaoBarreira = "direita"
		
		camera:add (barreira, 2)


		local function movimentarBarreira ()
	
			if not (barreira.x == nil ) then
				
				if (direcaoBarreira == "direita" ) then
					barreira.x = barreira.x + (math.random(1, 5))
					barreira.xScale = 1
	
					if (barreira.x >= 550 ) then
						direcaoBarreira = "esquerda"
						barreira.xScale = -1
					end
	
				elseif (direcaoBarreira == "esquerda" ) then
					barreira.x = barreira.x - (math.random(1, 5))
					
					if (barreira.x <= -250 ) then
						direcaoBarreira = "direita"
					end
				end
			end
		end
	
		Runtime:addEventListener ("enterFrame", movimentarBarreira)
	end
		-- Babies
	for i = -6,6 do
		local babyBlue = display.newImageRect ( "imagens/turtle4.png", 255*0.15, 265*0.15)
		babyBlue.x = i*(math.random(-50,200))
		babyBlue.y = i*150
		babyBlue.myName = "BB"
		physics.addBody (babyBlue, "dynamic")
		babyBlue.isFixedRotation = true
		--babyBlue:setFillColor (61/255, 72/255, 245/255)
		babyBlue.xScale = 1
		camera:add (babyBlue, 2)
	end

	-- botão retorno menu

	local button = display.newImageRect (grupoMain,"cenas/botaomenu.png", 248/4, 100/4)
	button.x = 306
	button.y = 465
	button:addEventListener ("tap", gotoMenu)

	coletavel = audio.loadSound ("audios/coletavel.mp3")
    lata = audio.loadSound ("audios/erro.mp3")
    fundo = audio.loadSound ("audios/fase1.mp3")
	
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		-- Runtime:addEventListener ("enterFrame", movimentarBarreira)
		Runtime:addEventListener ("collision", onCollision)
		audio.play (fundo, {channel=4, loops=-1})
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		Runtime:removeEventListener ("collision", onCollision)
		Runtime:removeEventListener ("enterFrame", movimentarBarreira)
		physics.pause ()
		-- Remove todos os objetos do grupoMain e da câmera
		for i = grupoMain.numChildren, 1, -1 do
			local child = grupoMain[i]
			display.remove(child)
		end
		camera:destroy()
		composer.removeScene ("fase1")
		audio.stop(1)
		audio.stop(2)
		audio.stop(3)
		audio.stop(4)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose (coletavel)
    audio.dispose (lata)
    audio.dispose (fundo)
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

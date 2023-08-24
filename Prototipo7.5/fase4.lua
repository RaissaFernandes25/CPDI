
local composer = require( "composer" )

local scene = composer.newScene()

fundo = audio.loadSound ("audios/fase4.mp3")
audio.play (fundo, {channel=4, loops=-1})

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- função voltar para menu

local function gotoMenu()
	composer.gotoScene ("menu", {time=800, effect="crossFade"})
end

local physics = require ("physics")
physics.start()
physics.setGravity (0, 9,8)
physics.setDrawMode ("normal")

local plataforma
local tartaruga
local toquesText

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	print ("Fase4")

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

		
		--physics.pause()

		local bg = display.newImageRect (sceneGroup, "imagens/beach.png", 2000*0.25, 2000*0.25)
		bg.x = display.contentCenterX
		bg.y = 210
		bg.rotation = 180

		local predadores = display.newImageRect (sceneGroup, "imagens/platform.png",2000*0.18, 2000*0.18)
		predadores.x = display.contentCenterX
		predadores.y = 300

		local plataforma = display.newRoundedRect (sceneGroup, display.contentCenterX, 440, 300, 25, 1)
		plataforma.alpha = 0.01
		physics.addBody (plataforma,"static")
		
		local tartaruga = display.newImageRect (sceneGroup, "imagens/card1.png",1080*0.10,1080*0.10)
		tartaruga.x = display.contentCenterX
		tartaruga.y = display.contentCenterY
		tartaruga.rotation = 90
		
		physics.addBody (tartaruga,"dynamic", {radius=50, bounce=0.6})

		--botão voltar para menu
		local button = display.newImageRect (sceneGroup,"cenas/botaomenu.png", 248/4, 100/4)
		button.x = 306
		button.y = 465
    	button:addEventListener ("tap", gotoMenu)

		local fundo = display.newImageRect (sceneGroup,"cenas/placar.png", 507/4, 100/4)
    	fundo.x = 45
    	fundo.y = 15

		local numToques=0

		local toquesText = display.newText (numToques, 73, 15.5, native.systemFont, 20)
		toquesText:setFillColor (1,1,1)

		sceneGroup:insert(toquesText)

		local function cima ()
			-- Parametros: (impulsox,impulsoy,objeto.x,objeto.y)
			tartaruga:applyLinearImpulse (0,-0.75,tartaruga.x,tartaruga.y)
			numToques=numToques+1
			toquesText.text = numToques
			audio.play (pulo, {channel=5})
		end
		
		-- Função Game Over
		local function finish ()
			numToques=0
			composer.gotoScene ("gameOver", {time = 200, effect = "crossFade"})
			audio.play (erro, {channel=5})
		end	

		local function fase4check ()
			if (numToques >= 15) then
				composer.gotoScene ("fase4check", { time = 600, effect = "crossFade"})
			end
		end

		plataforma:addEventListener ("collision",finish)
		tartaruga:addEventListener ("tap",cima)
		tartaruga:addEventListener ("tap",fase4check)

    	erro = audio.loadSound ("audios/erro.mp3")
		pulo = audio.loadSound ("audios/pulo.mp3")
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
		physics.pause ()
		
		composer.removeScene ("fase4")
		audio.stop(1)
		audio.stop(2)
		audio.stop(3)
		audio.stop(4)
		audio.stop(5)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	
    audio.dispose (erro)
	audio.dispose (pulo)
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

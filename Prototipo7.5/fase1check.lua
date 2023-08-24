
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local fundo

local function gotoIntro2()
	composer.gotoScene ("intro2", {time=800, effect="crossFade"})
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	print ("Fase 1 Check")

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local bg = display.newImageRect (sceneGroup,"cenas/fase1check.png", 1520/4, 1920/4)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	local botaoOk = display.newRoundedRect (sceneGroup, display.contentCenterX, 391, 100, 25, 10)
	botaoOk.alpha = 0.01
	botaoOk:addEventListener ("tap", gotoIntro2)

	vitoria = audio.loadSound ("audios/vitoria.mp3")
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play (vitoria, {channel=5})
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
		audio.stop(5)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose (vitoria)
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


local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local fundo

local function gotoFase1()
	composer.gotoScene ("fase1", {time=800, effect="crossFade"})
end

local function gotoMenu()
	composer.gotoScene ("menu", {time=800, effect="crossFade"})
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	print ("Intro1")

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local bg = display.newImageRect (sceneGroup,"cenas/fase1.png", 1520/4, 1920/4)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	local botaoOk = display.newRoundedRect (sceneGroup, display.contentCenterX, 391, 100, 25, 10)
	botaoOk.alpha = 0.01
	botaoOk:addEventListener ("tap", gotoFase1)

	local botaoVoltar = display.newRoundedRect (sceneGroup, display.contentCenterX, 435, 100, 25, 10)
	botaoVoltar.alpha = 0.01
	botaoVoltar:addEventListener ("tap", gotoMenu)

end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

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
		audio.stop(8)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
	audio.dispose (audiofundo)
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

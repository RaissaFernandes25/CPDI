
local composer = require( "composer" )

local scene = composer.newScene()


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local fundo

local function gotoIntro1()
	composer.gotoScene ("intro1", {time=800, effect="crossFade"})
	audio.play (audiofundo, {channel=8, loops=-1})
end

local function gotoIntro2()
	composer.gotoScene ("intro2", {time=800, effect="crossFade"})
	audio.play (audiofundo, {channel=8, loops=-1})
end

local function gotoIntro3()
	composer.gotoScene ("intro3", {time=800, effect="crossFade"})
	audio.play (audiofundo, {channel=8, loops=-1})
end

local function gotoIntro4()
	composer.gotoScene ("intro4", {time=800, effect="crossFade"})
	audio.play (audiofundo, {channel=8, loops=-1})
end




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	print ("Menu")

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local bg = display.newImageRect (sceneGroup,"cenas/menu.png", 1520/4, 1920/4)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	local botaoFase1 = display.newRoundedRect (sceneGroup, display.contentCenterX, 284, 133, 31, 9)
	botaoFase1.alpha = 0.01
	botaoFase1:addEventListener ("tap", gotoIntro1)

	local botaoFase2 = display.newRoundedRect (sceneGroup, display.contentCenterX, 325, 133, 31, 9)
	botaoFase2.alpha = 0.01
	botaoFase2:addEventListener ("tap", gotoIntro2)

	local botaoFase3 = display.newRoundedRect (sceneGroup, display.contentCenterX, 365, 133, 31, 9)
	botaoFase3.alpha = 0.01
	botaoFase3:addEventListener ("tap", gotoIntro3)

	local botaoFase4 = display.newRoundedRect (sceneGroup, display.contentCenterX, 406, 133, 31, 9)
	botaoFase4.alpha = 0.01
	botaoFase4:addEventListener ("tap", gotoIntro4)

	audiofundo = audio.loadSound ("audios/fundo.mp3")
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	audio.play (audiofundo, {channel=8, loops=-1})
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

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

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

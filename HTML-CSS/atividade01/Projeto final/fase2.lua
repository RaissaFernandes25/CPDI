
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local scriptPlayer = require ("Player")
local scriptPlacar = require ("Placar")
local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode ("normal")

local backGroup
local mainGroup
local placar
local trashTable = {}
local foodTable = {}
local gameLoopTimer

-- função voltar para menu

local function gotoMenu()
	composer.gotoScene ("menu", {time=800, effect="crossFade"})
end

-- Lixo

local function criartrash ()
    local trash = display.newImageRect (mainGroup,"imagens/bag2.png", 210*0.20, 250*0.20)
    table.insert (trashTable, trash)
    physics.addBody (trash, "dynamic", {radius=20, bounce=0.8})
    trash.myName = "Trash"

    trash.x = -60
    trash.y = math.random (500)
    trash:setLinearVelocity (math.random(40,50), math.random(20,30))
end

-- Agua viva = food

local function criarfood ()
    local food = display.newImageRect (mainGroup,"imagens/jellyfish2.png", 512*0.10, 487*0.10)
    table.insert (foodTable, food)
    physics.addBody (food, "dynamic", {radius=20, bounce=0.8})
    food.myName = "Food"

    food.x = display.contentWidth + 60
    food.y = math.random (500)
    food:setLinearVelocity (math.random(-40,-25), math.random(20,25))
end

-- gerar lixo

local function gameLoop ()
    criartrash ()

    for i = #trashTable, 1, -1 do 
        local thistrash = trashTable [1]

        if (thistrash.x < -100 or thistrash.x > display.contentWidth + 100 or thistrash.y < -100 or thistrash.y > display.contentHeight + 100) then
            display.remove (thistrash)
            table.remove (trashTable, i)
        end
    end 

-- gerar food

    criarfood ()

    for i = #foodTable, 1, -1 do 
        local thisfood = foodTable [1]

        if (thisfood.x < -100 or thisfood.x > display.contentWidth + 100 or thisfood.y < -100 or thisfood.y > display.contentHeight + 100) then
            display.remove (thisfood)
            table.remove (foodTable, i)
        end
    end 
end
-- Colisões

local function onCollision (event)

    if (event.phase == "began" ) then

        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "Trashcan" and obj2.myName == "Food") or (obj1.myName == "Food" and obj2.myName == "Trashcan"))
        then
            if (obj1.myName == "Food") then 
                display.remove (obj1)
            else
                display.remove (obj2)
            end

            for i = #foodTable, 1, -1 do
                if (foodTable[i] == obj1 or foodTable[i] == obj2) then
                    table.remove (foodTable, i)
                    break
                end 
            end 
            audio.play (erro, {channel=4})
            placar.somarVidas()

        elseif ((obj1.myName == "Trashcan" and obj2.myName == "Trash") or (obj1.myName == "Trash" and obj2.myName == "Trashcan"))
        then
            if (obj1.myName == "Trash") then 
                display.remove (obj1)
            else
                display.remove (obj2)
            end

            for i = #trashTable, 1, -1 do
                if (trashTable[i] == obj1 or trashTable[i] == obj2) then
                    table.remove (trashTable, i)
                    break
                end 
            end 
            audio.play (acerto, {channel=4})
            placar.somarPontos()
            placar.comparar2()
        end
        --
        if ((obj1.myName == "Trash" and obj2.myName == "Group") or (obj1.myName == "Group" and obj2.myName == "Trash"))
        then
            if (obj1.myName == "Trash") then 
                display.remove (obj1)
            else
                display.remove (obj2)
            end

            for i = #trashTable, 1, -1 do
                if (trashTable[i] == obj1 or trashTable[i] == obj2) then
                    table.remove (trashTable, i)
                    break
                end 
            end 
            audio.play (erro, {channel=4})
            placar.somarVidas()

        elseif ((obj1.myName == "Group" and obj2.myName == "Food") or (obj1.myName == "Food" and obj2.myName == "Group"))
        then
            if (obj1.myName == "Food") then 
                display.remove (obj1)
            else
                display.remove (obj2)
            end

            for i = #foodTable, 1, -1 do
                if (foodTable[i] == obj1 or foodTable[i] == obj2) then
                    table.remove (foodTable, i)
                    break
                end 
            end 
            audio.play (acerto, {channel=4})
            placar.somarPontos()
            placar.comparar2()
        end
    end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    print ("Fase2")

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen


	physics.pause()
	backGroup = display.newGroup ()
    sceneGroup:insert (backGroup)
	mainGroup = display.newGroup ()
    sceneGroup:insert (mainGroup)
	placar = scriptPlacar.novo ()
    --
    sceneGroup:insert(placar)
    --


	-- Backgrounds 

	local bg1 = display.newImageRect (backGroup, "imagens/sea.png", 1999*0.25, 2000*0.25)
	bg1.x = 160
	bg1.y = 240
	bg1.xScale = 1.202
	bg1.yScale = 1.200
	transition.to (bg1, {time=12000, x=-224, iterations=0})

	local bg2 = display.newImageRect (backGroup, "imagens/sea.png", 1999*0.25, 2000*0.25)
	bg2.x, bg2.y = 544, 240
	bg2.xScale = 1.202
	bg2.yScale = 1.200
	transition.to (bg2, {time=12000, x=160, iterations=0})

	-- Player

	local player = scriptPlayer.novo (display.contentCenterX, display.contentCenterY - 100, placar)
	mainGroup:insert (player)

	-- Lixeira

	local trashcan = display.newImageRect (mainGroup, "imagens/trashcan2.png", 167*0.35, 200*0.35)
	trashcan.x = display.contentCenterX -150
	trashcan.y = 450
	trashcan.myName = "Trashcan"
	physics.addBody (trashcan, "static")

	-- Barreira Lixeira

	local trashBar= display.newRect (backGroup,display.contentCenterX -165,455, 80,80)
	physics.addBody (trashBar, "static")
	trashBar:setFillColor(1, 1, 1, 0.01)

	-- Babies

	local turtleGroup = display.newImageRect (mainGroup, "imagens/turtleNest3.png", 492*0.20, 460*0.20)
	turtleGroup.x = 290
	turtleGroup.y = 55
	turtleGroup.myName = "Group"
	physics.addBody (turtleGroup, "static")

	-- Barreira Babies

	local babiesBar= display.newRect (backGroup,305, 45, 110,110)
	physics.addBody (babiesBar, "static")
	babiesBar:setFillColor(1, 1, 1, 0.01)

    --botão voltar para menu
    local button = display.newImageRect (mainGroup,"cenas/botaomenu.png", 248/4, 100/4)
	button.x = 306
	button.y = 465
	button:addEventListener ("tap", gotoMenu)
    
    acerto = audio.loadSound ("audios/check.mp3")
    erro = audio.loadSound ("audios/erro.mp3")
    fundo = audio.loadSound ("audios/fase2.mp3")
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
        gameLoopTimer = timer.performWithDelay (2000, gameLoop, 0)
		Runtime:addEventListener ("collision", onCollision)
        audio.play (fundo, {channel=3, loops=-1})
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

		timer.cancel (gameLoopTimer)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
		Runtime:removeEventListener ("collision", onCollision)
		physics.pause ()
		composer.removeScene ("fase2")
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
    audio.dispose (acerto)
    audio.dispose (erro)
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

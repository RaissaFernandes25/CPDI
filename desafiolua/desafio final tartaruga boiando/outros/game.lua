
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode ("hybrid") -- ou normal

local spriteOpcoes = 
{
    frames= 
    {
        { -- 1) Asteroide 1
            x=0,
            y=0,
            width=102,
            height=85
        },
        {--2)Asteroide 2
            x=0,
            y=85,
            width=90,
            height=83
        },
        {-- 3) Asteroide 3
            x=0,
            y=168,
            width=100,
            height=97
        }, 
        { -- 4) Nave
            x=0,
            y=265,
            width=98,
            height=79
        },
        { -- 5) Laser
            x=98,
            y=265,
            width=14,
            height=40
        }
    }
}

local sprite = graphics.newImageSheet ("imagens/sprite.png", spriteOpcoes)

local vidas = 3
local pontos = 0
local asteroideTable = {}
local gameLoopTimer
local morto = false
local nave
local pontosText
local vidasText

local backGroup
local mainGroup
local UIGroup

local explosao
local tiro 
local fundo

local function atualizaText ()
	vidasText.text = " vidas: " .. vidas
	pontosText.text = "Pontos:".. pontos
end

local function criarAsteroide ()
    local novoAsteroide = display.newImageRect (mainGroup, sprite, 1, 102, 85)
    -- incluindo o asteroide na tabela
    table.insert (asteroideTable, novoAsteroide)
    physics.addBody(novoAsteroide, "dynamic", {radius=40, bounce=0.8})
    novoAsteroide.myName = "Asteroide"

    local localizacao = math.random (3)

    if (localizacao == 1) then
        novoAsteroide.x = -60
        novoAsteroide.y = math.random (500)
        novoAsteroide:setLinearVelocity (math.random (40, 120), math.random (20, 60))   
    elseif (localizacao == 2) then
        novoAsteroide.x = math.random (display.contentWidth)
        novoAsteroide.y = -60
        novoAsteroide:setLinearVelocity (math.random (-40, 40), math.random (40, 120))

    elseif (localizacao == 3) then 
        novoAsteroide.x = display.contentWidth + 60
        novoAsteroide.y = math.random (500)
        novoAsteroide:setLinearVelocity (math.random(-120, -40), math.random (20, 60))
    end    

    novoAsteroide:applyTorque (math.random (-6, 6))   
    
end

local function atirar ()

    audio.play (tiro)

    local laser = display.newImageRect (mainGroup, sprite, 5, 14, 40)
    physics.addBody (laser, "dynamic", {isSensor=true})
    laser.isBullet = true
    laser.myName = "Laser"
    laser.x, laser.y = nave.x, nave.y
    laser:toBack ()

    transition.to (laser, {y=-40, time=500, 
                    onComplete = function () display.remove (laser) end})
end

local function moverNave(event)

    local nave = event.target
    local phase = event.phase

    if ("began" == phase) then
    -- define a nave como foco de toque.
        display.currentStage:setFocus(nave)
        nave.touchOffsetX = event.x - nave.x
    elseif ("moved" == phase) then
        nave.x = event.x - nave.touchOffsetX
    elseif ("ended" == phase or "cancelled" == phase) then
        display.currentStage:setFocus(nil)
    end
    return true
end

local function gameLoop()
    criarAsteroide()

    for i = #asteroideTable, 1, -1 do
        local thisAsteroide = asteroideTable[i]

        if (thisAsteroide.x < -100 or thisAsteroide.x > display.contentWidth + 100 or thisAsteroide.y < -100 or thisAsteroide.y > display.contentHeight + 100) then
            display.remove(thisAsteroide)
            table.remove(asteroideTable, i)
        end
    end
end

local function restauraNave ()

    nave.isBodyActive = false
    nave.x = display.contentCenterX
    nave.y = display.contentHeight - 100

    transition.to (nave, {alpha=1, time=4000, onComplete = function ()
                                                nave.isBodyActive = true
                                                morto = false
                                                end })
end 

local function gameOver ()
    composer.setVariable ("scoreFinal",pontos)
    composer.gotoScene ("menu", {time=800, effect="crossFade"})	
end

local function onCollision (event)
    if (event.phase == "began") then 
        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "Laser" and obj2.myName == "Asteroide") or
            (obj1.myName == "Asteroide" and obj2.myName == "Laser")) then 
                display.remove (obj1)
                display.remove (obj2)

                audio.play (explosao)

                for i = #asteroideTable, 1, -1 do
                    if (asteroideTable[i] == obj1 or asteroideTable[i] == obj2) then
                        table.remove (asteroideTable, i)
                        break 
                    end -- if asteroideTable
                end -- for
            pontos = pontos + 100
            pontosText.text = "Pontos: " .. pontos

        elseif ((obj1.myName == "Nave" and obj2.myName == "Asteroide") or
                (obj1.myName == "Asteroide" and obj2.myName == "Nave")) then
                if (morto == false) then
                    morto = true

                    audio.play (explosao)

                        vidas = vidas -1
                        vidasText.text = "Vidas: " .. vidas

                        if (vidas == 0) then
                            display.remove (nave)
							timer.performWithDelay (2000, gameOver)
                        else 
                            nave.alpha = 0

                timer.performWithDelay (1000, restauraNave)
                        end -- if vidas
                end -- if morto 
        end -- if myName
    end -- if event.phase
end -- function


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause()

	backGroup = display.newGroup ()
	sceneGroup:insert (backGroup)
	mainGroup = display.newGroup ()
	sceneGroup:insert (mainGroup)
	UIGroup = display.newGroup ()
	sceneGroup:insert (UIGroup)
	

	local bg = display.newImageRect(mainGroup,"imagens/bg.png", 800, 1400)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

	nave = display.newImageRect (mainGroup, sprite, 4, 98, 79)
	nave.x = display.contentCenterX
	nave.y = display.contentHeight - 100
	physics.addBody (nave, "dynamic", {radius=30, isSensor=true})
	nave.myName = "Nave"

	vidasText = display.newText (UIGroup, "Vidas: " .. vidas, display.contentCenterX-150, display.contentHeight/2*0.1, native.systemFont, 36)
	pontosText = display.newText (UIGroup, "Pontos:"  .. pontos, display.contentCenterX+30, display.contentHeight/2*0.1, native.systemFont, 36)

	nave:addEventListener ("tap", atirar)
	nave:addEventListener("touch", moverNave)

    explosao = audio.loadSound ("audio/explosion.wav")
    tiro = audio.loadSound ("audio/fire.wav")
    fundo = audio.loadStream ("audio/80s-Space-Game_Looping.wav")
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
		gameLoopTimer = timer.performWithDelay (700, gameLoop, 0)
		Runtime:addEventListener ("collision", onCollision)
        audio.play (fundo,{channel=1, loops=-1})
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
		physics.pause()
		composer.removeScene ("game")
        audio.stop (1)
    end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
    audio.dispose (explosao)
    audio.dispose (tiro)
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
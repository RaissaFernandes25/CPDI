local physics = require ("physics")
physics.start ()
physics.setGravity (0,9.8)
physics.setDrawMode ("hybrid")

display.setStatusBar (display.HiddenStatusBar)

local letterboxWidth = (display.actualContentWidth-display.actualContentWidth)/2
local letterboxHeight = (display.actualContentHeight-display.actualContentHeight)/2

local paredeEsquerda = display.newRect (-54-letterboxWidth,display.actualContentHeight-180,600,70)
physics.addBody (paredeEsquerda, "static")
paredeEsquerda.rotation = 86

local chao = display.newRect (display.contentCenterX, display.actualContentHeight + 60 + letterboxHeight, 440, 120)
physics.addBody (chao,"static")

local paredeDireita = display.newRect (display.contentWidth +54 + letterboxWidth, display.contentHeight -180, 600, 70)
physics.addBody (paredeDireita, "static")
paredeDireita.rotation = -86

local bg1 =display.newImageRect ("imagens/background.png",320,480)
bg1.x,bg1.y = 160,240
bg1.xScale = 1.202
bg1.yScale = 1.200
transition.to (bg1, {time=12000,x=-224,iterations=0})

local bg2 =display.newImageRect ("imagens/background.png",320,480)
bg2.x,bg2.y = 544,240
bg2.xScale = 1.202
bg2.yScale = 1.200
transition.to (bg2, {time=12000,x=160,iterations=0})

local heroi = display.newImageRect ("imagens/hero.png", 64,64)
heroi.x, heroi.y = 160,-400
-- Density == densidade (acima de 1 boia, abaixo de 1 afunda)
physics.addBody (heroi,{density=0.7,friction=0.3,bounce=0.2,radius=30})

local function moverHeroi (event)
    local body = event.target
    local phase = event.phase

    if ("began" == phase) then
        display.getCurrentStage (): setFocus (body,event.id)
        body.isFocus = true
        body.tempJoint= physics.newJoint ("touch", body, event.x, event.y)
        body.isFixedRotation = true
    elseif (body.isFocus) then
        if ("moved" == phase) then
            body.tempJoint:setTarget (event.x,event.y)
        elseif ("ended" == phase or "cancelled" == phase) then
            display.getCurrentStage (): setFocus (body,nil)
            body.isFocus = false
            event.target:setLinearVelocity (0,0)
            event.target.angularVelocity=0
            body.tempJoint:removeSelf ()
            body.isFixedRotation = false
        end
    end
    return true
end
heroi:addEventListener ("touch",moverHeroi)

-- Criar um sistema de particulas para a agua
local particulas = physics.newParticleSystem {
    filename="imagens/liquidParticle.png",
    radius=3,
    imageRadius=5,
    gravityScale=1.0, -- escala de gravudade das particulas
    strictContactCheck = true -- checagem de contato ativada
}

-- Criar um bloco de agua 
particulas:createGroup( 
    {
        flags={"tensile"},-- tração
        x=160,
        y=0,
        color= {0.1,0.1,0.1,1},
        halfWidth=128,
        halfHeight=256
    }
)

-- Inicializa a tela cheia instantanea
local snapshot = display.newSnapshot (320+letterboxWidth+letterboxWidth,480+letterboxHeight+letterboxHeight)
local snapshotGroup= snapshot.group 
snapshot.x,snapshot.y=160,240
snapshot.canvasMode="discard"
snapshot.alpha=0.3

-- Aplica um filtro sobel para retratar a superficie visivel da agua.
snapshot.fill.effect = "filter.sobel"

-- inclui o sistema de particulas dentro do snapshot.
snapshotGroup:insert (particulas)
snapshotGroup.x = -160
snapshotGroup.y= -240

-- Tras o heroi para frente.
heroi:toFront()

-- Invalida o snapshot de cada frame.
local function onEnterFrame (event)
    snapshot:invalidate()
end

Runtime:addEventListener("enterFrame",onEnterFrame)
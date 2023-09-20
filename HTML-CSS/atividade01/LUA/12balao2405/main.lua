local physics = require ("physics")
physics.start()
physics.setDrawMode ("hybrid")

-- Remover a barra da notificação:
display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/background.png",360,570)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local plataforma = display.newImageRect ("imagens/platform.png",300,50)
plataforma.x = display.contentCenterX
plataforma.y = display.contentHeight - 25
physics.addBody (plataforma,"static")

local balao = display.newImageRect ("imagens/balloon.png",112,112)
balao.x = display.contentCenterX
balao.y = display.contentCenterY
balao.alpha = 0.8
physics.addBody (balao,"dynamic", {radius=50, bounce=0.6})

local numToques=0

local toquesText = display.newText (numToques, display. contentCenterX, 50, native.systemFont,40)
toquesText:setFillColor (0,0,0)

local function cima ()
    -- Parametros: (impulsox,impulsoy,objeto.x,objeto.y)
    balao:applyLinearImpulse (0,-0.75,balao.x,balao.y)
    numToques=numToques+1
    toquesText.text = numToques
end

local function zerou ()
    numToques=0
    toquesText.text = numToques
end

plataforma:addEventListener ("collision",zerou)
balao:addEventListener ("tap",cima)
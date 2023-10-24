local physics = require ("physics")
physics.start()
physics.setDrawMode ("hybrid")

-- Remover a barra da notificação:
display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/beach.png",1301,1300)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local plataforma = display.newImageRect ("imagens/platform.png",300*2,50)
plataforma.x = display.contentCenterX
plataforma.y = display.contentHeight +100
physics.addBody (plataforma,"static")

local tartaruga = display.newImageRect ("imagens/turtle2.png",255/2,265/2)
tartaruga.x = display.contentCenterX
tartaruga.y = display.contentCenterY
tartaruga.alpha = 0.8
physics.addBody (tartaruga,"dynamic", {radius=50, bounce=0.6})

local tartarugadois = display.newImageRect ("imagens/turtle2.png",255/5,265/5)
tartarugadois.x = 110
tartarugadois.y = 200

local tartarugatres = display.newImageRect ("imagens/turtle2.png",255/5,265/5)
tartarugatres.x = 210
tartarugatres.y = 200

local foca = display.newImageRect ("imagens/seal.png",348/5,314/5)
foca.x = 130
foca.y = 530

local focaum = display.newImageRect ("imagens/seal.png",348/5,314/5)
focaum.x = 200
focaum.y = 530

local jacare = display.newImageRect ("imagens/aligator.png",174/2,117/2)
jacare.x = 280
jacare.y = 530

local jacareum = display.newImageRect ("imagens/aligator.png",174/2,117/2)
jacareum.x = 50
jacareum.y = 530

local numToques=0

local toquesText = display.newText (numToques, display. contentCenterX, 50, native.systemFont,40)
toquesText:setFillColor (0,0,0)

local function cima ()
    -- Parametros: (impulsox,impulsoy,objeto.x,objeto.y)
    tartaruga:applyLinearImpulse (0,-0.75,tartaruga.x,tartaruga.y)
    numToques=numToques+1
    toquesText.text = numToques
end

local function zerou ()
    numToques=0
    toquesText.text = numToques
end

plataforma:addEventListener ("collision",zerou)
tartaruga:addEventListener ("tap",cima)

local bgAudio = audio.loadStream("Audio/instrumental.mp3")
audio.reserveChannels (1)
audio.setVolume (0.6, {channel=1})
audio.play (bgAudio, {channel=1, loops=-1})

local audioTiro = audio.loadSound ("Audio/fire.wav")
local parametros = {time=2000, fadein = 200}
local botaoTiro = display.newCircle (10,100,20)
botaoTiro.x = 150
botaoTiro.y = 500
botaoTiro:setFillColor (10,50,60)
local function tocarTiro ()
    audio.play (audioTiro,parametros)
end
botaoTiro:addEventListener ("tap",tocarTiro)


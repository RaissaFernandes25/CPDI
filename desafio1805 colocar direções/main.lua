local bg = display.newImageRect ("imagens/sky.png",960*3, 240*3)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local chao = display.newImageRect ("imagens/ground.png", 1028, 256)
chao.x = display.contentCenterX
chao.y = 490

local player = display.newImageRect ("imagens/player.png", 532/5, 469/5)
player.x = 50
player.y = 300

--Andar para a direita
local function direita()
     player.x = player.x + 10
end

local botaoDireita = display.newImageRect ("imagens/button.png",1280/20, 1279/20)
botaoDireita.x = 300
botaoDireita.y = 430
botaoDireita:addEventListener ("tap", direita)

local function esquerda ()  --Andar para a esquerda
    player.x = player.x - 10
 end

local botaoEsquerda = display.newImageRect ("imagens/button.png",1280/20, 1279/20)
botaoEsquerda.x = 220
botaoEsquerda.y = 430
botaoEsquerda.rotation = 180
botaoEsquerda:addEventListener ("tap", esquerda)

local function cima ()  --Andar para a cima
    player.y = player.y - 10
 end 

local botaocima = display.newImageRect ("imagens/button.png", 1280/20, 1279/20)
botaocima.x = 250
botaocima.y = 396
botaocima.rotation = 270
botaocima:addEventListener ("tap", cima)

--Andar para a baixo
local function baixo ()  
    player.y = player.y + 10
 end

local botaoBaixo = display.newImageRect ("imagens/button.png",1280/20, 1279/20)
botaoBaixo.x = 260
botaoBaixo.y = 450
botaoBaixo.rotation = 90
botaoBaixo:addEventListener ("tap", baixo)

local function diagonalDiCm  ()  
    player.x = player.x + 5
    player.y = player.y - 5
end

local botaoDiagonalCm = display.newImageRect ("imagens/button.png",1280/20, 1279/20)
botaoDiagonalCm.x = 320
botaoDiagonalCm.y = 330
botaoDiagonalCm.rotation = 315
botaoDiagonalCm:addEventListener ("tap", diagonalDiCm)

local function diagonalDiBx  ()  
    player.y = player.y + 5
    player.x = player.x + 5
end

local botaoDiagonalBx = display.newImageRect ("imagens/button.png",1280/20, 1279/20)
botaoDiagonalBx.x = 320
botaoDiagonalBx.y = 475
botaoDiagonalBx.rotation = 45
botaoDiagonalBx:addEventListener ("tap", diagonalDiBx)

local function diagonal1  ()  
    player.y = player.y - 2
    player.x = player.x - 2
end

local botaoCimaEsquerda = display.newImageRect ("imagens/button.png",1280/20, 1279/20)
botaoCimaEsquerda.x = 180
botaoCimaEsquerda.y = 330
botaoCimaEsquerda.rotation = 225
botaoCimaEsquerda:addEventListener ("tap", diagonal1)

local function diagonalInfEsq  ()  
    player.y = player.y + 2
    player.x = player.x - 2
end

local botaoDiagBe = display.newImageRect ("imagens/button.png",1280/20, 1279/20)
botaoDiagBe.x = 200
botaoDiagBe.y = 470
botaoDiagBe.rotation = 140
botaoDiagBe:addEventListener ("tap", diagonalInfEsq)
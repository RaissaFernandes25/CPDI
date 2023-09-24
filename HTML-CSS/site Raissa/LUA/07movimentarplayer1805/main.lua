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

local botaoDireita = display.newImageRect ("imagens/button.png",1280/25, 1279/25)
botaoDireita.x = 300
botaoDireita.y = 420
botaoDireita:addEventListener ("tap", direita)

--Andar para a esquerda
local function esquerda ()
    player.x = player.x - 10
 end
 
local botaoEsqueda = display.newImageRect ("imagens/button.png",1280/25, 1279/25)
botaoEsqueda.x = 200
botaoEsqueda.y = 420
botaoEsqueda.rotation = 180
botaoEsqueda:addEventListener ("tap", esquerda)

--Andar para a cima
local function cima ()
    player.y = player.y - 10
 end 

local botaocima = display.newImageRect ("imagens/button.png", 1280/25, 1279/25)
botaocima.x = 250
botaocima.y = 396
botaocima:addEventListener ("tap", cima)
botaocima.rotation = 270

--Andar para a baixo
local function baixo ()
    player.y = player.x + 10
 end

local botaoBaixo = display.newImageRect ("imagens/button.png",1280/25, 1279/25)
botaoBaixo.x = 250
botaoBaixo.y = 454
botaoBaixo.rotation = 90
botaoBaixo:addEventListener ("tap", botaoBaixo)


local cano1 = display.newImageRect ("imagens/cano1.png", 379/5, 658/5)
cano1.x = 20
cano1.y = 315

local Block = display.newImageRect ("imagens/Block.png", 499/4, 167/4)
Block.x = 275
Block.y = 250

local bomba2 = display.newImageRect ("imagens/bomba2.png", 474/4, 472/4)
bomba2.x = 275
bomba2.y = 160

local bomba3 = display.newImageRect ("imagens/bomba3.png", 441/7, 566/7)
bomba3.x = 130
bomba3.y = 200

local bomba4 = display.newImageRect ("imagens/bomba4.png", 585/8, 427/8)
bomba4.x = 76
bomba4.y = 344

local super2 = display.newImageRect ("imagens/super2.png", 912/3, 273/3)
super2.x = 150
super2.y = 60
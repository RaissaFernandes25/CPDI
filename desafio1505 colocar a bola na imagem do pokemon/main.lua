-- Adicionar nova imagem na tela:
-- Comandos: display.newImageRect ("pasta/arquivo.formato", largura, altura)
local bg = display.newImageRect ("imagens/bg.jpg", 1280*1.25, 720*1.25)
-- Definir localização do objeto.
-- Comando: variável.linha que vou definir = localização na linha.
bg.x = display.contentCenterX -- Comando que centraliza a variável em qualquer resolução.
bg.y = display.contentCenterY

local pikachu = display.newImageRect ("imagens/pikachu.png", 1191/15, 1254/15)
pikachu.x = display.contentCenterX
pikachu.y = display.contentCenterY

local charmander = display.newImageRect ("imagens/charmander.png", 507/10, 492/10)
charmander.x = 110
charmander.y = 200

--------------------------------------------------------------------------

-- Criando um retângulo:
-- Comandos: display.newRect (localização x, localização y, largura, altura)
local retangulo = display.newRect (750, 380, 100, 70)

local mystery = display.newImageRect ("imagens/mystery.png", 493/10, 506/10)
mystery.x = 290
mystery.y = 170

-- Criando um círculo:
-- Comandos: display.newCircle (localização x, localização y, radius (raio(metade do círculo))
local circulo = display.newCircle (100, 80, 30)

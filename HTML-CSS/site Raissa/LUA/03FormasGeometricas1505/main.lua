local retangulo = display.newRect (120, 80, 200, 140)

local circulo = display.newCircle (340, 80, 80)

local quadrado = display.newRect (530, 80, 140, 140)

-- Adicionar retângulo arredondado:
-- Comandos: display.newRoundedRect (x, y, largura, altura, raio das bordas)
local retanguloArredondado = display.newRoundedRect (750, 80, 200, 140, 30)

-- Adicionar uma linha:
-- Comandos: display.newLine (xInicial, yInicial), xFinal, yFinal)
local linha = display.newLine (0, 250, 1200, 250)

-- Criar um polígono: 
-- Comandos: display.newPolygon (x, y, vertices)

local localizacaoX = 200
local localizacaoY = 350

local vertices = {0, -110, 27, -35, 105, -35, 43, 16, 65, 90, 0, 45, -65, 90, -43, 15, -105, -35, -27, -35}

local estrela = display.newPolygon (localizacaoX, localizacaoY, vertices)

-- Criar um novo texto:
-- Comandos: display.newText ("Texto que quero inserir", x, y, fonte, fontsize)
local helloWorld = display.newText ("Hello World!", 500, 370, native.systemFont, 50)

local parametros = {
    text = "Olá Mundo!",
    x = 500,
    y = 450,
    font = "Arial",
    fontSize = 50,
    align = "right"
}
local olaMundo = display.newText (parametros)

-- Adicionar texto em relevo:
-- Comandos: display.newEmbossedText ()

local opcoes = {
    text = "Ellen",
    x = 730,
    y = 450,
    font = "Arial",
    fontSize = 50,
}

local textoRelevo = display.newEmbossedText (opcoes)

-- Adicionar cor ao objeto/texto:
-- Comandos: variavel:setFillColor (cinza, vermelho, verde, azul, alfa)

helloWorld:setFillColor (0.9, 0.4, 0.5)
helloWorld.alpha = 0.5

textoRelevo:setFillColor (0.9, 0.4, 0.5)

local color = {
    -- destaque
    highlight = {r = 0, g = 1, b = 0},
    -- sombra
    shadow = {r = 0, g = 0, b = 0}
}

textoRelevo:setEmbossColor (color)

-- Gradiente:
-- Comandos: variável = { type = , color1 = { , , }, color2 = { , , }, direction =  " "}

-- Colorindo a estrela:
local gradiente = {
    type = "gradient",
    color1 = { 1, 0.1, 0.9},
    color2 = {0.5, 0.8, 0.8},
    direction = "down"
}

estrela:setFillColor (gradiente)

-- Colorindo o retângulo:
local gradiente = {
    type = "gradient",
    color1 = { 1.2, 0.1, 0.4},
    color2 = {0.3, 0.2, 0.6},
    direction = "down"
}

retangulo:setFillColor (gradiente)

-- Colorindo o círculo:
local gradiente = {
    type = "gradient",
    color1 = { 0.1, 1, 0.5},
    color2 = {0.9, 0.1, 0.3},
    direction = "down"
}

circulo:setFillColor (gradiente)

-- Colorindo o quadrado:
local gradiente = {
    type = "gradient",
    color1 = { 0, 0.3, 0.1},
    color2 = {0.1, 0.2, 0.6},
    direction = "down"
}

quadrado:setFillColor (gradiente)

-- Colorindo o retângulo arredondado:
local gradiente = {
    type = "gradient",
    color1 = { 0.9, 0.7, 0.5},
    color2 = {0.1, 0.4, 0.5},
    direction = "down"
}

retanguloArredondado:setFillColor (gradiente)

-- Colorindo o Olá Mundo!:
olaMundo:setFillColor (0.4, 0.2, 0.1)
olaMundo.alpha = 0.7
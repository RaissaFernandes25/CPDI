local retangulo = display.newRect (20, 40, 200,140)

local circulo = display.newCircle (400, 40, 60)

local quadrado = display.newRect (200, 80, 140, 140)

-- Adicionar um retangulo arredondado:
-- Comandos: display.newRoundedRect (x, y, largura, alturua, raio das bordas)

local localizacaoX = 100
local localizacaoY = 200

local vertices = { 0, -110, 27, -35, 105, -35, 43, 16, 65, 90, 0, 45, -65, 90, -43, 15, -105, -35, -27, -35 }

local estrela = display.newPolygon (localizacaoX, localizacaoY, vertices)

-- Criar um novo texto:
-- Comandos: display.newText ("Texto que quero inserir, x, y, fonte, fontsize")

local helloWorld = display.newText ( "-- Hello Words", 500, 350, native.systemFont, 50 )

local parametros = {
    text     = "Olá Mundo!",
    x        = 400,
    y        = 250,
    font     = "Arial",
    fontSize = 50,
    align    = "right"
}

local olaMundo = display.newText (parametros)

-- Adicionar texto em relevo:
-- Comandos: display.newEmbossedText ()

local opcoes = {
    text     = "Raissa",
    x        = 400,
    y        = 200, 
    font     = "Arial",
    fontSize = 50,
}

local textoRelevo = display.newEmbossedText (opcoes)

-- Adicionar cor ao objeto/texto:
-- Comandos: variavel setFillColor ( cinza, vermelho, verde, azul, alfa )

helloWorld:setFillColor (0.9, 0.4, 0.5)
helloWorld.alpha = 0.5

local color = {
    -- destaque
    highlight = { 
        r =0, 
        g =1, 
        b =0 
    },
    -- sombra
    shadow = {
        r =0,
        g =0,
        b =0 
    },
}

textoRelevo:setEmbossColor    (color)
-- textoRelevo:setFillColor   (color) 


-- Gradiente:
-- Comandos: variavel = { type =, color1 = { , , }, color2 = { , , }, direction = "" }

local gradiente = {
    type = "gradient", 
    color1 = { 
        1, 
        0.1, 
        0.9 
    }, 
    color2 = { 
        0.8, 
        0.8, 
        0.8 
    },
    direction = "down"
}
estrela: setFillColor(gradiente)

local gradienteFormas = {
    color1 = { 
        0.1, 
        0.4, 
        0.4 
    }, 
    color2 = { 
        1, 
        1, 
        2 
    },
    direction = "circle"
}
retangulo           : setFillColor(gradienteFormas)
circulo             : setFillColor(gradienteFormas)
quadrado            : setFillColor(gradienteFormas)
olaMundo            : setFillColor(gradiente)
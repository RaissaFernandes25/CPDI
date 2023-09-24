-- Fisica
-- Chamar a biblioteca:atribui a biblioteca interna de fosoca a varoavel physics.
local physics= require ("physics")
-- Iniciar a fisica no projeto:
physics.start ()
-- Definir a gravidade do projeto: Definimos a gravidade x e y do projeto.
physics.setGravity (0,9.8)
-- Definir a renderização da visualizacao da fisica (usado somente durante o desenvolvimento para testes)
-- modos: normal: aparece apenas as imagens, corpos fisicos
physics.setDrawMode ("hybrid")

-- Adicionando objetos fisicos:
local retangulo = display.newRect (150,display.contentCenterY, 300, 240)
-- corpo dinamico: interage com a gravidade e colide com todos os corpos.
physics.addBody (retangulo,"dynamic")

local chao = display.newRect (display.contentCenterX,400,450,30)
-- corpo estatico: não se movimenta e colide com dinâmico.
physics.addBody (chao,"static")

local circulo = display.newCircle (300,50,30)
-- corpo cinemático não interage com a gravidade e colide apenas com dinamico.
physics.addBody (circulo,"kinematic", {radius=30})

local quadrado = display.newRect (display.contentCenterX, 0,50,50)
physics.addBody (quadrado,"dynamic", {bounce=1, friction=1,density=1})
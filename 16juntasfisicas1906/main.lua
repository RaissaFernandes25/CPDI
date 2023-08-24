local physics = require ("physics") -->Chamar a bliblioteca: a bliblioteca interna de fisica á variavel physic
physics.start () --> iniciar a fisica no projeto 
physics.setGravity (0,9.8) --> Definir a renderização (gravidade) da visualização da fisica (usando somente durante o desenvolvimento para testes ) gravidade 0 é sem gravidade 
physics.setDrawMode ("hybrid") --> definir o modo de renderização (hybrid, normal, debug) durante a fase de programação do projeto colocar Hybrid mostra os dois, normal mostra as imagens, debug mostra somente  o comprotamento do corpo fisico

display.setStatusBar (display.HiddenStatusBar) --> removendo a barra de notificaçao

local joint

local staticBox = display.newRect (0, 0, 60, 60)
staticBox:setFillColor (0.2, 0.2, 1)
physics.addBody (staticBox, "static", {isSensor = true}) --> habilitanto o motor da fisica 
staticBox.x, staticBox.y = display.newCenterX, 80

local shape = display.newRect( 0, 0, 40, 100)
shape:setFillColor (1, 0.2, 0.4)
physics.addBody (shape, "dynamic")
shape.x, shape.y, shape.rotation = 100, staticBox.y-40, 0

-- Criação da junta de pivô ("tipo de junta", objA, objB, ancoraX, ancoraY)
local jointPivot = physics.newJoint ("pivot", staticBox, shape, staticBox.x, staticBox.y) --> Criação da junta de pivô ("tipo de junta", objA, objB)
jointPivot.isMotorEnabled = true --> Ativa a junta do pivô
jointPivot.motorSpeed = 40 --> define a velocidade do torque do motor
jointPivot.maxMotorTorque = 1000 --> define o valor maximo da velocidade do torque do motor, utilizando para melhorar visialização do efeito ( chipando o torque)
jointPivot.isLimitEnabled = true --> Determina como ativado o limite de rotação 
jointPivot:setRotationLimits (-60, 125)
---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Junta de distancia
-- local staticBox = display.newRect (0, 0, 60, 60 ) 
-- staticBox:setFillColor (0.2, 0.2, 1)
-- physics.addBody (staticBox, "static", {isSensor = true}) --> habilitanto o motor da fisica 
-- staticBox.x, staticBox.y = 200, 180

-- local shape = display.newRect( 0, 0, 40, 100)
-- shape:setFillColor (1, 0.2, 0.4)
-- physics.addBody (shape, "dynamic", {bounce=1})
-- shape.x, shape.y = 200, 80

-- -- ("tipo de junta", objt A e obj B,ancoraObjA.x, ancoraObjA.y)
-- local jointDistance = physics.newJoint("distance", staticBox, shape, staticBox.x, staticBox.y-10, shape.x, shape.y)
-- jointDistance.frequency = 0.8 --> Define a frequencia de amortecimento, quanto menor o valor mais macio sera o retorno ( valor em HERTZ)
-- jointDistance.dampingRatio = 0.8 --> Nivel de amortecimento , onde 1 é amortecimento + critico 
-- jointDistance.length = staticBox.y - shape.y --> Define a distancia entre os pontos de ancoragem  

-- shape:applyLinearImpulse(0.3, 0, shape.x, shape.y-5)


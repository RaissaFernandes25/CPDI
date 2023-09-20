local physics = require ("physics") -->Chamar a bliblioteca: a bliblioteca interna de fisica á variavel physic
physics.start () --> iniciar a fisica no projeto 
physics.setGravity (0,9.8) --> Definir a renderização (gravidade) da visualização da fisica (usando somente durante o desenvolvimento para testes ) gravidade 0 é sem gravidade 
physics.setScale( 10 )
physics.setDrawMode ("normal") --> definir o modo de renderização (hybrid, normal, debug) durante a fase de programação do projeto colocar Hybrid mostra os dois, normal mostra as imagens, debug mostra somente  o comprotamento do corpo fisico

display.setStatusBar (display.HiddenStatusBar) --> removendo a barra de notificaçao

 local joints = {}

 -- local staticBox = display.newRect (0, 0, 60, 60)
 -- staticBox:setFillColor (0.2, 0.2, 1)
 -- physics.addBody (staticBox, "static", {isSensor = true}) --> habilitanto o motor da fisica 
 -- staticBox.x, staticBox.y = display.newCenterX, 80

 -- local shape = display.newRect( 0, 0, 40, 100)
 -- shape:setFillColor (1, 0.2, 0.4)
 -- physics.addBody (shape, "dynamic")
 -- shape.x, shape.y, shape.rotation = 100, staticBox.y-40, 0

  -- Criação da junta de pivô ("tipo de junta", objA, objB, ancoraX, ancoraY)
-- local jointPivot = physics.newJoint ("pivot", staticBox, shape, staticBox.x, staticBox.y) --> Criação da junta de pivô ("tipo de junta", objA, objB)
 -- jointPivot.isMotorEnabled = true --> Ativa a junta do pivô
 -- jointPivot.motorSpeed = 40 --> define a velocidade do torque do motor
 -- jointPivot.maxMotorTorque = 1000 --> define o valor maximo da velocidade do torque do motor, utilizando para melhorar visialização do efeito ( chipando o torque)
 -- jointPivot.isLimitEnabled = true --> Determina como ativado o limite de rotação 
 -- jointPivot:setRotationLimits (-60, 125)
-- -- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- -- Junta de distancia
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
-- --Junta do pistao 

--   local staticBox = display.newRect (0, 0, 60, 60 ) 
--   staticBox:setFillColor (0.2, 0.2, 1)
--   physics.addBody (staticBox, "static", {isSensor=true}) --> habilitanto o motor da fisica 
--   staticBox.x, staticBox.y = display.contentCenterX, 360
    
--   local shape = display.newRect ( 0, 0, 140 ,30)
--   shape:setFillColor (01, 0.2, 0.4)
--   physics.addBody (shape, "dynamic", {bouce=1})
--   shape.x, shape.y = display.contentCenterX, 310
  
--   -- criação da junta do pistao ("tipo de junta", obj A obj B, ancoraX, ancoraY, limite de movimentaçãoX, limite de movimento)
--     local jointPiston = physics.newJoint ("piston", staticBox, shape, shape.x, shape.y, 0, 1)
    
--     jointPiston.isMotorEnabled = true --> habilita o motor da junta 
--     jointPiston.motorSpeed = -30 --> faz subir o elevador  ( define a velocidade do motor)
--     jointPiston.maxMotorForce = 1000 --> da forca para o motor ( define o valor maximo de força)

--     jointPiston.isLimitEnabled = true --> define a junta possui limite de movimentação
--     jointPiston:setLimits (-140, 0) -- Define os limites de movimentação positiva e negativa.
-- --------------------
-- Junta de fricção
local bodies = {} --> string/ tabela para armazenamento
local bodiesGroup = display.newGroup () --> 
local joint = {} -- Tabela para armazemaneto de corpos 

bodiesGroup.alpha = 0
transition.to (bodiesGroup, {time=600, alpha=1, transition = easing.outQuad}) --> Tramsição do grupo para o alfa 1 e 600 milisegundos com efeito outQuad
local shape1 = display.newRect (bodiesGroup,0,0,40,40)
shape1: setFillColor (1,0.2,0.4)
physics.addBody (shape1, "dynamic")
shape1.x, shape1.y, shape1.rotation = display.contentCenterX-60, 170, 0
shape1.angularVelocity = 200 --> Adiciona um impulso angular ao shape ( rotação ao redor do proprio eixo)
bodies [#bodies+1] = shape1 --> colocando na tabela de corpos para nao soobre escrever ( add um shape na tabela )

local shape2 = display.newRect (bodiesGroup, 0 ,0 , 40, 40)
shape2:setFillColor (1 ,0.2, 0.4)
physics.addBody (shape2, "dynamic")
shape2.x, shape2.y, shape2.rotation = display.contentCenterX+60, 170, 0
shape2.angularVelocity = 200 --> adiciona um impulso angular ao shape
bodies [#bodies+1] = shape2

local dirtField = display.newRect (bodiesGroup, 0, 0, 120, 190)
dirtField.type = "dirt"
dirtField:setFillColor (0.4, 0.25, 0.2)
physics.addBody (dirtField, "static", {isSensor=true})
dirtField.x, dirtField.y = display.contentCenterX-60, 335
bodies [#bodies+1]=dirtField

local grassField = display.newRect (bodiesGroup, 0 , 0 , 120, 190)
grassField.type = "grass"
grassField:setFillColor ( 0.1, 0.4, 0.3)
physics.addBody (grassField, "static", {isSensor=true})
grassField.x, grassField.y = display.contentCenterX+60, 335
bodies [#bodies+1] = grassField
bodiesGroup.alpha=0 -- Define que todos os elementos do grupo possuem alfa 0

transition.to (bodiesGroup,{time=600,alpha=1, transition=easing.outQuad}) -- Transição do grupo para o alfa 1 em 600 milisegundos com efeito outQuad. 

local function handleCollision (self, event) --> 
    if (event.phase == "began") then
-- Criando duas variavel para armazenar limite de força e torque
            local forceLimit = 0
            local torqueLimit = 0
-- Se o tipo do outro objeto colidir for.. entao 
            if (event.other.type == "dirt") then
                -- Altera os valores limites de força e torque
                forceLimit = 0.22
                torqueLimit = 0.022
                --se nao 
            else 
               -- Altera para outros valores
                forceLimit = 0.28
                torqueLimit = 0.028
            end 
    -- Cria um timer com função temporaria para criação das juntas 10 milisegundos apos a colisao
            timer.performWithDelay (10, --criando um timer para so depois desse tempo para criar uma junta para nao ter erro 
                function ()
    -- Cria-se a junta já dentro da string, joints, aonde o obje Aé colidido e o B o ouvinte da função, e as ancoras sao criadas de acordo com a localização do Objeto B
               joints[#joints+1]= physics.newJoint     ("friction", event.other, self, self.x, self.y) 
                  -- altera o valor maximo de força e torque de acordo com o objeto da if acima
               joints[#joints].maxForce = forceLimit
               joints[#joints].maxTorque = torqueLimit
               end -- Fecha a function do timer
               )  -- fecha o timer
    end-- fecha o if Began
end-- fecha a função
       
shape1.collision = handleCollision
shape1:addEventListener ("collision", shape1)
       
shape2.collision = handleCollision
shape2:addEventListener ("collision", shape2)
--------------------------------------------------------------------------------------------------------------------------   
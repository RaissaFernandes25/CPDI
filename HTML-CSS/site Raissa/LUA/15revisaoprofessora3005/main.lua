-- Chamar a biblioteca de física
local physics= require ("physics")
-- Iniciar o motor de física
physics.start()
--Definir a gravidade.
physics.setGravity(0,0)
--Definir o modo de renderização
physics.setDrawMode ("hybrid") -- normal,hybrid,debug

-- Remover a barra de notificações.
display.setStatusBar (display.HiddenStatusBar)

-- criar os grupos de exibição.
local grupoBg= display.newGroup() -- Objetos decorativos,cenário (não tem interação)
local grupoMain= display.newGroup() -- Bloco principal (tudo que precisa interagir com o player fica nesse grupo)
local grupoUI= display.newGroup() -- Interface do usuário (placares,)

-- Criar variáveis de pontos e vidas para atribuição de valor.
local pontos=0
local vidas=5

-- Adicionar background
--                          (grupo, "pasta/nome do arquivo.formato",largura,altura )
local bg=display.newImageRect(grupoBg,"imagens/bg.jpg",728*1.2,410*1.2)

bg.x=display.contentCenterX -- localização horizontal
bg.y=display.contentCenterY -- localização vertical

-- Adicionar placar na tela.
-- (grupo de exibição,"Escreve o que irá aparecer na tela", localizaçãoX, localizaçãoY,fonte, tamanho da fonte)
local pontosText = display.newText (grupoUI,"Pontos: "..pontos,100,30,native.systemFont,20)
-- Altera a cor da variavel 
pontosText:setFillColor (0/255,0/255,0/255)

local vidasText=display.newText(grupoUI,"Vidas:"..vidas,200,30,native.systemFont,20)
vidasText:setFillColor (0,0,0)

--Adicionar herói
local player= display.newImageRect (grupoMain,"imagens/harry.png",324*0.3,234*0.3)
player.x =30
player.y = 370
player.myName="harry"
-- Adicionar o corpo físico da imagem.
physics.addBody(player,"kinematic") -- colide apenas com dinâmico e não tem interferência da gravidade.

-- Criar botões:
local botaoCima = display.newImageRect (grupoMain,"imagens/button.png",1280/22, 1279/22)
botaoCima.x=100
botaoCima.y=510
botaoCima.rotation= -90 -- faz a rotação da imagem em x graus.

local botaoBaixo = display.newImageRect (grupoMain,"imagens/button.png",1280/22, 1279/22)
botaoBaixo.x=100
botaoBaixo.y=560
botaoBaixo.rotation= 90

-- Adicionar funções de movimentação
local function cima ()
    player.y = player.y - 10
end

local function baixo ()
    player.y= player.y + 10
end

-- Adicionar o ouvinte e a função ao botão.
botaoCima:addEventListener ("tap",cima)
botaoBaixo:addEventListener ("tap",baixo)

-- Adicionar botão de tiro:
local botaotiro= display.newImageRect (grupoMain,"imagens/tiro.png",360/5,360/5)
botaotiro.x= display.contentCenterX 
botaotiro.y= 440

-- Função para atirar:
local function atirar ()
    -- Toda vez que a função for executada cria-se um novo "tiro"
    local feiticoplayer= display.newImageRect (grupoMain,"imagens/laserAzul.png",583*0.1,428*0.1)
    -- a localização é a mesma do player 
    feiticoPlayer.x= player.x 
    feiticoPlayer.y= player.y 
    physics.addBody (feiticoPlayer,"dynamic", {isSensor=true}) -- determinamos que o projétil é um sensor, o que ativa a detecção contínua de colisão.
    -- Transição do projétil para linha x=400 em 900 milisegundos.
    transition.to (feiticoPlayer, {y=100, time=900,
    -- Quando a transição for completa        
            onComplete = function ()
    -- Removemos o projétil do display.
                display.remove (feiticoplayer)
                 end})
    feiticoplayer.myName = "Stupefy"
    feiticoplayer: toBack () -- Joga o elemento pra trás
end

botaotiro: addEventListener ("tap",atirar)

-- Adicionando inimigo
local inimigo = display.newImageRect (grupoMain,"imagens/voldemort.png",500*0.3,500*0.3)
inimigo.x=270
inimigo.y=370
inimigo.myName = "voldemort"
physics.addBody (inimigo,"kinematic")
local direcaoinimigo = "cima"

-- Função para inimigo atirar:
local function inimigoAtirar ()
    local tiroInimigo = display.newImageRect (grupoMain,"imagens/laserVerde.png", 500*0.3,500*0.3)
    tiroInimigo.x = inimigo.x -50
    tiroInimigo.y = inimigo.y
        tiroInimigo.rotation=180
    physics.addBody (tiroInimigo,"dynamic", {isSensor=true})
    transition.to (tiroInimigo,{x=-200, time=900,
                onComplete= function () display.remove (tiroInimigo)
                    end})
    tiroInimigo.myName= "AvadaKedavra"
    tiroPlayer: toBack()
end

-- Criando o timer de disparo do inimigo:
-- Comandos timer: (tempo repetição, função,quantidade de repetições )
inimigo.timer = timer.performWithDelay (math.random (1000,1500),
inimigoAtirar,0)
-- Movimentação do inimigo:
local function movimentarInimigo ()
-- se a localização y não for igual a nulo então
    if not ( inimigo.y == nil ) then
-- Quando a direção do inimigo for cima então  
        if (direcaoInimigo == "cima") then
            inimigo.x = inimigo.x - 1
-- Se a localização x do inimigo for menor ou igual a 50 então 
            if (inimigo.x <=50 ) then
            -- altera a variável para "baixo"
                direcaoInimigo = "baixo"
            end -- if (inimigo.y.....)
-- se a direção do inimigo for igual a baixo então
        elseif (direcaoInimigo == "baixo") then
            inimigo.x = inimigo.x + 1
-- se a localização x do inimigo for maior ou igual a 400 então 
            if (inimigo.x >= 400) then
                direcaoInimigo = "cima"
            end -- if (inimigo.y...)
        end -- if (direcaoInimigo....)
-- Se não
    else
        print ("Inimigo morreu!")
-- Runtime: representa todo o jogo (evento é executado para todos),enterframe: está ligado ao valor de FPS do jogo (frames por segundo), no caso, a função vai ser executada 60 vezes por segundo.
        Runtime: removeEventListener ("enterFrame", movimentarInimigo)
    end
end

Runtime: addEventListener ("enterFrame", movimentarInimigo)

-- Função de colisão:
local function onCollision (event)
-- Quando a fase de evento for began então
    if (event.phase == "began") then
-- Variáveis criadas para facilitar a escrita do código.
            local obj1 = event.object1
            local obj2 = event.object2
-- Quando o myName do objeto 1 for ... e o nome do obj2 for ... 
            if ((obj1.myName == "Stuperfy" and obj2.myName == "Voldemort") or (obj1.myName == "Voldemort" and obj2.myName == "Stuperfy")) then
            -- Se o obj1 for ... then
            if (obj1.myName == "Stuperfy") then
            -- Remove o projétil do jogo.
                display.remove (obj1)
            else
                display.remove (obj2)
            end
-- Somar 10 pontos a cada colisão
            pontos = pontos + 10
-- Atualizo os pontos na tela.
pontosText.text = "Pontos:".. pontos
-- Se obj1 for Player e o 2 projétil do inimigo ou vice versa então
        elseif ((obj1.myName == "Harry" and obj2.myName == "AvadaKedavra") or (obj1.myName == "AvadaKedavra" and obj2.myName == "Harry" )) then
        if (obj1.myName == "AvadaKedavra") then
            display.remove (obj1)
        else
            display.remove (obj2)
        end
-- Reduz uma vida do player a cada colisão 
            vidas = vidas -1
            vidasText.text = "Vidas:" .. vidas
            end -- fecha o if myName
    end -- fecha o if event.phase
end -- fecha a function

Runtime: addEventListener ("collision", onCollision)

---------------------------------------------------------------------------------------
-- ----andar para a direita
-- local function direita()
--     player.x = player.x + 10
-- end

-- local botaoDireita = display.newImageRect ("imagens/button.png",1280/25, 1279/25)
-- botaoDireita.x = 140
-- botaoDireita.y = 525

-- --Andar para a esquerda
-- local function esquerda ()
--    player.x = player.x - 10
-- end

-- local botaoEsquerda = display.newImageRect ("imagens/button.png",1280/25, 1279/25)
-- botaoEsquerda.x = 60
-- botaoEsquerda.y = 525
-- botaoEsquerda.rotation = 180







-- botaoEsquerda:addEventListener ("tap", esquerda)
-- botaoDireita:addEventListener ("tap", direita)








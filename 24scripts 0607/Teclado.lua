local Teclado = {} -- Armazena todos os dados do script

function Teclado.novo (player)

    local function verificarTecla (event)
        -- se a fase de evento for down (tecla pressionada) entao 
        if event.phase == "down" then
            -- se a tecla pressionada for o d entao
            if event.keyName == "d" then
                player.direcao = "direita"
                player:setSequence ("correndo")
                player:play()
                player.xScale = 1       
            elseif event.keyName == "a" then
                player.direcao = "esquerda"
                player:setSequence ("correndo")
                player:play()
                player.xScale = -1
            elseif event.keyName == "space" then
                player.numeroPulo = player.numeroPulo + 1
                -- se numeroPulo for igual a 1 entao    
                if player.numeroPulo == 1 then
                    -- eh aplicado impulso linear no player (y)    
                    player:applyLinearImpulse (0, -0.4, player.x, player.y)
                -- se o numeroPulo for igual a 2 entao    
                elseif player.numeroPulo == 2 then
                    -- transicao para o player gire 360 graus em torno do proprio eixo.    
                    transition.to (player, {rotation=player.rotation+360, time=750})
                        player:applyLinearImpulse (0, -0.4, player.x, player.y)
                    end
            end
        -- quando a fase    
        elseif event.phase == "up" then
            if event.keyName == "d" then
                player.direcao = "parado"
                player:setSequence("parado")
                player:play()
            elseif event.keyName == "a" then
                player.direcao = "parado"
                player:setSequence("parado")
                player:play()
            end
        end 
    end
    --"key": teclado
    Runtime:addEventListener ("key", verificarTecla)
    
    -- funcao para movimentacao
    local function verificarDirecao ()
        -- Retorna os valores da velocidade linear X e Y e armazena nas variaveis velocidadeX, velocidadeY respectivamente.
        local velocidadeX, velocidadeY = player:getLinearVelocity()
        -- print ("velocidade x:".. velocidadeX..",velocidade Y:".. velocidadeY)
        -- se a direcao do player for direita e a velocidade x for menor ou igual a 200 then
        print ("Velocidade x".. velocidadeX.. ",velocidade Y:" .. velocidadeY)
        -- aplicacao impulso linear para movimentacao x direita.
        if player.direcao == "direita" and velocidadeX <= 200 then
            player:applyLinearImpulse (0.2, 0, player.x, player.y)
        elseif player.direcao == "esquerda" and velocidadeX >= -200 then
            player:applyLinearImpulse (-0.2, 0, player.x, player.y)
        end 
    end 
    -- "enterFrame" - executa a funcao o numero de fps/s (nesse caso 60x por segundo)
    Runtime:addEventListener ("enterFrame", verificarDirecao)
end

return Teclado -- "fechar string teclado"
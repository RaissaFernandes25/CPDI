
local composer = require( "composer" )
local Placar = {}

function Placar.novo ()
    local grupoPlacar = display.newGroup()

    local pontos = 0
    local vidas = 5

    local fundo = display.newImageRect (grupoPlacar,"cenas/coletavelvidas.png", 1032/4, 100/4)
    fundo.x = 112
    fundo.y = 15

    local pontosText = display.newText (grupoPlacar, " " .. pontos, 100, 15, native.systemFont, 20)
    pontosText:setFillColor (1, 1, 1)

    local vidasText  = display.newText (grupoPlacar, " " .. vidas, 200, 15, native.systemFont, 20)
    vidasText:setFillColor (1, 1, 1)

    grupoPlacar.somarPontos = function ()
        pontos = pontos + 1
        pontosText.text = " " .. pontos
        print (pontos)
    end

    grupoPlacar.somarVidas = function ()
        vidas = vidas -1
        vidasText.text = " " .. vidas

        if (vidas == 0) then
            composer.gotoScene("gameOver", { time = 800, effect = "crossFade" })  
        end
    end

    grupoPlacar.comparar = function ()
        if (pontos >= 10) then
            print ("Finalizou")
            composer.gotoScene("fase1check", { time = 800, effect = "crossFade" })
            alga = audio.loadSound ("audios/algas.mp3")
        else
            
            print ("Falta pontos")
            
        end

    end

    grupoPlacar.comparar2 = function ()
        if (pontos >= 20) then
            print ("Finalizou")
            composer.gotoScene("fase2check", { time = 800, effect = "crossFade" })
            
        else
            print ("Falta pontos")
        end
    end

    return grupoPlacar
end

return Placar
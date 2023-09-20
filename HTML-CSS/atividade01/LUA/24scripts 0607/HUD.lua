local HUD = {}

function HUD.novo()
-- Cria o grupo hud para armazenamento da funcao
    local grupoHUD = display.newGroup ()

    local pontos = 0
    local pontosText = display.newText ("Pontos: " .. pontos, 120, 40, native.systemFont, 30)

-- Cria funcao somar atribuida ao grupo.
    grupoHUD.somar = function()
        pontos = pontos + 1
        pontosText.text = "Pontos: " .. pontos
    end 

    return grupoHUD
end

return HUD
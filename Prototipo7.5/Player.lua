local Player = {}

function Player.novo (x, y, placar)

    local player = display.newImageRect ( "imagens/turtle3.png", 255*0.25, 265*0.25)
    player.x = x
    player.y = y + 100
    player.rotation = 90
    player.myName = "Turtle"
    physics.addBody (player, "dynamic")
    player.isFixedRotation = true

    local function moverPlayer (event)

        local player = event.target
        local phase = event.phase
    
        if ("began" == phase) then
    
            display.currentStage:setFocus (player)
            player.touchOffsetX = event.x - player.x 
            player.touchOffsetY = event.y - player.y 
        elseif ("moved" == phase) then
            player.x = event.x - player.touchOffsetX
            player.y = event.y - player.touchOffsetY
        elseif ("ended" == phase or "cancelled" == phase) then
            display.currentStage:setFocus (nil)
        end
        return true
    end
    
    player:addEventListener ("touch", moverPlayer)

    return player
end
return Player
display.setStatusBar (display.HiddenStatusBar)

-- Inclusão de sprite animação
-- ("pasta/arquivo.formato", {larguraFrame=, alturaFrame=, numeroFrames= })
local sprite1 = graphics.newImageSheet ("imagens/playerFem2.png", {width=192, height=256, numFrames=45})

local sprite1Animacao = {
-- {nome da animação= ,frameinicial= , continuação=, tempo=, loopins= (0 é infinito) }
    {name="parado", start=1, count=1, time=1000, loopCount=0},
    {name="andando", start=37, count=8, time=1000, loopCount=0},
    {name="pulo", start=2, count=3, time=1000, loopCount=0}
}

-- newSprite é utilizado apenas para as sprites de animação.
local player= display.newSprite (sprite1,sprite1Animacao) 
player.x = display.contentCenterX
player.y = display.contentCenterY
-- player.width = player.width*0.5
-- player.height = player.heigth*0.5
player.xScale =0.5
player.yScale =0.5
-- Definir sequencia de animacao inicial
player: setSequence ("parado")
-- Inicia a sequencia de animação.
player: play ()

--------------------------------------------------------------------
-- Sprite de elementos estáticos:

local spriteOpcoes = 
{

	frames= 
	{ 
		{ -- 1) menu
			x= 0,
			y= 0,
			width= 125,
			height= 100
		},
		{ -- 2) botao esquerda
			x= 0,
			y= 100,
			width= 125,
			height= 100
		},
		{-- 3) on/off
			x= 0,
			y= 200,
			width= 125,
			height= 100
		},
		{ -- 4) configurações
			x= 0,
			y= 300,
			width= 125,
			height= 100 
		}, 
		{ -- 5) mensagens
			x= 0, 
			y= 400, 
			width= 125,
			height= 100
		},
		{ -- 6) pause
			x= 125,
			y= 0,
			width= 125,
			height= 100
		},
		{ -- 7) botao direita
			x= 125,
			y= 100,
			width= 125,
			height= 100
		},
		{-- 8) return
			x= 125,
			y= 200,
			width= 125,
			height= 100
		},
		{ -- 9) volume
			x= 125,
			y= 300,
			width= 125,
			height= 100 
		}, 
		{ -- 10) compras
			x= 125, 
			y= 400, 
			width= 125,
			height= 100
			},
		{ -- 11) play
			x= 250,
			y= 0,
			width= 125,
			height= 100
		},
		{ -- 12) cima
			x= 250,
			y= 100,
			width= 125,
			height= 100
		},
		{-- 13) x/não
			x= 250,
			y= 200,
			width= 125,
			height= 100
		},
		{ -- 14) ajuda
			x= 250,
			y= 300,
			width= 125,
			height= 100 
		}, 
		{ -- 15) recordes
			x= 250, 
			y= 400, 
			width= 125,
			height= 100
		},
		{ -- 16) home
			x= 375,
			y= 0,
			width= 125,
			height= 100
		},
		{ -- 17) botao baixo
			x= 375,
			y= 100,
			width= 125,
			height= 100
		},
		{-- 18) yes
			x= 375,
			y= 200,
			width= 125,
			height= 100
		},
		{ -- 19) segurança
			x= 375,
			y= 300,
			width= 125,
			height= 100 
		}, 
		{ -- 20) música
			x= 375, 
			y= 400, 
			width= 125,
			height= 100
			}	
	}
}

local sprite2 = graphics.newImageSheet ("imagens/button.png",spriteOpcoes)

-- (arquivo, frame, larguraFrame, alturaFrame)
local botaoEsquerda = display.newImageRect (sprite2,2,125,100)
botaoEsquerda.x = 50
botaoEsquerda.y = 420

local botaoDireita = display.newImageRect (sprite2,7,125,100)
botaoDireita.x = 250
botaoDireita.y = 420

local function moverEsquerda (event)
    if (event.phase == "began") then
        player.x = player.x -1
        player:setSequence ("andando")
        player:play ()
        player.xScale = -0.5
    elseif (event.phase== "moved") then
        player.x = player.x -1
    elseif (event.phase== "ended") then
        player:setSequence ("andando")
        player:play ()
        player.xScale = -0.5
    end
end

botaoEsquerda: addEventListener ("touch", moverEsquerda)

local function moverDireita (event)
    if (event.phase == "began") then
        player.x = player.x +1
        player:setSequence ("andando")
        player:play()
    elseif (event.phase== "moved") then
        player.x = player.x +1
    elseif (event.phase== "ended") then
        player:setSequence ("andando")
        player:play ()
    end
end

botaoDireita: addEventListener ("touch", moverDireita)
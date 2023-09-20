
local composer = require( "composer" )

local scene = composer.newScene()

fundo = audio.loadStream ("audios/fase3.mp3")
audio.play (fundo, {channel=2, loops=-1})

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- função voltar para menu

local function gotoMenu()
	composer.gotoScene ("menu", {time=800, effect="crossFade"})
end

-- Lista de imagens para as cartas
local cartas = { "card1", "card2", "card3", "card4", "card5", "card6" }
-- Número de colunas e linhas do tabuleiro
local numCols, numLinhas = 3, 4
-- Espaçamento entre as cartas
local distancia = 20
-- Largura e altura de cada carta
local larguraCarta, alturaCarta
--Variáveis para armazenar as cartas viradas
local card1, card2
-- Variável para controlar se as cartas podem ser viradas
local virar = true
-- Variável que representa o tabuleiro de cartas
local tabuleiro
-- Variável que representa o numero de pontos
local pontos = 0
-- Variável que representa o numero de tentativas inicial
local tentativas = 10
-- Texto do placar
local placarText
-- Texto das tentativas
local tentativasText

-- Função para embaralhar uma tabela
local function embaralhar(tabela)
    -- Armazena o tamanho da tabela
    local n = #tabela
    -- Laço para embaralhar os elementos da tabela
    while n > 1 do
        -- Gera um número aleatório entre 1 e n
        local l = math.random(n)
        -- Troca os elementos n e k de posição
        tabela[n], tabela[l] = tabela[l], tabela[n]
        -- Reduz o tamanho da tabela para embaralhar os elementos restantes
        n = n - 1
    end
    -- Retorna a tabela com os elementos embaralhados
    return tabela
end

--Função para criar uma carta com imagem de frente e verso
local function criarCarta(x, y, frenteImagem, atrasImagem)
    -- Cria um novo grupo para as cartas
    local carta = display.newGroup()
    -- Adiciona a imagem do verso da carta
    local back = display.newImageRect(carta, atrasImagem, larguraCarta, alturaCarta)
    -- Armazena o nome da imagem da frente da carta
    carta.frenteImagem = frenteImagem
    -- Variável para controlar se a carta está virada
    carta.virada = false
    -- Define a posição inicial da carta
    carta.x, carta.y = x, y
    -- função para virar a carta
    function carta:virar()
        audio.play (flipcard, {channel=4})
        if not self.virada then
            self.virada = true
            transition.to(self, { time = 200, xScale = 0.1, onComplete = function()
                back.isVisible = false
                display.newImageRect(self, self.frenteImagem, larguraCarta, alturaCarta)
                transition.to(self, { time = 200, xScale = 1 })
                audio.play (flipcard, {channel=4})
            end})
        end
    end
    -- Função para reverter a carta para a posição inicial
    function carta:reset()
        self.virada = false
        back.isVisible = true
        display.remove(self[2])
    end
    -- Adiciona um evento de toque para a carta
    carta:addEventListener("tap", function(event)
        carta:virar()
    end)

    return carta
end

-- Função para calcular o tamanho ideal das cartas
local function tamanhoDaCarta()
    local larguraDisponivel = display.actualContentWidth - (distancia * (numCols + 1))
    local alturaDisponivel = display.actualContentHeight - (distancia * (numLinhas + 1))
    larguraCarta = larguraDisponivel / numCols
    alturaCarta = alturaDisponivel / numLinhas
end

-- Função para calcular o tamanho total do tabuleiro
local function tamanhoTabuleiro()
    tamanhoDaCarta()
    local larguraTabuleiro = larguraCarta * numCols + distancia * (numCols - 1)
    local alturaTabuleiro = alturaCarta * numLinhas + distancia * (numLinhas - 1)
    return larguraTabuleiro, alturaTabuleiro
end

-- Função para criar o tabuleiro
local function criarTab()
    -- Novo grupo para o tabuleiro
    local grupoTab = display.newGroup()
    -- Calcula o tamanho total do tabuleiro
    local larguraTabuleiro, alturaTabuleiro = tamanhoTabuleiro()
    -- Posiciona o tabuleiro a partir do centro
    local startX = (display.actualContentWidth - larguraTabuleiro) / 2 + 25
    local startY = (display.actualContentHeight - alturaTabuleiro) / 2 + 45
    -- Gera posições aleatórias para as cartas no tabuleiro
    local posicoes = {}
    for i = 1, numLinhas do
        for j = 1, numCols do
            table.insert(posicoes, { startX + (larguraCarta + distancia) * (j - 1), startY + (alturaCarta + distancia) * (i - 1) })
        end
    end

    posicoes = embaralhar(posicoes)
    -- Cria as cartas e adiciona elas ao grupo do tabuleiro
    for i = 1, numLinhas * numCols / 2 do
        for j = 1, 2 do
            local indice = (i - 1) * 2 + j
            local carta = criarCarta(posicoes[indice][1], posicoes[indice][2], "imagens/"..cartas[i]..".png", "imagens/back.png")
            grupoTab:insert(carta)
        end
    end

    return grupoTab
end

-- Função para verificar vitória
local function verificarVitoria()
    -- Variavel para verificaçao de cartas restantes
    local cartasRestantes = 0
    -- Verificação dentro da tabela
    for i = 1, tabuleiro.numChildren do
        local carta = tabuleiro[i]
        if not carta.removida then
            cartasRestantes = cartasRestantes + 1
        end
    end
    -- Se os pontos forem igual a  6 entao
    if pontos == 6 then
        timer.performWithDelay(1300, function()
        composer.gotoScene("fase3check", { time = 800, effect = "crossFade" })
        end)
    end
end

-- Função para verificar se duas cartas viradas são iguaais
local function checar()
    -- Cria uma tabela para armazenar as cartas viradas
    local cartasViradas = {}

    -- Coleta as cartas viradas
    for i = 1, tabuleiro.numChildren do
        local carta = tabuleiro[i]
        -- Se a carta estiver virada, adiciona a tabela de cartas viradas
        if carta.virada then
            table.insert(cartasViradas, carta)
        end
    end
    -- Se tiverem duas cartas viradas e a função de virar cartas estiver disponivel
    if #cartasViradas == 2 and virar then
        -- Bloqueia a função de virar cartas temporariamente
        virar = false

        -- Armazena as duas cartas viradas para comparação
        local card1, card2 = cartasViradas[1], cartasViradas[2]

        -- Verifica se as cartas são iguais
        local saoIguais = card1.frenteImagem == card2.frenteImagem

        -- Função para reverter as cartas após um intervalo
        local function reverterCartas()
            card1:reset()
            card2:reset()
            -- Libera a função de virar cartas novamente
            virar = true
        end

        if saoIguais then
            -- Se forem iguais, aumenta os pontos e verifica a vitória
            audio.play (check, {channel=7})
            pontos = pontos + 1
            placarText.text = " " .. pontos
            verificarVitoria()
            -- Remove as cartas após um pequeno atraso
            timer.performWithDelay(1000, function()
                display.remove(card1)
                display.remove(card2)
                -- Libera a função de virar cartas novamente
                virar = true
            end)
        else
            -- Reverte as cartas após um pequeno atraso e diminuir as tentativas
            timer.performWithDelay(1000, function()
                reverterCartas()
                audio.play (erro, {channel=7})
                tentativas = tentativas - 1
                tentativasText.text = " " .. tentativas
                -- Se o numero de tentativas chegar a 0, va para cena gameover
                if tentativas == 0 then
                    composer.gotoScene ("gameOver", {time = 800, effect = "crossFade"})
                end
                -- Libera a função de virar cartas novamente
                virar = true
            end)
        end
    end
end

-- Função chamada quando o jogador toca no tabuleiro
local function onBoardTap(event)
    checar()
end




-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create(event)
    local sceneGroup = self.view

    local bg = display.newImageRect(sceneGroup, "imagens/bg.jpg", 2000 * 0.25, 2000 * 0.25)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    tabuleiro = criarTab()
    tabuleiro:addEventListener("tap", onBoardTap)
    sceneGroup:insert(tabuleiro)

    local fundo = display.newImageRect (sceneGroup,"cenas/pontostentativas.png", 1108/4, 100/4)
    fundo.x = 120
    fundo.y = 15

    placarText = display.newText(sceneGroup, " " .. pontos, 65, 15.5, native.systemFont, 20)
    tentativasText = display.newText(sceneGroup, " " .. tentativas, 220, 15.5, native.systemFont, 20)

    local button = display.newImageRect (sceneGroup,"cenas/botaomenu.png", 248/4, 100/4)
	button.x = 306
	button.y = 465
    button:addEventListener ("tap", gotoMenu)
    
    flipcard = audio.loadSound ("audios/flipcard.mp3")
    check = audio.loadSound ("audios/check.mp3")
    erro = audio.loadSound ("audios/erro.mp3")

end


-- show()
function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif (phase == "did") then
        -- Code here runs when the scene is entirely on screen
        placarText.text = " " .. pontos
        tentativasText.text = " " .. tentativas
    end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
        composer.removeScene("fase3")
        audio.stop(1)
		audio.stop(2)
		audio.stop(3)
        audio.stop(4)
        audio.stop(7)
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
    audio.dispose (flipcard)
    audio.dispose (check)
    audio.dispose (erro)
    audio.dispose (fundo)
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

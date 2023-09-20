-- variavel global. (Deve ser evitado)
vidas = 2
vidas = 0
print (vidas)
print ("O valor de vidas:"..vidas)
---------------------------
-- Variáveis locais (só é lida dentro do script)
-- (local) é utilizado
local pontos = 10
print (pontos)
print ("o valor de pontos".. pontos)

----------------------operações aritimeticas-------------
-- Soma
-- Local (significa que a variavel é local ) laranjas(nome da variavel) = (atribuir o valor) 10 (valor atribuido a valor)
local laranjas = 10

laranjas = laranjas + 5 
-- print imprime a informação dentro do console
print (laranjas)

local bananas = 5

-- Soma entre variaveis
local cesta = 0
cesta = laranjas + bananas
print ("A soma entre as variáveis laranjas e bananas é:".. cesta)

print ("Na sua cesta possuem".. cesta.. "frutas" )

-- Subtraçao

cesta = laranjas - bananas
bananas = bananas -1

-- mutliplicacao

local carro = 8
carro = carro *2
print ("Quantidade de carros:".. carro )

-- dividindo pela multiplicacao
carro = carro * 0.5
print ("Dividindo pela multiplicação".. carro)

-- divisao
local gato=6
gato = gato /2
print ("A divisão final é:" ..gato)

local arvore = 97.5
arvore = arvore/7
print ("Divisão com vírgula".. arvore)









-- Variavel global. (deve ser evitado)
vidas = 2
vidas = 8
print (vidas)
print ("O valor de vidas".. vidas)
-----------------------------------------------------
-- Variaveis local (só é lida dentro do script)
-- (local) é utilizado somente na criação da variavel 
local pontos = 10
print (pontos)
print ("O valor de pontos:" .. pontos)

--------------------------- Operações aritimeticas ----------------
---- Soma
local laranjas = 10

laranjas = laranjas + 5
print (laranjas)

local bananas = 5

-- Soma entre variantes
local cesta = 0
cesta = laranjas + bananas
print ("A soma entre as variáveis laranjas e bananas é:".. cesta)

print ("Na sua cesta possuem".. cesta.. "frutas")

-- Subtração

cesta = laranjas - bananas
bananas = bananas - 1

-- Multiplicação

local carro = 8
carro = carro * 2
print ("quantidades de carros".. carro)

carro = carro *0.5
print (carro)
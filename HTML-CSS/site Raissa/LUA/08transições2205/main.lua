local circulo = display.newCircle (80,50,30)
-- Transiçoes
-- Comandos: transition.to (variável, {parametros})
transition.to (circulo, {time=3000,y=400})

local circulo1= display.newCircle (150,50,30)
transition.to (circulo1, {time=3000,y=400, delta=true})

local circulo2= display.newCircle (150,50,30)
transition.to (circulo2, {time=3000,y=400,iterations=4, transition= easing.outElastic})

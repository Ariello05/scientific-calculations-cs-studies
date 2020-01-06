#Zadanie 6
#Paweł Dychus 244941
#07.12.2019r 

include("interpolacja.jl")
using .Interpolacja

f(x) = abs(x)
g(x) = 1.0 / (1.0 + x^2)

rysujNnfx(f, -1.0, 1.0, 5) 
rysujNnfx(f, -1.0, 1.0, 10)
rysujNnfx(f, -1.0, 1.0, 15)

rysujNnfx(g, -5.0, 5.0, 5)
rysujNnfx(g, -5.0, 5.0, 10)
rysujNnfx(g, -5.0, 5.0, 15)
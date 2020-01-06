#Testy do zadań 1,2,3,4
#Paweł Dychus 244941
#07.12.2019r 

include("interpolacja.jl")
using .Interpolacja

f(x) = x^3 - x - 1
e = exp(1)
g(x) = e^-x

h(x) = abs(x) + x^2

rysujNnfx(f, -5.0, 5.0, 2)
rysujNnfx(f, -5.0, 5.0, 5)

rysujNnfx(g, 0.0, 10.0, 5)
rysujNnfx(g, 0.0, 10.0, 10)

rysujNnfx(h, -1.0, 1.0, 10)

x = [-2.0,0.0,2.0]
y = [6.0,2.0,6.0]
fx = ilorazyRoznicowe(x,y)
print(fx)
res = naturalna(x,fx)
print(res)
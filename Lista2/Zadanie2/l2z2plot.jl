#Paweł Dychus Lista 2 Zadanie 2 - Obliczenia Naukowe 03.11.2019
#Poniższy kod generuje wykres u użyciem biblioteki Plot.jl

e = exp((1.0))

using Plots

x = range(-10,45,length=1000)

eq(x) = e^x*log(1.0+e^(-x))

plot(x,eq)






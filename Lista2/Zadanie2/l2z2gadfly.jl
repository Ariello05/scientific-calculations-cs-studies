#]add Gadfly

#Paweł Dychus Lista 2 Zadanie 2 - Obliczenia Naukowe 03.11.2019
#Poniższy kod generuje wykres u użyciem biblioteki Gadfly

using Gadfly
e = exp((1.0))


eq(x) = e^x*log(1.0+e^(-x))

plot(eq,-10,45)



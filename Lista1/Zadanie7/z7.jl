#Paweł Dychus Lista 1 Zadanie 7 - Obliczenia Naukowe 19.10.2019

function f(x)#x - argument funkcji
    return sin(x) + cos(3*x)
end

function fprim(x)#x - argument funkcji
    return cos(x) - 3*sin(3*x)
end

function derive(x, h)#x - argument funkcji, h - argument funkcji
    return (f(x + h) - f(x))/h
end

const actual = fprim(1.0)#wartość właściwa
println(actual)
println("h & 1+h & pochodna & błąd")
for n in 0:54
    h = 2.0^(-n)
    approx = derive(1.0,h)#wartość aproksymacji pochodnej
    diff = abs(actual - approx)#błąd 
    println("2^{-$n} & $(1+h) & $(approx) & $(diff)")
end






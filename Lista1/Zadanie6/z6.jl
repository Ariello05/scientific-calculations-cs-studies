#Paweł Dychus Lista 1 Zadanie 6 - Obliczenia Naukowe 19.10.2019

function f(val)
    return sqrt(x^2 + 1.0) - 1.0
end

function g(val)
    return x^2/(sqrt(x^2 + 1.0) + 1.0)
end

i = 1#kolejne potęgi 
x = 1.0#argument funkcji
while (f(x) != 0.0) || (g(x) != 0.0)
    println("f(8^(-$i)) = $(f(x))")
    println("g(8^(-$i)) = $(g(x))")
    global x = 8.0^-i
    global i+=1
end



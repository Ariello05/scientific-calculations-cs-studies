#Paweł Dychus Lista 1 Zadanie 4 - Obliczenia Naukowe 18.10.2019

delta = 2^(-52)#współczynnik przesunięcia - w tym przypadku macheps
x = 2.0#x trzyma kolejne wartości
while (x*(1/x) == 1)#czyli iteracja po całym przedziale [1,2] aż do znalezenia wartości spełniającej warunek
    global x -= delta  
end

println("x:$x")
println("result: $(x*(1/x))")

x = nextfloat(0.0)#kolejne wartości - w tym przypadku min_{sub}
while (x *(1/x) == 1)
    x = nextfloat(x) 
end
println("\nMIN x")
println("x:$x")
println("result: $(x*(1/x))")




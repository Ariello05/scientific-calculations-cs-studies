#Paweł Dychus Lista 1 Zadanie 3 - Obliczenia Naukowe 17.10.2019

const iterations = 3#ilość iteracji w pętli

function checkRange(delta, beg)#delta - współczynnik przesunięcia, beg- początkowa wartość
    k = 1# licznik pętli
    println(bitstring(beg))
    while k <= iterations #optymalizacja, pokazujemy tylko, że mantysa iteruje binarnie do góry
        x = beg + k*delta
        k += 1
        println(bitstring(x))
    end
    println("...")
    k = 2^(52) - 1 #warunek końca
    x = beg + k*delta #przedostatnia wartość przed 1
    println(bitstring(x))#kolejne dodanie delty, dało by x = beg*2
end


println("[1, 2]")
checkRange(2^(-52),1.0)

println("[0.5, 1]")
checkRange(2^(-53),0.5)

println("[2, 4]")
checkRange(2^(-51),2.0)






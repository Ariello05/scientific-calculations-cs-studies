#Paweł Dychus Lista 1 Zadanie 1 - Obliczenia Naukowe 17.10.2019

# x to kolejne otrzymywane wartości
function myeps(T)#T typ danych
    x = T(1)

    while(T(1.0 + x / 2) > 1)
        x /= 2
    end
    return x
end

println("Float16")
println("x: $(myeps(Float16))")
println("eps: $(eps(Float16))")
println("\nFloat32")
println("x: $(myeps(Float32))")
println("eps: $(eps(Float32))")
println("FLT_EPSILON: 1.192092896e-07F")
println("\nFloat64")
println("x: $(myeps(Float64))")
println("eps: $(eps(Float64))")
println("DBL_EPSILON: 2.2204460492503131e-016")

function eta(T)#T typ danych
    eta = T(1)
    while(eta / 2 > 0)
        eta /= 2
    end
    return eta 
end

println("\nFloat16")
println("eta: $(eta(Float16))")
println("nextfloat: $(nextfloat(Float16(0)))")
println("\nFloat32")
println("eta: $(eta(Float32))")
println("nextfloat: $(nextfloat(Float32(0)))")
println("\nFloat64")
println("eta: $(eta(Float64))")
println("nextfloat: $(nextfloat(Float64(0)))")

println("\nfloatmin(Float32): $(floatmin(Float32))")
println("floatmin(Float64): $(floatmin(Float64))\n")

function maxi(T, rn)#T typ danych, rn indeks najniższej potęgi dwójki dodawanej do wartości x
    x = T(1)#x wartość początkowa

    while(!isinf(x * 2))
        x = x * 2
    end#x = 2^bias

    # Optymalizacja algorytmu, dodajemy kolejne 1 przesuwające się w strone cechy, aż osiągniemy inf.
    cur = rn #cur = 2^bias / 2^(t-1) = rn Najmniejsza możliwa liczba, która po dodaniu zmienia wartość
    while(!isinf(x + T(2)^cur))
        x = x + T(2)^cur
        cur += 1
    end
    return x
end


# bias = 15
# x = 2^15
# 2^15/2^10 = 2^5
println("Float16")
println("x: $(maxi(Float16, 5))")
println("floatmax: $(floatmax(Float16))")

# bias = 127 = cmax
# x = 2^127
# min = 2^127 / 2^23 = 2^104

println("\nFloat32")
println("x: $(maxi(Float32, 104))")
println("floatmax: $(floatmax(Float32))")
println("FLT_MAX: 3.402823466e+38F")

# bias = 1023 = cmax
# x = 2^1023
# min = 2^1023 / 2^52 = 2^971
 
println("\nFloat64")
println("x: $(maxi(Float64, 971))")
println("floatmax: $(floatmax(Float64))")
println("DBL_MAX: 1.79769e+308")



#Paweł Dychus Lista 1 Zadanie 5 - Obliczenia Naukowe 19.10.2019

const double_x = [2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
const double_y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

const float_x = map(element -> convert(Float32, element), double_x)
const float_y = map(element -> convert(Float32, element), double_y)

const array_length = length(double_x)#długość wektorów
double_sums = Array{Float64}(undef, 5)#czynniki dla FLOAT64 
float_sums = Array{Float32}(undef, 5)#czynniki dla FLOAT32
for i in 1:array_length
    double_sums[i] = double_x[i]*double_y[i]
    float_sums[i] = float_x[i]*float_y[i]
end


function A(x, T)#x - podsumy, T - typ
    println("Algorytm do przodu")
    S = (T)(0.0)

    for i in 1:array_length
        S += x[i]
    end
    println(S)
end

function B(x, T)#x - podsumy, T - typ
    println("Algorytm do tyłu")
    S = (T)(0.0)
    
    for i in reverse(1:array_length)
    S += x[i]
    end
    println(S)
end

function C(x, T)#x - podsumy, T - typ
    println("Algorytm od największego")
    Splus = (T)(0.0)#suma dodatnia
    Sminus = (T)(0.0)#suma ujemna(czynników ujemnych)
    sorted = sort(x, rev=true)
    ct = 1# dzieli indeksem na część dodatnią i ujemną
    for i in (1:array_length)
        if(sorted[i] < 0)
            ct = i
            break
        end
    end

    for i in 1:(ct-1)
        Splus += sorted[i]
    end
    for i in reverse(ct:array_length)
        Sminus += sorted[i]
    end

    S=Splus+Sminus
    println(S)
end

function D(x, T)#x - podsumy, T - typ
    println("Algorytm od najmniejszego")
    Splus = (T)(0.0)#suma dodatnia
    Sminus = (T)(0.0)#suma ujemna(czynników ujemnych)
    sorted = sort(x, rev=true)

    ct = 1# dzieli indeksem na część dodatnią i ujemną
    for i in (1:array_length)
        if(sorted[i] < 0)
            ct = i
            break
        end
    end

    for i in reverse(1:ct-1)
        Splus += sorted[i]
    end
    for i in ct:array_length
        Sminus += sorted[i]
    end
    S=Splus+Sminus
    println(S)
end

println("Float64:")
A(double_sums,Float64)
B(double_sums,Float64)
C(double_sums,Float64)
D(double_sums,Float64)
println("Float32:")
A(float_sums,Float32)
B(float_sums,Float32)
C(float_sums,Float32)
D(float_sums,Float32)

    





#Paweł Dychus Lista 2 Zadanie 1 - Obliczenia Naukowe 03.11.2019

const double_x = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
const double_y = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

const float_x = map(element -> convert(Float32, element), double_x)
const float_y = map(element -> convert(Float32, element), double_y)

const array_length = length(double_x)
double_sums = Array{Float64}(undef, 5)
float_sums = Array{Float32}(undef, 5)
for i in 1:array_length
    double_sums[i] = double_x[i]*double_y[i]
    float_sums[i] = float_x[i]*float_y[i]
end


function A(x, T)
    println("Algorytm do przodu")
    S = (T)(0.0)

    for i in 1:array_length
        S += x[i]
    end
    println(S)
end

function B(x, T)
    println("Algorytm do tyłu")
    S = (T)(0.0)
    
    for i in reverse(1:array_length)
    S += x[i]
    end
    println(S)
end

function C(x, T)
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

function D(x, T)
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

    

1.0251881368296672e-10 - -0.004296342739891585

-1.5643308870494366e-10 - -0.004296342998713953

-0.004296342842280865 - 0.0

-0.004296342842280865

bitstring(Float32(0.5772156649))

bitstring(Float32(0.577215664))



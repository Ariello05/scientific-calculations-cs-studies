#Paweł Dychus Lista 2 Zadanie 3 - Obliczenia Naukowe 08.11.2019

using LinearAlgebra

#Function generates the Hilbert matrix  A of size n,
# A (i, j) = 1 / (i + j - 1)
# by Pawel Zielinski
function hilb(n::Int)
    if n < 1
        error("size n should be >= 1")
    end
    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end


# Function generates a random square matrix A of size n with
# a given condition number c.
# by Pawel Zielinski
function matcond(n::Int, c::Float64)
    if n < 2
        error("size n should be > 1")
    end
    if c< 1.0
        error("condition number  c of a matrix  should be >= 1.0")
    end
    (U,S,V)=svd(rand(n,n))
    return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end

a = matcond(3,199.0)

println(a)

println("Hilbert")
println("n & rząd & wskaźnik_uwarunkowania & błąd_gauss & błąd_inverse")

for n in 2:20
    x = ones(n)
    A = hilb(n)
    b = A * x
    
    gauss = A\b
    inverse = inv(A)*b
    gauss = norm(gauss-x)/norm(x)
    inverse = norm(inverse-x)/norm(x)
    
    #println("A:$A; inverted:{$(inv(A))}")
    println("$n & $(rank(A)) & $(cond(A)) & $gauss & $inverse")
end

println("Random")
println("n & rząd & wskaźnik_uwarunkowania & błąd_gauss & błąd_inverse")
conds = [1.0, 10.0, 10^3, 10^7, 10^12, 10^16]

for n in [5,10,20]
    for c in conds
        x = ones(n)
        A = matcond(n, c)
        b = A * x
        
        gauss = A\b
        inverse = inv(A)*b
        gauss = norm(gauss-x)/norm(x)
        inverse = norm(inverse-x)/norm(x)
        
        println("$n & $(rank(A)) & $c & $gauss & $inverse")
    end
end




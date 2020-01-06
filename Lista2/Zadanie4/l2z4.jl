#import Pkg; Pkg.add("Polynomials")

#Paweł Dychus Lista 2 Zadanie 4 - Obliczenia Naukowe 08.11.2019

using Polynomials

#kolejne współczynniki
co = [
    1,
    -210.0-2^(-23),
    #-210.0,
    20615.0,
    -1256850.0,
    53327946.0,
    -1672280820.0,
    40171771630.0,
    -756111184500.0,
    11310276995381.0,
    -135585182899530.0,
    1307535010540395.0,
    -10142299865511450.0,
    63030812099294896.0,
    -311333643161390640.0,
    1206647803780373360.0,
    -3599979517947607200.0,
    8037811822645051776.0,
    -12870931245150988800.0,
    13803759753640704000.0,
    -8752948036761600000.0,
    2432902008176640000.0
]
# 1*x^20 + ... + 24329..0x^0
P = Poly(reverse(co))# Postać naturalna
p = poly(collect(1.0:20.0))# Wielomian Wilkinsona

mz = roots(P)# Miejsca zerowe 
println("k & |P(z_{k})| & |p(z_{k})| & |z_{k}-k|")
for k in 1:20
    println("$k & $(abs(P(mz[k]))) & $(abs(p(mz[k]))) & $(abs(mz[k]-k))")
end






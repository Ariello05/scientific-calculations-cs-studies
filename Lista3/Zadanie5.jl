#Zadanie 5
#Paweł Dychus 244941
#24.11.2019r 

include("./metody.jl")
using .Metody

delta = 10.0^-4.0
epsilon = 10.0^-4.0

e = exp(1)
f(x) = e^x - 3x # przecinają się, gdy mają tą samą wartość


print("1. rozwiązanie w: [0,1] \n")
(r, v, it, err) = mbisekcji(f, 0.0, 1.0, delta, epsilon)
print("x1: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("2. rozwiązanie w: [1,2] \n")
(r, v, it, err) = mbisekcji(f, 1.0, 2.0, delta, epsilon)
print("x2: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

#Zadanie 6
#Paweł Dychus 244941
#24.11.2019r 

include("./metody.jl")
using .Metody

delta = 10.0^-5.0               # dokładność obliczeń
epsilon = 10.0^-5.0             # dokładność obliczeń
maxit = 32                      # maksymalna dopuszczalna liczba iteracji

e = exp(1)
f(x) = e^(1.0 - x) - 1.0# f - funkcja, x - argument
g(x) = x * e^(-x)# g - funkcja, x - argument

pf(x) = -e^(1.0 - x)# pochodna f
pg(x) = e^-x - x * e^-x# pochodna g


print("f1(x) = e^(1-x)-1: \n")

print("bisekcji: [0.0,1.5]\n")
(r, v, it, err) = mbisekcji(f, 0.0, 1.5, delta, epsilon)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("bisekcji [0.0,10.0]: \n")
(r, v, it, err) = mbisekcji(f, 0.0, 10.0, delta, epsilon)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("bisekcji [-100.0,1000.0]: \n")
(r, v, it, err) = mbisekcji(f, 0.0, 1000.0, delta, epsilon)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("stycznych(Newtona): \n")
(r, v, it, err) = mstycznych(f, pf, 0.5, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("siecznych(-1.0, 2.0): \n")
(r, v, it, err) = msiecznych(f, -1.0, 2.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("siecznych(-1.0, 5.0): \n")
(r, v, it, err) = msiecznych(f, -1.0, 5.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

println()
print("stycznych(Newtona) test dla x = 5: \n")
(r, v, it, err) = mstycznych(f, pf, 5.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("stycznych(Newtona) test dla x = 10: \n")
(r, v, it, err) = mstycznych(f, pf, 10.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("stycznych(Newtona) test dla x = 100: \n")
(r, v, it, err) = mstycznych(f, pf, 100.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("f2(x) = xe^-x: \n")

print("bisekcji[-0.5,1.0]: \n")
(r, v, it, err) = mbisekcji(g, -0.5, 1.0, delta, epsilon)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("bisekcji[-0.5,10.0]: \n")
(r, v, it, err) = mbisekcji(g, -0.5, 10.0, delta, epsilon)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("bisekcji [-5,1000.0]: \n")
(r, v, it, err) = mbisekcji(g, -5.0, 1000.0, delta, epsilon)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("stycznych(Newtona): \n")
(r, v, it, err) = mstycznych(g, pg, -0.5, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("siecznych(-1.0, 1.0) \n")
(r, v, it, err) = msiecznych(g, -1.0, 1.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("siecznych(-3.0, 3.0): \n")
(r, v, it, err) = msiecznych(g, -3.0, 3.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("siecznych(10.0, 20.0): \n")
(r, v, it, err) = msiecznych(g, 10.0, 20.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

println()
print("stycznych(Newtona) test dla x = 1: \n")
(r, v, it, err) = mstycznych(g, pg, 1.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("stycznych(Newtona) test dla x = 10: \n")
(r, v, it, err) = mstycznych(g, pg, 10.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("stycznych(Newtona) test dla x = 100: \n")
(r, v, it, err) = mstycznych(g, pg, 100.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

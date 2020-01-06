include("./metody.jl")
using .Metody

#Paweł Dychus 244941
#24.11.2019r 
#Testy

delta = 10.0^-6.0
epsilon = 10.0^-6.0
maxit = 64

f(x) = x^2 - 16
g(x) = x^4 - 18
pf(x) = 2*x
pg(x) = 4*(x^3)

print("x^2 - 16\n")

print("bisekcji: \n")
(r,v,it,err) = mbisekcji(f, 1.8, 5.5, delta, epsilon)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("Newtona: \n")
(r,v,it,err) = mstycznych(f, pf, 6.5, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("siecznych: \n")
(r,v,it,err) = msiecznych(f, 1.0, 5.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")
print()


print("x^4 - 18\n")

print("bisekcji: \n")
(r,v,it,err) = mbisekcji(g, 1.5, 6.0, delta, epsilon)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("Newtona: \n")
(r,v,it,err) = mstycznych(g, pg, 1.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("siecznych: \n")
(r,v,it,err) = msiecznych(g, 1.0, 6.5, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")
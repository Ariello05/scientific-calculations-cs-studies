#Zadanie 4
#Paweł Dychus 244941
#24.11.2019r 

include("./metody.jl")
using .Metody

delta = 0.5 * 10.0^-5.0       
epsilon = 0.5 * 10.0^-5.0           
maxit = 64                       


f(x) = (sin(x) - (0.5 * x)^2.0)# f - funkcja, x - argument
pf(x) = (cos(x) - 0.5 * x)# Pochodna f

print("Metoda bisekcji: \n")
(r,v,it,err) = mbisekcji(f, 1.5, 2.0, delta, epsilon)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("Metoda Newtona: \n")
(r,v,it,err) = mstycznych(f, pf, 1.5, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")

print("Metoda siecznych: \n")
(r,v,it,err) = msiecznych(f, 1.0, 2.0, delta, epsilon, maxit)
print("r: $(r)\t v: $(v)\t it: $(it)\t err: $(err)\n")




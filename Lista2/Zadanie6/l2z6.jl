#import Pkg; Pkg.add("Plots")

#Paweł Dychus Lista 2 Zadanie 6 - Obliczenia Naukowe 09.11.2019

using Plots

#Funkcja rekurencyjna opisująca wzór
function rek(count, x, c)#x - wartość początkowa, c - stała
    
    if(count <= 0)
        return x
    else
        xn = rek(count-1,x, c)        
        return xn*xn+c #wzor rekurencyjny
    end
end


println(rek(40,1,-2))
println(rek(40,2,-2))
println(rek(40, 1.99999999999999,-2))
println(rek(40,1,-1))
println(rek(40,-1,-1))
println(rek(40,0.75,-1))
println(rek(40,0.25,-1))


#Sekcja pomocniczna, iteracja graficzna

#Funkcja rekurencyjna opisująca wzór + zwracająca tablicę kolejnych wartości
function rek_show(count, x, c)#x - wartość początkowa, c - stała
    tab = Array{typeof(x)}(undef, count)
    size = count
    rek2(count,x,c,tab,size)
    #println(tab[size])
    return tab
end

#Funkcja rekurencyjna opisująca wzór
function rek2(count, x, c,tab, size)#x - wartość początkowa, c - stała
    
    if(count <= 0)
        return x
    else
        xn = rek2(count-1,x, c,tab,size)        
        tab[count] = xn*xn+c
        return xn*xn+c #wzor rekurencyjny 
    end
end
println()
arr = 1:40
#tab = rek_show(40,1,-2)
#tab = rek_show(40,2,-2)
#tab = rek_show(40,1.99999999999999,-2)
#tab = rek_show(40,1,-1)
#tab = rek_show(40,-1,-1)
#tab = rek_show(40,0.75,-1)
#tab = rek_show(40,0.25,-1)
#println(tab[16])
#plot(arr,tab,lw=2)






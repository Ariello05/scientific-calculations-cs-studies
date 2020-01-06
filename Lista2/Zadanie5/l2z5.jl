#Paweł Dychus Lista 2 Zadanie 5 - Obliczenia Naukowe 09.11.2019

function pop(count, p, r)

    if(count <= 0)
        return p
    else
        pn = pop(count-1,p, r)
        println(pn)
        return pn+r*pn*(1-pn)#wzor rekurencyjny
    end
end

r = Float32(3)#czynnik r

w32 = pop(40,Float32(0.01),r)#wartość po 40 iteracjach
println("step")
re = pop(10,Float32(0.01),r)
re = pop(10,trunc(re*1000)/1000,r)#przesuń 3 w lewo, usuń część ułamkową przesuń 3 w prawo 
re = pop(10,trunc(re*1000)/1000,r)
re = pop(10,trunc(re*1000)/1000,r)
println("step")

println("no trunc: $w32; with trunc: $re")

w64 = pop(40,Float64(0.01),3.0)#wartość po 40 iteracjach
println("32float: $w32; 64float: $w64")




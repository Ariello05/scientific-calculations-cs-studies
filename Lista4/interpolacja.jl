module Interpolacja
	#Zadania 1,2,3,4 kolejne implementacje
	#Paweł Dychus 244941
    #07.12.2019r 

	export ilorazyRoznicowe,warNewton,naturalna,rysujNnfx

    using Plots
    plotly()

    function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
        n = length(f)             # długość wektorów
        fx = Vector{Float64}(undef, n)   # wyjściowy wektor z ilorazami różnicowymi

        for i = 1:n             
            fx[i] = f[i]
        end

        for i = 2:n   
            for j = n:-1:i # n -> i; f[k] : k < i, nie zmienia wartości = f[x_0,x_1,...,x_k-1]
                fx[j] = (fx[j] - fx[j - 1]) / (x[j] - x[j - i + 1])
            end
                
        end

        return fx
    end
    
    function warNewton(x :: Vector{Float64}, fx :: Vector{Float64}, t :: Float64)

        n = length(fx)      # długość wektorów
        nt = fx[n]          # w_n(x)
    
        for i = n-1 : -1 : 1
            nt = fx[i]+(t-x[i])*nt # w_k(x) = w_k+1(x)(x-x_k) + f[x_0,...,x_k]
        end
    
        return nt
    end

    function naturalna(x :: Vector{Float64}, fx :: Vector{Float64})
        n = length(fx)                  # długość wektorów
        a = Vector{Float64}(undef, n)          # współczynniki wyjściowe w postaci normalnej
        a[n] = fx[n]                    # z twierdzenia 

        for k = n-1 : -1 : 1            
            a[k] = fx[k]-a[k+1]*x[k]    
            for i = k+1 : n-1           #  "częściowa" postac normalna
                a[i] = a[i]-a[i+1]*x[k]
            end
        end
        return a
    end

    function rysujNnfx(f, a :: Float64, b :: Float64, n :: Int)
    
        curx = 0.0                                   # kolejne wartości h
        steps  = n + 1                               # maksymalna ilość węzłów
        dist = (b-a)/n                               # krok - stała długość
    
        x = Vector{Float64}(undef,n+1)        # wektor zawierający węzły
        y = Vector{Float64}(undef,n+1)        # wartości funkcji w kolejnych węzłach

        for i = 1: steps 
            x[i] = a + curx
            y[i] = f(x[i])
            curx += dist
        end
    
        fx = ilorazyRoznicowe(x, y);                # ilorazy różnicowe dla kolejnych węzłów
        dens = 10                                   # mnożnik dokładności wykresu

        curx = 0.0
        steps  *= dens
        dist = (b - a)/(steps -1)

        res_y = Vector{Float64}(undef, dens*(n + 1))       # wektor wartości funkcji na rysunku
        res_x = Vector{Float64}(undef, dens*(n + 1))       # wektor węzłów 
        res_new = Vector{Float64}(undef, dens*(n + 1))     # wartości wielomianu interpolacyjnego w węzłach
    
        for i = 1: steps 
            res_x[i] = a + curx
            res_new[i] = warNewton(x, fx, res_x[i])
            res_y[i] = f(res_x[i])
            curx += dist
        end

        labels = ["f(x)" "w(x)"]
        plt = plot(res_x, [res_y, res_new], label = labels, linewidth=2.0)
        display(plt)
        #savefig(string("img/plot", f, "_", n, ".png"))
    end

end

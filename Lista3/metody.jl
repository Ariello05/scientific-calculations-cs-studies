module Metody
	#Zadanie 1,2,3 kolejne implementacje
	#Paweł Dychus 244941
	#23.11.2019r 

	export mbisekcji, mstycznych, msiecznych

	function mbisekcji(f,a::Float64,b::Float64,delta::Float64,epsilon::Float64)
		if sign(f(a)) == sign(f(b))
			print("Function doesn't change sign!\n")
			return (0,0,0,1)
		end
		
		it = 1;
		e = (b-a) / 2 
		center = a + e
		valcent = f(center)

		while e >= delta && abs(valcent) >= epsilon
			it += 1
			#if(abs(a-b+) <= epsilon || abs(f(c)) <= delta)
			#    break
			#end
			
			if (sign(f(a)) == sign(valcent))
				a = center
			else
				b = center
			end
			
			e /= 2
			center = a + e
			valcent = f(center)
			#print("=$center \t $a \t $b\n")
		end
				
		return (center,valcent,it,0)
	end

	function mstycznych(f, pf, x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
		y = f(x0)
		if abs(y) < epsilon
			return (x0,y,0,0)
		end
		
		if abs(pf(x0)) < epsilon# pochodna bliska 0
			return (x0,y,0,2)
		end
			
		k = 1
		while k < maxit 
			x1 = x0 - y/pf(x0)
			y = f(x1)
			if abs(x1-x0) <= delta || abs(y) <= epsilon# warunek zbieznosci(końca)
				return(x0,y,k,0)
			end
			
			x0 = x1
			k += 1
		end
				
		return (x0,y,k,1)# nie osiagnieto wymaganej zbieznosci, po 'maxit' iteracji
	end

	function swap(x1,x2)
		m = x1
		x1 = x2
		x2 = m
	end

	function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
		fa = f(x0)
		fb = f(x1)
		
		k = 1
		while k < maxit 
			if abs(fa) > abs(fb)
				swap(fa,fb)
				swap(x0,x1)
			end
			
			s = (x1-x0)/(fb-fa)
			x1 = x0
			fb = fa
			x0 = x0 - fa*s
			fa = f(x0)
			
			if abs(fa) <= epsilon || abs(x1-x0) <= delta
				return (x0,fa,k,0)
			end
				
			k += 1
		end
				
		return (x0,fa,k,1)# nie osiagnieto wymaganej zbieznosci, po 'maxit' iteracji
	end

end
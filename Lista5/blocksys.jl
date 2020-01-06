# Paweł Dychus 244941
# XII 2019
module Blocksys
using SparseArrays
export read_matrix, read_vector, gauss_standard, gauss_pivot,
 write_result, LU_standard,LU_pivot, solve_LU_standard,solve_LU_pivot, right_vector;

# Funkcja wczytuje macierz z pliku
# in: f_path - filename
# out: (M,n,l): M - sparse matrix, n - matrix size, l - block size
function read_matrix(f_path::String)
    open(f_path) do file
        line = split(readline(file))
      		n = parse(Int64, line[1])
      		l = parse(Int64, line[2])
      		el_num = n * l + 3 * (n - l)
      		J = Array{Int64}(undef, el_num)
      		I = Array{Int64}(undef, el_num)
      		V = Array{Float64}(undef, el_num)
      		i = 1
      		while !eof(file)
            line = split(readline(file))
         			J[i] = parse(Int64, line[1])
         			I[i] = parse(Int64, line[2])
         			V[i] = parse(Float64, line[3])
         			i += 1
      		end
      		M = sparse(I, J, V)
        return (M, n, l)
    end
end

# Funkcja wczytuje wektor z pliku
# in: f_path - filename
# out: B - vector
function read_vector(f_path::String)
    open(f_path) do file
        n = parse(Int64, readline(file))
        B = Array{Float64}(undef, n)
        i = 1
        while !eof(file)
            B[i] = parse(Float64, readline(file))
            i += 1
        end
        return B
    end
end

using LinearAlgebra # norm

# Funkcja zapisująca rozwiązanie układu równań do pliku
# in:	f_path - ścieżka do pliku wyjścia, x - wektor z rozwiązaniem,
#       n - rozmiar macierzy, err - flaga zapisu błędu względnego
function write_result(f_path::String, x::Array{Float64}, n::Int64, err::Bool)
   	open(f_path, "w") do file
      		if (err)
         			relative_error = norm(ones(n) - x) / norm(x)
         			println(file, relative_error)
      		end
      		for i in 1:n
         			println(file, x[i])
      		end
   	end
end

# Funkcja liczy prawy wektor równania Ax=b, gdzie x_i dla każdego i wynosi 1
# in: M - macierz rzadka, n - wielkość macierzy, l - wielkość bloku 
function right_vector(M::SparseMatrixCSC{Float64,Int64}, n::Int64, l::Int64)
    b = zeros(Float64, n)
    for i = 1:n
        x_end = min(i + l, n)
        x_begin = convert(Int64, max((-1 + l * floor((i - 1) / l)), 1))
        for j = x_begin:x_end
            b[i] += M[j,i]
        end
    end

    return b
end


# Funkcja rozwiązuje układ równań metodą Gaussa
# in: (M,b,n,l) M - spare matrix, b - vector, n - matrix size, l - block size
# out: X - vector, oc - operation count (helper)
function gauss_standard(M::SparseMatrixCSC{Float64,Int64}, b::Array{Float64}, n::Int64, l::Int64)
    # yend = l # kontroluje końcowy wiersz przy odejmowaniu równań stronami
    oc = 0 # operation count (arithmetic)
    for i = 1:(n - 1)
        yend = convert(Int64, min(l + l * floor((i + 1) / l), n))# ostatni wiersz w danym kroku
        xend = min(i + l, n) # ostatni element wiersza w danym kroku
        for j = i + 1:yend
            if abs(M[i,i]) < eps(Float64)
                error("Nie można zastosować tej metody, współczynnik na przekątnej równy 0!")
            end

            c = M[i,j] / M[i,i] # mnożnik zerujący a_ij przy odejmowaniu stronami równań
            b[j] = b[j] - b[i] * c
            M[i,j] = 0
            oc += 3
            for p = (i + 1):xend
                M[p,j] = M[p,j] - M[p,i] * c
                oc += 2
            end
        end
    end
    x = Array{Float64}(undef, n)

    for i = n:-1:1
        sum = 0.0
        xend = min(i + l, n)# ostatni element wiersza w danym kroku
        for j = (i + 1):xend
            sum += M[j,i] * x[j]
            oc += 2
        end  
        x[i] = (b[i] - sum) / M[i,i]
        oc += 2
    end
    return x, oc
end

# Funkcja rozwiązuje układ równań metodą Gaussa
# in: (M,b,n,l) M - spare matrix, b - vector, n - matrix size, l - block size
# out: X - vector, oc - operation count (helper)
        function gauss_pivot(M::SparseMatrixCSC{Float64,Int64}, b::Array{Float64}, n::Int64, l::Int64)
    oc = 0# operation count (arithmetic)
    p = collect(1:n)
    for i = 1:(n - 1)
        yend = convert(Int64, min(l + l * floor((i + 1) / l), n))# ostatni wiersz w danym kroku
        xend = convert(Int64, min(2 * l + l * floor((i + 1) / l), n))# ostatni element wiersza w danym kroku

        maxindex = i
        max = abs(M[i,p[i]])
        for x = i + 1:yend
            if abs(M[i,p[x]]) > max
                maxindex = x
                max = abs(M[i,p[x]])
            end
            oc += 1
        end
        p[i], p[maxindex] = p[maxindex], p[i]

        for j = i + 1:yend
            if abs(M[i,p[i]]) < eps(Float64)
                error("Współczynnik równy 0!")
            end

            c = M[i,p[j]] / M[i,p[i]] # mnożnik zerujący a_ij przy odejmowaniu stronami równań
            b[p[j]] = b[p[j]] - b[p[i]] * c
            M[i,p[j]] = 0
            oc += 3
            for q = (i + 1):xend
                M[q,p[j]] = M[q,p[j]] - M[q,p[i]] * c
                oc += 2
            end
        end
    end
    x = Array{Float64}(undef, n)

    for i = n:-1:1
        sum = 0.0
        xend = convert(Int64, min(2 * l + l * floor((i + 1) / l), n))# ostatni element wiersza w danym kroku
        for j = (i + 1):xend
            sum += M[j,p[i]] * x[j]
            oc += 2
        end  
        x[i] = (b[p[i]] - sum) / M[i,p[i]]
        oc += 2
    end
    return x, oc
end

# Funkcja tworzy rozkład LU zadanej macierzy
# in: (M,b,n,l) M - sparse matrix, b - vector, n - matrix size, l - block size
# out: oc - operation count (helper)
        function LU_standard(M::SparseMatrixCSC{Float64,Int64}, b::Array{Float64}, n::Int64, l::Int64)
    oc = 0 # operation count (arithmetic)
    for i = 1:(n - 1)
        yend = convert(Int64, min(l + l * floor((i + 1) / l), n))# ostatni wiersz w danym kroku
        xend = min(i + l, n) # ostatni element wiersza w danym kroku
        for j = i + 1:yend
            if abs(M[i,i]) < eps(Float64)
                error("Współczynnik równy 0!")
            end

            c = M[i,j] / M[i,i] # mnożnik zerujący a_ij przy odejmowaniu stronami równań
            M[i,j] = c # L
            oc += 1
            for p = (i + 1):xend
                M[p,j] = M[p,j] - M[p,i] * c # U
                oc += 2
            end
        end
    end
    return oc
end

# Funkcja rozwiązuje układ równań metodą Gaussa
# in: (M,b,n,l) M - spare matrix, b - vector, n - matrix size, l - block size
# out: p - pivoting permutations of M, oc - operation count (helper)
        function LU_pivot(M::SparseMatrixCSC{Float64,Int64}, b::Array{Float64}, n::Int64, l::Int64)
    oc  = 0# operation count(arithmetic)
    p = collect(1:n)# tablica permutacji
    for i = 1:(n - 1)
        yend = convert(Int64, min(l + l * floor((i + 1) / l), n))# ostatni wiersz w danym kroku
        xend = convert(Int64, min(2 * l + l * floor((i + 1) / l), n))# ostatni element wiersza w danym kroku

        maxindex = i
        max = abs(M[i,p[i]])
        for x = i + 1:yend
            if abs(M[i,p[x]]) > max
                maxindex = x
                max = abs(M[i,p[x]])
            end
            oc += 1
        end
        p[i], p[maxindex] = p[maxindex], p[i]

        for j = i + 1:yend
            if abs(M[i,p[i]]) < eps(Float64)
                error("Współczynnik równy 0!")
            end

            c = M[i,p[j]] / M[i,p[i]] # mnożnik zerujący a_ij przy odejmowaniu stronami równań
            M[i,p[j]] = c # L
            oc += 1
            for q = (i + 1):xend
                M[q,p[j]] = M[q,p[j]] - M[q,p[i]] * c # U
                oc += 2
            end
        end
    end

    return p, oc
end

# Funkcja rozwiązuje LU bez permutacji
# in: (M,b,n,l) M - LU matrix, b - vector, n - matrix size, l - block size, oc - optional operation count
# out: X - vector
        function solve_LU_standard(M::SparseMatrixCSC{Float64,Int64}, b::Array{Float64}, n::Int64, l::Int64, oc::Int64 = 0)
    # oc: operation count(arithmetic)
    z = Array{Float64}(undef, n)# z, Lz = b
    x_begin = 1
    for i = 1:n
        sum = 0.0
        x_begin = convert(Int64, max(l * floor((i - 1) / l) - 1, 1))# początek wiersza
        for j = x_begin:i - 1
            sum += M[j,i] * z[j]
            oc += 2
        end  
        z[i] = b[i] - sum # /1
        oc += 1
    end

    x = Array{Float64}(undef, n)# x, Ux = z
    for i = n:-1:1
        sum = 0.0
        x_end = min(i + l, n)# koniec wiersza
        for j = i + 1:x_end
            sum += M[j,i] * x[j]
            oc += 2
        end  
        x[i] = (z[i] - sum) / M[i,i]
        oc += 2
    end

    return x, oc
end

# Funkcja rozwiązuje LU z permutacjami
# in: (M,b,n,l) M - LU matrix, b - vector, n - matrix size, l - block size, oc - optional operation count
# out: X - vector, oc - operation count (helper)
        function solve_LU_pivot(M::SparseMatrixCSC{Float64,Int64}, b::Array{Float64}, n::Int64, l::Int64, p::Array{Int64}, oc::Int64 = 0)
    # oc: operation count(arithmetic)
    z = Array{Float64}(undef, n)# z, Lz = b
    for i = 1:n
        sum = 0.0
        x_begin = convert(Int64, max(l * floor((p[i] - 1) / l) - 1, 1))# początek wiersza
        for j = x_begin:i - 1
            sum += M[j,p[i]] * z[j]
            oc += 2
        end  
        z[i] = b[p[i]] - sum # /1
        oc += 1
    end

    x = Array{Float64}(undef, n)# x, Ux = z
    for i = n:-1:1
        sum = 0.0
        x_end = convert(Int64, min(2 * l + l * floor((p[i] + 1) / l), n))# koniec wiersza
        for j = i + 1:x_end
            sum += M[j,p[i]] * x[j]
            oc += 2
        end  
        x[i] = (z[i] - sum) / M[i,p[i]]
        oc += 2
    end

    return x, oc
end

    end
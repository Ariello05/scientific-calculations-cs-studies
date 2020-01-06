# Testy do zadania
# Paweł Dychus 244941
# XII 2019

include("blocksys.jl")
using .Blocksys
using LinearAlgebra
(A, n, l) = read_matrix("Dane/Dane16_1_1/A.txt")
B = read_vector("Dane/Dane16_1_1/b.txt")
# x,oc = gauss_pivot(A, B, n, l)
# p,oc = LU_pivot(A, B, n, l)
# x,oc = solve_LU_pivot(A, B, n, l, p)
# x,oc = gauss_standard(A, B, n, l)

LU_standard(A, B, n, l)
x, oc = solve_LU_standard(A, B, n, l)
write_result("res.txt", x, n, true)


# include("matrixgen.jl")
# using .matrixgen


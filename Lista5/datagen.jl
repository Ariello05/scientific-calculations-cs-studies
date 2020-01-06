# Generowanie danych testujących złożoność obliczenowią zaimplementowanych algorytmów.
# Paweł Dychus 244941
# XII 2019
include("blocksys.jl")
using .Blocksys
include("matrixgen.jl")
using .matrixgen
using SparseArrays
using LinearAlgebra

# Standard data gathering method for stepping n
function runTest(outFileName::String, method, (start, step, stop), repeats::Int64, blockSize::Int64, condition::Float64)

    open(outFileName, "w") do file
        println(file, "i \t operation_count \t time \t memory \t error")
        for i in (start:step:stop)
            sum_t = 0.0
            sum_b = 0.0
            sum_e = 0.0
            ocl = 0
            for k in 1:repeats
                blockmat(i, blockSize, condition, "test.txt")
                (A, n, l) = read_matrix("test.txt")
                b = right_vector(A, n, l)   

                (x, oc), t, bytes, gctime, memallocs = @timed method(A, n, l, b)
                counter = 0
                while (gctime > 0)# garbage collection time
                    (x, oc), t, bytes, gctime, memallocs = @timed method(A, n, l, b)
                    counter += 1
                    if (counter > 10)# safe guard
                        break
                    end
                end
                ocl = oc# oc doesnt really change...
                err = norm(x - ones(n)) / norm(ones(n))
                sum_b += bytes / repeats
                sum_t += t
                sum_e += err

            end
            sum_t /= repeats
            sum_e /= repeats

            println(file, "$i \t $ocl \t $sum_t \t $sum_b \t $sum_e")
        end
        close(file)
    end
end

function gaussA(A, n, l, b)
    x, oc = gauss_standard(A, b, n, l)
    return x, oc
end

function gaussB(A, n, l, b)
    x, oc = gauss_pivot(A, b, n, l)
    return x, oc
end

function luA(A, n, l, b)
    oc = LU_standard(A, b, n, l)
    x, oc = solve_LU_standard(A, b, n, l, oc)
    return x, oc
end

function luB(A, n, l, b)
    p, oc = LU_pivot(A, b, n, l)
    x, oc = solve_LU_pivot(A, b, n, l, p, oc)
    return x, oc
end


# (396, 12, 1500)
runTest("gaussA.txt", gaussA, (16, 200, 10616), 32, 4, 1.0)
runTest("gaussB.txt", gaussB, (16, 200, 10616), 32, 4, 1.0)
runTest("luA.txt", luA, (16, 200, 10616), 32, 4, 1.0)
runTest("luB.txt", luB, (16, 200, 10616), 32, 4, 1.0)

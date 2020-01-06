#Paweł Dychus Lista 1 Zadanie 2 - Obliczenia Naukowe 17.10.2019

# x to wartość wyrażenia Kahana
x = 3(Float16(4)/3-1) - 1
println("Float16")
println(x)
println(eps(Float16))

x = 3(Float32(4)/3-1) - 1
println("\nFloat32")
println(x)
println(eps(Float32))

x = 3(Float64(4)/3-1) - 1
println("\nFloat64")
println(x)
println(eps(Float64))





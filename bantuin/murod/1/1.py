# Soal 1: Polinomial Lagrange
# Hitung P(5) dari rumus Polinomial Lagrange
x = 5
P = ((x - 4) * (x - 6) / ((2 - 4) * (2 - 6)) * 5 +
     (x - 2) * (x - 6) / ((4 - 2) * (4 - 6)) * 15 +
     (x - 2) * (x - 4) / ((6 - 2) * (6 - 4)) * 30)
print("Hasil perkiraan f(5) menggunakan Polinomial Lagrange:", P)

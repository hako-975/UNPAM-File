# Data titik-titik
x = [1, 2, 3, 4, 5]
y = [2, 1, 4, 5, 7]

# Fungsi untuk menghitung polinomial Lagrange
def lagrange_interpolation(x, y, xi):
    n = len(x)
    result = 0
    for i in range(n):
        term = y[i]
        for j in range(n):
            if j != i:
                term *= (xi - x[j]) / (x[i] - x[j])
        result += term
    return result

# Hitung nilai y saat x = 2.5
xi = 2.5
yi = lagrange_interpolation(x, y, xi)
print("Hasil interpolasi Lagrange:", yi)

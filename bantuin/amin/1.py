# Definisikan fungsi PDB
def f(x, y):
    return x + y

# Inisialisasi nilai awal
x0 = 0
y0 = 1
h = 0.05
target_x = 0.20

# Perhitungan Metode Euler
while x0 < target_x:
    y0 = y0 + h * f(x0, y0)
    x0 += h

# Hasil perkiraan nilai y(0.20)
predicted_y = y0

# Solusi sejati
import math
true_y = math.exp(0.20) - 0.20 - 1

# Menghitung galat
error = abs(true_y - predicted_y)

print("Perkiraan y(0.20) menggunakan Metode Euler:", predicted_y)
print("Galat:", error)

# Definisikan fungsi PDB
def f(x, y):
    return x + y

# Inisialisasi nilai awal
x0 = 0
y0 = 1
h = 0.02
target_x = 0.10

# Perhitungan Metode Heun
while x0 < target_x:
    k1 = h * f(x0, y0)
    k2 = h * f(x0 + h, y0 + k1)
    y0 = y0 + 0.5 * (k1 + k2)
    x0 += h

# Hasil perkiraan nilai y(0.10)
predicted_y = y0

print("Perkiraan y(0.10) menggunakan Metode Heun:", predicted_y)

# Soal 3: Akar Numerik dengan Metode Tali Busur
# Implementasi metode tali busur untuk mencari akar numerik
def f(x):
    return x**3 - 2 * x - 5

def f_prime(x):
    return 3 * x**2 - 2

x0 = 2  # Tebakan awal
x1 = 3  # Tebakan awal

for i in range(10):
    x2 = x1 - f(x1) / f_prime(x1)
    x0, x1 = x1, x2

print("Akar numerik dari f(x) adalah:", x2)

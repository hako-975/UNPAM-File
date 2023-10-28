#include <iostream>
#include <cmath>

using namespace std;

// Fungsi f(x)
double f(double x) {
    return pow(x, 3) - 2 * x - 5;
}

// Turunan pertama dari f(x)
double f_prime(double x) {
    return 3 * pow(x, 2) - 2;
}

int main() {
    double x0 = 2; // Tebakan awal
    double x1 = 3; // Tebakan awal
    double x2;     // Untuk menyimpan hasil iterasi

    for (int i = 0; i < 10; i++) {
        x2 = x1 - f(x1) / f_prime(x1);
        x0 = x1;
        x1 = x2;
    }

    cout << "Akar numerik dari f(x) adalah: " << x2 << endl;

    return 0;
}


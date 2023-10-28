#include <iostream>

using namespace std;

int main() {
    // Data titik
    double x[] = {2, 4, 6};
    double y[] = {5, 15, 30};
    double target_x = 5; // Nilai x yang ingin diinterpolasi

    int n = sizeof(x) / sizeof(x[0]);
    double result = 0.0;

    for (int i = 0; i < n; i++) {
        double term = y[i];
        for (int j = 0; j < n; j++) {
            if (i != j) {
                term *= (target_x - x[j]) / (x[i] - x[j]);
            }
        }
        result += term;
    }

    cout << "Hasil perkiraan f(" << target_x << ") menggunakan Polinomial Lagrange: " << result << endl;

    return 0;
}


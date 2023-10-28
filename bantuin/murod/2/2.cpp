#include <iostream>

using namespace std;

int main() {
    // Data
    double t[] = {0, 1, 2, 3, 4};
    double y[] = {0, 5, 12, 21, 32};
    double t_target = 2.5;  // Waktu yang ingin diperiksa

    int n = sizeof(t) / sizeof(t[0]);
    int segment = 0;

    // Mencari segmen yang sesuai
    while (segment < n - 1 && t_target > t[segment + 1]) {
        segment++;
    }

    // Menggunakan persamaan Spline Linier untuk menghitung jarak pada waktu t_target
    double m = (y[segment + 1] - y[segment]) / (t[segment + 1] - t[segment]);
    double y_target = y[segment] + m * (t_target - t[segment]);

    cout << "Jarak yang ditempuh pada t = 2.5 jam dengan Spline Linier: " << y_target-1 << " kilometer" << endl;

    return 0;
}


#include <iostream>
#include <cmath>
using namespace std;

double f(double y) {
    return 1 + pow(y, 2);
}

int main() {
    double x0 = 0;
    double y0 = 0;
    double h = 0.10;
    double target_x = 0.20;
    while (x0 < target_x) {
        double k1 = h * f(y0);
        double k2 = h * f(y0 + 0.5 * k1);
        double k3 = h * f(y0 + 0.5 * k2);
        double k4 = h * f(y0 + k3);
        y0 = y0 + (1.0/6.0) * (k1 + 2*k2 + 2*k3 + k4);
        x0 += h;
    }
    double predicted_y = y0;
    double true_y = atan(0.20);
    double error = fabs(true_y - predicted_y);
    cout << "Predicted y(0.20) using Runge-Kutta (4th order): " << predicted_y << endl;
    cout << "Error: " << error << endl;
    return 0;
}


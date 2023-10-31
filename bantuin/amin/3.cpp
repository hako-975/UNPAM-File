#include <iostream>

using namespace std;

// Define the differential equation function
double f(double x, double y) {
    return x + y;
}

int main() {
    double x0 = 0;
    double y0 = 1;
    double h = 0.02;
    double target_x = 0.10;

    while (x0 < target_x) {
        double k1 = h * f(x0, y0);
        double k2 = h * f(x0 + h, y0 + k1);
        y0 = y0 + 0.5 * (k1 + k2);
        x0 += h;
    }

    double predicted_y = y0;
    
    cout << "Predicted y(0.10) using Heun's method: " << predicted_y << endl;
    
    return 0;
}


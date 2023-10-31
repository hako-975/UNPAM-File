#include <iostream>
#include <cmath>

using namespace std;

double f(double x, double y) {
    return x + y;
}

int main() {
    double x0 = 0;
    double y0 = 1;
    double h = 0.05;
    double target_x = 0.20;

    while (x0 < target_x) {
        y0 = y0 + h * f(x0, y0);
        x0 += h;
    }

    double predicted_y = y0;
    
    double true_y = exp(0.20) - 0.20 - 1;
    
    double error = fabs(true_y - predicted_y);
    
    cout << "Predicted y(0.20) using Euler's method: " << predicted_y << endl;
    cout << "Error: " << error << endl;
    
    return 0;
}


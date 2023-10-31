import math

# Define the differential equation function
def f(y):
    return 1 + y**2

# Initial values
x0 = 0
y0 = 0
h = 0.10
target_x = 0.20

# Using Runge-Kutta method (4th order)
while x0 < target_x:
    k1 = h * f(y0)
    k2 = h * f(y0 + 0.5 * k1)
    k3 = h * f(y0 + 0.5 * k2)
    k4 = h * f(y0 + k3)
    y0 = y0 + (1/6) * (k1 + 2*k2 + 2*k3 + k4)
    x0 += h

# Predicted value of y(0.20)
predicted_y = y0

# True solution
true_y = math.tan(0.20)

# Calculate the error
error = abs(true_y - predicted_y)

print("Predicted y(0.20) using Runge-Kutta (4th order):", predicted_y)
print("Error:", error)

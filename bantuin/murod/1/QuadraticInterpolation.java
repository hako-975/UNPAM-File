public class QuadraticInterpolation {
    public static void main(String[] args) {
        double[] x = {1, 2, 4};
        double[] y = {3, 8, 20};

        // Menentukan koefisien a, b, dan c
        double a, b, c;

        a = ((y[2] - y[0]) / ((x[2] - x[0]) * (x[2] - x[1])) - (y[1] - y[0]) / ((x[1] - x[0]) * (x[2] - x[1]))) / (x[2] - x[0]);
        b = ((y[1] - y[0]) / (x[1] - x[0])) - a * (x[0] + x[1]);
        c = y[0] - a * x[0] * x[0] - b * x[0];

        System.out.println("Polinomial kuadratik yang menginterpolasi data adalah:");
        System.out.println("p(x) = " + a + "x^2 + " + b + "x + " + c);

        // Estimasi nilai y pada x = 5
        double xValue = 5;
        double yValue = a * xValue * xValue + b * xValue + c;

        System.out.println("Estimasi nilai y pada x = 5 adalah: " + yValue);
    }
}

public class SecantMethod {
    public static void main(String[] args) {
        double x0 = 2.0;
        double x1 = 3.0;
        double epsilon = 0.0001; // Toleransi kesalahan
        int maxIterations = 100; // Maksimum iterasi

        double x = 0; // Hasil akar numerik

        for (int i = 0; i < maxIterations; i++) {
            double f0 = f(x0);
            double f1 = f(x1);

            // Menghitung x2 menggunakan metode tali busur
            x = x1 - (f1 * (x1 - x0)) / (f1 - f0);

            if (Math.abs(x - x1) < epsilon) {
                break; // Kondisi berhenti jika telah mencapai toleransi
            }

            x0 = x1;
            x1 = x;
        }

        System.out.println("Akar numerik dari f(x) = x^3 - 2x - 5 adalah x = " + x);
    }

    public static double f(double x) {
        return x * x * x - 2 * x - 5;
    }
}

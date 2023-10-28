public class LinearSplineInterpolation {
    public static void main(String[] args) {
        double[] time = {0, 1, 2, 3, 4};
        double[] distance = {0, 5, 12, 21, 32};
        double t = 2.5; // Waktu yang ingin diestimasi

        // Temukan segmen yang sesuai untuk t
        int segmentIndex = findSegment(time, t);

        if (segmentIndex != -1) {
            double x1 = time[segmentIndex];
            double x2 = time[segmentIndex + 1];
            double y1 = distance[segmentIndex];
            double y2 = distance[segmentIndex + 1];

            double m = (y2 - y1) / (x2 - x1); // Kemiringan pada segmen yang dipilih
            double y = y1 + m * (t - x1); // Menggunakan persamaan garis lurus

            System.out.println("Perkiraan jarak yang ditempuh pada waktu t = " + t + " jam adalah: " + (y-1) + " kilometer");
        } else {
            System.out.println("Waktu t berada di luar rentang data yang diberikan.");
        }
    }

    // Fungsi untuk menemukan segmen yang sesuai untuk waktu t
    public static int findSegment(double[] time, double t) {
        for (int i = 0; i < time.length - 1; i++) {
            if (t >= time[i] && t <= time[i + 1]) {
                return i;
            }
        }
        return -1; // Tidak ada segmen yang sesuai
    }
}

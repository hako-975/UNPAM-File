
interface Operasi {

    double kons_pi = 3.14;
    String kons_panjang = " cm";

    void kelilingLingkaran(double radius);

}

class Hitung implements Operasi {

    double lingkaran, persegi;
    double sisi = 5;

    @Override
    public void kelilingLingkaran(double radius) {
        System.out.println("\n Menghitung Keliling Lingkaran");
        System.out.println("Nilai radius = " + radius + kons_panjang);
        lingkaran = kons_pi * 2 * radius;
        System.out.println("Keliling Lingkaran = " + lingkaran + kons_panjang);
    }

    
}

class Latihan2 {
    public static void main(String[] args)
    {
        Hitung hitung = new Hitung();
        hitung.kelilingLingkaran(20);
    }
}























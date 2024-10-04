using System;

class Manusia
{
    // Atribut
    String nama;
    int usia;

    // Method untuk menampilkan informasi manusia
    public void tampilkanInformasi()
    {
        Console.WriteLine("Nama: " + nama);
        Console.WriteLine("Usia: " + usia + " tahun");
    }

    public static void Main(string[] args)
    {
        // Membuat objek manusia1
        Manusia manusia1 = new Manusia();
        manusia1.nama = "Ali";
        manusia1.usia = 30;

        // Menampilkan informasi manusia1
        Console.WriteLine("Informasi Manusia 1:");
        manusia1.tampilkanInformasi();

        // Membuat objek manusia2
        Manusia manusia2 = new Manusia();
        manusia2.nama = "Budi";
        manusia2.usia = 25;

        // Menampilkan informasi manusia2
        Console.WriteLine("\nInformasi Manusia 2:");
        manusia2.tampilkanInformasi();
    }
}

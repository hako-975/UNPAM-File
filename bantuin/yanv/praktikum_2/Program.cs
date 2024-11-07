using System;

class Program
{
    static void Main(string[] args)
    {
		// Soal 1
        // Meminta input panjang dari user
        Console.Write("Masukkan panjang: ");
        double length = Convert.ToDouble(Console.ReadLine());

        // Meminta input lebar dari user
        Console.Write("Masukkan lebar: ");
        double width = Convert.ToDouble(Console.ReadLine());

        // Membuat objek Rectangle dengan input dari user
        Rectangle rectangle = new Rectangle(length, width);

        // Menampilkan panjang, lebar, luas, dan keliling
        Console.WriteLine("\nPanjang: " + rectangle.Length);
        Console.WriteLine("Lebar: " + rectangle.Width);
        Console.WriteLine("Luas: " + rectangle.HitungLuas());
        Console.WriteLine("Keliling: " + rectangle.HitungKeliling());

		// Soal 2
		// Input untuk Student pertama
        Console.WriteLine("Masukkan informasi untuk Siswa Pertama:");
        Console.Write("Nama: ");
        string name1 = Console.ReadLine();

        Console.Write("Umur: ");
        int age1 = Convert.ToInt32(Console.ReadLine());

        Console.Write("Nilai: ");
        double grade1 = Convert.ToDouble(Console.ReadLine());

        // Membuat objek Student pertama dengan input user
        Student student1 = new Student(name1, age1, grade1);

        // Input untuk Student kedua
        Console.WriteLine("\nMasukkan informasi untuk Siswa Kedua:");
        Console.Write("Nama: ");
        string name2 = Console.ReadLine();

        Console.Write("Umur: ");
        int age2 = Convert.ToInt32(Console.ReadLine());

        Console.Write("Nilai: ");
        double grade2 = Convert.ToDouble(Console.ReadLine());

        // Membuat objek Student kedua dengan input user
        Student student2 = new Student(name2, age2, grade2);

        // Menampilkan informasi untuk kedua siswa
        Console.WriteLine("\nInformasi Siswa Pertama:");
        student1.DisplayInfo();

        Console.WriteLine("Informasi Siswa Kedua:");
        student2.DisplayInfo();
    }
}

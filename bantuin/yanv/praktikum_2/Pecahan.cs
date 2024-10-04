using System;

class Pecahan
{
    public int pembilang, penyebut; // atribut

    // Getter untuk pembilang
    public int getpembilang()
    {
        return pembilang;
    }

    // Getter untuk penyebut
    public int getpenyebut()
    {
        return penyebut;
    }

    // Konstruktor untuk inisialisasi pembilang dan penyebut
    Pecahan(int pembilang, int penyebut)
    {
        this.pembilang = pembilang;
        this.penyebut = penyebut;
    }

    // Method untuk menambah dua pecahan
    public Pecahan tambah(Pecahan p)
    {
        // Pecahan hasil penambahan
        Pecahan d2 = new Pecahan(5, 6); // Objek 2

        // Menampilkan pecahan objek 2
        Console.Write("objek2 : ");
        Console.Write(d2.getpembilang());
        Console.Write("/");
        Console.WriteLine(d2.getpenyebut());

        // Menambahkan pecahan p dan d2
        p.penyebut = p.penyebut * d2.penyebut;
        p.pembilang = (p.pembilang * d2.penyebut) + (p.penyebut / d2.penyebut) * d2.pembilang;
        return p;
    }

    public static void Main(string[] args)
    {
        // Membuat objek 1 dengan pecahan 3/2
        Pecahan d1 = new Pecahan(3, 2);
        Console.Write("objek1 : ");
        Console.Write(d1.getpembilang());
        Console.Write("/");
        Console.WriteLine(d1.getpenyebut());

        // Menambah objek 1 dengan objek 2
        Pecahan p = d1.tambah(d1);

        // Menampilkan hasil penambahan
        int x = p.getpembilang();
        int y = p.getpenyebut();
        Console.Write("hasil : " + x);
        Console.Write("/");
        Console.WriteLine(y);
    }
}

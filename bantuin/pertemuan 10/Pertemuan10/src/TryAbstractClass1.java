/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author andri
 */
abstract class Hewan {
    String nama;
    public abstract void habitatHewan();
    public void namaHewan()
    {
        System.out.println("\n Method di dalam abstract class Hewan");
        System.out.println("Nama Hewan: " + nama);
    }
}

class Karnivora extends Hewan {
    String habitat;
    @Override
    public void habitatHewan() {
        System.out.println("\n Method di dalam class Karnivora");
        System.out.println("Habitat hewan: " + habitat);
    }
}

public class TryAbstractClass1 {
    public static void main(String[] args)
    {
        System.out.println("\n***************************************************************");
        System.out.println("\n\tMenerapkan Penggunaan Abstract Class #1");
        System.out.println("\n***************************************************************");
        
        Karnivora singa = new Karnivora();
        singa.nama = "Singa";
        singa.habitat = "Darat";
        singa.namaHewan();
        singa.habitatHewan();
    }
}
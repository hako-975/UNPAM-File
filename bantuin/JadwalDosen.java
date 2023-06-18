/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pkg04tplp005_churul_ain_yahya_uts;

/**
 *
 * @author USER
 */
import java.util.Scanner;

public class JadwalDosen {

    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);
        String[] dosen = new String[5];
        String[] mataKuliah = new String[5];
        int[] jamMulai = new int[5];
        int[] jamSelesai = new int[5];

        boolean isRunning = true;
        while (isRunning) {
            System.out.println("\n==== MENU UTAMA ====");
            System.out.println("1. Input Data");
            System.out.println("2. Edit atau Hapus Data");
            System.out.println("3. Menampilkan Data");
            System.out.println("4. Keluar");
            System.out.print("Pilih menu (1-4): ");
            int choice = input.nextInt();

            switch (choice) {
                case 1 ->
                    inputData(input, dosen, mataKuliah, jamMulai, jamSelesai);
                case 2 ->
                    editData(input, dosen, mataKuliah, jamMulai, jamSelesai);
                case 3 ->
                    tampilkanData(dosen, mataKuliah, jamMulai, jamSelesai);
                case 4 -> {
                    isRunning = false;
                    System.out.println("Terima kasih!");
                }
                default ->
                    System.out.println("Pilihan tidak valid!");
            }
        }
    }

    public static void inputData(Scanner input, String[] dosen, String[] mataKuliah, float[] jamMulai, float[] jamSelesai) {
        System.out.println("\n==== INPUT DATA ====");
        for (int i = 0; i < 5; i++) {
            System.out.println("Data ke-" + (i + 1));
            System.out.print("Nama Dosen: ");
            dosen[i] = input.nextLine();

            System.out.print("Mata Kuliah: ");
            mataKuliah[i] = input.nextLine();

            System.out.print("Jam Mulai: ");
            jamMulai[i] = input.nextFloat();

            System.out.print("Jam Selesai: ");
            jamSelesai[i] = input.nextFloat();

            input.nextLine();
        }
        System.out.println("Data berhasil diinput!");
    }

    public static void editData(Scanner input, String[] dosen, String[] mataKuliah, float[] jamMulai, float[] jamSelesai) {
        System.out.println("\n==== EDIT/HAPUS DATA ====");
        System.out.print("Masukkan nomor data yang akan diubah/hapus (1-5): ");
        int index = input.nextInt() - 1;

        if (index >= 0 && index < 5) {
            System.out.println("Data saat ini:");
            System.out.println("Nama Dosen: " + dosen[index]);
            System.out.println("Mata Kuliah: " + mataKuliah[index]);
            System.out.println("Jam Mulai: " + jamMulai[index]);
            System.out.println("Jam Selesai: " + jamSelesai[index]);

            System.out.print("Apakah data ingin diubah (y/n)? ");
            char choice = input.next().charAt(0);

            switch (choice) {
                case 'y' -> {
                    System.out.print("Nama Dosen: ");
                    dosen[index] = input.nextLine();
                    System.out.print("Mata Kuliah: ");
                    mataKuliah[index] = input.nextLine();
                    System.out.print("Jam Mulai: ");
                    jamMulai[index] = input.nextFloat();
                    System.out.print("Jam Selesai: ");
                    jamSelesai[index] = input.nextFloat();
                    System.out.println("Data berhasil diubah!");
                }
                case 'n' -> {
                    System.out.print("Apakah data ingin dihapus (y/n)? ");
                    choice = input.next().charAt(0);
                    if (choice == 'y') {
                        dosen[index] = null;
                        mataKuliah[index] = null;
                        jamMulai[index] = 0;
                        jamSelesai[index] = 0;
                        System.out.println("Data berhasil dihapus!");
                    } else if (choice == 'n') {
                        System.out.println("Pilihan tidak valid!");
                    }
                }
                default ->
                    System.out.println("Pilihan tidak valid!");
            }
        } else {
            System.out.println("Nomor data tidak valid!");
        }
    }

    private static void tampilkanData(String[] dosen, String[] mataKuliah, float[] jamMulai, float[] jamSelesai) {
        System.out.println("Daftar Jadwal Dosen Mengajar");
        System.out.println("=============================");
        for (int i = 0; i < dosen.length; i++) {
            System.out.println("Dosen : " + dosen[i]);
            System.out.println("Mata Kuliah : " + mataKuliah[i]);
            System.out.println("Jam Mengajar : " + jamMulai[i] + ".00 - " + jamSelesai[i] + ".00");
            System.out.println("=============================");
        }
    }
}

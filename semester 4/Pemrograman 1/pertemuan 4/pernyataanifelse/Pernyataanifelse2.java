/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.io.*;

/**
 *
 * @author andri
 */
public class Pernyataanifelse2 {
    public static void main(String[] args) {
        BufferedReader dataIn = new BufferedReader(new InputStreamReader(System.in));
        
        String gradeString = "";
        byte grade = 0;
        
        System.out.print("Ketik Nilai Anda: ");
        try {
            gradeString = dataIn.readLine();
        }
        catch (IOException e) {
            System.out.println("Ada kesalahan!");
        }
        
        grade = new Byte(gradeString);
        
        if (grade >= 80) {
            System.out.println("Selamat Anda Lulus!");
            System.out.println("Karena nilai Anda " + grade + "!");
        } else {
            System.out.println("Maaf Anda Belum Lulus!");
            System.out.println("Karena nilai Anda "  + grade + "!");
        }
    }
}

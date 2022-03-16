/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
import java.io.*; 

/**
 *
 * @author andri
 */
public class PernyataanIfElseIf {
    public static void main(String[] args) {
        BufferedReader dataIn = new BufferedReader(new InputStreamReader(System.in));
        String gradeString = "";
        byte grade = 0;
        
        System.out.print("Ketik nilai Anda : "); 
        try{
            gradeString = dataIn.readLine();
        }
        catch( IOException e ){
            System.out.println("Ada kesalahan !");
        } 
        
        //  konversi nilai string ke byte
        grade = new Byte(gradeString);
        
        if (grade == 100) {
            System.out.println("Selamat Anda Lulus dengan Katagori Sempurna!");
        }
        else if (grade >= 95) {
            System.out.println("Selamat Anda Lulus dengan Katagori sangat Memuaskan!");
        }
        else if (grade >= 90) {
            System.out.println("Selamat Anda Lulus dengan Katagori Memuaskan!");
        }
        else if (grade >= 80) {
            System.out.println("Selamat Anda Lulus dengan Katagori Baik!");
        }
        else {
            System.out.println("Maaf Anda belum Lulus!");
        }
        
        System.out.println("Karena nilai Anda " + grade + "!");
    }
}

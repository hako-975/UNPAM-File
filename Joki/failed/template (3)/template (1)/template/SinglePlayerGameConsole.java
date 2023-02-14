import java.util.Scanner;

/**
 * Class ini mengimplementasikan interaksi berbasis teks untuk permainan
 * battleship dan satu pemain.
 */
public class SinglePlayerGameConsole
{

    Board board;


    public SinglePlayerGameConsole ()
    {
        board = new Board ();
    }


    public void play ()
    {

        Scanner scanIn = new Scanner (System.in);

        // TODO: ubahlah bagian ini supaya user bisa memberikan lokasi kapal
        // secara interaktif untuk 5 buah kapal yang panjangnya 5,4,3,3,2
        // Jika posisi kapal yang diberikan overlap, tanyakan kembali posisi
        // kapal yang sama.
        // Implementasi di bawah ini memberikan koordinat secara hard coded.
        board.placeShip (5, 0, 0, true);
        board.placeShip (4, 2, 1, false);
        board.placeShip (3, 4, 3, true);
        board.placeShip (3, 7, 3, true);
        board.placeShip (2, 8, 7, true);

        // mencetak kondisi board awal dan menunjukkan kapal.
        // diperlukan hanya untuk memastikan posisi kapal sudah benar.
        board.printBoard (false);

        // mencetak kondisi board awal dan menyembunyikan kapal
        board.printBoard (true);

        // mencatat berapa langkah yang dibutuhkan untuk melumpuhkan semua kapal
        // musuh
        int counter = 0;

        // selama belum semua karam dan masih ingin bermain
        boolean quit = false;
        while (!quit && !board.isAllShipSunk ()) {
            System.out.print ("Berikan koordinat (misalnya J10, A1, E5, quit): ");
            String coord = scanIn.nextLine ();

            if ("quit".equalsIgnoreCase (coord)) {
                quit = true;

            } else {
                boolean isHit = board.hit (coord);
                if (isHit) {
                    System.out.println ("\nTembakan anda mengenai kapal\n");
                } else {
                    System.out.println ("\nTembakan anda luput\n");
                }

                board.printBoard (true);
                counter++;
            }
        }
        // post-condition: quit || board.isAllShipSunk ()

        if (quit) {
            System.out.printf ("Berhenti bermain setelah %d langkah.", counter);

        } else {
            System.out
                    .printf (
                            "\nSelamat!\nAnda telah melumpuhkan semua kapal musuh dalam %d langkah.",
                            counter);
        }

        scanIn.close ();
    }


    public static void main (String[] args)
    {
        SinglePlayerGameConsole game = new SinglePlayerGameConsole ();
        game.play ();
    }

}

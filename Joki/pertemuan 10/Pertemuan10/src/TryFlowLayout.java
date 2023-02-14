
import javax.swing.*;
import java.awt.*;

public class TryFlowLayout extends JFrame {

    public TryFlowLayout() {
        super("MENGGUNAKAN FLOW LAYOUT");
        setSize(500, 250);

        JPanel p1 = new JPanel();
        p1.setLayout(new FlowLayout());

        // Meletakkan button pada panel
        p1.add(new JButton("Tombol A"));
        p1.add(new JButton("Tombol B"));
        p1.add(new JButton("Tombol C"));

        JPanel p2 = new JPanel();
        p2.setLayout(new FlowLayout(FlowLayout.LEFT, 30, 20));

        // Meletakkan button pada panel
        p2.add(new JButton("Tombol J"));
        p2.add(new JButton("Tombol K"));

        JPanel p3 = new JPanel();
        p3.setLayout(new FlowLayout(FlowLayout.RIGHT, 40, 50));

        // Meletakkan button pada panel
        p3.add(new JButton("Tombol X"));
        p3.add(new JButton("Tombol Y"));
        p3.add(new JButton("Tombol Z"));

        // Meletakkan dan mengatur posisi panel pada frame
        add("North", p1);
        add("Center", p2);
        add("South", p3);

        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    public static void main(String[] args) {
        TryFlowLayout frame = new TryFlowLayout();
    }

}

import javax.swing.*;
import java.awt.event.*;

public class TryRadioButton extends JFrame implements ActionListener {
    // Membuat objek yang akan digunakan
    private JRadioButton rb1, rb2, rb3;
    private ButtonGroup bg;
    private JTextArea tArea;
    
    public TryRadioButton()
    {
        super("MENGGUNAKAN RADIO BUTTON");
        setSize(400, 150);
        
        // Menugaskan objek yang dibuat dari class JRadioButton
        rb1 = new JRadioButton("SATU", false);
        rb2 = new JRadioButton("DUA", false);
        rb3 = new JRadioButton("TIGA", false);
        
        // Membuat hanya bisa memilih satu radio button
        bg = new ButtonGroup();
        bg.add(rb1);
        bg.add(rb2);
        bg.add(rb3);
        
        tArea = new JTextArea(3, 20);
        tArea.setEditable(false);
        
        JPanel p1 = new JPanel();
        p1.add(rb1);
        p1.add(rb2);
        p1.add(rb3);
        
        JPanel p2 = new JPanel();
        p2.add(tArea);
        
        add("North", p1);
        add("South", p2);
        
        // Memberikan mekanisme event handling pada radio button
        rb1.addActionListener(this);
        rb2.addActionListener(this);
        rb3.addActionListener(this);
        
        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    
    // Method untuk memberikan aksi bila radio button dipilih
    public void actionPerformed(ActionEvent e)
    {
        tArea.setText("Pilihan Anda: " + e.getActionCommand());
    }
    
    public static void main(String[] args)
    {
        TryRadioButton frame = new TryRadioButton();
    }
}














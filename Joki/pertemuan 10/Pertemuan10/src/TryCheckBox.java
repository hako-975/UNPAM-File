import javax.swing.*;
import java.awt.event.*;

public class TryCheckBox extends JFrame implements ActionListener {
    // Membuat objek yang akan digunakan 
    private JCheckBox cb1, cb2, cb3;
    private JTextArea tArea;
    
    public TryCheckBox()
    {
        super("MENGGUNAKAN CHECK BOX");
        setSize(400, 150);
        
        // Menugaskan Objek yang dibuat dari class JCheckBox
        cb1 = new JCheckBox("SATU", false);
        cb2 = new JCheckBox("DUA", false);
        cb3 = new JCheckBox("TIGA", false);
        
        tArea = new JTextArea(3, 20);
        tArea.setEditable(false);
        
        JPanel p1 = new JPanel();
        p1.add(cb1);
        p1.add(cb2);
        p1.add(cb3);
        
        JPanel p2 = new JPanel();
        p2.add(tArea);
        
        add("North", p1);
        add("South", p2);
        
        // Memberikan mekanisme event handling pada check box
        cb1.addActionListener(this);
        cb2.addActionListener(this);
        cb3.addActionListener(this);
        
        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    
    // Method untuk menampilkan status check box
    public void tampilkanInfo()
    {
        String sCB1, sCB2, sCB3;
        sCB1 = "Status SATU : " + cb1.isSelected();
        sCB2 = "\n Status DUA : " + cb2.isSelected();
        sCB3 = "\n Status TIGA : " + cb3.isSelected();
        
        tArea.setText(sCB1 + sCB2 + sCB3);
    }
    
    // Method untuk memberikan aksi bila status check box berubah
    @Override
    public void actionPerformed(ActionEvent e) {
        tampilkanInfo(); // Memanggil method tampilkanInfo()
    }

    public static void main(String[] args) {
        TryCheckBox frame = new TryCheckBox();
    }
}

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package view;

import javax.swing.JOptionPane;

/**
 *
 * @author 4R135
 */
public class PesanDialog {
    
    public int tampilkanPilihan(String pesan, String judul, Object[] opsiPilihan){        
        return JOptionPane.showOptionDialog(null, pesan, judul, JOptionPane.YES_NO_OPTION,JOptionPane.QUESTION_MESSAGE, null, opsiPilihan, opsiPilihan[0]);
    }
    
}

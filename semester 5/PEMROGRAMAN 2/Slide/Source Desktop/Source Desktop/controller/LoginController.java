/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package controller;

import javax.swing.JOptionPane;
import model.Enkripsi;
import model.Mahasiswa;
import model.StafTU;
import view.FormLogin;

/**
 *
 * @author Aries Saifudin
 */
public class LoginController {
    private final StafTU stafTU = new StafTU();
    private final Mahasiswa mahasiswa = new Mahasiswa();
    private final Enkripsi enkripsi = new Enkripsi();
    
    public boolean validasi(javax.swing.JTextField userIdTextField, javax.swing.JPasswordField passwordField){
        boolean valid = false, userIdSalah=false;
        String hashedInputPassword = "";
        
        if (!userIdTextField.getText().equals("")){
            if (stafTU.baca(userIdTextField.getText())){
                try {
                    hashedInputPassword = enkripsi.hashMD5(new String(passwordField.getPassword()));
                } catch (Exception ex){}
                
                if (stafTU.getPassword().equalsIgnoreCase(hashedInputPassword)){
                    valid = true;
                    FormLogin.tipe = "StafTU";
                } else {
                    userIdSalah = true;
                }
            } else {
                if (stafTU.getPesan().substring(0, 3).equalsIgnoreCase("Kode")){
                    userIdSalah = true;
                }
            }
            
            if (!valid){
                if (mahasiswa.baca(userIdTextField.getText())){
                    try {
                        hashedInputPassword = enkripsi.hashMD5(new String(passwordField.getPassword()));
                    } catch (Exception ex){}
                    
                    if (mahasiswa.getPassword().equalsIgnoreCase(hashedInputPassword)){
                        valid = true;
                        FormLogin.tipe = "Mahasiswa";
                    } else {
                        userIdSalah = true;
                    }
                } else {
                    if (mahasiswa.getPesan().substring(0, 3).equalsIgnoreCase("NIM")){
                        userIdSalah = true;
                    }
                }
                
                if (!valid){
                    if (userIdSalah){
                        JOptionPane.showMessageDialog(null, "User Id atau password salah", "Kesalahan", JOptionPane.ERROR_MESSAGE);
                    } else {
                        JOptionPane.showMessageDialog(null, mahasiswa.getPesan(), "Kesalahan", JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        } else {
            JOptionPane.showMessageDialog(null, "User Id (NIM) tidak boleh kosong", "Kesalahan", JOptionPane.ERROR_MESSAGE);
        }
        
        return valid;
    }
}

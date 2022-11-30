/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import javax.swing.JOptionPane;
import model.Enkripsi;
import model.Mahasiswa;
import view.FormLihatMahasiswa;
import view.FormUtama;

/**
 *
 * @author 4R135
 */
public class MahasiswaController {
    private final Mahasiswa mahasiswa = new Mahasiswa();
    private FormLihatMahasiswa formLihatMahasiswa;
    private final Enkripsi enkripsi = new Enkripsi();
    private boolean hashed = false;

    public void setHashed(boolean hashed) {
        this.hashed = hashed;
    }
    
    public void simpan(javax.swing.JTextField nimTextField, javax.swing.JTextField namaTextField,
            javax.swing.JComboBox semesterComboBox, javax.swing.JComboBox kelasComboBox, javax.swing.JPasswordField passwordField){
        if (!nimTextField.getText().equals("")){
            mahasiswa.setNim(nimTextField.getText());
            mahasiswa.setNama(namaTextField.getText());
            mahasiswa.setSemester(Integer.parseInt(semesterComboBox.getSelectedItem().toString()));
            mahasiswa.setKelas(kelasComboBox.getSelectedItem().toString());
            
            if (hashed){
                mahasiswa.setPassword(new String(passwordField.getPassword()));
            } else {
                try {
                    mahasiswa.setPassword(enkripsi.hashMD5(new String(passwordField.getPassword())));
                } catch (Exception ex){
                    mahasiswa.setPassword("");
                }
            }
            
            if (mahasiswa.simpan()){
                FormUtama.formMahasiswa.setNim("");
                FormUtama.formMahasiswa.setNama("");
                FormUtama.formMahasiswa.setSemester(1);
                FormUtama.formMahasiswa.setKelas("A");
                FormUtama.formMahasiswa.setPassword("");
            }  else {
                if (mahasiswa.getPesan().length() > 0){
                    JOptionPane.showMessageDialog(null, mahasiswa.getPesan(), "Kesalahan", JOptionPane.ERROR_MESSAGE);
                }
            }
        } else {
            JOptionPane.showMessageDialog(null, "NIM tidak boleh kosong", "Kesalahan", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void hapus(javax.swing.JTextField nimTextField){
        if (!nimTextField.getText().equals("")){
            if (mahasiswa.hapus(nimTextField.getText())){
                FormUtama.formMahasiswa.setNim("");
                FormUtama.formMahasiswa.setNama("");
                FormUtama.formMahasiswa.setSemester(1);
                FormUtama.formMahasiswa.setKelas("A");
                FormUtama.formMahasiswa.setPassword("");
            }else {
                JOptionPane.showMessageDialog(null, mahasiswa.getPesan(), "Kesalahan", JOptionPane.ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null, "NIM tidak boleh kosong", "Kesalahan", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void cari(javax.swing.JTextField nimTextField){
        if (!nimTextField.getText().equals("")){
            if (mahasiswa.baca(nimTextField.getText())){
                FormUtama.formMahasiswa.setNama(mahasiswa.getNama());
                FormUtama.formMahasiswa.setSemester(mahasiswa.getSemester());
                FormUtama.formMahasiswa.setKelas(mahasiswa.getKelas());
                FormUtama.formMahasiswa.setPassword(mahasiswa.getPassword());
                hashed = true;
            } else {
                FormUtama.formMahasiswa.setNama("");
                FormUtama.formMahasiswa.setSemester(1);
                FormUtama.formMahasiswa.setKelas("A");
                FormUtama.formMahasiswa.setPassword("");
                
                JOptionPane.showMessageDialog(null, mahasiswa.getPesan(), "Kesalahan", JOptionPane.ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null, "NIM tidak boleh kosong", "Kesalahan", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void tampilkanFormLihatMahasiswa(){
        formLihatMahasiswa = new FormLihatMahasiswa(null,true);
        
        if (mahasiswa.bacaData()){
            formLihatMahasiswa.tampilkanData(mahasiswa.getList());
            
            formLihatMahasiswa.setVisible(true);
            if (!formLihatMahasiswa.getNimDipilih().equals("")){
                FormUtama.formMahasiswa.setNim(formLihatMahasiswa.getNimDipilih());
                if (mahasiswa.baca(formLihatMahasiswa.getNimDipilih())){
                    FormUtama.formMahasiswa.setNama(mahasiswa.getNama());
                    FormUtama.formMahasiswa.setSemester(mahasiswa.getSemester());
                    FormUtama.formMahasiswa.setKelas(mahasiswa.getKelas());
                    FormUtama.formMahasiswa.setPassword(mahasiswa.getPassword());
                    hashed = true;
                } else {
                    FormUtama.formMahasiswa.setNama("");
                    FormUtama.formMahasiswa.setSemester(1);
                    FormUtama.formMahasiswa.setKelas("A");
                    FormUtama.formMahasiswa.setPassword("");
                }
            }
        } else {
            JOptionPane.showMessageDialog(null, mahasiswa.getPesan());
        }
    }
}

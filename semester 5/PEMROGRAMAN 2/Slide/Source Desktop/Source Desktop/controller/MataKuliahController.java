/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import javax.swing.JOptionPane;
import model.MataKuliah;
import view.FormLihatMataKuliah;
import view.FormUtama;

/**
 *
 * @author 4R135
 */
public class MataKuliahController {
    private final MataKuliah mataKuliah = new MataKuliah();
    private FormLihatMataKuliah formLihatMataKuliah;
    
    public void simpan(javax.swing.JTextField kodeMataKuliahTextField, 
            javax.swing.JTextField namaMataKuliahTextField,
            javax.swing.JComboBox jumlahSksComboBox){
        if (!kodeMataKuliahTextField.getText().equals("")){
            mataKuliah.setKodeMataKuliah(kodeMataKuliahTextField.getText());
            mataKuliah.setNamaMataKuliah(namaMataKuliahTextField.getText());
            mataKuliah.setJumlahSks(Integer.parseInt(
                    jumlahSksComboBox.getSelectedItem().toString()));
            
            if (mataKuliah.simpan()){
                FormUtama.formMataKuliah.setKodeMataKuliah("");
                FormUtama.formMataKuliah.setNamaMataKuliah("");
                FormUtama.formMataKuliah.setJumlahSks(1);
            }  else {
                if (mataKuliah.getPesan().length() > 0){
                    JOptionPane.showMessageDialog(null, mataKuliah.getPesan(), "Kesalahan", JOptionPane.ERROR_MESSAGE);
                }
            }
        } else {
            JOptionPane.showMessageDialog(null, "Kode mata kuliah tidak boleh kosong", "Kesalahan", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void hapus(javax.swing.JTextField kodeMataKuliahTextField){
        if (!kodeMataKuliahTextField.getText().equals("")){
            if (mataKuliah.hapus(kodeMataKuliahTextField.getText())){
                FormUtama.formMataKuliah.setKodeMataKuliah("");
                FormUtama.formMataKuliah.setNamaMataKuliah("");
                FormUtama.formMataKuliah.setJumlahSks(1);
            }  else {
                JOptionPane.showMessageDialog(null, mataKuliah.getPesan(), "Kesalahan", JOptionPane.ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null, "Kode mata kuliah tidak boleh kosong", "Kesalahan", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void cari(javax.swing.JTextField kodeMataKuliahTextField){
        if (!kodeMataKuliahTextField.getText().equals("")){
            if (mataKuliah.baca(kodeMataKuliahTextField.getText())){
                FormUtama.formMataKuliah.setNamaMataKuliah(mataKuliah.getNamaMataKuliah());
                FormUtama.formMataKuliah.setJumlahSks(mataKuliah.getJumlahSks());
            } else {
                FormUtama.formMataKuliah.setNamaMataKuliah("");
                FormUtama.formMataKuliah.setJumlahSks(1);
                
                JOptionPane.showMessageDialog(null, mataKuliah.getPesan(), "Kesalahan", JOptionPane.ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null, "Kode mata kuliah tidak boleh kosong", "Kesalahan", JOptionPane.ERROR_MESSAGE);
        }
    }
    
    public void tampilkanDaftar(){
        formLihatMataKuliah = new FormLihatMataKuliah(null,true);
        if (mataKuliah.bacaData()){
            formLihatMataKuliah.tampilkanData(mataKuliah.getList());
            
            formLihatMataKuliah.setVisible(true);
            if (!formLihatMataKuliah.getKodeMataKuliahDipilih().equals("")){
                FormUtama.formMataKuliah.setKodeMataKuliah(formLihatMataKuliah.getKodeMataKuliahDipilih());
                if (mataKuliah.baca(formLihatMataKuliah.getKodeMataKuliahDipilih())){
                    FormUtama.formMataKuliah.setNamaMataKuliah(mataKuliah.getNamaMataKuliah());
                    FormUtama.formMataKuliah.setJumlahSks(mataKuliah.getJumlahSks());
                } else {
                    FormUtama.formMataKuliah.setNamaMataKuliah("");
                    FormUtama.formMataKuliah.setJumlahSks(1);
                }
            }
        }  else {
            JOptionPane.showMessageDialog(null, mataKuliah.getPesan());
        }
    }
}

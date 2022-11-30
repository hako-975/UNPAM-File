/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import javax.swing.JOptionPane;
import model.Mahasiswa;
import model.MataKuliah;
import model.Nilai;
import view.FormLihatMahasiswa;
import view.FormLihatMataKuliah;
import view.FormUtama;

/**
 *
 * @author 4R135
 */
public class NilaiController {
    private final Mahasiswa mahasiswa = new Mahasiswa();
    private final MataKuliah mataKuliah = new MataKuliah();
    private final Nilai nilai = new Nilai();
    private FormLihatMahasiswa formLihatMahasiswa;
    private FormLihatMataKuliah formLihatMataKuliah;
    
    public void cariMahasiswa(javax.swing.JTextField nim){
        if (!nim.getText().equals("")){
            if (mahasiswa.baca(nim.getText())){
                FormUtama.formNilai.setNama(mahasiswa.getNama());
                FormUtama.formNilai.setSemester( Integer.toString( mahasiswa.getSemester()));
                FormUtama.formNilai.setKelas(mahasiswa.getKelas());
                FormUtama.formNilai.clearNilaiTable();
                
                int jumlahNilai=0;
                if (nilai.baca(nim.getText())){
                    Object[][] listNilai = nilai.getListNilai();
                    FormUtama.formNilai.clearNilaiTable();
                    
                    if (listNilai.length>0){
                        for (int i=0; i<listNilai.length;i++){
                            if (!((String)listNilai[i][0]).equals("")){
                                String namaMataKuliah="";
                                if (mataKuliah.baca((String) listNilai[i][0])){
                                    namaMataKuliah = mataKuliah.getNamaMataKuliah();                      
                                }
                                FormUtama.formNilai.setTambahNilai(new Object[]{listNilai[i][0],namaMataKuliah,listNilai[i][1],listNilai[i][2],listNilai[i][3]});
                                jumlahNilai++;
                            }
                        }
                    }
                } 
                
                if (jumlahNilai==0) {
                    FormUtama.formNilai.setTambahNilai(new Object[]{});
                }
            } else {
                FormUtama.formNilai.setNama("");
                FormUtama.formNilai.setSemester("");
                FormUtama.formNilai.setKelas("");
                FormUtama.formNilai.clearNilaiTable();
                FormUtama.formNilai.setTambahNilai(new Object[]{});
                
                JOptionPane.showMessageDialog(null, mahasiswa.getPesan(), "Kesalahan", JOptionPane.ERROR_MESSAGE);
            }
        } else {
            JOptionPane.showMessageDialog(null,"nim tidak boleh kosong\n","Kesalahan",JOptionPane.ERROR_MESSAGE);
        } 
    }
    
    public void tampilkanFormLihatMahasiswa(){
        formLihatMahasiswa = new FormLihatMahasiswa(null, true);
        if (mahasiswa.bacaData()){
            formLihatMahasiswa.tampilkanData(mahasiswa.getList());
            formLihatMahasiswa.setVisible(true);
            
            if (!formLihatMahasiswa.getNimDipilih().equals("")) {
                if (mahasiswa.baca(formLihatMahasiswa.getNimDipilih())){
                    FormUtama.formNilai.setNim(mahasiswa.getNim());
                    FormUtama.formNilai.setNama(mahasiswa.getNama());
                    FormUtama.formNilai.setSemester( Integer.toString( mahasiswa.getSemester()));
                    FormUtama.formNilai.setKelas(mahasiswa.getKelas());
                    FormUtama.formNilai.clearNilaiTable();
                    
                    int jumlahNilai=0;
                    if (nilai.baca(formLihatMahasiswa.getNimDipilih())){
                        Object[][] listNilai = nilai.getListNilai();
                        FormUtama.formNilai.clearNilaiTable();
                        
                        if (listNilai.length>0){
                            for (int i=0; i<listNilai.length;i++){
                                if (!((String)listNilai[i][0]).equals("")){
                                    String namaMataKuliah="";
                                    if (mataKuliah.baca((String)listNilai[i][0])){
                                        namaMataKuliah = mataKuliah.getNamaMataKuliah();
                                    }
                                    FormUtama.formNilai.setTambahNilai(new Object[]{listNilai[i][0],namaMataKuliah,listNilai[i][1],listNilai[i][2],listNilai[i][3]});
                                    jumlahNilai++;
                                }
                            }
                        }
                    }
                    
                    if (jumlahNilai==0) {
                        FormUtama.formNilai.setTambahNilai(new Object[]{});
                    }
                }  else {
                    JOptionPane.showMessageDialog(null, mahasiswa.getPesan());
                }
            }
        } else {
            JOptionPane.showMessageDialog(null, mahasiswa.getPesan());
        }
    }
    
    public void tampilkanFormLihatMataKuliah(){
        formLihatMataKuliah = new FormLihatMataKuliah(null,true);
        if (mataKuliah.bacaData()){
            formLihatMataKuliah.tampilkanData(mataKuliah.getList());
            
            formLihatMataKuliah.setVisible(true);
            if (!formLihatMataKuliah.getKodeMataKuliahDipilih().equals("")){
                
                if (mataKuliah.baca(formLihatMataKuliah.getKodeMataKuliahDipilih())){
                    FormUtama.formNilai.setTambahNilai(new Object[]{mataKuliah.getKodeMataKuliah(),mataKuliah.getNamaMataKuliah(),"","",""});
                } else {
                    FormUtama.formNilai.setTambahNilai(new Object[]{formLihatMataKuliah.getKodeMataKuliahDipilih(),"","","",""});
                }
            }
        }  else {
            JOptionPane.showMessageDialog(null, mataKuliah.getPesan());
        }
    }
    
    public void cariMataKuliah(String kodeMataKuliah){
        if (mataKuliah.baca(kodeMataKuliah)){
            FormUtama.formNilai.setNamaMataKuliah( mataKuliah.getNamaMataKuliah());                      
        } else {
            FormUtama.formNilai.setNamaMataKuliah("");        
            FormUtama.formNilai.hapusNilai();
            
            JOptionPane.showMessageDialog(null, mataKuliah.getPesan(), "Kesalahan", JOptionPane.ERROR_MESSAGE);
        }    
    }
    
    public void simpan(javax.swing.JTextField nim, javax.swing.JTable nilaiTable){
	if (!nim.getText().equals("")){
            nilai.setNim(nim.getText());
            Object[][] listNilai = new Object[nilaiTable.getRowCount()][4];
            
            for (int i=0; i <nilaiTable.getRowCount();i++){
                listNilai[i][0] = nilaiTable.getValueAt(i, 0);
                listNilai[i][1] = nilaiTable.getValueAt(i, 2);
                listNilai[i][2] = nilaiTable.getValueAt(i, 3);
                listNilai[i][3] = nilaiTable.getValueAt(i, 4);
            }
            
            nilai.setListNilai(listNilai);            
            
            if (nilai.simpan()){
                FormUtama.formNilai.setNim("");
                FormUtama.formNilai.setNama("");
                FormUtama.formNilai.setSemester("");
                FormUtama.formNilai.setKelas("");
                FormUtama.formNilai.clearNilaiTable();
                FormUtama.formNilai.setTambahNilai(new Object[]{});
            }  else {
                JOptionPane.showMessageDialog(null, nilai.getPesan());
            }
        } else {
            JOptionPane.showMessageDialog(null,"nim tidak boleh kosong\n","Kesalahan",JOptionPane.ERROR_MESSAGE);
        }
    }    
    
    public void cetakLaporan(javax.swing.JComboBox semesterComboBox,
            javax.swing.JComboBox kelasComboBox){
        int semester=0;
        String kelas="";
        
        if (semesterComboBox.getSelectedIndex()>0){
            semester = Integer.parseInt(semesterComboBox.getSelectedItem().toString());
        }
        
        if (kelasComboBox.getSelectedIndex()>0){
            kelas = kelasComboBox.getSelectedItem().toString();
        }
        
        if (!nilai.cetakLaporan(semester, kelas)) {
            JOptionPane.showMessageDialog(null,nilai.getPesan(),"Kesalahan",JOptionPane.ERROR_MESSAGE);
        }
    }
}

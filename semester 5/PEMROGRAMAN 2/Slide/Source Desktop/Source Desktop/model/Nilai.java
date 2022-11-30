/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;

/**
 *
 * @author 4R135
 */
public class Nilai {
    private String nim;
    private String pesan;
    private Object[][] listNilai;
    private final Koneksi koneksi = new Koneksi();

    public String getNim() {
        return nim;
    }

    public void setNim(String nim) {
        this.nim = nim;
    }

    public String getPesan() {
        return pesan;
    }

    public void setPesan(String pesan) {
        this.pesan = pesan;
    }

    public Object[][] getListNilai() {
        return listNilai;
    }

    public void setListNilai(Object[][] listNilai) {
        this.listNilai = listNilai;
    }
    
    public boolean simpan(){
        boolean adaKesalahan = false;	
	Connection connection; 
	
	if ((connection = koneksi.getConnection()) != null){
            int jumlahSimpan = 0;
            String SQLStatemen;
            PreparedStatement preparedStatement;
            
            try{
                SQLStatemen = "delete from tbnilai where nim=?"; 
                preparedStatement = connection.prepareStatement(SQLStatemen);
                preparedStatement.setString(1, nim);
                preparedStatement.executeUpdate();
            } catch (SQLException ex){}
            
            for (Object[] recNilai: listNilai){
                try {
                    SQLStatemen = "insert into tbnilai(nim, kodematakuliah, tugas, uts, uas) values (?,?,?,?,?)";
                    preparedStatement = connection.prepareStatement(SQLStatemen);
                    preparedStatement.setString(1, nim);
                    for (int i=0; i<4; i++){
                        preparedStatement.setString(2+i, recNilai[i].toString());
                    }
                    jumlahSimpan += preparedStatement.executeUpdate();
                } catch (SQLException ex){}
            }
            
            if (jumlahSimpan>0) {
                adaKesalahan = false;
            }
        } else {
            adaKesalahan = true;
            pesan = "Tidak dapat melakukan koneksi ke server\n"+koneksi.getPesanKesalahan();
        }
        
        return !adaKesalahan;
    }
    
    public boolean baca(String nim){
        boolean adaKesalahan = false;	
	Connection connection; 
        
	this.nim = nim;
	listNilai = null;
	
	if ((connection = koneksi.getConnection()) != null){
            String SQLStatemen;
            PreparedStatement preparedStatement;
            ResultSet rset;
            
            try {
                SQLStatemen = "select * from tbnilai where nim=?"; 
                preparedStatement = connection.prepareStatement(SQLStatemen);
                preparedStatement.setString(1, nim);
                rset = preparedStatement.executeQuery();
                
                rset.next();
                rset.last();
                listNilai = new Object[rset.getRow()][4];
                
                rset.first();
                int i=0;
                do {
                    if (!rset.getString("kodematakuliah").equals("")){
                        listNilai[i] = new Object[]{ rset.getString("kodematakuliah"), 
                            rset.getObject("tugas"), rset.getObject("uts"), rset.getObject("uas")}; 		    
                    }
                    i++;
                } while (rset.next());
                
                if (listNilai.length > 0) {
                    adaKesalahan = false;
                }
                
                preparedStatement.close();
                rset.close();
                connection.close();
            } catch (SQLException ex){
                adaKesalahan = true;
                pesan = "Tidak dapat membaca data nilai siswa\n"+ex.getMessage();
            }
        } else {
            adaKesalahan = true;
            pesan = "Tidak dapat melakukan koneksi ke server\n"+koneksi.getPesanKesalahan();
        }
        
        return !adaKesalahan;
    }
    
    public boolean cetakLaporan(int semester, String kelas){
        boolean adaKesalahan = false;
        Connection connection;
        
        if ((connection = koneksi.getConnection()) != null){
            String SQLStatement;
            Statement statement;
            ResultSet resultSet = null;
                    
            try {
                SQLStatement = " SELECT tbmahasiswa.`nim` AS tbmahasiswa_nim, "
                        + " tbmahasiswa.`nama` AS tbmahasiswa_nama, "
                        + " tbmahasiswa.`semester` AS tbmahasiswa_semester, "
                        + " tbmahasiswa.`kelas` AS tbmahasiswa_kelas, "
                        + " tbmatakuliah.`kodematakuliah` AS tbmatakuliah_kodematakuliah, "
                        + " tbmatakuliah.`namamatakuliah` AS tbmatakuliah_namamatakuliah, "
                        + " tbmatakuliah.`jumlahsks` AS tbmatakuliah_jumlahsks, "
                        + " tbnilai.`nim` AS tbnilai_nim, "
                        + " tbnilai.`kodematakuliah` AS tbnilai_kodematakuliah, "
                        + " tbnilai.`tugas` AS tbnilai_tugas, "
                        + " tbnilai.`uts` AS tbnilai_uts, "
                        + " tbnilai.`uas` AS tbnilai_uas, "
                        + " round((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3, 2) AS tbnilai_nilaiakhir, "
                        + " (if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=85,'A', "
                        + " if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=70,'B', "
                        + " if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=55,'C', "
                        + " if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=40,'D','E'))))) AS tbnilai_nilaihuruf, "
                        + " (if((tbnilai.`tugas`+tbnilai.`uts`+tbnilai.`uas`)/3>=55,'Lulus','Tidak Lulus')) AS tbnilai_status "
                        + " FROM "
                        + " `tbmahasiswa` tbmahasiswa INNER JOIN `tbnilai` tbnilai ON tbmahasiswa.`nim` = tbnilai.`nim` "
                        + " INNER JOIN `tbmatakuliah` tbmatakuliah ON tbnilai.`kodematakuliah` = tbmatakuliah.`kodematakuliah` ";
                
                if (semester!=0){
                    SQLStatement = SQLStatement + " where tbmahasiswa.`semester`="+semester;
                    
                    if (!kelas.equals("")){
                        SQLStatement = SQLStatement + " and tbmahasiswa.`kelas`='"+kelas+"' ";
                    }
                } else {
                    if (!kelas.equals("")){
                        SQLStatement = SQLStatement + " where tbmahasiswa.`kelas`='"+kelas+"' ";
                    }
                }
                
                SQLStatement = SQLStatement +" ORDER BY "
                        + " tbmahasiswa.`semester` ASC, "
                        + " tbmahasiswa.`kelas` ASC, "
                        + " tbmahasiswa.`nama` ASC, "
                        + " tbmahasiswa.`nim` ASC";
                
                statement = connection.createStatement();
                resultSet = statement.executeQuery(SQLStatement);
            } catch (SQLException ex) {
                adaKesalahan = true;
                pesan = "Tidak dapat membaca data\n"+ex;
            }
            
            if (resultSet != null){
                try {
                    JasperDesign disain = JRXmlLoader.load("src/reports/NilaiReport.jrxml");
                    JasperReport nilaiLaporan = JasperCompileManager.compileReport(disain);
                    JRResultSetDataSource resultSetDataSource = new JRResultSetDataSource(resultSet);
                    JasperPrint cetak = JasperFillManager.fillReport(nilaiLaporan,new HashMap(),resultSetDataSource);
                    JasperViewer.viewReport(cetak,false);
                } catch (JRException ex) {
                    adaKesalahan = true;
                    pesan = "Tidak dapat mencetak laporan\n"+ex;
                }
            }
        }  else {
            adaKesalahan = true;
            pesan = "Tidak dapat melakukan koneksi ke server\n"+koneksi.getPesanKesalahan();
        }
        
        return !adaKesalahan;
    }
}

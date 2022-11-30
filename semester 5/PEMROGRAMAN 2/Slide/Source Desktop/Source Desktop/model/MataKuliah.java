/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import view.PesanDialog;

/**
 *
 * @author 4R135
 */
public class MataKuliah {
    private String kodeMataKuliah, namaMataKuliah;
    private int jumlahSks;
    private String pesan;
    private Object[][] list;
    private final Koneksi koneksi = new Koneksi();
    private final PesanDialog pesanDialog = new PesanDialog();

    public String getKodeMataKuliah() {
        return kodeMataKuliah;
    }

    public void setKodeMataKuliah(String kodeMataKuliah) {
        this.kodeMataKuliah = kodeMataKuliah;
    }

    public String getNamaMataKuliah() {
        return namaMataKuliah;
    }

    public void setNamaMataKuliah(String namaMataKuliah) {
        this.namaMataKuliah = namaMataKuliah;
    }

    public int getJumlahSks() {
        return jumlahSks;
    }

    public void setJumlahSks(int jumlahSks) {
        this.jumlahSks = jumlahSks;
    }

    public String getPesan() {
        return pesan;
    }

    public Object[][] getList() {
        return list;
    }

    public void setList(Object[][] list) {
        this.list = list;
    }
    
    public boolean simpan(){
        boolean adaKesalahan = false;	
	Connection connection; 
	
	if ((connection = koneksi.getConnection()) != null){
            int jumlahSimpan=0;
            boolean simpan = false;
            Statement sta;
            ResultSet rset;
            
            
            try {
                String SQLStatemen = "select * from tbmatakuliah where kodematakuliah='"+kodeMataKuliah+"'";
                sta = connection.createStatement();
                rset = sta.executeQuery(SQLStatemen);
                
                rset.next();
                if (rset.getRow()>0){
                    if (pesanDialog.tampilkanPilihan("Kode mata kuliah sudah ada\nApakah data diperbaharui?","Konfirmasi", new Object[]{"Ya","Tidak"}) == 0){
                        simpan = true;
                        SQLStatemen = "update tbmatakuliah set namamatakuliah='"+namaMataKuliah+
                                "', jumlahsks='"+jumlahSks+"' where kodematakuliah='"+kodeMataKuliah+"'";
                        sta = connection.createStatement();
                        jumlahSimpan = sta.executeUpdate(SQLStatemen);
                    }
                } else {
                    simpan = true;
                    SQLStatemen = "insert into tbmatakuliah values ('"+ kodeMataKuliah +"','"+
                            namaMataKuliah+"','"+ jumlahSks +"')";
                    sta = connection.createStatement();
                    jumlahSimpan = sta.executeUpdate(SQLStatemen);
                }
                
                if (simpan) {
                    if (jumlahSimpan < 1){
                        adaKesalahan = true;
                        pesan = "Gagal menyimpan data mata kuliah";
                    }
                }
                
                sta.close();
                rset.close();
                connection.close();
            } catch (SQLException ex){
                adaKesalahan = true;
                pesan = "Tidak dapat membuka tabel tbmatakuliah\n"+ex;
            }
        } else {
            adaKesalahan = true;
            pesan = "Tidak dapat melakukan koneksi ke server\n"+koneksi.getPesanKesalahan();
        }
        
        return !adaKesalahan;
    }
    
    public boolean baca(String kodeMataKuliah){
        boolean adaKesalahan = false;
        Connection connection;
        
        if ((connection = koneksi.getConnection()) != null){
            Statement sta;
            ResultSet rset;
            
            try {
                String SQLStatemen = "select * from tbmatakuliah where kodematakuliah='"+kodeMataKuliah+"'";
                sta = connection.createStatement();
                rset = sta.executeQuery(SQLStatemen);
                
                rset.next();
                if (rset.getRow()>0){
                    this.kodeMataKuliah = rset.getString("kodematakuliah");
                    this.namaMataKuliah = rset.getString("namamatakuliah");
                    this.jumlahSks = rset.getInt("jumlahsks");                    
                } else {
                    adaKesalahan = true;
                    pesan = "Kode mata kuliah \""+kodeMataKuliah+"\" tidak ditemukan";
                }
                
                sta.close();
                rset.close();
                connection.close();
            } catch (SQLException ex){
                adaKesalahan = true; 
                pesan = "Tidak dapat membuka tabel tbmatakuliah\n"+ex;
            }
        } else {
            adaKesalahan = true;
            pesan = "Tidak dapat melakukan koneksi ke server\n"+koneksi.getPesanKesalahan();
        }
        
        return !adaKesalahan;
    }
  
    public boolean bacaData(){
        boolean adaKesalahan = false;
        Connection connection;
        list = new Object[0][0] ;
        
        if ((connection = koneksi.getConnection()) != null){
            String SQLStatemen;
            Statement sta;
            ResultSet rset;
            
            try { 
                SQLStatemen = "select kodematakuliah,namamatakuliah from tbmatakuliah"; 
                sta = connection.createStatement(); 
                rset = sta.executeQuery(SQLStatemen);
                
                rset.next();
                rset.last();
                list = new Object[rset.getRow()][2];
                if (rset.getRow()>0){
                    rset.first();
                    int i=0;
                    do { 
                        list[i] = new Object[]{rset.getString("kodematakuliah"), rset.getString("namamatakuliah")};
                        i++;
                    } while (rset.next());
                }
                
                sta.close();
                rset.close();
                connection.close();
            } catch (SQLException ex){
                adaKesalahan = true;
                pesan = "Tidak dapat membuka tabel tbmatakuliah\n"+ex;
            }
        } else {
            adaKesalahan = true;
            pesan = "Tidak dapat melakukan koneksi ke server\n"+koneksi.getPesanKesalahan();
        }
        
        return !adaKesalahan;
    }
    
    public boolean hapus(String kodeMataKuliah){
        boolean adaKesalahan = false;
        Connection connection; 
        
        if ((connection = koneksi.getConnection()) != null){
            int jumlahHapus;
            Statement sta;
            
            try { 
                String SQLStatemen = "delete from tbmatakuliah where kodematakuliah='"+kodeMataKuliah+"'"; 
                sta = connection.createStatement(); 
                jumlahHapus = sta.executeUpdate(SQLStatemen);                    
                
                if (jumlahHapus < 1){
                    pesan = "Kode mata kuliah tidak ditemukan";
                    adaKesalahan = true;
                }
                
                sta.close();
                connection.close();
            } catch (SQLException ex){
                adaKesalahan = true; 
                pesan = "Tidak dapat membuka tabel tbmatakuliah\n"+ex;
            }
        } else {
            adaKesalahan = true;
            pesan = "Tidak dapat melakukan koneksi ke server\n"+koneksi.getPesanKesalahan();
        }
        
        return !adaKesalahan;
    }
}

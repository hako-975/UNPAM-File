    private void setItemComboBox(){
        jumlahSksComboBox.removeAllItems();
        for (int i=1; i<=6; i++){
            if (i != 5){
                jumlahSksComboBox.addItem(i);
            }
        }
    }
    
    public void setKodeMataKuliah(String kodeMataKuliah){
        kodeMataKuliahTextField.setText(kodeMataKuliah);
    }
    
    public String getKodeMataKuliah(){
        return kodeMataKuliahTextField.getText();
    }
    
    public void setNamaMataKuliah(String namaMataKuliah){
        namaMataKuliahTextField.setText(namaMataKuliah);
    }
    
    public String getNamaMataKuliah(){
        return namaMataKuliahTextField.getText();
    }
    
    public void setJumlahSks(int jumlahSks){
        jumlahSksComboBox.setSelectedItem(jumlahSks);
    }
    
    public int getJumlahSks(){
        return Integer.parseInt(jumlahSksComboBox.getSelectedItem().toString());
    }
	
	
	public void tampilkanData(Object[][] list) {
        if ((list != null) && (list.length>0)){
            for (int i=0; i<list.length; i++){
                mahasiswaTableModel.addRow(list[i]);
            }
        }
    }

    public String getNimDipilih() {
        return nimDipilih;
    }
	
	
	private void pilihButtonActionPerformed()
        if (mahasiswaTable.getSelectedRowCount() > 0 ){
            nimDipilih = mahasiswaTable.getValueAt(mahasiswaTable.getSelectedRow(), 0).toString();
            dispose();
        } else {
            JOptionPane.showMessageDialog(null, "Belum ada yang dipilih", "Informasi", JOptionPane.INFORMATION_MESSAGE);
        }
    }
	
	
	
	public void setNim(String nim){
        nimTextField.setText(nim);
    }
    
    public void setNama(String nama){
        namaTextField.setText(nama);
    }
    
    public void setSemester(String semester){
	semesterTextField.setText(semester);
    }
    
    public void setKelas(String kelas){
	kelasTextField.setText(kelas);
    }
    
    public void setNamaMataKuliah(String nama){
	nilaiTable.setValueAt(nama, nilaiTable.getSelectedRow(), 1);
    }
    
    public void setTambahNilai(Object[] nilaiMatakuliah){
        int noRecord;
        
        if ((noRecord = nilaiDefaultTableModel.getRowCount()-1) >= 0){
            while ((((nilaiTable.getValueAt(noRecord, 0) == null) || nilaiTable.getValueAt(noRecord, 0).equals("")) && (noRecord > 0))){
                noRecord--;
            }
            
            if (!((nilaiTable.getValueAt(noRecord, 0) == null) || nilaiTable.getValueAt(noRecord, 0).equals(""))){
                noRecord++;
            }
            
            if (noRecord < nilaiDefaultTableModel.getRowCount()){
                if ((nilaiTable.getValueAt(noRecord, 0) == null) || nilaiTable.getValueAt(noRecord, 0).equals("")){
                    nilaiDefaultTableModel.removeRow(noRecord--);
                }
            } else {
                noRecord--;
            }
        }
        
        nilaiDefaultTableModel.insertRow(++noRecord, nilaiMatakuliah);
    }
    
    public void clearNilaiTable(){
        nilaiDefaultTableModel.setRowCount(0);
    }
    
    private void klikKananTabel(java.awt.event.MouseEvent evt){
        if(evt.isPopupTrigger()){
            mataKuliahPopupMenu.show(evt.getComponent(), evt.getX(), evt.getY());
        }
    }
	
	
	private void nilaiTableMouseReleased()
        Point p = evt.getPoint();
        int rowNumber = nilaiTable.rowAtPoint( p );
        ListSelectionModel model = nilaiTable.getSelectionModel();
        model.setSelectionInterval( rowNumber, rowNumber );
        
        klikKananTabel(evt);
    }

    private void jScrollPane1MouseReleased()
        klikKananTabel(evt);
    }
	
	private void nilaiTableKeyPressed()
        if (evt.getKeyCode() == KeyEvent.VK_ENTER){
            if (nilaiTable.getSelectedRow() == (nilaiTable.getRowCount()-1)){
                if (nilaiTable.getSelectedColumn()==0){
                    nilaiDefaultTableModel.insertRow( nilaiDefaultTableModel.getRowCount(), new Object[]{}); 
                } else {
                    if (nilaiTable.getSelectedColumn() == (nilaiTable.getColumnCount()-1)){
                        nilaiDefaultTableModel.insertRow( nilaiDefaultTableModel.getRowCount(), new Object[]{});
                        nilaiTable.changeSelection(nilaiTable.getSelectedRow(), 0, false, false);
                    } else {
                        nilaiTable.changeSelection(nilaiTable.getSelectedRow()-1, nilaiTable.getSelectedColumn()+1, false, false);                    
                    }
                }
            } else {
                if (nilaiTable.getSelectedColumn() == (nilaiTable.getColumnCount()-1)){
                    nilaiTable.changeSelection(nilaiTable.getSelectedRow(), 0, false, false);
                } else {
                    nilaiTable.setColumnSelectionInterval(nilaiTable.getSelectedColumn()+1,nilaiTable.getSelectedColumn()+1);
                    nilaiTable.setRowSelectionInterval(nilaiTable.getSelectedRow()-1,nilaiTable.getSelectedRow()-1);
                }
            }
        }
    }

    private void nilaiTablePropertyChange()
        if (nilaiTable.getSelectedRowCount()>0){
            if (nilaiTable.getSelectedColumn()==0){
                String kodeMataKuliah = "";
                try{
                    kodeMataKuliah = nilaiTable.getValueAt(nilaiTable.getSelectedRow(), 0).toString();                
		}catch (Exception ex){}
                
		if (!kodeMataKuliah.equals("")){
                    nilaiController.cariMataKuliah(kodeMataKuliah); 	            
		}
            }
        }
    }
	
	private void setItemComboBox(){
        char[] ch = new char[1];
        int i;
        
        semesterComboBox.removeAllItems();
        for (i=1; i<=14; i++){
            semesterComboBox.addItem(i);
        }
        
        kelasComboBox.removeAllItems();
        for (i=0; i<26; i++){
            ch[0] = (char) (65+i);
            kelasComboBox.addItem(new String(ch));
        }
    }
    
    public String getKelas() {
        return kelasComboBox.getSelectedItem().toString();
    }

    public void setKelas(String kelas) {
        kelasComboBox.setSelectedItem(kelas);
    }

    public String getNama() {
        return namaTextField.getText();
    }

    public void setNama(String nama) {
        namaTextField.setText(nama);
    }

    public String getNim() {
        return nimTextField.getText();
    }

    public void setNim(String nim) {
        nimTextField.setText(nim);
    }

    public int getSemester() {
        return Integer.parseInt(semesterComboBox.getSelectedItem().toString());
    }

    public void setSemester(int semester) {
        semesterComboBox.setSelectedItem(semester);
    }
    
    public String getPassword() {
        return new String(passwordField.getPassword());
    }

    public void setPassword(String password) {
        passwordField.setText(password);
    }
	
	private void loginButtonActionPerformed(){
	    if (loginController.validasi(userIdTextField, passwordField)){
            userLogin = userIdTextField.getText();
            dispose();
        }
	}
	
	private void aksesMenuItemActionPerformed(){
		if (aksesMenuItem.getText().equals("Login")){
            formLogin.setVisible(true);
            if (!formLogin.getUserLogin().equals("")){
                setEnableMenu(true);
                aksesMenuItem.setText("Logout");
            } else {
                setEnableMenu(false);
            }
        } else {
            aksesMenuItem.setText("Login");
            setEnableMenu(false);
        }
	}
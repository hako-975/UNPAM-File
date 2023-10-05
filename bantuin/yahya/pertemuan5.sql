use ChurulAinYahya;

--INSERT INTO TblMahasiswa (NIM, NamaMHS, TmptLahir, TglLahir, JKelamin, Agama, Alamat, Kota, NoTelp, Hobi) 
--VALUES ('12345', 'Ahmad Kurniawan', 'Tangerang', '2023-05-20', 'L', 'Islam', 'Jl. Aria Putra, Ciputat', 'Tangerang Selatan',
--'081312345', 'Naik Gunung');

--ALTER TABLE TblMahasiswa DROP CONSTRAINT PK_NIM;

--ALTER TABLE TblMahasiswa ALTER COLUMN NIM nchar(12) NOT NULL;

--ALTER TABLE TblMahasiswa
--ADD CONSTRAINT PK_NIM PRIMARY KEY(NIM);

--INSERT INTO TblMahasiswa (NIM, NamaMHS, TmptLahir, TglLahir, JKelamin, Agama, Alamat, Kota, NoTelp, Hobi)
--VALUES ('211011400356', 'Churul Ain Yahya', 'Jakarta', '2003-04-21', 'P', 'Islam', 'jln. delima, tajur halang', 
--'Bogor', '081383472177', 'Main');

--UPDATE TblMahasiswa SET Alamat = 'Jl. Medan Merdeka, Jakarta Pusat', Hobi = 'Berenang' WHERE NIM = '12345';
--SELECT NIM, NamaMHS, Alamat, Hobi, Kota FROM TblMahasiswa;
--DELETE FROM TblMahasiswa WHERE NamaMHS = 'Ahmad Kurniawan';
SELECT NIM, NamaMHS, Alamat, Hobi, Kota FROM TblMahasiswa;

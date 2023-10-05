CREATE DATABASE ChurulAinYahya;

USE ChurulAinYahya;

CREATE TABLE TblMahasiswa (
	NIM nchar (10) NOT NULL, 
	NamaMHS nchar (35) NOT NULL, 
	TmptLahir nchar (26) NOT NULL, 
	TglLahir datetime NOT NULL, 
	JKelamin nchar (1) NOT NULL, 
	Agama nchar (10) NOT NULL, 
	Alamat nchar (100) NULL, 
	Kota nchar (26) NULL,
	KodePos nchar (5) NULL, 
	NoTelp nchar (15) NULL
);

ALTER TABLE TblMahasiswa
ADD Hobi nchar(20);

ALTER TABLE TblMahasiswa
DROP COLUMN KodePos;

ALTER TABLE TblMahasiswa
ADD CONSTRAINT PK_NIM PRIMARY KEY(NIM);

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TblMahasiswa'
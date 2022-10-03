create database contoh5;

use contoh5;

create table TblMahasiswa (nim char(10) not null, 
							nama_mhs varchar(50) not null, 
							tmpt_lahir varchar(20) not null, 
							tgl_lahir date not null, 
							jenis_kelamin char(1) not null, 
							agama varchar(10) not null, 
							alamat text not null, 
							kota varchar(15) not null,
							kode_pos char(5) not null,
							no_telp char(13) not null);

insert into TblMahasiswa (nim, nama_mhs, tmpt_lahir, tgl_lahir, jenis_kelamin, agama, alamat, kota, kode_pos, no_telp) 
			values ('200714014', 'Andri Firman Saputra', 'Jakarta', '2002-01-29', 'l', 'Islam', 'Jl. AMD Babakan Pocis', 
					'Tangsel', '15315', '087808675313');

insert into TblMahasiswa (nim, nama_mhs, tmpt_lahir, tgl_lahir, jenis_kelamin, agama, alamat, kota, kode_pos, no_telp) 
			values ('2007140086', 'ADE CAHYADI', 'Bandung', '1987-08-17', 'l', 'Islam', 'Jl. Raya Jakarta', 
			'Jakarta', '54321', '0888999922');

insert into TblMahasiswa (nim, nama_mhs, tmpt_lahir, tgl_lahir, jenis_kelamin, agama, alamat, kota, kode_pos, no_telp) 
			values ('2007140156', 'ARIZONA RH', 'Surabaya', '1985-02-10', 'l', 'Islam', 'Jl. Perumnas 1 No. 11', 
			'Tangerang', '21211', '0818787212');

select * from TblMahasiswa;

update TblMahasiswa set alamat = 'Jl. Jakarta 41 bulungan' where nim = '200714014';

select * from TblMahasiswa;

delete from TblMahasiswa where nim = '200714014';

select * from TblMahasiswa;

CREATE TABLE TblDosen(
	NoDos nchar(3) Not Null,
	NamaDos nchar(35) Not Null,
	TmptLahir nchar(25) Not Null,
	TglLahir datetime Not Null,
	JKelamin nchar(1) Not Null,
	Agama nchar(10) Not Null,
	Alamat nchar(100) Null,
	Kota nchar(25) Null,
	Kodepos nchar(5) Null,
	GajiPokok money Not Null,
	CONSTRAINT PK_Dosen Primary key (NoDos)
);


CREATE TABLE TblMatakuliah(
	KodeMK nchar(5) Not Null,
	NamaMK nchar(35) Not Null,
	SKS int Not Null,
	Semester nchar(1) Not Null,
	CONSTRAINT PK_Matakuliah Primary key (KodeMK)
);


CREATE TABLE TblJurusan(
	KodeJur nchar(3) Not Null,
	NamaJur nchar(35) Not Null,
	Jenjang nchar(2) Not Null,
	KaJur nchar(35) Not Null,
	CONSTRAINT PK_Jurusan Primary key (KodeJur)
);

CREATE TABLE TblMengajar(
	kodeMengajar nchar(5) not null,
	ThnAkademik nchar(4) Not Null,
	Semester nchar(1) Not Null,
	KodeMK nchar(5) Not Null,
	NoDos nchar(3) Not Null,
	Hari nchar(6) Not Null,
	JamKe nchar(1) Not Null,
	Kelas nchar(3) Not Null,
	KodeJur nchar(3) Not Null,
CONSTRAINT PK_Mengajar primary key (kodeMengajar));

ALTER TABLE TblMengajar
ADD CONSTRAINT FK_Dosen Foreign Key (NoDos)
REFERENCES TblDosen(NoDos)ALTER TABLE TblMengajar
ADD CONSTRAINT FK_Matakuliah Foreign Key (KodeMK)
REFERENCES TblMatakuliah(KodeMK)ALTER TABLE TblMengajar
ADD CONSTRAINT FK_Jurusan Foreign Key (KodeJur)
REFERENCES TblJurusan(KodeJur)

INSERT INTO TblDosen
(NoDos, NamaDos, TmptLahir, TglLahir, JKelamin, Agama, Alamat,
Kota, KodePos, GajiPokok)
VALUES('269','ACHMAD BISRI','Jakarta','1980-01-01',
 'L','Islam','Jl. Raya Jakarta','Jakarta',
 '12345','5000000')INSERT INTO TblDosen
(NoDos, NamaDos, TmptLahir, TglLahir, JKelamin, Agama, Alamat,
Kota, KodePos, GajiPokok)
VALUES('270','ACHMAD UDIN ZAELANI','Jakarta','1980-02-02',
 'L','Islam', 'Jl. Raya Pamulang','Jakarta',
 '12312','3000000')
INSERT INTO TblDosen
(NoDos, NamaDos, TmptLahir, TglLahir, JKelamin, Agama, Alamat,
Kota, KodePos, GajiPokok)
VALUES('271','BUDI','Bandung','1975-05-02','L','Islam',
 'Jl. Raya Tangerang','Tangerang','34211','4500000')

INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF105','Sistem Digital','2','1')
INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF201','Komunikasi Data','3','2')
INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF202','Struktur Data','4','2')
INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF203','Matematika Diskrit','2','2')
INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF204','Jaringan Komputer','2','2')
INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF205','Sistem Operasi','2','2')
INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF101','Pengantar Teknologi Informasi','2','1')
INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF102','Pengantar Aplikasi Komputer','2','1')
INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF103','Algoritma dan Pemrograman','4','1')
INSERT INTO TblMatakuliah
(KodeMK, NamaMK, SKS, Semester) VALUES('IF104','Fisika Dasar','2','1')INSERT INTO TblJurusan
(KodeJur, NamaJur, Jenjang, KaJur) VALUES('IF1','Teknik Informatika','S1',
'Ir. Atang Susila, M.Eng')
INSERT INTO TblJurusan
(KodeJur, NamaJur, Jenjang, KaJur) VALUES('IF2','Sistem Informasi','S1','Achmad Bisri, S.Kom')
INSERT INTO TblJurusan
(KodeJur, NamaJur, Jenjang, KaJur) VALUES('IF3','Manajemen Informatika','D3',
'Achmad Udin Zaelani, S.Kom')


INSERT INTO TblMengajar
(kodeMengajar, ThnAkademik, Semester, KodeMK, NoDos, Hari,
JamKe, Kelas, KodeJur) VALUES('KM001', '2011','1','IF103','269','Senin','1','401','IF1')
INSERT INTO TblMengajar
(kodeMengajar, ThnAkademik, Semester, KodeMK, NoDos, Hari,
JamKe, Kelas, KodeJur) VALUES('KM002', '2011','1','IF103','269','Senin','2','402','IF1')
INSERT INTO TblMengajar
(kodeMengajar, ThnAkademik, Semester, KodeMK, NoDos, Hari,
JamKe, Kelas, KodeJur) VALUES('KM003', '2011','1','IF205','269','Senin','3','403','IF1')
INSERT INTO TblMengajar
(kodeMengajar, ThnAkademik, Semester, KodeMK, NoDos, Hari,
JamKe, Kelas, KodeJur) VALUES('KM004', '2011','1','IF105','270','Rabu','1','408','IF1')
INSERT INTO TblMengajar
(kodeMengajar, ThnAkademik, Semester, KodeMK, NoDos, Hari,
JamKe, Kelas, KodeJur) VALUES('KM005', '2011','1','IF201','270','Rabu','2','416','IF1')
INSERT INTO TblMengajar
(kodeMengajar, ThnAkademik, Semester, KodeMK, NoDos, Hari,
JamKe, Kelas, KodeJur) VALUES('KM006', '2011','1','IF202','270','Senin','1','408','IF1')

SELECT * FROM TblDosenSELECT * FROM TblMatakuliahSELECT * FROM TblJurusanSELECT * FROM TblMengajarSELECT NamaDos, JKelamin, Alamat, Kota
FROM TblDosenSELECT NamaDos, JKelamin, Alamat, Kota
FROM TblDosen
WHERE Kota = 'Tangerang'
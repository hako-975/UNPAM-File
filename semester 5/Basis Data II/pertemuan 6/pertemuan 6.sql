create database andri_firman_saputra;
use andri_firman_saputra;

create table TblRuangKuliah (
	IDRuang nchar(3) not null,
	Letak nchar(10) not null,
	Lokasi nchar(10) not null,
	Kapasitas int null 
	constraint PK_RuangKuliah
	primary key (IDRuang, Letak, Lokasi));

insert into TblRuangKuliah values
(201, 'Lantai 2', 'Gedung A', 30),
(202, 'Lantai 2', 'Gedung A', 40),
(203, 'Lantai 2', 'Gedung A', 35),
(204, 'Lantai 2', 'Gedung A', 40),
(301, 'Lantai 3', 'Gedung A', 30),
(302, 'Lantai 3', 'Gedung A', 40),
(303, 'Lantai 3', 'Gedung A', 35),
(304, 'Lantai 3', 'Gedung A', 40),
(401, 'Lantai 4', 'Gedung A', 30),
(402, 'Lantai 4', 'Gedung A', 40),
(403, 'Lantai 4', 'Gedung A', 35),
(404, 'Lantai 4', 'Gedung A', 40),
(201, 'Lantai 2', 'Gedung B', 30),
(202, 'Lantai 2', 'Gedung B', 40),
(203, 'Lantai 2', 'Gedung B', 35),
(204, 'Lantai 2', 'Gedung B', 40),
(301, 'Lantai 3', 'Gedung B', 30),
(302, 'Lantai 3', 'Gedung B', 40),
(303, 'Lantai 3', 'Gedung B', 35),
(304, 'Lantai 3', 'Gedung B', 40),
(401, 'Lantai 4', 'Gedung B', 30),
(402, 'Lantai 4', 'Gedung B', 40),
(403, 'Lantai 4', 'Gedung B', 35),
(404, 'Lantai 4', 'Gedung B', 40),
(501, 'Lantai 2', 'Gedung B', 30),
(502, 'Lantai 2', 'Gedung B', 40),
(503, 'Lantai 2', 'Gedung B', 35),
(504, 'Lantai 2', 'Gedung B', 40);

SELECT 'TOTAL RUANG KULIAH' = COUNT(IDRuang) FROM TblRuangKuliah;

SELECT 'TOTAL RUANG KULIAH GEDUNG A' = COUNT(IDRuang) FROM TblRuangKuliah WHERE Lokasi = 'Gedung A';

SELECT 'TOTAL KAPASITAS RUANG KULIAH' = SUM(Kapasitas) FROM TblRuangKuliah;

SELECT 'TOTAL KAPASITAS RUANG KULIAH GEDUNG B' = SUM(Kapasitas) FROM TblRuangKuliah WHERE Lokasi = 'Gedung B';

SELECT 'KAPASITAS RUANG TERKECIL' = MIN(Kapasitas) FROM TblRuangKuliah;

SELECT 'KAPASITAS RUANG TERBESAR' = MAX(Kapasitas) FROM TblRuangKuliah;

SELECT 'RATA-RATA KAPASITAS RUANG' = AVG(Kapasitas) FROM TblRuangKuliah;

SELECT Lokasi, 'JML KAPASITAS' = SUM(Kapasitas) FROM TblRuangKuliah GROUP BY Lokasi;

SELECT Letak, 'JML KAPASITAS' = SUM(Kapasitas) FROM TblRuangKuliah GROUP BY Letak;

SELECT Letak, 'JML KAPASITAS' = SUM(Kapasitas) FROM TblRuangKuliah WHERE Lokasi = 'Gedung B' GROUP BY Letak;

SELECT * FROM TblRuangKuliah ORDER BY IDRuang ASC;

SELECT * FROM TblRuangKuliah ORDER BY IDRuang DESC;

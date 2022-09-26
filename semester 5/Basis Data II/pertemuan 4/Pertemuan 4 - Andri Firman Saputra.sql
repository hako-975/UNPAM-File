
--create database latihan1;
--drop database latihan1;
--create database latihan2;

/*create table karyawan (
	nik nchar (10) not null,
	nama_kar nchar(35) not null,
	jk nchar(1) not null,
	alamat nchar(100) null,
	kota nchar(26) null
);*/

/*
ALTER TABLE karyawan
ADD CONSTRAINT PK_karyawan primary key(nik);
*/

/*
ALTER TABLE karyawan
ADD no_telepon nchar(12) not null;
*/

-- create database latihan4_201011402125_andri;
-- use latihan4_201011402125_andri;
/*create table buku_andri (
	kode_buku nchar(5) not null,
	judul_buku nchar(100) not null,
	pengarang nchar(35) not null,
	penerbit nchar(35) not null,
	tahun_terbit nchar(4) not null,
	jml_buku int not null
);
*/

/*
alter table buku_andri 
add constraint PK_buku primary key(kode_buku);
*/

/*
alter table buku_andri add ISBN nchar(30) not null;
alter table buku_andri add _status int(1) not null;
*/

--alter table buku_andri add nama nchar(30) not null;

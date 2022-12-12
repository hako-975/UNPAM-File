create database NilaiMahasiswa_andri_201011402125;

use NilaiMahasiswa_andri_201011402125;

create table TblJurusan_andri_201011402125 (
	KodeJur nchar(3) not null,
	NamaJur nchar(35) not null,
	Jenjang nchar(2) not null,
	KaJur nchar(35) not null,
	primary key (KodeJur)
);

create table TblMahasiswa_andri_201011402125 (
	NIM nchar(12) not null,
	NamaMHS nchar(35) not null,
	TmptLahir nchar(26) not null,
	TglLahir datetime not null,
	JKelamin nchar(1) not null,
	Agama nchar(10) not null,
	Alamat nchar(100) null,
	Kota nchar(26) null,
	KodePos nchar(5) null,
	NoTelp nchar(15) null,
	KodeJur nchar(3) null,
	primary key(NIM)
);

create table TblMatakuliah_andri_201011402125 (
	KodeMK nchar(5) not null,
	NamaMK nchar(35) not null,
	SKS int not null,
	Semester nchar(2) not null,
	primary key(KodeMK)
);

create table TblNilai_andri_201011402125 (
	ThnAkademik nchar(4) not null,
	Semester nchar(2) not null,
	NIM nchar(10) not null,
	KodeMK nchar(5) not null,
	NoDos nchar(3) null,
	NilaiAbsen int null,
	NilaiTugas int null, 
	NilaiUTS int null,
	NilaiUAS int null, 
	primary key(ThnAkademik, Semester, NIM, KodeMK)
);

create table TblDosen_andri_201011402125 (
	NoDos nchar(3) not null,
	NamaDos nchar(35) not null,
	TmptLahir nchar(25) not null,
	TglLahir datetime not null,
	JKelamin nchar(1) not null,
	Agama nchar(10) not null,
	Alamat nchar(100) null,
	Kota nchar(25) null,
	Kodepos nchar(5) null,
	GajiPokok money,
	primary key(NoDos)
);

insert into TblMahasiswa_andri_201011402125 values 
('201011402125', 'Andri Firman Saputra', 'Jakarta', 
'2002-01-29', 'L', 'Islam', 'Jl. Pocis', 'Tangerang Selatan', '15315', '087808675313', '1');

select * from TblMahasiswa_andri_201011402125;
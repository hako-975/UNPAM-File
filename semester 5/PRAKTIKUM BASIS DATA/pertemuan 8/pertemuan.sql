create database toko_andri;

use toko_andri;

create table barang(
	kode_barang varchar(10),
	nama_barang varchar(15),
    stok int(10),
    harga int(10),
    primary key(kode_barang)
);

insert into barang values
('a1', 'buku tulis', 15, 5000),
('a2', 'Pulpen', 20, 3000),
('a3', 'Penggaris', 10, 2000),
('a4', 'tipeX', 15, 5000);

select * from barang;

create database toko_baru_andri;

use toko_baru_andri;

select * from `tabel barang`;

create database perusahaan1;

use perusahaan1;

create table karyawan(
	nip int(10),
    nama varchar(20),
    alamat varchar(20),
    jabatan varchar(15)
);

insert into karyawan values
(20111, 'Toni', 'Ciledug', 'Teknik'),
(20112, 'Vina', 'Depok', 'HRD');

create database perusahaan2;

use perusahaan2;

desc karyawan;

select * from karyawan;







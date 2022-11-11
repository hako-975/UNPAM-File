create database toko_andri;
use toko_andri;

create table barang (
	kode_barang varchar(10), 
	nama_barang varchar (15),
	stok int(10),
	harga int(10),
	primary key(kode_barang)
);


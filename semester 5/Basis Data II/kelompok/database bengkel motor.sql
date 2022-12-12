create database bengkel_motor;

use bengkel_motor;

create table user_bengkel (
	id_user_bengkel int,
	username nchar(50),
	password nchar(300),
	hak_akses nchar(100),
	nama_lengkap nchar(100)
	primary key(id_user_bengkel)
);

create table montir (
	id_montir int,
	nama_montir nchar(100),
	no_telepon nchar(15),
	alamat nchar(200)
	primary key(id_montir)
);

create table customer (
	id_customer int,
	nama_customer nchar(100),
	no_telepon nchar(15),
	alamat nchar(200)
	primary key(id_customer)
);
	
create table barang (
	id_barang int,
	nama_barang nchar(100),
	stok_barang int,
	harga_beli int,
	harga_jual int
	primary key(id_barang)
);

create table servis (
	id_servis int,
	id_customer int,
	id_montir int,
	biaya_servis int,
	keterangan nchar(100)
	constraint FK_Customer
	foreign Key (id_customer)
	references customer(id_customer),
	constraint FK_Montir
	foreign Key (id_montir)
	references montir(id_montir),
	primary key (id_servis)
);


create table barang_servis (
	id_barang_servis int, 
	id_servis int,
	id_barang int,
	jumlah_barang int,
	subtotal_harga int
	constraint FK_Servis
	foreign Key (id_servis)
	references servis(id_servis),
	constraint FK_Barang
	foreign Key (id_barang)
	references barang(id_barang),
	primary key (id_barang_servis)
);

create table transaksi (
	id_transaksi int,
	id_user_bengkel int,
	id_servis int,
	tanggal_transaksi datetime,
	total_harga int,
	keterangan nchar(100)
	constraint FK_UserBengkel
	foreign Key (id_user_bengkel)
	references user_bengkel(id_user_bengkel),
	constraint FK_Servis_Transaksi
	foreign Key (id_servis)
	references servis(id_servis),
	primary key(id_transaksi)
);

insert into user_bengkel (id_user_bengkel, username, password, hak_akses, nama_lengkap) values 
(1, 'adminandri', 'adminandri123', 'Administrator', 'Andri Firman Saputra'),
(2, 'kasirrangga', 'kasirrangga123', 'Kasir', 'Rangga Ariansyah'),
(3, 'kasirfiki', 'kasirfiki123', 'Kasir', 'Fiki Aji Panuntun');

insert into montir (id_montir, nama_montir, no_telepon, alamat) values 
(1, 'Dhiwa Gemilang Pramdhani', '081212131953', 'Bogor'),
(2, 'Rizki Ramadhan', '085622778921', 'Ciputat'),
(3, 'Bima Darmaja Suryatama', '089899882273', 'Pondok Cabe');

insert into customer (id_customer, nama_customer, no_telepon, alamat) values 
(1, 'Fariz Septiawan', '081212341234', 'Alam Sutra'),
(2, 'Aldo Hermawan Suryana', '089621236545', 'Graha Raya'),
(3, 'Ragil Ramadhan', '085642126638', 'Serpong');

insert into barang (id_barang, nama_barang, stok_barang, harga_beli, harga_jual) values
(1, 'Oli', 12, 35000, 40000),
(2, 'Kampas Rem', 50, 50000, 56000),
(3, 'Minyak Rem', 10, 20000, 25000),
(4, 'Van Belt Matic', 6, 35000, 40000);

insert into servis (id_servis, id_customer, id_montir, biaya_servis, keterangan) values
(1, 1, 1, 120000, 'Ganti Kampas Rem dan Ganti Van Belt'),
(2, 2, 2, 30000, 'Ganti Oli'),
(3, 3, 3, 35000, 'Ganti Minyak Rem');

insert into barang_servis (id_barang_servis, id_servis, id_barang, jumlah_barang, subtotal_harga) values
(1, 1, 2, 1, 56000),
(2, 1, 4, 1, 40000),
(3, 2, 1, 1, 40000),
(4, 3, 3, 2, 50000);

insert into transaksi (id_transaksi, id_user_bengkel, id_servis, tanggal_transaksi, total_harga, keterangan) values
(1, 2, 1, '2022-11-21 10:38:59', 216000, 'Biaya Ganti Kampas Rem, Ganti Van Belt, Beli Kampas Rem dan Van Belt Baru'),
(2, 3, 2, '2022-11-21 13:45:59', 70000, 'Biaya Ganti Oli dan Beli Oli'),
(3, 2, 3, '2022-11-21 17:08:59', 85000, 'Biaya Ganti Minyak Rem dan Beli Minyak Rem');

select * from user_bengkel;

select * from montir;

select * from customer;

select * from barang;

select * from servis;

select * from barang_servis;

select * from barang_servis where id_servis = 1;

select * from transaksi;

select tanggal_transaksi, transaksi.keterangan, user_bengkel.nama_lengkap, customer.nama_customer, servis.keterangan, 
	montir.nama_montir, servis.biaya_servis, barang_servis.subtotal_harga, total_harga from 
	transaksi
	inner join user_bengkel on transaksi.id_user_bengkel = user_bengkel.id_user_bengkel
	inner join servis on transaksi.id_servis = servis.id_servis
	inner join barang_servis on barang_servis.id_servis = servis.id_servis
	inner join barang on barang.id_barang = barang_servis.id_barang
	inner join montir on montir.id_montir = servis.id_montir
	inner join customer on customer.id_customer = servis.id_customer;


create database Routine;
use Routine;

create function fungsi1(a smallint) returns int return(a+a);

select fungsi1(60);

create function fungsi2(kar char(50)) returns int return length(kar);

select fungsi2('MySQL');

create function fungsi3(a smallint) returns int return((a*a)+a);

select fungsi3(10);

show create function fungsi1;

show create function fungsi2;

show create function fungsi3;

drop function fungsi3;

show create function fungsi3;

create database sekolah;
use sekolah;

create table siswa (
	nis varchar(15), 
	nama char(20), 
	angkatan varchar(30),
	primary key(nis)
);

INSERT INTO siswa values ('11234','ana','2008/2009');
INSERT INTO siswa values ('11235','bayu','2009/2010');
INSERT INTO siswa values ('11236','canda','2010/2011');
INSERT INTO siswa values ('11237','dirga','2012/2013');
INSERT INTO siswa values ('11238','endang','2013/2014');

delimiter //
create procedure jumlahsiswa(out parameter1 int)
begin
select count(*) into parameter1 from siswa;
end;
//

call jumlahsiswa(@a);

select (@a);

create database toko;
use toko;

create table barang (
	IdBarang int,
    NamaBarang varchar(20), 
	Satuan varchar(20), 
	Harga int, 
	Jumlah int,
    primary key(IdBarang)
);

INSERT INTO barang values ('1','Sabun','Bungkus', 3000, 20);
INSERT INTO barang values ('2','Sikat gigi','Bungkus', 4000, 50);
INSERT INTO barang values ('3','Sampho','Botol', 10000, 30);
INSERT INTO barang values ('4','Kopi','Kg', 30000, 20);
INSERT INTO barang values ('5','Teh','Bungkus', 5000, 40);
INSERT INTO barang values ('6','Beras','Kg', 10000, 10);


delimiter //
create procedure jumlahbarang(out parameter2 int)
begin
select count(*) into parameter2 from barang;
end;
//

call jumlahbarang(@a);

select (@a);
    
delimiter //
create procedure total(out parameter3 int)
begin
select sum(harga * jumlah) as total into parameter3 from barang;
end;
//

call total(@a);

select (@a);


INSERT INTO barang values ('7','Indomie','Bungkus', 3000, 40);
INSERT INTO barang values ('8','Gula merah','Kg', 10000, 10);




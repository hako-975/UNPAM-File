create database koperasi;

use koperasi;

create table member (Id_member varchar(15), Nama char(20), Alamat char(20),
primary key(Id_member));

desc member;

INSERT INTO member values('1111', 'Anang', 'Cipondoh');
INSERT INTO member values('1112', 'Budi', 'Ciledug');
INSERT INTO member values('1113', 'Cici', 'Cinangka');
INSERT INTO member values('1114', 'Darma', 'Cikupa');
INSERT INTO member values('1115', 'Endang', 'Cipondoh');

create table pinjam(Nota varchar(15), Id_member varchar(20), Tanggal date, Jumlah char(10), primary key(Nota));

desc pinjam;

INSERT INTO pinjam values('A100', '1111', '2014-02-04', '500000');
INSERT INTO pinjam values('B100', '1113', '2014-02-06', '700000');
INSERT INTO pinjam values('C100', '1112', '2014-02-07', '400000');
INSERT INTO pinjam values('D100', '1114', '2014-02-09', '900000');

select * from member INNER JOIN pinjam using(id_member);

select a.id_member, a.nama, a.alamat, b.nota, b.tanggal, b.jumlah from member a 
INNER JOIN pinjam b on(a.id_member=b.id_member);

select a.id_member, a.nama, a.alamat, b.nota, b.tanggal, b.jumlah from member a 
LEFT OUTER JOIN pinjam b on(a.id_member=b.id_member);


select a.id_member, a.nama, a.alamat, b.nota, b.tanggal, b.jumlah from member a 
LEFT OUTER JOIN pinjam b on(a.id_member=b.id_member) where nota is not null;

INSERT INTO pinjam values('E100', '1114', '2014-02-09', null);

INSERT INTO pinjam values('F100', '1114', null, null);

select a.id_member, a.nama, a.alamat, b.nota, b.tanggal, b.jumlah from member a 
LEFT OUTER JOIN pinjam b on(a.id_member=b.id_member) where nota is not null;

select a.id_member, a.nama, a.alamat, b.nota, b.tanggal, b.jumlah from member a 
LEFT OUTER JOIN pinjam b on(a.id_member=b.id_member) where nota is not null AND jumlah is not null AND tanggal is not null;

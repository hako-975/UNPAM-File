create database rumahsakit;

use rumahsakit;

create table pasien(
	id_pasien varchar(5), 
	nama char(20), 
    alamat char(20), 
    no_antrian varchar(5),
    tgl_masuk date,
    primary key(id_pasien)
);

insert into pasien values('a1', 'yahya', 'pondok cabe', 'a11', '2014-05-21');
insert into pasien values('a2', 'yanto', 'cinere', 'a12', '2014-05-23');
insert into pasien values('a4', 'wandi', 'ciputat', 'a14', '2014-05-24');
select * from pasien;

set @jmlpenambahan=0;
create trigger trigger1 before insert on pasien for each row set 
@jmlpenambahan=@jmlpenambahan + 1;

insert into pasien values('a3', 'lulu', 'cinere', 'a15', '2014-05-24');
insert into pasien values('a5', 'sari', 'cilandak', 'a16', '2014-05-25');
insert into pasien values('a6', 'bari', 'cinere', 'a16', '2014-05-25');

create trigger trigger2 after delete on pasien for each row set 
@jmlpenambahan=@jmlpenambahan - 1;

select @jmlpenambahan;

insert into pasien values('a7', 'andri', 'pocis', 'a17', '2022-11-25');
delete from pasien where id_pasien = 'a3';
delete from pasien where id_pasien = 'a5';

select @jmlpenambahan;


create database bioskop;
use bioskop;
create table JadwalFilm(
	Id_film varchar(15), 
	Judul char(20), 
    Waktu datetime,
    primary key(Id_Film)
);

desc JadwalFilm;

insert into JadwalFilm values('D11', 'In Fear', '2014-03-07 18:30:00');
insert into JadwalFilm values('H12', 'Haunt', '2014-03-07 19:00:00');
insert into JadwalFilm values('C13', 'Bad Words', '2014-03-07 19:30:00');
insert into JadwalFilm values('A14', 'Divergent', '2014-03-07 20:00:00');
insert into JadwalFilm values('E15', 'Enemy', '2014-03-07 20:30:00');
insert into JadwalFilm values('F16', 'Harry Potter', '2014-03-07 21:00:00');

create table stdio(
	kode_stdio varchar(15),
    namaStdio char(20),
    Id_Film varchar(10),
    judul char(20),
    primary key(kode_stdio)
);

desc stdio;

insert into stdio values ('STD4', 'Stdio 4', 'E15', 'Enemy');
insert into stdio values ('STD3', 'Stdio 3', 'D11', 'In Fear');
insert into stdio values ('STD2', 'Stdio 2', 'C13', 'Bad Words');
insert into stdio values ('STD5', 'Stdio 5', 'A14', 'Divergent');
insert into stdio values ('STD1', 'Stdio 1', 'H12', 'Haunt');

insert into stdio values ('STD6', 'Stdio 6', 'F16', 'Harry Potter');

create view tblview as select 
jadwalfilm.judul, 
jadwalfilm.waktu, 
namaStdio
from jadwalfilm, stdio 
where jadwalfilm.id_film = stdio.id_film;

select * from tblview;


select * from tblview where waktu > '2014-03-07 19:30:00';

select * from tblview where judul = 'Haunt';
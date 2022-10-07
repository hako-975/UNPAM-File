create database latihan5_201011402125_andri;


use latihan5_201011402125_andri;

create table TblMerekMotor_201011402125_andri (KodeMerek_201011402125_andri nchar(3) not null,
											   NamaMerek_201011402125_andri nchar(30) not null);

create table TblJenisMotor_201011402125_andri (KodeJenis_201011402125_andri nchar(4) not null, 
											   NamaJenis_201011402125_andri nchar(30) not null, 
											   KodeMerek_201011402125_andri nchar(3) not null, 
											   Harga_201011402125_andri Money not null, 
											   LamaGaransi_201011402125_andri int not null, 
											   Stok_201011402125_andri Int not null);

alter table TblMerekMotor_201011402125_andri 
add constraint PK_MerekMotor_201011402125_andri primary key(KodeMerek_201011402125_andri);

alter table TblJenisMotor_201011402125_andri 
add constraint PK_JenisMotor_201011402125_andri primary key(KodeJenis_201011402125_andri);

alter table TblJenisMotor_201011402125_andri
add constraint FK_MerekMotor_201011402125_andri foreign Key (KodeMerek_201011402125_andri)
references TblMerekMotor_201011402125_andri(KodeMerek_201011402125_andri);
insert into TblMerekMotor_201011402125_andri 
values ('M01', 'Honda'),
('M02', 'Yamaha'),
('M03', 'Suzuki'),
('M04', 'Kawasaki'),
('M05', 'Minerva'),
('M06', 'Bajaj'),
('M07', 'Piaggio');

insert into TblJenisMotor_201011402125_andri 
values ('J001', 'CBR-150', 'M01', 38000000, 5, 10),
('J002', 'Tiger', 'M01', 24000000, 3, 20),
('J003', 'MegaPro', 'M01', 22500000, 3, 15),
('J004', 'Vario', 'M01', 18500000, 2, 35),
('J005', 'Beat', 'M01', 17500000, 2, 30),
('J006', 'Supra', 'M01', 14000000, 2, 30),
('J007', 'Vixion', 'M02', 19500000, 3, 25),
('J008', 'Scorpio', 'M02', 19000000, 3, 20),
('J009', 'Mio', 'M02', 11000000, 3, 35),
('J010', 'Satria', 'M03', 17000000, 2, 20),
('J011', 'Thunder-125', 'M03', 13500000, 2, 30),
('J012', 'Spin-125', 'M03', 12500000, 3, 25),
('J013', 'Ninja-150', 'M04', 25000000, 3, 10),
('J014', '150-R', 'M05', 15000000, 1, 20),
('J015', 'Pulsar-135', 'M06', 15000000, 1, 25),
('J016', 'Pulsar-200', 'M06', 18500000, 1, 20),
('J017', 'Vespa-150', 'M07', 17500000, 1, 10),
('J018', 'Vespa-100', 'M07', 12500000, 1, 10);

select * from TblMerekMotor_201011402125_andri;

select * from TblJenisMotor_201011402125_andri;


update TblJenisMotor_201011402125_andri set NamaJenis_201011402125_andri='Tiger2000' 
where KodeJenis_201011402125_andri='J002';

update TblJenisMotor_201011402125_andri set NamaJenis_201011402125_andri='Supra-X' 
where KodeJenis_201011402125_andri='J006';

update TblJenisMotor_201011402125_andri set NamaJenis_201011402125_andri='Satria-150' 
where KodeJenis_201011402125_andri='J010';

update TblJenisMotor_201011402125_andri set NamaJenis_201011402125_andri='Minerva 150-R' 
where KodeJenis_201011402125_andri='J014';

select * from TblJenisMotor_201011402125_andri;

update TblJenisMotor_201011402125_andri set Harga_201011402125_andri='22000000' 
where KodeJenis_201011402125_andri='J013';

update TblJenisMotor_201011402125_andri set Harga_201011402125_andri='14500000' 
where KodeJenis_201011402125_andri='J017';

select * from TblJenisMotor_201011402125_andri;

delete from TblJenisMotor_201011402125_andri where 
KodeJenis_201011402125_andri='J018';

select * from TblJenisMotor_201011402125_andri;

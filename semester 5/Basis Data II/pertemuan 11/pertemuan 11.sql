create database StudiKasus_andri_201011402125;

use StudiKasus_andri_201011402125;

create table TblKaryawan_andri_201011402125 (
	NIP nchar(10) not null,
	NamaKar nchar(50) not null,
	TmptLahir nchar(50) not null,
	TglLahir datetime not null,
	JK nchar(1) not null,
	KodeStatus int not null,
	Alamat text not null,
	Kota nchar(50) not null,
	NoTelp nchar(20) not null,
	KodeDivisi nchar(5) not null,
	Gol nchar(5) not null,
	JmlAnak int null,
	primary key(NIP)
);

create table TblDivisi_andri_201011402125 (
	KodeDivisi nchar(5) not null,
	NamaDivisi nchar(50) not null,
	primary key(KodeDivisi)
);

create table TblGaji_andri_201011402125 (
	Gol nchar(5) not null,
	GajiPokok money not null,
	primary key(Gol)
);

create table TblStatus_andri_201011402125 (
	KodeStatus int not null,
	NamaStatus nchar(50) not null,
	primary key (KodeStatus)
);

alter table TblKaryawan_andri_201011402125
add constraint FK_Divisi_andri_201011402125 foreign Key (KodeDivisi)
references TblDivisi_andri_201011402125(KodeDivisi);

alter table TblKaryawan_andri_201011402125
add constraint FK_Gaji_andri_201011402125 foreign Key (Gol)
references TblGaji_andri_201011402125(Gol);

alter table TblKaryawan_andri_201011402125
add constraint FK_Status_andri_201011402125 foreign Key (KodeStatus)
references TblStatus_andri_201011402125(KodeStatus);


insert into TblGaji_andri_201011402125 values 
('A', 750000),
('B', 1000000),
('C', 1250000),
('D', 1500000),
('E', 1750000),
('F', 2000000),
('G', 2500000),
('H', 3000000),
('I', 4000000),
('J', 5000000);

insert into TblDivisi_andri_201011402125 values 
('A', 'Direktur'),
('B', 'Manager'),
('C', 'Personalia'),
('D', 'Marketing'),
('E', 'Produksi'),
('G', 'Warehouse'),
('H', 'Accounting'),
('I', 'Umum'),
('J', 'Sales');


insert into TblStatus_andri_201011402125 values
(1, 'Tidak'),
(2, 'Kawin'),
(3, 'Duda'),
(4, 'Janda');

insert into TblKaryawan_andri_201011402125 values
('0101000', 'Andri Firman Saputra', 'JAKARTA', '2002-01-29', 'L', 2, 'Jl. AMD Babakan Pocis', 'Tangerang Selatan', 
'087808675313', 'H', 'C', 10),
('0101001', 'DEWI', 'JAKARTA', '1977-05-23', 'P', 2, 'Jl. RAYA BOGOR 21', 'BOGOR', '02511234567', 'H', 'C', 2),
('0101002', 'ASTRI', 'TANGERANG', '1980-12-2', 'P', 1, 'Jl. SUKA SENANG 2', 'TANGERANG', '0219737292', 'E', 'B', NULL),
('0102001', 'ACHMAD', 'BANDUNG', '1988-12-12', 'L', 2, 'Jl. BUKIT DAGO', 'JAKARTA', '0211232121', 'B', 'I', 1),
('0201003', 'UDIN', 'BOGOR', '1985-09-10', 'L', 1, 'Jl. PAMULANG 2', 'TANGERANG', '0217866767', 'G', 'E', NULL),
('0311021', 'FITRI', 'SUKABUMI', '1979-12-10', 'P', 2, 'Jl. RAYA SUKABUMI', 'SUKABUMI', '025223232', 'J', 'D', 1);

select sum(JmlAnak) as 'TOTAL JUMLAH ANAK' from TblKaryawan_andri_201011402125;

select count(*) as 'JUMLAH STATUS KAWIN' from TblKaryawan_andri_201011402125 where KodeStatus = '2';

select NIP, NamaKar, NamaStatus from TblKaryawan_andri_201011402125 
inner join TblStatus_andri_201011402125 on TblKaryawan_andri_201011402125.KodeStatus = TblStatus_andri_201011402125.KodeStatus
where TblStatus_andri_201011402125.KodeStatus = 2;


select * from TblKaryawan_andri_201011402125 order by NamaKar desc;

select NIP, NamaKar, JK, TblKaryawan_andri_201011402125.KodeStatus, 
TblKaryawan_andri_201011402125.KodeDivisi, TblKaryawan_andri_201011402125.gol, JmlAnak from TblKaryawan_andri_201011402125 
inner join TblStatus_andri_201011402125 on TblKaryawan_andri_201011402125.KodeStatus = TblStatus_andri_201011402125.KodeStatus
inner join TblDivisi_andri_201011402125 on TblKaryawan_andri_201011402125.KodeDivisi = TblDivisi_andri_201011402125.KodeDivisi
inner join TblGaji_andri_201011402125 on TblKaryawan_andri_201011402125.Gol = TblGaji_andri_201011402125.Gol;

select sum(TblKaryawan_andri_201011402125.JmlAnak) as sum, COUNT(NIP) as cnt  from TblKaryawan_andri_201011402125 
inner join TblStatus_andri_201011402125 on TblKaryawan_andri_201011402125.KodeStatus = TblStatus_andri_201011402125.KodeStatus
inner join TblDivisi_andri_201011402125 on TblKaryawan_andri_201011402125.KodeDivisi = TblDivisi_andri_201011402125.KodeDivisi
inner join TblGaji_andri_201011402125 on TblKaryawan_andri_201011402125.Gol = TblGaji_andri_201011402125.Gol;

select NIP, NamaKar, TmptLahir, JK, Alamat, Kota, JmlAnak 
from TblKaryawan_andri_201011402125 where kota = 'bogor';

select sum(TblKaryawan_andri_201011402125.JmlAnak) as sum, COUNT(NIP) as cnt  
from TblKaryawan_andri_201011402125 where kota = 'bogor';

select NIP, NamaKar, TmptLahir, JK, Alamat, Kota, JmlAnak 
from TblKaryawan_andri_201011402125 where kota = 'jakarta';

select sum(TblKaryawan_andri_201011402125.JmlAnak) as sum, COUNT(NIP) as cnt  
from TblKaryawan_andri_201011402125 where kota = 'jakarta';

select NIP, NamaKar, TmptLahir, JK, Alamat, Kota, JmlAnak 
from TblKaryawan_andri_201011402125 where kota = 'sukabumi';

select sum(TblKaryawan_andri_201011402125.JmlAnak) as sum, COUNT(NIP) as cnt  
from TblKaryawan_andri_201011402125 where kota = 'sukabumi';

select NIP, NamaKar, TmptLahir, JK, Alamat, Kota, JmlAnak 
from TblKaryawan_andri_201011402125 where kota = 'tangerang';

select sum(TblKaryawan_andri_201011402125.JmlAnak) as sum, COUNT(NIP) as cnt  
from TblKaryawan_andri_201011402125 where kota = 'tangerang';

select TblGaji_andri_201011402125.Gol, count(NIP) as 'Jml Karyawan' from TblKaryawan_andri_201011402125 
inner join TblGaji_andri_201011402125 on
TblKaryawan_andri_201011402125.Gol = TblGaji_andri_201011402125.gol 
where KodeStatus = '2' and kota = 'jakarta' or kota = 'sukabumi' group by TblGaji_andri_201011402125.gol;

select kota, JmlAnak from TblKaryawan_andri_201011402125 where KodeDivisi = 'B';


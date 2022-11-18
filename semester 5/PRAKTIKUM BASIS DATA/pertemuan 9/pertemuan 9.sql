create database Penjualan;

use Penjualan;

create table buku(isbn varchar(15), judul char(20), pengarang char(30),
	harga varchar(15), stok char(10), primary key(isbn));

desc buku;

INSERT INTO buku values('11231', 'Matematika Diskrit', 'Hanafi', '60000', '25');
INSERT INTO buku values('11232', 'Pintar Java', 'Median', '50000', '20');
INSERT INTO buku values('11233', 'Struktur Data', 'Andrianto', '70000', '15');
INSERT INTO buku values('11234', 'Algoritma', 'SintaSari', '45000', '16');
INSERT INTO buku values('11235', 'Kewarganegaraan', 'Ramdani', '64000', '22');
INSERT INTO buku values('11236', 'Basisdata', 'Suginanto', '46000', '33');
INSERT INTO buku values('11237', 'Sistem Berkas', 'Suginanto', '60000', '20');
INSERT INTO buku values('11238', 'Web PHP', 'Median', '50000', '25');

select distinct pengarang from buku;

select distinct harga from buku;

select ABS(-90);

select ACOS(-0.90);

select ASIN(-0.90);

-- f) 
select ATAN(10), ATAN2(5, 4), BIN(10), CEILING(6.123), CONV(5, 15, 4),
COS(9), COT(9), DEGREES(5);

select MOD(15, 5), PI(), RADIANS(150), ROUND(6.43),
ROUND(5.4315, 3), SIN(300), TAN(150);

select EXP(9), FLOOR(8.98), FORMAT(12345.67, 4), GREATEST(9, 200, 344, 4, 3, 1),
HEX(15), LEAST(15, 3, 10, 0, 100, 355), LOG(10), LOG10(15);

select OCT(18), POW(5, 4), RAND(180), RAND(10), SIGN(-5.5637), SQRT(50), 
TRUNCATE(1234.56789, 2);

select count(*) from buku;

select count(*) from buku WHERE harga = 60000;

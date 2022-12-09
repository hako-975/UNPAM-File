use kelompok1;
create table dosen (kodeDosen char(4), namaDosen varchar(100), gelar varchar(100), primary key(kodeDosen));

insert into dosen values
('6335', 'A A GEDE RAI RASSI', 'S.Kom., M.Kom'),
('6336', 'ABDUL ROZAK', 'S.Kom., M.Kom'),
('6337', 'ABYGHAIL SHIDDIQ', 'S.Kom., M.Kom'),
('6338', 'ADE RISKI ILMAN', 'S.Kom., M.Kom'),
('6339', 'ADI SURYA ANGGANA', 'S.Kom., MTI'),
('6340', 'AHMAD KHAFIDHIN', 'S.Kom., MTI'),
('6341', 'ALDY PUTRA DIKARTA', 'S.Kom., M.Kom'),
('6342', 'ALI ALFATAH', 'S.Kom., M.Kom'),
('6343', 'ANDIKA RAMADHANI', 'S.Kom., M.Kom'),
('6344', 'ANGGUN WIBAWA', 'S.Kom., M.Kom'),
('6345', 'ARIEF WICHAKSONO', 'S.Kom., M.Kom'),
('6346', 'BAGUS INDRA BASUDEWA BANYU ROHMAN', 'S.Kom., M.Kom'),
('6347', 'BANYU ROHMAN', 'S.Kom., M.Kom'),
('6348', 'CANDRA NURUL HILAL', 'S.Kom., M.Kom'),
('6349', 'DEDI ROSANDI', 'S.Kom., M.Kom'),
('6350', 'DENY SETIAWAN', 'S.Kom., M.Kom'),
('6351', 'DESYANO FACHRI RAMDHANI', 'S.Kom., M.Kom'),
('6352', 'DETI DANIRA', 'S.Kom., M.Kom'),
('6353', 'DODI SETIANTO', 'S.Kom., M.Kom'),
('6354', 'FAHMI RAMADHAN', 'S.Kom., M.Kom'),
('6355', 'FIRQIN FUAD', 'S.Kom., MTI'),
('6356', 'FIRRIZQI MENTARIYANA', 'S.Kom., MTI'),
('6357', 'GOZALI YUSUF HADI', 'S.Kom., MTI'),
('6358', 'HISYAM ALI AL ABDURAHMAN', 'S.Kom., MTI'),
('6359', 'IDOFI ZAHWA', 'S.T.,M.Sc'),
('6360', 'IRHAM ANGGI NAMORA', 'S.T.,M.Sc'),
('6361', 'IRWAN SUGIARTO', 'S.T.,M.Sc'),
('6362', 'JULIA ARFANI', 'S.Kom., MTI'),
('6363', 'LEONARDO SIHALOHO', 'S.Kom., MTI'),
('6364', 'M YAHFA ALFARIZI', 'S.Kom., MTI'),
('6365', 'MOH. MUWAHIDIN', 'S.Kom., MTI'),
('6366', 'MOHAMAD FANDI YUSUF', 'S.T.,M.Sc'),
('6367', 'MOHAMMAD HILMAN', 'S.T.,M.Sc'),
('6368', 'MUFRIH AKHDIANSYAH', 'S.T.,M.Sc'),
('6369', 'MUHAMAD IDRIS', 'S.T.,M.Sc'),
('6370', 'MUHAMMAD GILANG', 'S.Kom., MTI'),
('6371', 'MUHAMMAD RIZKIYANSYAH', 'S.Kom., MTI'),
('6372', 'NASRUDIN', 'S.Kom., MTI'),
('6373', 'QURAISY ABDULJABAR', 'S.Kom., MTI'),
('6374', 'RIFQI KHOIRULLOH', 'S.T.,M.Sc'),
('6375', 'RIZKI PRASETYO', 'S.T.,M.Sc'),
('6376', 'RIZKI SHOLEHUDIN', 'S.Kom., M.Kom'),
('6377', 'SUHENDI', 'S.Kom., M.Kom'),
('6378', 'SUKMARA', 'S.Kom., M.Kom');


CREATE TABLE `kelompok1`.`jadwaldosen` 
(`kodeJadwalDosen` INT NOT NULL AUTO_INCREMENT , 
`kodeMatkul` char(8) NOT NULL ,
`kodeDosen` VARCHAR(4) NOT NULL , 
`hari` VARCHAR(20) NOT NULL , 
`jamPelaksanaan` VARCHAR(50) NOT NULL , 
PRIMARY KEY (`kodeJadwalDosen`), INDEX (`kodeMatkul`), INDEX (`kodeDosen`));

-- insert into jadwalDosen values (null, 'TPLP0062', '6335', 'Senin', '08.50 - 10.30');

set @jmlpenambahanMataKuliah=0;
create trigger triggerInsertMataKuliah before insert on matakuliah for each row set
@jmlpenambahanMataKuliah=@jmlpenambahanMataKuliah + 1;

create trigger triggerDeleteMataKuliah before delete on matakuliah for each row set
@jmlpenambahanMataKuliah=@jmlpenambahanMataKuliah - 1;

set @jmlpenambahanMahasiswa=0;
create trigger triggerInsertMahasiswa before insert on mahasiswa for each row set
@jmlpenambahanMahasiswa=@jmlpenambahanMahasiswa + 1;

create trigger triggerDeleteMahasiswa before delete on mahasiswa for each row set
@jmlpenambahanMahasiswa=@jmlpenambahanMahasiswa - 1;

set @jmlpenambahanDosen=0;
create trigger triggerInsertDosen before insert on dosen for each row set
@jmlpenambahanDosen=@jmlpenambahanDosen + 1;

create trigger triggerDeleteDosen before delete on dosen for each row set
@jmlpenambahanDosen=@jmlpenambahanDosen - 1;

set @jmlpenambahanJadwalDosen=0;
create trigger triggerInsertJadwalDosen before insert on jadwalDosen for each row set
@jmlpenambahanJadwalDosen=@jmlpenambahanJadwalDosen + 1;

create trigger triggerDeleteJadwalDosen before delete on jadwalDosen for each row set
@jmlpenambahanJadwalDosen=@jmlpenambahanJadwalDosen - 1;

set @jmlpenambahanRuangan=0;
create trigger triggerInsertRuangan before insert on ruangan for each row set
@jmlpenambahanRuangan=@jmlpenambahanRuangan + 1;

create trigger triggerDeleteRuangan before delete on ruangan for each row set
@jmlpenambahanRuangan=@jmlpenambahanRuangan - 1;

DROP TABLE ruangan;

create view tblView04TPLM016 as select 
matakuliah.namaMatkul as 'Mata kuliah', 
dosen.kodeDosen as 'Kode dosen', 
ruangan.hari as 'Hari',
ruangan.jamPelaksanaan as 'Jam pelaksanaan',
ruangan.kodeRuangan as 'Ruang'
from matakuliah, jadwalDosen, dosen, ruangan, mahasiswa
where mahasiswa.kelas = '04TPLM016';

select * from tblView04TPLM016;


create view tblView03TPLM018 as select 
matakuliah.namaMatkul as 'Mata kuliah', 
dosen.kodeDosen as 'Kode dosen', 
ruangan.hari as 'Hari',
ruangan.jamPelaksanaan as 'Jam pelaksanaan',
ruangan.kodeRuangan as 'Ruang'
from matakuliah, jadwalDosen, dosen, ruangan, mahasiswa
where mahasiswa.kelas = '03TPLM018';


create view tblView06TPLM010 as select 
matakuliah.namaMatkul as 'Mata kuliah', 
dosen.kodeDosen as 'Kode dosen', 
ruangan.hari as 'Hari',
ruangan.jamPelaksanaan as 'Jam pelaksanaan',
ruangan.kodeRuangan as 'Ruang'
from matakuliah, jadwalDosen, dosen, ruangan, mahasiswa
where mahasiswa.kelas = '06TPLM010';

create view tblView05TLPM012 as select 
matakuliah.namaMatkul as 'Mata kuliah', 
dosen.kodeDosen as 'Kode dosen', 
ruangan.hari as 'Hari',
ruangan.jamPelaksanaan as 'Jam pelaksanaan',
ruangan.kodeRuangan as 'Ruang'
from matakuliah, jadwalDosen, dosen, ruangan, mahasiswa
where mahasiswa.kelas = '05TLPM012';


create view tblView02TPLM014 as select 
matakuliah.namaMatkul as 'Mata kuliah', 
dosen.kodeDosen as 'Kode dosen', 
ruangan.hari as 'Hari',
ruangan.jamPelaksanaan as 'Jam pelaksanaan',
ruangan.kodeRuangan as 'Ruang'
from matakuliah, jadwalDosen, dosen, ruangan, mahasiswa
where mahasiswa.kelas = '02TPLM014';


create view tblView07TPLM009 as select 
matakuliah.namaMatkul as 'Mata kuliah', 
dosen.kodeDosen as 'Kode dosen', 
ruangan.hari as 'Hari',
ruangan.jamPelaksanaan as 'Jam pelaksanaan',
ruangan.kodeRuangan as 'Ruang'
from matakuliah, jadwalDosen, dosen, ruangan, mahasiswa
where mahasiswa.kelas = '07TPLM009';


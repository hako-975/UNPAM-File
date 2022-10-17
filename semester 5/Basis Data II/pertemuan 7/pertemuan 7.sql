use contoh5;

SELECT NamaDos 'Nama Dosen', Hari, JamKe 
FROM TblMengajar INNER JOIN TblDosen ON 
TblMengajar.NoDos = TblDosen.NoDos
WHERE Hari IN ('Senin', 'Rabu') AND JamKe = '2'
ORDER BY Hari;

SELECT NamaDos 'Nama Dosen', NamaMK 'Nama Matakuliah',
SKS, Hari, JamKe
FROM TblMengajar JOIN TblDosen ON TblMengajar.NoDos =
TblDosen.NoDos
 JOIN TblMatakuliah ON TblMengajar.KodeMK =
TblMatakuliah.KodeMK
WHERE SKS > 2
ORDER BY JamKe DESC


SELECT NamaDos 'Nama Dosen', NamaMK 'Matakuliah', SKS, Hari, Kelas
FROM TblDosen INNER JOIN TblMengajar ON TblDosen.NoDos = TblMengajar.NoDos
INNER JOIN TblMatakuliah ON TblMatakuliah.KodeMK = TblMengajar.KodeMk
WHERE Kelas BETWEEN '403' AND '410';

use latihan5_201011402125_andri;

SELECT NamaJenis_201011402125_andri, NamaMerek_201011402125_andri, Harga_201011402125_andri, LamaGaransi_201011402125_andri
FROM TblMerekMotor_201011402125_andri LEFT OUTER JOIN TblJenisMotor_201011402125_andri
ON TblMerekMotor_201011402125_andri.KodeMerek_201011402125_andri = TblJenisMotor_201011402125_andri.KodeMerek_201011402125_andri
WHERE LamaGaransi_201011402125_andri = 2

SELECT NamaJenis_201011402125_andri, NamaMerek_201011402125_andri, Harga_201011402125_andri, LamaGaransi_201011402125_andri
FROM TblMerekMotor_201011402125_andri RIGHT OUTER JOIN TblJenisMotor_201011402125_andri
ON TblMerekMotor_201011402125_andri.KodeMerek_201011402125_andri = TblJenisMotor_201011402125_andri.KodeMerek_201011402125_andri
WHERE LamaGaransi_201011402125_andri <> 2

SELECT NamaJenis_201011402125_andri, NamaMerek_201011402125_andri, Harga_201011402125_andri, LamaGaransi_201011402125_andri
FROM TblMerekMotor_201011402125_andri FULL OUTER JOIN TblJenisMotor_201011402125_andri
ON TblMerekMotor_201011402125_andri.KodeMerek_201011402125_andri = TblJenisMotor_201011402125_andri.KodeMerek_201011402125_andri
WHERE LamaGaransi_201011402125_andri = 2



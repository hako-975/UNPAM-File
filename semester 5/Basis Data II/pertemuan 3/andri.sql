print 123456;
print 'Andri Firman Saputra';

SELECT 'andri';
SELECT 123 AS test, 'Andri Firman Saputra' AS Nama, '201011402125' AS NIM;
SELECT 'Gaji Per Jam', 50.000;
SELECT 150;
SELECT (SELECT 250);
SELECT (SELECT (SELECT 350));
SELECT 50.000 as Gaji_Per_Jam;
SELECT 5*2 as 'perkalian 5x2', 10/2 as 'pembagian 10/2', 2%10 as 'modulus 2%10', 2+10 as 'penjumlahan 2+10', 10-2 as 'pengurangan 10-2';

DECLARE @sudut1 float
SET @sudut1 = 52.64

DECLARE @sinus float
SET @sinus = SIN(@sudut1)

SELECT 
	@sinus AS Sinus,
	ASIN(@sinus) AS Arcsinus

DECLARE @sudut2 float
SET @sudut2 = 52.64

DECLARE @cosinus float
SET @cosinus = COS(@sudut2)

SELECT 
	@cosinus AS Cosinus,
	ACOS(@cosinus) AS Arcosinus

DECLARE @sudut3 float
SET @sudut3 = 53.64

DECLARE @tangent float
SET @tangent = TAN(@sudut3)

SELECT 
	@tangent AS Tangent,
	ATAN(@tangent) As Arctangent
	
DECLARE @sudut4 float
SET @sudut4 = 52.64

DECLARE @cotangent float
SET @cotangent = COT(@sudut4)
SELECT @cotangent AS Cotangent
	
DECLARE @pi float
SET @pi = PI()

SELECT @pi AS [PI],
	DEGREES(@pi/2) AS [Derajat]

SELECT ROUND(5.49, 0),
	   ROUND(5.50, 0),
	   ROUND(5.51, 0),
	   ROUND(5.59, 0)

SELECT CEILING(5.00),
	   CEILING(5.01),
	   CEILING(5.55),
	   CEILING(5.99)

SELECT FLOOR(4.00),
	   FLOOR(4.99),
	   FLOOR(5.01),
	   FLOOR(5.50)

SELECT ABS(5),
	   ABS(-5),
	   ABS(-5.5)

SELECT POWER(2, 2),
	   POWER(3, 2),
	   POWER(4, 2)

SELECT RAND(1),
       RAND(2),
	   RAND(10),
	   RAND(20)

SELECT SQRT(9),
	   SQRT(16),
	   SQRT(25),
	   SQRT(36)

SELECT SQUARE(2),
	   SQUARE(3),
	   SQUARE(4),
	   SQUARE(5)

SELECT LOG(3.354),
	   LOG10(100)

SELECT EXP(0.999999),
	   EXP(2.30259)

SELECT ASCII('a')
SELECT ASCII('b')
SELECT ASCII('c')

SELECT CHAR(97)
SELECT CHAR(98)
SELECT CHAR(99)

SELECT LEN('Andri Firman Saputra')

SELECT LOWER('BELAJAR SQL') AS Hasil_Konversi

SELECT UPPER('Belajar sql') AS Hasil_Konversi

SELECT LEFT('Belajar SQL', 3) 

SELECT RIGHT('Belajar SQL', 4)

SELECT SUBSTRING('JAKARTA', 2, 4)

SELECT LTRIM('   DataBase')

SELECT LTRIM('DataBase   ')

SELECT REPLACE('www.unpam.ac.id', '.', ' dot ')

SELECT REVERSE('UNPAM')

SELECT 'JAKARTA' + SPACE(10) + 'BANDUNG'


	


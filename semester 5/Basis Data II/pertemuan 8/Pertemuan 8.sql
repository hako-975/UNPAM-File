use contoh5;

SELECT * FROM TblDosen;

INSERT INTO TblDosen VALUES 
(272, 'Lusianti', 'Jakarta', '2002-10-31', 'P', 'Islam', 'Jl. Sudirman', 'Tangerang', '15312', '3000000');

EXEC DosenPerempuan;

EXEC Sinus_Arcsinus;

EXEC CariDosen 272;

EXEC CariDosen2 @JK = 'L',  @NamaDosen = '%ACH%';

DECLARE @Gaji money;
EXEC GajiTertinggi 'L', @Gaji OUTPUT
PRINT 'Rp. ' + CAST(@Gaji as nchar(10));


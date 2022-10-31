CREATE PROCEDURE GajiTertinggi
	@JK nchar(1),
	@Gaji money OUTPUT 
AS 
BEGIN
	DECLARE @GajiTertinggi money;
	SET @GajiTertinggi = (SELECT MAX(GajiPokok)
								 FROM TblDosen
						  WHERE JKelamin = @JK);
	SET @Gaji = @GajiTertinggi;
END

DROP PROCEDURE GajiTertinggi;
GO
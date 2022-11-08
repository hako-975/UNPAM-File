SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE HargaTerendah
@Harga money OUTPUT
AS
BEGIN
	DECLARE @HargaTerendah money;

	SET @HargaTerendah = (SELECT MIN(Harga_201011402125_andri) FROM TblJenisMotor_201011402125_andri);

	SET @Harga = @HargaTerendah;
END
GO
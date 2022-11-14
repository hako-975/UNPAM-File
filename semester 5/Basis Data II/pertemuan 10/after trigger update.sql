SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER TanggalModifikasiData
   ON  TblJenisMotor_201011402125_andri
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;

	UPDATE TblJenisMotor_201011402125_andri
		SET TblJenisMotor_201011402125_andri.MODIFIKASIDATA = GETDATE()
	FROM inserted
	WHERE inserted.KodeJenis_201011402125_andri = TblJenisMotor_201011402125_andri.KodeJenis_201011402125_andri;
	PRINT 'Anda telah melakukan update data pada tabel item';
END
GO


UPDATE TblJenisMotor_201011402125_andri
	SET LamaGaransi_201011402125_andri = 4
	WHERE KodeJenis_201011402125_andri = 'J001';

SELECT * FROM TblJenisMotor_201011402125_andri;

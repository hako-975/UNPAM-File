SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER HapusMerekMotor
	ON TblJenisMotor_201011402125_andri
	INSTEAD OF DELETE
AS 
BEGIN 
	SET NOCOUNT ON;

	DECLARE @jml NUMERIC(10);

	SET @jml = (SELECT jm.Stok_201011402125_andri FROM TblJenisMotor_201011402125_andri jm,
				deleted d WHERE 
				jm.KodeJenis_201011402125_andri = d.KodeJenis_201011402125_andri);

	IF (@jml = 0)
	BEGIN 
		DELETE FROM TblJenisMotor_201011402125_andri WHERE KodeJenis_201011402125_andri = 
		(SELECT KodeJenis_201011402125_andri FROM deleted);
		print 'Item telah berhasil dihapus';
	END 
	ELSE 
	BEGIN 
		print 'Item tidak dapat dihapus karena belum kosong';
	END
END
GO

DELETE FROM TblJenisMotor_201011402125_andri 
	WHERE KodeJenis_201011402125_andri = 'J017';
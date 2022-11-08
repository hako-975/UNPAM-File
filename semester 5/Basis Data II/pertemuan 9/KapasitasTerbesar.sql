-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE KapasitasTerbesar
	-- Add the parameters for the stored procedure here
	@Lokasi char(8),
	@Kapasitas int Output
AS
BEGIN
	DECLARE @KapasitasTerbesar int;
	SET @KapasitasTerbesar = (SELECT max(Kapasitas) FROM TblRuangKuliah
								WHERE Lokasi = @Lokasi);
	SET @Kapasitas = @KapasitasTerbesar;
END
GO

use latihan5_201011402125_andri;
exec JenisMotor;
exec HargaLebihDari20Juta;
exec CariGaransi 3;

DECLARE @Harga money;
exec HargaTerendah @Harga OUTPUT;
print 'Rp. ' + CAST(@Harga as nchar(12));

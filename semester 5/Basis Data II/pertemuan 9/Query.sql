exec Kapasitas;

exec CariLokasi 30;

DECLARE @Kapasitas int;
exec KapasitasTerbesar 'Gedung A', @Kapasitas output;
print @Kapasitas;
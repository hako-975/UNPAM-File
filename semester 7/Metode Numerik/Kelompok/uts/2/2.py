hasil_pengukuran = 40
nilai_sebenarnya = 42
galat_mutlak = abs(hasil_pengukuran - nilai_sebenarnya)
galat_relatif = (galat_mutlak / nilai_sebenarnya) * 100
print("Galat Mutlak:", galat_mutlak)
print("Galat Relatif:", galat_relatif, "%")

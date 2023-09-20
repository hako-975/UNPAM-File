# logika fuzzy
import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt  # Import library matplotlib

# Variabel input

# Rentang nilai rata-rata 0-100
nilai_rata_rata = ctrl.Antecedent(np.arange(0, 101, 1), 'nilai_rata_rata') 

# Rentang gaji 0-10 juta Rupiah
pendapatan_orangtua = ctrl.Antecedent(np.arange(0, 11, 1), 'pendapatan_orangtua')  

# Variabel output
kecocokan_beasiswa = ctrl.Consequent(np.arange(0, 101, 1), 'kecocokan_beasiswa')

# Fungsi keanggotaan untuk nilai rata-rata
# Angka pertama merupakan batas awal dari rentang keanggotaan.
# Angka kedua menunjukkan titik puncak (nilai maksimum) dalam rentang keanggotaan. 
# Angka ketiga merupakan batas akhir dari rentang keanggotaan.
nilai_rata_rata['rendah'] = fuzz.trimf(nilai_rata_rata.universe, [0, 0, 50])
nilai_rata_rata['sedang'] = fuzz.trimf(nilai_rata_rata.universe, [25, 50, 75])
nilai_rata_rata['tinggi'] = fuzz.trimf(nilai_rata_rata.universe, [50, 100, 100])

# Fungsi keanggotaan untuk pendapatan orang tua
pendapatan_orangtua['rendah'] = fuzz.trimf(pendapatan_orangtua.universe, [0, 0, 5])
pendapatan_orangtua['sedang'] = fuzz.trimf(pendapatan_orangtua.universe, [3, 5, 10])
pendapatan_orangtua['tinggi'] = fuzz.trimf(pendapatan_orangtua.universe, [5, 10, 10])

# Fungsi keanggotaan untuk kecocokan beasiswa
kecocokan_beasiswa['rendah'] = fuzz.trimf(kecocokan_beasiswa.universe, [0, 0, 50])
kecocokan_beasiswa['sedang'] = fuzz.trimf(kecocokan_beasiswa.universe, [25, 50, 75])
kecocokan_beasiswa['tinggi'] = fuzz.trimf(kecocokan_beasiswa.universe, [50, 100, 100])

# Aturan Fuzzy
rule1 = ctrl.Rule(nilai_rata_rata['rendah'] | pendapatan_orangtua['rendah'], kecocokan_beasiswa['rendah'])
rule2 = ctrl.Rule(nilai_rata_rata['sedang'] & pendapatan_orangtua['sedang'], kecocokan_beasiswa['sedang'])
rule3 = ctrl.Rule(nilai_rata_rata['tinggi'] & pendapatan_orangtua['tinggi'], kecocokan_beasiswa['tinggi'])

# Sistem Kontrol
beasiswa_ctrl = ctrl.ControlSystem([rule1, rule2, rule3])
beasiswa = ctrl.ControlSystemSimulation(beasiswa_ctrl)

# Input dari Pengguna
nilai_rata_rata_input = float(input("Masukkan nilai rata-rata: "))
pendapatan_orangtua_input = float(input("Masukkan pendapatan orang tua (dalam jutaan Rupiah): "))

beasiswa.input['nilai_rata_rata'] = nilai_rata_rata_input
beasiswa.input['pendapatan_orangtua'] = pendapatan_orangtua_input

# Perhitungan Output
beasiswa.compute()

# Tampilkan Hasil
print("Kecocokan Beasiswa:", beasiswa.output['kecocokan_beasiswa'])
kecocokan_beasiswa.view(sim=beasiswa)
input("Tekan Enter untuk keluar")

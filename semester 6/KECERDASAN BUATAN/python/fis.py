from matplotlib import pyplot as plt

class BaseFuzzy():
    def __init__(self):
        self.maximum = 0
        self.minimum = 0

    def up(self, x):
        return (x - self.minimum )/ (self.maximum - self.minimum)
    def down(self, x):
        return (self.maximum - x)/ (self.maximum - self.minimum)

class Permintaan(BaseFuzzy):

    def __init__(self):
        self.p1 = 2100
        self.p2 = 3500
        self.pn = 4000
    def turun(self, x):
        if x >= self.p2:
            return 0
        elif x<= self.p1:
            return 1
        else:
            self.maximum = self.p2
            self.minimum = self.p1
            return self.down(x)

    def naik(self, x):
        if x >= self.p2:
            return 1
        elif x<= self.p1:
            return 0
        else:
            self.maximum = self.p2
            self.minimum = self.p1
            return self.up(x)
    
    def graph(self, ax, value=None):
        # turun
        x = [0, self.p1, self.p2, self.pn]
        y_trn = [1, 1, 0, 0]
        ax.plot(x, y_trn, label='turun')
        # naik
        y_naik = [0, 0, 1, 1]
        ax.plot(x, y_naik, label='naik')
        ax.set_title('Permintaan')
        ax.legend(loc='upper left')
        if value:
            # turun
            x_param = [0, value, value]
            turun_value = self.turun(value)
            y_param_turun = [turun_value, turun_value, 0]
            ax.plot(x_param, y_param_turun, color='C0')
            # naik
            naik_value = self.naik(value)
            y_param_naik = [naik_value, naik_value, 0]
            ax.plot(x_param, y_param_naik, color='C1')

class Persediaan(BaseFuzzy):

    def __init__(self):
        self.p1 = 100
        self.p2 = 250
        self.pn = 300

    def sedikit(self, x):
        if x >= self.p2:
            return 0
        elif x<= self.p1:
            return 1
        else:
            self.minimum = self.p1
            self.maximum = self.p2
            return self.down(x)

    def banyak(self, x):
        if x >= self.p2:
            return 1
        elif x<= self.p1:
            return 0
        else:
            self.minimum = self.p1
            self.maximum = self.p2
            return self.up(x)
        
    def graph(self, ax, value=None):
        # sedikit
        x = [0, self.p1, self.p2, self.pn]
        y_sdk = [1, 1, 0, 0]
        ax.plot(x, y_sdk, label='sedikit', color='C0')
        # banyak
        y_byk = [0, 0, 1, 1]
        ax.plot(x, y_byk, label='banyak', color='C1')
        ax.legend(loc='upper left')
        ax.set_title('Persediaan')
        if value:
            # sedikit
            x_param = [0, value, value]
            sedikit_value = self.sedikit(value)
            y_param_kurang = [sedikit_value, sedikit_value, 0]
            ax.plot(x_param, y_param_kurang, color='C0')
            # banyak
            banyak_value = self.banyak(value)
            y_param_banyak = [banyak_value, banyak_value, 0]
            ax.plot(x_param, y_param_banyak, color='C1')


# output
class Produksi(BaseFuzzy):
    minimum = 1000
    maximum = 5000
    permintaan = 0
    persediaan = 0

    def __init__(self):
        self.p1 = 1000
        self.p2 = 5000
        self.pn = 6000
        self.permintaan = 0
        self.persediaan = 0
        self.kurang = 0
        self.tambah = 0
        self.real_value = 0

    def _berkurang(self, a):
        self.kurang = self.p2 - a*(self.p2 - self.p1)
        return self.kurang


    def _bertambah(self, a):
        self.tambah =  a*(self.p2 - self.p1) + self.p1
        return self.tambah
    
    @property
    def fuzzy_berkurang(self):
        x = self.real_value
        if x >= self.p2:
            return 0
        elif x<= self.p1:
            return 1
        else:
            self.minimum = self.p1
            self.maximum = self.p2
            return self.down(x)
    
    @property
    def fuzzy_bertambah(self):
        x = self.real_value
        if x >= self.p2:
            return 1
        elif x<= self.p1:
            return 0
        else:
            self.minimum = self.p1
            self.maximum = self.p2
            return self.up(x)
    

    def _inferensi(self, pmt=Permintaan(), psd=Persediaan()):
        result = []
        # [R1] JIKA Permintaan TURUN, dan Persediaan BANYAK, MAKA
        # Produksi Barang BERKURANG.
        a1 = min(pmt.turun(self.permintaan), psd.banyak(self.persediaan))
        z1 = self._berkurang(a1)
        result.append((a1, z1))
        # [R2] JIKA Permintaan TURUN, dan Persediaan SEDIKIT, MAKA
        # Produksi Barang BERKURANG.
        a2 = min(pmt.turun(self.permintaan), psd.sedikit(self.persediaan))
        z2 = self._berkurang(a2)
        result.append((a2, z2))
        # [R3] JIKA Permintaan NAIK, dan Persediaan BANYAK, MAKA
        # Produksi Barang BERTAMBAH.
        a3 = min(pmt.naik(self.permintaan), psd.banyak(self.persediaan))
        z3 = self._bertambah(a3)
        result.append((a3, z3))
        # [R4] JIKA Permintaan NAIK, dan Persediaan SEDIKIT, MAKA
        # Produksi Barang BERTAMBAH.
        a4 = min(pmt.naik(self.permintaan), psd.sedikit(self.persediaan))
        z4 = self._bertambah(a4)
        result.append((a4, z4))
        return result
    
    def defuzifikasi(self, data_inferensi=[]):
        # (α1∗z1+α2∗z2+α3∗z3+α4∗z4) / (α1+α2+α3+α4)
        data_inferensi = data_inferensi if data_inferensi else self._inferensi()
        res_a_z = 0
        res_a = 0
        for data in data_inferensi:
            # data[0] = a 
            # data[1] = z
            res_a_z += data[0] * data[1]
            res_a += data[0]
        self.real_value = res_a_z/res_a
        return self.real_value
    
    def graph(self):
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2)
        pmt = Permintaan()
        psd = Persediaan()

        pmt.graph(ax1, self.permintaan)
        psd.graph(ax2, self.persediaan)
        # berkurang
        x = [0, self.p1, self.p2, self.pn]
        y_krg = [1, 1, 0, 0]
        ax3.plot(x, y_krg, label='berkurang', color='C0')
        # bertambah
        y_tmb = [0, 0, 1, 1]
        ax3.plot(x, y_tmb, label='bertambah', color='C1')
        ax3.set_title('Produksi [Output]')
        ax3.legend(loc='upper left')
        if self.real_value:
            value = self.real_value
            # kurang
            x_param = [0, value, value]
            kurang_value = self.fuzzy_berkurang
            y_param_kurang = [kurang_value, kurang_value, 0]
            ax3.plot(x_param, y_param_kurang, color='C0')
            # tambah
            tambah_value = self.fuzzy_bertambah
            y_param_tambah = [tambah_value, tambah_value, 0]
            ax3.plot(x_param, y_param_tambah, color='C1')

        plt.show()


permintaan = input('Permintaan:')
persediaan = input('Persediaan:')
produksi = Produksi()



produksi.permintaan = float(permintaan) # 2500
produksi.persediaan = float(persediaan) # 160
hasil_produksi = produksi.defuzifikasi()

print(f'Hasil produksi {hasil_produksi}')

produksi.graph()
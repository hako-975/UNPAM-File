#include <iostream>
#include <cmath>

using namespace std;

int main() {
    double hasil_awal = 567.89669420;
    double hasil_bulat = round(hasil_awal * 1000) / 1000;
    double galat_pembulatan = hasil_awal - hasil_bulat;
    cout << "Hasil awal: " << hasil_awal << endl;
    cout << "Hasil yang dibulatkan: " << hasil_bulat << endl;
    cout << "Galat pembulatan: " << galat_pembulatan << endl;
    return 0;
}


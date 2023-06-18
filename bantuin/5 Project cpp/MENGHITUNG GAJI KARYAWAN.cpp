#include <iostream>
using namespace std;

int main() {
    int jamKerja;
    double tarifPerJam, gaji;
    cout << "Masukkan jumlah jam kerja: ";
    cin >> jamKerja;
    cout << "Masukkan tarif per jam: ";
    cin >> tarifPerJam;
    if (jamKerja <= 0 || tarifPerJam <= 0) {
        cout << "Jumlah jam kerja dan tarif per jam harus lebih dari nol." << endl;
        return 0;
    }
    if (jamKerja <= 40) {
        gaji = jamKerja * tarifPerJam;
    } else {
        gaji = 40 * tarifPerJam + (jamKerja - 40) * 1.5 * tarifPerJam;
    }
    cout << "Gaji karyawan adalah: " << gaji << endl;
    return 0;
}


#include <iostream>
using namespace std;

int main() {
    double pemakaianListrik, tagihan;
    cout << "Masukkan jumlah pemakaian listrik (kWh): ";
    cin >> pemakaianListrik;
    if (pemakaianListrik <= 0) {
        cout << "Jumlah pemakaian listrik harus lebih dari nol." << endl;
        return 0;
    }
    if (pemakaianListrik <= 50) {
        tagihan = pemakaianListrik * 1000;
    } else if (pemakaianListrik <= 100) {
        tagihan = 50 * 1000 + (pemakaianListrik - 50) * 1500;
    } else {
        tagihan = 50 * 1000 + 50 * 1500 + (pemakaianListrik - 100) * 2000;
    }
    cout << "Tagihan listrik adalah: " << tagihan << " rupiah." << endl;
    return 0;
}


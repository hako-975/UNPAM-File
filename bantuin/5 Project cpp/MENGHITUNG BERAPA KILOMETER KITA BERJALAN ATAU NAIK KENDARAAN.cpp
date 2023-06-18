#include <iostream>
using namespace std;

int main() {
    float kecepatan, waktu, jarak;
    cout << "Masukkan kecepatan kendaraan (km/jam): ";
    cin >> kecepatan;
    cout << "Masukkan waktu perjalanan (jam): ";
    cin >> waktu;
    jarak = kecepatan * waktu;
    cout << "Jarak yang ditempuh adalah " << jarak << " km." << endl;
    return 0;
}


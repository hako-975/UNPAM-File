#include <iostream>
using namespace std;

int main() {
    float tinggi, beratIdeal;
    char jenisKelamin;
    cout << "Masukkan tinggi badan (cm): ";
    cin >> tinggi;
    cout << "Masukkan jenis kelamin (L/P): ";
    cin >> jenisKelamin;
    if (jenisKelamin == 'L' || jenisKelamin == 'l') {
        beratIdeal = (tinggi - 100) - ((tinggi - 100) * 0.1);
    } else if (jenisKelamin == 'P' || jenisKelamin == 'p') {
        beratIdeal = (tinggi - 100) - ((tinggi - 100) * 0.15);
    } else {
        cout << "Jenis kelamin yang dimasukkan tidak valid." << endl;
        return 0;
    }
    cout << "Berat badan ideal adalah " << beratIdeal << " kg." << endl;
    return 0;
}


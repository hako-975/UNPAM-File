#include <iostream>
#include <string>
using namespace std;

int main() {
    string jenisMakanan;
    cout << "Masukkan jenis makanan hewan: ";
    cin >> jenisMakanan;
    if (jenisMakanan == "rumput" || jenisMakanan == "daun") {
        cout << "Hewan tersebut adalah herbivora." << endl;
    } else if (jenisMakanan == "daging" || jenisMakanan == "ikan") {
        cout << "Hewan tersebut adalah karnivora." << endl;
    } else {
        cout << "Jenis makanan yang dimasukkan tidak valid." << endl;
        return 0;
    }
    return 0;
}


#include <iostream>
#include <cmath>

using namespace std;

int main() {
    double hasil_pengukuran = 40;
    double nilai_sebenarnya = 42;
    double galat_mutlak = fabs(hasil_pengukuran - nilai_sebenarnya);
    double galat_relatif = (galat_mutlak / nilai_sebenarnya) * 100;
    cout << "Galat Mutlak: " << galat_mutlak << endl;
    cout << "Galat Relatif: " << galat_relatif << "%" << endl;
    return 0;
}


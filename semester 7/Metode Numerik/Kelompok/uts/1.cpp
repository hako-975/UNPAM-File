#include <iostream>
#include <cmath>

using namespace std;

int main() {
    double hasil_pengukuran = 23;
    double nilai_sebenarnya = 25;
    double galat_mutlak = fabs(hasil_pengukuran - nilai_sebenarnya);
    cout << "Galat Mutlak: " << galat_mutlak << endl;
    return 0;
}


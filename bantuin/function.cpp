#include<iostream>

using namespace std;

float hitungGaji(int jamKerja, float tarifPerJam) 
{
	float gaji = 0;
	gaji = jamKerja * tarifPerJam;
	return gaji;
}

int main() 
{
	int jamKerja;
	float tarifPerJam;
	cout << "Masukkan jumlah jam kerja: ";
    cin >> jamKerja;
    cout << "Masukkan tarif per jam: ";
    cin >> tarifPerJam;
    
	cout << "Gaji karyawan adalah: " << hitungGaji(jamKerja, tarifPerJam);
    
}

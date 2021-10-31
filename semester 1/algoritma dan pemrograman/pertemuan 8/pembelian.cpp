#include<iostream>

using namespace std;

int main()
{
	int harga_barang, jumlah_barang, total_harga;
	
	cout<<"Masukkan Jumlah Barang : ";
	cin>>jumlah_barang;
	
	cout<<"Masukkan Harga Barang : ";
	cin>>harga_barang;
	
	total_harga = jumlah_barang * harga_barang;
	
	if(jumlah_barang > 100)
	{
		total_harga -= total_harga * 15 / 100;
	}
	else
	{
		total_harga -= total_harga * 5 / 100;
	}
	cout<<"Total harga : "<<total_harga;
}


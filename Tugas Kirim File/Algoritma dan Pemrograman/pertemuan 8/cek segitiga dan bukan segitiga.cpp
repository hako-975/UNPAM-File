#include<iostream>
using namespace std;

int main()
{
	int garis_1, garis_2, garis_3;
	
	cout<<"Masukkan garis pertama	: ";
	cin>>garis_1;
	
	cout<<"Masukkan garis kedua	: ";
	cin>>garis_2;
	
	cout<<"Masukkan garis ketiga	: ";
	cin>>garis_3;
	
	cout<<"Bentuk			: ";
	if(garis_1 < 1 || garis_2 < 1 || garis_3 < 1)
	{
		cout<<"Bukan Segitiga";
	} 
	else
	{
		cout<<"Segitiga";
	}
}


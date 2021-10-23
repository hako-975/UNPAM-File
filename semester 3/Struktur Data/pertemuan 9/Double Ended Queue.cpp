#include<iostream>
#include<stdlib.h>
#define n 15
using namespace std;

void inisialisasi();
void INSERTL();
void INSERTR();
void CETAKLAYAR();
void DELETEL();
void DELETER();
void reset();
void posisiKiri();
void posisiKanan();
int pil, L, R;
char pilihan[1];
int Q[n];
int x;

int main() 
{
	inisialisasi();
	do
	{
		cout<<"Aplikasi Circular Queue"<<endl;
		cout<<"------------------------------"<<endl;
		cout<<"1. Insert Kiri Antrian"<<endl;
		cout<<"2. Insert Kanan Antrian"<<endl;
		cout<<"3. Delete Kiri Antrian"<<endl;
		cout<<"4. Delete Kanan Antrian"<<endl;
		cout<<"5. Cetak Antrian"<<endl;
		cout<<"6. Posisi Kiri"<<endl;
		cout<<"7. Posisi Kanan"<<endl;
		cout<<"8. Quit"<<endl;
		cout<<"------------------------------"<<endl;
		cout<<"Masukkan Pilihan Anda   : ";
		cin>>pilihan;
		pil = atoi(pilihan);
		switch (pil)
		{
			case 1 :
				INSERTL ();
				break;
			case 2 :
				INSERTR ();
				break;
			case 3 :
				DELETEL ();
				break;
			case 4 :
				DELETER ();
				break;
			case 5 :
				CETAKLAYAR ();
				break;
			case 6 :
				posisiKiri ();
				break;
			case 7 :
				posisiKanan ();
				break;
			default :
				pil = 0;
				cout<<"Thank you"<<endl;
				break;	
		}
		
		system("pause");
		system("cls");
	}
	while (pil > 0);
}

void INSERTL() 
{
	if (L > 0)
	{
		cout<<"Masukkan elemen antrian : ";
		cin>>x;
		Q[--L]=x;
	}
	else
	{
		cout<<"Antrian kiri penuh!"<<endl;
	}
}

void INSERTR() 
{
	if (R < n - 1)
	{
		cout<<"Masukkan elemen antrian : ";
		cin>>x;
		Q[++R]=x;
	}
	else
	{
		cout<<"Antrian kiri penuh!"<<endl;
	}
}

void DELETEL() 
{
	if (L < R + 1)
	{
		x = Q[L++];
		cout<<"Data yang diambil : "<<x<<endl;
		Q[--L] = 0;
		Q[L++];
	}
	else
	{
		cout<<"Antrian kosong!"<<endl;
	}
}

void DELETER() 
{
	if (L < R + 1)
	{
		x = Q[R--];
		cout<<"Data yang diambil : "<<x<<endl;
		Q[++R] = 0;
		Q[R--];
	}
	else
	{
		cout<<"Antrian kosong!"<<endl;
	}
}

void CETAKLAYAR() 
{
	for (int i = 0; i < n; i++)
	{
		cout<<"Q["<<i<<"] = "<<Q[i]<<endl;
	}
}

void inisialisasi() 
{
	L=0;
	R=-1;
}

void reset() 
{
	L=0;
	R=-1;
}

void posisiKiri()
{
	cout<<L<<endl;
}

void posisiKanan()
{
	cout<<R<<endl;
}


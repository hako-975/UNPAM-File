#include<stdio.h>
#include<string.h>
#include<conio.h>

using namespace std;

int main()
{
	long int kode, jml, sks, semester;
	char nama[100];
	
	printf("Masukkan Kode 1-3 : ");
	scanf("%ld", &kode);
	
	printf("Jumlah SKS per semester 20-25 : ");
	scanf("%ld", &sks);
	
	if(kode == 1)
	{
		strcpy(nama, "Teknik Informatika");
		jml 	 = 30000 * sks;
		semester = jml * 2;
	}
	else if(kode == 2)
	{
		strcpy(nama, "Akuntansi");
		jml 	 = 20000 * sks;
		semester = jml * 2;
	}
	else if (kode == 3)
	{
		strcpy(nama, "Manajemen");
		jml 	 = 15000 * sks;
		semester = jml * 2;
	} 
	else
	{
		printf("Kode yang kamu masukkan salah!");
		return 0;
	}
	
	printf("*==================================*\n");
	printf("Nama Kursus : %s\n", nama);
	printf("Pembayaran dalam 1 semester: %ld\n", jml);
	printf("Pembayaran dalam 1 tahun: %ld\n", semester);	
	getch();
}


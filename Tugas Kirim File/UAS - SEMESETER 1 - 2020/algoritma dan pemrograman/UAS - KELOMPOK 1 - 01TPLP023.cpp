#include<iostream>
#include<string>
#include<conio.h>
#include<windows.h>

using namespace std;

void tampil(string mata_kuliah, 
			int sks, 
			string nim, 
			string nama_mhs, 
			float jumlah_kehadiran, 
			float nilai_tugas, 
			float nilai_uts, 
			float nilai_uas, 
			float nilai_angka, 
			char grade);

void gotoxy(int x, int y)
{
  static HANDLE h = NULL;  
  if(!h)
    h = GetStdHandle(STD_OUTPUT_HANDLE);
  COORD c = { x, y };  
  SetConsoleCursorPosition(h,c);
}

void cetak(int a, int b, char *teks)
{
	gotoxy(a, b);
	cout<<teks;
}

main()
{
	// mendeklarasi variabel
	string nim;
	string nama_mhs;
	string mata_kuliah;
	int sks;
	float jumlah_kehadiran;
	float nilai_tugas;
	float nilai_uts;
	float nilai_uas;
	
	float nilai_angka;
	char grade;

	do
	{	
		gotoxy(33, 1);
		cout<<"PROGRAM NILAI HASIL PERKULIAHAN MAHASISWA"<<endl;
		gotoxy(50, 2);
		cout<<"KELOMPOK 1"<<endl;
		// input nim
		gotoxy(2,4);
		cout<<"Masukkan NIM";
		gotoxy(28,4);
		cout<<" : ";
		cin>>nim;
		
		// meng-ignore karakter agar dapat menginput getline pd baris berikutnya
		cin.ignore(256, '\n');
		
		// jika nim bernilai negatif, keluar aplikasi
		if(nim < "0")
		{
			return 0;
		}
		
		// input nama_mhs
		gotoxy(2,5);
		cout << "Masukkan Nama Mahasiswa";
		gotoxy(28,5);
		cout<<" : ";
		getline(cin, nama_mhs);
		
		// input mata_kuliah
		gotoxy(2,6);
		cout << "Masukkan Mata Kuliah";
		gotoxy(28,6);
		cout<<" : ";
		getline(cin, mata_kuliah);
	
		// input sks
		gotoxy(2,7);
		cout<<"Masukkan SKS";
		gotoxy(28,7);
		cout<<" : ";
		cin>>sks;
	
		// input jumlah_kehadiran
		gotoxy(2,8);
		cout<<"Masukkan Jumlah Kehadiran";
		gotoxy(28,8);
		cout<<" : ";
		cin>>jumlah_kehadiran;
	
		// input nilai_tugas
		gotoxy(2,9);
		cout<<"Masukkan Nilai Tugas";
		gotoxy(28,9);
		cout<<" : ";
		cin>>nilai_tugas;
	
		// input nilai_uts
		gotoxy(2,10);
		cout<<"Masukkan Nilai UTS";
		gotoxy(28,10);
		cout<<" : ";
		cin>>nilai_uts;
	
		// input nilai_uas
		gotoxy(2,11);
		cout<<"Masukkan Nilai UAS";
		gotoxy(28,11);
		cout<<" : ";
		cin>>nilai_uas;
		
		if(jumlah_kehadiran && nilai_tugas && nilai_uts && nilai_uas > 0)
		{
			/* 
			untuk yg jml hadir, 
			jadi jika jml hadir kurang dari empat, maka nilainya otomatis berkurang
			contoh: 2 - 4 = -2 * 10 = -20 * 10% = -2
			nilai akan ditambahkan -2			    
			*/
			nilai_angka = (((jumlah_kehadiran - 4) * 10) * 0.1) + 
						  (nilai_tugas * 0.2) + 
						  (nilai_uts * 0.3) + 
						  (nilai_uas * 0.4);
						  
			if(nilai_angka > 80)
			{
				grade = 'A';
			}
			else if(nilai_angka >= 70 && nilai_angka < 80)
			{
				grade = 'B';
			}
			else if(nilai_angka >= 60 && nilai_angka < 70)
			{
				grade = 'C';
			}
			else if(nilai_angka >= 50 && nilai_angka < 60)
			{
				grade = 'D';
			}
			else if(nilai_angka < 50)
			{
				grade = 'E';
			}
		}
		else 
		{
			grade = 'D';
		}		
		
		gotoxy(2,13);
		cout<<"=================================================================================================";

		tampil(mata_kuliah, 
			sks, 
			nim, 
			nama_mhs, 
			jumlah_kehadiran, 
			nilai_tugas, 
			nilai_uts, 
			nilai_uas, 
			nilai_angka, 
			grade);	
		cout<<endl;
		system("pause");
		system("cls");
	} 
	// jika nim diatas angka 0, maka lakukan perulangan
	while(nim > "0");
	
	return 0;
}

void tampil(string mata_kuliah, 
			int sks, 
			string nim, 
			string nama_mhs, 
			float jumlah_kehadiran, 
			float nilai_tugas, 
			float nilai_uts, 
			float nilai_uas, 
			float nilai_angka, 
			char grade)
{
	cetak(4,15,"NAMA MATA KULIAH : ");
	cout<<mata_kuliah;
	cetak(4,16,"SKS");
	cetak(20,16, " : ");
	cout<<sks;
	cetak(4,17,"===============================================================================================");
	cetak(4,18,"|");
	cetak(10,18,"NIM");
	cetak(19,18,"|");
	cetak(27,18,"N A M A");
	cetak(44,18,"|");
	cetak(46,18,"JML HADIR");
	cetak(56,18,"|");
	cetak(58,18,"TUGAS");
	cetak(64,18,"|");
	cetak(66,18,"UTS");
	cetak(70,18,"|");
	cetak(72,18,"UAS");
	cetak(76,18,"|");
	cetak(78,18,"NILAI ANGKA");
	cetak(90,18,"|");
	cetak(92,18,"GRADE");
	cetak(98,18,"|");
	cetak(4,19,"===============================================================================================");
	cout<<endl;
	cetak(4,20,"|");
	cetak(6,20,""); cout<<nim;
	
	cetak(19,20,"|");
	cetak(21,20,""); cout<<nama_mhs;
	
	cetak(44,20,"|");
	cetak(46,20,""); cout<<jumlah_kehadiran;
	
	cetak(56,20,"|");
	cetak(58,20,""); cout<<nilai_tugas;
	
	cetak(64,20,"|");
	cetak(66,20,""); cout<<nilai_uts;
	
	cetak(70,20,"|");
	cetak(72,20,""); cout<<nilai_uas;
	
	cetak(76,20,"|");
	cetak(78,20,""); cout<<nilai_angka;
	
	cetak(90,20,"|");
	cetak(92,20,""); cout<<grade;
	
	cetak(98,20,"|");
	cetak(4,21,"===============================================================================================");
	cout<<endl;
}



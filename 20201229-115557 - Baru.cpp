#include<iostream>
#include<windows.h>
using namespace std;

void gotoxy(int x, int y)
{
  static HANDLE h = NULL;  
  if(!h)
    h = GetStdHandle(STD_OUTPUT_HANDLE);
  COORD c = { x, y };  
  SetConsoleCursorPosition(h,c);
}

int main()
{
    char nama[30];
    char mapel[30];
   	char NIM[12];
    char grade;
    int t, ut, ua, nilaiakhir, h, sks, hadir, tugas, uts, uas;
    do
    {
        cout<<"//-----------------------------------//\n";
        cout<<"Nama Mahasiswa      : ";
        cin>>nama;
        cout<<"NIM                 : ";
        cin>>NIM;
        cout<<"Nama Matakuliah     : ";
        cin>>mapel;
        cout<<"SKS                 : ";
        cin>>sks;
        cout<<"Jumlah Kehadiran    : ";
        cin>>h;
        cout<<"Masukan Nilai Tugas : ";
        cin>>t;
        cout<<"Masukan Nilai UTS   : ";
        cin>>ut;
        cout<<"Masukan Nilai UAS   : ";
        cin>>ua;

        hadir = h * 0.1;
        tugas = t* 0.2;
        uts = ut * 0.3;
        uas = ua * 0.4;
        nilaiakhir = (hadir+tugas+uts+uas);
        
        
        /*
        cout<<"//----------------HASIL----------------//\n";
        cout<<"\nNama Mahasiswa   : " <<nama;
        cout<<"\nNIM              : " <<NIM;
        cout<<"\nNama Mata Kuliah : " <<mapel;
        cout<<"\nSKS              : " <<sks;
        cout<<"\nJumlah kehadiran : " <<h;
        cout<<"\nNilai Tugas      : " <<t;
        cout<<"\nNilai UTS        : " <<ut;
        cout<<"\nNIlai UAS        : " <<ua;
        cout<<"\n//-----------------------------------//";
        */
        if (nilaiakhir>=80) {
            grade = 'A';
        }
        else if((nilaiakhir<80)&&(nilaiakhir>=70)) {
            grade = 'B';
        }
        else if((nilaiakhir<70)&&(nilaiakhir>=60)) {
            grade = 'C';
        }
        else if((nilaiakhir<60)&&(nilaiakhir>=50)) {
            grade = 'D';
        }
        else {
            grade = 'E';
        }
        
        gotoxy(4,13);
        cout<<"NAMA MATA KULIAH : ";
        cout<<mapel;
        gotoxy(4,14);
        cout<<"SKS";
        gotoxy(20,14);
        cout<< " : ";
        cout<<sks;
        gotoxy(4,15);
        cout<<"===============================================================================================";
        gotoxy(4,16);
        cout<<"|";
        gotoxy(10,16);
        cout<<"NIM";
        gotoxy(19,16);
        cout<<"|";
        gotoxy(27,16);
        cout<<"N A M A";
        gotoxy(44,16);
        cout<<"|";
        gotoxy(46,16);
        cout<<"JML HADIR";
        gotoxy(56,16);
        cout<<"|";
        gotoxy(58,16);
        cout<<"TUGAS";
        gotoxy(64,16);
        cout<<"|";
        gotoxy(66,16);
        cout<<"UTS";
        gotoxy(70,16);
        cout<<"|";
        gotoxy(72,16);
        cout<<"UAS";
        gotoxy(76,16);
        cout<<"|";
        gotoxy(78,16);
        cout<<"NILAI ANGKA";
        gotoxy(90,16);
        cout<<"|";
        gotoxy(92,16);
        cout<<"GRADE";
        gotoxy(98,16);
        cout<<"|";
        gotoxy(4,17);
        cout<<"===============================================================================================";
        cout<<endl;
        gotoxy(4,18);
        cout<<"|";
        gotoxy(6,18); 
        cout<<"";
        cout<<NIM;
        gotoxy(19,18);
        cout<<"|";
        gotoxy(21,18); 
        cout<<"";
        cout<<nama;
        gotoxy(44,18);
        cout<<"|";
        gotoxy(46,18);
        cout<<"";
        cout<<h;
        gotoxy(56,18);
        cout<<"|";
        gotoxy(58,18);
        cout<<"";
        cout<<t;
        gotoxy(64,18);
        cout<<"|";
        gotoxy(66,18);
        cout<<"";
        cout<<ut;
        gotoxy(70,18);
        cout<<"|";
        gotoxy(72,18);
        cout<<"";
        cout<<ua;
        gotoxy(76,18);
        cout<<"|";
        gotoxy(78,18);
        cout<<"";
        cout<<nilaiakhir;
        gotoxy(90,18);
        cout<<"|";
        gotoxy(92,18);
        cout<<"";
        cout<<grade;
        gotoxy(98,18);
        cout<<"|";
        gotoxy(4,19);
        cout<<"===============================================================================================";
        cout<<endl;
        cout<<endl;
        system("pause");
        system("cls");
    } while(NIM > 0);

    return 0;

}

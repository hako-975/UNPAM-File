#include<iostream>
#include <bits/stdc++.h>

using namespace std;

void sortStringAsc(string s)
{
    int N = s.length();
 
    vector<int> freq(256, 0);
 
    for (int i = 0; i < N; i++) 
	{
        freq[s[i]]++;
    }
 
    s = "";
 
    for (int i = 0; i < 256; i++) 
	{
        for (int j = 0; j < freq[i]; j++)
        {
        	s = s + (char)i;
		}
    }
 
    cout<<"Hasil: "<<s<<endl;
 
    return;
}

void sortStringDesc(string s)
{
    int N = s.length();
 
    vector<int> freq(256, 0);
 
    for (int i = 0; i < N; i++) 
	{
        freq[s[i]]++;
    }
 
    s = "";
 
    for (int i = 256; i > 0; i--) 
	{
        for (int j = 0; j < freq[i]; j++)
        {
        	s = s + (char)i;
		}
    }
	
	
    cout<<"Hasil: "<<s<<endl;
 
    return;
}

int main()
{
	int pilih;
	char lagi;
	string input;
	
	do {
		system("cls");
		cout<<"------------------------------"<<endl;
		cout<<"| Aplikasi pengurutan simbol |"<<endl;
		cout<<"------------------------------"<<endl;
		cout<<"1. Pengurutan Ascending (Menaik)"<<endl;
		cout<<"2. Pengurutan Descending (Menurun)"<<endl;
		cout<<"------------------------------"<<endl;
		cout<<"Pilih menu di atas: ";
		cin>>pilih;
		cout<<"------------------------------"<<endl;
		cout<<"Masukkan simbol-simbol: "<<endl;
		cin>>input;
		switch(pilih) {
			case 1:
				sortStringAsc(input);
				break;
			case 2:
				sortStringDesc(input);
				break;
			default:
				break;
		}
		
		cout << "Menghitung lagi? Y/t"<<endl;
		cin >> lagi;
	} while (lagi == 'y' || lagi == 'Y');
	cout<<"------------------------------"<<endl;
	cout<<"Terima kasih telah menggunakan aplikasi pengurutan simbol"<<endl;
	system("pause");
}

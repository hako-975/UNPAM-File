#include<iostream>

using namespace std;

int main()
{
	int N;
	
	cout<<"Masukkan Nilai N : ";
	cin>>N;
	
	if(N > 50)
	{
		N += 10;
	}
	else 
	{
		N += 25;
	}
	
	cout<<"Nilai N : "<<N;
}


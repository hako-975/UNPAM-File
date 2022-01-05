#include<iostream>
#include<stdlib.h>
#include<conio.h>

using namespace std;

struct SIMPUL
{
	int data;
	struct SIMPUL* link;
};
struct SIMPUL* top;

void push(int data)
{
	
	struct SIMPUL* temp;
	temp = new SIMPUL();

	if (!temp)
	{
		cout << "\n Stack Penuh!";
		exit(1);
	}

	temp->data = data;

	temp->link = top;

	top = temp;
}

int isEmpty()
{
	return top == NULL;
}


int peek()
{
	
	if (!isEmpty())
		return top->data;
	else
		exit(1);
}

void pop()
{
	struct SIMPUL* temp;

	if (top == NULL)
	{
		cout << "\n Stack Kosong" << endl;
		exit(1);
	}
	else
	{
		
		temp = top;

		top = top->link;

		temp->link = NULL;

		free(temp);
		
		cout << "Data berhasil dihapus" << endl;
	}
}


void display()
{
	struct SIMPUL* temp;
	cout<<"---------------------------"<<endl;
	if (top == NULL)
	{
		cout << "\n Stack Kosong";
		exit(1);
	}
	else
	{
		temp = top;
		while (temp != NULL)
		{

			cout << temp->data << endl;

			temp = temp->link;
		}
	}
	cout<<"---------------------------"<<endl;
}

int main()
{
	int pilih, nilai;
    do 
    {
    	cout<<"Program Linked List - Stack"<<endl;
        cout<<"1. Push"<<endl;
		cout<<"2. Pop"<<endl;
		cout<<"3. Tampilkan Data"<<endl;
		cout<<"4. Exit"<<endl;
		cout<<"======================"<<endl;
		cout<<"Pilih: "; 
		cin>>pilih;
        switch (pilih)
        {
            case 1:
            	cout<<"Masukkan Nilai: ";
            	cin>>nilai;
                push(nilai);
                cout<<"Tekan apa saja untuk melanjutkan"<<endl;
                getch();
                break;
            case 2:
                pop();
                cout<<"Tekan apa saja untuk melanjutkan"<<endl;
                getch();
                break;
            case 3:
            	display();
            	cout<<"Tekan apa saja untuk melanjutkan"<<endl;
            	getch();
            	break;
            case 4:
                cout<<"Terima Kasih!"<<endl;
                getch();
                break;
            default:
                cout<<"Pilihan tidak ada!"<<endl;
                cout<<"Masukan pilihan sesuai dengan daftar"<<endl;
                getch();
                break;
        }
        system("cls");
    }
    while (pilih != 4);
	
		
	return 0;
}



#include <iostream>
#define MAX_SIZE 5

using namespace std;

struct Tumpukan
{
    int data[MAX_SIZE];
    int top;
};

void inisialisasi(Tumpukan& tumpuk)
{
    tumpuk.top = -1;
}

bool isEmpty(Tumpukan& tumpuk)
{
    return tumpuk.top == -1;
}

bool isFull(Tumpukan& tumpuk)
{
    return tumpuk.top == MAX_SIZE - 1;
}

void push(Tumpukan& tumpuk, int elemen)
{
    if (isFull(tumpuk))
    {
        cout << "Tumpukan penuh!" << endl;
        return;
    }

    tumpuk.top++;
    tumpuk.data[tumpuk.top] = elemen;
    cout << "Data " << elemen << " berhasil di-push ke tumpukan." << endl;
}

void pop(Tumpukan& tumpuk)
{
    if (isEmpty(tumpuk))
    {
        cout << "Tumpukan kosong! Tidak ada elemen untuk di-pop." << endl;
        return;
    }

    int elemen = tumpuk.data[tumpuk.top];
    tumpuk.top--;
    cout << "Data " << elemen << " berhasil di-pop dari tumpukan." << endl;
}

void display(Tumpukan& tumpuk)
{
    if (isEmpty(tumpuk))
    {
        cout << "Tumpukan kosong." << endl;
        return;
    }

    cout << "Isi tumpukan: ";
    for (int i = tumpuk.top; i >= 0; i--)
    {
        cout << tumpuk.data[i] << " ";
    }
    cout << endl;
}

int main()
{
    Tumpukan tumpuk;
    inisialisasi(tumpuk);

    int pilihan, data;

    do
    {
        cout << "Menu:" << endl;
        cout << "1. Push data" << endl;
        cout << "2. Pop data" << endl;
        cout << "3. Tampilkan tumpukan" << endl;
        cout << "4. Keluar" << endl;
        cout << "Pilihan: ";
        cin >> pilihan;

        switch (pilihan)
        {
            case 1:
                cout << "Masukkan data: ";
                cin >> data;
                push(tumpuk, data);
                break;
            case 2:
                pop(tumpuk);
                break;
            case 3:
                display(tumpuk);
                break;
            case 4:
                cout << "Terima kasih. Program selesai." << endl;
                break;
            default:
                cout << "Pilihan tidak valid!" << endl;
                break;
        }
    } while (pilihan != 4);

    return 0;
}


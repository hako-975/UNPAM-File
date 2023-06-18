#include <iostream>

using namespace std;

struct Node {
    char isi;
    Node* kanan;
    Node* kiri;
};

void sisipKiri(Node*& L, char elemen) {
    Node* baru = new Node;
    baru->isi = elemen;
    baru->kanan = NULL;
    baru->kiri = NULL;
    if (L == NULL)
        L = baru;
    else {
        baru->kanan = L;
        L->kiri = baru;
        L = baru;
    }
}

void sisipKanan(Node*& L, char elemen) {
    Node* baru = new Node;
    baru->isi = elemen;
    baru->kanan = NULL;
    baru->kiri = NULL;
    if (L == NULL)
        L = baru;
    else {
        Node* bantu = L;
        while (bantu->kanan != NULL)
            bantu = bantu->kanan;
        bantu->kanan = baru;
        baru->kiri = bantu;
    }
}

void hapusKiri(Node*& L) {
    if (L == NULL)
        return;
    else {
        Node* hapus = L;
        L = L->kanan;
        if (L != NULL)
            L->kiri = NULL;
        hapus->kanan = NULL;
        delete hapus;
    }
}

void hapusKanan(Node*& L) {
    if (L == NULL) {
        cout << "Linked list kosong" << endl;
        return;
    }
    else {
        Node* bantu = L;
        while (bantu->kanan->kanan != NULL)
            bantu = bantu->kanan;
        Node* hapus = bantu->kanan;
        bantu->kanan = NULL;
        hapus->kiri = NULL;
        delete hapus;
    }
}

void tampilkanList(Node* L) {
    if (L == NULL) {
        cout << "Linked list kosong" << endl;
        return;
    }

    Node* bantu = L;
    while (bantu != NULL) {
        cout << bantu->isi << " ";
        bantu = bantu->kanan;
    }
    cout << endl;
}

void hapusList(Node*& L) {
    Node* bantu = L;
    while (bantu != NULL) {
        Node* hapus = bantu;
        bantu = bantu->kanan;
        delete hapus;
    }
    L = NULL;
}

int main() {
    Node* list = NULL;
    int pilihan;
    char elemen;

    do {
        cout << "Menu:" << endl;
        cout << "1. Sisipkan elemen di sebelah kiri" << endl;
        cout << "2. Sisipkan elemen di sebelah kanan" << endl;
        cout << "3. Hapus elemen di sebelah kiri" << endl;
        cout << "4. Hapus elemen di sebelah kanan" << endl;
        cout << "5. Tampilkan list" << endl;
        cout << "6. Hapus semua list" << endl;
        cout << "7. Keluar" << endl;
        cout << "Pilihan: ";
        cin >> pilihan;

        switch (pilihan) {
        case 1:
            cout << "Masukkan elemen: ";
            cin >> elemen;
            sisipKiri(list, elemen);
            break;
        case 2:
            cout << "Masukkan elemen: ";
            cin >> elemen;
            sisipKanan(list, elemen);
            break;
        case 3:
            hapusKiri(list);
            break;
        case 4:
            hapusKanan(list);
            break;
        case 5:
            tampilkanList(list);
            break;
        case 6:
            hapusList(list);
            break;
        case 7:
            return 0;
        default:
            cout << "Pilihan tidak valid!" << endl;
            break;
        }
        
    } while (true);

    return 0;
}


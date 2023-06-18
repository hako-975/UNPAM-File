#include <iostream>
using namespace std;

// Struktur Node
struct Node {
    int data;
    Node* left;
    Node* right;
};

// Fungsi untuk membuat node baru
Node* createNode(int data) {
    Node* newNode = new Node();
    if (!newNode) {
        cout << "Tidak dapat membuat node baru." << endl;
        return NULL;
    }
    newNode->data = data;
    newNode->left = newNode->right = NULL;
    return newNode;
}

// Fungsi untuk menambahkan node ke dalam pohon
Node* insertNode(Node* root, int data) {
    if (root == NULL) {
        root = createNode(data);
        return root;
    }
    if (data < root->data) {
        root->left = insertNode(root->left, data);
    } else if (data > root->data) {
        root->right = insertNode(root->right, data);
    }
    return root;
}

// Fungsi untuk mencari elemen dalam pohon
bool searchNode(Node* root, int data) {
    if (root == NULL) {
        return false;
    }
    if (data == root->data) {
        return true;
    } else if (data < root->data) {
        return searchNode(root->left, data);
    } else {
        return searchNode(root->right, data);
    }
}

// Fungsi untuk menampilkan elemen dalam pohon secara inorder
void inorderTraversal(Node* root) {
    if (root == NULL) {
        return;
    }
    inorderTraversal(root->left);
    cout << root->data << " ";
    inorderTraversal(root->right);
}

// Fungsi untuk menampilkan menu
void displayMenu() {
    cout << "\nMenu:\n";
    cout << "1. Tambahkan elemen ke dalam pohon\n";
    cout << "2. Cari elemen dalam pohon\n";
    cout << "3. Tampilkan pohon (Inorder traversal)\n";
    cout << "4. Keluar\n";
    cout << "Pilih menu: ";
}

// Fungsi utama
int main() {
    Node* root = NULL;
    int choice;
    int data, searchData;

    do {
        displayMenu();
        cin >> choice;

        switch (choice) {
            case 1:
                cout << "Masukkan elemen yang ingin ditambahkan: ";
                cin >> data;
                root = insertNode(root, data);
                break;
            case 2:
                cout << "Masukkan elemen yang ingin dicari: ";
                cin >> searchData;
                if (searchNode(root, searchData)) {
                    cout << searchData << " ditemukan dalam pohon." << endl;
                } else {
                    cout << searchData << " tidak ditemukan dalam pohon." << endl;
                }
                break;
            case 3:
                cout << "Pohon (Inorder traversal): ";
                inorderTraversal(root);
                cout << endl;
                break;
            case 4:
                cout << "Terima kasih. Program selesai.\n";
                break;
            default:
                cout << "Pilihan tidak valid. Silakan pilih kembali.\n";
                break;
        }
    } while (choice != 4);

    return 0;
}


#include <iostream>
using namespace std;

template <class Type>
struct nodeType {
    Type info;
    nodeType<Type> *link;
};

template <class Type>
class linkedQueueType {
public:
    linkedQueueType();
    ~linkedQueueType();
    bool isEmptyQueue() const;
    void addQueue(const Type& newElement);
    void deleteQueue();
    Type front() const;
    Type back() const;

private:
    nodeType<Type> *queueFront;
    nodeType<Type> *queueRear;
};

template <class Type>
linkedQueueType<Type>::linkedQueueType() {
    queueFront = NULL;
    queueRear = NULL;
}

template <class Type>
linkedQueueType<Type>::~linkedQueueType() {
    while (!isEmptyQueue()) {
        deleteQueue();
    }
}

template <class Type>
bool linkedQueueType<Type>::isEmptyQueue() const {
    return (queueFront == NULL);
}

template <class Type>
void linkedQueueType<Type>::addQueue(const Type& newElement) {
    nodeType<Type> *newNode;
    newNode = new nodeType<Type>;
    newNode->info = newElement;
    newNode->link = NULL;

    if (queueFront == NULL) {
        queueFront = newNode;
        queueRear = newNode;
    } else {
        queueRear->link = newNode;
        queueRear = queueRear->link;
    }
}

template <class Type>
void linkedQueueType<Type>::deleteQueue() {
    if (!isEmptyQueue()) {
        nodeType<Type> *temp;
        temp = queueFront;
        queueFront = queueFront->link;
        delete temp;

        if (queueFront == NULL) {
            queueRear = NULL;
        }
    } else {
        cout << "Cannot remove from an empty queue" << endl;
    }
}

template <class Type>
Type linkedQueueType<Type>::front() const {
    if (!isEmptyQueue()) {
        return queueFront->info;
    } else {
        cout << "Queue is empty." << endl;
        return Type();
    }
}

template <class Type>
Type linkedQueueType<Type>::back() const {
    if (!isEmptyQueue()) {
        return queueRear->info;
    } else {
        cout << "Queue is empty." << endl;
        return Type();
    }
}

int main() {
    linkedQueueType<int> queue;
    int pilihan;
    int elemen;

    do {
        cout << "=========== MENU ===========" << endl;
        cout << "1. Tambah Elemen ke Antrian" << endl;
        cout << "2. Hapus Elemen dari Antrian" << endl;
        cout << "3. Tampilkan Elemen Depan" << endl;
        cout << "4. Tampilkan Elemen Belakang" << endl;
        cout << "5. Periksa Apakah Antrian Kosong" << endl;
        cout << "6. Keluar" << endl;
        cout << "============================" << endl;

        cout << "Pilihan Anda: ";
        cin >> pilihan;

        switch (pilihan) {
            case 1:
                cout << "Masukkan elemen yang akan ditambahkan: ";
                cin >> elemen;
                queue.addQueue(elemen);
                cout << "Elemen ditambahkan ke dalam antrian." << endl;
                break;
            case 2:
                if (!queue.isEmptyQueue()) {
                    cout << "Elemen yang dihapus dari antrian: " << queue.front() << endl;
                    queue.deleteQueue();
                } else {
                    cout << "Antrian kosong. Tidak ada elemen yang dihapus." << endl;
                }
                break;
            case 3:
                if (!queue.isEmptyQueue()) {
                    cout << "Elemen depan antrian: " << queue.front() << endl;
                } else {
                    cout << "Antrian kosong." << endl;
                }
                break;
            case 4:
                if (!queue.isEmptyQueue()) {
                    cout << "Elemen belakang antrian: " << queue.back() << endl;
                } else {
                    cout << "Antrian kosong." << endl;
                }
                break;
            case 5:
                if (queue.isEmptyQueue()) {
                    cout << "Antrian kosong." << endl;
                } else {
                    cout << "Antrian tidak kosong." << endl;
                }
                break;
            case 6:
                cout << "Keluar dari program." << endl;
                break;
            default:
                cout << "Pilihan tidak valid. Silakan coba lagi." << endl;
                break;
        }

        cout << endl;

    } while (pilihan != 6);

    return 0;
}


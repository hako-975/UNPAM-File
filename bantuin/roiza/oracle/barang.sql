CREATE TABLE barang (
    kode_barang varchar(10) not null, 
    nama_barang varchar(50) not null,
    satuan_barang varchar(20) null,
    stok_barang int null,
    primary key (kode_barang)
);


CREATE TABLE supplier (
    kode_supplier varchar(10) not null,
    nama_supplier varchar(20) not null,
    alamat_supplier varchar(30) not null,
    primary key (kode_supplier)
);


CREATE TABLE customer (
    kode_customer varchar(10) not null, 
    nama_customer varchar(20) not null,
    alamat_customer varchar(30) not null,
    primary key (kode_customer)
);


CREATE TABLE pasok (
    kode_pasok VARCHAR(10) NOT NULL,
    kode_barang VARCHAR(10) NOT NULL,
    kode_supplier VARCHAR(10) NOT NULL,
    jumlah_pasok INT,
    PRIMARY KEY (kode_pasok),
    FOREIGN KEY (kode_barang) REFERENCES barang(kode_barang),
    FOREIGN KEY (kode_supplier) REFERENCES supplier(kode_supplier)
);


CREATE TABLE pembelian (
    kode_pembelian varchar(10) not null,
    kode_barang varchar(10) not null,
    kode_customer varchar(10) not null,
    jumlah_pembelian int,
    primary key (kode_pembelian)
);

INSERT INTO barang (kode_barang, nama_barang, satuan_barang, stok_barang) VALUES
('B001', 'Lemari Es', 'unit', 11);
select * from barang;

INSERT INTO barang (kode_barang, nama_barang, satuan_barang, stok_barang) VALUES
('B002', 'Rice Cooker', 'buah', 23);
select * from barang;

INSERT INTO barang (kode_barang, nama_barang) VALUES
('B003', 'TV');
select * from barang;

INSERT INTO barang (kode_barang, nama_barang, satuan_barang, stok_barang) VALUES
('B004', 'radio', 'buah', 21);
select * from barang;

INSERT INTO supplier VALUES ('s001', 'PT. Ani', 'Palembang');
INSERT INTO supplier VALUES ('s002', 'PT. Budi', 'Lampung');
INSERT INTO supplier VALUES ('s003', 'PT. Citra', 'Bandung');
select * from supplier;

INSERT INTO customer VALUES ('c001', 'Doni', 'Baturaja');
INSERT INTO customer VALUES ('c002', 'hana', 'palembang');
INSERT INTO customer VALUES ('c003', 'lili', 'jakarta');
select * from customer;


UPDATE barang SET satuan_barang = 'UNIT', stok_barang = 30 WHERE kode_barang = 'B003';
select * from barang;

INSERT INTO pasok VALUES ('P001', 'B010', 's001', 5);

INSERT INTO pasok VALUES ('P001', 'B002', 's001', 5);
INSERT INTO pasok VALUES ('P002', 'B003', 's002', 20);
INSERT INTO pasok VALUES ('P003', 'B002', 's002', 26);
select * from pasok;

INSERT INTO pembelian VALUES ('PB001', 'B001', 'c003', 30);
INSERT INTO pembelian VALUES ('PB002', 'B003', 'c002', 8);
INSERT INTO pembelian VALUES ('PB003', 'B003', 'c003', 14);
select * from pembelian;

select table_name from users_tables;

disconnect;

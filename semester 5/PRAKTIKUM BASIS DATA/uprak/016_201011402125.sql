-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 16 Des 2022 pada 02.32
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ujian_praktikum`
--

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `asset`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `asset` (
`jumlah asset` decimal(42,0)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `kodeBarang` varchar(10) NOT NULL,
  `namaBarang` varchar(50) NOT NULL,
  `harga` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `supplier` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`kodeBarang`, `namaBarang`, `harga`, `stock`, `supplier`) VALUES
('AC 001', 'Air Conditioner', 2000000, 5, 'CV Adi Jaya'),
('FZ 002', 'Freezzer', 2740000, 30, 'CV Sejahtera Bersama'),
('IC 003', 'Ice Box', 547000, 60, 'CV Adi Jaya'),
('KA 007', 'Kipas Angin', 173000, 74, 'CV Adi Jaya'),
('LP 005', 'Lemari Pendingin', 3019000, 20, 'CV Adi Jaya'),
('MC 006', 'Mesin Cuci', 3325000, 25, 'CV Sejahtera Bersama'),
('PN 008', 'Pemanas Nasi', 602000, 84, 'CV Adi Jaya'),
('SC 004', 'Showcase', 3400000, 55, 'CV Sejahtera Bersama');

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE `transaksi` (
  `kodeTtransaksi` varchar(10) NOT NULL,
  `kodeBarang` varchar(10) NOT NULL,
  `jumlahBarang` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `keterangan` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`kodeTtransaksi`, `kodeBarang`, `jumlahBarang`, `tanggal`, `keterangan`) VALUES
('2910001', 'AC 001', 5, '2022-10-29', 'Terkirim'),
('2910002', 'PN 008', 6, '2022-10-29', 'Belum Terkirim'),
('2910003', 'SC 004', 7, '2022-10-29', 'Belum Terkirim'),
('3010004', 'AC 001', 3, '2022-10-30', 'Terkirim'),
('3010005', 'PN 008', 4, '2022-10-30', 'Belum Terkirim'),
('3010006', 'AC 001', 2, '2022-10-30', 'Terkirim');

--
-- Trigger `transaksi`
--
DELIMITER $$
CREATE TRIGGER `mengurangi_stock` AFTER INSERT ON `transaksi` FOR EACH ROW update barang set 
barang.stock = barang.stock - NEW.jumlahBarang
where kodeBarang = NEW.kodeBarang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur untuk view `asset`
--
DROP TABLE IF EXISTS `asset`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `asset`  AS SELECT sum(`barang`.`harga` * `barang`.`stock`) AS `jumlah asset` FROM `barang` WHERE `barang`.`supplier` = 'CV Adi Jaya''CV Adi Jaya'  ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kodeBarang`);

--
-- Indeks untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`kodeTtransaksi`),
  ADD KEY `kodeBarang` (`kodeBarang`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`kodeBarang`) REFERENCES `barang` (`kodeBarang`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

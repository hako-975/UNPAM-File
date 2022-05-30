-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 29 Bulan Mei 2022 pada 17.06
-- Versi server: 10.4.24-MariaDB
-- Versi PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `andri_04tplp016`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `kodebar` varchar(10) NOT NULL,
  `namabar` varchar(30) NOT NULL,
  `hargabeli` int(11) NOT NULL,
  `hargajual` int(11) NOT NULL,
  `stok` int(11) NOT NULL,
  `saham` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`kodebar`, `namabar`, `hargabeli`, `hargajual`, `stok`, `saham`) VALUES
('1', 'Mouse Gaming AULA', 100000, 150000, 0, 0),
('2', 'Headset Gaming AULA', 400000, 450000, 5, 2000000),
('3', 'Keyboard Gaming AULA', 550000, 600000, 0, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `login`
--

CREATE TABLE `login` (
  `id_login` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `login`
--

INSERT INTO `login` (`id_login`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembelian`
--

CREATE TABLE `pembelian` (
  `kodepem` varchar(10) NOT NULL,
  `kodebar` varchar(10) NOT NULL,
  `jumlahbeli` int(11) NOT NULL,
  `totalhargabeli` int(11) NOT NULL,
  `tanggalbeli` date NOT NULL,
  `kodesup` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `pembelian`
--

INSERT INTO `pembelian` (`kodepem`, `kodebar`, `jumlahbeli`, `totalhargabeli`, `tanggalbeli`, `kodesup`) VALUES
('1', '1', 5, 500000, '2022-05-29', '1'),
('2', '2', 15, 6000000, '2022-05-29', '1'),
('3', '1', 10, 1000000, '2022-05-29', '1');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan`
--

CREATE TABLE `penjualan` (
  `kodepenjualan` varchar(10) NOT NULL,
  `kodebar` varchar(10) NOT NULL,
  `jumlahjual` int(11) NOT NULL,
  `tanggaljual` date NOT NULL,
  `diskon` int(11) NOT NULL,
  `totalhargajual` int(11) NOT NULL,
  `profit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `penjualan`
--

INSERT INTO `penjualan` (`kodepenjualan`, `kodebar`, `jumlahjual`, `tanggaljual`, `diskon`, `totalhargajual`, `profit`) VALUES
('1', '1', 4, '2022-05-29', 0, 600000, 200000),
('2', '1', 1, '2022-05-29', 0, 150000, 50000),
('3', '1', 5, '2022-05-29', 0, 750000, 250000),
('4', '2', 10, '2022-05-29', 0, 4500000, 500000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `kodesup` varchar(10) NOT NULL,
  `namasup` varchar(30) NOT NULL,
  `alamatsup` varchar(50) NOT NULL,
  `notelpsup` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`kodesup`, `namasup`, `alamatsup`, `notelpsup`) VALUES
('1', 'Andri Firman', 'Pocis', '087808675313'),
('2', 'Andre Farhan Saputra', 'Pocis', '087733932416'),
('3', 'Fiki Aji Panuntun', 'Buaran', '08964123421');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kodebar`);

--
-- Indeks untuk tabel `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`id_login`);

--
-- Indeks untuk tabel `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`kodepem`),
  ADD KEY `kodebar` (`kodebar`),
  ADD KEY `kodesup` (`kodesup`);

--
-- Indeks untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`kodepenjualan`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`kodesup`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `login`
--
ALTER TABLE `login`
  MODIFY `id_login` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

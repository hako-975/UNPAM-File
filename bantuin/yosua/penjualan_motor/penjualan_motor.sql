-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 03 Nov 2023 pada 09.46
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `penjualan_motor`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `motor`
--

CREATE TABLE `motor` (
  `id_motor` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `merk` varchar(50) NOT NULL,
  `tahun` int(11) NOT NULL,
  `harga` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `motor`
--

INSERT INTO `motor` (`id_motor`, `nama`, `merk`, `tahun`, `harga`) VALUES
(1, 'Ninja ZX-10R', 'Kawasaki', 2023, 15000000000),
(2, 'CBR1000RR', 'Honda', 2023, 16000000000),
(3, 'GSX-R1000', 'Suzuki', 2023, 15500000000),
(4, 'YZF-R1', 'Yamaha', 2023, 15800000000),
(5, 'Panigale V4', 'Ducati', 2023, 18000000000),
(6, 'S 1000 RR', 'BMW', 2023, 17000000000),
(7, 'Ninja 650', 'Kawasaki', 2023, 8000000000),
(8, 'CBR650R', 'Honda', 2023, 8200000000),
(9, 'GSX-S750', 'Suzuki', 2023, 8100000000),
(10, 'MT-09', 'Yamaha', 2023, 8200000000),
(11, 'Monster 821', 'Ducati', 2023, 9000000000),
(12, 'F 900 R', 'BMW', 2023, 8800000000),
(13, 'Vespa Primavera', 'Vespa', 2023, 5500000000),
(14, 'Scoopy', 'Honda', 2023, 4900000000),
(15, 'NMAX', 'Yamaha', 2023, 5300000000),
(16, 'Vario', 'Honda', 2023, 4700000000),
(17, 'PCX', 'Honda', 2023, 5500000000),
(18, 'Vespa GTS 300', 'Vespa', 2023, 8000000000),
(19, 'Burgman 400', 'Suzuki', 2023, 7500000000),
(20, 'Forza', 'Honda', 2023, 7800000000);

-- --------------------------------------------------------

--
-- Struktur dari tabel `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama_pelanggan` varchar(100) NOT NULL,
  `no_telepon_pelanggan` varchar(20) NOT NULL,
  `alamat_pelanggan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama_pelanggan`, `no_telepon_pelanggan`, `alamat_pelanggan`) VALUES
(1, 'Ahmad Satrio', '081234567890', 'Jakarta'),
(2, 'Putri Wulandari', '085432109876', 'Surabaya'),
(3, 'Budi Santoso', '082345678901', 'Bandung'),
(4, 'Dewi Kusumawati', '081987654321', 'Yogyakarta'),
(5, 'Rudi Pranata', '085678901234', 'Medan'),
(6, 'Siti Rahmawati', '081234567890', 'Semarang'),
(7, 'Iwan Setiawan', '085432109876', 'Makassar'),
(8, 'Ani Fitriani', '082345678901', 'Palembang'),
(9, 'Eko Prabowo', '081987654321', 'Denpasar'),
(10, 'Rina Susanto', '085678901234', 'Bandar Lampung');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penjualan`
--

CREATE TABLE `penjualan` (
  `id_penjualan` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `id_motor` int(11) NOT NULL,
  `pembayaran` enum('Cash','Kredit') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penjualan`
--

INSERT INTO `penjualan` (`id_penjualan`, `tanggal`, `id_pelanggan`, `id_motor`, `pembayaran`) VALUES
(1, '2023-11-01', 1, 1, 'Cash'),
(2, '2023-11-02', 2, 2, 'Cash'),
(3, '2023-11-03', 3, 3, 'Kredit'),
(4, '2023-11-04', 4, 4, 'Kredit'),
(5, '2023-11-05', 5, 5, 'Cash'),
(6, '2023-11-06', 6, 6, 'Cash'),
(7, '2023-11-07', 7, 7, 'Kredit'),
(8, '2023-11-08', 8, 8, 'Cash'),
(9, '2023-11-09', 9, 9, 'Cash'),
(10, '2023-11-10', 10, 10, 'Kredit');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `nama_lengkap`) VALUES
(1, 'admin', '$2y$10$xr0T3NWU6iYqPnj/.ZCR/eeCZz0gqxlSdtDE0EkYT7cCafVHWSWRa', 'Yosua Manurung');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `motor`
--
ALTER TABLE `motor`
  ADD PRIMARY KEY (`id_motor`);

--
-- Indeks untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`);

--
-- Indeks untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD KEY `penjualan_ibfk_1` (`id_pelanggan`),
  ADD KEY `penjualan_ibfk_2` (`id_motor`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `motor`
--
ALTER TABLE `motor`
  MODIFY `id_motor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `id_penjualan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `penjualan_ibfk_2` FOREIGN KEY (`id_motor`) REFERENCES `motor` (`id_motor`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

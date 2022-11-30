-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 30 Nov 2022 pada 16.28
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
-- Database: `dbaplikasipenilaianmahasiswa`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbmahasiswa`
--

CREATE TABLE `tbmahasiswa` (
  `nim` varchar(15) NOT NULL,
  `nama` varchar(30) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  `kelas` varchar(1) DEFAULT NULL,
  `password` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbmahasiswa`
--

INSERT INTO `tbmahasiswa` (`nim`, `nama`, `semester`, `kelas`, `password`) VALUES
('201011400378', 'An Nisa Dira', 5, 'A', '202cb962ac59075b964b07152d234b70'),
('201011401566', 'Noval Rizky', 7, 'B', '202cb962ac59075b964b07152d234b70'),
('201011401824', 'Azriel FachrulRezy', 7, 'A', '202cb962ac59075b964b07152d234b70'),
('201011402123', 'Andre Farhan Saputra', 5, 'A', '202cb962ac59075b964b07152d234b70'),
('201011402149', 'Nixon Milo Hamonangan', 7, 'A', '202cb962ac59075b964b07152d234b70');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbmatakuliah`
--

CREATE TABLE `tbmatakuliah` (
  `kodematakuliah` varchar(6) NOT NULL,
  `namamatakuliah` varchar(30) DEFAULT NULL,
  `jumlahsks` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbmatakuliah`
--

INSERT INTO `tbmatakuliah` (`kodematakuliah`, `namamatakuliah`, `jumlahsks`) VALUES
('1', 'Pemrograman 2', 3),
('2', 'Pemrograman Web 1', 3),
('3', 'Kalkulus', 3),
('4', 'Basis Data 2', 2),
('6', 'Metode Penelitian', 3);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbnilai`
--

CREATE TABLE `tbnilai` (
  `nim` varchar(15) NOT NULL,
  `kodematakuliah` varchar(6) NOT NULL,
  `tugas` double DEFAULT NULL,
  `uts` double DEFAULT NULL,
  `uas` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tbnilai`
--

INSERT INTO `tbnilai` (`nim`, `kodematakuliah`, `tugas`, `uts`, `uas`) VALUES
('201011400378', '1', 90, 70, 80),
('201011400378', '3', 95, 90, 90),
('201011401566', '3', 90, 90, 95),
('201011401566', '4', 90, 90, 80),
('201011401566', '6', 80, 80, 80),
('201011401824', '2', 90, 80, 90),
('201011402123', '3', 90, 90, 90),
('201011402123', '4', 90, 90, 80),
('201011402149', '4', 90, 80, 80);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tbmahasiswa`
--
ALTER TABLE `tbmahasiswa`
  ADD PRIMARY KEY (`nim`);

--
-- Indeks untuk tabel `tbmatakuliah`
--
ALTER TABLE `tbmatakuliah`
  ADD PRIMARY KEY (`kodematakuliah`);

--
-- Indeks untuk tabel `tbnilai`
--
ALTER TABLE `tbnilai`
  ADD PRIMARY KEY (`nim`,`kodematakuliah`),
  ADD KEY `fkmatakuliah` (`kodematakuliah`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tbnilai`
--
ALTER TABLE `tbnilai`
  ADD CONSTRAINT `fkmahasiswa` FOREIGN KEY (`nim`) REFERENCES `tbmahasiswa` (`nim`),
  ADD CONSTRAINT `fkmatakuliah` FOREIGN KEY (`kodematakuliah`) REFERENCES `tbmatakuliah` (`kodematakuliah`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

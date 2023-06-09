-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 08 Jun 2023 pada 09.25
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
-- Database: `doxscien`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokter`
--

CREATE TABLE `dokter` (
  `id_dokter` int(11) NOT NULL,
  `nama_dokter` varchar(100) NOT NULL,
  `jadwal_praktek` varchar(100) NOT NULL,
  `foto_dokter` text NOT NULL,
  `id_spesialis` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dokter`
--

INSERT INTO `dokter` (`id_dokter`, `nama_dokter`, `jadwal_praktek`, `foto_dokter`, `id_spesialis`) VALUES
(1, 'Andri Firman Saputra', 'Senin sampai Jumat pukul 07:00-17:00', '6470e2e68010fIMG-20220614-WA0006_2-removebg-preview.png', 5),
(2, 'Azriel', 'Jumat jam 09:00 sampai 10:00', 'default.jpg', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `konsultasi`
--

CREATE TABLE `konsultasi` (
  `id_konsultasi` int(11) NOT NULL,
  `nama_pasien` varchar(100) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `no_wa_pasien` varchar(20) NOT NULL,
  `alamat_pasien` text NOT NULL,
  `gejala_pasien` text NOT NULL,
  `tanggal_daftar` datetime NOT NULL,
  `status_konsultasi` enum('BELUM DITANGGAPI','SUDAH DITANGGAPI','SUDAH DIKONFIRMASI','SELESAI') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `konsultasi`
--

INSERT INTO `konsultasi` (`id_konsultasi`, `nama_pasien`, `jenis_kelamin`, `no_wa_pasien`, `alamat_pasien`, `gejala_pasien`, `tanggal_daftar`, `status_konsultasi`) VALUES
(2, 'Annisa', 'P', '6287808675313', 'Pocis', 'Sakit', '2023-05-30 11:15:00', 'SELESAI'),
(3, 'Azriel', 'L', '6281399811975', 'Ciputat', 'Batuk', '2023-05-30 16:02:00', 'SELESAI'),
(4, 'Andri Firman Saputra', 'L', '6287808675313', 'Jl. AMD Babakan Pocis', 'Sakit', '2023-06-04 14:21:00', 'SUDAH DIKONFIRMASI'),
(5, 'Andri Firman Saputra', 'L', '6287808675313', 'Jl. AMD Babakan Pocis', 'Sakit', '2023-06-04 14:22:00', 'BELUM DITANGGAPI'),
(6, 'Andri Firman Saputra', 'L', '6287808675313', 'Jl. AMD Babakan Pocis', 'Pocis', '2023-06-04 14:30:00', 'BELUM DITANGGAPI'),
(7, 'Andri Firman Saputra123', 'L', '123', '213', '123', '2023-06-04 14:31:00', 'BELUM DITANGGAPI'),
(8, 'Andri Firman Saputra', 'L', '6287808675313', 'Jl. AMD Babakan Pocis', 'Sakit123', '2023-06-04 14:32:00', 'BELUM DITANGGAPI'),
(9, 'Andri Firman Saputra', 'L', '023123', 'asdq', 'asd', '2023-06-04 14:35:00', 'BELUM DITANGGAPI'),
(10, '112313', 'L', '31312', '31312313123', '131231', '2023-06-04 14:36:00', 'BELUM DITANGGAPI'),
(11, '123', 'L', '3213', '123131231', '321', '2023-06-04 14:37:00', 'BELUM DITANGGAPI'),
(12, 'Andri Firman Saputra', 'L', '123123', '12312123', '1123123', '2023-06-04 14:38:00', 'BELUM DITANGGAPI'),
(13, 'Andri Firman Saputra', 'L', '123123', '12312313123', '1231', '2023-06-04 14:39:00', 'BELUM DITANGGAPI');

-- --------------------------------------------------------

--
-- Struktur dari tabel `obat`
--

CREATE TABLE `obat` (
  `id_obat` int(11) NOT NULL,
  `nama_obat` varchar(100) NOT NULL,
  `deskripsi_obat` text NOT NULL,
  `foto_obat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `obat`
--

INSERT INTO `obat` (`id_obat`, `nama_obat`, `deskripsi_obat`, `foto_obat`) VALUES
(1, 'Panadol', '&lt;p&gt;&lt;h1&gt;Panadol&lt;/h1&gt;&lt;/p&gt;&lt;p&gt;&lt;h2&gt;An Effective Pain Relief Medication&lt;/h2&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;p&gt;Panadol is a widely recognized brand of over-the-counter pain relief medication. It contains the active ingredient paracetamol, which is known for its analgesic (pain-relieving) and antipyretic (fever-reducing) properties.&lt;/p&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;p&gt;With its trusted formulation, Panadol provides effective relief from various types of pain, including headaches, muscle aches, toothaches, backaches, and menstrual pain. It can also help reduce fever associated with common illnesses.&lt;/p&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;p&gt;What sets Panadol apart is its gentle formula, which makes it suitable for most individuals, including adults and children aged six years and above. However, it is essential to follow the recommended dosage instructions and consult a healthcare professional if you have any specific concerns or medical conditions.&lt;/p&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;p&gt;As with any medication, it&#039;s important to read and follow the instructions and warnings provided on the packaging. Panadol is generally considered safe when used as directed, but it&#039;s always advisable to seek medical advice if symptoms persist or worsen.&lt;/p&gt;&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;&lt;p&gt;Remember, Panadol is intended for temporary relief of pain and should not be used as a long-term solution without medical supervision. If you have any doubts or questions regarding its usage, consult your healthcare provider.&lt;/p&gt;&lt;/p&gt;&lt;h2&gt;&lt;br&gt;&lt;/h2&gt;', '6470d1241a195Panadol Extra_455x455.png');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penyakit`
--

CREATE TABLE `penyakit` (
  `id_penyakit` int(11) NOT NULL,
  `nama_penyakit` varchar(100) NOT NULL,
  `deskripsi_penyakit` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penyakit`
--

INSERT INTO `penyakit` (`id_penyakit`, `nama_penyakit`, `deskripsi_penyakit`) VALUES
(3, 'Covid 19 berbahaya cok!', '&lt;h2&gt;&lt;strong&gt;Sangat berbahaya&lt;/strong&gt;&lt;/h2&gt;&lt;ul&gt;&lt;li&gt;Covid 19 merupakan penyakit yg tidak mudah di lacak&lt;/li&gt;&lt;/ul&gt;');

-- --------------------------------------------------------

--
-- Struktur dari tabel `riwayat`
--

CREATE TABLE `riwayat` (
  `id_riwayat` int(11) NOT NULL,
  `isi_riwayat` text NOT NULL,
  `tanggal_riwayat` datetime NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `riwayat`
--

INSERT INTO `riwayat` (`id_riwayat`, `isi_riwayat`, `tanggal_riwayat`, `id_user`) VALUES
(1, 'User Berhasil login!', '2023-05-26 18:23:24', 1),
(2, 'Penyakit Covid 19 Berhasil ditambahkan!', '2023-05-26 18:39:19', 1),
(3, 'Penyakit Covid 19 Berhasil ditambahkan!', '2023-05-26 18:39:46', 1),
(4, 'Penyakit Covid 19 Berhasil dihapus!', '2023-05-26 18:47:00', 1),
(5, 'Penyakit Covid 19 Berhasil dihapus!', '2023-05-26 18:47:03', 1),
(6, 'Penyakit Covid 19 Berhasil ditambahkan!', '2023-05-26 18:47:24', 1),
(7, 'Penyakit Covid 19 berbahaya cok! Berhasil diubah!', '2023-05-26 18:55:32', 1),
(8, 'Penyakit Covid 19 berbahaya cok! Berhasil diubah!', '2023-05-26 18:55:38', 1),
(9, 'Obat Panadol Berhasil ditambahkan!', '2023-05-26 22:32:52', 1),
(10, 'Obat Panadol Berhasil diubah!', '2023-05-26 22:43:56', 1),
(11, 'Obat Panadol Berhasil diubah!', '2023-05-26 22:48:45', 1),
(12, 'Obat Panadol Berhasil diubah!', '2023-05-26 22:49:00', 1),
(13, 'Dokter Andri Firman Saputra Berhasil ditambahkan!', '2023-05-26 23:48:38', 1),
(14, 'User Berhasil logout!', '2023-05-26 23:57:53', 1),
(15, 'User Berhasil login!', '2023-05-27 00:14:32', 1),
(16, 'User Berhasil logout!', '2023-05-27 00:14:37', 1),
(17, 'User Berhasil login!', '2023-05-29 08:39:35', 1),
(18, 'User Berhasil login!', '2023-05-29 22:43:51', 1),
(19, 'User Berhasil login!', '2023-05-30 06:45:13', 1),
(20, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 08:25:52', 1),
(21, 'Konsultasi  Berhasil dihapus!', '2023-05-30 08:35:21', 1),
(22, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 08:36:24', 1),
(23, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 08:36:42', 1),
(24, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 08:39:30', 1),
(25, 'Konsultasi Andri Firman Saputra123 Berhasil diubah!', '2023-05-30 08:45:23', 1),
(26, 'Konsultasi Andri Firman Saputra Berhasil diubah!', '2023-05-30 08:46:22', 1),
(27, 'Penyakit 1 Berhasil ditambahkan!', '2023-05-30 09:15:50', 1),
(28, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 09:18:24', 1),
(29, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 09:20:58', 1),
(30, 'User Berhasil login!', '2023-05-30 09:40:13', 1),
(31, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 09:40:32', 1),
(32, 'Konsultasi Andri Firman Saputra Selesai!', '2023-05-30 09:55:18', 1),
(33, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 09:56:42', 1),
(34, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 09:57:06', 1),
(35, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:05:55', 1),
(36, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:07:32', 1),
(37, 'Konsultasi Andri Firman Saputra Selesai!', '2023-05-30 10:09:28', 1),
(38, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:09:30', 1),
(39, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:09:47', 1),
(40, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:14:46', 1),
(41, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:15:19', 1),
(42, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:16:38', 1),
(43, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:16:49', 1),
(44, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:17:03', 1),
(45, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:17:49', 1),
(46, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:18:21', 1),
(47, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:18:58', 1),
(48, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:19:13', 1),
(49, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:19:27', 1),
(50, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:19:52', 1),
(51, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:20:21', 1),
(52, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:20:35', 1),
(53, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:20:43', 1),
(54, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:20:54', 1),
(55, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:23:11', 1),
(56, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:23:23', 1),
(57, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:23:36', 1),
(58, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:23:48', 1),
(59, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:24:04', 1),
(60, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:24:14', 1),
(61, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:26:51', 1),
(62, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:27:00', 1),
(63, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:27:11', 1),
(64, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:28:31', 1),
(65, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:28:42', 1),
(66, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:28:56', 1),
(67, 'Konsultasi Andri Firman Saputra sudah dikonfirmasi!', '2023-05-30 10:50:26', 1),
(68, 'Konsultasi Andri Firman Saputra Selesai!', '2023-05-30 10:52:10', 1),
(69, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:52:13', 1),
(70, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:52:24', 1),
(71, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:52:37', 1),
(72, 'Konsultasi Andri Firman Saputra sudah dikonfirmasi!', '2023-05-30 10:52:42', 1),
(73, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:52:51', 1),
(74, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:52:59', 1),
(75, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:54:53', 1),
(76, 'Konsultasi Andri Firman Saputra sudah dikonfirmasi!', '2023-05-30 10:55:19', 1),
(77, 'Konsultasi Andri Firman Saputra sudah dikonfirmasi!', '2023-05-30 10:55:34', 1),
(78, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 10:57:40', 1),
(79, 'Konsultasi Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:57:48', 1),
(80, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-05-30 10:57:56', 1),
(81, 'Konsultasi Andri Firman Saputra sudah dikonfirmasi!', '2023-05-30 10:57:59', 1),
(82, 'Konsultasi Andri Firman Saputra sudah dikonfirmasi!', '2023-05-30 10:58:26', 1),
(83, 'Konsultasi Andri Firman Saputra Berhasil dihapus!', '2023-05-30 11:00:43', 1),
(84, 'Konsultasi Annisa Berhasil ditambahkan!', '2023-05-30 11:04:36', 1),
(85, 'Tanggapan Annisa Berhasil ditambahkan!', '2023-05-30 11:04:54', 1),
(86, 'Konsultasi Annisa sudah dikonfirmasi!', '2023-05-30 11:05:00', 1),
(87, 'Konsultasi Annisa Berhasil dihapus!', '2023-05-30 11:06:00', 1),
(88, 'Konsultasi Annisa Berhasil ditambahkan!', '2023-05-30 11:06:12', 1),
(89, 'Tanggapan Annisa Berhasil ditambahkan!', '2023-05-30 11:06:20', 1),
(90, 'Konsultasi Annisa sudah dikonfirmasi!', '2023-05-30 11:08:11', 1),
(91, 'Konsultasi Annisa Berhasil dihapus!', '2023-05-30 11:09:50', 1),
(92, 'Konsultasi Annisa Berhasil ditambahkan!', '2023-05-30 11:10:02', 1),
(93, 'Tanggapan Annisa Berhasil ditambahkan!', '2023-05-30 11:10:11', 1),
(94, 'Konsultasi Annisa sudah dikonfirmasi!', '2023-05-30 11:10:14', 1),
(95, 'Konsultasi Annisa Berhasil ditambahkan!', '2023-05-30 11:12:23', 1),
(96, 'Tanggapan Annisa Berhasil ditambahkan!', '2023-05-30 11:12:38', 1),
(97, 'Konsultasi Annisa Berhasil ditambahkan!', '2023-05-30 11:13:37', 1),
(98, 'Tanggapan Annisa Berhasil ditambahkan!', '2023-05-30 11:13:48', 1),
(99, 'Konsultasi Annisa sudah dikonfirmasi!', '2023-05-30 11:13:51', 1),
(100, 'Konsultasi Annisa Selesai!', '2023-05-30 11:15:16', 1),
(101, 'Konsultasi Annisa Berhasil dihapus!', '2023-05-30 11:15:26', 1),
(102, 'Konsultasi Annisa Berhasil ditambahkan!', '2023-05-30 11:15:37', 1),
(103, 'Tanggapan Annisa Berhasil ditambahkan!', '2023-05-30 11:15:46', 1),
(104, 'Tanggapan  Berhasil diubah!', '2023-05-30 11:22:00', 1),
(105, 'Tanggapan  Berhasil diubah!', '2023-05-30 11:22:48', 1),
(106, 'Tanggapan Annisa Berhasil diubah!', '2023-05-30 11:23:03', 1),
(107, 'Dokter Azriel Berhasil ditambahkan!', '2023-05-30 11:24:06', 1),
(108, 'Tanggapan Annisa Berhasil diubah!', '2023-05-30 11:24:15', 1),
(109, 'Konsultasi Annisa sudah dikonfirmasi!', '2023-05-30 11:24:25', 1),
(110, 'Konsultasi Annisa Selesai!', '2023-05-30 11:24:37', 1),
(111, 'User Berhasil logout!', '2023-05-30 16:01:27', 1),
(112, 'User Berhasil login!', '2023-05-30 16:01:32', 1),
(113, 'Konsultasi Azriel Berhasil ditambahkan!', '2023-05-30 16:02:36', 1),
(114, 'Tanggapan Azriel Berhasil ditambahkan!', '2023-05-30 16:03:18', 1),
(115, 'Konsultasi Azriel sudah dikonfirmasi!', '2023-05-30 16:03:31', 1),
(116, 'Konsultasi Azriel Selesai!', '2023-05-30 16:13:01', 1),
(117, 'Penyakit Covid 19 berbahaya cok! Berhasil diubah!', '2023-05-30 16:20:23', 1),
(118, 'User Berhasil logout!', '2023-05-30 16:20:37', 1),
(119, 'User Berhasil login!', '2023-05-31 10:57:31', 1),
(120, 'User Berhasil logout!', '2023-05-31 11:00:41', 1),
(121, 'User Berhasil login!', '2023-05-31 11:36:46', 1),
(122, 'User Berhasil login!', '2023-06-04 14:12:20', 1),
(123, 'Tanggapan Andri Firman Saputra Berhasil ditambahkan!', '2023-06-04 14:39:54', 1),
(124, 'Konsultasi Andri Firman Saputra sudah dikonfirmasi!', '2023-06-04 14:39:57', 1),
(125, 'User Berhasil logout!', '2023-06-04 14:47:10', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `spesialis`
--

CREATE TABLE `spesialis` (
  `id_spesialis` int(11) NOT NULL,
  `spesialis` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `spesialis`
--

INSERT INTO `spesialis` (`id_spesialis`, `spesialis`) VALUES
(1, 'Dokter Spesialis Mata'),
(2, 'Dokter Spesialis Telinga, Hidung, dan Tenggorokan'),
(3, 'Dokter Spesialis Kulit dan Kelamin'),
(4, 'Dokter Spesialis Paru'),
(5, 'Dokter Spesialis Jantung'),
(6, 'Dokter Spesialis Endokrinologi'),
(7, 'Dokter Spesialis Gastroenterologi');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tanggapan`
--

CREATE TABLE `tanggapan` (
  `id_tanggapan` int(11) NOT NULL,
  `id_konsultasi` int(11) NOT NULL,
  `id_dokter` int(11) NOT NULL,
  `tanggal_konsultasi` datetime NOT NULL,
  `keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tanggapan`
--

INSERT INTO `tanggapan` (`id_tanggapan`, `id_konsultasi`, `id_dokter`, `tanggal_konsultasi`, `keterangan`) VALUES
(1, 1, 1, '2023-05-30 11:00:00', 'Selamat pagi, Ibu Annisa, Ibu telah kami jadwalkan konsultasi dengan dokter Andri Firman Saputra pada waktu berikut: 30-05-2023, 11:00'),
(2, 2, 2, '2023-06-16 11:15:00', 'Selamat pagi, Ibu Annisa, kami dari Doxscien. Ibu telah kami jadwalkan konsultasi dengan dokter Azriel pada waktu berikut: 16-06-2023, 11:15'),
(3, 3, 1, '2023-06-02 17:00:00', 'Selamat sore, Bapak Azriel, kami dari Doxscien. Bapak telah kami jadwalkan konsultasi dengan dokter Andri Firman Saputra pada waktu berikut: 02-06-2023, 17:00'),
(4, 4, 1, '2023-06-04 20:45:00', 'Selamat siang, Bapak Andri Firman Saputra, kami dari Doxscien. Bapak telah kami jadwalkan konsultasi dengan dokter Andri Firman Saputra pada waktu berikut: 04-06-2023, 20:45');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `nama_lengkap`) VALUES
(1, 'admin', '$2y$10$uhFanjJHWe6AYEkdDGbsie91JzMScS0IkCExvR5E4d3Eqcyk97N2K', 'Admin');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD PRIMARY KEY (`id_dokter`),
  ADD KEY `id_spesialis` (`id_spesialis`);

--
-- Indeks untuk tabel `konsultasi`
--
ALTER TABLE `konsultasi`
  ADD PRIMARY KEY (`id_konsultasi`);

--
-- Indeks untuk tabel `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id_obat`);

--
-- Indeks untuk tabel `penyakit`
--
ALTER TABLE `penyakit`
  ADD PRIMARY KEY (`id_penyakit`);

--
-- Indeks untuk tabel `riwayat`
--
ALTER TABLE `riwayat`
  ADD PRIMARY KEY (`id_riwayat`),
  ADD KEY `id_user` (`id_user`);

--
-- Indeks untuk tabel `spesialis`
--
ALTER TABLE `spesialis`
  ADD PRIMARY KEY (`id_spesialis`);

--
-- Indeks untuk tabel `tanggapan`
--
ALTER TABLE `tanggapan`
  ADD PRIMARY KEY (`id_tanggapan`),
  ADD KEY `id_dokter` (`id_dokter`),
  ADD KEY `id_konsultasi` (`id_konsultasi`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `dokter`
--
ALTER TABLE `dokter`
  MODIFY `id_dokter` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `konsultasi`
--
ALTER TABLE `konsultasi`
  MODIFY `id_konsultasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `obat`
--
ALTER TABLE `obat`
  MODIFY `id_obat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `penyakit`
--
ALTER TABLE `penyakit`
  MODIFY `id_penyakit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `riwayat`
--
ALTER TABLE `riwayat`
  MODIFY `id_riwayat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT untuk tabel `spesialis`
--
ALTER TABLE `spesialis`
  MODIFY `id_spesialis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `tanggapan`
--
ALTER TABLE `tanggapan`
  MODIFY `id_tanggapan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `dokter`
--
ALTER TABLE `dokter`
  ADD CONSTRAINT `dokter_ibfk_1` FOREIGN KEY (`id_spesialis`) REFERENCES `spesialis` (`id_spesialis`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tanggapan`
--
ALTER TABLE `tanggapan`
  ADD CONSTRAINT `tanggapan_ibfk_1` FOREIGN KEY (`id_dokter`) REFERENCES `dokter` (`id_dokter`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

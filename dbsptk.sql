-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 03 Okt 2024 pada 04.38
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsptk`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admin`
--

CREATE TABLE `admin` (
  `IdAdmin` int(11) NOT NULL,
  `NamaAdmin` varchar(255) DEFAULT NULL,
  `usernameAdmin` varchar(255) DEFAULT NULL,
  `emailAdmin` varchar(255) DEFAULT NULL,
  `passwordAdmin` varchar(255) DEFAULT 'admintekkom123'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `admin`
--

INSERT INTO `admin` (`IdAdmin`, `NamaAdmin`, `usernameAdmin`, `emailAdmin`, `passwordAdmin`) VALUES
(17, NULL, 'kuro', 'kuro@gmail.com', '$2b$10$e4BuHAgrDi0ffYltS8xLDOCEhNTnjt3xtvPXYxX.TpBTXbS3xSrH.'),
(18, 'mara', 'mara', 'mara@gmail.com', 'mara123'),
(19, 'Admin', 'admin1', 'admin@gmail.com', 'admin'),
(20, NULL, 'useradmin', NULL, '$2a$10$vQqII.ldv0NkXcsVrJjzL.Tv4T1PxTYOHTdY9nVGQAkrQGQUsmf16');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dosen`
--

CREATE TABLE `dosen` (
  `IdDosen` int(11) NOT NULL,
  `NamaDosen` varchar(100) DEFAULT NULL,
  `Nip` varchar(50) DEFAULT NULL,
  `passwordDosen` varchar(255) NOT NULL DEFAULT 'dosen123',
  `PhoneDosen` varchar(255) DEFAULT NULL,
  `Alamat` varchar(255) DEFAULT NULL,
  `Fakultas` varchar(255) NOT NULL DEFAULT 'Teknik',
  `Prodi` varchar(255) NOT NULL DEFAULT 'Teknik Komputer',
  `IdInfo` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `dosen`
--

INSERT INTO `dosen` (`IdDosen`, `NamaDosen`, `Nip`, `passwordDosen`, `PhoneDosen`, `Alamat`, `Fakultas`, `Prodi`, `IdInfo`, `created_at`) VALUES
(9, 'Prof. Budi', '1234567890', '$2a$10$YHZgjhMabzKC7Ooc2Ecs.eXFQxDElXEl39OkK79sK8/KmScjry3YK', '085678912345', 'Semarang, Indonesia, Juwana pati jawa tengah, asia tenggara', '', '', NULL, '2024-08-02 00:39:51'),
(25, 'Dr. Farid Iskandar', '6789012345', '$2a$10$y46pJ1.wZwYlyxVEUR0Xo.wJDy7yMKl1JGDuYal41O4.0kXwDM.lG', '086789012346', 'Jl. Jend. Sudirman No. 6, Jakarta', 'Teknik', 'Teknik Komputer', NULL, '2024-08-02 00:39:51'),
(26, 'Prof. Elisa Rahmawati', '5678901234', '$2a$10$5ucAn7B9l0qCnH1zsrZQfOJ7R2lwrUfKpoT7qZg6UwiH4E.MSH6QO', '85678901234', 'Jl. MH Thamrin No. 5, Jakarta', 'Teknik', 'Teknik Komputer', NULL, '2024-08-02 00:39:51'),
(28, 'Dr. Cindy Permata', '3456789012', '$2a$10$udtLQCB9bGpdmwFvp.CEROXsR.4eksdhwZFKR36emEy5r5CT.Ln62', '083456789011', 'Jl. Gatot Subroto No. 3, Jakarta', 'Teknik', 'Teknik Komputer', NULL, '2024-08-02 00:39:51'),
(31, 'Ike Pertiwi Windasari, S.T., M.T.', '198412062010122008', 'dosen123', '085640082652', 'jalan emas 02', 'Teknik', 'Teknik Komputer', NULL, '2024-08-02 00:39:51'),
(66, 'haki', '212103021', '$2a$10$FOpXMXU/cB79ihruA39pi.LepLSz4V64.THVrdmfdSIulSJCcUOH6', '0', '-', 'Teknik', 'Teknik Komputer', NULL, '2024-09-22 12:34:59');

-- --------------------------------------------------------

--
-- Struktur dari tabel `gpm`
--

CREATE TABLE `gpm` (
  `IdGpm` int(11) NOT NULL,
  `NamaGpm` varchar(50) DEFAULT NULL,
  `Nip` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `passwordGpm` varchar(255) NOT NULL DEFAULT 'gpm123',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `gpm`
--

INSERT INTO `gpm` (`IdGpm`, `NamaGpm`, `Nip`, `phone`, `passwordGpm`, `created_at`) VALUES
(14, 'Sarah Williams', '', '', '$2a$10$kAoTQMtI7TX8QnefpDQBSes.nhP2SXr/3e7Ei02egSv8pKuxrTMuu', '2024-08-02 01:25:15'),
(16, 'Gpm1', '21120120140138', '0895395070385', '$2a$10$FpWTT7ZnrLULT1hhwB0spu/dyZRizAn97xNt6QUhgXA68SfhjXMb2', '2024-08-02 01:27:22'),
(17, 'Gpm2', '2112', '0897', '$2a$10$mtAiCYck4PEm2B2unLrCMuWIIpBylphY7f0okQuGr.LbcwNo49ekm', '2024-08-04 11:34:52'),
(21, 'gpm3', '21124124', '00977212', '$2a$10$JQB65DtZ0rm/PTgGJYMJQuArgF.eL.onfirV.Ve/W2m0t.3QZXbiS', '2024-08-13 11:56:33'),
(22, 'GPM12', '211023123213', '089765238787', 'gpm123', '2024-08-14 05:35:11'),
(23, 'Ike Pertiwi Windasari, S.T., M.T.', '198412062010122008', '08975782', '$2a$10$JwkJGm66NFSaQZOft0mSWOX8a7Fobycpc.4UFA8lSewlyKI.HaaWO', '2024-08-31 02:10:07'),
(28, 'gpm', '2112', '', '$2a$10$Sl804SzONFKYoye920C7c.yv5ljvKoc1MPvMnBRwFdEKkfVBuckr2', '2024-09-21 06:01:10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `info`
--

CREATE TABLE `info` (
  `IdInfo` int(11) NOT NULL,
  `JudulInfo` varchar(255) DEFAULT NULL,
  `Isi` text DEFAULT NULL,
  `TanggalInfo` timestamp NULL DEFAULT current_timestamp(),
  `IdDosen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `info`
--

INSERT INTO `info` (`IdInfo`, `JudulInfo`, `Isi`, `TanggalInfo`, `IdDosen`) VALUES
(1, 'njasdbkjs', 'n andvevae', '2024-05-09 05:13:45', NULL),
(2, 'nmsasdjbwge', 'n mndabegjugeur', '2024-05-09 05:14:56', NULL),
(3, ' nbabsdjge', 'andnmhvejjgjeaf', '2024-05-09 16:14:56', NULL),
(4, 'Perwalian', 'Jadwal hari senin dikosongkan', '2024-07-25 08:43:37', 31),
(5, 'Perwalian', 'Perwalian dimajukan', '2024-07-25 08:46:36', 31),
(7, 'Revisi', 'Laporan dikumpulkan tanggal 16 Agustus Maksimal', '2024-08-04 10:32:09', 25),
(8, 'Perubahan Jadwal', 'Kepada seluruh mahasiswa, kami menginformasikan bahwa jadwal perkuliahan untuk semester ini mengalami beberapa perubahan signifikan. Beberapa mata kuliah mengalami penyesuaian waktu dan tanggal yang perlu diperhatikan untuk memastikan kehadiran dan partisipasi yang optimal. Selain itu, kami juga ingin mengingatkan bahwa batas akhir pengumpulan tugas akhir semester akan diperpanjang hingga tanggal 15 Desember 2024 untuk memberikan kesempatan lebih bagi mahasiswa dalam menyelesaikan pekerjaan mereka. Mohon untuk memeriksa jadwal terbaru yang telah diperbarui di portal akademik dan melakukan penyesuaian dalam rencana studi Anda. Jika ada pertanyaan atau membutuhkan klarifikasi lebih lanjut, silakan menghubungi pihak administrasi akademik atau dosen pengampu masing-masing mata kuliah.', '2024-08-05 02:05:56', 31),
(9, 'Jadwal Kuliah Terbaru', 'lihat siap undip', '2024-08-07 04:05:44', 28),
(10, 'Revisi', 'Revisi C100', '2024-08-10 07:23:43', 31),
(11, 'Perwalian', 'Bimbingan Perwalian', '2024-08-10 07:44:49', 31),
(13, 'Bimbingan Perwalian IRS', 'IRS', '2024-08-30 02:35:11', 31),
(14, 'Bimbingan Perwalian IRS', 'oke satu dua tiga', '2024-08-30 02:38:21', 31),
(15, 'Bimbingan Perwalian IRS', 'klaldjljlead', '2024-08-30 02:39:46', 31),
(16, 'Bimbingan Perwalian IRS', 'okeee', '2024-08-30 02:40:07', 31),
(17, 'Jadwal Kuliah Terbaru', 'masuk kuliah tgl 22', '2024-08-31 04:56:49', 31),
(19, 'Bimbingan Perwalian IRS', 'jadwal diubah', '2024-09-18 04:19:34', NULL),
(1508, 'Baru', 'baru', '2024-09-22 07:21:21', 31);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_dosen`
--

CREATE TABLE `jadwal_dosen` (
  `IdJadwal` int(11) NOT NULL,
  `Hari` enum('Senin','Selasa','Rabu','Kamis','Jumat') DEFAULT NULL,
  `Waktu` varchar(255) DEFAULT NULL,
  `Prodi` varchar(255) DEFAULT 'Teknik Komputer',
  `MataKuliah` varchar(255) DEFAULT NULL,
  `Kelas` varchar(255) DEFAULT NULL,
  `Pengampu` varchar(255) DEFAULT NULL,
  `Ruangan` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `IdDosen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jadwal_dosen`
--

INSERT INTO `jadwal_dosen` (`IdJadwal`, `Hari`, `Waktu`, `Prodi`, `MataKuliah`, `Kelas`, `Pengampu`, `Ruangan`, `created_at`, `IdDosen`) VALUES
(10, 'Rabu', '09.00', 'Teknik Komputer', 'STT', 'C', 'Dr.Alice', 'B201', '2024-08-05 03:23:50', 31),
(11, 'Selasa', '09.30', 'Teknik Komputer', 'MPTI', 'A', 'Dr.Cindy', 'B202', '2024-08-09 07:22:52', 31),
(12, 'Jumat', '10.00', 'Teknik Komputer', 'MPTI', 'C', 'Prof. Budi', 'A202', '2024-08-10 07:13:37', 9),
(14, 'Selasa', '08.00', 'Teknik Komputer', 'STT', 'C', 'Prof. Budi', 'B201', '2024-08-10 07:38:12', 9),
(15, 'Senin', '07.00', 'Teknik Komputer', 'STT', 'A', 'Prof. Budi', 'A202', '2024-09-04 07:16:31', 9),
(16, 'Senin', '07.00-08.00', 'Teknik Komputer', 'Kecerdasan Buatan', 'A', 'Ike Pertiwi Windasari, S. T., M. T.', 'A202', '2024-09-19 10:01:46', 31),
(17, 'Senin', '07.00-08.00', 'Teknik Komputer', 'Kecerdasan Buatan', 'A', 'Ike Pertiwi Windasari, S. T., M. T.', 'A202', '2024-09-21 03:49:04', 31),
(18, 'Senin', '07.00-08.00', 'Teknik Komputer', 'Kecerdasan Buatan', 'A', 'Ike Pertiwi Windasari, S. T., M. T.', 'A202', '2024-09-21 06:01:50', 31),
(19, 'Senin', '07.00-08.00', 'Teknik Komputer', 'Kecerdasan Buatan', 'A', 'Ike Pertiwi Windasari, S. T., M. T.', 'A202', '2024-09-23 00:36:40', 31);

-- --------------------------------------------------------

--
-- Struktur dari tabel `jadwal_perwalian`
--

CREATE TABLE `jadwal_perwalian` (
  `IdPermintaan` int(11) NOT NULL,
  `IdMaha` int(11) DEFAULT NULL,
  `IdDosen` int(11) DEFAULT NULL,
  `jadwal_diajukan` datetime NOT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `keterangan` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `jadwal_perwalian`
--

INSERT INTO `jadwal_perwalian` (`IdPermintaan`, `IdMaha`, `IdDosen`, `jadwal_diajukan`, `status`, `keterangan`, `created_at`) VALUES
(30, 4, 31, '2024-08-11 14:20:00', 'Approved', NULL, '2024-08-10 07:20:34'),
(31, 62, 31, '2024-08-11 15:46:00', 'Rejected', 'baik', '2024-08-10 07:46:52'),
(33, 62, 31, '2024-09-01 08:09:00', 'Rejected', 'ganti jadwal', '2024-08-31 01:09:38'),
(34, 62, 31, '2024-09-02 08:10:00', 'Approved', NULL, '2024-08-31 01:10:12'),
(36, 4, 31, '2024-08-30 12:16:00', 'Rejected', 'ganti bulan depan', '2024-08-31 05:17:05'),
(37, 4, 31, '2024-08-31 12:31:00', 'Rejected', 'Ganti jadwal tanggal sekian', '2024-08-31 05:31:30'),
(266, 4, 31, '2024-10-20 10:00:00', 'Pending', NULL, '2024-09-21 10:50:40'),
(1149, 4, 31, '2024-09-30 13:00:00', 'Approved', NULL, '2024-09-22 03:51:53');

-- --------------------------------------------------------

--
-- Struktur dari tabel `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `IdMaha` int(11) NOT NULL,
  `NamaMaha` varchar(100) DEFAULT NULL,
  `NimMaha` varchar(50) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `agama` varchar(255) DEFAULT NULL,
  `TahunMasuk` year(4) DEFAULT NULL,
  `JalurMasuk` varchar(255) DEFAULT NULL,
  `passwordMaha` varchar(255) NOT NULL,
  `Alamat` varchar(255) DEFAULT NULL,
  `Semester` int(11) DEFAULT NULL,
  `Sks` int(11) DEFAULT NULL,
  `Ipk` decimal(3,2) DEFAULT NULL,
  `Fakultas` varchar(255) NOT NULL DEFAULT 'Teknik',
  `Prodi` varchar(255) NOT NULL DEFAULT 'Teknik Komputer',
  `phone` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `IdDosen` int(11) DEFAULT NULL,
  `is_surveyed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `mahasiswa`
--

INSERT INTO `mahasiswa` (`IdMaha`, `NamaMaha`, `NimMaha`, `gender`, `agama`, `TahunMasuk`, `JalurMasuk`, `passwordMaha`, `Alamat`, `Semester`, `Sks`, `Ipk`, `Fakultas`, `Prodi`, `phone`, `status`, `IdDosen`, `is_surveyed`, `created_at`) VALUES
(4, 'MARUL ANGGARA', '21120120140138', 'Laki-laki', 'Islam', '2020', 'Mandiri', 'mahasiswa123', 'Jalan Emas, Desa Growong Lor RT.02', 10, 147, 3.65, 'Teknik', 'Teknik Komputer', '0895395070385', 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(53, 'GERHAD RUBEN RUSSEL ANGGORO', '21120120130075', 'L', 'PROTESTAN', '2020', NULL, '$2a$10$A.zTHs61RtfVAZWLjkw6auS7z0ekM8GPWmpsCs/YmbYCxrZ7.pMj.', NULL, 9, 103, 3.43, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(54, 'DAFFA ABHYASA SANTOSO', '21120120130093', 'L', 'ISLAM', '2020', NULL, '$2a$10$.0wV80/WFkNaS2STbcvil.72O6.T96DAJB9AlWAgTPBBJ/94uYwn2', NULL, 9, 141, 3.47, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(55, 'YOGA SADHEWO SHALAHUDIN', '21120120130113', 'L', 'ISLAM', '2020', NULL, '$2a$10$IfdSeGXCwxN6Tvv1Wscs4urVaqTBdBmT1NZbzFQvZPfRKwetUKgGy', NULL, 9, 145, 3.88, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(56, 'MUHAMMAD ARIF RAZMI', '21120120130116', 'L', 'ISLAM', '2020', NULL, '$2a$10$26thp3ZKezIhYjYCmV3pr.eszj7rkRU0sm79Es3gtrf4bf18vEaHu', NULL, 9, 147, 3.84, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(57, 'KEVIN OWEN SANTOSO', '21120120130117', 'L', 'KHATOLIK', '2020', NULL, '$2a$10$oMkkPlayfh0IfDmF3Ck.2O8HQ6M4maw/6L1mU8Y3WvcZ8QMsqyQze', NULL, 9, 63, 3.76, 'Teknik', 'Teknik Komputer', NULL, 'Cuti', 31, 0, '2024-08-03 03:22:32'),
(58, 'ATHALLAH DWI RAHADIANTO', '21120120130122', 'L', 'ISLAM', '2020', NULL, '$2a$10$PJjnu66LWjC3Ya9D.xLskuOO6QiXVe1YlK8bc91wC3ELTisowJG.G', NULL, 9, 137, 3.46, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(59, 'ABRAM DARMAPUTRA', '21120120130124', 'L', 'ISLAM', '2020', NULL, '$2a$10$PEncspvCEEext0/uKs3vq.RkFJre2ZDsQiQt804yQJhuyr3yLsmBW', NULL, 9, 147, 3.69, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(60, 'JULIANT RAFFA', '21120120130127', 'L', 'ISLAM', '2020', NULL, '$2a$10$Miq3jO0mD0uRp7964iTh1uq9SmNxMM6/8wYOswHv1SWc3g3.IzM4S', NULL, 9, 146, 3.94, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(61, 'NAURA SHARFINA AZARINE', '21120120140159', 'L', 'ISLAM', '2020', NULL, '$2a$10$zMel8qEU5cEXh8oEG5m82eCnLv8JyNBScbdRnCXj33EmxCNhKZkhS', NULL, 9, 147, 3.84, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(62, 'MUHAMMAD FITRA ARISAPUTRA', '21120120140160', 'L', 'ISLAM', '2020', NULL, '$2a$10$0/MtKd72pcp3LgP4ZbCrXeouXa.hC5pEBpV.xbLqFskNI6uxoL56O', 'jalan diponegoro, tembalang', 9, 144, 3.46, 'Teknik', 'Teknik Komputer', '0812803769790', 'Aktif', 31, 1, '2024-08-03 03:22:32'),
(63, 'EZRA LAZUARDY WIJAYA', '21120120140162', 'L', 'ISLAM', '2020', NULL, '$2a$10$Fq5bkr4Cktr1r6dAaWY6keCX9s23uq1kW1iKSSJMyW.9BozwRTfCS', NULL, 9, 124, 3.70, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(64, 'EFESUS GALATIA KHASEA BANUREA', '21120122140117', 'L', 'PROTESTAN', '2022', NULL, '$2a$10$EB1qOkV4GkHEWmrDTHdeKuqGQQ6sI3HIouXKfjWWnn9UrsjiNsfVW', NULL, 7, 88, 3.30, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(65, 'DAVIN RADITYA', '21120122140118', 'L', 'ISLAM', '2022', NULL, '$2a$10$atGA.FmtzI/dqPnq7pGI/e6UG8UbiTkLxrLxXP5uJRWoyyxKJMsDe', NULL, 7, 91, 3.55, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(66, 'BAGASKARA DIPOWICAKSONO HP', '21120122140119', 'L', 'ISLAM', '2022', NULL, '$2a$10$7uhqtmLFqFc9F9ermmvU8ux.JE2YJMhYzuHAggl.DVSovkVRIe7iW', NULL, 7, 90, 3.49, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(67, 'RUBEN SHANDOVA SIGALINGGING', '21120122140120', 'L', 'PROTESTAN', '2022', NULL, '$2a$10$ogAEx7r4b0W6W5Tsw.uSn.cRutDk4VlvwMriOX4y1wubyodToDK8.', NULL, 7, 90, 3.72, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(68, 'MUHAMMAD AZHAR RENALDI', '21120122140121', 'L', 'ISLAM', '2022', NULL, '$2a$10$HQ2y5R95IunLW90.VpKaNedVbSjHe2jQAVMWxfG99xvdXOLnBbImi', NULL, 7, 91, 3.81, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(69, 'ACHMAD RIEZQI MURTADLO', '21120122140122', 'L', 'ISLAM', '2022', NULL, '$2a$10$qQr6JBOScJ3agMIq6GyYWekSaJcPcQCKrtekJPy0s6zozCB9Q4lR.', NULL, 7, 91, 3.74, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(70, 'RENDY AKBAR PERMANA', '21120122140123', 'L', 'ISLAM', '2022', NULL, '$2a$10$syzs6Rj9i.CGfQPSePN49O7B1AfeYFVumT1Dx8SGkN/KZigU8qJ.G', NULL, 7, 91, 3.63, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(71, 'FAIZ WIDYADANANTO', '21120122140124', 'L', 'ISLAM', '2022', NULL, '$2a$10$.F1zK7hjQIKn7VRrGwr8aed7XApkOOZ5A/JCDWBk.PZZEbp3m80ey', NULL, 7, 89, 3.34, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(72, 'MELISA NOVPRIYANTI HUTABARAT', '21120122140125', 'P', 'PROTESTAN', '2022', NULL, '$2a$10$OaTaYDUjseNQX1z6YlOdf.nZSPxRJegtreiq01y9yohptwiyrW1BO', NULL, 7, 89, 3.73, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(73, 'I MADE SURYANATHA BHASKARA', '21120122140126', 'L', 'HINDU', '2022', NULL, '$2a$10$rG9xgdYZVIWvLE7LDJfNJOXJA7eXTbek8J4DOSau7VUboUZ0MUqrS', NULL, 7, 86, 3.28, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(74, 'DHANU SATRIA ATMAJA', '21120122140127', 'L', 'ISLAM', '2022', NULL, '$2a$10$yzSp0sY6PhrROAox43RYSOyrDeKUrVmrDiHvVML2PpnfPordCK.km', NULL, 7, 90, 3.59, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(75, 'ALLWAN SETYO RAHARJO', '21120122140128', 'L', 'ISLAM', '2022', NULL, '$2a$10$L21zbG5AW2GNpOub.usimuYRArueyr311TLdYeiiT5Y9VU942F3vy', NULL, 7, 86, 3.55, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(76, 'MUTIARA SABRINA RAHMADIANNISA', '21120122140129', 'P', 'ISLAM', '2022', NULL, '$2a$10$O1kA5dx9G4uGe6G59bW9.O2S9DR9FEKsQWKeSMG.5vfJ5cLvrVBw2', NULL, 7, 91, 3.82, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(77, 'INDRA MAULUDANI EFENDI', '21120122140130', 'L', 'ISLAM', '2022', NULL, '$2a$10$Jekq5T41xy01V2hdnwjny.1/7yYmJD9mQYwgkk1Adn.iyU73ljh3a', NULL, 7, 88, 3.32, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(78, 'MUHAMMAD ERDIN ILHAM FACHYUMI', '21120122140131', 'L', 'ISLAM', '2022', NULL, '$2a$10$KbtcPqNZvDHDZfflzV7B9ubVdXxP2s0XY.O.abDwx1krggiBb/P7W', NULL, 7, 88, 3.32, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(79, 'SYABINA KAMILA', '21120122140132', 'P', 'ISLAM', '2022', NULL, '$2a$10$XiLeMGv8/S4.LKL1ZBssZOTObmXkpWMZPp5KUBym/uqYXwAm/wObu', NULL, 7, 92, 3.62, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(80, 'Nadia Faadhillah', '21120122140133', 'P', 'ISLAM', '2022', NULL, '$2a$10$CBfNSKBMF7or6YLp0c40ruIxS878yhikv1vQUuRTgXrlA7Zv13aVO', NULL, 7, 90, 3.58, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(81, 'DAFFA ANANDA FRIANTO', '21120122140134', 'L', 'ISLAM', '2022', NULL, '$2a$10$Cmp45zAmPLMxlh4nMD8OF.2.BZGz8Z7Apx1t4kzwoCIFkzkOt4Cl.', NULL, 7, 90, 3.49, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(82, 'NAMIRA NURFALIANI', '21120122140135', 'P', 'ISLAM', '2022', NULL, '$2a$10$nBpRzPJVZ.6wiOnJozUkgehXqo3hH6/hXiUvn/9BMAmpnkl771syu', NULL, 7, 91, 3.73, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', NULL, 0, '2024-08-03 03:22:32'),
(83, 'RAIHAN MAULANA', '21120122140136', 'L', 'ISLAM', '2022', NULL, '$2a$10$JFFlsvXEJowphHXcRwzY6uiqeusPNQ98RtVO0ylyCKKIJI5dCQtXi', NULL, 7, 78, 3.22, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(84, 'CHRISTENTA TIRTA PRADIEVA', '21120122140137', 'L', 'PROTESTAN', '2022', NULL, '$2a$10$UaEVDU7pi5mV69/SiwjfAuKy9hj59MXyjhVZPoH7QVnXbSLwAWkQC', NULL, 7, 90, 3.48, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(85, 'LUCKY BARGA ARETAMA', '21120122140138', 'L', 'ISLAM', '2022', NULL, '$2a$10$rX1ApzlydF7EuXN6tojOOuzLL0EO2wK1Uzl1/muYlCb9wZFH9cR.G', NULL, 7, 90, 3.71, 'Teknik', 'Teknik Komputer', NULL, 'Aktif', 31, 0, '2024-08-03 03:22:32'),
(101, 'Budi Santoso', '21120345001', 'L', 'Islam', '2023', 'SNMPTN', '$2a$10$L9iBcvRWsziV95nx5g0ehu9KIlooyVgdlwl8nMeJjD5BxVDKU8L/K', 'Jakarta', 1, 20, 2.60, 'Teknik', 'Teknik Komputer', '8123456789', 'Aktif', 9, 0, '2024-09-04 04:59:07'),
(102, 'Siti Aminah', '21120345002', 'P', 'Islam', '2023', 'SBMPTN', '$2a$10$SgZfxdZK54fa6YvFs2qg5.s7vDh011F5Q4GgEk8LAPUaKXSM6piy6', 'Bandung', 1, 20, 2.49, 'Teknik', 'Teknik Komputer', '8123456780', 'Aktif', 9, 0, '2024-09-04 04:59:07'),
(103, 'Joko Widodo', '21120345003', 'L', 'Islam', '2023', 'Mandiri', '$2a$10$My/bTuN5HfdzhHhZsVrDqeE0u2pkn3ZL3uWAC26.QYY6lx1faTxeu', 'Surabaya', 1, 18, 2.10, 'Teknik', 'Teknik Komputer', '8123456781', 'Aktif', 9, 0, '2024-09-04 04:59:08'),
(104, 'Rahmi Fadillah', '21120345004', 'P', 'Islam', '2022', 'SNMPTN', '$2a$10$mAOrq3V5bk/8u4LcRdJiqOKAbYOUIkFJHiLgitbNkC2IozGFD4YLW', 'Bogor', 2, 40, 2.80, 'Teknik', 'Teknik Komputer', '8123456782', 'Aktif', 9, 0, '2024-09-04 04:59:08'),
(105, 'Agus Salim', '21120345005', 'L', 'Islam', '2022', 'SBMPTN', '$2a$10$rWtmV/IqiuyfxU81ZRZg../8hnBKIB8wTgeVzBwarJpXB1ZHxB3Py', 'Depok', 2, 40, 2.30, 'Teknik', 'Teknik Komputer', '8123456783', 'Aktif', 9, 0, '2024-09-04 04:59:08'),
(107, 'Dian Fitriani', '21120345007', 'P', 'Hindu', '2021', 'SNMPTN', '$2a$10$yDd0xvKlPfT8axl1Nw9biOFhlB7Y6rPy7jCqIO3Ttzh/paIFNl.4O', 'Denpasar', 3, 35, 2.70, 'Teknik', 'Teknik Komputer', '8123456785', 'Aktif', 9, 0, '2024-09-04 04:59:08'),
(108, 'Rian Saputra', '21120345008', 'L', 'Islam', '2021', 'SBMPTN', '$2a$10$zylpoj.q7nyXmdK33h/khO9fE5cvscaqLGzYpFOUqP93O4zijxQZK', 'Makassar', 3, 25, 2.40, 'Teknik', 'Teknik Komputer', '8123456786', 'Aktif', 9, 0, '2024-09-04 04:59:08'),
(109, 'Ratna Sari', '21120345009', 'P', 'Kristen', '2021', 'Mandiri', '$2a$10$l21UxNVjGl0lBPAeoFihmun7TpglwH6gjZfHFZLMhwJbnzrmQKjUO', 'Malang', 3, 24, 2.10, 'Teknik', 'Teknik Komputer', '8123456787', 'Aktif', 9, 0, '2024-09-04 04:59:08'),
(110, 'Ari Wibowo', '21120345010', 'L', 'Hindu', '2020', 'SNMPTN', '$2a$10$i0CKkFE5fB8dEYDJDeIjbuxDRCArjsdr7V72e0.q.gg0uxGFvasO6', 'Bekasi', 4, 47, 2.90, 'Teknik', 'Teknik Komputer', '8123456788', 'Aktif', 9, 0, '2024-09-04 04:59:08'),
(111, 'Melati Dewi', '21120345011', 'P', 'Kristen', '2020', 'SBMPTN', '$2a$10$v7uQtENVHA0PWuGQWqnMvOjsVSMBOwB/CiJoONfYGu62oA2Lkb5W2', 'Medan', 4, 46, 2.50, 'Teknik', 'Teknik Komputer', '8123456789', 'Aktif', 9, 0, '2024-09-04 04:59:08'),
(112, 'Bambang Sutejo', '21120345012', 'L', 'Islam', '2020', 'Mandiri', '$2a$10$j5dQ/Oaet/IJAmcIOOqj8uanTJiehUcv9pqRnZ6463VQflSFyZ5XO', 'Palembang', 4, 46, 2.30, 'Teknik', 'Teknik Komputer', '8123456780', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(113, 'Rina Kartika', '21120345013', 'P', 'Kristen', '2019', 'SNMPTN', '$2a$10$4FoZH3wOpc/k.OvjfNvENOkk5vqUcSBxJWpc1CvGQiiarewLD/kcO', 'Semarang', 5, 50, 3.00, 'Teknik', 'Teknik Komputer', '8123456781', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(114, 'Dedi Gunawan', '21120345014', 'L', 'Islam', '2019', 'SBMPTN', '$2a$10$ZIlkcO4ePuF18f9IhbZ1/.PF03EcUurA2TVFlMeFk4.PJ1TjfEfpK', 'Yogyakarta', 5, 50, 2.30, 'Teknik', 'Teknik Komputer', '8123456782', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(115, 'Linda Susanti', '21120345015', 'P', 'Islam', '2019', 'Mandiri', '$2a$10$oBn78k44JaNpFLBN6xyfI.zONQxzRWO9Xa69cT/tt7ZXwMSqiOVzi', 'Malang', 5, 40, 2.10, 'Teknik', 'Teknik Komputer', '8123456783', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(116, 'Andi Firmansyah', '21120345016', 'L', 'Islam', '2018', 'SNMPTN', '$2a$10$/rOJY2vmjvK9piRxj.JAo.qV00W2plk7Ch0cknyP5iH427/lJAPoK', 'Bali', 6, 91, 3.10, 'Teknik', 'Teknik Komputer', '8123456784', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(117, 'Endah Suryani', '21120345017', 'P', 'Kristen', '2018', 'SBMPTN', '$2a$10$zGpVaxXiyQVzbh/3wLKfFuPooxKnm.k20bpbbIDds3c0im1L5Rnlm', 'Semarang', 6, 70, 2.50, 'Teknik', 'Teknik Komputer', '8123456785', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(118, 'Toni Setiawan', '21120345018', 'L', 'Islam', '2018', 'Mandiri', '$2a$10$QOIKRFHrrGosFzjaRwy46OVoyDcEiIkLdStCsd/13aiiMUpM7DXiq', 'Surabaya', 6, 70, 2.20, 'Teknik', 'Teknik Komputer', '8123456786', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(119, 'Ari Wibowo', '21120345019', 'L', 'Hindu', '2017', 'SNMPTN', '$2a$10$//5gRrWuvFj1p7JC4XlehexlGdexJploNg6MyG3uP7A8ja6k9p0V.', 'Bekasi', 7, 90, 2.90, 'Teknik', 'Teknik Komputer', '8123456787', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(120, 'Melati Dewi', '21120345020', 'P', 'Kristen', '2017', 'SBMPTN', '$2a$10$aAu7SwrHgi96shbaUyxlseJWjiy.9/2JZ7GwY9fMdD6S0TioIOduu', 'Medan', 7, 90, 2.40, 'Teknik', 'Teknik Komputer', '8123456788', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(121, 'Bambang Sutejo', '21120345021', 'L', 'Islam', '2017', 'Mandiri', '$2a$10$M/FfqacrkgFTukp/pKVi9euI9Gi3eLRUz38/7AfHsXizGEsyXAb4G', 'Palembang', 7, 60, 2.20, 'Teknik', 'Teknik Komputer', '8123456789', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(122, 'Dian Fitriani', '21120345022', 'P', 'Hindu', '2016', 'SNMPTN', '$2a$10$3k9gE0JUeuGYNCj2vxzN0.Ij0MZwbzobf9cRSVSNmK5VPxR3vuRsa', 'Denpasar', 8, 144, 3.00, 'Teknik', 'Teknik Komputer', '8123456780', 'Aktif', 9, 0, '2024-09-04 04:59:09'),
(123, 'Rian Saputra', '21120345023', 'L', 'Islam', '2016', 'SBMPTN', '$2a$10$tMeQQFNJzCqNInMTcS9Rqe3upNmDclikSrKELpIQ3s1zNMbh497x6', 'Makassar', 8, 120, 2.40, 'Teknik', 'Teknik Komputer', '8123456781', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(124, 'Ratna Sari', '21120345024', 'P', 'Kristen', '2016', 'Mandiri', '$2a$10$0jV2GHRxs6Jc2j63lTDCIefTHS/mqclz0/j4.8ibkEBLd/9jZWoYO', 'Malang', 8, 93, 2.10, 'Teknik', 'Teknik Komputer', '8123456782', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(125, 'Ari Wibowo', '21120345025', 'L', 'Hindu', '2015', 'SNMPTN', '$2a$10$Ag0q3BYSoj8X2T7fbDDtruAettVSi8PyTEUr5iG33sWkfY7xifB6.', 'Bekasi', 9, 110, 2.70, 'Teknik', 'Teknik Komputer', '8123456783', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(126, 'Melati Dewi', '21120345026', 'P', 'Kristen', '2015', 'SBMPTN', '$2a$10$OCoyLq8pQLMhnOEZJ1X7z.xRwhhfZNF.JqbSHs7KaZuzqj7DhuIo.', 'Medan', 9, 100, 2.40, 'Teknik', 'Teknik Komputer', '8123456784', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(127, 'Bambang Sutejo', '21120345027', 'L', 'Islam', '2015', 'Mandiri', '$2a$10$rPDcyu.CtVl8QsvQv90/B.gYmxF.DQ4fVvdoFfXyPyfLfUMqbuH.u', 'Palembang', 9, 90, 2.00, 'Teknik', 'Teknik Komputer', '8123456785', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(128, 'Rina Kartika', '21120345028', 'P', 'Kristen', '2014', 'SNMPTN', '$2a$10$4jlsLB5huvA4.Ap1y.0y2OEJF/SPcuf.GwTSnKPFOUK2LaxHzsjeu', 'Semarang', 10, 125, 3.20, 'Teknik', 'Teknik Komputer', '8123456786', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(129, 'Dedi Gunawan', '21120345029', 'L', 'Islam', '2014', 'SBMPTN', '$2a$10$Kq6Dz.TjQfRhjSgLLARX9uDDPVdWTBcdBa6wxa26PAZCS50PGGEWG', 'Yogyakarta', 10, 115, 2.49, 'Teknik', 'Teknik Komputer', '8123456787', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(130, 'Linda Susanti', '21120345030', 'P', 'Islam', '2014', 'Mandiri', '$2a$10$o5Yd7E7F96Mmm6gMDBij3.rhpFFOuBm.IKu8LneFTDlLJGm5kzlQW', 'Malang', 10, 93, 2.30, 'Teknik', 'Teknik Komputer', '8123456788', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(131, 'Dian Fitriani', '21120345031', 'P', 'Hindu', '2013', 'SNMPTN', '$2a$10$f4b3o1y8gVcGq.uhBiSUfepDmSqwXfZcDEO5IFXsUF2hM.IFV5j9C', 'Denpasar', 11, 135, 3.10, 'Teknik', 'Teknik Komputer', '8123456789', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(132, 'Rian Saputra', '21120345032', 'L', 'Islam', '2013', 'SBMPTN', '$2a$10$PX84qHf9cmoJ/oayhwCqbOx8V3dRUcNV5UzgDp5WqAyyRPYT5VRDu', 'Makassar', 11, 93, 2.60, 'Teknik', 'Teknik Komputer', '8123456780', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(133, 'Ratna Sari', '21120345033', 'P', 'Kristen', '2013', 'Mandiri', '$2a$10$RXAZrI2vFFhUcw/R0Lkbheo5Q/OUMn.QpkKnlzORjdYPnSRb4OXE2', 'Malang', 11, 93, 2.40, 'Teknik', 'Teknik Komputer', '8123456781', 'Aktif', 9, 0, '2024-09-04 04:59:10'),
(134, 'Ari Wibowo', '21120345034', 'L', 'Hindu', '2012', 'SNMPTN', '$2a$10$2Ko0kdAnWaEOeSPLRM2AE.WTMSvmNye52T81aukzrs4KMi20.KJ4m', 'Bekasi', 12, 140, 3.00, 'Teknik', 'Teknik Komputer', '8123456782', 'Aktif', 9, 0, '2024-09-04 04:59:11'),
(135, 'Melati Dewi', '21120345035', 'P', 'Kristen', '2012', 'SBMPTN', '$2a$10$J9hkt.ursNqGn6y6Ez5faO5aYDirQMDgy7P1Bsmk0M8IAhkBcbgt.', 'Medan', 12, 93, 2.50, 'Teknik', 'Teknik Komputer', '8123456783', 'Aktif', 9, 0, '2024-09-04 04:59:11'),
(136, 'Bambang Sutejo', '21120345036', 'L', 'Islam', '2012', 'Mandiri', '$2a$10$UgVchboH81i8yIVXqGsZWeMJDMzrqgnRXKUyFTqli5BjdUbKrq/J6', 'Palembang', 12, 93, 2.30, 'Teknik', 'Teknik Komputer', '8123456784', 'Aktif', 9, 0, '2024-09-04 04:59:11'),
(137, 'Dian Fitriani', '21120345037', 'P', 'Hindu', '2011', 'SNMPTN', '$2a$10$OxPj1llcKDsG9mD4rhwl2.fmVPpBZhQco8uHc5xzL7aBjGYkZu4Qm', 'Denpasar', 13, 108, 3.00, 'Teknik', 'Teknik Komputer', '8123456785', 'Aktif', 9, 0, '2024-09-04 04:59:11'),
(138, 'Rian Saputra', '21120345038', 'L', 'Islam', '2011', 'SBMPTN', '$2a$10$FCmzOnO/m8IXdFs./x.8kO5nSqjDMKx2j3bLw5qswW52d8sFUAkOC', 'Makassar', 13, 135, 2.40, 'Teknik', 'Teknik Komputer', '8123456786', 'Aktif', 9, 0, '2024-09-04 04:59:11'),
(139, 'Ratna Sari', '21120345039', 'P', 'Kristen', '2011', 'Mandiri', '$2a$10$g75HAhiB55alFhkQxyaCyuStsqSxnz5YxW9NOW.GCLEodVTCQNOKi', 'Malang', 13, 107, 2.20, 'Teknik', 'Teknik Komputer', '8123456787', 'Aktif', 9, 0, '2024-09-04 04:59:11'),
(140, 'Tono Setiawan', '21120345040', 'L', 'Islam', '2010', 'SNMPTN', '$2a$10$1ipdKtlB1V5JGh4Dc/trOO1HUp5pUptiIb0uI9EJTMKBdxrfFCayq', 'Solo', 14, 144, 2.70, 'Teknik', 'Teknik Komputer', '8123456788', 'Aktif', 9, 0, '2024-09-04 04:59:11'),
(145, 'MARUL ANGGARA', 'http://www.google.com/', 'Laki-laki', 'Islam', '2020', 'Mandiri', '$2a$10$MxltE2FrxGidEp7zXKmxfOAqZ0XOo2623jH879bpjs3zQGLxkRyy.', 'Desa Growong Lor', 9, 147, 3.67, 'Teknik', 'Teknik Komputer', '0', 'Aktif', 28, 0, '2024-09-21 06:01:41'),
(146, 'MARUL ANGGARA', '123124123', 'Laki-laki', 'Islam', '2020', 'Mandiri', '$2a$10$IMkTigbbQKZ6oqhuH0Ab9uyFeUFzkmckKKdUMxk5SoRygz5fDXZYy', 'Desa Growong Lor', 9, 147, 3.67, 'Teknik', 'Teknik Komputer', '0', 'Aktif', NULL, 0, '2024-09-23 00:36:21');

-- --------------------------------------------------------

--
-- Struktur dari tabel `perwalian`
--

CREATE TABLE `perwalian` (
  `IdPerwalian` int(11) NOT NULL,
  `NamaMaha` varchar(100) NOT NULL,
  `NimMaha` varchar(20) NOT NULL,
  `NamaOrtu` varchar(100) NOT NULL,
  `PhoneOrtu` varchar(255) DEFAULT NULL,
  `Semester` int(11) NOT NULL,
  `Sks` int(11) NOT NULL,
  `Ipk` decimal(3,2) NOT NULL,
  `TanggalPerwalian` datetime NOT NULL DEFAULT current_timestamp(),
  `Alamat` varchar(255) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `DosenWali` varchar(100) DEFAULT NULL,
  `uraian` enum('Awal Semester','Sebelum UTS','Sebelum UAS') NOT NULL,
  `masalah` text DEFAULT NULL,
  `rekomendasi` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `IdMaha` int(11) DEFAULT NULL,
  `IdDosen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `perwalian`
--

INSERT INTO `perwalian` (`IdPerwalian`, `NamaMaha`, `NimMaha`, `NamaOrtu`, `PhoneOrtu`, `Semester`, `Sks`, `Ipk`, `TanggalPerwalian`, `Alamat`, `phone`, `DosenWali`, `uraian`, `masalah`, `rekomendasi`, `image_path`, `IdMaha`, `IdDosen`) VALUES
(45, 'mahasiswa tekkom', '2222222', 'Ibu', '089765772', 3, 50, 3.00, '2024-08-10 14:43:25', 'Semarang', '0896543782', 'Prof. Budi', 'Awal Semester', 'isi coba', 'okee', 'uploads\\1723873717832-2024-02-19 10-43-25.png', NULL, 9),
(48, 'MUHAMMAD FITRA ARISAPUTRA', '21120120140160', 'oke', '081280376979', 8, 144, 3.46, '2024-08-30 09:15:20', '-', '081280376979', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', 'osadnnoeoa\n', 'oke', 'uploads\\1726895582802-Marul Anggara_21120120140138_UAS SBD_ER Metode Chen.png', 62, 31),
(49, 'MUHAMMAD FITRA ARISAPUTRA', '21120120140160', 'oke', '081280376979', 8, 144, 3.46, '2024-08-30 09:15:33', '-', '081280376979', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', 'okokoaosdm\n', 'ganti', 'uploads\\1726894977856-bg_wave.png', 62, 31),
(50, 'MUHAMMAD FITRA ARISAPUTRA', '21120120140160', 'oke', '081280376979', 8, 144, 3.46, '2024-08-30 09:15:43', '-', '081280376979', 'Ike Pertiwi Windasari, S.T., M.T.', 'Sebelum UAS', 'asdmkdnw', 'baik', 'uploads\\1724987098560-TTD_Marul.png', 62, 31),
(51, 'MUHAMMAD FITRA ARISAPUTRA', '21120120140160', 'oke', '081280376979', 8, 144, 3.46, '2024-08-30 09:15:54', '-', '081280376979', 'Ike Pertiwi Windasari, S.T., M.T.', 'Sebelum UAS', 'addwaedds', 'okeeee', 'uploads\\1724986993196-TTD_Marul.png', 62, 31),
(52, 'MUHAMMAD FITRA ARISAPUTRA', '21120120140160', 'oke', '081280376979', 8, 144, 3.46, '2024-08-30 09:16:04', '-', '081280376979', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', 'okojnainiwe', 'baiklah', 'uploads\\1724986793211-TTD_Marul.png', 62, 31),
(53, 'MUHAMMAD FITRA ARISAPUTRA', '21120120140160', 'Ibu', '0896768628368', 10, 144, 3.46, '2024-08-31 07:59:29', 'jalan diponegoro', '0812803769790', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', 'Laporan TA', 'acc', 'uploads\\1726110479176-TTD_Marul.png', 62, 31),
(54, 'MUHAMMAD FITRA ARISAPUTRA', '21120120140160', 'Ibu', '0897737213', 10, 144, 3.46, '2024-08-31 08:02:18', 'jalan diponegoro', '081280376979', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', 'oke', '-', 'uploads\\1725080245959-TTD_Marul.png', 62, 31),
(56, 'MUHAMMAD FITRA ARISAPUTRA', '21120120140160', 'Ibu', '08989786823', 9, 144, 3.46, '2024-09-12 10:04:38', 'jalan diponegoro, tembalang', '0812803769790', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', 'testv1', 'oke masuk', 'uploads\\1726110388114-TTD_Marul.png', 62, 31),
(58, 'MARUL ANGGARA', '21120120140138', 'ibu saya', '08123456789', 10, 147, 3.65, '2024-09-19 16:13:22', 'Jalan Emas, Desa Growong Lor RT.002', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Sebelum UAS', 'Sidang tugas akhir', 'lulus', 'uploads\\1726893821062-bg_wave.png', 4, 31),
(59, 'MARUL ANGGARA', '21120120140138', 'Ibu', '08957686213', 10, 147, 3.65, '2024-09-19 16:44:26', 'Jalan Emas, Desa Growong Lor RT.002', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Sebelum UTS', 'Tips lulus tepat waktu', 'amin', 'uploads\\1726890154880-TTD_Marul.png', 4, 31),
(60, 'MARUL ANGGARA', '21120120140138', 'Ibu', '08989766', 10, 147, 3.65, '2024-09-20 09:46:41', 'Jalan Emas, Desa Growong Lor RT.002', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Sebelum UTS', 'sidang tugas akhir', 'lulus', 'uploads\\1726800576056-TTD_Marul.png', 4, 31),
(61, 'MARUL ANGGARA', '21120120140138', 'ibu', '0987879232', 10, 147, 3.65, '2024-09-21 10:35:57', 'Jalan Emas, Desa Growong Lor RT.02', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Sebelum UAS', 'lulus', 'amin', 'uploads\\1726890033224-TTD_Marul.png', 4, 31),
(62, 'MARUL ANGGARA', '21120120140138', 'ibu', '09778', 10, 147, 3.65, '2024-09-21 13:15:59', 'Jalan Emas, Desa Growong Lor RT.002', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Sebelum UTS', 'lulus', 'amin', 'uploads\\1726977653359-bg_wave.png', 4, 31),
(63, 'MARUL ANGGARA', '21120120140138', 'ibu', '0897', 10, 147, 3.65, '2024-09-21 17:01:08', 'Jalan Emas, Desa Growong Lor RT.002', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', 'sidang', 'lulus', 'uploads\\1726914562656-bg_wave.png', 4, 31),
(64, 'MARUL ANGGARA', '21120120140138', 'ibuku', '1233123123', 10, 147, 3.65, '2024-09-21 17:50:05', 'Jalan Emas, Desa Growong Lor RT.02', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', 'lulus', NULL, NULL, 4, 31),
(65, 'MARUL ANGGARA', '21120120140138', 'ibu', '0', 10, 147, 3.65, '2024-09-22 09:12:54', 'Jalan Emas, Desa Growong Lor RT.002', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', '-', NULL, NULL, 4, 31),
(66, 'MARUL ANGGARA', '21120120140138', 'ibu', '089989898', 10, 147, 3.65, '2024-09-22 10:01:35', 'Jalan Emas, Desa Growong Lor RT.02', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Awal Semester', 'revisi', NULL, NULL, 4, 31),
(67, 'MARUL ANGGARA', '21120120140138', 'ibuku', '0987', 10, 147, 3.65, '2024-09-22 10:43:20', 'Jalan Emas, Desa Growong Lor RT.02', '0895395070385', 'Ike Pertiwi Windasari, S.T., M.T.', 'Sebelum UTS', 'acc laporan', NULL, NULL, 4, 31);

-- --------------------------------------------------------

--
-- Struktur dari tabel `survei`
--

CREATE TABLE `survei` (
  `IdSurvei` bigint(20) UNSIGNED NOT NULL,
  `merasa_cemas` int(11) DEFAULT NULL,
  `merasa_bingung` int(11) DEFAULT NULL,
  `menarik_diri` int(11) DEFAULT NULL,
  `merasa_bosan` int(11) DEFAULT NULL,
  `merasa_tidak_puas` int(11) DEFAULT NULL,
  `merasa_lelah` int(11) DEFAULT NULL,
  `tidak_dapat_mencari_jalan_keluar` int(11) DEFAULT NULL,
  `tidak_dapat_berkonsentrasi` int(11) DEFAULT NULL,
  `merasa_tidak_kreatif` int(11) DEFAULT NULL,
  `merasa_tidak_tahu` int(11) DEFAULT NULL,
  `merasa_tidak_percaya_diri` int(11) DEFAULT NULL,
  `detak_jantung_berdebar` int(11) DEFAULT NULL,
  `lambung_terasa_perih` int(11) DEFAULT NULL,
  `mudah_keluar_keringat_dingin` int(11) DEFAULT NULL,
  `kepala_pusing` int(11) DEFAULT NULL,
  `susah_tidur` int(11) DEFAULT NULL,
  `merasa_mudah_mengantuk` int(11) DEFAULT NULL,
  `menunda_tugas` int(11) DEFAULT NULL,
  `bolos_kuliah` int(11) DEFAULT NULL,
  `kehilangan_nafsu_makan` int(11) DEFAULT NULL,
  `komunikasi_kurang_baik` int(11) DEFAULT NULL,
  `total_nilai` int(11) DEFAULT NULL,
  `Semester` int(11) DEFAULT NULL,
  `IdMaha` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `survei`
--

INSERT INTO `survei` (`IdSurvei`, `merasa_cemas`, `merasa_bingung`, `menarik_diri`, `merasa_bosan`, `merasa_tidak_puas`, `merasa_lelah`, `tidak_dapat_mencari_jalan_keluar`, `tidak_dapat_berkonsentrasi`, `merasa_tidak_kreatif`, `merasa_tidak_tahu`, `merasa_tidak_percaya_diri`, `detak_jantung_berdebar`, `lambung_terasa_perih`, `mudah_keluar_keringat_dingin`, `kepala_pusing`, `susah_tidur`, `merasa_mudah_mengantuk`, `menunda_tugas`, `bolos_kuliah`, `kehilangan_nafsu_makan`, `komunikasi_kurang_baik`, `total_nilai`, `Semester`, `IdMaha`, `created_at`) VALUES
(50, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 4, '2024-08-03 07:43:25'),
(51, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 21, NULL, 4, '2024-08-03 07:44:16'),
(52, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3, 4, '2024-08-03 07:45:32'),
(53, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3, 4, '2024-08-03 07:46:44'),
(54, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 21, 3, 4, '2024-08-03 07:47:25'),
(55, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3, 4, '2024-08-03 07:48:04'),
(56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 3, 4, '2024-08-03 07:48:42'),
(57, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 21, 3, 4, '2024-08-03 08:11:47'),
(58, 1, 1, 1, 3, 2, 3, 2, 2, 2, 1, 2, 1, 1, 1, 2, 1, 2, 2, 1, 1, 1, 33, 9, 4, '2024-08-04 08:47:49'),
(59, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 21, 3, NULL, '2024-08-04 11:28:48'),
(60, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 22, 9, 4, '2024-08-06 07:48:03'),
(61, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 21, 9, 62, '2024-08-10 07:41:48'),
(62, 2, 1, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 2, 1, 2, 1, 2, 2, 2, 1, 1, 34, 9, 4, '2024-09-09 01:03:36'),
(63, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 21, 9, NULL, '2024-09-20 03:01:39');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`IdAdmin`),
  ADD UNIQUE KEY `username` (`usernameAdmin`),
  ADD UNIQUE KEY `email` (`emailAdmin`);

--
-- Indeks untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`IdDosen`),
  ADD KEY `fk_IdInfo` (`IdInfo`);

--
-- Indeks untuk tabel `gpm`
--
ALTER TABLE `gpm`
  ADD PRIMARY KEY (`IdGpm`);

--
-- Indeks untuk tabel `info`
--
ALTER TABLE `info`
  ADD PRIMARY KEY (`IdInfo`),
  ADD KEY `IdDosen` (`IdDosen`);

--
-- Indeks untuk tabel `jadwal_dosen`
--
ALTER TABLE `jadwal_dosen`
  ADD PRIMARY KEY (`IdJadwal`),
  ADD KEY `IdDosen` (`IdDosen`);

--
-- Indeks untuk tabel `jadwal_perwalian`
--
ALTER TABLE `jadwal_perwalian`
  ADD PRIMARY KEY (`IdPermintaan`),
  ADD KEY `fk_jadwal_perwalian_1` (`IdMaha`),
  ADD KEY `fk_jadwal_perwalian_2` (`IdDosen`);

--
-- Indeks untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`IdMaha`),
  ADD KEY `fk_IdDosen` (`IdDosen`);

--
-- Indeks untuk tabel `perwalian`
--
ALTER TABLE `perwalian`
  ADD PRIMARY KEY (`IdPerwalian`),
  ADD KEY `fk_Id_Dosen` (`IdDosen`),
  ADD KEY `fk_IdMaha` (`IdMaha`);

--
-- Indeks untuk tabel `survei`
--
ALTER TABLE `survei`
  ADD PRIMARY KEY (`IdSurvei`),
  ADD KEY `fk_id_maha` (`IdMaha`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admin`
--
ALTER TABLE `admin`
  MODIFY `IdAdmin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT untuk tabel `dosen`
--
ALTER TABLE `dosen`
  MODIFY `IdDosen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=922;

--
-- AUTO_INCREMENT untuk tabel `gpm`
--
ALTER TABLE `gpm`
  MODIFY `IdGpm` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=436;

--
-- AUTO_INCREMENT untuk tabel `info`
--
ALTER TABLE `info`
  MODIFY `IdInfo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1989;

--
-- AUTO_INCREMENT untuk tabel `jadwal_dosen`
--
ALTER TABLE `jadwal_dosen`
  MODIFY `IdJadwal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT untuk tabel `jadwal_perwalian`
--
ALTER TABLE `jadwal_perwalian`
  MODIFY `IdPermintaan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1591;

--
-- AUTO_INCREMENT untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `IdMaha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=147;

--
-- AUTO_INCREMENT untuk tabel `perwalian`
--
ALTER TABLE `perwalian`
  MODIFY `IdPerwalian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT untuk tabel `survei`
--
ALTER TABLE `survei`
  MODIFY `IdSurvei` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `fk_IdInfo` FOREIGN KEY (`IdInfo`) REFERENCES `info` (`IdInfo`);

--
-- Ketidakleluasaan untuk tabel `info`
--
ALTER TABLE `info`
  ADD CONSTRAINT `info_ibfk_1` FOREIGN KEY (`IdDosen`) REFERENCES `dosen` (`IdDosen`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `jadwal_dosen`
--
ALTER TABLE `jadwal_dosen`
  ADD CONSTRAINT `fk_dosen` FOREIGN KEY (`IdDosen`) REFERENCES `dosen` (`IdDosen`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Ketidakleluasaan untuk tabel `jadwal_perwalian`
--
ALTER TABLE `jadwal_perwalian`
  ADD CONSTRAINT `fk_jadwal_perwalian_1` FOREIGN KEY (`IdMaha`) REFERENCES `mahasiswa` (`IdMaha`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_jadwal_perwalian_2` FOREIGN KEY (`IdDosen`) REFERENCES `dosen` (`IdDosen`) ON DELETE SET NULL;

--
-- Ketidakleluasaan untuk tabel `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `fk_IdDosen` FOREIGN KEY (`IdDosen`) REFERENCES `dosen` (`IdDosen`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Ketidakleluasaan untuk tabel `perwalian`
--
ALTER TABLE `perwalian`
  ADD CONSTRAINT `fk_IdMaha` FOREIGN KEY (`IdMaha`) REFERENCES `mahasiswa` (`IdMaha`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `fk_Id_Dosen` FOREIGN KEY (`IdDosen`) REFERENCES `dosen` (`IdDosen`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Ketidakleluasaan untuk tabel `survei`
--
ALTER TABLE `survei`
  ADD CONSTRAINT `fk_id_maha` FOREIGN KEY (`IdMaha`) REFERENCES `mahasiswa` (`IdMaha`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

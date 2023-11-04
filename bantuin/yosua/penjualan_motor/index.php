<?php 
    require_once 'koneksi.php';

    if (!isset($_SESSION['id_user'])) {
        header("Location: login.php");
        exit;
    }

    $total_penjualan_hari_ini = mysqli_fetch_assoc(mysqli_query($koneksi, "SELECT *, COUNT(penjualan.id_pelanggan) AS jumlah_penjualan FROM penjualan INNER JOIN motor ON penjualan.id_motor = motor.id_motor WHERE DATE(tanggal) = CURDATE()"))['jumlah_penjualan'];

    $total_penjualan_hari_ini_kredit = mysqli_fetch_assoc(mysqli_query($koneksi, "SELECT *, COUNT(penjualan.id_pelanggan) AS jumlah_penjualan FROM penjualan INNER JOIN motor ON penjualan.id_motor = motor.id_motor WHERE DATE(tanggal) = CURDATE() AND pembayaran = 'kredit'"))['jumlah_penjualan'];

    $total_penjualan_hari_ini_cash = mysqli_fetch_assoc(mysqli_query($koneksi, "SELECT *, COUNT(penjualan.id_pelanggan) AS jumlah_penjualan FROM penjualan INNER JOIN motor ON penjualan.id_motor = motor.id_motor WHERE DATE(tanggal) = CURDATE() AND pembayaran = 'cash'"))['jumlah_penjualan'];

    $penjualan = mysqli_query($koneksi, "SELECT * FROM penjualan INNER JOIN pelanggan ON penjualan.id_pelanggan = pelanggan.id_pelanggan INNER JOIN motor ON penjualan.id_motor = motor.id_motor WHERE DATE(tanggal) = CURDATE() ORDER BY tanggal DESC");
?>

<html>
<head>
    <?php include_once 'head.php'; ?>
    <title>Dashboard</title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <div class="bg-table">
            <h2 class="text-center">Dashboard</h2>
            <div class="row justify-content-between">
                <div class="col">
                    <div class="card">
                        <h4>Total Penjualan Hari ini:<br><?= str_replace(",", ".", number_format($total_penjualan_hari_ini)); ?> Motor</h4>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <h4>Total Penjualan Hari ini Kredit:<br><?= str_replace(",", ".", number_format($total_penjualan_hari_ini_kredit)); ?> Motor</h4>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <h4>Total Penjualan Hari ini Cash:<br><?= str_replace(",", ".", number_format($total_penjualan_hari_ini_cash)); ?> Motor</h4>
                    </div>
                </div>
            </div>
            <div class="head-left">
                <h2>Penjualan Hari Ini:</h2>
            </div>
            <div class="head-right">
                <a href="tambah_penjualan.php" class="button">Tambah Penjualan</a>
            </div>
            <form method="post" class="clear form-cari">
                <input class="input" type="text" id="cari" name="cari" placeholder="Cari" required value="<?= (isset($_POST['cari'])) ? $_POST['cari'] : ''; ?>">
                <button type="submit" class="button align-right" name="btnCari">Cari</button>
            </form>
            <?php if (isset($_POST['cari'])): ?>
                <a href="penjualan.php" class="button">Reset</a>
                <h3>Data ditemukan: <?= mysqli_num_rows($penjualan); ?></h3>
            <?php endif ?>
            <div class="table-responsive">
                <table border="1" cellpadding="10" cellspacing="0"> 
                    <tr>
                        <th>No.</th>
                        <th>Tanggal</th>
                        <th>Nama Pelanggan</th>
                        <th>Nama Motor</th>
                        <th>Harga</th>
                        <th>Pembayaran</th>
                        <th>Aksi</th>
                    </tr>
                    <?php $i = 1; ?>
                    <?php foreach ($penjualan as $data_penjualan): ?>
                        <tr>
                            <td><?= $i++; ?></td>
                            <td><?= date("d-m-Y", strtotime($data_penjualan['tanggal'])); ?></td>
                            <td><?= $data_penjualan['nama_pelanggan']; ?></td>
                            <td><?= $data_penjualan['nama']; ?></td>
                            <td>Rp. <?= str_replace(",", ".", number_format($data_penjualan['harga'])); ?></td>
                            <td><?= $data_penjualan['pembayaran']; ?></td>
                            <td>
                                <a class="button" href="ubah_penjualan.php?id_penjualan=<?= $data_penjualan['id_penjualan']; ?>">Ubah</a>
                                <a class="button" onclick="return confirm('Apakah Anda yakin ingin menghapus Penjualan <?= $data_penjualan['nama_pelanggan']; ?>?')" href="hapus_penjualan.php?id_penjualan=<?= $data_penjualan['id_penjualan']; ?>">Hapus</a>
                            </td>
                        </tr>
                    <?php endforeach ?>
                </table>
            </div>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
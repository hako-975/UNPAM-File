<?php 
    require_once 'koneksi.php';
    
    if (!isset($_SESSION['id_user'])) {
        header("Location: login.php");
        exit;
    }

    $penjualan = mysqli_query($koneksi, "SELECT * FROM penjualan INNER JOIN pelanggan ON penjualan.id_pelanggan = pelanggan.id_pelanggan INNER JOIN motor ON penjualan.id_motor = motor.id_motor ORDER BY tanggal DESC");

    if (isset($_POST['btnCari'])) {
        $cari = htmlspecialchars($_POST['cari']);
        $penjualan = mysqli_query($koneksi, "SELECT * FROM penjualan INNER JOIN pelanggan ON penjualan.id_pelanggan = pelanggan.id_pelanggan INNER JOIN motor ON penjualan.id_motor = motor.id_motor
            WHERE tanggal LIKE '%$cari%' OR nama_pelanggan LIKE '%$cari%' OR nama LIKE '%$cari%' OR harga LIKE '%$cari%' OR pembayaran LIKE '%$cari%'
         ORDER BY tanggal DESC");
    }
?>

<html>
<head>
    <?php include_once 'head.php'; ?>
    <title>Penjualan</title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <div class="bg-table">
            <div class="head-left">
                <h2>Penjualan</h2>
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
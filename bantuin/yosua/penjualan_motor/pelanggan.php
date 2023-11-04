<?php 
    require_once 'koneksi.php';
    
    if (!isset($_SESSION['id_user'])) {
        header("Location: login.php");
        exit;
    }

    $pelanggan = mysqli_query($koneksi, "SELECT * FROM pelanggan ORDER BY nama_pelanggan ASC");

    if (isset($_POST['btnCari'])) {
        $cari = htmlspecialchars($_POST['cari']);
        $pelanggan = mysqli_query($koneksi, "SELECT * FROM pelanggan WHERE id_pelanggan LIKE '%$cari%' OR  nama_pelanggan LIKE '%$cari%' OR  no_telepon_pelanggan LIKE '%$cari%' OR  alamat_pelanggan LIKE '%$cari%' ORDER BY nama_pelanggan ASC");
    }
?>

<html>
<head>
    <?php include_once 'head.php'; ?>
    <title>Pelanggan</title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <div class="bg-table">
            <div class="head-left">
                <h2>Pelanggan</h2>
            </div>
            <div class="head-right">
                <a href="tambah_pelanggan.php" class="button">Tambah Pelanggan</a>
            </div>
            <form method="post" class="clear form-cari">
                <input class="input" type="text" id="cari" name="cari" placeholder="Cari" required value="<?= (isset($_POST['cari'])) ? $_POST['cari'] : ''; ?>">
                <button type="submit" class="button align-right" name="btnCari">Cari</button>
            </form>
            <?php if (isset($_POST['cari'])): ?>
                <a href="pelanggan.php" class="button">Reset</a>
                <h3>Data ditemukan: <?= mysqli_num_rows($pelanggan); ?></h3>
            <?php endif ?>
            <div class="table-responsive">
                <table border="1" cellpadding="10" cellspacing="0">
                    <tr>
                        <th>No.</th>
                        <th>Nama Pelanggan</th>
                        <th>No. Telepon Pelanggan</th>
                        <th>Alamat Pelanggan</th>
                        <th>Aksi</th>
                    </tr>
                    <?php $i = 1; ?>
                    <?php foreach ($pelanggan as $data_pelanggan): ?>
                        <tr>
                            <td><?= $i++; ?></td>
                            <td><?= $data_pelanggan['nama_pelanggan']; ?></td>
                            <td><?= $data_pelanggan['no_telepon_pelanggan']; ?></td>
                            <td><?= $data_pelanggan['alamat_pelanggan']; ?></td>
                            <td>
                                <a class="button" href="ubah_pelanggan.php?id_pelanggan=<?= $data_pelanggan['id_pelanggan']; ?>">Ubah</a>
                                <a class="button" onclick="return confirm('Apakah Anda yakin ingin menghapus pelanggan <?= $data_pelanggan['nama_pelanggan']; ?>?')" href="hapus_pelanggan.php?id_pelanggan=<?= $data_pelanggan['id_pelanggan']; ?>">Hapus</a>
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
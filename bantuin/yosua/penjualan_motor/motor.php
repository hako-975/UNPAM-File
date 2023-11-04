<?php 
    require_once 'koneksi.php';
    
    if (!isset($_SESSION['id_user'])) {
        header("Location: login.php");
        exit;
    }

    $motor = mysqli_query($koneksi, "SELECT * FROM motor ORDER BY nama ASC");

    if (isset($_POST['btnCari'])) {
        $cari = htmlspecialchars($_POST['cari']);
        $motor = mysqli_query($koneksi, "SELECT * FROM motor WHERE id_motor LIKE '%$cari%' OR nama LIKE '%$cari%' OR merk LIKE '%$cari%' OR tahun LIKE '%$cari%' OR harga LIKE '%$cari%' ORDER BY nama ASC");
    }
?>

<html>
<head>
    <?php include_once 'head.php'; ?>
    <title>Motor</title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <div class="bg-table">
            <div class="head-left">
                <h2>Motor</h2>
            </div>
            <div class="head-right">
                <a href="tambah_motor.php" class="button">Tambah Motor</a>
            </div>
            <form method="post" class="clear form-cari">
                <input class="input" type="text" id="cari" name="cari" placeholder="Cari" required value="<?= (isset($_POST['cari'])) ? $_POST['cari'] : ''; ?>">
                <button type="submit" class="button align-right" name="btnCari">Cari</button>
            </form>
            <?php if (isset($_POST['cari'])): ?>
                <a href="motor.php" class="button">Reset</a>
                <h3>Data ditemukan: <?= mysqli_num_rows($motor); ?></h3>
            <?php endif ?>
            <div class="table-responsive">
                <table border="1" cellpadding="10" cellspacing="0">
                    <tr>
                        <th>No.</th>
                        <th>Nama</th>
                        <th>Merk</th>
                        <th>Tahun</th>
                        <th>Harga</th>
                        <th>Aksi</th>
                    </tr>
                    <?php $i = 1; ?>
                    <?php foreach ($motor as $data_motor): ?>
                        <tr>
                            <td><?= $i++; ?></td>
                            <td><?= $data_motor['nama']; ?></td>
                            <td><?= $data_motor['merk']; ?></td>
                            <td><?= $data_motor['tahun']; ?></td>
                            <td>Rp. <?= str_replace(",", ".", number_format($data_motor['harga'])); ?></td>
                            <td>
                                <a class="button" href="ubah_motor.php?id_motor=<?= $data_motor['id_motor']; ?>">Ubah</a>
                                <a class="button" onclick="return confirm('Apakah Anda yakin ingin menghapus Motor <?= $data_motor['nama']; ?>?')" href="hapus_motor.php?id_motor=<?= $data_motor['id_motor']; ?>">Hapus</a>
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
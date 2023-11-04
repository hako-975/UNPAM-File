<?php 
    require_once 'koneksi.php';
    if (!isset($_SESSION['id_user'])) {
        header("Location: login.php");
        exit;
    }

    $id_penjualan = $_GET['id_penjualan'];
    $data_penjualan = mysqli_fetch_assoc(mysqli_query($koneksi, "SELECT * FROM penjualan WHERE id_penjualan = '$id_penjualan'"));

    $motor = mysqli_query($koneksi, "SELECT * FROM motor ORDER BY nama ASC");
    $pelanggan = mysqli_query($koneksi, "SELECT * FROM pelanggan ORDER BY nama_pelanggan ASC");


    if (isset($_POST['btnUbah'])) {
        $tanggal = $_POST['tanggal'];
        $id_pelanggan = $_POST['id_pelanggan'];
        $id_motor = $_POST['id_motor'];
        $pembayaran = $_POST['pembayaran'];

        if ($id_pelanggan == 0) {
            echo "
                <script>
                    alert('Pilih Pelanggan terlebih dahulu!')
                    window.history.back()
                </script>
            ";
            exit;
        }

        if ($id_motor == 0) {
            echo "
                <script>
                    alert('Pilih Motor terlebih dahulu!')
                    window.history.back()
                </script>
            ";
            exit;
        }

        if ($pembayaran == 0) {
            echo "
                <script>
                    alert('Pilih Pembayaran terlebih dahulu!')
                    window.history.back()
                </script>
            ";
            exit;
        }

        $ubah_penjualan = mysqli_query($koneksi, "UPDATE penjualan SET tanggal = '$tanggal', id_pelanggan = '$id_pelanggan', id_motor = '$id_motor', pembayaran = '$pembayaran' WHERE id_penjualan = '$id_penjualan'");

        if ($ubah_penjualan) {
            echo "
                <script>
                    alert('Penjualan berhasil diubah!')
                    window.location.href='penjualan.php'
                </script>
            ";
            exit;
        } else {
            echo "
                <script>
                    alert('Penjualan gagal diubah!')
                    window.history.back()
                </script>
            ";
            exit;
        }
    }
?>

<html>
<head>
    <?php include_once 'head.php'; ?>
    <title>Tambah Penjualan</title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <div class="container">
            <form method="post" class="form form-left">
                <h2>Tambah Penjualan</h2>
                <label class="label" for="tanggal">Tanggal</label>
                <input type="date" class="input" id="tanggal" name="tanggal" value="<?= $data_penjualan['tanggal']; ?>" required>

                <label class="label" for="id_pelanggan">Nama Pelanggan</label>
                <select class="input" id="id_pelanggan" name="id_pelanggan" required>
                    <?php
                        $id_pelanggan = $data_penjualan['id_pelanggan'];
                        $nama_pelanggan = mysqli_fetch_assoc(mysqli_query($koneksi, "SELECT * FROM pelanggan WHERE id_pelanggan = '$id_pelanggan'"))['nama_pelanggan'];
                    ?>
                    <option value="<?= $id_pelanggan ?>"><?= $nama_pelanggan; ?></option>
                    <?php foreach ($pelanggan as $data_pelanggan): ?>
                        <option value="<?= $data_pelanggan['id_pelanggan']; ?>"><?= $data_pelanggan['nama_pelanggan']; ?> (<?= $data_pelanggan['no_telepon_pelanggan']; ?>)</option>
                    <?php endforeach ?>
                </select>

                <label class="label" for="id_motor">Motor</label>
                <select class="input" id="id_motor" name="id_motor" required>
                    <?php
                        $id_motor = $data_penjualan['id_motor'];
                        $nama_motor = mysqli_fetch_assoc(mysqli_query($koneksi, "SELECT * FROM motor WHERE id_motor = '$id_motor'"))['nama'];
                    ?>
                    <option value="<?= $id_motor; ?>"><?= $nama_motor; ?></option>
                    <?php foreach ($motor as $data_motor): ?>
                        <option value="<?= $data_motor['id_motor']; ?>"><?= $data_motor['nama']; ?> (Rp. <?= str_replace(",", ".", number_format($data_motor['harga'])); ?>)</option>
                    <?php endforeach ?>
                </select>

                <label class="label" for="pembayaran">Pembayaran</label>
                <select class="input" id="pembayaran" name="pembayaran" required>
                    <option value="<?= $data_penjualan['pembayaran']; ?>"><?= $data_penjualan['pembayaran']; ?></option>
                    <?php if ($data_penjualan['pembayaran'] == 'Cash'): ?>
                        <option value="Kredit">Kredit</option>
                    <?php else: ?>
                        <option value="Cash">Cash</option>
                    <?php endif ?>
                </select>

                <button type="submit" class="button align-right" name="btnUbah">Submit</button>
            </form>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
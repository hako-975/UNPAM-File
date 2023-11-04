<?php 
    require_once 'koneksi.php';

    if (!isset($_SESSION['id_user'])) {
        header("Location: login.php");
        exit;
    }
    $id_motor = $_GET['id_motor'];
    $data_motor = mysqli_fetch_assoc(mysqli_query($koneksi, "SELECT * FROM motor WHERE id_motor = '$id_motor'"));
    if (isset($_POST['btnUbah'])) {
        $nama = $_POST['nama'];
        $merk = $_POST['merk'];
        $tahun = $_POST['tahun'];
        $harga = $_POST['harga'];

        $ubah_motor = mysqli_query($koneksi, "UPDATE motor SET nama = '$nama', merk = '$merk', tahun = '$tahun', harga = '$harga' WHERE id_motor = '$id_motor'");

        if ($ubah_motor) {
            echo "
                <script>
                    alert('Motor berhasil diubah!')
                    window.location.href='motor.php'
                </script>
            ";
            exit;
        } else {
            echo "
                <script>
                    alert('Motor gagal diubah!')
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
    <title>Ubah Motor - <?= $data_motor['nama']; ?></title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <div class="container">
            <form method="post" class="form form-left">
                <h2>Ubah Motor - <?= $data_motor['nama']; ?></h2>
                <label class="label" for="nama">Nama Motor</label>
                <input type="text" class="input" id="nama" name="nama" value="<?= $data_motor['nama']; ?>" required>

                <label class="label" for="merk">Merk</label>
                <input type="text" class="input" id="merk" name="merk" value="<?= $data_motor['merk']; ?>" required>

                <label class="label" for="tahun">Tahun</label>
                <input type="number" class="input" id="tahun" name="tahun" value="<?= $data_motor['tahun']; ?>" required>

                <label class="label" for="harga">Harga</label>
                <input type="number" class="input" id="harga" name="harga" value="<?= $data_motor['harga']; ?>" required>

                <button type="submit" class="button align-right" name="btnUbah">Submit</button>
            </form>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
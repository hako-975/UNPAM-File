<?php 
    require_once 'koneksi.php';
    if (!isset($_SESSION['id_user'])) {
        header("Location: login.php");
        exit;
    }

    $id_pelanggan = $_GET['id_pelanggan'];
    $data_pelanggan = mysqli_fetch_assoc(mysqli_query($koneksi, "SELECT * FROM pelanggan WHERE id_pelanggan = '$id_pelanggan'"));

    if (isset($_POST['btnUbah'])) {
        $nama_pelanggan = $_POST['nama_pelanggan'];
        $no_telepon_pelanggan = $_POST['no_telepon_pelanggan'];
        $alamat_pelanggan = $_POST['alamat_pelanggan'];

        $ubah_pelanggan = mysqli_query($koneksi, "UPDATE pelanggan SET nama_pelanggan = '$nama_pelanggan', no_telepon_pelanggan = '$no_telepon_pelanggan', alamat_pelanggan = '$alamat_pelanggan' WHERE id_pelanggan = '$id_pelanggan'");

        if ($ubah_pelanggan) {
            echo "
                <script>
                    alert('Pelanggan berhasil ditambahkan!')
                    window.location.href='pelanggan.php'
                </script>
            ";
            exit;
        } else {
            echo "
                <script>
                    alert('Pelanggan gagal ditambahkan!')
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
    <title>Ubah Pelanggan - <?= $data_pelanggan['nama_pelanggan']; ?></title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <div class="container">
            <form method="post" class="form form-left">
                <h2>Ubah Pelanggan - <?= $data_pelanggan['nama_pelanggan']; ?></h2>
                <label class="label" for="nama_pelanggan">Nama Pelanggan</label>
                <input type="text" class="input" id="nama_pelanggan" name="nama_pelanggan" value="<?= $data_pelanggan['nama_pelanggan']; ?>" required>

                <label class="label" for="no_telepon_pelanggan">No. Telepon Pelanggan</label>
                <input type="number" class="input" id="no_telepon_pelanggan" name="no_telepon_pelanggan" value="<?= $data_pelanggan['no_telepon_pelanggan']; ?>" required>

                <label class="label" for="alamat_pelanggan">Alamat Pelanggan</label>
                <textarea class="input" id="alamat_pelanggan" name="alamat_pelanggan" required><?= $data_pelanggan['alamat_pelanggan']; ?></textarea>

                <button type="submit" class="button align-right" name="btnUbah">Submit</button>
            </form>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
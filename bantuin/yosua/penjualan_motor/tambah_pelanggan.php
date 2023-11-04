<?php 
    require_once 'koneksi.php';
    if (!isset($_SESSION['id_user'])) {
        header("Location: login.php");
        exit;
    }
    if (isset($_POST['btnTambah'])) {
        $nama_pelanggan = $_POST['nama_pelanggan'];
        $no_telepon_pelanggan = $_POST['no_telepon_pelanggan'];
        $alamat_pelanggan = $_POST['alamat_pelanggan'];

        $tambah_pelanggan = mysqli_query($koneksi, "INSERT INTO pelanggan VALUES ('', '$nama_pelanggan', '$no_telepon_pelanggan', '$alamat_pelanggan')");

        if ($tambah_pelanggan) {
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
    <title>Tambah Pelanggan</title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <div class="container">
            <form method="post" class="form form-left">
                <h2>Tambah Pelanggan</h2>
                <label class="label" for="nama_pelanggan">Nama Pelanggan</label>
                <input type="text" class="input" id="nama_pelanggan" name="nama_pelanggan" required>

                <label class="label" for="no_telepon_pelanggan">No. Telepon Pelanggan</label>
                <input type="number" class="input" id="no_telepon_pelanggan" name="no_telepon_pelanggan" required>

                <label class="label" for="alamat_pelanggan">Alamat Pelanggan</label>
                <textarea class="input" id="alamat_pelanggan" name="alamat_pelanggan" required></textarea>

                <button type="submit" class="button align-right" name="btnTambah">Submit</button>
            </form>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
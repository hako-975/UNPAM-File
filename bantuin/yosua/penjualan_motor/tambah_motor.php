<?php 
    require_once 'koneksi.php';
    if (!isset($_SESSION['id_user'])) {
        header("Location: login.php");
        exit;
    }
    if (isset($_POST['btnTambah'])) {
        $nama = $_POST['nama'];
        $merk = $_POST['merk'];
        $tahun = $_POST['tahun'];
        $harga = $_POST['harga'];

        $tambah_motor = mysqli_query($koneksi, "INSERT INTO motor VALUES ('', '$nama', '$merk', '$tahun', '$harga')");

        if ($tambah_motor) {
            echo "
                <script>
                    alert('Motor berhasil ditambahkan!')
                    window.location.href='motor.php'
                </script>
            ";
            exit;
        } else {
            echo "
                <script>
                    alert('Motor gagal ditambahkan!')
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
    <title>Tambah Motor</title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <div class="container">
            <form method="post" class="form form-left">
                <h2>Tambah Motor</h2>
                <label class="label" for="nama">Nama Motor</label>
                <input type="text" class="input" id="nama" name="nama" required>

                <label class="label" for="merk">Merk</label>
                <input type="text" class="input" id="merk" name="merk" required>

                <label class="label" for="tahun">Tahun</label>
                <input type="number" class="input" id="tahun" name="tahun" required>

                <label class="label" for="harga">Harga</label>
                <input type="number" class="input" id="harga" name="harga" required>

                <button type="submit" class="button align-right" name="btnTambah">Submit</button>
            </form>
        </div>
    </div>

    <script src="script.js"></script>
</body>
</html>
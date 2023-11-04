<?php
    require_once 'koneksi.php';
    
    if (isset($_SESSION['id_user'])) {
        echo "
            <script>
                window.location='index.php'
            </script>
        ";
        exit;
    }

    if (isset($_POST['btnLogin'])) {
        $username = $_POST['username'];
        $password = $_POST['password'];

        $query_login = mysqli_query($koneksi, "SELECT * FROM user WHERE username = '$username'");
        
        if ($data_user = mysqli_fetch_assoc($query_login)) {
            if (password_verify($password, $data_user['password'])) {
                $_SESSION['id_user'] = $data_user['id_user'];
                header("Location: index.php");
                exit;
            } else {
                echo "
                    <script>
                        alert('Gagal Username atau Password salah!')
                        window.history.back()
                    </script>
                ";
                exit;
            }
        } else {
            echo "
                <script>
                    alert('Gagal Username atau Password salah!')
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
    <title>Login - Penjualan Motor</title>
</head>
<body>
    <?php include_once 'navbar.php'; ?>

    <div class="container anti-navbar">
        <form method="post" class="form">
            <img src="img/logo.png" alt="Logo">
            <h2 class="title">Form Login</h2>
            <label class="label" for="username">Username</label>
            <input class="input" type="text" id="username" name="username" required>

            <label class="label" for="password">Password</label>
            <input class="input" type="password" id="password" name="password" required>

            <button type="submit" class="button align-right" name="btnLogin">Login</button>
        </form>
    </div>

    <script src="script.js"></script>
</body>
</html>
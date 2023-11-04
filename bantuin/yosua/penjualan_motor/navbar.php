<navbar class="navbar navbar-fixed-top">
  <div class="navbar-container">
    <a class="navbar-title" href="index.php"><img src="img/logo-only.png"> <span>Penjualan Motor Manurung</span></a>
      <div class="navbar-nav">
        <?php if (isset($_SESSION['id_user'])): ?>
          <a class="button" href="penjualan.php">Penjualan</a>
          <a class="button" href="pelanggan.php">Pelanggan</a>
          <a class="button" href="motor.php">Motor</a>
          <a class="button" href="logout.php">Logout</a>
        <?php else: ?>
          <a class="button" href="login.php">Login</a>
        <?php endif ?>
      </div>
  </div>
</navbar>

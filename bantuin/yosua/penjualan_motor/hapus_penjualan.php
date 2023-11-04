<?php 
	require_once 'koneksi.php';

	if (!isset($_SESSION['id_user'])) {
		header("Location: login.php");
		exit;
	}


	$id_penjualan = $_GET['id_penjualan'];

	$hapus_penjualan = mysqli_query($koneksi, "DELETE FROM penjualan WHERE id_penjualan = '$id_penjualan'");

	if ($hapus_penjualan) {
		echo "
			<script>
				alert('Penjualan berhasil dihapus!')
				window.location.href='penjualan.php'
			</script>
		";
		exit;
	} else {
		echo "
			<script>
				alert('Penjualan gagal dihapus!')
				window.history.back()
			</script>
		";
		exit;
	}
?>
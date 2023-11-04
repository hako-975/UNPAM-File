<?php 
	require_once 'koneksi.php';

	if (!isset($_SESSION['id_user'])) {
		header("Location: login.php");
		exit;
	}


	$id_pelanggan = $_GET['id_pelanggan'];

	$hapus_pelanggan = mysqli_query($koneksi, "DELETE FROM pelanggan WHERE id_pelanggan = '$id_pelanggan'");

	if ($hapus_pelanggan) {
		echo "
			<script>
				alert('Pelanggan berhasil dihapus!')
				window.location.href='pelanggan.php'
			</script>
		";
		exit;
	} else {
		echo "
			<script>
				alert('Pelanggan gagal dihapus!')
				window.history.back()
			</script>
		";
		exit;
	}
?>
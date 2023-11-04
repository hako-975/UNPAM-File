<?php 
	require_once 'koneksi.php';

	if (!isset($_SESSION['id_user'])) {
		header("Location: login.php");
		exit;
	}


	$id_motor = $_GET['id_motor'];

	$hapus_motor = mysqli_query($koneksi, "DELETE FROM motor WHERE id_motor = '$id_motor'");

	if ($hapus_motor) {
		echo "
			<script>
				alert('Motor berhasil dihapus!')
				window.location.href='motor.php'
			</script>
		";
		exit;
	} else {
		echo "
			<script>
				alert('Motor gagal dihapus!')
				window.history.back()
			</script>
		";
		exit;
	}
?>
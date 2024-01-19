<?php
$conn = new mysqli("localhost", "root", "", "pegawai");
$name = $_POST["name"];
$data = mysqli_query($conn, "DELETE from users WHERE name='$name'");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}

?>
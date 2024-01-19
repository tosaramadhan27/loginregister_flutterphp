<?php
$conn = new mysqli("localhost", "root", "", "pegawai");
$name = $_POST["name"];
$email = $_POST["email"];
$password = $_POST["password"];
$data = mysqli_query($conn, "INSERT INTO users SET name='$name', email= '$email', password='$password'");
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
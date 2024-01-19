<?php
$conn = new mysqli("localhost", "root", "", "pegawai");
$id = $_POST["id"];
$name = $_POST["name"];
$email = $_POST["email"];
$password = $_POST["password"];
$data = mysqli_query($conn, "UPDATE users SET name='$name', email= '$email', password='$password' WHERE id='$id'");
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
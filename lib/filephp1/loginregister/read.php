<?php
$conn = new mysqli("localhost", "root", "", "pegawai");
$query = mysqli_query($conn, "SELECT * FROM users");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);



?>
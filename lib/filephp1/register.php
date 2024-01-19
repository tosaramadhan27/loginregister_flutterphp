<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Content-Type: application/json");

$servername = "localhost";
$username = "root";
$password = "";
$database = "pegawai";

$conn = new mysqli($servername, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $data = json_decode(file_get_contents("php://input"), true);

    $name = $data["name"];
    $email = $data["email"];
    $password = password_hash($data["password"], PASSWORD_DEFAULT);

    $sql = "INSERT INTO users (name, email, password) VALUES ('$name', '$email', '$password')";
    $result = $conn->query($sql);

    if ($result) {
        echo json_encode(["message" => "Registration successful"]);
    } else {
        echo json_encode(["message" => "Registration failed"]);
    }
}

$conn->close();
?>

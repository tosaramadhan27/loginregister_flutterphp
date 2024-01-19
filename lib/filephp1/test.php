<!-- <?php
$db = mysqli_connect ('localhost', 'root', '', 'pegawai');
if (!$db) {
    echo "Database connection failed";
}

$name = $_POST['name'];
$email = $_POST['email'];
$password = $_POST['password'];

$sql = "SELECT * FROM users WHERE name='$name' email='$email' AND password='$password'";

$result = mysqli_query ($db, $sql);
$count = mysqli_num_rows($result);

if ($count == 1) {
    echo json_encode("Error");
} else {
    $insert = "INSERT INTO users(name,email,password) VALUES(''$name',$email', $password )";
    $query = mysqli_query($db, $insert);
    if ($query) {
        echo json_encode("Success");
    }
}

?> -->

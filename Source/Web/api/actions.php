<?php
require_once 'config.php';
header('Access-Control-Allow-Origin: *');

$AuthDeviceID = '';
if (isset($_GET['id']))
	$AuthDeviceID = strtolower(trim(htmlspecialchars($_GET['id'])));

$conn = mysqli_connect($dbserver, $dbuser, $dbpassword, $dbname);

if (!$conn)
	die('auth:denied');

$result = mysqli_query($conn, "SHOW TABLES LIKE \"actions_$AuthDeviceID\"");
if (mysqli_num_rows($result) == 0) {
	mysqli_close($conn);
	die('auth:denied');
}

$result = mysqli_query($conn, "SELECT * FROM actions_$AuthDeviceID");

echo "<actions>\n";
if ($result && mysqli_num_rows($result) > 0) {
	for ($i=0; $i < mysqli_num_rows($result); $i++) {
		$action = $result->fetch_assoc();
		echo "\t" . '<' . $action['Action'] . ' id="' . $action['ID'] . '" datetime="' . $action['DateTime'] . '">' . $action['Note'] . '</' . $action['Action'] . '>' . "\n";
	}
}
echo '</actions>';

if ($conn)
	mysqli_close($conn);

?>
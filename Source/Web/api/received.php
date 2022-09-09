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

$result = mysqli_query($conn, "DELETE FROM actions_$AuthDeviceID");

if ($result)
	echo 'ok';
else
	echo 'access:denied';

if ($conn)
	mysqli_close($conn);

?>
<?php
require_once 'config.php';
header('Access-Control-Allow-Origin: *');

$AuthDeviceID = '';
if (isset($_GET['id']))
	$AuthDeviceID = strtolower(trim(htmlspecialchars($_GET['id'])));

$conn = mysqli_connect($dbserver, $dbuser, $dbpassword, $dbname);

if (!$conn)
	die('db error');

$result = mysqli_query($conn, "SHOW TABLES LIKE \"actions_$AuthDeviceID\"");
if (mysqli_num_rows($result) == 0 && $allowNewAuth == false) {
	mysqli_close($conn);
	die('auth:denied');
}

$result = mysqli_query($conn, "CREATE TABLE IF NOT EXISTS actions_$AuthDeviceID (Action TEXT, ID bigint, Note TEXT, DateTime bigint)");

if ($result)
	echo 'auth:ok';
else
	echo 'auth:denied';

if ($conn)
	mysqli_close($conn);
?>
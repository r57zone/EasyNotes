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

$result = mysqli_query($conn, "SHOW TABLES"); 
$AuthorizedDevices = array();
while ($row = mysqli_fetch_array($result))
	if ($row[0] != 'actions_' . $AuthDeviceID && $row[0] != 'notes')
		array_push($AuthorizedDevices, $row[0]);
	
$postdata = file_get_contents("php://input");
//$postdata = '<actions><insert id="1662457537" datetime="1662471937">x52</insert></actions>';
if ($postdata != '') {
	$xml = simplexml_load_string($postdata);
	foreach($xml->children() as $child) {
		if ($child->getName() == 'insert')
		  $result = mysqli_query($conn, "INSERT INTO notes (ID, Note, DateTime) VALUES (" . $child['id'] .", \"$child\", " . $child['datetime'] . ")");
		else if ($child->getName() == 'update')
		  $result = mysqli_query($conn, "UPDATE notes SET Note=\"$child\", DateTime=" . $child['datetime'] . " WHERE ID=" . $child['id']);
		else if ($child->getName() == 'delete')
		  $result = mysqli_query($conn, "DELETE FROM notes WHERE ID=" . $child['id']);
		foreach ($AuthorizedDevices as $DeviceDBName)
			if ($child->getName() != 'delete')
				$result = mysqli_query($conn, "INSERT INTO $DeviceDBName (Action, ID, Note, DateTime) VALUES (\"" . $child->getName() . "\", " . $child['id'] .", \"$child\", " . $child['datetime'] . ")");
			else
				$result = mysqli_query($conn, "INSERT INTO $DeviceDBName (Action, ID, Note, DateTime) VALUES (\"" . $child->getName() . "\", " . $child['id'] .", \"\", 0)");
	}

	if ($result)
		echo 'ok';
	else
		echo 'auth:denied';
}

// $fp = @fopen("sniff.txt", "a");
// @fputs($fp, "$postdata\n");
// @fputs($fp, "INSERT INTO $DeviceDBName (Action, ID, Note, DateTime) VALUES (\"" . $child->getName() . "\", " . $child['id'] .", \"\", " . $child['datetime'] . ")\n");
// @fclose($fp);

if ($conn)
	mysqli_close($conn);
?>
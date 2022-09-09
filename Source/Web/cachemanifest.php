<?php 
header('Content-type: text/cache-manifest'); 
echo file_get_contents(__DIR__ . '/app.manifest');
?>
<?php 
$source = file_get_contents(__DIR__ . '/main.html');
echo str_replace('<html data-theme="default" manifest="app.manifest">', '<html data-theme="default" manifest="cachemanifest.php">', $source);
?>
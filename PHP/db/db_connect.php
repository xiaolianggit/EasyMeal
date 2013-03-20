<?php require_once ('db_config.php'); ?>
<?php
	$connection = mysql_connect($dbhost, $dbusername, $dbpassword);
	mysql_query("SET NAMES 'utf8'");
	$db = mysql_select_db($dbname);
?>

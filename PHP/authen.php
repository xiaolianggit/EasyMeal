<?php
require_once 'db/db_connect.php';

$username = $_REQUEST['username'];
$passwordHash = sha1($_REQUEST['password']);
$result = mysql_query("SELECT * FROM admin_list WHERE password = '$passwordHash' AND username = '$username'");
if(mysql_num_rows($result)<1)
	echo "no";
else
	echo "yes";
mysql_close();
?>

<?php
require_once 'db/db_connect.php';
$result = mysql_query("SELECT recommended from restaurant_info");
//echo $recommended;
while ($row = mysql_fetch_array($result))
	$recommendedID = $row['recommended'];
$result = mysql_query("select name from menu_info WHERE id = '$recommendedID'");
while ($row = mysql_fetch_array($result))
	$recommendedName = $row['name'];

$result = mysql_query("SELECT id,name FROM menu_info WHERE id = (SELECT MAX(id) FROM menu_info)");
$row = mysql_fetch_array($result);
$latestID = $row['id'];
$latestName = $row['name'];
echo $recommendedID.",".$recommendedName.",".$latestID.",".$latestName;
mysql_close();
?>

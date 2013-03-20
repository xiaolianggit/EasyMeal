<?php
require_once 'db/db_connect.php';
$name = $_REQUEST['name'];
$intro = $_REQUEST['intro'];
$location = $_REQUEST['location'];
$phone = $_REQUEST['phone'];
$recommended = $_REQUEST['recommend'];

if($name)
	mysql_query ("UPDATE restaurant_info SET name = '$name'") or die (mysql_error ());
if($intro)
	mysql_query ("UPDATE restaurant_info SET intro = '$intro'") or die (mysql_error ());
if($phone)
	mysql_query ("UPDATE restaurant_info SET phone = '$phone'") or die (mysql_error ());
if($location)
	mysql_query ("UPDATE restaurant_info SET location = '$location'") or die (mysql_error ());
if($recommended)
	mysql_query ("UPDATE restaurant_info SET recommended = '$recommended'") or die(mysql_error ());

mysql_close();

?>

<?php
require_once 'db/db_connect.php';
$id = $_GET['id'];

mysql_query("DELETE FROM order_list WHERE id='$id'") or die(mysql_error());
mysql_query("DELETE FROM order_list_item WHERE orderID='$id'") or die(mysql_error());

mysql_close();
?>

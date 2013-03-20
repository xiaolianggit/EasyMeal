<?php
require_once 'db/db_connect.php';
$newStatus = $_REQUEST['status'];
$OrderID = $_REQUEST['orderID'];
echo $OrderID."</br>".$newStatus;
mysql_query("UPDATE order_list SET order_status = '$newStatus' WHERE id = '$OrderID'");

mysql_close();
?>
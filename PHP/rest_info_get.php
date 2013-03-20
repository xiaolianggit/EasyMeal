<?php
require_once 'db/db_connect.php';
$result = mysql_query("SELECT * FROM restaurant_info")
    or die();

$row = mysql_fetch_array( $result );
echo "<xml>";
echo "<name>";
echo $row['name'];
echo "</name><intro>";
echo $row['intro'];
echo "</intro><location>";
echo $row['location'];
echo "</location><phone>";
echo $row['phone'];
echo "</phone><picversion>";
echo $row['picversion'];
echo "</picversion></xml>";
mysql_close();

?>

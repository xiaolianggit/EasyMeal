<?php
require_once 'db/db_connect.php';
$name = $_REQUEST['name'];
$intro = $_REQUEST['intro'];
$price = $_REQUEST['price'];
$quantity = $_REQUEST['quantity'];
$kind = $_REQUEST['kind'];

mysql_query("INSERT INTO menu_info
        (name, intro, price, quantity,kind) VALUES('$name', '$intro', '$price', '$quantity','$kind' ) ")
        or die(mysql_error());


$result = mysql_query("SELECT id FROM menu_info WHERE name='$name'") or die();
/*$tempItemID=0;
while($row = mysql_fetch_array( $result )) {
    if($row['id'] > $tempItemID)
        $tempItemID = $row['id'];
}*/

echo mysql_insert_id();
mysql_close();
?>

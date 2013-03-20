<?php
require_once 'db/db_connect.php';
$result = mysql_query("SELECT * FROM menu_info")
    or die();

echo "<xml>";
// keeps getting the next row until there are no more to get
// Print out the contents of each row into a table
while($row = mysql_fetch_array( $result )) {
    echo "<item><id>";
    echo $row['id'];
    echo "</id><name>";
    echo $row['name'];
    echo "</name><intro>";
    echo $row['intro'];
    echo "</intro><price>";
    echo $row['price'];
    echo "</price><quantity>";
    echo $row['quantity'];
    echo "</quantity><kind>";
    echo $row['kind'];
    echo "</kind></item>";
}


echo "</xml>";

mysql_close();


?>

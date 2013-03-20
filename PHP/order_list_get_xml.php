<?php
require_once 'db/db_connect.php';
$orders = mysql_query("SELECT * FROM order_list") or die();
echo "<xml>";
while($row = mysql_fetch_array($orders)) {
	echo "<order>";
	echo "<orderID>";
	echo $row['id'];
	echo "</orderID><name>";
	echo $row['customer_name'];
	echo "</name><phone>";
	echo $row['customer_phone'];
	echo "</phone><address>";
	echo $row['delivery_address'];
	echo "</address><date>";
	echo $row['order_date'];
	echo "</date><comment>";
	echo $row['customer_comment'];
	echo "</comment><status>";
	echo $row['order_status'];
	echo "</status>";
	
	$OrderID = $row['id'];
	
	$orderItem = mysql_query("SELECT * FROM order_list_item WHERE orderID = '$OrderID'") or die();
	while($orderItemContent = mysql_fetch_array( $orderItem )) {
				// Print out the contents of each row into a table
		echo "<item>";
		echo "<itemID>";
		echo $orderItemContent['itemID'];
		echo "</itemID>";
		echo "<quantity>";
		echo $orderItemContent['quantity'];
		echo "</quantity>";
		echo "</item>";
	}
	
	echo "</order>";
}

echo "</xml>";
mysql_close();
?>

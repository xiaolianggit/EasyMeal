<?php
require_once 'db/db_connect.php';
	$result = mysql_query("SELECT * FROM order_list") or die();
	//table for order list
	echo "<table border='1'>";
	echo "<tr> <th>id</th><th>Name</th> <th>phone</th><th>address</th><th>udid</th><th>date</th><th>comment</th><th>order status</th></tr>";
	while($row = mysql_fetch_array( $result )) {
				// Print out the contents of each row into a table
		echo "<tr><td>";
		echo $row['id'];
		echo "</td><td>";
		echo $row['customer_name'];
		echo "</td><td>";
		echo $row['customer_phone'];
		echo "</td><td>";
		echo $row['delivery_address'];
		echo "</td><td>";
		echo $row['udid'];
		echo "</td><td>";
		echo $row['order_date'];
		echo "</td><td>";
		echo $row['customer_comment'];
		echo "</td><td>";
		echo $row['order_status'];
		echo "</td></tr>";
	}
	echo "</table></br></br>";





	//table for order list item
	echo "<table border='1'>";
	echo "<tr> <th>id</th><th>itemID</th> <th>quantity</th><th>orderID</th></tr>";
	$result = mysql_query("SELECT * FROM order_list_item") or die();
	while($row = mysql_fetch_array( $result )) {
				// Print out the contents of each row into a table
		echo "<tr><td>";
		echo $row['id'];
		echo "</td><td>";
		echo $row['itemID'];
		echo "</td><td>";
		echo $row['quantity'];
		echo "</td><td>";
		echo $row['orderID'];
		echo "</td><td>";
	}
	echo "</table>";

	mysql_close();
?>

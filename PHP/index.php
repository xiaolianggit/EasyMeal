<html>
<head>
<title>EIE FYP iPhone Application Development</title>
</br>
</head>
<body>
	<a href="menu_item_html_table.php">menu_item_html_table</a>
	</br>
	<a href="menu_item_delete.php">menu_item_delete</a>
	</br>
	<a href="testUploadHTML.php">test upload html</a>
	</br>
	<a href="order_list_add.php">order list add</a>
	</br>
	<a href="order_list_get_html.php">order list get</a>
</body>
</html>
<?php
require_once 'db/db_connect.php';
//restaurant information
echo "</br></br>restaurant information:</br>";
$result = mysql_query("SELECT * FROM restaurant_info")
or die();
$row = mysql_fetch_array( $result );?>
<table border='1'>
<tr> <th>id</th><th>Name</th> <th>phone</th><th>address</th><th>picversion</th><th>recommended</th></tr>
<?php
echo "<tr><td>";
echo $row['name'];
echo "</td><td>";
echo $row['intro'];
echo "</td><td>";
echo $row['phone'];
echo "</td><td>";
echo $row['location'];
echo "</td><td>";
echo $row['picversion'];
echo "</td><td>";
echo $row['recommended'];?>
</td></tr></table></br>

<!--menu information:-->
<?php
echo "menu information:</br>";
$result = mysql_query("SELECT * FROM menu_info")
or die(mysql_error());?>

<table border='1'>
<tr> <th>id</th><th>Name</th> <th>intro</th><th>price</th><th>quantity</th><th>kind</th> </tr>
<!-- keeps getting the next row until there are no more to get -->
<?php
while($row = mysql_fetch_array( $result )) {
	// Print out the contents of each row into a table
	echo "<tr><td>";
	echo $row['id'];
	echo "</td><td>";
	echo $row['name'];
	echo "</td><td>";
	echo $row['intro'];
	echo "</td><td>";
	echo $row['price'];
	echo "</td><td>";
	echo $row['quantity'];
	echo "</td><td>";
	echo getFoodKind($row['kind']);
	echo "</td></tr>";
}

echo "</table>";



//table for order list
echo "order list:</br>";
$result = mysql_query("SELECT * FROM order_list") or die();
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
echo "order list item:</br>";
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


function getFoodKind($kind){
	switch ($kind){
		case 0:
			return "main";
			break;
		case 1:
			return "drink";
			break;
		case 2:
			return "soup";
			break;
		case 3:
			return "dessert";
			break;
		case 4:
			return "other";
			break;
	}

	return "error";

}
?>
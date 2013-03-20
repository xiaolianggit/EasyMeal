<?php
require_once 'db/db_connect.php';
$customer_name = $_REQUEST['name'];
$customer_phone = $_REQUEST['phone'];
$delivery_address = $_REQUEST['address'];
$udid = $_REQUEST['udid'];
$comment = $_REQUEST['comment'];

mysql_query("INSERT INTO order_list (customer_name, customer_phone, delivery_address, udid,order_date,customer_comment,order_status) VALUES('$customer_name', '$customer_phone', '$delivery_address', '$udid',NOW(),'$comment','0') ") or die(mysql_error());

/*
$result = mysql_query("SELECT id FROM order_list WHERE udid='$udid'") or die();
$latest_order=0;

while($row = mysql_fetch_array($result)){
	if($row['id'] > $latest_order)
		$latest_order = $row['id'];
}
echo $latest_order;
*/
echo mysql_insert_id();

foreach ($_REQUEST as $key => $value) {
	if(startWith($key, "itemID")){
		$tempItemID = $value;
		$quantity = "quantity".substr($key, 6);
		mysql_query("INSERT INTO order_list_item (itemID,quantity,orderID)
			VALUES ('$value','$_REQUEST[$quantity]','$latest_order')") or die(mysql_error());
		}
}

function startWith($longerString,$shorterString){
	$length = strlen($shorterString);
	return (substr($longerString,0, $length) === $shorterString);

}

mysql_close();
?>

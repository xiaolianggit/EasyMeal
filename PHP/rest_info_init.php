<?php
require_once 'db/db_connect.php';
$name = $_GET['name'];
$intro = $_GET['intro'];
$location = $_GET['location'];
$phone = $_GET['phone'];
$recommended = $_GET['recommended'];
echo $name;
echo $intro;
echo $location;
echo $phone;

mysql_query("DROP TABLE restaurant_info");
mysql_query("CREATE TABLE restaurant_info(
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id),
	name VARCHAR(50),
	intro VARCHAR(200),
	location VARCHAR(300),
	phone INT,
	picversion DATETIME,
	recommended INT)");


mysql_query("INSERT INTO restaurant_info
        (name, intro, location, phone,recommended,picversion) VALUES('$name', '$intro', '$location', '$phone','$recommended',NOW() ) ")
        or die(mysql_error());
mysql_close();

?>

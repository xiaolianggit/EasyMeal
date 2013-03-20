<?php
require_once 'db/db_connect.php';
mysql_query("DROP TABLE restaurant_info");

mysql_query("CREATE TABLE restaurant_info(
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id),
	name VARCHAR(50),
	intro VARCHAR(300),
	location VARCHAR(300),
	phone INT,
	picversion DATETIME)") or die(mysql_error());

mysql_query("INSERT INTO restaurant_info (name,intro,location,phone,picversion) VALUES ('good tast restaurant','welcome to our restaurant','hong kong polytechnic university','77883344',NOW())") or die(mysql_error());

?>

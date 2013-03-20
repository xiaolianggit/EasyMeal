<?php
require_once 'db/db_connect.php';
$id = $_GET['id'];

mysql_query("DELETE FROM menu_info WHERE id='$id'") or die(mysql_error());

	$oldFile = "menuItemPic/".$id.".jpg";
	echo $oldFile."</br>";
    if (file_exists($oldFile)){
        unlink($oldFile);
		echo "file deleted";}

	else
		echo "file not found";


	mysql_close();
?>

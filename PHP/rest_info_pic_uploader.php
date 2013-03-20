<?php
require_once 'db/db_connect.php';

$oldFile = "restPicture/restPic.jpg";
//unlink($oldFile);

if (file_exists($oldFile)) {
	unlink($oldFile);
	echo "file replaced</br>";
}
else
	echo "file not exist</br>";
$target_path = "restPicture/";
$filename = basename($_FILES['uploadedfile']['name']);
$info = pathinfo($filename);
$target_path = $target_path."restPic.".$info['extension'];
if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path)){
	echo "The file".  basename($_FILES['uploadedfile']['name'])." has been uploaded";
	mysql_query ("UPDATE restaurant_info SET picversion = NOW()") or die (mysql_error ());
}
else
	echo "Error uploading the file";


?>

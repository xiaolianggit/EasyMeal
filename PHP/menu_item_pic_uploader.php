<?php
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
    $itemId = $_REQUEST['itemID'];
    $oldFile = 'menuItemPic/".$itemId.".jpg';
    if (file_exists($oldFile)) {
        unlink($oldFile);
        echo $itemId.",file replaced</br>";
    }
    else
        echo $itemId.",file not exist</br>";


    $target_path = "menuItemPic/";
    $filename = basename($_FILES['uploadedfile']['name']);
    $info = pathinfo($filename);
    $target_path = $target_path.$itemId.".".$info['extension'];
    if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path))
        echo "The file".  basename($_FILES['uploadedfile']['name'])." has been uploaded";
    else
        echo "Error uploading the file";
?>

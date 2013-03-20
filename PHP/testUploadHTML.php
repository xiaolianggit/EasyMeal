<form enctype="multipart/form-data" action="menu_item_pic_uploader.php" method="POST">
    Item ID: <input type="text" size="10" maxlength="40" name="itemID"></br>
    <input type="hidden" name="MAX_FILE_SIZE" value="1000000" />
    Choose a file to upload: <input name="uploadedfile" type="file" /><br />
    <input type="submit" value="Upload File" />
</form>
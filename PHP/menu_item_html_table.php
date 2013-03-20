<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
require_once 'db/db_connect.php';

    // Get all the data from the "example" table
    $result = mysql_query("SELECT * FROM menu_info")
    or die(mysql_error());

    echo "<table border='1'>";
    echo "<tr> <th>id</th><th>Name</th> <th>intro</th><th>price</th><th>quantity</th><th>kind</th> </tr>";
    // keeps getting the next row until there are no more to get
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
    
    
	
	mysql_close();
?>

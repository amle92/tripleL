<?php
	require_once("dbconnect.php");

	if(isset($_POST['type'])){
		$myfile = fopen("../DBProductLoader.txt", "r") or die("Unable to open file!");
		
		while($line = fgets($myfile)){
			$data = explode(", ",$line);

			$name = $data[0];
			$quantity = $data[1];
			$price = $data[2];
			$brand = $data[3];


			$query = "SELECT * FROM product WHERE name='$name' AND brand='$brand'";
			$result = mysqli_query($conn, $query) or die (mysql_error().$query);

			if (mysqli_num_rows($result) == 0){
				$query = "INSERT INTO product(name,quantity,price,brand,updatedAt) VALUES (\"$name\",'$quantity','$price','$brand',NOW())";
				$result = mysqli_query($conn,$query) or die(mysql_error().$query);
			}

		}
		fclose($myfile);
		echo "Successfully added products from DBProductLoader.txt!";

	}

?>
<?php
	require_once("dbconnect.php");

	if ($_POST){
		$productID = $_POST['productID'];
		$price = $_POST['price'];

		$query = "UPDATE product SET price=$price WHERE productID=$productID";
		$result = mysqli_query($conn,$query);

		if($result){
			echo "Price successfully changed to " . $price;
		}
	}

?>
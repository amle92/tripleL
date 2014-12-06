<?php
	require_once("dbconnect.php");

	if($_POST){
		$prodID = $_POST['productID'];
		$quantity = $_POST['quantity'];

		$query = "CALL ChangeStock($prodID,$quantity);";
		$result = mysqli_query($conn,$query) or die(mysql_error().$query);


		if ($result){
			echo "Quantity is now " . $quantity;
		}
	}
?>
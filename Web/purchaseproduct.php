<?php
	session_start();
	require_once("dbconnect.php");

	if($_POST){
		$productID = $_POST['productID'];
		$purchaseQuant = $_POST['quantity'];
		$customerID = $_SESSION['customerID'];

		$query = "SELECT * FROM product WHERE productID='$productID'";
		$result = mysqli_query($conn, $query) or die(mysql_error().$query);
		$data = mysqli_fetch_array($result);

		$name = $data['name'];
		$quantity = $data['quantity'];

		$query = "SELECT * FROM customer WHERE customerID='$customerID'";
		$result = mysqli_query($conn, $query);
		$data = mysqli_fetch_array($result);
		$card = $data['creditcard'];

		if (empty($card)) {
			echo 0;
		}
		else if ($purchaseQuant <= 0){
			echo -2;
		}
		else{
			if ($quantity < $purchaseQuant){
				echo -1;
			}
			else {
				$query = "CALL InsertPurchase($customerID,$productID,$purchaseQuant,'$card');";
				$result = mysqli_query($conn, $query) or die(mysql_error().$query);

				$query = "CALL SetUpdatedAt($productID);";
				$result = mysqli_query($conn, $query) or die(mysql_error().$query);

				echo 1;
			}
		}

		


	}
?>
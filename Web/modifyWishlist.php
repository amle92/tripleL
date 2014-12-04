<?php
	session_start();
	require_once("config.php");

	if($_POST){
		$productID = $_POST['productID'];
		$customerID = $_SESSION['customerID'];
		$action = $_POST['action'];


		if ($action == "add"){
			$query = "SELECT * FROM wishlist WHERE customerID='$customerID' AND productID='$productID'";
			$result = mysqli_query($conn, $query) or die(mysql_error().$query);

			if (mysqli_num_rows($result) > 0){

			}
			else {
				$query = "CALL addToWishlist('$customerID','$productID')";
				$result = mysqli_query($conn, $query) or die(mysql_error().$query);
			}
		}
		else if ($action == "remove") {
			$query = "DELETE FROM wishlist WHERE productID='$productID' AND customerID='$customerID'";
			$result = mysqli_query($conn, $query) or die(mysql_error().$query);
		}
		
	}
	else {
		print ("Error");
	}

?>
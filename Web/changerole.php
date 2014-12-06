<?php
	require_once("dbconnect.php");

	if ($_POST){
		$customerID = $_POST['customerID'];
		$role = $_POST['role'];

		$query = "UPDATE users SET role='$role' WHERE customerID=$customerID";
		$result = mysqli_query($conn,$query) or die(mysql_error().$query);

		if($result){
			echo "Successfully changed role";
		}
	}
?>
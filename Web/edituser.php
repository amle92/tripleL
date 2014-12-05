<?php
	session_start();
	require_once("dbconnect.php");

	$customerID = $_SESSION['customerID'];
	$query = "SELECT * FROM customer WHERE customerID='$_SESSION[customerID]'";
	$result = mysqli_query($conn, $query);
	$data = mysqli_fetch_array($result);

	$name = $data['name'];
	$address = $data['address'];
	$phone = $data['phone'];
	$creditcard = $data['creditcard'];

	if ($_POST) {
		$address = $_POST['address'];
		$phone = $_POST['phone'];
		$creditcard = $_POST['creditcard'];

		$query = "UPDATE customer SET address='$address', phone='$phone', creditcard='$creditcard' WHERE customerID='$customerID'";
		$result = mysqli_query($conn, $query);

		if ($result){
			header('Location: userpage.php');
		}
	}
	

	function printUserForm(){
		global $name,$address,$phone,$creditcard;
		echo "
			<form action='edituser.php' method='post'>
				<div>
					<label for='name'>Name: </label> $name
				</div>
				<br>
				<div>
					<label for='address'>Address: </label>
					<input type='text' name='address' placeholder='Address' value='$address' required>
				<div>
				<br>
				<div>
					<label for='phone'>Phone Number: </label>
					<input type='text' name='phone' placeholder='(800)800-8080' value='$phone' pattern='[(][0-9]{3}[)][0-9]{3}[-][0-9]{4}' required>
				<div>
				<br>
				<div>
					<label for='creditcard'>Credit Card Number: </label>
					<input type='text' name='creditcard' placeholder='1234567812345678' value='$creditcard' pattern='[0-9]{16}' required>
				</div>
				<input type='submit' name='edit' value='submit'>

			</form>
		";
	}
?>

<!DOCTYPE html>
<html>

	<head>
		<?php require_once('config.php'); ?>
	</head>

	<body>
		<?php require_once('navbar.php'); ?>
		<h3>Edit Your Information:</h3>
		<?php printUserForm(); ?>
	</body>

</html>
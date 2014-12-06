<?php
	session_start();
	require_once("dbconnect.php");

	$custID = $_SESSION["customerID"];

	function printPurchases() {
		global $custID,$conn;

		$query = "CALL GetPurchases($custID);";
		$result = mysqli_query($conn,$query);

		if (mysqli_num_rows($result) == 0){
			echo "<h3>No purchases made.</h3>";
		}

		else {
			echo "<h3>Your purchases</h3>";
		
			echo "
			<table border='2'>
				<thead>
					<tr>
						<th>Name</th>
						<th>Quantity Bought</th>
						<th>Card Used</th>
						<th>Purchase Date</th>
					</tr>
				</thead>
		";

		while ($data = mysqli_fetch_array($result)) {
			$card = $data['creditcard'];
			$card = substr($card,-4);
			$card = "XXXXXXXXXXXX".$card;

			echo "<tr>";

			echo "<td>" . $data['name'] . "</td>";
			echo "<td>" . $data['buyquantity'] . "</td>";
			echo "<td>" . $card . "</td>";
			echo "<td>" . $data['datetime'] . "</td>";


			echo "</tr>";
		}

		echo "</table>";

		}
		

	}
?>

<!DOCTYPE html>
<html>
	<head>
		<?php require_once("config.php"); ?>
	</head>

	<body>
		<?php 
			require_once("navbar.php"); 
			printPurchases();
		?>
	</body>
</html>
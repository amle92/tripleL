<?php
	session_start();
	require_once("dbconnect.php");

	$query = "SELECT * FROM product";
	$result = mysqli_query($conn, $query);
?>

<!DOCTYPE html>
<html>

<head>
</head>

<body>
	<?php require_once("navbar.php"); ?>
	<h3>List of all products</h3>
	
	<?php
		echo "
			<table border='2'>
				<thead>
					<tr>
						<th>Product Name</th>
						<th>Brand</th>
						<th>Quantity</th>
						<th>Price</th>
					</tr>
				</thead>
		";

		while($data = mysqli_fetch_array($result)) {
			$productID = $data['productID'];
			$name = $data['name'];
			$brand = $data['brand'];
			$quantity = $data['quantity'];
			$price = $data['price'];

			echo "<tr><td>" . $name . "</td>";
			echo "<td>" . $brand . "</td>";
			echo "<td>" . $quantity . "</td>";
			echo "<td>$" . $price . "</td></tr>";
		}

		echo "</table>";
	?>

</body>

</html>
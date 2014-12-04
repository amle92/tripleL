<?php
	session_start();
	require_once("config.php");

	$customerID = $_SESSION['customerID'];

	$query = "CALL getWishlistedItems('$customerID');";
	$result = mysqli_query($conn, $query) or die(mysql_error().$query);

	function printWishlist(){
		global $result;

		if(mysqli_num_rows($result) > 0) {
			echo "<table border='2'>
				<thead>
					<tr>
						<th>Product Name</th>
						<th>Brand</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Action</th>
					</tr>";

			while ($data = mysqli_fetch_array($result)) {
				$productID = $data['productID'];
				$name = $data['name'];
				$brand = $data['brand'];
				$quantity = $data['quantity'];
				$price = $data['price'];

				echo "<tr>";

				echo "<td>" . $name . "</td>";
				echo "<td>" . $brand . "</td>";
				echo "<td>" . $quantity . "</td>";
				echo "<td>" . $price . "</td>";
				echo "<td><button type='button' onclick='removeFromWishlist($productID)' class='removeFromWishlist'>Remove from Wishlist</button></td>";

				echo "</tr>";
			}

			echo "</table>";

		}
		else {
			print "<h3>No Wishlisted Items.<h3>";
		}

	}
?>

<script>
	function removeFromWishlist(prodID){
		var cusID = '@Session["customerID"]';
		$.post("modifyWishlist.php",{action:"remove",customerID:cusID,productID:prodID},function(){
			alert("Item successfully deleted from wishlist");
			location.reload();
		});
	}
</script>

<!DOCTYPE html>
<html>

	<head>
	</head>

	<body>
		<?php require_once("navbar.php"); ?>
		Your wishlist: <br>
		<?php printWishlist(); ?>

	</body>

</html>
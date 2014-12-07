<?php
	require_once("dbconnect.php");

	$name = "";
	$quantity = "";
	$price = "";
	$brand = "";

	if($_POST)
	{
		$name = $_POST['name'];
		$quantity = $_POST['quantity'];
		$price = $_POST['price'];
		$brand = $_POST['brand'];

		$query = "SELECT * FROM product WHERE name='$name' AND brand='$brand'";
		$result = mysqli_query($conn, $query) or die (mysql_error().$query);

		if (mysqli_num_rows($result) > 0){
			print "$name by $brand is already added.";

		}
		else{
			$query = "INSERT INTO product(name,quantity,price,brand,updatedAt) VALUES ('$name','$quantity','$price','$brand',NOW())";
			$result = mysqli_query($conn,$query) or die(mysql_error().$query);

			print("Successfully added $name by $brand");

			$name = "";
			$quantity = "";
			$price = "";
			$brand = "";
		}
	}

	function addproductform(){
		global $name,$quantity,$price,$brand;
		echo "
			<form action='addproduct.php' method='post'>
				<div>
					<label for='name'>Name: </label>
					<input type='text' name='name' placeholder='Umbrella' value='$name' required>
				</div>
				<br>
				<div>
					<label for='quantity'>Quantity: </label>
					<input type='number' name='quantity' placeholder='5' value='$quantity' min='0' required>
				</div>
				<br>
				<div>
					<label for='price'>Price: </label>
					<input type='text' name='price' placeholder='9.99' value='$price' pattern='[0-9]{1}[.][0-9]{2}' required>
				</div>
				<br>
				<div>
					<label for='brand'>Brand: </label>
					<input type='text' name='brand' placeholder='Johnson & Johnson' value='$brand' required>
				</div>

				<input type='submit' value='Add Product' name='submit'>
			</form>
		";
	}
?>

<!DOCTYPE html>
<html>

<head>
	<?php require_once("config.php"); ?>

	<script>
		function addproduct(){
			if(window.confirm("Are you sure you want to add the products?")){
				$.post("addbulk.php",{type:"bulk"},function(data){
					alert(data);
				});
			}
		}
	</script>

</head>

<body>
	<?php require_once("navbar.php"); ?>
	<h3>Add products from file</h3>
	<button type='button' class='addproduct' onclick='addproduct()'>Add Products</button>

	<h3>Add a Product Manually</h3>
	<?php addproductform(); ?>
</body>

</html>
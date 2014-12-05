<?php
	session_start();
	require_once("dbconnect.php");

	$query = "SELECT * FROM product";
	$result = mysqli_query($conn, $query);
?>

<script>
	function addToWishlist(id) {
		$.post("modifyWishlist.php", {productID:id,action:"add"},function(){
			alert("Item added to wishlist");
		});
	}

	function purchase(prodID,name) {
		var quant = "a";

		while (isNaN(quant)) {
			quant = prompt("How many would you like to purchase?");

			if (isNaN(quant)) {
				alert("Please enter a number.");
			}
			else if(quant == null){
				quant = 0;
			}
		}

		var confirm = window.confirm("Are you sure you want to buy " + quant + " " + name + "?");

		if (confirm) {
			$.post("purchaseproduct.php",{productID:prodID,quantity:quant},function(data){
				//alert(data);
				if(data == -1){
					alert("We do not have enough stock for your purchase. Please try again.");
				}
				else if(data == -2){
					alert("Please enter a positive whole number greater than 0.");
				}
				else if(data == 0){
					alert("Please enter your credit card information first (Edit Info).");
				}
				else if(data == 1){
					alert("You purchased "+ quant + " " + name);
					location.reload();
				}
			});
		}
	}
	
</script>

<!DOCTYPE html>
<html>

	<head>
		<?php require_once("config.php"); ?>
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
							<th>Price</th>";

			if (isset($_SESSION['username'])) {
				echo "
					<th>Actions</th>
				";
			}

			echo "
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
				echo "<td>$" . $price . "</td>";

				if(isset($_SESSION['role'])){
					echo "<td>";
					if ($_SESSION['role'] == 'A'){
						echo "<button type='button' onclick='addStock($productID)' class='addStock'>Add Stock</button>";
						echo "<button type='button' onclick='changePrice($productID)' class='changePrice'>Change Price</button>";
					}
					else{
						echo "<button type='button' onclick='purchase($productID,\"$name\")' class='purchase'>Purchase</button>";
						echo "<button type='button' onclick='addToWishlist($productID)' class='addToWishlist'>Add to Wishlist</button>";
					}


					echo "</td>";
				}
				echo "</tr>";
			}

			echo "</table>";
		?>

	</body>

</html>
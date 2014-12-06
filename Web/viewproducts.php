<?php
	session_start();
	require_once("dbconnect.php");

	$query = "SELECT * FROM product";
	$result = mysqli_query($conn, $query);
?>

<!DOCTYPE html>
<html>
	<head>
		<?php require_once("config.php"); ?>

		<script>
			function addToWishlist(id) {
				$.post("modifyWishlist.php", {productID:id,action:"add"},function(){
					alert("Item added to wishlist");
				});
			}

			function changeStock(prodID,name) {
				var quant = "a";

				while (isNaN(quant) || quant < 0) {
					quant = prompt("How many " + name + " are there?");

					if (isNaN(quant)) {
						alert("Please enter a number.");
					}
					else if(quant < 0){
						alert("Please enter a positive whole number (or 0).");
					}
					else if(quant == null){
						quant = 0;
					}
				}

				var confirm = window.confirm("Change stock of " + name + " to " + quant + "?");

				if (confirm){
					$.post('changestock.php',{productID:prodID,quantity:quant},function(data){
						alert(data);
						location.reload();
					});
				}

			}

			function changePrice(prodID,name) {
				var price = prompt("Enter the new price of " + name + " (without $)");
				var format = new RegExp('[0-9]+.[0-9]{2}');

				while (!format.test(price)) {
					alert("Please enter a valid price (e.g. 9.99)");
					price = prompt("Enter the new price " + name +" (without $)");
				}

				if (window.confirm("Change the price of " + name + " to " + price + "?")) {
					$.post('changeprice.php',{productID:prodID,price:price},function(data){
						alert(data);
						location.reload();
					});
				}

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
				if ($_SESSION['role'] == 'M' || $_SESSION['role'] == 'A') {
					echo "
						<th>Updated At</th>
					";
				}

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
				$updatedAt = $data['updatedAt'];

				echo "<tr><td>" . $name . "</td>";
				echo "<td>" . $brand . "</td>";
				echo "<td>" . $quantity . "</td>";
				echo "<td>$" . $price . "</td>";

				if(isset($_SESSION['role'])){
					if ($_SESSION['role'] == 'A' || $_SESSION['role'] == 'M'){
						echo "<td>" . $updatedAt . "</td>";

						echo "<td>";
						echo "<button type='button' onclick='changeStock($productID,\"$name\")' class='changeStock'>Change Stock</button>";
						echo "<button type='button' onclick='changePrice($productID,\"$name\")' class='changePrice'>Change Price</button>";
						echo "</td>";
					}
					else{
						echo "<td>";
						echo "<button type='button' onclick='purchase($productID,\"$name\")' class='purchase'>Purchase</button>";
						echo "<button type='button' onclick='addToWishlist($productID)' class='addToWishlist'>Add to Wishlist</button>";
						echo "<td>";
					}
				}
				echo "</tr>";
			}

			echo "</table>";
		?>

	</body>

</html>
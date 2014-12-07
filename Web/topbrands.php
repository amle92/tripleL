<?php
	session_start();
	require_once("dbconnect.php");

	$customerID = $_SESSION['customerID'];

	$query = "CALL BrandsWithAtLeast(500);";
	$result = mysqli_query($conn, $query) or die(mysql_error().$query);

	function printWishlist(){
		global $result;

		if(mysqli_num_rows($result) > 0) {
			echo "<table border='2'>
				<thead>
					<tr>
						<th>Brand</th>
						<th>Total Value</th>
					</tr>
				</thead>";

			while ($data = mysqli_fetch_array($result)) {
				$brand = $data['brand'];
				$total = $data['total'];

				echo "<tr>";

				echo "<td>" . $brand . "</td>";
				echo "<td>" . $total . "</td>";

				echo "</tr>";
			}

			echo "</table>";

		}
		else {
			print "<h3>No Items.<h3>";
		}

	}
?>


<!DOCTYPE html>
<html>

	<head>
		<script>
			function purchase(prodID,name) {
				var quant = "a";

				while (isNaN(quant)) {
					quant = prompt("How many would you like to purchase?",0);

					if (isNaN(quant)) {
						alert("Please enter a number.");
					}
					else if(quant == null){
						quant = 0;
					}
					else
					{
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
									/*
									confirm = window.confirm("Do you want to keep " + name + " on your wishlist?");
									
									if (!confirm){
										removeFromWishlist(prodID);
									}
									*/
									location.reload();
								}
							});
						}
					}
				}
			}

			function addToWishlist(id) {
				$.post("modifyWishlist.php", {productID:id,action:"add"},function(){
					alert("Item added to wishlist");
				});
			}
		</script>

		<?php require_once("config.php"); ?>
	</head>

	<body>
		<?php require_once("navbar.php"); ?>
		<h3>Expensive Brands: </h3>
		<?php printWishlist(); ?>

	</body>

</html>
<?php
	session_start();
	require_once("dbconnect.php");

	$myRole = $_SESSION['role'];

	function printusers(){
		global $conn,$myRole;

		echo "
			<table border='2'>
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Username</th>
						<th>Phone</th>
						<th>Last Purchase</th>
						<th>Action</th>
					</tr>
				</thead>
		";

		$query = "CALL GetUserInfo();";
		$result = mysqli_query($conn,$query);

		while($data = mysqli_fetch_array($result)){
			$custID = $data['customerID'];
			$name = $data['name'];
			$username = $data['username'];
			$phone = $data['phone'];
			$lastpurchase = $data['lastpurchase'];
			$role = $data['role'];

			echo "<tr>";

			echo "<td>" . $custID . "</td>";
			echo "<td>" . $name . "</td>";
			echo "<td>" . $username . "</td>";
			echo "<td>" . $phone . "</td>";
			echo "<td>" . $lastpurchase . "</td>";

			echo "<td>";

			if ($role == 'U') {
				echo "<button type='button' class='makeadmin' onclick='changerole($custID,\"A\")'>Make Admin</button>";
			}
			if ($role == 'A') {
				if ($myRole == 'M') {
					echo "<button type='button' class='makeuser' onclick='changerole($custID,\"U\")'>Make User</button>";
				}
			}


			echo "</td></tr>";
		}

	}
?>

<!DOCTYPE html>
<html>
	<head>
		<?php require_once("config.php"); ?>

		<script>
			function changerole(custID,role){
				var confirm;

				if (role == "A") {
					confirm = window.confirm("Make this user an Admin?");
				}
				else {
					confirm = window.confirm("Make this Admin a user?");
				}

				if(confirm){
					$.post("changerole.php",{customerID:custID,role:role},function(data){
						alert(data);
						location.reload();
					});
				}

			}
		</script>

	</head>

	<body>
		<?php 
			require_once("navbar.php"); 
			printusers();
		?>

	</body>
</html>
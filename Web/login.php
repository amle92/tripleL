<?php
	require_once("dbconnect.php");
	$username = "";
	$password = "";

	if($_POST) {
		$username = $_POST['username'];
		$password = $_POST['password'];

		$query = "SELECT * FROM users WHERE username='$username'";
		$result = mysqli_query($conn,$query);
		$data = mysqli_fetch_array($result);
		$passcheck = $data['password'];

		if (mysqli_num_rows($result) === 0){
			print "Username does not exist!<br>";
		}
		if (strcmp($password,$passcheck) === 0){
			session_start();
			$customerID = $data['customerID'];
			$_SESSION['username'] = $username;
			$_SESSION['customerID'] = $customerID;
			header('Location: userpage.php');
		}
		else {
			print "Incorrect Password.";
		}
	}

	
?>


<html>

	<head>
	</head>

	<body>
		<?php require_once("navbar.php"); ?>

		<form action='login.php' method='post'>
			<div>
				<label for='username'>Username: </label>
				<input type='text' name='username' placeholder='Username' value='<?php echo "$username"; ?>' pattern='{4,}' title='4 characters minimum' required>
			</div>
			<br>
			<div>
				<label for='password'>Password: </label>
				<input type='password' name='password' placeholder='Password' required>
			</div>
			<input type='submit' name='submit' value='Login'>
		</form>

	</body>

</html>
<?php
	require_once('dbconnect.php');

	$error = false;
	$name = "";
	$username = "";

	if ($_POST) {
		$name = $_POST["name"];
		$username = $_POST["username"];
		$password = $_POST["password"];
		$confirm_pass = $_POST["confirm_pass"];

		$query = "SELECT * FROM users WHERE username='$username'";
		$results = mysqli_query($conn, $query) or die(mysql_error().$query);
		$results = mysql_fetch_array($results);

		if (mysql_num_rows($results) > 0) {
			print 'Username is already taken<br>';
			$error = true;
		}

		if(strcmp($password, $confirm_pass) != 0){
			print 'Passwords did not match<br>';
			$error = true;
		}

		//Check for 6 characters
		if(strlen($password) < 6 || strlen($password) > 20){
			print "Password must be 6 to 20 characters.<br>";
			$error = true;
		}

		if (!$error) {
			$query = "INSERT into customer(name) values ('$name')";
			mysqli_query($conn, $query);

			$query = "SELECT * FROM customer WHERE name='$name'";
			$results = mysqli_query($conn, $query);
			$data = mysql_fetch_array($results);
			$id = $data['customerID'];

			$query = "INSERT into users(customerID,username,password,role) values ('$id','$username','$password','U')";
			$data = mysqli_query($conn, $query);

			print "You have successfully been registered<br>";
			print $data;
		}
	}

	function printForm($name,$username) {
		echo "
			<form action='register.php' method='post'>
				<div>
					<label for='name'>Name: </label>
					<input type='text' name='name' placeholder='Tester McTest' value='$name' required>
				</div>
				<br>
				<div>
					<label for='username'>Username: </label>
					<input type='text' name='username' placeholder='Username' value='$username' pattern='.{4,}'' title='4 characters minimum' required>
				</div>
				<br>
				<div>
					<label for='password'>Password: </label>
					<input type='password' name='password' placeholder='Password' required>
				</div>
				<br>
				<div>
					<label for='confirm_pass'>Confirm Password: </label>
					<input type='password' name='confirm_pass' placeholder='Confirm password' required>
				</div>
				<input type='submit' name='submit' value='Register'>
			</form>
		";
	}

?>

<html>
<head>

</head>

<body>
	<h3>New User Registration:</h3>
	<?php printForm($name,$username); ?>


</body>

</html>
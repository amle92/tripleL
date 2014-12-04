<?php
	$sessionId = session_id();
	if(empty($sessionId)) session_start();

	if (isset($_SESSION['username'])) {
		if ($_SESSION['role'] == 'U') {
			loggedInUser();
		}
		else {
			loggedInAdmin();
		}
	}
	else {
		notLoggedIn();
	}

	function notLoggedIn() {
		echo "
			<h2>
				<a href='login.php'>Login</a>
				 | 
				<a href='register.php'>Register</a>
				 | 
				<a href='viewproducts.php'>View Products</a>
			</h2>
		";
	}

	function loggedInAdmin() {
		echo "
			<h2>
				<a href='viewproducts.php'>View Products</a>
				 | 
				<a href=''>View Users</a>
				 | 
				<a href='addproduct.php'>Add Product</a>
				 | 
				<a href='logout.php'>Logout</a>
			</h2>
		";
	}

	function loggedInUser() {
		echo "
			<h2>
				<a href='userpage.php'>User Homepage</a>
				 | 
				<a href='viewproducts.php'>View Products</a>
				 | 
				<a href='edituser.php'>Edit Info</a>
				 | 
				<a href='logout.php'>Logout</a>
			</h2>
		";
	}


?>
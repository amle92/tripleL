<?php
	//Create a database named cs157aproject
	$servername = "localhost";
	$username = "root";
	$password = "";
	$dbname = "cs157aproject";

	// Create connection
	$conn = new mysqli($servername, $username, $password, $dbname);
	// Check connection
	if ($conn->connect_error) {
	    die("Connection failed: " . $conn->connect_error);
	}

?>
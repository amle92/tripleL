<?php
	session_start();
	unset($_SESSION['username']);
	unset($_SESSION['customerID']);
	session_unset();
	session_destroy();
	header('Location: login.php');
?>
<?php
	session_start();
	
	// DATABASE CONSTANTS
	define(__DBHOST__, "localhost");
	define(__DBUSERNAME__, "-");
	define(__DBPASSWORD__, "-");
	define(__DBNAME__, "-");
	define(__IDENTIFIER_LENGTH__, 7);
	
	// DB CONNECTION
	$mysqli = new MySQLi(__DBHOST__, __DBUSERNAME__, __DBPASSWORD__, __DBNAME__);
	if($mysqli->error) {
		die('Application error! Please try again later! (Error_D10001)');
	}
	$mysqli->query("SET NAMES 'UTF8'");
?>
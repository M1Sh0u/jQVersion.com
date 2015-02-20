<?php
	require_once("config.php");
	
	function generateIdentifier($identifier = NULL, $fork = false, $identifierLength = __IDENTIFIER_LENGTH__) {
		global $mysqli;
		
		if (!empty($identifier) && !$fork) {
			preg_match('/(?:\!\/)?([a-zA-Z0-9]{' . __IDENTIFIER_LENGTH__ . '})(?:\/([0-9]*))?/', $identifier, $matches);
			if (!isset($matches[1])) {
				return generateIdentifier();
			}
			if (isset($matches[2])) {
				$result = $matches[1] . '/' . ($matches[2] + 1);
			} else {
				$result = $matches[1] . '/1';
			}
		} else {
			$charactersToBeUsed = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
			$characters = str_split($charactersToBeUsed);
			shuffle($characters);
			$result = array();
			for ($i = 0; $i < $identifierLength; $i++) {
				$randomKey = rand(0, count($characters) - 1);
				$result[] = $characters[$randomKey];
			}
			shuffle($result);
			$result = implode('', $result);
		}
		
		// ensure there is no database entry with this identifier
		$stmt = $mysqli->query("SELECT test_identifier FROM tests WHERE test_identifier='" . $result . "'");
		if ($stmt->num_rows === 0) {
			return $result;
		}
		return generateIdentifier($result, $fork, $identifierLength);
	}
	
?>
<?php
	require_once("functions.php");
	
	if (!isset($_SESSION['verified']) || $_SESSION['verified'] != 'jQV3rs10n') {
		die('Access denied!');
	}
	
	$identifier = $_POST['identifier'];
	
	preg_match('/(?:\/#\!\/)?([a-zA-Z0-9]{' . __IDENTIFIER_LENGTH__ . '})(?:\/([0-9]*))?/', $identifier, $matches);
	if (empty($matches)) {
		echo json_encode(array(
			'error' => 'Incorrect identifier provided.',
		));
		exit;
	}
	
	$identifier = $matches[1];
	if (isset($matches[2])) {
		$identifier .= '/' . $matches[2];
	}
	
	$stmt = $mysqli->prepare('SELECT test_id, test_identifier, test_working_version_id, test_events, test_actions, test_versions_ids, test_autorun, test_html, test_css, test_js
							  FROM tests
							  WHERE test_identifier=?');
	$stmt->bind_param('s', $identifier);
	$stmt->execute();
	$stmt->store_result();
	
	if ($stmt->num_rows == 0) {
		echo json_encode(array(
			'error' => 'Test not found! The tests are automatically deleted after 3 months if there is no visit.',
		));
	} else {
		$stmt->bind_result($id, $identifier, $workingVersion, $eventsToBeListened, $actions, $versionsIds, $autorun, $html, $css, $js);
		$stmt->fetch();
		
		$mysqli->query("INSERT INTO test_last_action (test_id) VALUES (" . $id . ") ON DUPLICATE KEY UPDATE test_last_action = NOW()");
		
		echo json_encode(array(
			'identifier'         => $identifier,
			'workingVersion'     => $workingVersion,
			'eventsToBeListened' => $eventsToBeListened,
			'actions'            => $actions,
			'versionsIds'        => $versionsIds,
			'autorun'            => $autorun,
			'html'               => stripslashes($html),
			'css'                => stripslashes($css),
			'js'                 => stripslashes($js),
			'error'              => NULL,
		));
	}
	
	$stmt->free_result();
	$stmt->close();
?>
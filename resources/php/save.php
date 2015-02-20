<?php
	require_once('functions.php');
	
	if (!isset($_SESSION['verified']) || $_SESSION['verified'] != 'jQV3rs10n') {
		die('Access denied!');
	}
	
	$js                 = $_POST['js'];
	$css                = $_POST['css'];
	$html               = $_POST['html'];
	$workingVersionId   = $_POST['workingVersion'];
	$eventsToBeListened = $_POST['eventsToBeListened'];
	$versionsToBeTested = isset($_POST['versionsToBeTested']) && is_array($_POST['versionsToBeTested'])
						? implode(',', $_POST['versionsToBeTested'])
						: NULL;
	$actions            = $_POST['actions'];
	$autorun            = $_POST['autorun'] ? 1 : 0;
	$identifier         = generateIdentifier($_POST['identifier'], (bool) $_POST['fork']);
	
	$stmt = $mysqli->prepare("INSERT INTO tests
					 		 	(test_identifier, test_working_version_id, test_events, test_actions, test_versions_ids, test_autorun, test_html, test_css, test_js)
					  		  VALUES
					  			(?, ?, ?, ?, ?, ?, ?, ?, ?)");
	
	$stmt->bind_param('sisssisss', $identifier, $workingVersionId, $eventsToBeListened, $actions, $versionsToBeTested, $autorun, $html, $css, $js);
	$stmt->execute();
	$stmt->close();
	
	echo json_encode(array(
		'identifier' => $identifier,
		'error' 	 => NULL,
	));
?>
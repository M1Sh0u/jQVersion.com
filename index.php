<?php
	include("resources/php/functions.php");
	
	$_SESSION['verified'] = 'jQV3rs10n';
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Test javascript in multiple versions of jQuery | jqversion.com</title>
    <meta name="description" content="Test any javascript code on multiple jQuery versions at once. Share your tests to others to see the results." />
    <meta name="keywords" content="javascript test, jquery test, multiple jquery tests, jquery versions, jquery tester, online jquery, jquery online test" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link type="text/css" rel="stylesheet" media="all" href="/resources/css/reset.css" />
    <link type="text/css" rel="stylesheet" media="all" href="/resources/plugins/codemirror-3.21/lib/codemirror.css" />
    <link type="text/css" rel="stylesheet" media="all" href="/resources/plugins/codemirror-3.21/theme/eclipse.css" />
    <link type="text/css" rel="stylesheet" media="all" href="/resources/css/jquery.qtip.min.css" />
    <link type="text/css" rel="stylesheet" media="all" href="/resources/css/style.css?v=1.0.0" />
	<script src="/resources/plugins/codemirror-3.21/lib/codemirror.js"></script>
    <script src="/resources/plugins/codemirror-3.21/mode/javascript/javascript.js"></script>
    <script src="/resources/plugins/codemirror-3.21/mode/xml/xml.js"></script>
    <script src="/resources/plugins/codemirror-3.21/mode/css/css.js"></script>
    <script src="/resources/plugins/codemirror-3.21/mode/htmlmixed/htmlmixed.js"></script>
    <script src="/resources/plugins/codemirror-3.21/keymap/extra.js"></script>
    <script src="/resources/plugins/codemirror-3.21/addon/selection/active-line.js"></script>
    <script src="/resources/plugins/codemirror-3.21/addon/edit/matchbrackets.js"></script>
    <script src="/resources/plugins/codemirror-3.21/addon/edit/closetag.js"></script>
    <script src="/resources/js/jquery.2.1.0.js"></script>
    <script src="/resources/js/jquery.getPath.js"></script>
    <script src="/resources/js/jquery.qtip.min.js"></script>
    <script src="/resources/js/jquery.address.js?autoUpdate=1&crawling=1&history=1&state=&strict=1&wrap=1"></script>
    <script src="/resources/js/jqversion.js?v=1.0.0"></script>
</head>

<body>
	<div id="page-wrapper">
    	<div id="header">
        	<div id="logo">
            	<a href="/"><img src="/resources/images/logo.png" /></a>
            </div>
            <div id="menu">
            	<a href="#run" id="run"><span class="ui-icon ui-icon-play"></span>Run</a>
            	<a href="#save" id="save" data-fork="0"><span class="ui-icon ui-icon-disk"></span>Save</a>
            	<a href="#fork" id="fork"><span class="ui-icon ui-icon-copy"></span>Fork</a>
            	<a href="#share" id="share"><span class="ui-icon ui-icon-link"></span>Share<span class="ui-icon ui-icon-triangle-1-s"></span></a>
                <div id="share-menu">
                	<label for="test-link">Share the test link:</label>
                    <input type="text" id="test-link" value="http://jqversion.com/" />
                </div>
            </div>
            <div id="main-loader">
            	<img src="/resources/images/ajax-loader-white.gif" />
            </div>
        </div>
        <div id="page-container">
            <div class="sidebar left-sidebar">
                <div class="left-sidebar-box">
                	<span class="title">Working jQuery version:</span>
                    <select id="working-jquery-version">
						<?php
							$cachedVersions = array();
                            $sql = $mysqli->query("SELECT version_id,
												  		  version_name,
														  version_uncompressed_package,
														  version_compressed_package
												   FROM versions");
							$i = 0;
                            while($row = $sql->fetch_assoc()) {
								$i++;
                                
								$filename = basename($row['version_compressed_package']);
								if (!file_exists('jquery/' . $filename)) {
									continue;
								}
								
								echo '
                    	<option value="' . $row['version_id'] . '"'; 
								if ($i === $sql->num_rows) {
									echo ' selected="selected"';
								}
								echo ' data-version-jquery-source="/jquery/' . $filename . '">' . $row['version_name'] . '</option>';
								
								// cache the jquery version to be used later without making a new db request
								$cachedVersions[$row['version_id']] = array(
									'version_name' => $row['version_name'],
									'version_filename' => $filename,
								);
                            }
                        ?>
                    </select>
                </div>
                <div class="left-sidebar-box">
                	<span class="title">Events to be listened:</span>
                    <input type="text" id="events-to-be-listened" value="click dblclick mousedown mouseenter mouseleave keydown keyup" />
                </div>
                <div class="left-sidebar-box">
                    <label class="centered-input"><input type="checkbox" id="autorun" checked="checked" /> Enable auto run when loading</label>
                </div>
                <div class="left-sidebar-ads">
                </div>
            </div>
            <div id="code-container">
                <div id="html-js-boxes">
                    <div id="html-box" class="box">
                        <span class="box-hint">HTML</span>
                        <textarea name="html-code" id="html-editor"></textarea>
                    </div>
                    <div id="js-box" class="box">
                        <span class="box-hint">JavaScript/jQuery</span><textarea name="js-code" id="js-editor"></textarea>
                    </div>
                </div>
                <div id="css-result-boxes">
                    <div id="css-box" class="box">
                        <span class="box-hint">CSS</span>
                        <textarea name="css-code" id="css-editor"></textarea>
                    </div>
                    <div id="result-box" class="box">
                        <span class="box-hint result-box-hint"><span class="result"></span> Result/Action</span>
                    </div>
                    <textarea name="actions" id="actions"></textarea>
                </div>
            </div>
            <div class="sidebar right-sidebar">
                <div id="versions">
                    <ul>
                    <?php
                        foreach ($cachedVersions as $versionId => $versionDetails) {
                                echo '
                        <li id="container-version-' . $versionId . '" data-version-id="' . $versionId . '" data-version-name="' . $versionDetails['version_name'] . '" data-version-jquery-source="/jquery/' . $versionDetails['version_filename'] . '">
                            <label class="centered-input"><input type="checkbox" name="run-version[]" value="' . $versionId . '" />' . $versionDetails['version_name'] . '</label>
                            <span class="result"></span>
                        </li>';
                        }
                    ?>
                    </ul>
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div id="footer">
        	<p>Copyright &copy;2014-<?php echo date('Y'); ?> - JQ.VER.SION | <a href="#" id="feedback">Help or Feedback</a> | <a href="https://jqversion.uservoice.com/knowledgebase" target="_blank">Knowledge Base</a></p>
            <script type="text/javascript">
				// Include the UserVoice JavaScript SDK (only needed once on a page)
				UserVoice=window.UserVoice||[];(function(){var uv=document.createElement('script');uv.type='text/javascript';uv.async=true;uv.src='//widget.uservoice.com/yu6MKFylUQoEOsd12yzQ.js';var s=document.getElementsByTagName('script')[0];s.parentNode.insertBefore(uv,s)})();
				
				// Set colors
				UserVoice.push(['set', {
				  accent_color: '#448dd6',
				  trigger_color: 'white',
				  trigger_background_color: '#448dd6'
				}]);
				
				// Or, use your own custom trigger:
				UserVoice.push(['addTrigger', '#feedback', { mode: 'contact' }]);
				
				// Autoprompt for Satisfaction and SmartVote (only displayed under certain conditions)
				UserVoice.push(['autoprompt', {}]);
			</script> 
        </div>
    </div>
    <div id="qtip-growl-container"></div>
</body>
</html>
--
-- TABLE STRUCTURE `tests`
--

CREATE TABLE IF NOT EXISTS `tests` (
  `test_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `test_identifier` varchar(255) NOT NULL,
  `test_working_version_id` int(11) NOT NULL,
  `test_events` varchar(255) NOT NULL,
  `test_actions` longtext,
  `test_versions_ids` varchar(255) DEFAULT NULL,
  `test_autorun` tinyint(4) NOT NULL,
  `test_html` longtext,
  `test_css` longtext,
  `test_js` longtext,
  `test_added_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`test_id`),
  UNIQUE KEY `test_identifier` (`test_identifier`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- TABLE STRUCTURE `test_last_action`
--

CREATE TABLE IF NOT EXISTS `test_last_action` (
  `test_id` bigint(20) NOT NULL,
  `test_last_action` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `test_id` (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- TABLE STRUCTURE `versions`
--

CREATE TABLE IF NOT EXISTS `versions` (
  `version_id` int(11) NOT NULL AUTO_INCREMENT,
  `version_name` varchar(255) NOT NULL,
  `version_uncompressed_package` varchar(255) NOT NULL,
  `version_compressed_package` varchar(255) NOT NULL,
  PRIMARY KEY (`version_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- TABLE ENTRIES `versions`
--

INSERT INTO `versions` (`version_id`, `version_name`, `version_uncompressed_package`, `version_compressed_package`) VALUES
(1, 'jQuery Core 1.0.0', 'http://code.jquery.com/jquery-1.0.js', 'http://code.jquery.com/jquery-1.0.pack.js'),
(2, 'jQuery Core 1.0.1', 'http://code.jquery.com/jquery-1.0.1.js', 'http://code.jquery.com/jquery-1.0.1.pack.js'),
(3, 'jQuery Core 1.0.2', 'http://code.jquery.com/jquery-1.0.2.js', 'http://code.jquery.com/jquery-1.0.2.pack.js'),
(4, 'jQuery Core 1.0.3', 'http://code.jquery.com/jquery-1.0.3.js', 'http://code.jquery.com/jquery-1.0.3.pack.js'),
(5, 'jQuery Core 1.0.4', 'http://code.jquery.com/jquery-1.0.4.js', 'http://code.jquery.com/jquery-1.0.4.pack.js'),
(6, 'jQuery Core 1.1.0-a', 'http://code.jquery.com/jquery-1.1a.js', 'http://code.jquery.com/jquery-1.1a.pack.js'),
(7, 'jQuery Core 1.1.0-b', 'http://code.jquery.com/jquery-1.1b.js', 'http://code.jquery.com/jquery-1.1b.pack.js'),
(8, 'jQuery Core 1.1.0', 'http://code.jquery.com/jquery-1.1.js', 'http://code.jquery.com/jquery-1.1.pack.js'),
(9, 'jQuery Core 1.1.1', 'http://code.jquery.com/jquery-1.1.1.js', 'http://code.jquery.com/jquery-1.1.1.pack.js'),
(10, 'jQuery Core 1.1.2', 'http://code.jquery.com/jquery-1.1.2.js', 'http://code.jquery.com/jquery-1.1.2.pack.js'),
(11, 'jQuery Core 1.1.3-a', 'http://code.jquery.com/jquery-1.1.3a.js', 'http://code.jquery.com'),
(12, 'jQuery Core 1.1.3', 'http://code.jquery.com/jquery-1.1.3.js', 'http://code.jquery.com/jquery-1.1.3.pack.js'),
(13, 'jQuery Core 1.1.4', 'http://code.jquery.com/jquery-1.1.4.js', 'http://code.jquery.com/jquery-1.1.4.pack.js'),
(14, 'jQuery Core 1.2.0', 'http://code.jquery.com/jquery-1.2.js', 'http://code.jquery.com/jquery-1.2.min.js'),
(15, 'jQuery Core 1.2.1', 'http://code.jquery.com/jquery-1.2.1.js', 'http://code.jquery.com/jquery-1.2.1.min.js'),
(16, 'jQuery Core 1.2.2-b', 'http://code.jquery.com/jquery-1.2.2b.js', 'http://code.jquery.com/jquery-1.2.2b.min.js'),
(17, 'jQuery Core 1.2.2-b2', 'http://code.jquery.com/jquery-1.2.2b2.js', 'http://code.jquery.com/jquery-1.2.2b2.min.js'),
(18, 'jQuery Core 1.2.2', 'http://code.jquery.com/jquery-1.2.2.js', 'http://code.jquery.com/jquery-1.2.2.min.js'),
(19, 'jQuery Core 1.2.3-a', 'http://code.jquery.com/jquery-1.2.3a.js', 'http://code.jquery.com/jquery-1.2.3a.min.js'),
(20, 'jQuery Core 1.2.3-b', 'http://code.jquery.com/jquery-1.2.3b.js', 'http://code.jquery.com/jquery-1.2.3b.min.js'),
(21, 'jQuery Core 1.2.3', 'http://code.jquery.com/jquery-1.2.3.js', 'http://code.jquery.com/jquery-1.2.3.min.js'),
(22, 'jQuery Core 1.2.4-a', 'http://code.jquery.com/jquery-1.2.4a.js', 'http://code.jquery.com/jquery-1.2.4a.min.js'),
(23, 'jQuery Core 1.2.4-b', 'http://code.jquery.com/jquery-1.2.4b.js', 'http://code.jquery.com/jquery-1.2.4b.min.js'),
(24, 'jQuery Core 1.2.4', 'http://code.jquery.com/jquery-1.2.4.js', 'http://code.jquery.com/jquery-1.2.4.min.js'),
(25, 'jQuery Core 1.2.5', 'http://code.jquery.com/jquery-1.2.5.js', 'http://code.jquery.com/jquery-1.2.5.min.js'),
(26, 'jQuery Core 1.2.6', 'http://code.jquery.com/jquery-1.2.6.js', 'http://code.jquery.com/jquery-1.2.6.min.js'),
(27, 'jQuery Core 1.3.0-b1', 'http://code.jquery.com/jquery-1.3b1.js', 'http://code.jquery.com/jquery-1.3b1.min.js'),
(28, 'jQuery Core 1.3.0-b2', 'http://code.jquery.com/jquery-1.3b2.js', 'http://code.jquery.com/jquery-1.3b2.min.js'),
(29, 'jQuery Core 1.3.0-rc1', 'http://code.jquery.com/jquery-1.3rc1.js', 'http://code.jquery.com/jquery-1.3rc1.min.js'),
(30, 'jQuery Core 1.3.0-rc2', 'http://code.jquery.com/jquery-1.3rc2.js', 'http://code.jquery.com/jquery-1.3rc2.min.js'),
(31, 'jQuery Core 1.3.0', 'http://code.jquery.com/jquery-1.3.js', 'http://code.jquery.com/jquery-1.3.min.js'),
(32, 'jQuery Core 1.3.1-rc1', 'http://code.jquery.com/jquery-1.3.1rc1.js', 'http://code.jquery.com/jquery-1.3.1rc1.min.js'),
(33, 'jQuery Core 1.3.1', 'http://code.jquery.com/jquery-1.3.1.js', 'http://code.jquery.com/jquery-1.3.1.min.js'),
(34, 'jQuery Core 1.3.2', 'http://code.jquery.com/jquery-1.3.2.js', 'http://code.jquery.com/jquery-1.3.2.min.js'),
(35, 'jQuery Core 1.4.0-a1', 'http://code.jquery.com/jquery-1.4a1.js', 'http://code.jquery.com/jquery-1.4a1.min.js'),
(36, 'jQuery Core 1.4.0-a2', 'http://code.jquery.com/jquery-1.4a2.js', 'http://code.jquery.com/jquery-1.4a2.min.js'),
(37, 'jQuery Core 1.4.0-rc1', 'http://code.jquery.com/jquery-1.4rc1.js', 'http://code.jquery.com/jquery-1.4rc1.min.js'),
(38, 'jQuery Core 1.4.0', 'http://code.jquery.com/jquery-1.4.js', 'http://code.jquery.com/jquery-1.4.min.js'),
(39, 'jQuery Core 1.4.1', 'http://code.jquery.com/jquery-1.4.1.js', 'http://code.jquery.com/jquery-1.4.1.min.js'),
(40, 'jQuery Core 1.4.2', 'http://code.jquery.com/jquery-1.4.2.js', 'http://code.jquery.com/jquery-1.4.2.min.js'),
(41, 'jQuery Core 1.4.3-rc1', 'http://code.jquery.com/jquery-1.4.3rc1.js', 'http://code.jquery.com/jquery-1.4.3rc1.min.js'),
(42, 'jQuery Core 1.4.3-rc2', 'http://code.jquery.com/jquery-1.4.3rc2.js', 'http://code.jquery.com/jquery-1.4.3rc2.min.js'),
(43, 'jQuery Core 1.4.3', 'http://code.jquery.com/jquery-1.4.3.js', 'http://code.jquery.com/jquery-1.4.3.min.js'),
(44, 'jQuery Core 1.4.4-rc1', 'http://code.jquery.com/jquery-1.4.4rc1.js', 'http://code.jquery.com/jquery-1.4.4rc1.min.js'),
(45, 'jQuery Core 1.4.4-rc2', 'http://code.jquery.com/jquery-1.4.4rc2.js', 'http://code.jquery.com/jquery-1.4.4rc2.min.js'),
(46, 'jQuery Core 1.4.4-rc3', 'http://code.jquery.com/jquery-1.4.4rc3.js', 'http://code.jquery.com/jquery-1.4.4rc3.min.js'),
(47, 'jQuery Core 1.4.4', 'http://code.jquery.com/jquery-1.4.4.js', 'http://code.jquery.com/jquery-1.4.4.min.js'),
(48, 'jQuery Core 1.5.0-b1', 'http://code.jquery.com/jquery-1.5b1.js', 'http://code.jquery.com/jquery-1.5b1.min.js'),
(49, 'jQuery Core 1.5.0-rc1', 'http://code.jquery.com/jquery-1.5rc1.js', 'http://code.jquery.com/jquery-1.5rc1.min.js'),
(50, 'jQuery Core 1.5.0', 'http://code.jquery.com/jquery-1.5.js', 'http://code.jquery.com/jquery-1.5.min.js'),
(51, 'jQuery Core 1.5.1-rc1', 'http://code.jquery.com/jquery-1.5.1rc1.js', 'http://code.jquery.com/jquery-1.5.1rc1.min.js'),
(52, 'jQuery Core 1.5.1', 'http://code.jquery.com/jquery-1.5.1.js', 'http://code.jquery.com/jquery-1.5.1.min.js'),
(53, 'jQuery Core 1.5.2-rc1', 'http://code.jquery.com/jquery-1.5.2rc1.js', 'http://code.jquery.com/jquery-1.5.2rc1.min.js'),
(54, 'jQuery Core 1.5.2', 'http://code.jquery.com/jquery-1.5.2.js', 'http://code.jquery.com/jquery-1.5.2.min.js'),
(55, 'jQuery Core 1.6.0-b1', 'http://code.jquery.com/jquery-1.6b1.js', 'http://code.jquery.com/jquery-1.6b1.min.js'),
(56, 'jQuery Core 1.6.0-rc1', 'http://code.jquery.com/jquery-1.6rc1.js', 'http://code.jquery.com/jquery-1.6rc1.min.js'),
(57, 'jQuery Core 1.6.0', 'http://code.jquery.com/jquery-1.6.js', 'http://code.jquery.com/jquery-1.6.min.js'),
(58, 'jQuery Core 1.6.1-rc1', 'http://code.jquery.com/jquery-1.6.1rc1.js', 'http://code.jquery.com/jquery-1.6.1rc1.min.js'),
(59, 'jQuery Core 1.6.1', 'http://code.jquery.com/jquery-1.6.1.js', 'http://code.jquery.com/jquery-1.6.1.min.js'),
(60, 'jQuery Core 1.6.2-rc1', 'http://code.jquery.com/jquery-1.6.2rc1.js', 'http://code.jquery.com/jquery-1.6.2rc1.min.js'),
(61, 'jQuery Core 1.6.2', 'http://code.jquery.com/jquery-1.6.2.js', 'http://code.jquery.com/jquery-1.6.2.min.js'),
(62, 'jQuery Core 1.6.3-rc1', 'http://code.jquery.com/jquery-1.6.3rc1.js', 'http://code.jquery.com/jquery-1.6.3rc1.min.js'),
(63, 'jQuery Core 1.6.3', 'http://code.jquery.com/jquery-1.6.3.js', 'http://code.jquery.com/jquery-1.6.3.min.js'),
(64, 'jQuery Core 1.6.4-rc1', 'http://code.jquery.com/jquery-1.6.4rc1.js', 'http://code.jquery.com/jquery-1.6.4rc1.min.js'),
(65, 'jQuery Core 1.6.4', 'http://code.jquery.com/jquery-1.6.4.js', 'http://code.jquery.com/jquery-1.6.4.min.js'),
(66, 'jQuery Core 1.7.0-b1', 'http://code.jquery.com/jquery-1.7b1.js', 'http://code.jquery.com/jquery-1.7b1.min.js'),
(67, 'jQuery Core 1.7.0-b2', 'http://code.jquery.com/jquery-1.7b2.js', 'http://code.jquery.com/jquery-1.7b2.min.js'),
(68, 'jQuery Core 1.7.0-rc1', 'http://code.jquery.com/jquery-1.7rc1.js', 'http://code.jquery.com/jquery-1.7rc1.min.js'),
(69, 'jQuery Core 1.7.0-rc2', 'http://code.jquery.com/jquery-1.7rc2.js', 'http://code.jquery.com/jquery-1.7rc2.min.js'),
(70, 'jQuery Core 1.7.0', 'http://code.jquery.com/jquery-1.7.js', 'http://code.jquery.com/jquery-1.7.min.js'),
(71, 'jQuery Core 1.7.0', 'http://code.jquery.com/jquery-1.7.0.js', 'http://code.jquery.com/jquery-1.7.0.min.js'),
(72, 'jQuery Core 1.7.1-rc1', 'http://code.jquery.com/jquery-1.7.1rc1.js', 'http://code.jquery.com/jquery-1.7.1rc1.min.js'),
(73, 'jQuery Core 1.7.1', 'http://code.jquery.com/jquery-1.7.1.js', 'http://code.jquery.com/jquery-1.7.1.min.js'),
(74, 'jQuery Core 1.7.2-b1', 'http://code.jquery.com/jquery-1.7.2b1.js', 'http://code.jquery.com/jquery-1.7.2b1.min.js'),
(75, 'jQuery Core 1.7.2-rc1', 'http://code.jquery.com/jquery-1.7.2rc1.js', 'http://code.jquery.com/jquery-1.7.2rc1.min.js'),
(76, 'jQuery Core 1.7.2', 'http://code.jquery.com/jquery-1.7.2.js', 'http://code.jquery.com/jquery-1.7.2.min.js'),
(77, 'jQuery Core 1.8.0-b1', 'http://code.jquery.com/jquery-1.8b1.js', 'http://code.jquery.com'),
(78, 'jQuery Core 1.8.0-b2', 'http://code.jquery.com/jquery-1.8b2.js', 'http://code.jquery.com/jquery-1.8b2.min.js'),
(79, 'jQuery Core 1.8.0-rc1', 'http://code.jquery.com/jquery-1.8rc1.js', 'http://code.jquery.com/jquery-1.8rc1.min.js'),
(80, 'jQuery Core 1.8.0', 'http://code.jquery.com/jquery-1.8.0.js', 'http://code.jquery.com/jquery-1.8.0.min.js'),
(81, 'jQuery Core 1.8.1', 'http://code.jquery.com/jquery-1.8.1.js', 'http://code.jquery.com/jquery-1.8.1.min.js'),
(82, 'jQuery Core 1.8.2', 'http://code.jquery.com/jquery-1.8.2.js', 'http://code.jquery.com/jquery-1.8.2.min.js'),
(83, 'jQuery Core 1.8.3', 'http://code.jquery.com/jquery-1.8.3.js', 'http://code.jquery.com/jquery-1.8.3.min.js'),
(84, 'jQuery Core 1.9.0-b1', 'http://code.jquery.com/jquery-1.9.0b1.js', 'http://code.jquery.com/jquery-1.9.0b1.min.js'),
(85, 'jQuery Core 1.9.0-rc1', 'http://code.jquery.com/jquery-1.9.0rc1.js', 'http://code.jquery.com/jquery-1.9.0rc1.min.js'),
(86, 'jQuery Core 1.9.0', 'http://code.jquery.com/jquery-1.9.0.js', 'http://code.jquery.com/jquery-1.9.0.min.js'),
(87, 'jQuery Core 1.9.1', 'http://code.jquery.com/jquery-1.9.1.js', 'http://code.jquery.com/jquery-1.9.1.min.js'),
(88, 'jQuery Core 1.10.0-beta1', 'http://code.jquery.com/jquery-1.10.0-beta1.js', 'http://code.jquery.com/jquery-1.10.0-beta1.min.js'),
(89, 'jQuery Core 1.10.0', 'http://code.jquery.com/jquery-1.10.0.js', 'http://code.jquery.com/jquery-1.10.0.min.js'),
(90, 'jQuery Core 1.10.1', 'http://code.jquery.com/jquery-1.10.1.js', 'http://code.jquery.com/jquery-1.10.1.min.js'),
(91, 'jQuery Core 1.10.2', 'http://code.jquery.com/jquery-1.10.2.js', 'http://code.jquery.com/jquery-1.10.2.min.js'),
(92, 'jQuery Core 1.11.0-beta1', 'http://code.jquery.com/jquery-1.11.0-beta1.js', 'http://code.jquery.com/jquery-1.11.0-beta1.min.js'),
(93, 'jQuery Core 1.11.0-beta2', 'http://code.jquery.com/jquery-1.11.0-beta2.js', 'http://code.jquery.com/jquery-1.11.0-beta2.min.js'),
(94, 'jQuery Core 1.11.0-beta3', 'http://code.jquery.com/jquery-1.11.0-beta3.js', 'http://code.jquery.com/jquery-1.11.0-beta3.min.js'),
(95, 'jQuery Core 1.11.0-rc1', 'http://code.jquery.com/jquery-1.11.0-rc1.js', 'http://code.jquery.com/jquery-1.11.0-rc1.min.js'),
(96, 'jQuery Core 1.11.0', 'http://code.jquery.com/jquery-1.11.0.js', 'http://code.jquery.com/jquery-1.11.0.min.js'),
(97, 'jQuery Core 2.0.0-b1', 'http://code.jquery.com/jquery-2.0.0b1.js', 'http://code.jquery.com/jquery-2.0.0b1.min.js'),
(98, 'jQuery Core 2.0.0-b2', 'http://code.jquery.com/jquery-2.0.0b2.js', 'http://code.jquery.com/jquery-2.0.0b2.min.js'),
(99, 'jQuery Core 2.0.0-beta3', 'http://code.jquery.com/jquery-2.0.0-beta3.js', 'http://code.jquery.com/jquery-2.0.0-beta3.min.js'),
(100, 'jQuery Core 2.0.0', 'http://code.jquery.com/jquery-2.0.0.js', 'http://code.jquery.com/jquery-2.0.0.min.js'),
(101, 'jQuery Core 2.0.1', 'http://code.jquery.com/jquery-2.0.1.js', 'http://code.jquery.com/jquery-2.0.1.min.js'),
(102, 'jQuery Core 2.0.2', 'http://code.jquery.com/jquery-2.0.2.js', 'http://code.jquery.com/jquery-2.0.2.min.js'),
(103, 'jQuery Core 2.0.3', 'http://code.jquery.com/jquery-2.0.3.js', 'http://code.jquery.com/jquery-2.0.3.min.js'),
(104, 'jQuery Core 2.1.0-beta1', 'http://code.jquery.com/jquery-2.1.0-beta1.js', 'http://code.jquery.com/jquery-2.1.0-beta1.min.js'),
(105, 'jQuery Core 2.1.0-beta2', 'http://code.jquery.com/jquery-2.1.0-beta2.js', 'http://code.jquery.com/jquery-2.1.0-beta2.min.js'),
(106, 'jQuery Core 2.1.0-beta3', 'http://code.jquery.com/jquery-2.1.0-beta3.js', 'http://code.jquery.com/jquery-2.1.0-beta3.min.js'),
(107, 'jQuery Core 2.1.0-rc1', 'http://code.jquery.com/jquery-2.1.0-rc1.js', 'http://code.jquery.com/jquery-2.1.0-rc1.min.js'),
(108, 'jQuery Core 2.1.0', 'http://code.jquery.com/jquery-2.1.0.js', 'http://code.jquery.com/jquery-2.1.0.min.js');
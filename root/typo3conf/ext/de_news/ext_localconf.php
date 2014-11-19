<?php
if (!defined('TYPO3_MODE')) {
	die('Access denied.');
}

\TYPO3\CMS\Extbase\Utility\ExtensionUtility::configurePlugin(
	'MyNewsExtension.' . $_EXTKEY,
	'Dedisplaynews',
	array(
		'Article' => 'list, show, json',
		
		
	),
	// non-cacheable actions
	array(
		'Article' => '',
		
	)
);

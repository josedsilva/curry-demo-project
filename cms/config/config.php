<?php
return array (
  'curry' => 
  array (
    'name' => 'Curry CMS',
    'adminEmail' => 'webmaster@domain.com',
    'forceDomain' => false,
    'statistics' => false,
    'applicationClass' => 'Project_Application',
    'migrationVersion' => 1,
    'updateTranslationStrings' => true,
    'developmentMode' => true,
    'setup' => false,
    'maintenance' => 
    array (
      'enabled' => false,
      'page' => NULL,
      'message' => 'Rebuilding database, please wait...',
    ),
    'cache' => 
    array (
      'method' => 'none',
    ),
    'log' => 
    array (
      'method' => 'none',
    ),
    'propel' => 
    array (
      'logging' => false,
      'debug' => false,
    ),
    'template' => 
    array (
    ),
    'backend' => 
    array (
      'noauth' => false,
    ),
    'errorPage' => 
    array (
      'notFound' => NULL,
      'accessDenied' => NULL,
      'error' => NULL,
      'unauthorized' => NULL,
    ),
    'divertOutMailToAdmin' => false,
    'revisioning' => false,
    'autoPublish' => false,
    'autoUpdateIndex' => '0',
    'liveEdit' => true,
    'errorNotification' => false,
  ),
);

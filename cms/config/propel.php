<?php
// This file generated by Propel 1.6.9 convert-conf target
// from XML runtime conf file /var/www/html/currydemo/cms/config/propel.xml
$conf = array (
  'datasources' => 
  array (
    'curry' => 
    array (
      'adapter' => 'mysql',
      'connection' => 
      array (
        'dsn' => 'mysql:host=localhost;dbname=curry_demo',
        'user' => 'curry',
        'password' => 'dummy',
        'settings' => 
        array (
          'charset' => 
          array (
            'value' => 'utf8',
          ),
        ),
      ),
    ),
    'default' => 'curry',
  ),
  'generator_version' => '1.6.9',
);
$conf['classmap'] = include(dirname(__FILE__) . DIRECTORY_SEPARATOR . 'propel-classmap.php');
return $conf;
<?php
$aliases['drupal'] = array (
  'uri' => 'drupal',
  'root' => '/var/www/html/',
  'remote-user' => 'nagios',
  'remote-host' => 'drupal',
  'path-aliases' =>
  array (
    '%drush' => '/home/nagios/.composer/vendor/drush/drush',
    '%site' => 'sites/default/'
  )
);

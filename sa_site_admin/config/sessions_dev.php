<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$config['sess_mode'] = 'memcached';
$config['sess_memcached'] = $_SERVER['MEMCACHED_ENDPOINT'];
$config['sess_adm_mode'] = 'memcached';
$config['sess_adm_memcached'] = $_SERVER['MEMCACHED_ENDPOINT'];

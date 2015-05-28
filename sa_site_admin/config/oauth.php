<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$config['providers'] = array(
    'google' => array(
        'clientId'      => $_SERVER['GOOGLE_CLIENTID'],
        'clientSecret'  => $_SERVER['GOOGLE_CLIENTSECRET'],
        'redirectUri'   => base_url('login/google/end'),
        'scopes'        => array(
            'profile',
            'email'
        )
    ),
    'facebook' =>  array(
        'clientId'      => $_SERVER['FACEBOOK_CLIENTID'],
        'clientSecret'  => $_SERVER['FACEBOOK_CLIENTSECRET'],
        'redirectUri'   => base_url('login/facebook/end')
    )
);

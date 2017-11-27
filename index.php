<?php
/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 15.6.17
 * Time: 15:29
 */
mb_internal_encoding("UTF-8");
function autoload($class){
    if(preg_match('/Controller$/',$class)){
        require ("Controllers/" . $class . ".php");
    } else{
        require ("Models/" . $class . ".php");
    }
}
session_start();
spl_autoload_register("autoload");
$db = new Database();
$db->connect('127.0.0.1','root','root','konference');
$smerovac = new RouterController();
$smerovac->login();
$smerovac->logout();
$smerovac->process(array($_SERVER['REQUEST_URI']));
$smerovac->printView();

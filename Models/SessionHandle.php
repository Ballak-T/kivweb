<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 27.6.17
 * Time: 14:51
 */
class SessionHandle{

    public static function start(){
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }
    }
    public static function createSessions($content){
        self::start();
        $sessions = array();
        foreach ($content as $key => $value){
            $newSession = $_SESSION[$key]=$value;
            $sessions[$key] = $newSession;
            }
        return $sessions;
    }
    public static function unsetSessions($content){
        foreach ($content as $value){
            unset($_SESSION[$value]);
        }
    }
    private static function printSessions($sessions){
        foreach ($sessions as $key => $value){
            echo $key . " " .$value. ", ";
        }
    }
    public static function end(){
        session_destroy();
    }
}
<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 6.7.17
 * Time: 17:09
 */
class HomeModel{

    public function getNumPosts(){
        $num = Database::queryOne('SELECT Count(idPost) AS NumberOfPosts FROM Post');
        return $num;
    }
    public function getNumUsers(){
        $num = Database::queryOne('SELECT Count(idUser) AS NumberOfUsers FROM User');
        return $num;
    }
}
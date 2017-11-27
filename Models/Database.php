<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 26.6.17
 * Time: 12:33
 */
class Database{

    private static $conn;
    private static $settings = array(
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8",
        PDO::ATTR_EMULATE_PREPARES => false,
    );
    public static function connect($host, $user, $password, $database){
        if (!isset(self::$conn)){
            self::$conn = @new PDO(
               "mysql:host=$host;dbname=$database", $user, $password,  self::$settings
            );
        }
    }
    /*
     * Vyber jednoho radku
     */
    public static function queryOneRow($query_content, $params){
        $result = self::$conn->prepare($query_content);
        $result->execute($params);
        $result = $result->fetch();
        return $result;
    }
    /*
     * Vyber vice radku
     */
    public static function queryAll($query_content, $params){
        $result = self::$conn->prepare($query_content);
        $result->execute($params);
        $result = $result->fetchall();
        return $result;
    }
    /*
     * Vyber prvniho sloupce
     */
    public static function queryOne($query_content, $params){
        $result = self::queryOneRow($query_content,$params);
        return $result[0];
    }
    public static function query($query_content, $params){
        $return = self::$conn->prepare($query_content);
        $return->execute($params);
        $return = $return->rowCount();
        return $return;
    }
}
<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 25.6.17
 * Time: 15:41
 */
abstract class Controller{

    protected $data = array();
    protected $view = "";
    protected $header = array('title'=>'','key_words'=>'','description'=>'');

    abstract function process($params);
    public function printView(){
        if($this->view){
            extract($this->data);
            require ("Views/" . $this->view . ".phtml");
        }
    }
    protected function isLogged(){
        return isset($_SESSION['username']);
    }
    public function login(){
        if (!$this->isLogged()){
            $login = new LoginModel();
            $error = $login->run();
            if($error){
                $this->data['loginError'] = $error;
            }
        }
    }
    public function logout(){
        if (isset($_SESSION['username'])){
            $login = new LoginModel();
            $login->logout();
        }
    }
    public function redirect($url){
        header("Location: /$url");
        header("Connection: close");
        exit;
    }

}
<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 26.6.17
 * Time: 12:03
 */
class LoginModel{
    public $status_user = '';
    public function run(){
        if(!isset($_SESSION['username'])){
            if (isset($_POST['send'])){
                return $this->login($_POST['email'],$_POST['password']);
            }
        }
    }
    public function login($email,$password){

        $checked = $this->checkEmail($email);
        if (!$checked){
            return "Email neexistuje";
        }
        $checked = $this->checkPassword($password, $email);
        if (!$checked){
            return "Heslo nesouhlasí";
        }
        if ($checked['ban']){
            return "Máte ban";
        }
        $rights = '';
        if ($checked['status'] == 1){
            $rights = 'Autor';
        }elseif ($checked['status'] == 2){
            $rights = 'Recenzent';
        }else{
            $rights = 'Administrátor';
        }
        SessionHandle::createSessions(array('username' => $checked['name'], 'valid' => true, 'timeout'=>time(), 'rights' => $rights, 'id' => $checked['idUser']));
        return 0;
    }
    public function logout(){

        if (isset($_POST['logout'])) {
            SessionHandle::unsetSessions(array('username', 'valid', 'timeout','rights','id'));
            SessionHandle::end();
        }
        return "Byl jste odhlášen";
    }
    private function checkPassword($password, $email){
        $result = Database::queryAll('SELECT * from User WHERE email = ?', array($email));
        if (password_verify($password, $result[0]['password'])){
            return $result[0];
        }else{
            return 0;
        }
    }
    private function checkEmail($email){
        $result = Database::queryOne('SELECT name from User WHERE email = ?', array($email));
        return $result;
    }

    private function getUser($email, $password){

    }
}
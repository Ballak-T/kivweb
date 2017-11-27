<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 25.6.17
 * Time: 23:11
 */
class SigninModel{

    protected $passMinLength = 6;
    protected $nameMinLength = 3;

    public function signIn($name, $email, $password, $password_check, $type){
        $checked = $this->checkName($name);
        if ($checked){
            return $checked;
        }
        $checked = $this->checkEmail($email);
        if ($checked){
            return $checked;
        }
        $checked = $this->checkPassword($password,$password_check);
        if ($checked){
            return $checked;
        }
        self::userToDb($name,$email,$password, $type);
        $login = new LoginModel();
        $login->login($email,$password);
        return 0;
    }
    private function checkName($name){
        $lengthName= strlen($name);
        if ($lengthName < $this->nameMinLength){
            return "Jméno je příliš krátké";
        }
        if ($this->findName($name)){
            return "Uživatel již existuje";
        }
        return 0;
    }
    private function checkEmail($email){
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return "Špatný formát emailu";
        }
        if ($this->findEmail($email)){
            return "Email již existuje";
        }
        return 0;
    }
    private function checkPassword($password, $password_check){

        $lengthPassword = strlen($password);
        $sameBoolean = strcmp($password,$password_check);

        if ($lengthPassword < $this->passMinLength){
            return "Heslo je příliš krátké";
        }
        if ($sameBoolean){
            return "Hesla se neshodují";
        }
        return 0;
    }
    private function findEmail($email){
        $result = Database::queryOneRow('SELECT * from User WHERE email = ?',array($email));
        return $result;
    }
    private function findName($name){
        $result = Database::queryOneRow('SELECT * from User WHERE name = ?',array($name));
        return $result;
    }
    private function userToDb($name,$email,$password,$man){
        $password = password_hash($password, PASSWORD_BCRYPT, array(
            'cost' => 10
        ));
        $status = Database::query('INSERT INTO User (name,email,password,status,ban, man) VALUES (?,?,?,1,0,?)',array($name,$email,$password,$man));
        return $status;
    }
}
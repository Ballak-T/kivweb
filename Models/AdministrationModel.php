<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 6.7.17
 * Time: 17:18
 */
class AdministrationModel{

   public function getUsers(){
       $users = Database::queryAll('SELECT * FROM User');
       $i = 0;
       foreach ($users as $user){

           $user['status'] = $this->statusToText($user['status']);
           $users[$i] = $user;
           $i++;

       }
       return $users;
   }
   private function statusToText($statusNum){

       $status = '';

       if ($statusNum == 1){
           $status = 'Autor';
       }elseif ($statusNum == 2){
           $status = 'Recenzent';
       }else{
           $status = 'Administrátor';
       }

       return $status;
   }
   public function changeStatus($status, $idUser){
       $rows = Database::query('UPDATE User SET status = ? WHERE idUser = ?',array($status,$idUser));
       if ($rows){
           return 0;
       }else{
           return 'Nepodařilo se změnit status uživatele';
       }
   }
    public function changeBan($ban, $idUser){
        $rows = Database::query('UPDATE User SET ban = ? WHERE idUser = ?',array($ban,$idUser));
        if ($rows){
            return 0;
        }else{
            return 'Nepodařilo se změnit ban uživatele';
        }
    }

}
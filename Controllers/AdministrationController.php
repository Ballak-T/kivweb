<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 6.7.17
 * Time: 17:45
 */
class AdministrationController extends Controller {

    public function process($params){


        $admin = new AdministrationModel();
        $users = $admin->getUsers();
        if ($_SESSION['rights'] == 'Administrátor') {
            $this->view = 'administration';
            if (isset($_GET['newStatus']) and isset($_GET['id'])){
                $newStatus = $_GET['newStatus'];
                $id = $_GET['id'];
                $result = $admin->changeStatus($newStatus,$id);
                if ($result){
                    $this->data['errorChange'] = $result;
                }else{
                    $this->data['successChange'] = 'Status byl úspěšně změněn';
                }
                $this->redirect('administration');
            }
            if (isset($_GET['ban']) and isset($_GET['id'])){
                $admin->changeBan($_GET['ban'],$_GET['id']);
                $this->redirect('administration');
            }
        }else{
            $this->redirect('home');
        }
        $this->data['users'] = $users;
    }

}
<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 25.6.17
 * Time: 20:30
 */
class SigninController extends Controller {
    public function process($params){

        $message = 'fdsfsdf';
        $this->header['title'] = 'Registrační formulář';
        $this->header['key_words'] = 'registrace, formulář, signin, form';
        $this->header['description'] = 'Formulář pro registraci uživatelů.';
        $this->view = 'signin';

        if (isset($_POST['send_reg'])){
            $signModel = new SigninModel();
            $result = $signModel->signIn($_POST['fullname'],$_POST['email'],$_POST['password'],$_POST['password_verify'],$_POST['type']);
            if (!$result){
                $this->data['success'] = "Byl/a jste úspěšně zaregistrován";
                if (isset($this->data['error'])){
                    unset($this->data['error']);
                }
            }else{
                $this->data['error'] = $result;
            }
        }

    }
}
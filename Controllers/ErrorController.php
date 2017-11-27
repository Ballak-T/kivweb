<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 25.6.17
 * Time: 19:28
 */
class ErrorController extends Controller {

    public function process($params){
        header("HTTP/1.0 404 Not Found");
        $this->header['title'] = 'Chyba 404';
        $this->view = 'error';
    }
}
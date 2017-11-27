<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 25.6.17
 * Time: 15:58
 */
class RouterController extends Controller{
    protected $controller;
    public function process($params){
        $parsedUrl = $this->parseURL($params[0]);
        if (empty($parsedUrl[0])){
            $this->redirect('home');
        }

        $classController = $this->convertString(array_shift($parsedUrl)) . "Controller";

        if (file_exists('Controllers/' . $classController . '.php')){
            $this->controller = new $classController;
        }else{
            $this->redirect('error');
        }

        $this->controller->process($parsedUrl);
        $this->data['title'] = $this->controller->header['title'];
        $this->data['description'] = $this->controller->header['description'];
        $this->data['key_words'] = $this->controller->header['key_words'];
        $this->view='hlavni';
    }
    private function parseURL($url){
        $parsed = parse_url($url);
        $parsed["path"] = ltrim($parsed["path"], "/");
        $parsed["path"] = trim($parsed["path"]);

        $split = explode("/",$parsed["path"]);
        return $split;
    }
    private function convertString($text){
        $result = str_replace('-','', $text);
        $result = strtolower($result);
        $result = ucwords($result);
        return $result;

    }
}
<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 25.6.17
 * Time: 20:54
 */
class HomeController extends Controller {
    public function process($params)
    {
        $this->header['title'] = 'Semestrální práce kiv/web';
        $this->header['key_words'] = 'zču,kiv,semestální práce,semestrálka,semestralka,fav';
        $this->header['description'] = 'Základní redakční systém jako semestrální práce, na předmět kiv/web';
        $this->view = 'home';

        $home = new HomeModel();
        $this->data['numPosts'] = $home->getNumPosts();
        $this->data['numUsers'] = $home->getNumUsers();
    }
}
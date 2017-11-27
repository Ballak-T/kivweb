<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 30.6.17
 * Time: 0:06
 */
class PostController extends Controller {

    public function process($params){

        $this->view = 'post';
        $post = new PostModel();
        $posts = $post->getPosts();
        $this->header['title'] = 'Příspěvky';
        $this->data['posts'] = $posts;

        if ($this->isLogged()) {
            if ($_SESSION['rights'] == 'Autor') {
                $mypost = $post->getPostByUsername($_SESSION['username']);
                if ($mypost) {
                    $this->data['myPosts'] = $mypost;
                }
            }elseif ($_SESSION['rights'] == 'Administrátor'){
                $this->data['assigned'] = $post->getAssigned();
                $this->data['reviewers'] = $post->getReviewers();
                $this->data['reviews'] = $post->getPostsAdmin();
            }
        }
        if (isset($_GET['del'])) {
            if ($this->isLogged()) {
                if ($_SESSION['rights'] == 'Autor'){
                    $errorMessage = $post->deletePostByUsername($_SESSION['username'],$_GET['del']);
                    if ($errorMessage){
                        $this->data['errorPost'] = $errorMessage;
                    }
                    $this->redirect('post');
                }elseif ($_SESSION['rights'] == 'Administrátor'){
                    $errorMessage = $post->deletePostById($_GET['del']);
                    if ($errorMessage){
                        $this->data['errorPost'] = $errorMessage;
                    }else {
                        header('Location: /post');
                    }
                }else{
                    $this->data['errorPost'] = 'Nemáte dostatečná práva!';
                }
            } else {
                $this->data['errorPost'] = 'Nejste přihlášen!';
            }
        }
        if (isset($_GET['postId']) && isset($_GET['userId'])) {
            if ($this->isLogged()) {
                if ($_SESSION['rights'] == 'Administrátor'){
                    $errorMessage = $post->addTask($_GET['postId'],$_GET['userId']);
                    if ($errorMessage){
                        $this->data['errorPost'] = $errorMessage;
                    }
                }else{
                    $this->data['errorPost'] = 'Nemáte dostatečná práva!';
                }
            }else {
                $this->data['errorPost'] = 'Nejste přihlášen!';
            }
        }
        if (isset($_POST['send_post'])) {
            if ($this->isLogged()) {
                if ($_SESSION['rights'] == 'Autor'){
                    $errorMessage = 0;
                    $errorMessage = $post->addPost($_POST['topic'], $_POST['content'], $_SESSION['username'], $_FILES['document'], $_SESSION['id']);
                    if ($errorMessage) {
                        $this->data['errorPost'] = $errorMessage;
                    } else {
                        $this->data['successPost'] = 'Příspěvek byl přidán';
			header('Location: /post');
                    }
                }else{
                    $this->data['errorPost'] = 'Nemáte dostatečná práva!';
                }
            } else {
                $this->data['errorPost'] = 'Nejste přihlášen!';
            }
        }
    }
}
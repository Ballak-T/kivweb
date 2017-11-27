<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 9.7.17
 * Time: 17:25
 */
class ReviewController  extends Controller {
    function process($params){
        $review = new ReviewModel();
        $this->data['task'] = $review->getTasks($_SESSION['id']);
        $this->view = 'review';
        if ($_SESSION['rights'] != 'Recenzent')
            $this->redirect('home');
        if($_POST['send_review']){
            $review = new ReviewModel();
            $errorMessage = $review->addReview($_SESSION['id'],$_POST['originality'],$_POST['topic'],$_POST['technique'],$_POST['language'],$_POST['recommendation'],$_POST['note'],$_POST['post']);
            if ($errorMessage){
                $this->data['errorMessage'] = $errorMessage;
            }else{
                //$this->data['successMessage'] = 'Recenze byla přidána';
		header('Location: /review');
            }
        }
    }
}
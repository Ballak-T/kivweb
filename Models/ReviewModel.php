<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 9.7.17
 * Time: 17:27
 */
class ReviewModel {
    public function getTasks($userId){
        $result = Database::queryAll('SELECT Task.Made,Task.idTask,Post.topic,Post.author,Post.content
FROM Task JOIN Post ON Task.Post_idPost = Post.idPost WHERE Task.User_idUser = ? AND Task.made = 0;',array($userId));
        return $result;
    }

    public function addReview($userId,$originality,$topic,$technique,$language,$recommendation,$comment,$taskId){
        $result = Database::query('INSERT INTO Review (originality,topic,technique,language,recommendation,comment,User_idUser)
VALUES (?,?,?,?,?,?,?)',array($originality,$topic,$technique,$language,$recommendation,$comment,$userId));
        if (!$result){
            return 'Recenze nešla přidat';
        }
        $idPost = Database::queryOne('SELECT Task.Post_idPost FROM Task WHERE Task.idTask = ?',array($taskId));
        echo $idPost;
        $idReview = Database::queryOne('SELECT Review.idReview FROM Review WHERE Review.User_idUser = ? ORDER BY Review.idReview DESC LIMIT 1',array($userId));
        echo $idReview."userid:".$userId;
        $result = Database::query('INSERT INTO Post_has_Review (Post_idPost, Review_idReview) VALUES (?,?)',array($idPost,$idReview));
        if (!$result){
            return 'Recenze nešla přidat';
        }
        $result = Database::query('UPDATE Task SET Task.made = 1 WHERE Task.User_idUser = ? AND Task.Post_idPost = ?',array($userId,$idPost));
        if (!$result){
            return 'Recenze nešla přidat';
        }
        if ($result){
            return 0;
        }
    }
}
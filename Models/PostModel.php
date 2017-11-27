<?php

/**
 * Created by PhpStorm.
 * User: ballin
 * Date: 3.7.17
 * Time: 12:11
 */
class PostModel{

    private $filename = '';

    public function getPosts($limit=50){
        $result = Database::queryAll('SELECT * FROM Post ORDER BY idPost DESC LIMIT ?',array($limit));
        return $result;
    }
    public function getPostsAdmin($limit=50){
        $result = Database::queryAll('SELECT Post.idPost,Review.* FROM Post JOIN Post_has_Review ON Post_has_Review.Post_idPost = Post.idPost JOIN 
Review ON Review.idReview = Post_has_Review.Review_idReview ORDER BY Post.idPost DESC LIMIT ?',array($limit));
        return $result;
    }
    public function getAssigned($limit=50){
        $result = Database::queryAll('SELECT Post.topic,Post.author,User.name FROM Post INNER JOIN Task ON
 Task.Post_idPost = Post.idPost AND Task.made = 0 INNER JOIN User ON User.idUser = Task.User_idUser ORDER BY User.idUser LIMIT ?',array($limit));
        return $result;
    }
    public function getPostByUsername($username,$limit=50){
        $id = Database::queryOne('SELECT idUser FROM User WHERE name = ?',array($username));
        $result = Database::queryAll('SELECT * FROM Post WHERE User_idUser = ? ORDER BY idPost DESC LIMIT ?',array($id,$limit));
        return $result;
    }
    public function getReviewers($limit=10){
        $result = Database::queryAll('SELECT * FROM User WHERE status = 2 ORDER BY idUser DESC LIMIT ?',array($limit));
        return $result;
    }
    public function deletePostByUsername($username, $postId){
        $id = Database::queryOne('SELECT idUser FROM User WHERE name = ?',array($username));
        $filename = Database::queryOne('SELECT filename FROM Post WHERE User_idUser = ? AND idPost = ?',array($id,$postId));
        if (file_exists($filename)){
            unlink($filename);
        }
        $rows = Database::query('DELETE FROM Post WHERE idPost = ? AND User_idUser = ?',array($postId,$id));
        if ($rows){
            return 0;
        }else{
            return "Nepodařilo se smazat příspěvek";
        }

    }
    public function deletePostById($postId){
        $filename = Database::queryOne('SELECT filename FROM Post WHERE idPost = ?',array($postId));
        if (file_exists($filename)){
            unlink($filename);
        }
        $rows = Database::query('DELETE FROM Post WHERE idPost = ?',array($postId   ));
        if ($rows){
            return 0;
        }else{
            return "Nepodařilo se smazat příspěvek";
        }
    }
    public function addPost($topic, $content, $author, $file, $user_id){

        $errMessage = 0;

        if ($file['size']){
            $errMessage = $this->addFile($file,$user_id);
        }

        if ($errMessage) {
            return $errMessage;
        }else{
            $status = $this->addToDatabase($topic,$content,$author,$this->filename, $user_id);
            if ($status){
                return 0;
            }else{
                $errMessage = 'Nepovedlo se přidat příspěvek';
                return $errMessage;
            }
        }
    }
    private function addToDatabase($topic, $content, $author, $filename, $user_id){

        $rowsChanged = Database::query('INSERT INTO Post (topic,content,author,filename,accepted,User_idUser) VALUES (?,?,?,?,0,?)',
            array($topic,$content,$author,$filename,$user_id));
        return $rowsChanged;


    }
    public function addTask($postId,$userId){
        $exist = Database::queryOne('SELECT * FROM Task WHERE Task.User_idUser = ? AND Task.Post_idPost = ?',array($userId,$postId));
        if (!$exist) {
            $rowsChanged = Database::query('INSERT INTO Task (Post_idPost,User_idUser,Made) VALUES (?,?,0)', array($postId, $userId));
            if ($rowsChanged) {
                return 0;
            } else {
                return 'Nepodařilo se přidělit práci';
            }
        }else{
            return 'Recenzent už má tuto práci přidělenou';
        }
    }
    private function addFile($sentFile,$user_id,$types=array('pdf'),$max_size=50000000){

        $dir = 'uploads/' . $user_id . '/';
        if (!file_exists($dir)) {
            mkdir($dir, 0777, true);
        }
        $file = $dir . basename($sentFile["name"]);
        $this->filename = $file;
        $type = pathinfo($file, PATHINFO_EXTENSION);
        $size = $sentFile["size"];
        $errorMessage = '';
        $typeStatus = 0;

        foreach ($types as $one){
            if ($type == $one){
                $typeStatus = 1;
            }
        }

        if (!$typeStatus){
            $errorMessage = 'Nepovolený typ souboru "'.$type.'"';
            return $errorMessage;
        }
        if (file_exists($file)){
            $errorMessage = 'Soubor již existuje';
            return $errorMessage;
        }
        if ($size > $max_size){
            $errorMessage = 'Soubor překročil maximální velikost ' . $max_size;
            return $errorMessage;
        }

        $status = move_uploaded_file($sentFile["tmp_name"], $file);

        if ($status){
            return 0;
        }else{
            $errorMessage = 'Nepodařilo se nahrát soubor';
            return $errorMessage;
        }
    }
    private function deleteFile($filePath){
        if (file_exists($filePath)){
            unset($filePath);
            return 0;
        }else{
            return 'Soubor nebyl nalezen';
        }
    }




}
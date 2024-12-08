<?php 

function database(){

    try{
        $db = new PDO("mysql:host=localhost;dbname=cotesfip", 'root', '');
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $db;
    }catch (PDOException $pDOException){
        echo "Erreur ".$pDOException->getMessage();
    }
}
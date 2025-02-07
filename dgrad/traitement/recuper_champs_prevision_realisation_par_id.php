<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['jlk']) and !empty($_SESSION['jlk'])){
    $session = htmlspecialchars($_SESSION['jlk']);
  
    $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgrad_utilisateur WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $id_service_pourvoyeur = $data->id_service_pourvoyeur;

        if(isset($_POST['id_modifier']) and !empty($_POST['id_modifier'])){
            $id_modifier = htmlspecialchars($_POST['id_modifier']);

            $req = database()->prepare("SELECT prevision, realisation FROM dgrad_statistique WHERE id=?");
            $req->execute([$id_modifier]);

            if($req->rowCount()==1){
                $data = $req->fetch(PDO::FETCH_OBJ);
                echo json_encode($data);
            }
            
        }

        

    }else{
        echo "<option value=''>Erreur</option>";

    }
  
  }else{
    echo "<option value=''>Erreur 2</option>";

  }
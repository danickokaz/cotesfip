<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['visa']) and !empty($_SESSION['visa'])){
    $session = htmlspecialchars($_SESSION['visa']);
  
    $req = database()->prepare("SELECT id_service_pourvoyeur FROM utilisateur WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $id_service_pourvoyeur = $data->id_service_pourvoyeur;

        $req = database()->prepare("SELECT id,libelle_role as role_utilisateur FROM role_utilisateur");
        $req->execute();

        echo "<option value=''>Veuillez choisir un role</option>";

        if($req->rowCount() > 0){
            $provinces = $req->fetchAll(PDO::FETCH_OBJ);
            foreach($provinces as $province){
                echo "<option value='". $province->id. "'>". $province->role_utilisateur. "</option>";
            }
        }else{
            echo "<option value=''>Aucun role</option>";
        }

    }else{
        echo "<option value=''>Aucun role</option>";

    }
  
  }else{
    echo "<option value=''>Aucun role</option>";

  }
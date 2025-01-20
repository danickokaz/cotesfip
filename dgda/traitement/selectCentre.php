<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['access']) and !empty($_SESSION['access'])){
    $session = htmlspecialchars($_SESSION['access']);

    if(isset($_POST['id_province']) and !empty($_POST['id_province'])){
        $id_province = htmlspecialchars($_POST['id_province']);


        $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgda_utilisateur WHERE token_utilisateur=?");
        $req->execute([$session]);
  
        if($req->rowCount() == 1){

            $data = $req->fetch(PDO::FETCH_OBJ);
            $id_service_pourvoyeur = $data->id_service_pourvoyeur;

            $req = database()->prepare("SELECT id,libelle_centre_perception as centre FROM dgda_centre_perception WHERE id_province= ?");
            $req->execute([$id_province]);

            echo "<option>Veuillez choisir  un centre de perception</option>";

            if($req->rowCount() > 0){
                $centres = $req->fetchAll(PDO::FETCH_OBJ);
                foreach($centres as $centre){
                    echo "<option value='". $centre->id. "'>". $centre->centre. "</option>";
                }
            }else{
                echo "<option>Aucun centre de perception</option>";
            }

        }else{
            echo "<option>Aucun centre de perception</option>";

        }

        
    }
  
    
  
  }else{
    echo "<option value=''>Aucune province</option>";

  }
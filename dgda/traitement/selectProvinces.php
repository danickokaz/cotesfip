<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['access']) and !empty($_SESSION['access'])){
    $session = htmlspecialchars($_SESSION['access']);

    if(isset($_POST['id_configuration']) and !empty($_POST['id_configuration'])){
        $configuration = htmlspecialchars($_POST['id_configuration']);


        $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgda_utilisateur WHERE token_utilisateur=?");
        $req->execute([$session]);
  
        if($req->rowCount() == 1){

            $data = $req->fetch(PDO::FETCH_OBJ);
            $id_service_pourvoyeur = $data->id_service_pourvoyeur;

            $req = database()->prepare("SELECT id,libelle_province as province FROM province WHERE id_configuration= ? AND id_service=?");
            $req->execute([$configuration,$id_service_pourvoyeur]);

            echo "<option>Veuillez choisir une province</option>";

            if($req->rowCount() > 0){
                $provines = $req->fetchAll(PDO::FETCH_OBJ);
                foreach($provines as $province){
                    echo "<option value='". $province->id. "'>". $province->province. "</option>";
                }
            }else{
                echo "<option>Aucune province</option>";
            }

        }else{
            echo "<option>Aucune province</option>";

        }

        
    }
  
    
  
  }else{
    echo "<option value=''>Aucune province</option>";

  }
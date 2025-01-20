<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['access']) and !empty($_SESSION['access'])){
    $session = htmlspecialchars($_SESSION['access']);

    if(isset($_POST['id_type_secteur']) and !empty($_POST['id_type_secteur'])){
        $id_type_secteur = htmlspecialchars($_POST['id_type_secteur']);


        $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgda_utilisateur WHERE token_utilisateur=?");
        $req->execute([$session]);
  
        if($req->rowCount() == 1){

            $data = $req->fetch(PDO::FETCH_OBJ);
            $id_service_pourvoyeur = $data->id_service_pourvoyeur;

            $req = database()->prepare("SELECT id,libelle_categorie_secteur as libelle_categorie_secteur FROM dgda_categorie_secteur_actvite WHERE id_type_secteur=?");
            $req->execute([$id_type_secteur]);

            echo "<option>Veuillez choisir une catégorie</option>";

            if($req->rowCount() > 0){
                $categoires = $req->fetchAll(PDO::FETCH_OBJ);
                foreach($categoires as $categorie){
                    echo "<option value='". $categorie->id. "'>". $categorie->libelle_categorie_secteur. "</option>";
                }
            }else{
                echo "<option>Aucune catégorie</option>";
            }

        }else{
            echo "<option>Aucune catégorie</option>";

        }

        
    }
  
    
  
  }else{
    echo "<option value=''>Aucune catégorie</option>";

  }
<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['access']) and !empty($_SESSION['access'])){
    $session = htmlspecialchars($_SESSION['access']);

    if(isset($_POST['id_type_nature']) and !empty($_POST['id_type_nature'])){
        $id_type_nature = htmlspecialchars($_POST['id_type_nature']);


        $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgda_utilisateur WHERE token_utilisateur=?");
        $req->execute([$session]);
  
        if($req->rowCount() == 1){

            $data = $req->fetch(PDO::FETCH_OBJ);
            $id_service_pourvoyeur = $data->id_service_pourvoyeur;

            $req = database()->prepare("SELECT id,libelle_nature_economique as libelle_categorie FROM dgda_categorie_nature_economique WHERE id_type_nature_economique=?");
            $req->execute([$id_type_nature]);

            echo "<option value=''>Veuillez choisir une catégorie</option>";

            if($req->rowCount() > 0){
                $categoires = $req->fetchAll(PDO::FETCH_OBJ);
                foreach($categoires as $categorie){
                    echo "<option value='". $categorie->id. "'>". $categorie->libelle_categorie. "</option>";
                }
            }else{
                echo "<option value=''>Aucune catégorie</option>";
            }

        }else{
            echo "<option value=''>Aucune catégorie</option>";

        }

        
    }
  
    
  
  }else{
    echo "<option value=''>Aucune catégorie</option>";

  }
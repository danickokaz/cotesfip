<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_POST['service']) and !empty($_POST['service'])){
    $service = htmlspecialchars($_POST['service']);

    if(isset($_SESSION['jlk']) and !empty($_SESSION['jlk'])){
        $session = htmlspecialchars($_SESSION['jlk']);
      
        $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgrad_utilisateur WHERE token_utilisateur=?");
        $req->execute([$session]);
      
        if($req->rowCount() == 1){
            $data = $req->fetch(PDO::FETCH_OBJ);
            $id_service_pourvoyeur = $data->id_service_pourvoyeur;
    
            $req = database()->prepare("SELECT id,libelle_categorie_acte FROM dgrad_categorie_acte_generateur WHERE id_service_assiette= ?");
            $req->execute([$service]);
    
            echo "<option value=''>Veuillez choisir une categorie</option>";
    
            if($req->rowCount() > 0){
                $categories = $req->fetchAll(PDO::FETCH_OBJ);
                foreach($categories as $categorie){
                    echo "<option value='". $categorie->id. "'>". $categorie->libelle_categorie_acte. "</option>";
                }
            }else{
                echo '<option value="">Aucune categorie</option>';
            }
    
        }else{
            echo "<option value=''>Aucune categorie</option>";
    
        }
      
      }else{
        echo "<option value=''>Aucune categorie</option>";
    
      }
}


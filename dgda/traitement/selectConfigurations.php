<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['access']) and !empty($_SESSION['access'])){
    $session = htmlspecialchars($_SESSION['access']);
  
    $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgda_utilisateur WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $id_service_pourvoyeur = $data->id_service_pourvoyeur;

        $req = database()->prepare("SELECT id,libelle_configuration_province as configuration_province FROM configuration_province ORDER BY id DESC");
        $req->execute();

        echo "<option value=''>Veuillez choisir une configuration</option>";

        if($req->rowCount() > 0){
            $configurations_province = $req->fetchAll(PDO::FETCH_OBJ);
            foreach($configurations_province as $cp){
                echo "<option value='". $cp->id. "'>". $cp->configuration_province. "</option>";
            }
        }else{
            echo '<option value="">Aucune configuration disponible</option>';
        }

    }else{
        echo "<option value=''>Aucune configuration disponible</option>";

    }
  
  }else{
    echo "<option value=''>Aucune configuration disponible</option>";

  }
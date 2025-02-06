<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_POST['exerciceM']) and !empty($_POST['exerciceM'])){
    $exerciceM = htmlspecialchars($_POST['exerciceM']);

    if(isset($_SESSION['jlk']) and !empty($_SESSION['jlk'])){
        $session = htmlspecialchars($_SESSION['jlk']);
      
        $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgrad_utilisateur WHERE token_utilisateur=?");
        $req->execute([$session]);
      
        if($req->rowCount() == 1){
            $data = $req->fetch(PDO::FETCH_OBJ);
            $id_service_pourvoyeur = $data->id_service_pourvoyeur;
    
            $req = database()->prepare("SELECT id,libelle_service as service_assiette FROM dgrad_servives_assiettes WHERE exercice= ?");
            $req->execute([$exerciceM]);
    
            echo "<option value=''>Veuillez choisir un service</option>";
    
            if($req->rowCount() > 0){
                $services = $req->fetchAll(PDO::FETCH_OBJ);
                foreach($services as $service){
                    echo "<option value='". $service->id. "'>". $service->service_assiette. "</option>";
                }
            }else{
                echo '<option value="">Aucune province</option>';
            }
    
        }else{
            echo "<option value=''>Aucune province</option>";
    
        }
      
      }else{
        echo "<option value=''>Aucune province</option>";
    
      }
}


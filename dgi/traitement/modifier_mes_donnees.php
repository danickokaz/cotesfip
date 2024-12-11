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

        if(isset($_POST['id_modifier']) and !empty($_POST['id_modifier'])){

            $id_modifier = htmlspecialchars($_POST['id_modifier']);
            $prevision = isset($_POST['previsionModifier']) ? htmlspecialchars($_POST['previsionModifier']) :NULL;
            $realisation = isset($_POST['realisationModifier']) ? htmlspecialchars($_POST['realisationModifier']) :NULL;

            try{
                $req = database()->prepare("UPDATE dgi_statistique SET prevision=?, realisation=? WHERE id=?");
                $req->execute([$prevision,$realisation,$id_modifier]);

                echo "success";
            }catch(Exception $e){
                echo "Erreur: ".$e->getMessage();
            }

        
               
                
               

            

        }else{
            echo "Erreur1";
        }

    }else{
        echo "Erreur2";
    }
}else{
    echo "Erreur3";
}
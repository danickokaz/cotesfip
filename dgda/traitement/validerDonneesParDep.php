<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['access']) and !empty($_SESSION['access'])){
    $session = htmlspecialchars($_SESSION['access']);
  
    $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgda_utilisateur WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){

        if(isset($_POST['id_valider']) and !empty($_POST['id_valider'])){
            $id_valider = htmlspecialchars($_POST['id_valider']);

            $req = database()->prepare("UPDATE dgda_statistique SET id_etat_donnee=? WHERE id=? ");
            $req->execute([3,$id_valider]);
            echo "Success";

        }else{
            echo "Vide";
        }

    }
}
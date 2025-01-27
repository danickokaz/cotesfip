<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';


if(isset($_SESSION['kedadaje']) and !empty($_SESSION['kedadaje'])){
    $session = htmlspecialchars($_SESSION['kedadaje']);
  
    $req = database()->prepare("SELECT 
    administrateur.token_admin,
    administrateur.pseudo,
    administrateur.id,
    administrateur.id_role,
    administrateur.id_service_affecte,
    service_pourvoyeur.abreviation as service_utilisateur,
    role_admin.libelle_role as role_utilisateur
    FROM administrateur 
    LEFT JOIN service_pourvoyeur ON administrateur.id_service_affecte = service_pourvoyeur.id
    LEFT JOIN role_admin ON administrateur.id_role = role_admin.id
    WHERE administrateur.token_admin=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
      $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);
  
      
      if(isset($_POST['id']) and !empty($_POST['id'])){
        $id = htmlspecialchars($_POST['id']);

        $req = database()->prepare("DELETE FROM  statistiques_globales WHERE code_transfert=?");
        $req->execute([$id]);

        echo "success";

        
      }
    }
    
}

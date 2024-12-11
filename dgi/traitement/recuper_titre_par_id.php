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

            $req = database()->prepare("SELECT code_nature, libelle_nature_recette FROM dgi_statistique WHERE id=?");
            $req->execute([$id_modifier]);

            if($req->rowCount()==1){
                $data = $req->fetch(PDO::FETCH_OBJ);
                echo '
                <div class="alert alert-warning" role="alert">
                    <h4 class="alert-heading"><i class="fa fa-warning"></i> A savoir!</h4>
                    <p>'.$data->code_nature.' / '.$data->libelle_nature_recette.'</p>
                    
                </div>
                
                ';
            }
            
        }

        

    }else{
        echo "<option value=''>Aucune province</option>";

    }
  
  }else{
    echo "<option value=''>Aucune province</option>";

  }
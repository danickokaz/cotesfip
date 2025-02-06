<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['jlk']) and !empty($_SESSION['jlk'])){
    $session = htmlspecialchars($_SESSION['jlk']);
  
    $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgrad_utilisateur WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $id_service_pourvoyeur = $data->id_service_pourvoyeur;

        if(isset($_POST['role'],$_POST['pseudo']) and !empty($_POST['role']) and !empty($_POST['pseudo'])){

            $role = htmlspecialchars($_POST['role']);
            $pseudo = htmlspecialchars($_POST['pseudo']);
            $province = isset($_POST['province']) && is_numeric($_POST['province']) ? (int)$_POST['province'] : null;

           

            try{
                $req = database()->prepare("SELECT * FROM dgrad_utilisateur WHERE pseudo = ? AND motdepasse=? AND id_service_pourvoyeur=? AND id_role=?");
                $req->execute([$pseudo, sha1("12345678"), $id_service_pourvoyeur, $role]);

                if($req->rowCount() == 0){
                    try{
                        $req = database()->prepare("INSERT INTO dgrad_utilisateur (pseudo,motdepasse,id_province,id_service_pourvoyeur,id_role,id_etat_utilisateur,token_utilisateur)
                        VALUES (?,?,?,?,?,?,?)");
                        $req->execute([$pseudo,sha1("12345678"),$province,$id_service_pourvoyeur,$role,1,sha1(time().uniqid())]);

                        echo "success";
                    }catch(Exception $e){
                        echo "Erreur: ".$e->getMessage();
                    }
                }else{
                    echo "deja";
                }

            }catch(Exception $e){
                echo 'Erreur: '.$e->getMessage();
            }

        }else{
            echo "Champs vides";
        }

    }else{
        echo "Vide 1";
    }
}else{
    echo "Vide 2";
}
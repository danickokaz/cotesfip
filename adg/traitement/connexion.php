<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';



if(isset($_POST['nomutilisateur'],$_POST['motdepasse']) and !empty($_POST['nomutilisateur']) and !empty($_POST['motdepasse'])){

    $nomutilisateur = htmlspecialchars($_POST['nomutilisateur']);
    $motdepasse = sha1(htmlspecialchars($_POST['motdepasse']));

    $req = database()->prepare("SELECT token_admin FROM administrateur WHERE pseudo = ? AND motdepasse=? AND id_etat_utilisateur=?");
    $req->execute([$nomutilisateur,$motdepasse,1]);

    if($req->rowCount()==1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $tokenRecuperer = $data->token_admin;
        $tokenGenere  = sha1(random_int(0000000001,9999999999).time());
        $req = database()->prepare("UPDATE administrateur SET token_admin=? WHERE token_admin=?");
        $req->execute([$tokenGenere,$tokenRecuperer]);
        session_regenerate_id(true);
        $_SESSION['kedadaje'] = $tokenGenere;
        echo "Success";
    }else{
        echo "Informations incorrectes";
    }


}else{
    echo "vide";
}

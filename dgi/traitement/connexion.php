<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';



if(isset($_POST['nomutilisateur'],$_POST['motdepasse']) and !empty($_POST['nomutilisateur']) and !empty($_POST['motdepasse'])){

    $nomutilisateur = htmlspecialchars($_POST['nomutilisateur']);
    $motdepasse = sha1(htmlspecialchars($_POST['motdepasse']));

    $req = database()->prepare("SELECT token_utilisateur FROM utilisateur WHERE pseudo = ? AND motdepasse=? AND id_etat_utilisateur=?");
    $req->execute([$nomutilisateur,$motdepasse,1]);

    if($req->rowCount()==1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $tokenRecuperer = $data->token_utilisateur;
        $tokenGenere  = sha1(random_int(0000000001,9999999999).time());
        $req = database()->prepare("UPDATE utilisateur SET token_utilisateur=? WHERE token_utilisateur=?");
        $req->execute([$tokenGenere,$tokenRecuperer]);
        session_regenerate_id(true);
        $_SESSION['visa'] = $tokenGenere;
        echo "Success";
    }else{
        echo "Informations incorrectes";
    }


}else{
    echo "vide";
}

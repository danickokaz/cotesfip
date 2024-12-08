<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';
require __DIR__ . '../../../vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\IOFactory;


if(isset($_SESSION['visa']) and !empty($_SESSION['visa'])){
    $session = htmlspecialchars($_SESSION['visa']);
  
    $req = database()->prepare("SELECT 
    utilisateur.token_utilisateur,
    utilisateur.pseudo,
    utilisateur.id,
    utilisateur.id_service_pourvoyeur,
    utilisateur.id_role,
    service_pourvoyeur.abreviation as service_utilisateur,
    role_utilisateur.libelle_role as role_utilisateur
    FROM utilisateur 
    INNER JOIN service_pourvoyeur ON utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
    INNER JOIN role_utilisateur ON utilisateur.id_role = role_utilisateur.id
    WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
      $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);
  
      $pseudo = $donneesUtilisateur->pseudo;
      $service_utilisateur  = $donneesUtilisateur->service_utilisateur;
      $role_utilisateur = $donneesUtilisateur->role_utilisateur;
      $id_service_pourvoyeur = $donneesUtilisateur->id_service_pourvoyeur;

          // Vérifier si le fichier est bien envoyé
    if (isset($_FILES['fichier'],$_POST['configuration']) && $_FILES['fichier']['error'] === 0 && !empty($_POST['configuration'])) {
        $fileName = $_FILES['fichier']['name'];
        $fileTmpPath = $_FILES['fichier']['tmp_name'];
        $fileSize = $_FILES['fichier']['size'];
        $fileType = $_FILES['fichier']['type'];
        $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));

        $configuration = htmlspecialchars($_POST['configuration']);

        // Extensions autorisées
        $allowedExtensions = ['xlsx', 'xls', 'csv'];

        if (in_array($fileExtension, $allowedExtensions)) {
            // Déplacer le fichier vers un répertoire cible
            $uploadDir = 'uploadProvince/';

            $destinationPath = $uploadDir . uniqid() . '.' . $fileExtension;
            if (move_uploaded_file($fileTmpPath, $destinationPath)) {

                $spreadsheet = IOFactory::load($destinationPath);

                $data = $spreadsheet->getActiveSheet()->toArray();

                foreach ($data as $row) {
                    $libelle_centre = $row['0'];

                    $req = database()->prepare("INSERT INTO province (libelle_province,id_configuration,id_service) VALUES(?,?,?)");
                    $req->execute([$libelle_centre,$configuration,$id_service_pourvoyeur]);

                }
                echo "Success";






            } else {
                echo "Une erreur est survennue";
            }
        } else {
            echo "Type de fichier invalide";
        }
    } else {
        echo "Veuillez  choisir un fichier";
    }
  
  
    }else{
      echo "Erreur";
    }
  
  }else{
    echo "Erreur";
  }
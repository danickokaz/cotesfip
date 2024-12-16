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
    utilisateur.id_province,
    utilisateur.id_centre_perception,
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
      $id_province = $donneesUtilisateur->id_province;
      $id_centre_perception = $donneesUtilisateur->id_centre_perception;

          // Vérifier si le fichier est bien envoyé
    if (isset($_FILES['fichierExcelDonnees'],$_POST['mois'],$_POST['annee']) && $_FILES['fichierExcelDonnees']['error'] === 0  && !empty($_POST['mois']) and !empty($_POST['annee'])) {
        $fileName = $_FILES['fichierExcelDonnees']['name'];
        $fileTmpPath = $_FILES['fichierExcelDonnees']['tmp_name'];
        $fileSize = $_FILES['fichierExcelDonnees']['size'];
        $fileType = $_FILES['fichierExcelDonnees']['type'];
        $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));

        $mois = htmlspecialchars($_POST['mois']);
        $annee = htmlspecialchars($_POST['annee']);

        // Extensions autorisées
        $allowedExtensions = ['xlsx', 'xls', 'csv'];

        if (in_array($fileExtension, $allowedExtensions)) {
            // Déplacer le fichier vers un répertoire cible
            $uploadDir = 'uploadStats/';

            $destinationPath = $uploadDir . uniqid() . '.' . $fileExtension;
            if (move_uploaded_file($fileTmpPath, $destinationPath)) {

                $spreadsheet = IOFactory::load($destinationPath);

                $data = $spreadsheet->getActiveSheet()->toArray();

                foreach ($data as $row) {
                    $code_nature = $row['0'];
                    $libelle_nature = $row['1'];
                    $prevision = (float) $row['2'];
                    $realisation = (float) $row['3'];

                    // verification
                    if ($code_nature === null && $libelle_nature === null) {
                        // Les deux sont NULL
                        $req = database()->prepare("SELECT * FROM dgi_nature_impot WHERE code_nature_impot IS NULL AND libelle_nature_impot IS NULL");
                        $req->execute();
                    } elseif ($code_nature === null) {
                        // Seulement code_nature_impot est NULL
                        $req = database()->prepare("SELECT * FROM dgi_nature_impot WHERE code_nature_impot IS NULL AND libelle_nature_impot = ?");
                        $req->execute([trim($libelle_nature)]);
                    } elseif ($libelle_nature === null) {
                        // Seulement libelle_nature_impot est NULL
                        $req = database()->prepare("SELECT * FROM dgi_nature_impot WHERE code_nature_impot = ? AND libelle_nature_impot IS NULL");
                        $req->execute([$code_nature]);
                    } else {
                        // Aucune valeur n'est NULL
                        $req = database()->prepare("SELECT * FROM dgi_nature_impot WHERE code_nature_impot = ? AND libelle_nature_impot = ?");
                        $req->execute([$code_nature, trim($libelle_nature)]);
                    }

                    if($req->rowCount() == 1){

                        $data = $req->fetch(PDO::FETCH_OBJ);
                        $id_type_nature_impot = $data->id_type_nature_impot;
                        $id_categorie_nature_impot = $data->id_categorie_nature_impot;
                        $id_ordre  = $data->id;

                        

                        $req = database()->prepare("INSERT INTO dgi_statistique (id_ordre,id_province,id_centre_perception,code_nature,libelle_nature_recette,id_type_nature_recette,id_categorie_nature_recette,id_mois,annee,prevision,realisation,date_ajout,id_etat_donnee) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");

                        $req->execute([$id_ordre,$id_province,$id_centre_perception,$code_nature,trim($libelle_nature),$id_type_nature_impot,$id_categorie_nature_impot,$mois,$annee,$prevision,$realisation,date('Y-m-d'),1]);
                    }

                    

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
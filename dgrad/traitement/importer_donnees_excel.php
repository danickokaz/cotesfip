<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';
require __DIR__ . '../../../vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\IOFactory;


if(isset($_SESSION['jlk']) and !empty($_SESSION['jlk'])){
    $session = htmlspecialchars($_SESSION['jlk']);
  
    $req = database()->prepare("SELECT 
  dgrad_utilisateur.token_utilisateur,
  dgrad_utilisateur.pseudo,
  dgrad_utilisateur.id,
  dgrad_utilisateur.id_role,
  dgrad_utilisateur.id_province,
  dgrad_utilisateur.id_service_pourvoyeur,
  service_pourvoyeur.abreviation as service_utilisateur,
  role_utilisateur.libelle_role as role_utilisateur,
  province.libelle_province as libelle_province
  FROM dgrad_utilisateur 
  INNER JOIN service_pourvoyeur ON dgrad_utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
  INNER JOIN role_utilisateur ON dgrad_utilisateur.id_role = role_utilisateur.id
  LEFT JOIN province ON  province.id = dgrad_utilisateur.id_province
  WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
      $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);
  
      $pseudo = $donneesUtilisateur->pseudo;
        $service_utilisateur  = $donneesUtilisateur->service_utilisateur;
        $role_utilisateur = $donneesUtilisateur->role_utilisateur;
        $id_role = $donneesUtilisateur->id_role;
        $id_province = $donneesUtilisateur->id_province;
        $id_service_pourvoyeur = $donneesUtilisateur->id_service_pourvoyeur;

        $libelle_province  = $donneesUtilisateur->libelle_province;

          // Vérifier si le fichier est bien envoyé
    if (isset($_FILES['fichierExcelDonnees'],$_POST['mois'],$_POST['annee'],$_POST['services']) && $_FILES['fichierExcelDonnees']['error'] === 0  && !empty($_POST['mois']) and !empty($_POST['annee']) && !empty($_POST['services'])) {
        $fileName = $_FILES['fichierExcelDonnees']['name'];
        $fileTmpPath = $_FILES['fichierExcelDonnees']['tmp_name'];
        $fileSize = $_FILES['fichierExcelDonnees']['size'];
        $fileType = $_FILES['fichierExcelDonnees']['type'];
        $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));

        $mois = htmlspecialchars($_POST['mois']);
        $annee = htmlspecialchars($_POST['annee']);
        $services = htmlspecialchars($_POST['services']);

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
                    $code_acte = $row['0'];
                    $libelle_acte = $row['1'];
                    $prevision = (float) $row['2'];
                    $realisation = (float) $row['3'];

                    // verification
                    if ($code_acte === null && $libelle_acte === null) {
                        // Les deux sont NULL
                        $req = database()->prepare(" SELECT * FROM dgrad_acte_generateur 
                            WHERE (code_acte IS NULL AND libelle_acte_generateur IS NULL) 
                            AND (id_service_assiette IS NULL OR id_service_assiette = ?)
                        ");
                        $req->execute([$services]);
                    } elseif ($code_acte === null) {
                        // Seulement code_acte est NULL
                        $req = database()->prepare("SELECT * FROM dgrad_acte_generateur 
                            WHERE (code_acte IS NULL AND libelle_acte_generateur = ?) 
                            AND (id_service_assiette IS NULL OR id_service_assiette = ?)
                        ");
                        $req->execute([trim($libelle_acte), $services]);
                    } elseif ($libelle_acte === null) {
                        // Seulement libelle_acte est NULL
                        $req = database()->prepare("SELECT * FROM dgrad_acte_generateur 
                            WHERE (code_acte = ? AND libelle_acte_generateur IS NULL) 
                            AND (id_service_assiette IS NULL OR id_service_assiette = ?)
                        ");
                        $req->execute([$code_acte, $services]);
                    } else {
                        // Aucune valeur n'est NULL
                        $req = database()->prepare("SELECT * FROM dgrad_acte_generateur 
                            WHERE (code_acte = ? AND libelle_acte_generateur = ?) 
                            AND (id_service_assiette IS NULL OR id_service_assiette = ?)
                        ");
                        $req->execute([$code_acte, trim($libelle_acte), $services]);
                    }
                    

                    if($req->rowCount() == 1){

                        $data = $req->fetch(PDO::FETCH_OBJ);
                        $categorie_acte_generateur = $data->categorie_acte_generateur;
                        $id_service_assiette = $data->id_service_assiette;
                        $id_categorie_recette  = $data->id_categorie_recette;
                        $id_type_recette = $data->id_type_recette;
                        $id_ordre  = $data->id;

                        

                        $req = database()->prepare("INSERT INTO dgrad_statistique (
                        id_ordre,
                        id_type_recette,
                        id_categorie_recette,
                        id_service_assiette,
                        id_categorie_acte,
                        id_province,
                        code_acte,
                        libelle_acte,
                        prevision,
                        realisation,
                        id_etat_donnee,
                        mois,
                        annee)
                        VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");

                        $req->execute([
                        $id_ordre,
                        $id_type_recette,
                        $id_categorie_recette,
                        $services,
                        $categorie_acte_generateur,
                        $id_province,
                        $code_acte,
                        $libelle_acte,
                        $prevision,
                        $realisation,
                        1,
                    $mois,
                $annee]);
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
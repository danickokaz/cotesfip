<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';
require __DIR__ . '../../../vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\IOFactory;

    // Vérifier si le fichier est bien envoyé
    if (isset($_FILES['fichier']) && $_FILES['fichier']['error'] === 0) {
        $fileName = $_FILES['fichier']['name'];
        $fileTmpPath = $_FILES['fichier']['tmp_name'];
        $fileSize = $_FILES['fichier']['size'];
        $fileType = $_FILES['fichier']['type'];
        $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
        // Extensions autorisées
        $allowedExtensions = ['xlsx', 'xls', 'csv'];

        
        if(isset($_POST['exercice']) and !empty($_POST['exercice'])){
            $exercice = htmlspecialchars($_POST['exercice']);

            if (in_array($fileExtension, $allowedExtensions)) {
                // Déplacer le fichier vers un répertoire cible
                $uploadDir = 'upload/';
    
                $destinationPath = $uploadDir . uniqid() . '.' . $fileExtension;
                if (move_uploaded_file($fileTmpPath, $destinationPath)) {
    
                    $spreadsheet = IOFactory::load($destinationPath);
    
                    $data = $spreadsheet->getActiveSheet()->toArray();
    
                    foreach ($data as $row) {
                        $code = $row['0'];
                        $libelle = $row['1'];
    
                        // $req = database()->prepare("SELECT * FROM dgrad_acte_generateur WHERE libelle_acte_generateur=? AND code_acte=?");
                        // $req->execute([$libelle,$code]);
    
                        // if($req->rowCount() == 0) {
                            $req = database()->prepare("INSERT INTO dgrad_categorie_acte_generateur (code_categorie_acte,libelle_categorie_acte,exercice) VALUES(?,?,?)");
                            $req->execute([$code,$libelle,$exercice]);
                        // }
    
    
                        
    
                    }
                    echo "Success";
    
    
    
    
    
    
                } else {
                    echo "Une erreur est survennue";
                }
            } else {
                echo "Type de fichier invalide";
            }
        }

            
        

        
    } else {
        echo "Veuillez  choisir un fichier";
    }


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

        if (in_array($fileExtension, $allowedExtensions)) {
            // Déplacer le fichier vers un répertoire cible
            $uploadDir = 'upload/';

            $destinationPath = $uploadDir . uniqid() . '.' . $fileExtension;
            if (move_uploaded_file($fileTmpPath, $destinationPath)) {

                $spreadsheet = IOFactory::load($destinationPath);

                $data = $spreadsheet->getActiveSheet()->toArray();

                foreach ($data as $row) {
                    $libelle_centre = $row['0'];

                    $req = database()->prepare("INSERT INTO dgi_centre_perception (libelle_centre) VALUES(?)");
                    $req->execute([$libelle_centre]);

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


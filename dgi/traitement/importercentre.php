<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Vérifier si le fichier est bien envoyé
    if (isset($_FILES['fichier']) && $_FILES['fichier']['error'] === 0) {
        $fileName = $_FILES['fichier']['name'];
        $fileTmpPath = $_FILES['fichier']['tmp_name'];
        $fileSize = $_FILES['fichier']['size'];
        $fileType = $_FILES['fichier']['type'];
        $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));

        // Extensions autorisées
        $allowedExtensions = ['xlsx', 'xls'];

        if (in_array($fileExtension, $allowedExtensions)) {
            // Déplacer le fichier vers un répertoire cible
            $uploadDir = 'upload/';
            // if (!is_dir($uploadDir)) {
            //     mkdir($uploadDir, 0777, true); // Créer le répertoire si inexistant
            // }

            $destinationPath = $uploadDir . uniqid() . '.' . $fileExtension;
if (move_uploaded_file($fileTmpPath, $destinationPath)) {
    $fullPath = __DIR__ . '/' . $destinationPath;

    // Vérifiez que le fichier existe après déplacement
    if (!file_exists($fullPath)) {
        die("Erreur : Le fichier n'a pas été correctement déplacé.");
    }

    require __DIR__ . '../../../excelReader/excel_reader2.php';
    require __DIR__ . '../../../excelReader/SpreadsheetReader.php';

    try {
        $reader = new SpreadsheetReader($fullPath);
        foreach ($reader as $key => $value) {
            $libelle_centre = $value[0];

            $req = database()->prepare("INSERT INTO dgi_centre_perception (libelle_centre) VALUES(?)");
            $req->execute([$libelle_centre]);
        }
        echo "Success";
    } catch (Exception $e) {
        echo "Erreur lors de la lecture du fichier Excel : " . $e->getMessage();
    }
} else {
    echo "Failed to move the uploaded file.";
}
        } else {
            echo "Invalid file type. Only Excel files are allowed.";
        }
    } else {
        echo "No file was uploaded or an error occurred.";
    }
} else {
    echo "Invalid request method.";
}

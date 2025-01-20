<?php
session_start();
require __DIR__ . '../../../settings/bdd.php';


    $ids = $_POST['ids'];
    $typeNature = empty($_POST['typeNature']) ? NULL: htmlspecialchars($_POST['typeNature']); // Sécurise l'entrée utilisateur
    $categorieNature = empty($_POST['categorieNature']) ? NULL: htmlspecialchars($_POST['categorieNature']); // Sécurise l'entrée utilisateur

    try {
        $req = database()->prepare("UPDATE dgda_nature_economique SET id_type_nature_economique = ?, id_categorie_nature_economique = ? WHERE id = ?");

        foreach ($ids as $id) {
            
            $req->execute([$typeNature,$categorieNature,$id]);
        }

        echo json_encode([
            'status' => 'success',
            'message' => 'Centres mis à jour avec succès.'
        ]);
    } catch (Exception $e) {
        echo json_encode([
            'status' => 'error',
            'message' => 'Erreur lors de la mise à jour : ' . $e->getMessage()
        ]);
    }

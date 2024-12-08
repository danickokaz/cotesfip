<?php
session_start();
require __DIR__ . '../../../settings/bdd.php';

if (isset($_POST['province'], $_POST['ids']) && !empty($_POST['province']) && !empty($_POST['ids'])) {
    $ids = $_POST['ids'];
    $province = htmlspecialchars($_POST['province']); // Sécurise l'entrée utilisateur

    try {
        $req = database()->prepare("UPDATE dgi_centre_perception SET id_province = ? WHERE id = ?");

        foreach ($ids as $id) {
            $req->execute([$province, $id]);
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
} else {
    echo json_encode([
        'status' => 'error',
        'message' => 'Données manquantes ou invalides.'
    ]);
}

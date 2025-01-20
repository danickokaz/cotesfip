<?php
session_start();
require __DIR__ . '../../../settings/bdd.php';

if (isset($_POST['typeSecteur'],$_POST['categorieSecteur'], $_POST['ids'],$_POST['secteur']) && !empty($_POST['typeSecteur']) && !empty($_POST['ids'])
and !empty($_POST['categorieSecteur']) and !empty($_POST['secteur'])) {
    $ids = $_POST['ids'];
    $typeSecteur = htmlspecialchars($_POST['typeSecteur']); // Sécurise l'entrée utilisateur
    $categorieSecteur = htmlspecialchars($_POST['categorieSecteur']); // Sécurise l'entrée utilisateur
    $secteur = htmlspecialchars($_POST['secteur']); // Sécurise l'entrée utilisateur

    try {
        $req = database()->prepare("UPDATE dgda_nature_economique SET id_type_secteur_activite = ?, id_categorie_secteur_activite = ?, id_secteur_activite=? WHERE id = ?");

        foreach ($ids as $id) {
            $req->execute([$typeSecteur,$categorieSecteur,$secteur,$id]);
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
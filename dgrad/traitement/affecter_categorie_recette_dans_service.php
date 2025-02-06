<?php
session_start();
require __DIR__ . '../../../settings/bdd.php';

if (isset($_POST['categorie'], $_POST['ids']) && !empty($_POST['categorie']) && !empty($_POST['ids'])) {
    $ids = $_POST['ids'];
    $categorie = htmlspecialchars($_POST['categorie']); // Sécurise l'entrée utilisateur

    $req  = database()->prepare("SELECT id_type_recette FROM dgrad_categorie_recette WHERE id=?");
    $req->execute([$categorie]);

    if($req->rowCount()>0){
        $donnees = $req->fetch(PDO::FETCH_OBJ);
        $type_recette = $donnees->id_type_recette;

        try {
            $req = database()->prepare("UPDATE dgrad_servives_assiettes SET id_type_recette = ?, id_categorie_recette=? WHERE id = ?");
    
            foreach ($ids as $id) {
                $req->execute([$type_recette,$categorie, $id]);
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
        
    }

    
} else {
    echo json_encode([
        'status' => 'error',
        'message' => 'Données manquantes ou invalides.'
    ]);
}

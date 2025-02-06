<?php
session_start();
require __DIR__ . '../../../settings/bdd.php';

if (isset($_POST['service'],$_POST['exercice'],$_POST['ids']) && !empty($_POST['service']) && !empty($_POST['exercice']) && !empty($_POST['ids'])) {
    $ids = $_POST['ids'];
    $service = htmlspecialchars($_POST['service']); // Sécurise l'entrée utilisateur
    $exercice  = htmlspecialchars($_POST['exercice']); 

    

        try {
            $req = database()->prepare("UPDATE dgrad_categorie_acte_generateur SET id_service_assiette = ? WHERE id = ?");
    
            foreach ($ids as $id) {
                $req->execute([$service,$id]);
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

<?php
session_start();
require __DIR__ . '../../../settings/bdd.php';

if (isset($_POST['exercice'],$_POST['service'],$_POST['categorieActe'],$_POST['ids']) && !empty($_POST['exercice']) && !empty($_POST['service']) && !empty($_POST['categorieActe']) && !empty($_POST['ids'])) {
    $ids = $_POST['ids'];
    $service = htmlspecialchars($_POST['service']); // Sécurise l'entrée utilisateur
    $exercice  = htmlspecialchars($_POST['exercice']); 
    $categorieActe = htmlspecialchars($_POST['categorieActe']); // Sécurise l'entrée utilisateur


    //recupereatin des informations du service

    $req = database()->prepare("SELECT * FROM dgrad_servives_assiettes WHERE id=?");
    $req->execute([$service]);

    if($req->rowCount() > 0){
        $data = $req->fetch();
        $id_type_recette = $data['id_type_recette'];
        $id_categorie_recette = $data['id_categorie_recette'];

        try {
            $req = database()->prepare("UPDATE dgrad_acte_generateur SET categorie_acte_generateur=? , id_service_assiette=?, id_categorie_recette=?, id_type_recette=? WHERE id = ?");
    
            foreach ($ids as $id) {
                $req->execute([$categorieActe,$service,$id_categorie_recette,$id_type_recette,$id]);
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

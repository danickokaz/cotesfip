<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_POST['anneeSelection']) and !empty($_POST['anneeSelection'])){
    $anneeSelection = htmlspecialchars($_POST['anneeSelection']);


    // Récupération des données depuis la base
    $req = database()->prepare("SELECT 
    dgrad_servives_assiettes.id,
    dgrad_servives_assiettes.libelle_service,
    dgrad_servives_assiettes.code_service_assiette,
    dgrad_type_recette.libelle_type_recette,
    dgrad_categorie_recette.libelle_categorie_recette
    FROM dgrad_servives_assiettes
    LEFT JOIN dgrad_type_recette ON dgrad_type_recette.id = dgrad_servives_assiettes.id_type_recette
    LEFT JOIN dgrad_categorie_recette ON dgrad_categorie_recette.id = dgrad_servives_assiettes.id_categorie_recette
    
    WHERE dgrad_servives_assiettes.exercice = ?    ");
    $req->execute([$anneeSelection]);

    // Construction de la table HTML avec cases à cocher
    $output = '
        <table class="table table-striped">
            <thead>
                <th></th> <!-- Case pour tout sélectionner -->
                <th>N</th>
                <th>Code</th>
                <th>Libelle</th>
                <th>Catégorie</th>

            </thead>
            <tbody>';
    if ($req->rowCount() > 0) {
        $i = 1;
        while ($donnees = $req->fetch(PDO::FETCH_OBJ)) {
            $output .= '
                <tr>
                    <td><input type="checkbox" class="row-checkbox" value="' . $donnees->id . '"></td>
                    <td>' . $i . '</td>
                    <td>' . $donnees->code_service_assiette . '</td>
                    <td>' . $donnees->libelle_service . '</td>
                    <td>' . $donnees->libelle_categorie_recette . '</td>


                </tr>';
            $i++;
        }
        $output .= '
            </tbody>
            </table>';
        echo $output;
    } else {
        $output .= '
            <tr>
                <td colspan="5" align="center">Aucun service trouvé</td>
            </tr>
            </tbody>
            </table>';
        echo $output;
    }

}


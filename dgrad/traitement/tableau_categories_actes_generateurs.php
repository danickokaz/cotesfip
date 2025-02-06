<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

    if(isset($_POST['anneeSelection']) and !empty($_POST['anneeSelection'])){
        $anneeSelection = htmlspecialchars($_POST['anneeSelection']);

        // Récupération des données depuis la base
    $req = database()->prepare("SELECT 
    dgrad_categorie_acte_generateur.id,
    dgrad_categorie_acte_generateur.code_categorie_acte,
    dgrad_categorie_acte_generateur.libelle_categorie_acte,
    dgrad_servives_assiettes.libelle_service
    FROM dgrad_categorie_acte_generateur
    LEFT JOIN dgrad_servives_assiettes ON dgrad_servives_assiettes.id = dgrad_categorie_acte_generateur.id_service_assiette
    WHERE dgrad_categorie_acte_generateur.exercice=?
       ");
    $req->execute([$anneeSelection]);

    // Construction de la table HTML avec cases à cocher
    $output = '
        <table class="table table-striped">
            <thead>
                <th></th> <!-- Case pour tout sélectionner -->
                <th>N</th>
                <th>Code</th>
                <th>Libelle</th>
                <th>Service</th>

            </thead>
            <tbody>';
    if ($req->rowCount() > 0) {
        $i = 1;
        while ($donnees = $req->fetch(PDO::FETCH_OBJ)) {
            $output .= '
                <tr>
                    <td><input type="checkbox" class="row-checkbox" value="' . $donnees->id . '"></td>
                    <td>' . $i . '</td>
                    <td>' . $donnees->code_categorie_acte . '</td>
                    <td>' . $donnees->libelle_categorie_acte . '</td>
                    <td>' . $donnees->libelle_service . '</td>


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
                <td colspan="4" align="center">Aucune categorie  d\'acte generateur trouvee</td>
            </tr>
            </tbody>
            </table>';
        echo $output;
    }

    }

    




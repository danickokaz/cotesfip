<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

// Récupération des données depuis la base
$req = database()->prepare("SELECT 
dgda_nature_economique.id,
dgda_nature_economique.libelle_nature_economique,
dgda_nature_economique.code_nature_economique,
dgda_type_secteur_activite.libelle_type_secteur,
dgda_categorie_secteur_actvite.libelle_categorie_secteur,
dgda_secteur_activite.libelle_secteur,
dgda_type_nature_economique.libelle_type_nature_economique,
dgda_categorie_nature_economique.libelle_nature_economique AS categorie_nature_economique
FROM dgda_nature_economique
LEFT JOIN dgda_type_secteur_activite ON dgda_nature_economique.id_type_secteur_activite = dgda_type_secteur_activite.id
LEFT JOIN dgda_categorie_secteur_actvite ON dgda_nature_economique.id_categorie_secteur_activite = dgda_categorie_secteur_actvite.id
LEFT JOIN dgda_secteur_activite ON dgda_nature_economique.id_secteur_activite = dgda_secteur_activite.id
LEFT JOIN dgda_type_nature_economique ON dgda_nature_economique.id_type_nature_economique = dgda_type_nature_economique.id
LEFT JOIN dgda_categorie_nature_economique ON dgda_nature_economique.id_categorie_nature_economique = dgda_categorie_nature_economique.id
");
$req->execute();

// Construction de la table HTML avec cases à cocher
$output = '
    <table class="table table-striped">
        <thead>
            <th></th> <!-- Case pour tout sélectionner -->
            <th>N</th>
            <th>Code</th>
            <th>Libelle</th>
            <th>Type</th>
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
                <td>' . $donnees->code_nature_economique . '</td>
                <td>' . $donnees->libelle_nature_economique . '</td>
                <td>' . $donnees->libelle_type_nature_economique . '</td>
                <td>' . $donnees->categorie_nature_economique . '</td>


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
            <td colspan="3" align="center">Aucun centre de perception trouvé</td>
        </tr>
        </tbody>
        </table>';
    echo $output;
}

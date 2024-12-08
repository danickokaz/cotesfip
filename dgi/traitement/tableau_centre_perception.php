<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';

// Récupération des données depuis la base
$req = database()->prepare("SELECT 
dgi_centre_perception.id,
dgi_centre_perception.libelle_centre,
province.libelle_province
FROM dgi_centre_perception
LEFT JOIN province ON dgi_centre_perception.id_province = province.id");
$req->execute();

// Construction de la table HTML avec cases à cocher
$output = '
    <table class="table table-striped">
        <thead>
            <th></th> <!-- Case pour tout sélectionner -->
            <th>N</th>
            <th>Libelle</th>
            <th>Province</th>
        </thead>
        <tbody>';
if ($req->rowCount() > 0) {
    $i = 1;
    while ($donnees = $req->fetch(PDO::FETCH_OBJ)) {
        $output .= '
            <tr>
                <td><input type="checkbox" class="row-checkbox" value="' . $donnees->id . '"></td>
                <td>' . $i . '</td>
                <td>' . $donnees->libelle_centre . '</td>
                <td>' . $donnees->libelle_province . '</td>
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

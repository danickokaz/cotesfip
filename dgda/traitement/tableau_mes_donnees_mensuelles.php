<?php 
session_start();
require __DIR__ . '../../../settings/bdd.php';
require __DIR__ . '../../../vendor/autoload.php';

if (isset($_SESSION['access']) && !empty($_SESSION['access'])) {
    $session = htmlspecialchars($_SESSION['access']);
  
    $req = database()->prepare("
        SELECT 
            dgda_utilisateur.token_utilisateur,
            dgda_utilisateur.pseudo,
            dgda_utilisateur.id,
            dgda_utilisateur.id_service_pourvoyeur,
            dgda_utilisateur.id_role,
            dgda_utilisateur.id_province,
            dgda_utilisateur.id_centre_perception,
            service_pourvoyeur.abreviation as service_utilisateur,
            role_utilisateur.libelle_role as role_utilisateur
        FROM dgda_utilisateur 
        INNER JOIN service_pourvoyeur ON dgda_utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
        INNER JOIN role_utilisateur ON dgda_utilisateur.id_role = role_utilisateur.id
        WHERE dgda_utilisateur.token_utilisateur = ?
    ");
    $req->execute([$session]);
  
    if ($req->rowCount() === 1) {
        $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);
  
        $pseudo = $donneesUtilisateur->pseudo;
        $service_utilisateur = $donneesUtilisateur->service_utilisateur;
        $role_utilisateur = $donneesUtilisateur->role_utilisateur;
        $id_service_pourvoyeur = $donneesUtilisateur->id_service_pourvoyeur;
        $id_province = $donneesUtilisateur->id_province;
        $id_centre_perception = $donneesUtilisateur->id_centre_perception;

        if (isset($_POST['moisVoirDonnees'], $_POST['anneeVoirDonnees']) && !empty($_POST['moisVoirDonnees']) && !empty($_POST['anneeVoirDonnees'])) {
            $mois = htmlspecialchars($_POST['moisVoirDonnees']);
            $annee = htmlspecialchars($_POST['anneeVoirDonnees']);

            function afficherTableau($centrePerception, $prvovince,$mois, $annee) {
                $bdd = database();

                // Requête pour récupérer les données structurées
                $sql = "
                    SELECT 
                        tn.libelle_type_nature_economique AS type_recette,
                        cn.libelle_nature_economique AS categorie_recette,
                        s.code_nature,
                        s.libelle_nature_economique,
                        s.prevision,
                        s.realisation
                    FROM dgda_statistique s
                    LEFT JOIN dgda_type_nature_economique tn ON s.id_type_nature_economique = tn.id
                    LEFT JOIN dgda_categorie_nature_economique cn ON s.id_categorie_nature_economique = cn.id
                    WHERE s.id_centre_perception = ? AND s.id_province=? AND s.id_mois = ? AND s.annee = ?
                    ORDER BY 
                        
                        s.id_ordre ASC
                ";

                $stmt = $bdd->prepare($sql);
                $stmt->execute([$centrePerception, $prvovince ,$mois, $annee]);
                $resultats = $stmt->fetchAll(PDO::FETCH_ASSOC);

                // Génération du tableau HTML
                echo "<table border='1'>";
                echo "<thead><tr><th>Code</th><th>Nature de Recette</th><th>Prévision</th><th>Réalisation</th>Taux de realisation</th></tr></thead><tbody>";

                $typeCourant = null;
                $categorieCourante = null;

                foreach ($resultats as $row) {
                    // Cas 1 : Nature de recette avec un type
                    if ($row['type_recette'] !== $typeCourant) {
                        $typeCourant = $row['type_recette'];
                        $categorieCourante = null; // Réinitialiser la catégorie

                        echo "<tr><td colspan='5' style='background-color: #f0f0f0;'><strong>" . ($typeCourant ?? "") . "</strong></td></tr>";
                    }

                    // Cas 2 : Nature de recette avec une catégorie
                    if ($row['categorie_recette'] !== $categorieCourante) {
                        $categorieCourante = $row['categorie_recette'];

                        if ($categorieCourante !== null) {
                            echo "<tr><td colspan='5' style='background-color: #e0e0e0; padding-left: 20px;'><strong>" . $categorieCourante . "</strong></td></tr>";
                        }
                    }

                    // Cas 3 : Nature de recette sans type ni catégorie
                    if ($row['type_recette'] === null && $row['categorie_recette'] === null) {
                        echo "<tr><td colspan='5' style='background-color: #d0d0d0;'></strong></td></tr>";
                    }

                    // Affichage des natures de recettes
                    echo "<tr>";
                    echo "<td>" . $row['code_nature'] . "</td>";
                    echo "<td>" . $row['libelle_nature_economique'] . "</td>";
                    echo "<td>" . $row['prevision'] . "</td>";
                    echo "<td>" . $row['realisation'] . "</td>";

                    // Conversion des valeurs en nombres pour le calcul
                    $prevision = floatval($row['prevision']);
                    $realisation = floatval($row['realisation']);

                    // Validation pour éviter la division par zéro
                    if ($prevision > 0) {
                        $taux_realisation = ($realisation / $prevision) * 100;
                        echo "<td>" . number_format($taux_realisation, 2) . " %</td>";
                    } else {
                        echo "<td> - </td>"; // Ou une autre indication pour zéro ou non applicable
                    }

                    echo "</tr>";

                }

                echo "</tbody></table>";
            }

            afficherTableau($id_centre_perception, $id_province,$mois, $annee);
        }
    }
}
?>
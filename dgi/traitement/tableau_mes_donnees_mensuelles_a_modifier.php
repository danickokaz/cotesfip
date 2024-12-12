<?php 
session_start();
require __DIR__ . '../../../settings/bdd.php';
require __DIR__ . '../../../vendor/autoload.php';

if (isset($_SESSION['visa']) && !empty($_SESSION['visa'])) {
    $session = htmlspecialchars($_SESSION['visa']);
  
    $req = database()->prepare("
        SELECT 
            utilisateur.token_utilisateur,
            utilisateur.pseudo,
            utilisateur.id,
            utilisateur.id_service_pourvoyeur,
            utilisateur.id_role,
            utilisateur.id_province,
            utilisateur.id_centre_perception,
            service_pourvoyeur.abreviation as service_utilisateur,
            role_utilisateur.libelle_role as role_utilisateur
        FROM utilisateur 
        INNER JOIN service_pourvoyeur ON utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
        INNER JOIN role_utilisateur ON utilisateur.id_role = role_utilisateur.id
        WHERE token_utilisateur = ?
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

            function afficherTableau($centrePerception, $mois, $annee) {
                $bdd = database();

                // Requête pour récupérer les données structurées
                $sql = "
                    SELECT 
                        tn.libelle_nature_impot AS type_recette,
                        cn.libelle_categorie_nature_impot AS categorie_recette,
                        s.id,
                        mois.libelle_mois,
                        s.id_etat_donnee,
                        s.code_nature,
                        s.libelle_nature_recette,
                        s.prevision,
                        s.realisation
                    FROM dgi_statistique s
                    LEFT JOIN dgi_type_nature_impot tn ON s.id_type_nature_recette = tn.id
                    LEFT JOIN dgi_categorie_nature_impot cn ON s.id_categorie_nature_recette = cn.id
                    INNER JOIN mois ON mois.id = s.id_mois
                    WHERE s.id_centre_perception = ? AND s.id_mois = ? AND s.annee = ?
                    ORDER BY 
                        tn.libelle_nature_impot IS NULL, tn.libelle_nature_impot ASC,
                        cn.libelle_categorie_nature_impot IS NULL, cn.libelle_categorie_nature_impot DESC,
                        s.id_ordre ASC
                ";

                $stmt = $bdd->prepare($sql);
                $stmt->execute([$centrePerception, $mois, $annee]);
                $resultats = $stmt->fetchAll(PDO::FETCH_ASSOC);
                $moisEnLettres = $mois == "1" ? "JANVIER" :
                 ($mois == "2" ? "FEVRIER" :
                 ($mois == "3" ? "MARS" :
                 ($mois == "4" ? "AVRIL" :
                 ($mois == "5" ? "MAI" :
                 ($mois == "6" ? "JUIN" :
                 ($mois == "7" ? "JUILLET" :
                 ($mois == "8" ? "AOUT" :
                 ($mois == "9" ? "SEPTEMBRE" :
                 ($mois == "10" ? "OCTOBRE" :
                 ($mois == "11" ? "NOVEMBRE" :
                 ($mois == "12" ? "DECEMBRE" : "Mois invalide")))))))))));

                // Génération du tableau HTML
                echo "<h3>MES DONNES DU MOIS DE {$moisEnLettres} DE L'ANNEE {$annee}</h3>";
                echo "<table border='1'>";
                echo "<thead><tr><th>N</th><th>Code</th><th>Nature de Recette</th><th>Prévision</th><th>Réalisation</th><th>Action</th></tr></thead><tbody>";

                $typeCourant = null;
                $categorieCourante = null;
                $numero  = 1;

                foreach ($resultats as $row) {
                    // Cas 1 : Nature de recette avec un type
                    if ($row['type_recette'] !== $typeCourant) {
                        $typeCourant = $row['type_recette'];
                        $categorieCourante = null; // Réinitialiser la catégorie

                        echo "<tr><td colspan='6' style='background-color: #f0f0f0;'><strong>" . ($typeCourant ?? "") . "</strong></td></tr>";
                    }

                    // Cas 2 : Nature de recette avec une catégorie
                    if ($row['categorie_recette'] !== $categorieCourante) {
                        $categorieCourante = $row['categorie_recette'];

                        if ($categorieCourante !== null) {
                            echo "<tr><td colspan='6' style='background-color: #e0e0e0; padding-left: 20px;'><strong>" . $categorieCourante . "</strong></td></tr>";
                        }
                    }

                    // Cas 3 : Nature de recette sans type ni catégorie
                    if ($row['type_recette'] === null && $row['categorie_recette'] === null) {
                        echo "<tr><td colspan='6' style='background-color: #d0d0d0;'></strong></td></tr>";
                    }

                    if($row['id_etat_donnee'] == 1){
                        // Affichage des natures de recettes

                        // Affichage des natures de recettes
                        echo "<tr>";
                        echo "<td>" . $row['code_nature'] . "</td>";
                        echo "<td>" . $row['libelle_nature_recette'] . "</td>";
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
                        echo '<td style="text-align:center;cursor:pointer;"><i class="fa fa-edit btnModifierMesDonnees" id="'.$row['id'].'" ></i></td>';
                        echo "</tr>";

                        
                    }else{
                        
                        echo "<tr>";
                        echo "<td>" . $row['code_nature'] . "</td>";
                        echo "<td>" . $row['libelle_nature_recette'] . "</td>";
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
                        echo '<td style="text-align:center;cursor:pointer;"></td>';
                        echo "</tr>";
                        
                    }

                    
                }

                echo "</tbody></table>";
            }

            afficherTableau($id_centre_perception, $mois, $annee);
        }
    }
}
?>

<?php 
session_start();
require __DIR__ . '../../../settings/bdd.php';
require __DIR__ . '../../../vendor/autoload.php';

if (isset($_SESSION['jlk']) && !empty($_SESSION['jlk'])) {
    $session = htmlspecialchars($_SESSION['jlk']);
  
    $req = database()->prepare("SELECT 
        dgrad_utilisateur.token_utilisateur,
        dgrad_utilisateur.pseudo,
        dgrad_utilisateur.id,
        dgrad_utilisateur.id_role,
        dgrad_utilisateur.id_province,
        dgrad_utilisateur.id_service_pourvoyeur,
        service_pourvoyeur.abreviation as service_utilisateur,
        role_utilisateur.libelle_role as role_utilisateur,
        province.libelle_province as libelle_province
        FROM dgrad_utilisateur 
        INNER JOIN service_pourvoyeur ON dgrad_utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
        INNER JOIN role_utilisateur ON dgrad_utilisateur.id_role = role_utilisateur.id
        LEFT JOIN province ON  province.id = dgrad_utilisateur.id_province
        WHERE token_utilisateur=?
    ");
    $req->execute([$session]);
  
    if ($req->rowCount() === 1) {
        $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);
  
        $pseudo = $donneesUtilisateur->pseudo;
        $service_utilisateur  = $donneesUtilisateur->service_utilisateur;
        $role_utilisateur = $donneesUtilisateur->role_utilisateur;
        $id_role = $donneesUtilisateur->id_role;
        $id_province_utilisateur = $donneesUtilisateur->id_province;
        $id_service_pourvoyeur = $donneesUtilisateur->id_service_pourvoyeur;

        $libelle_province  = $donneesUtilisateur->libelle_province;
        

        if (isset($_POST['moisVoirDonnees'], $_POST['anneeVoirDonnees'],$_POST['servicesM']) && !empty($_POST['moisVoirDonnees']) && !empty($_POST['anneeVoirDonnees']) && !empty($_POST['servicesM'])) {
            $mois = htmlspecialchars($_POST['moisVoirDonnees']);
            $annee = htmlspecialchars($_POST['anneeVoirDonnees']);
            $services = htmlspecialchars($_POST['servicesM']);


            function afficherTableau($services,$id_province_utilisateur, $mois, $annee) {
                $bdd = database();

                // Requête pour récupérer les données structurées
                $sql = "
                     SELECT 
                        s.id,
                        ca.libelle_categorie_acte AS categorie_acte,
                        s.code_acte,
                        s.id_ordre,
                        s.libelle_acte,
                        s.prevision,
                        s.realisation,
                        s.id_etat_donnee
                    FROM dgrad_statistique s
                    LEFT JOIN dgrad_categorie_acte_generateur ca ON s.id_categorie_acte = ca.id
                    WHERE s.id_service_assiette = ? AND s.id_province=? AND s.mois = ? AND s.annee = ?
                    ORDER BY 
                        
                        s.id_ordre ASC
                ";

                $stmt = $bdd->prepare($sql);
                $stmt->execute([$services,$id_province_utilisateur, $mois, $annee]);
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
                echo "<table border='1' width='100%'>";
                echo "<thead><tr><th>Code</th><th>Acte generateur</th><th>Prévision</th><th>Réalisation</th><th>Taux realisation</th><th>Action</th></tr></thead><tbody>";

                // $typeCourant = null;
                $categorieCourante = null;
                $numero  = 1;

                foreach ($resultats as $row) {
                    // Cas 1 : Nature de recette avec un type
                    // if ($row['type_recette'] !== $typeCourant) {
                    //     $typeCourant = $row['type_recette'];
                    //     $categorieCourante = null; // Réinitialiser la catégorie

                    //     echo "<tr><td colspan='6' style='background-color: #f0f0f0;'><strong>" . ($typeCourant ?? "") . "</strong></td></tr>";
                    // }

                    // Cas 2 : Nature de recette avec une catégorie
                    if ($row['categorie_acte'] !== $categorieCourante) {
                        $categorieCourante = $row['categorie_acte'];

                        if ($categorieCourante !== null) {
                            echo "<tr><td colspan='6' style='background-color: #e0e0e0; padding-left: 20px;'><strong>" . $categorieCourante . "</strong></td></tr>";
                        }
                    }

                    // Cas 3 : Nature de recette sans type ni catégorie
                    if ($row['categorie_acte'] === null) {
                        echo "<tr><td colspan='6' style='background-color: #d0d0d0;'></strong></td></tr>";
                    }

                    if($row['id_etat_donnee'] == 1){
                        // Affichage des natures de recettes

                        // Affichage des natures de recettes
                        echo "<tr>";
                        echo "<td>" . $row['code_acte'] . "</td>";
                        echo "<td>" . $row['libelle_acte'] . "</td>";
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
                        echo "<td>" . $row['code_acte'] . "</td>";
                        echo "<td>" . $row['libelle_acte'] . "</td>";
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

            afficherTableau($services,$id_province_utilisateur, $mois, $annee);
        }
    }
}
?>
<?php
session_start();
require __DIR__.'../../settings/bdd.php';
if (isset($_SESSION['access']) and !empty($_SESSION['access'])) {
    $session = htmlspecialchars($_SESSION['access']);

    $req = database()->prepare("
        SELECT 
            dgda_utilisateur.token_utilisateur,
            dgda_utilisateur.pseudo,
            dgda_utilisateur.id,
            dgda_utilisateur.id_role,
            dgda_utilisateur.id_service_pourvoyeur,
            service_pourvoyeur.abreviation as service_utilisateur,
            role_utilisateur.libelle_role as role_utilisateur,
            dgda_centre_perception.libelle_centre_perception as centre_perception
        FROM dgda_utilisateur 
        INNER JOIN service_pourvoyeur ON dgda_utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
        INNER JOIN role_utilisateur ON dgda_utilisateur.id_role = role_utilisateur.id
        LEFT JOIN dgda_centre_perception ON dgda_centre_perception.id = dgda_utilisateur.id_centre_perception
        WHERE token_utilisateur = ?");
    $req->execute([$session]);

    if ($req->rowCount() == 1) {
        $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);
        $pseudo = $donneesUtilisateur->pseudo;
        $service_utilisateur = $donneesUtilisateur->service_utilisateur;
        $role_utilisateur = $donneesUtilisateur->role_utilisateur;
        $centre_perception = $donneesUtilisateur->centre_perception;

        if (isset($_GET['annee']) and !empty($_GET['annee'])) {
            $annee = htmlspecialchars($_GET['annee']);
            try {
                // Mois
                $mois_noms = [
                    1 => 'Janvier',
                    2 => 'Février',
                    3 => 'Mars',
                    4 => 'Avril',
                    5 => 'Mai',
                    6 => 'Juin',
                    7 => 'Juillet',
                    8 => 'Août',
                    9 => 'Septembre',
                    10 => 'Octobre',
                    11 => 'Novembre',
                    12 => 'Décembre'
                ];

                // Requête SQL pour obtenir les données par province et mois
                $sql = "
                    SELECT 
                        cp.libelle_centre_perception,
                        s.id_mois,
                        s.annee,
                        SUM(s.prevision) AS total_prevision,
                        SUM(s.realisation) AS total_realisation
                    FROM dgda_statistique s
                    JOIN dgda_centre_perception cp ON s.id_centre_perception = cp.id
                    WHERE s.annee = ? AND s.id_etat_donnee=?
                    GROUP BY cp.libelle_centre_perception, s.id_mois, s.annee
                    ORDER BY cp.libelle_centre_perception, s.id_mois;
                ";

                $stmt = database()->prepare($sql);
                $stmt->execute([$annee,3]);
                $resultats = $stmt->fetchAll(PDO::FETCH_ASSOC);

                // Organisation des données par province et mois
                $data_grouped = [];
                foreach ($resultats as $row) {
                    $province = $row['libelle_centre_perception'];
                    $mois = (int)$row['id_mois'];

                    if (!isset($data_grouped[$province])) {
                        $data_grouped[$province] = array_fill(1, 12, ['prevision' => 0, 'realisation' => 0]);
                    }

                    $data_grouped[$province][$mois]['prevision'] += $row['total_prevision'];
                    $data_grouped[$province][$mois]['realisation'] += $row['total_realisation'];
                }

                // Filtrage des provinces ayant des données
                $data_grouped = array_filter($data_grouped, function($province_data) {
                    // Ne garder que les provinces ayant des données non nulles
                    foreach ($province_data as $mois_data) {
                        if ($mois_data['prevision'] > 0 || $mois_data['realisation'] > 0) {
                            return true;
                        }
                    }
                    return false;
                });

                // Liste des provinces avec des données
                $provinces_with_data = array_keys($data_grouped);

            } catch (PDOException $e) {
                die("Erreur de connexion : " . $e->getMessage());
            }
        }
    } else {
        header("location: connexion");
    }
} else {
    header("location: connexion");
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau DGDA - Totaux par Province</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid mt-5">
        <h1 class="text-center mb-4">Tableau DGDA - Totaux par Province - <?= $annee ?></h1>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Province</th>
                    <?php foreach ($mois_noms as $mois): ?>
                        <th colspan="3" class="text-center"><?= $mois ?></th>
                    <?php endforeach; ?>
                    <th colspan="3" class="text-center">Cumul Annuel</th>
                </tr>
                <tr>
                    <th></th>
                    <?php foreach ($mois_noms as $mois): ?>
                        <th>Prévision</th>
                        <th>Réalisation</th>
                        <th>Taux de Réalisation</th>
                    <?php endforeach; ?>
                        <th>Prévision</th>
                        <th>Réalisation</th>
                        <th>Taux de Réalisation</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $totaux_generaux = array_fill(1, 12, ['prevision' => 0, 'realisation' => 0, 'taux' => 0]);
                foreach ($data_grouped as $province => $mois_data):
                    $cumul_prevision = 0;
                    $cumul_realisation = 0;
                    ?>
                    <tr>
                        <td><?= htmlspecialchars($province) ?></td>
                        <?php foreach ($mois_noms as $id => $mois):
                            // Si la donnée n'existe pas, on remplace par 0 ou un '-'
                            $prevision = $mois_data[$id]['prevision'] ?? 0;
                            $realisation = $mois_data[$id]['realisation'] ?? 0;
                            $taux = ($prevision > 0) ? ($realisation / $prevision) * 100 : '-';

                            // Cumul annuel
                            $cumul_prevision += $prevision;
                            $cumul_realisation += $realisation;

                            // Totaux généraux
                            $totaux_generaux[$id]['prevision'] += $prevision;
                            $totaux_generaux[$id]['realisation'] += $realisation;
                            $totaux_generaux[$id]['taux'] = ($totaux_generaux[$id]['prevision'] > 0) ? ($totaux_generaux[$id]['realisation'] / $totaux_generaux[$id]['prevision']) * 100 : 0;
                            ?>
                            <td class="text-end"><?= ($prevision == 0) ? '-' : number_format($prevision, 2, ',', '.') ?></td>
                            <td class="text-end"><?= ($realisation == 0) ? '-' : number_format($realisation, 2, ',', '.') ?></td>
                            <td class="text-end"><?= ($taux == '-') ? '-' : number_format($taux, 2, ',', '.') ?>%</td>
                        <?php endforeach; ?>
                        <td class="text-end">
                            <!-- Cumul Prévision / Réalisation / Taux -->
                            <?= number_format($cumul_prevision, 2, ',', '.') ?> 
                            
                        </td>
                        <td class="text-end">
                            <!-- Cumul Prévision / Réalisation / Taux -->
                            <?= number_format($cumul_realisation, 2, ',', '.') ?> 
                        </td>
                        <td class="text-end">
                            <!-- Cumul Prévision / Réalisation / Taux -->
                            
                            <?= ($cumul_prevision > 0) ? number_format(($cumul_realisation / $cumul_prevision) * 100, 2, ',', '.') : '-' ?>%
                        </td>
                    </tr>
                <?php endforeach; ?>
                <tr class="table-primary">
                    <td><strong>Total Général</strong></td>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <td class="text-end"><strong><?= number_format($totaux_generaux[$id]['prevision'], 2, ',', '.') ?></strong></td>
                        <td class="text-end"><strong><?= number_format($totaux_generaux[$id]['realisation'], 2, ',', '.') ?></strong></td>
                        <td class="text-end"><strong><?= number_format($totaux_generaux[$id]['taux'], 2, ',', '.') ?>%</strong></td>
                    <?php endforeach; ?>
                    <td class="text-end"><strong>
                        <?= number_format(array_sum(array_column($totaux_generaux, 'prevision')), 2, ',', '.') ?> 
                      
                    </strong></td>
                    <td class="text-end"><strong>
                        <?= number_format(array_sum(array_column($totaux_generaux, 'realisation')), 2, ',', '.') ?> 
                    </strong></td>
                    <td class="text-end"><strong>
                       
                        <?= number_format(($totaux_generaux[1]['prevision'] > 0) ? (array_sum(array_column($totaux_generaux, 'realisation')) / array_sum(array_column($totaux_generaux, 'prevision'))) * 100 : 0, 2, ',', '.') ?>%
                    </strong></td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>


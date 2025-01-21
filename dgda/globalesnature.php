<?php
session_start();
require __DIR__ . '../../settings/bdd.php';

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
        WHERE token_utilisateur = ?
    ");
    $req->execute([$session]);

    if ($req->rowCount() == 1) {
        $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);

        $pseudo = $donneesUtilisateur->pseudo;
        $service_utilisateur = $donneesUtilisateur->service_utilisateur;
        $role_utilisateur = $donneesUtilisateur->role_utilisateur;

        if (isset($_GET['annee']) and !empty($_GET['annee'])) {
            $annee = htmlspecialchars($_GET['annee']);

            try {
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

                $sql = "
                    SELECT 
                        s.id_ordre,
                        COALESCE(s.code_nature, '') AS code_nature,
                        COALESCE(s.libelle_nature_economique, '') AS nature_recette,
                        COALESCE(cni.libelle_nature_economique, '') AS categorie,
                        COALESCE(tni.libelle_type_nature_economique, '') AS type,
                        s.id_mois,
                        SUM(s.prevision) AS total_prevision,
                        SUM(s.realisation) AS total_realisation
                    FROM dgda_statistique s
                    LEFT JOIN dgda_categorie_nature_economique cni ON s.id_categorie_nature_economique = cni.id
                    LEFT JOIN dgda_type_nature_economique tni ON s.id_type_nature_economique = tni.id
                    WHERE s.annee = ?
                    GROUP BY s.id_mois, s.libelle_nature_economique, cni.libelle_nature_economique, tni.libelle_type_nature_economique
                    ORDER BY s.id_ordre, s.id_mois;
                ";

                $stmt = database()->prepare($sql);
                $stmt->execute([$annee]);
                $resultats = $stmt->fetchAll(PDO::FETCH_ASSOC);

                $data_grouped_by_type = [];
                foreach ($resultats as $row) {
                    $code = $row['code_nature'];
                    $nature_recette = $row['nature_recette'];
                    $categorie = $row['categorie'];
                    $type = $row['type'];
                    $prevision = (float) $row['total_prevision'];
                    $realisation = (float) $row['total_realisation'];

                    if (!isset($data_grouped_by_type[$type])) {
                        $data_grouped_by_type[$type] = [
                            'total_prevision' => array_fill(1, 12, 0),
                            'total_realisation' => array_fill(1, 12, 0),
                            'categories' => []
                        ];
                    }

                    if (!isset($data_grouped_by_type[$type]['categories'][$categorie])) {
                        $data_grouped_by_type[$type]['categories'][$categorie] = [
                            'total_prevision' => array_fill(1, 12, 0),
                            'total_realisation' => array_fill(1, 12, 0),
                            'nature_recettes' => []
                        ];
                    }

                    if (!isset($data_grouped_by_type[$type]['categories'][$categorie]['nature_recettes'][$code])) {
                        $data_grouped_by_type[$type]['categories'][$categorie]['nature_recettes'][$code] = [
                            'nature_recette' => $nature_recette,
                            'mois' => []
                        ];
                    }

                    $data_grouped_by_type[$type]['categories'][$categorie]['nature_recettes'][$code]['mois'][$row['id_mois']] = [
                        'prevision' => $prevision,
                        'realisation' => $realisation,
                        'taux' => $prevision > 0 ? ($realisation / $prevision) * 100 : 0
                    ];

                    $data_grouped_by_type[$type]['categories'][$categorie]['total_prevision'][$row['id_mois']] += $prevision;
                    $data_grouped_by_type[$type]['categories'][$categorie]['total_realisation'][$row['id_mois']] += $realisation;
                    $data_grouped_by_type[$type]['total_prevision'][$row['id_mois']] += $prevision;
                    $data_grouped_by_type[$type]['total_realisation'][$row['id_mois']] += $realisation;
                }

                // Initialisation des totaux globaux
                $totaux = [
                    'total_prevision_general' => array_fill(1, 12, 0),
                    'total_realisation_general' => array_fill(1, 12, 0)
                ];

                // Calcul des totaux globaux
                foreach ($data_grouped_by_type as $type => $type_data) {
                    foreach ($type_data['total_prevision'] as $id_mois => $prevision) {
                        $totaux['total_prevision_general'][$id_mois] += $prevision;
                    }
                    foreach ($type_data['total_realisation'] as $id_mois => $realisation) {
                        $totaux['total_realisation_general'][$id_mois] += $realisation;
                    }
                }
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
    <title>Tableau DGI - Prévisions et Réalisations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid mt-5">
        <h1 class="text-center mb-4">Tableau DGDA - Prévisions et Réalisations <?= $annee ?></h1>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th rowspan="2">Code Nature</th>
                    <th rowspan="2">Nature Recette</th>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <th colspan="3" class="text-center"><?= $mois ?></th>
                    <?php endforeach; ?>
                    <th colspan="3" class="text-center" style="background-color: green; color: white;">Cumul</th>

                    
                </tr>
                <tr>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <th>Prévision</th>
                        <th>Réalisation</th>
                        <th>Taux (%)</th>
                    <?php endforeach; ?>
                    <th>Prévision</th>
                    <th>Réalisation</th>
                    <th>Taux (%)</th>
                </tr>
            </thead>
            <tbody>
    <?php foreach ($data_grouped_by_type as $type => $type_data): ?>
        <!-- Ligne de type -->
        <tr class="table-secondary">
            <td colspan="2" align="center"><strong><?= htmlspecialchars($type ?: '') ?></strong></td>
            <?php 
            $cumul_prevision_type = 0;
            $cumul_realisation_type = 0;
            ?>
            <?php foreach ($mois_noms as $id => $mois): ?>
                <td class="text-center"><?= number_format($type_data['total_prevision'][$id], 2, ',', '.') ?></td>
                <td class="text-center"><?= number_format($type_data['total_realisation'][$id], 2, ',', '.') ?></td>
                <td class="text-center"><?= $type_data['total_prevision'][$id] > 0 
                    ? number_format(($type_data['total_realisation'][$id] / $type_data['total_prevision'][$id]) * 100, 2) 
                    : 0 ?></td>
                <?php 
                $cumul_prevision_type += $type_data['total_prevision'][$id];
                $cumul_realisation_type += $type_data['total_realisation'][$id];
                ?>
            <?php endforeach; ?>
            <!-- Colonne de cumul annuel -->
            <td class="text-center"><strong><?= number_format($cumul_prevision_type, 2, ',', '.') ?></strong></td>
            <td class="text-center"><strong><?= number_format($cumul_realisation_type, 2, ',', '.') ?></strong></td>
            <td class="text-center"><strong><?= $cumul_prevision_type > 0 
                ? number_format(($cumul_realisation_type / $cumul_prevision_type) * 100, 2) 
                : 0 ?></strong></td>
        </tr>

        <?php foreach ($type_data['categories'] as $categorie => $categorie_data): ?>
            <!-- Ligne de catégorie -->
            <tr class="table-info">
                <td colspan="2" align="center"><strong><?= htmlspecialchars($categorie) ?></strong></td>
                <?php 
                $cumul_prevision_categorie = 0;
                $cumul_realisation_categorie = 0;
                ?>
                <?php foreach ($mois_noms as $id => $mois): ?>
                    <td class="text-center"><?= number_format($categorie_data['total_prevision'][$id], 2, ',', '.') ?></td>
                    <td class="text-center"><?= number_format($categorie_data['total_realisation'][$id], 2, ',', '.') ?></td>
                    <td class="text-center"><?= $categorie_data['total_prevision'][$id] > 0 
                        ? number_format(($categorie_data['total_realisation'][$id] / $categorie_data['total_prevision'][$id]) * 100, 2) 
                        : 0 ?></td>
                    <?php 
                    $cumul_prevision_categorie += $categorie_data['total_prevision'][$id];
                    $cumul_realisation_categorie += $categorie_data['total_realisation'][$id];
                    ?>
                <?php endforeach; ?>
                <!-- Colonne de cumul annuel -->
                <td class="text-center"><strong><?= number_format($cumul_prevision_categorie, 2, ',', '.') ?></strong></td>
                <td class="text-center"><strong><?= number_format($cumul_realisation_categorie, 2, ',', '.') ?></strong></td>
                <td class="text-center"><strong><?= $cumul_prevision_categorie > 0 
                    ? number_format(($cumul_realisation_categorie / $cumul_prevision_categorie) * 100, 2) 
                    : 0 ?></strong></td>
            </tr>

            <?php foreach ($categorie_data['nature_recettes'] as $code => $details): ?>
                <!-- Ligne de nature recette -->
                <tr>
                    <td><?= htmlspecialchars($code ?: 'Non défini') ?></td>
                    <td><?= htmlspecialchars($details['nature_recette']) ?></td>
                    <?php 
                    $cumul_prevision_nature = 0;
                    $cumul_realisation_nature = 0;
                    ?>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <?php 
                        $prevision = isset($details['mois'][$id]) ? $details['mois'][$id]['prevision'] : 0;
                        $realisation = isset($details['mois'][$id]) ? $details['mois'][$id]['realisation'] : 0;
                        $taux = $prevision > 0 ? ($realisation / $prevision) * 100 : 0;
                        ?>
                        <td class="text-center"><?= number_format($prevision, 2, ',', '.') ?></td>
                        <td class="text-center"><?= number_format($realisation, 2, ',', '.') ?></td>
                        <td class="text-center"><?= number_format($taux, 2) ?></td>
                        <?php 
                        $cumul_prevision_nature += $prevision;
                        $cumul_realisation_nature += $realisation;
                        ?>
                    <?php endforeach; ?>
                    <!-- Colonne de cumul annuel -->
                    <td class="text-center"><strong><?= number_format($cumul_prevision_nature, 2, ',', '.') ?></strong></td>
                    <td class="text-center"><strong><?= number_format($cumul_realisation_nature, 2, ',', '.') ?></strong></td>
                    <td class="text-center"><strong><?= $cumul_prevision_nature > 0 
                        ? number_format(($cumul_realisation_nature / $cumul_prevision_nature) * 100, 2) 
                        : 0 ?></strong></td>
                </tr>
            <?php endforeach; ?>
        <?php endforeach; ?>
    <?php endforeach; ?>

    <!-- Ligne des totaux généraux -->
    <tr class="table-primary">
        <td colspan="2" align="center"><strong>Total</strong></td>
        <?php 
        $cumul_prevision_total = 0;
        $cumul_realisation_total = 0;
        ?>
        <?php foreach ($mois_noms as $id => $mois): ?>
            <td class="text-center"><?= number_format($totaux['total_prevision_general'][$id], 2, ',', '.') ?></td>
            <td class="text-center"><?= number_format($totaux['total_realisation_general'][$id], 2, ',', '.') ?></td>
            <td class="text-center"><?= $totaux['total_prevision_general'][$id] > 0 
                ? number_format(($totaux['total_realisation_general'][$id] / $totaux['total_prevision_general'][$id]) * 100, 2) 
                : 0 ?></td>
            <?php 
            $cumul_prevision_total += $totaux['total_prevision_general'][$id];
            $cumul_realisation_total += $totaux['total_realisation_general'][$id];
            ?>
        <?php endforeach; ?>
        <!-- Colonne de cumul annuel global -->
        <td class="text-center"><strong><?= number_format($cumul_prevision_total, 2, ',', '.') ?></strong></td>
        <td class="text-center"><strong><?= number_format($cumul_realisation_total, 2, ',', '.') ?></strong></td>
        <td class="text-center"><strong><?= $cumul_prevision_total > 0 
            ? number_format(($cumul_realisation_total / $cumul_prevision_total) * 100, 2) 
            : 0 ?></strong></td>
    </tr>
</tbody>
        </table>
    </div>
</body>
</html>

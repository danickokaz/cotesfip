<?php
// Connexion à la base de données
$host = 'localhost';
$dbname = 'cotesfip';
$username = 'root';
$password = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Récupérer les mois
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

    // Requête SQL pour regrouper les données et prendre en compte les natures de recettes avec code ou nature NULL
    $sql = "
        SELECT 
            s.id_ordre,
            COALESCE(s.code_nature, '') AS code_nature,
            COALESCE(s.libelle_nature_recette, '') AS nature_recette,
            COALESCE(cni.libelle_categorie_nature_impot, '') AS categorie,
            COALESCE(tni.libelle_nature_impot, '') AS type,
            s.id_mois,
            SUM(s.prevision) AS total_prevision,
            SUM(s.realisation) AS total_realisation
        FROM dgi_statistique s
        LEFT JOIN dgi_categorie_nature_impot cni ON s.id_categorie_nature_recette = cni.id
        LEFT JOIN dgi_type_nature_impot tni ON s.id_type_nature_recette = tni.id
        GROUP BY s.id_mois, s.libelle_nature_recette, cni.libelle_categorie_nature_impot, tni.libelle_nature_impot
        ORDER BY s.id_ordre, s.id_mois;
    ";

    $stmt = $pdo->query($sql);
    $resultats = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Natures à exclure des totaux par catégories et types
    $natures_exclues_total_prevision = [
        'Impôt sur les bénéfices et profits des petites entreprises',
        'Impôt sur les bénéfices et profits des micro-entreprises',
        'IBP DES PETROLIERS PRODUCTEURS'
    ];

    $natures_exclues_total_general = [
        'Impôt sur les bénéfices et profits des petites entreprises',
        'Impôt sur les bénéfices et profits des micro-entreprises'
    ];

    // Organiser les données par type, catégorie et code_nature
    $data_grouped_by_type = [];
    $totaux = [
        'total_prevision_exclu' => array_fill(1, 12, 0),
        'total_realisation_exclu' => array_fill(1, 12, 0),
        'total_prevision_general' => array_fill(1, 12, 0),
        'total_realisation_general' => array_fill(1, 12, 0)
    ];

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
            'taux' => $prevision > 0 
                ? ($realisation / $prevision) * 100 
                : 0
        ];

        if (!in_array($nature_recette, $natures_exclues_total_prevision)) {
            $data_grouped_by_type[$type]['categories'][$categorie]['total_prevision'][$row['id_mois']] += $prevision;
            $data_grouped_by_type[$type]['categories'][$categorie]['total_realisation'][$row['id_mois']] += $realisation;
            $data_grouped_by_type[$type]['total_prevision'][$row['id_mois']] += $prevision;
            $data_grouped_by_type[$type]['total_realisation'][$row['id_mois']] += $realisation;

            $totaux['total_prevision_exclu'][$row['id_mois']] += $prevision;
            $totaux['total_realisation_exclu'][$row['id_mois']] += $realisation;
        }

        if (!in_array($nature_recette, $natures_exclues_total_general)) {
            $totaux['total_prevision_general'][$row['id_mois']] += $prevision;
            $totaux['total_realisation_general'][$row['id_mois']] += $realisation;
        }
    }
} catch (PDOException $e) {
    die("Erreur de connexion : " . $e->getMessage());
}
?>

<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau DGI - Prévisions et Réalisations</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid mt-5">
        <h1 class="text-center mb-4">Tableau DGI - Prévisions et Réalisations</h1>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th rowspan="2" class="text-center">Code Nature</th>
                    <th rowspan="2" class="text-center">Nature Recette</th>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <th colspan="3" class="text-center"><?= $mois ?></th>
                    <?php endforeach; ?>
                    <th colspan="5" class="text-center">Cumul</th>
                </tr>
                <tr>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <th>Prévision</th>
                        <th>Réalisation</th>
                        <th>Taux (%)</th>
                    <?php endforeach; ?>
                    <th>Prévision</th>
                    <th>Réalisation</th>
                    <th>Écart</th>
                    <th>Taux de Réalisation (%)</th>
                    <th>Taux de Participation (%)</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($data_grouped_by_type as $type => $type_data): ?>
                    <tr class="table-secondary">
                        <td colspan="2"><strong><?= htmlspecialchars($type ?: '') ?></strong></td>
                        <?php foreach ($mois_noms as $id => $mois): ?>
                            <td class="text-center"><?= number_format($type_data['total_prevision'][$id], 2, ',', '.') ?></td>
                            <td class="text-center"><?= number_format($type_data['total_realisation'][$id], 2, ',', '.') ?></td>
                            <td class="text-center"><?= $type_data['total_prevision'][$id] > 0 
                                ? number_format(($type_data['total_realisation'][$id] / $type_data['total_prevision'][$id]) * 100, 2) 
                                : 0 ?></td>
                        <?php endforeach; ?>
                        <td colspan="5"></td>
                    </tr>

                    <?php foreach ($type_data['categories'] as $categorie => $cat_data): ?>
                        <tr class="table-light">
                            <td colspan="2"><strong><?= htmlspecialchars($categorie ?: '') ?></strong></td>
                            <?php foreach ($mois_noms as $id => $mois): ?>
                                <td class="text-center"><?= number_format($cat_data['total_prevision'][$id], 2, ',', '.') ?></td>
                                <td class="text-center"><?= number_format($cat_data['total_realisation'][$id], 2, ',', '.') ?></td>
                                <td class="text-center"><?= $cat_data['total_prevision'][$id] > 0 
                                    ? number_format(($cat_data['total_realisation'][$id] / $cat_data['total_prevision'][$id]) * 100, 2) 
                                    : 0 ?></td>
                            <?php endforeach; ?>
                            <td colspan="5"></td>
                        </tr>

                        <?php foreach ($cat_data['nature_recettes'] as $code => $nature): ?>
                            <tr>
                                <td class="text-center text-nowrap"><?= htmlspecialchars($code) ?></td>
                                <td>
                                    <?php if (in_array($nature['nature_recette'], $natures_exclues_total_general)): ?>
                                        <em><?= htmlspecialchars($nature['nature_recette']) ?></em>
                                    <?php else: ?>
                                        <?= htmlspecialchars($nature['nature_recette']) ?>
                                    <?php endif; ?>
                                </td>
                                <?php 
                                $cumul_prevision = 0;
                                $cumul_realisation = 0;
                                foreach ($mois_noms as $id => $mois): 
                                    $prevision = $nature['mois'][$id]['prevision'] ?? 0;
                                    $realisation = $nature['mois'][$id]['realisation'] ?? 0;
                                    $taux = $nature['mois'][$id]['taux'] ?? 0;
                                    $cumul_prevision += $prevision;
                                    $cumul_realisation += $realisation;
                                ?>
                                    <td class="text-center"><?= number_format($prevision, 2, ',', '.') ?></td>
                                    <td class="text-center"><?= number_format($realisation, 2, ',', '.') ?></td>
                                    <td class="text-center"><?= number_format($taux, 2, ',', '.') ?></td>
                                <?php endforeach; ?>
                                <td class="text-center"><?= number_format($cumul_prevision, 2, ',', '.') ?></td>
                                <td class="text-center"><?= number_format($cumul_realisation, 2, ',', '.') ?></td>
                                <td class="text-center"><?= number_format($cumul_realisation - $cumul_prevision, 2, ',', '.') ?></td>
                                <td class="text-center">
                                    <?= $cumul_prevision > 0 
                                        ? number_format(($cumul_realisation / $cumul_prevision) * 100, 2, ',', '.') 
                                        : 0 ?>
                                </td>
                                <td class="text-center">
                                    <?= $totaux['total_realisation_general'] > 0 
                                        ? number_format(($cumul_realisation / array_sum($totaux['total_realisation_general'])) * 100, 2, ',', '.') 
                                        : 0 ?>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endforeach; ?>
                <?php endforeach; ?>

                <tr class="table-primary">
                    <td colspan="2"><strong>Total Général</strong></td>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <td class="text-center"><?= number_format($totaux['total_prevision_general'][$id], 2, ',', '.') ?></td>
                        <td class="text-center"><?= number_format($totaux['total_realisation_general'][$id], 2, ',', '.') ?></td>
                        <td class="text-center">
                            <?= $totaux['total_prevision_general'][$id] > 0 
                                ? number_format(($totaux['total_realisation_general'][$id] / $totaux['total_prevision_general'][$id]) * 100, 2, ',', '.') 
                                : 0 ?>
                        </td>
                    <?php endforeach; ?>
                    <td class="text-center"><?= number_format(array_sum($totaux['total_prevision_general']), 2, ',', '.') ?></td>
                    <td class="text-center"><?= number_format(array_sum($totaux['total_realisation_general']), 2, ',', '.') ?></td>
                    <td class="text-center">
                        <?= number_format(array_sum($totaux['total_realisation_general']) - array_sum($totaux['total_prevision_general']), 2, ',', '.') ?>
                    </td>
                    <td class="text-center">
                        <?= array_sum($totaux['total_prevision_general']) > 0 
                            ? number_format((array_sum($totaux['total_realisation_general']) / array_sum($totaux['total_prevision_general'])) * 100, 2, ',', '.') 
                            : 0 ?>
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>

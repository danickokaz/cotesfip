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

    // Natures de recettes à exclure
    $natures_exclues = [
        'Impôt sur les bénéfices et profits des petites entreprises',
        'Impôt sur les bénéfices et profits des micro-entreprises'
    ];

    // Requête SQL pour regrouper les données par province et centre
    $sql = "
        SELECT 
            p.libelle_province,
            cp.libelle_centre,
            s.id_mois,
            s.annee,
            SUM(CASE WHEN ni.libelle_nature_impot NOT IN ('" . implode("','", $natures_exclues) . "') THEN s.prevision ELSE 0 END) AS total_prevision,
            SUM(CASE WHEN ni.libelle_nature_impot NOT IN ('" . implode("','", $natures_exclues) . "') THEN s.realisation ELSE 0 END) AS total_realisation,
            s.id_province,
            s.id_centre_perception
        FROM dgi_statistique s
        JOIN province p ON s.id_province = p.id
        JOIN dgi_centre_perception cp ON s.id_centre_perception = cp.id
        JOIN dgi_nature_impot ni ON s.id_ordre = ni.id
        GROUP BY p.libelle_province, cp.libelle_centre, s.id_mois, s.annee
        ORDER BY s.id_province, s.id_centre_perception, s.id_mois;
    ";

    $stmt = $pdo->query($sql);
    $resultats = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Organisation des données par province et centre
    $data_grouped = [];
    $totaux_mensuels = array_fill(1, 12, ['prevision' => 0, 'realisation' => 0]);

    foreach ($resultats as $row) {
        $province = $row['libelle_province'];
        $centre = $row['libelle_centre'];
        $mois = (int)$row['id_mois'];

        if (!isset($data_grouped[$province])) {
            $data_grouped[$province] = [];
        }

        if (!isset($data_grouped[$province][$centre])) {
            $data_grouped[$province][$centre] = array_fill(1, 12, ['prevision' => 0, 'realisation' => 0]);
        }

        $data_grouped[$province][$centre][$mois]['prevision'] += $row['total_prevision'];
        $data_grouped[$province][$centre][$mois]['realisation'] += $row['total_realisation'];

        $totaux_mensuels[$mois]['prevision'] += $row['total_prevision'];
        $totaux_mensuels[$mois]['realisation'] += $row['total_realisation'];
    }
} catch (PDOException $e) {
    die("Erreur de connexion : " . $e->getMessage());
}
?>

<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau DGI - Par Province et Centre</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid mt-5">
        <h1 class="text-center mb-4">Tableau DGI - Par Province et Centre</h1>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Province</th>
                    <th>Centre</th>
                    <?php foreach ($mois_noms as $mois): ?>
                        <th colspan="2" class="text-center"><?= $mois ?></th>
                    <?php endforeach; ?>
                </tr>
                <tr>
                    <th></th>
                    <th></th>
                    <?php foreach ($mois_noms as $mois): ?>
                        <th>Prévision</th>
                        <th>Réalisation</th>
                    <?php endforeach; ?>
                </tr>
            </thead>
            <tbody>
                <?php 
                $totaux_generaux = array_fill(1, 12, ['prevision' => 0, 'realisation' => 0]);
                foreach ($data_grouped as $province => $centres): 
                ?>
                    <?php 
                    $sous_total_prevision = array_fill(1, 12, 0);
                    $sous_total_realisation = array_fill(1, 12, 0);
                    foreach ($centres as $centre => $mois_data): ?>
                        <tr>
                            <td><?= htmlspecialchars($province) ?></td>
                            <td><?= htmlspecialchars($centre) ?></td>
                            <?php foreach ($mois_noms as $id => $mois): 
                                $prevision = $mois_data[$id]['prevision'] ?? 0;
                                $realisation = $mois_data[$id]['realisation'] ?? 0;
                                $sous_total_prevision[$id] += $prevision;
                                $sous_total_realisation[$id] += $realisation;
                            ?>
                                <td class="text-end"><?= number_format($prevision, 2, ',', '.') ?></td>
                                <td class="text-end"><?= number_format($realisation, 2, ',', '.') ?></td>
                            <?php endforeach; ?>
                        </tr>
                    <?php endforeach; ?>
                    <tr class="table-warning">
                        <td colspan="2" align="center"><strong><?= htmlspecialchars($province) ?></strong></td>
                        <?php foreach ($mois_noms as $id => $mois): 
                            $totaux_generaux[$id]['prevision'] += $sous_total_prevision[$id];
                            $totaux_generaux[$id]['realisation'] += $sous_total_realisation[$id];
                        ?>
                            <td class="text-end"><strong><?= number_format($sous_total_prevision[$id], 2, ',', '.') ?></strong></td>
                            <td class="text-end"><strong><?= number_format($sous_total_realisation[$id], 2, ',', '.') ?></strong></td>
                        <?php endforeach; ?>
                    </tr>
                <?php endforeach; ?>
                <tr class="table-primary">
                    <td colspan="2" align="center"><strong>Total Général</strong></td>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <td class="text-end"><strong><?= number_format($totaux_generaux[$id]['prevision'], 2, ',', '.') ?></strong></td>
                        <td class="text-end"><strong><?= number_format($totaux_generaux[$id]['realisation'], 2, ',', '.') ?></strong></td>
                    <?php endforeach; ?>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>

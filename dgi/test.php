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

    // Organiser les données par type, catégorie et code_nature
    $data_grouped_by_type = [];
    foreach ($resultats as $row) {
        $code = $row['code_nature']; // 'Non défini' est déjà assigné par la requête SQL si pas de code
        $nature_recette = $row['nature_recette']; // 'Non défini' est déjà assigné par la requête SQL si pas de nature
        $categorie = $row['categorie']; // 'Sans catégorie' est déjà assigné par la requête SQL si pas de catégorie
        $type = $row['type']; // 'Sans type' est déjà assigné par la requête SQL si pas de type

        // Convertir les valeurs en float pour les calculs (enlevant les virgules)
        $prevision = (float) $row['total_prevision'];
        $realisation = (float) $row['total_realisation'];

        // Ajouter les données sous le type de recette
        if (!isset($data_grouped_by_type[$type])) {
            $data_grouped_by_type[$type] = [
                'total_prevision' => array_fill(1, 12, 0),  // Initialiser les totaux par mois
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

        // Ajouter les valeurs pour chaque mois
        $data_grouped_by_type[$type]['categories'][$categorie]['nature_recettes'][$code]['mois'][$row['id_mois']] = [
            'prevision' => $prevision,
            'realisation' => $realisation,
            'taux' => $prevision > 0 
                ? ($realisation / $prevision) * 100 
                : 0
        ];

        // Ajouter au total de la catégorie
        $data_grouped_by_type[$type]['categories'][$categorie]['total_prevision'][$row['id_mois']] += $prevision;
        $data_grouped_by_type[$type]['categories'][$categorie]['total_realisation'][$row['id_mois']] += $realisation;

        // Ajouter au total du type
        $data_grouped_by_type[$type]['total_prevision'][$row['id_mois']] += $prevision;
        $data_grouped_by_type[$type]['total_realisation'][$row['id_mois']] += $realisation;
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
                    <th rowspan="2">Code Nature</th>
                    <th rowspan="2">Nature Recette</th>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <th colspan="3" class="text-center"><?= $mois ?></th>
                    <?php endforeach; ?>
                </tr>
                <tr>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <th>Prévision</th>
                        <th>Réalisation</th>
                        <th>Taux (%)</th>
                    <?php endforeach; ?>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($data_grouped_by_type as $type => $type_data): ?>
                    <!-- Ligne de total pour chaque type -->
                    <tr class="table-secondary">
                        <td colspan="2"><strong><?= htmlspecialchars($type ?: '') ?></strong></td>
                        <?php foreach ($mois_noms as $id => $mois): ?>
                            <td class="text-center"><?= number_format($type_data['total_prevision'][$id], 2, ',', ' ') ?></td>
                            <td class="text-center"><?= number_format($type_data['total_realisation'][$id], 2, ',', ' ') ?></td>
                            <td class="text-center"><?= $type_data['total_prevision'][$id] > 0 
                                ? number_format(($type_data['total_realisation'][$id] / $type_data['total_prevision'][$id]) * 100, 2) 
                                : 0 ?></td>
                        <?php endforeach; ?>
                    </tr>

                    <!-- Lignes des catégories sous chaque type -->
                    <?php foreach ($type_data['categories'] as $categorie => $categorie_data): ?>
                        <tr class="table-info">
                            <td colspan="2"><strong><?= htmlspecialchars($categorie) ?></strong></td>
                            <?php foreach ($mois_noms as $id => $mois): ?>
                                <td class="text-center"><?= number_format($categorie_data['total_prevision'][$id], 2, ',', ' ') ?></td>
                                <td class="text-center"><?= number_format($categorie_data['total_realisation'][$id], 2, ',', ' ') ?></td>
                                <td class="text-center"><?= $categorie_data['total_prevision'][$id] > 0 
                                    ? number_format(($categorie_data['total_realisation'][$id] / $categorie_data['total_prevision'][$id]) * 100, 2) 
                                    : 0 ?></td>
                            <?php endforeach; ?>
                        </tr>

                        <!-- Lignes des natures de recette sous chaque catégorie -->
                        <?php foreach ($categorie_data['nature_recettes'] as $code => $details): ?>
                            <tr>
                                <td><?= htmlspecialchars($code ?: 'Non défini') ?></td>
                                <td><?= htmlspecialchars($details['nature_recette'] ?: 'Non défini') ?></td>
                                <?php foreach ($mois_noms as $id => $mois): ?>
                                    <?php 
                                    // Vérification de l'existence de données et affichage
                                    $prevision = isset($details['mois'][$id]) ? $details['mois'][$id]['prevision'] : 0;
                                    $realisation = isset($details['mois'][$id]) ? $details['mois'][$id]['realisation'] : 0;
                                    $taux = $prevision > 0 ? ($realisation / $prevision) * 100 : 0;
                                    ?>
                                    <td class="text-center"><?= number_format($prevision, 2, ',', ' ') ?></td>
                                    <td class="text-center"><?= number_format($realisation, 2, ',', ' ') ?></td>
                                    <td class="text-center"><?= number_format($taux, 2) ?></td>
                                <?php endforeach; ?>
                            </tr>
                        <?php endforeach; ?>
                    <?php endforeach; ?>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

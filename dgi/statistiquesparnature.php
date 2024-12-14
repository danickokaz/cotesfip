<?php
// Connexion à la base de données
$dsn = 'mysql:host=localhost;dbname=cotesfip'; // Remplacez par vos informations
$username = 'root';
$password = '';

try {
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Erreur de connexion : " . $e->getMessage());
}

// Requête pour récupérer les données
$query = "
    SELECT 
        dgi_statistique.id_type_nature_recette,
        tni.libelle_nature_impot,
        dgi_statistique.id_categorie_nature_recette,
        cni.libelle_categorie_nature_impot,
        dgi_statistique.id_province,
        p.libelle_province,
        dgi_statistique.id_mois,
        m.libelle_mois,
        dgi_statistique.prevision,
        dgi_statistique.realisation,
        dgi_statistique.annee,
        dgi_statistique.id_ordre,
        dn.libelle_nature_impot,
        dn.code_nature_impot
    FROM dgi_statistique
    LEFT JOIN dgi_type_nature_impot tni ON dgi_statistique.id_type_nature_recette = tni.id
    LEFT JOIN dgi_categorie_nature_impot cni ON dgi_statistique.id_categorie_nature_recette = cni.id
    LEFT JOIN province p ON dgi_statistique.id_province = p.id
    LEFT JOIN mois m ON dgi_statistique.id_mois = m.id
    LEFT JOIN dgi_nature_impot dn ON dgi_statistique.id = dn.id
    ORDER BY tni.libelle_nature_impot, cni.libelle_categorie_nature_impot, dn.libelle_nature_impot, m.libelle_mois
";

$stmt = $pdo->prepare($query);
$stmt->execute();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Organisation des données pour le tableau
$tableData = [];
foreach ($data as $row) {
    $type = $row['libelle_nature_impot'] ?? 'Sans Type';
    $categorie = $row['libelle_categorie_nature_impot'] ?? 'Sans Catégorie';
    $nature = $row['libelle_nature_impot'];
    $mois = $row['libelle_mois'];

    if (!isset($tableData[$type])) {
        $tableData[$type] = [];
    }
    if (!isset($tableData[$type][$categorie])) {
        $tableData[$type][$categorie] = [];
    }
    if (!isset($tableData[$type][$categorie][$nature])) {
        $tableData[$type][$categorie][$nature] = [];
    }

    $tableData[$type][$categorie][$nature][$mois] = [
        'prevision' => $row['prevision'],
        'realisation' => $row['realisation'],
'taux' => is_numeric($row['realisation']) && is_numeric($row['prevision']) && $row['prevision'] != 0
    ? ($row['realisation'] / $row['prevision']) * 100
    : 0    ];
}

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau Statistiques</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h1 class="text-center mb-4">Tableau des Statistiques</h1>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Code</th>
                    <th>Mois</th>
                    <th>Prévision</th>
                    <th>Réalisation</th>
                    <th>Taux (%)</th>
                </tr>
            </thead>
            <tbody>
                <?php foreach ($tableData as $type => $categories): ?>
                    <tr class="table-primary">
                        <td colspan="5"><strong>Type: <?= htmlspecialchars($type) ?></strong></td>
                    </tr>
                    <?php foreach ($categories as $categorie => $natures): ?>
                        <tr class="table-secondary">
                            <td colspan="5"><strong>Catégorie: <?= htmlspecialchars($categorie) ?></strong></td>
                        </tr>
                        <?php foreach ($natures as $nature => $moisData): ?>
                            <tr>
                                <td colspan="5"><strong>Nature: <?= htmlspecialchars($nature) ?></strong></td>
                            </tr>
                            <?php foreach ($moisData as $mois => $values): ?>
                                <tr>
                                    <td><?= htmlspecialchars($values['code_nature_impot'] ?? '-') ?></td>
                                    <td><?= htmlspecialchars($mois) ?></td>
                                    <td><?= htmlspecialchars($values['prevision']) ?></td>
                                    <td><?= htmlspecialchars($values['realisation']) ?></td>
                                    <td><?= number_format($values['taux'], 2) ?></td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endforeach; ?>
                    <?php endforeach; ?>
                <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</body>
</html>
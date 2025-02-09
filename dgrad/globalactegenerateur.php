<?php
session_start();
require __DIR__ . '../../settings/bdd.php';

if (isset($_SESSION['jlk']) and !empty($_SESSION['jlk'])) {
    $session = htmlspecialchars($_SESSION['jlk']);

    $req = database()->prepare("SELECT 
        dgrad_utilisateur.token_utilisateur,
        dgrad_utilisateur.pseudo,
        dgrad_utilisateur.id,
        dgrad_utilisateur.id_role,
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

    if ($req->rowCount() == 1) {
        $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);

        $pseudo = $donneesUtilisateur->pseudo;
        $service_utilisateur  = $donneesUtilisateur->service_utilisateur;
        $role_utilisateur = $donneesUtilisateur->role_utilisateur;
        $id_role = $donneesUtilisateur->id_role;

        $libelle_province  = $donneesUtilisateur->libelle_province;

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
                        COALESCE(s.code_acte, '') AS code_acte,
                        COALESCE(s.libelle_acte, '') AS libelle_acte,
                        s.mois,
                        SUM(s.prevision) AS total_prevision,
                        SUM(s.realisation) AS total_realisation,
                        dgrad_type_recette.libelle_type_recette,
                        dgrad_categorie_recette.libelle_categorie_recette,
                        cag.libelle_categorie_acte,
                        sa.libelle_service
                    FROM dgrad_statistique s
                    LEFT JOIN dgrad_type_recette ON dgrad_type_recette.id =  s.id_type_recette
                    LEFT JOIN dgrad_categorie_recette ON dgrad_categorie_recette.id = s.id_categorie_recette
                    LEFT JOIN dgrad_categorie_acte_generateur cag ON s.id_categorie_acte = cag.id
                    LEFT JOIN dgrad_servives_assiettes sa ON sa.id = s.id_service_assiette
                    WHERE s.annee = ? AND s.id_etat_donnee=?
                    GROUP BY s.mois, s.libelle_acte, sa.libelle_service, dgrad_type_recette.libelle_type_recette
                    ORDER BY s.id_ordre, s.mois;
                ";

                $stmt = database()->prepare($sql);
                $stmt->execute([$annee,3]);
                $resultats = $stmt->fetchAll(PDO::FETCH_ASSOC);

                $data_grouped_by_type = [];
                foreach ($resultats as $row) {
                    $code = $row['code_acte'];
                    $nature_recette = $row['libelle_acte'];
                    $categorie = $row['libelle_categorie_acte'];
                    $type = $row['libelle_type_recette'];
                    $service = $row['libelle_service'];
                    $prevision = (float) $row['total_prevision'];
                    $realisation = (float) $row['total_realisation'];

                    if (!isset($data_grouped_by_type[$service])) {
                        $data_grouped_by_type[$service] = [
                            'total_prevision' => array_fill(1, 12, 0),
                            'total_realisation' => array_fill(1, 12, 0),
                            'categories' => []
                        ];
                    }

                    if (!isset($data_grouped_by_type[$service]['categories'][$categorie])) {
                        $data_grouped_by_type[$service]['categories'][$categorie] = [
                            'total_prevision' => array_fill(1, 12, 0),
                            'total_realisation' => array_fill(1, 12, 0),
                            'nature_recettes' => []
                        ];
                    }

                    if (!isset($data_grouped_by_type[$service]['categories'][$categorie]['nature_recettes'][$code])) {
                        $data_grouped_by_type[$service]['categories'][$categorie]['nature_recettes'][$code] = [
                            'nature_recette' => $nature_recette,
                            'mois' => []
                        ];
                    }

                    // Ajout de libelle_acte dans la structure
                    $data_grouped_by_type[$service]['categories'][$categorie]['nature_recettes'][$code]['libelle_acte'] = $nature_recette;

                    $data_grouped_by_type[$service]['categories'][$categorie]['nature_recettes'][$code]['mois'][$row['mois']] = [
                        'prevision' => $prevision,
                        'realisation' => $realisation,
                        'taux' => $prevision > 0 ? ($realisation / $prevision) * 100 : 0
                    ];

                    $data_grouped_by_type[$service]['categories'][$categorie]['total_prevision'][$row['mois']] += $prevision;
                    $data_grouped_by_type[$service]['categories'][$categorie]['total_realisation'][$row['mois']] += $realisation;
                    $data_grouped_by_type[$service]['total_prevision'][$row['mois']] += $prevision;
                    $data_grouped_by_type[$service]['total_realisation'][$row['mois']] += $realisation;
                }

                // Initialisation des totaux globaux
                $totaux = [
                    'total_prevision_general' => array_fill(1, 12, 0),
                    'total_realisation_general' => array_fill(1, 12, 0),
                    'recettes_hors_petrolier' => array_fill(1, 12, 0),
                    'recettes_petrolier_producteurs' => array_fill(1, 12, 0)
                ];

                // Calcul des totaux globaux
                foreach ($data_grouped_by_type as $service => $service_data) {
                    foreach ($service_data['total_prevision'] as $id_mois => $prevision) {
                        $totaux['total_prevision_general'][$id_mois] += $prevision;
                    }
                    foreach ($service_data['total_realisation'] as $id_mois => $realisation) {
                        $totaux['total_realisation_general'][$id_mois] += $realisation;
                    }

                    // Si le service est "RECETTES HORS PETROLIERS"
                    if (str_contains($type, "RECETTES HORS PETROLIERS")) {
                        foreach ($service_data['total_prevision'] as $id_mois => $prevision) {
                            $totaux['recettes_hors_petrolier'][$id_mois] += $prevision;
                        }
                        foreach ($service_data['total_realisation'] as $id_mois => $realisation) {
                            $totaux['recettes_hors_petrolier'][$id_mois] += $realisation;
                        }
                    }

                    // Si le service est "RECETTES PETROLIERS PRODUCTEURS"
                    if (str_contains($service, "RECETTES PETROLIERS PRODUCTEURS")) {
                        foreach ($service_data['total_prevision'] as $id_mois => $prevision) {
                            $totaux['recettes_petrolier_producteurs'][$id_mois] += $prevision;
                        }
                        foreach ($service_data['total_realisation'] as $id_mois => $realisation) {
                            $totaux['recettes_petrolier_producteurs'][$id_mois] += $realisation;
                        }
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
        <h1 class="text-center mb-4">Tableau DGRAD - Prévisions et Réalisations <?= $annee ?></h1>
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
                <?php foreach ($data_grouped_by_type as $service => $service_data): ?>
                    <tr class="table-warning">
                        <td colspan="2" align="center"><strong><?= htmlspecialchars($service ?: '') ?></strong></td>
                        <?php 
                        $cumul_prevision_type = 0;
                        $cumul_realisation_type = 0;
                        ?>
                        <?php foreach ($mois_noms as $id => $mois): ?>
                            <td class="text-center"><?= number_format($service_data['total_prevision'][$id], 2, ',', '.') ?></td>
                            <td class="text-center"><?= number_format($service_data['total_realisation'][$id], 2, ',', '.') ?></td>
                            <td class="text-center"><?= $service_data['total_prevision'][$id] > 0 
                                ? number_format(($service_data['total_realisation'][$id] / $service_data['total_prevision'][$id]) * 100, 2) 
                                : 0 ?></td>
                            <?php 
                            $cumul_prevision_type += $service_data['total_prevision'][$id];
                            $cumul_realisation_type += $service_data['total_realisation'][$id];
                            ?>
                        <?php endforeach; ?>
                        <td class="text-center"><strong><?= number_format($cumul_prevision_type, 2, ',', '.') ?></strong></td>
                        <td class="text-center"><strong><?= number_format($cumul_realisation_type, 2, ',', '.') ?></strong></td>
                        <td class="text-center"><strong><?= $cumul_prevision_type > 0 
                            ? number_format(($cumul_realisation_type / $cumul_prevision_type) * 100, 2) 
                            : 0 ?></strong></td>
                    </tr>

                    <?php foreach ($service_data['categories'] as $categorie => $categorie_data): ?>
                        <tr class="">
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
                            <td class="text-center"><strong><?= number_format($cumul_prevision_categorie, 2, ',', '.') ?></strong></td>
                            <td class="text-center"><strong><?= number_format($cumul_realisation_categorie, 2, ',', '.') ?></strong></td>
                            <td class="text-center"><strong><?= $cumul_prevision_categorie > 0 
                                ? number_format(($cumul_realisation_categorie / $cumul_prevision_categorie) * 100, 2) 
                                : 0 ?></strong></td>
                        </tr>
                        <?php foreach ($categorie_data['nature_recettes'] as $nature_recette_code => $nature_recette_data): ?>
                            <tr>
                                <td><?= htmlspecialchars($nature_recette_code) ?></td>
                                <td><?= htmlspecialchars($nature_recette_data['libelle_acte']) ?></td>
                                <?php 
                                $cumul_prevision_nature = 0;
                                $cumul_realisation_nature = 0;
                                ?>
                                <?php foreach ($mois_noms as $id => $mois): ?>
                                    <td class="text-center"><?= isset($nature_recette_data['mois'][$id]) ? number_format($nature_recette_data['mois'][$id]['prevision'], 2, ',', '.') : 0 ?></td>
                                    <td class="text-center"><?= isset($nature_recette_data['mois'][$id]) ? number_format($nature_recette_data['mois'][$id]['realisation'], 2, ',', '.') : 0 ?></td>
                                    <td class="text-center"><?= isset($nature_recette_data['mois'][$id]) && $nature_recette_data['mois'][$id]['prevision'] > 0 
                                        ? number_format($nature_recette_data['mois'][$id]['taux'], 2) 
                                        : 0 ?></td>
                                    <?php 
                                    $cumul_prevision_nature += isset($nature_recette_data['mois'][$id]) ? $nature_recette_data['mois'][$id]['prevision'] : 0;
                                    $cumul_realisation_nature += isset($nature_recette_data['mois'][$id]) ? $nature_recette_data['mois'][$id]['realisation'] : 0;
                                    ?>
                                <?php endforeach; ?>
                                <td class="text-center"><strong><?= number_format($cumul_prevision_nature, 2, ',', '.') ?></strong></td>
                                <td class="text-center"><strong><?= number_format($cumul_realisation_nature, 2, ',', '.') ?></strong></td>
                                <td class="text-center"><strong><?= $cumul_prevision_nature > 0 
                                    ? number_format(($cumul_realisation_nature / $cumul_prevision_nature) * 100, 2) 
                                    : 0 ?></strong></td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endforeach; ?>
                <?php endforeach; ?>

                


                <tr class="table-success">
                    <td colspan="2" class="text-center"><strong>Total Général</strong></td>
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

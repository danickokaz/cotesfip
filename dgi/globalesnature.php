<?php
session_start();
require __DIR__.'../../settings/bdd.php';
if(isset($_SESSION['visa']) and !empty($_SESSION['visa'])){
  $session = htmlspecialchars($_SESSION['visa']);

  $req = database()->prepare("SELECT 
  utilisateur.token_utilisateur,
  utilisateur.pseudo,
  utilisateur.id,
  service_pourvoyeur.abreviation as service_utilisateur,
  role_utilisateur.libelle_role as role_utilisateur,
  dgi_centre_perception.libelle_centre as centre_perception
  FROM utilisateur 
  INNER JOIN service_pourvoyeur ON utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
  INNER JOIN role_utilisateur ON utilisateur.id_role = role_utilisateur.id
  LEFT JOIN dgi_centre_perception ON  dgi_centre_perception.id = utilisateur.id_centre_perception
  WHERE token_utilisateur=?");
  $req->execute([$session]);

  if($req->rowCount() == 1){
    $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);

    $pseudo = $donneesUtilisateur->pseudo;
    $service_utilisateur  = $donneesUtilisateur->service_utilisateur;
    $role_utilisateur = $donneesUtilisateur->role_utilisateur;
    $centre_perception  = $donneesUtilisateur->centre_perception;

    if(isset($_GET['annee']) and !empty($_GET['annee'])){
        $annee = htmlspecialchars($_GET['annee']);

        try {
            // $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $username, $password);
            // $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
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
                WHERE s.annee=?
                GROUP BY s.id_mois, s.libelle_nature_recette, cni.libelle_categorie_nature_impot, tni.libelle_nature_impot
                ORDER BY s.id_ordre, s.id_mois;
            ";
        
            $stmt = database()->prepare($sql);
            $stmt->execute([$annee]);
            $resultats = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
            // Natures à exclure des totaux (Prévision Exclu)
            $natures_exclues_prevision = [
                'Impôt sur les bénéfices et profits des petites entreprises',
                'Impôt sur les bénéfices et profits des micro-entreprises',
                'IBP DES PETROLIERS PRODUCTEURS'
            ];
        
            // Natures à exclure uniquement pour le Total Général (2 recettes exclues)
            $natures_exclues_general = [
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
        
                // Exclure des totaux Prévision Exclu les trois recettes
                $exclude_from_totals_prevision = in_array($nature_recette, $natures_exclues_prevision);
                if (!$exclude_from_totals_prevision) {
                    $data_grouped_by_type[$type]['categories'][$categorie]['total_prevision'][$row['id_mois']] += $prevision;
                    $data_grouped_by_type[$type]['categories'][$categorie]['total_realisation'][$row['id_mois']] += $realisation;
                    $data_grouped_by_type[$type]['total_prevision'][$row['id_mois']] += $prevision;
                    $data_grouped_by_type[$type]['total_realisation'][$row['id_mois']] += $realisation;
        
                    $totaux['total_prevision_exclu'][$row['id_mois']] += $prevision;
                    $totaux['total_realisation_exclu'][$row['id_mois']] += $realisation;
                }
        
                // Exclure des totaux Général les deux recettes (en excluant aussi celles des petites entreprises et micro-entreprises)
                $exclude_from_totals_general = in_array($nature_recette, $natures_exclues_general);
                if (!$exclude_from_totals_general) {
                    $totaux['total_prevision_general'][$row['id_mois']] += $prevision;
                    $totaux['total_realisation_general'][$row['id_mois']] += $realisation;
                }
            }
        } catch (PDOException $e) {
            die("Erreur de connexion : " . $e->getMessage());
        }
        
    }


    


  }else{
    header(header: "location: connexion");
  }

}else{
  header(header: "location: connexion");
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
                    <tr class="table-secondary">
                        <td colspan="2" align="center"><strong><?= htmlspecialchars($type ?: '') ?></strong></td>
                        <?php foreach ($mois_noms as $id => $mois): ?>
                            <td class="text-center"><?= number_format($type_data['total_prevision'][$id], 2, ',', '.') ?></td>
                            <td class="text-center"><?= number_format($type_data['total_realisation'][$id], 2, ',', '.') ?></td>
                            <td class="text-center"><?= $type_data['total_prevision'][$id] > 0 
                                ? number_format(($type_data['total_realisation'][$id] / $type_data['total_prevision'][$id]) * 100, 2) 
                                : 0 ?></td>
                        <?php endforeach; ?>
                    </tr>

                    <?php foreach ($type_data['categories'] as $categorie => $categorie_data): ?>
                        <tr class="table-info">
                            <td colspan="2" align="center"><strong><?= htmlspecialchars($categorie) ?></strong></td>
                            <?php foreach ($mois_noms as $id => $mois): ?>
                                <td class="text-center"><?= number_format($categorie_data['total_prevision'][$id], 2, ',', '.') ?></td>
                                <td class="text-center"><?= number_format($categorie_data['total_realisation'][$id], 2, ',', '.') ?></td>
                                <td class="text-center"><?= $categorie_data['total_prevision'][$id] > 0 
                                    ? number_format(($categorie_data['total_realisation'][$id] / $categorie_data['total_prevision'][$id]) * 100, 2) 
                                    : 0 ?></td>
                            <?php endforeach; ?>
                        </tr>

                        <?php foreach ($categorie_data['nature_recettes'] as $code => $details): ?>
                            <tr>
                                <td><?= htmlspecialchars($code ?: 'Non défini') ?></td>
                                <!-- Affichage en italique pour les deux natures spécifiques -->
                                <td>
                                    <?= 
                                        in_array($details['nature_recette'], ['Impôt sur les bénéfices et profits des petites entreprises', 'Impôt sur les bénéfices et profits des micro-entreprises'])
                                        ? '<b><em>' . htmlspecialchars($details['nature_recette']) . '</em></b>'
                                        : htmlspecialchars($details['nature_recette'])
                                    ?>
                                </td>
                                <?php foreach ($mois_noms as $id => $mois): ?>
                                    <?php 
                                    $prevision = isset($details['mois'][$id]) ? $details['mois'][$id]['prevision'] : 0;
                                    $realisation = isset($details['mois'][$id]) ? $details['mois'][$id]['realisation'] : 0;
                                    $taux = $prevision > 0 ? ($realisation / $prevision) * 100 : 0;
                                    ?>
                                    <td class="text-center"><?= number_format($prevision, 2, ',', '.') ?></td>
                                    <td class="text-center"><?= number_format($realisation, 2, ',', '.') ?></td>
                                    <td class="text-center"><?= number_format($taux, 2) ?></td>
                                <?php endforeach; ?>
                            </tr>
                        <?php endforeach; ?>
                    <?php endforeach; ?>
                <?php endforeach; ?>

                <tr class="table-primary">
                    <td colspan="2" align="center"><strong>Total Prévision</strong></td>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <td class="text-center"><?= number_format($totaux['total_prevision_exclu'][$id], 2, ',', '.') ?></td>
                        <td class="text-center"><?= number_format($totaux['total_realisation_exclu'][$id], 2, ',', '.') ?></td>
                        <td class="text-center"><?= $totaux['total_prevision_exclu'][$id] > 0 
                            ? number_format(($totaux['total_realisation_exclu'][$id] / $totaux['total_prevision_exclu'][$id]) * 100, 2) 
                            : 0 ?></td>
                    <?php endforeach; ?>
                </tr>

                <tr class="table-success">
                    <td colspan="2" align="center"><strong>Total Général</strong></td>
                    <?php foreach ($mois_noms as $id => $mois): ?>
                        <td class="text-center"><?= number_format($totaux['total_prevision_general'][$id], 2, ',', '.') ?></td>
                        <td class="text-center"><?= number_format($totaux['total_realisation_general'][$id], 2, ',', '.') ?></td>
                        <td class="text-center"><?= $totaux['total_prevision_general'][$id] > 0 
                            ? number_format(($totaux['total_realisation_general'][$id] / $totaux['total_prevision_general'][$id]) * 100, 2) 
                            : 0 ?></td>
                    <?php endforeach; ?>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>

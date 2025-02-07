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
                WHERE s.annee = ?
                GROUP BY p.libelle_province, cp.libelle_centre, s.id_mois, s.annee
                ORDER BY s.id_province, s.id_centre_perception, s.id_mois;
            ";
        
            $stmt = database()->prepare($sql);
            $stmt->execute([$annee]);
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
                        <th colspan="3" class="text-center"><?= $mois ?></th>
                    <?php endforeach; ?>
                    <th colspan="3" class="text-center">Cumul</th>
                </tr>
                <tr>
                    <th></th>
                    <th></th>
                    <?php foreach ($mois_noms as $mois): ?>
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
                <?php 
                $totaux_generaux = array_fill(1, 12, ['prevision' => 0, 'realisation' => 0]);
                $total_cumul_prevision = 0;
                $total_cumul_realisation = 0;

                foreach ($data_grouped as $province => $centres): 
                ?>
                    <?php 
                    $sous_total_prevision = array_fill(1, 12, 0);
                    $sous_total_realisation = array_fill(1, 12, 0);
                    $cumul_prevision_province = 0;
                    $cumul_realisation_province = 0;

                    foreach ($centres as $centre => $mois_data): ?>
                        <tr>
                            <td><?= htmlspecialchars($province) ?></td>
                            <td><?= htmlspecialchars($centre) ?></td>
                            <?php 
                            $cumul_prevision_centre = 0;
                            $cumul_realisation_centre = 0;

                            foreach ($mois_noms as $id => $mois): 
                                $prevision = $mois_data[$id]['prevision'] ?? 0;
                                $realisation = $mois_data[$id]['realisation'] ?? 0;
                                $taux_realisation = ($prevision > 0) ? ($realisation / $prevision) * 100 : 0;

                                $sous_total_prevision[$id] += $prevision;
                                $sous_total_realisation[$id] += $realisation;

                                $cumul_prevision_centre += $prevision;
                                $cumul_realisation_centre += $realisation;
                            ?>
                                <td class="text-end"><?= number_format($prevision, 2, ',', '.') ?></td>
                                <td class="text-end"><?= number_format($realisation, 2, ',', '.') ?></td>
                                <td class="text-end"><?= number_format($taux_realisation, 2, ',', '.') ?>%</td>
                            <?php endforeach; ?>

                            <!-- Cumul par Centre -->
                            <td class="text-end"><strong><?= number_format($cumul_prevision_centre, 2, ',', '.') ?></strong></td>
                            <td class="text-end"><strong><?= number_format($cumul_realisation_centre, 2, ',', '.') ?></strong></td>
                            <td class="text-end"><strong><?= number_format(($cumul_prevision_centre > 0) ? ($cumul_realisation_centre / $cumul_prevision_centre) * 100 : 0, 2, ',', '.') ?>%</strong></td>
                        </tr>
                    <?php 
                    $cumul_prevision_province += $cumul_prevision_centre;
                    $cumul_realisation_province += $cumul_realisation_centre;
                    endforeach; ?>

                    <tr class="table-warning">
                        <td colspan="2" align="center"><strong><?= htmlspecialchars($province) ?></strong></td>
                        <?php foreach ($mois_noms as $id => $mois): 
                            $totaux_generaux[$id]['prevision'] += $sous_total_prevision[$id];
                            $totaux_generaux[$id]['realisation'] += $sous_total_realisation[$id];
                            $taux_sous_total = ($sous_total_prevision[$id] > 0) ? ($sous_total_realisation[$id] / $sous_total_prevision[$id]) * 100 : 0;
                        ?>
                            <td class="text-end"><strong><?= number_format($sous_total_prevision[$id], 2, ',', '.') ?></strong></td>
                            <td class="text-end"><strong><?= number_format($sous_total_realisation[$id], 2, ',', '.') ?></strong></td>
                            <td class="text-end"><strong><?= number_format($taux_sous_total, 2, ',', '.') ?>%</strong></td>
                        <?php endforeach; ?>

                        <!-- Cumul par Province -->
                        <td class="text-end"><strong><?= number_format($cumul_prevision_province, 2, ',', '.') ?></strong></td>
                        <td class="text-end"><strong><?= number_format($cumul_realisation_province, 2, ',', '.') ?></strong></td>
                        <td class="text-end"><strong><?= number_format(($cumul_prevision_province > 0) ? ($cumul_realisation_province / $cumul_prevision_province) * 100 : 0, 2, ',', '.') ?>%</strong></td>
                    </tr>
                <?php 
                $total_cumul_prevision += $cumul_prevision_province;
                $total_cumul_realisation += $cumul_realisation_province;
                endforeach; ?>

                <tr class="table-primary">
                    <td colspan="2" align="center"><strong>Total Général</strong></td>
                    <?php foreach ($mois_noms as $id => $mois): 
                        $taux_total_general = ($totaux_generaux[$id]['prevision'] > 0) ? ($totaux_generaux[$id]['realisation'] / $totaux_generaux[$id]['prevision']) * 100 : 0;
                    ?>
                        <td class="text-end"><strong><?= number_format($totaux_generaux[$id]['prevision'], 2, ',', '.') ?></strong></td>
                        <td class="text-end"><strong><?= number_format($totaux_generaux[$id]['realisation'], 2, ',', '.') ?></strong></td>
                        <td class="text-end"><strong><?= number_format($taux_total_general, 2, ',', '.') ?>%</strong></td>
                    <?php endforeach; ?>

                    <!-- Cumul Général -->
                    <td class="text-end"><strong><?= number_format($total_cumul_prevision, 2, ',', '.') ?></strong></td>
                    <td class="text-end"><strong><?= number_format($total_cumul_realisation, 2, ',', '.') ?></strong></td>
                    <td class="text-end"><strong><?= number_format(($total_cumul_prevision > 0) ? ($total_cumul_realisation / $total_cumul_prevision) * 100 : 0, 2, ',', '.') ?>%</strong></td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>


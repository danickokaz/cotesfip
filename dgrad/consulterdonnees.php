<?php
session_start();
require __DIR__.'../../settings/bdd.php';
if(isset($_SESSION['jlk']) and !empty($_SESSION['jlk'])){
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
  WHERE token_utilisateur=?");
  $req->execute([$session]);

  if($req->rowCount() == 1){
    $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);

    $pseudo = $donneesUtilisateur->pseudo;
    $service_utilisateur  = $donneesUtilisateur->service_utilisateur;
    $role_utilisateur = $donneesUtilisateur->role_utilisateur;
    $id_role = $donneesUtilisateur->id_role;

    $libelle_province  = $donneesUtilisateur->libelle_province;




  }else{
    header(header: "location: connexion");
  }

}else{
  header(header: "location: connexion");
}
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <!-- Required meta tags -->
    <?php require 'header/header.php' ?>
</head>

<body>
    <div class="container-scroller">
        <!-- partial:partials/_navbar.html -->
        <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">

            <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
                <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
                    <span class="icon-menu"></span>
                </button>
                <ul class="navbar-nav mr-lg-2">
                    <li class="nav-item nav-search d-none d-lg-block">
                        <!-- <div class="input-group">
              <div class="input-group-prepend">
                <span class="input-group-text" id="search">
                  <i class="icon-search"></i>
                </span>
              </div>
              <input type="text" class="form-control" placeholder="Search Projects.." aria-label="search" aria-describedby="search">
            </div> -->
                    </li>
                </ul>
                <ul class="navbar-nav navbar-nav-right">

                    <!-- <li class="nav-item dropdown d-flex">
            <a class="nav-link count-indicator dropdown-toggle d-flex justify-content-center align-items-center" id="messageDropdown" href="#" data-toggle="dropdown">
              <i class="icon-air-play mx-0"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="messageDropdown">
              <p class="mb-0 font-weight-normal float-left dropdown-header">Messages</p>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                    <img src="../images/armoiri.png" alt="image" class="profile-pic">
                </div>
                <div class="preview-item-content flex-grow">
                  <h6 class="preview-subject ellipsis font-weight-normal">David Grey
                  </h6>
                  <p class="font-weight-light small-text text-muted mb-0">
                    The meeting is cancelled
                  </p>
                </div>
              </a>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                    <img src="../images/faces/face2.jpg" alt="image" class="profile-pic">
                </div>
                <div class="preview-item-content flex-grow">
                  <h6 class="preview-subject ellipsis font-weight-normal">Tim Cook
                  </h6>
                  <p class="font-weight-light small-text text-muted mb-0">
                    New product launch
                  </p>
                </div>
              </a>
              <a class="dropdown-item preview-item">
                <div class="preview-thumbnail">
                    <img src="../images/faces/face3.jpg" alt="image" class="profile-pic">
                </div>
                <div class="preview-item-content flex-grow">
                  <h6 class="preview-subject ellipsis font-weight-normal"> Johnson
                  </h6>
                  <p class="font-weight-light small-text text-muted mb-0">
                    Upcoming board meeting
                  </p>
                </div>
              </a>
            </div>
          </li> -->
                    <li class="nav-item dropdown d-flex mr-4 ">
                        <a class="nav-link count-indicator dropdown-toggle d-flex align-items-center justify-content-center"
                            id="notificationDropdown" href="#" data-toggle="dropdown">
                            <i class="icon-cog"></i>
                        </a>
                        <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list"
                            aria-labelledby="notificationDropdown">
                            <p class="mb-0 font-weight-normal float-left dropdown-header">Paramètres</p>
                            <a class="dropdown-item preview-item" href="profil">
                                <i class="icon-head"></i> Profil
                            </a>
                            <a class="dropdown-item preview-item" href="deconnexion">
                                <i class="icon-inbox"></i> Se déconnecter
                            </a>
                        </div>
                    </li>

                </ul>
                <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button"
                    data-toggle="offcanvas">
                    <span class="icon-menu"></span>
                </button>
            </div>
        </nav>
        <!-- partial -->
        <div class="container-fluid page-body-wrapper">
            <!-- partial:partials/_sidebar.html -->
            <nav class="sidebar sidebar-offcanvas p-0" id="sidebar">
                <div class="user-profile">
                    <div class="user-image">
                        <img src="../images/armoiri.png">
                    </div>
                    <div class="user-name">
                        <?= $pseudo. " ({$service_utilisateur} / {$libelle_province})" ?>
                    </div>
                    <div class="user-designation">
                        <?= $role_utilisateur ?>
                    </div>
                </div>
                <?php require 'menu/sidebar.php' ?>
            </nav>
            <!-- partial -->
            <div class="main-panel">
                <div class="content-wrapper">

                    <div class="modal fade bd-example-modal-lg" id="modalImporterDonneesExcel" tabindex="-1"
                        role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">IMPORTER LES DONNEES DEPUIS UNE
                                        FEUILLE EXCEL</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form method="POST" id="formulaireImporterDonneesExcel">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="fichierExcelDonnees">Choisir le fichier Excel</label>
                                                    <input type="file" class="form-control-file"
                                                        id="fichierExcelDonnees" name="fichierExcelDonnees">
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="mois">Choisir les colonnes à importer</label>
                                                    <select class="form-control" id="mois" name="mois">
                                                        <option value="1">Janvier</option>
                                                        <option value="2">Février</option>
                                                        <option value="3">Mars</option>
                                                        <option value="4">Avril</option>
                                                        <option value="5">Mai</option>
                                                        <option value="6">Juin</option>
                                                        <option value="7">Juillet</option>
                                                        <option value="8">Aout</option>
                                                        <option value="9">Septembre</option>
                                                        <option value="10">Octobre</option>
                                                        <option value="11">Novembre</option>
                                                        <option value="12">Décembre</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="annee">Choisir l'annee</label>
                                                    <select class="form-control" id="annee" name="annee">
                                                        <option value="">Veuillez choisir une annee</option>
                                                        <?php for($i=2024;$i<=date('Y');$i++): ?>
                                                        <option value="<?= $i ?>"><?= $i ?></option>
                                                        <?php endfor; ?>
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label for="servicesI">Choisir le service</label>
                                                    <select class="form-control" id="servicesI" name="servicesI">

                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="container">
                                            <button class="btn btn-info" id="btnImporterDonneesExcel"
                                                type="submit">Importer</button>
                                        </div>
                                </div>
                                </form>
                            </div>

                        </div>
                    </div>


                    <div class="modal fade" id="modalVoirStatsGloblesParNature" tabindex="-1" role="dialog"
                        aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">STATISTIQUES GLOBALES PAR NATURE</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="formulaireVoirStatsGlobalesParNature" method="post">
                                        <div class="form-group">
                                            <label for="anneeStatsGlobalesParNature">Choisir l'annee</label>
                                            <select class="form-control" id="anneeStatsGlobalesParNature"
                                                name="anneeStatsGlobalesParNature">
                                                <?php for($i=2024;$i<=date('Y');$i++): ?>
                                                <option value="<?= $i ?>"><?= $i ?></option>
                                                <?php endfor; ?>
                                            </select>

                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                data-dismiss="modal">Annuler</button>
                                            <button type="submit" class="btn btn-info">Voir</button>
                                        </div>


                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>


                    <div class="modal fade" id="modalVoirStatsGloblesParProvince" tabindex="-1" role="dialog"
                        aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">STATISTIQUES GLOBALES PAR PROVINCES
                                    </h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="formulaireVoirStatsGlobalesPaProvince" method="post">
                                        <div class="form-group">
                                            <label for="anneeStatsGlobalesParProvince">Choisir l'annee</label>
                                            <select class="form-control" id="anneeStatsGlobalesParProvince"
                                                name="anneeStatsGlobalesParProvince">
                                                <?php for($i=2024;$i<=date('Y');$i++): ?>
                                                <option value="<?= $i ?>"><?= $i ?></option>
                                                <?php endfor; ?>
                                            </select>

                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                data-dismiss="modal">Annuler</button>
                                            <button type="submit" class="btn btn-info">Voir</button>
                                        </div>


                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="container">
                        <h2>CONSULTER MES DONNEES PAR MOIS</h2>
                        <div class="container">
                            <form method="post" id="formualireVoirDonnees">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label class="label" for="moisVoirDonnees">Mois</label>
                                            <select class="form-control" id="moisVoirDonnees" name="moisVoirDonnees">
                                                <option value="1">Janvier</option>
                                                <option value="2">Février</option>
                                                <option value="3">Mars</option>
                                                <option value="4">Avril</option>
                                                <option value="5">Mai</option>
                                                <option value="6">Juin</option>
                                                <option value="7">Juillet</option>
                                                <option value="8">Aout</option>
                                                <option value="9">Septembre</option>
                                                <option value="10">Octobre</option>
                                                <option value="11">Novembre</option>
                                                <option value="12">Décembre</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="anneeVoirDonnees">Choisir l'annee</label>
                                            <select class="form-control" id="anneeVoirDonnees" name="anneeVoirDonnees">
                                                <option value="">Veuillez choisir l'annee</option>
                                                <?php for($i=2024;$i<=date('Y');$i++): ?>
                                                <option value="<?= $i ?>"><?= $i ?></option>
                                                <?php endfor; ?>
                                            </select>

                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="services">Choisir le service</label>
                                            <select class="form-control" id="services" name="services">
                                                <option value="">Veuillez choisir le service</option>

                                            </select>

                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button id="btnVoirDonnees" class="btn btn-info">Afficher</button>
                                </div>
                            </form>
                        </div>
                    </div>


                    <div id="tableau_voir_mes_donnees"></div>


                </div>
                <!-- content-wrapper ends -->

            </div>
            <!-- main-panel ends -->
        </div>
        <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->

    <!-- base:js -->
    <?php require 'footer/footer.php' ?>
    <!-- End custom js for this page-->
    <script>
        $(document).ready(function () {

            $(".importerDonneesExcel").click(function () {
                event.preventDefault();

                $("#modalImporterDonneesExcel").modal("show");
            })

            $('#formualireVoirDonnees').submit(function () {
                event.preventDefault()

                $("#btnVoirDonnees").text('Chargement...')
                $("#btnVoirDonnees").prop('disabled', true);
                $.ajax({
                    url: 'traitement/tableau_mes_donnees_mensuelles.php',
                    type: 'POST',
                    data: $("#formualireVoirDonnees").serialize(),
                    dataType: 'html',
                    success: function (response) {
                        console.log(response);
                        document.getElementById("tableau_voir_mes_donnees").innerHTML =
                            response
                    },
                    error: function () {
                        alert('Erreur');
                    },
                    complete: function () {
                        $("#btnVoirDonnees").text('Afficher')
                        $("#btnVoirDonnees").prop('disabled', false);
                    }
                });
            });

            $('#btnImporterDonneesExcel').click(function () {
                event.preventDefault()
                var formulaireImporter = new FormData($('#formulaireImporterDonneesExcel')[0]);
                $("#btnImporterDonneesExcel").text('Chargement...')
                $("#btnImporterDonneesExcel").prop('disabled', true);
                $.ajax({
                    url: 'traitement/importer_donnees_excel.php',
                    type: 'POST',
                    data: formulaireImporter,
                    contentType: false,
                    processData: false,
                    success: function (response) {
                        if (response === "Success") {


                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: 'Importation réussie',
                                showConfirmButton: false,
                                timer: 1500
                            });
                            location.href = "consulterdonnees"

                        } else if (response === "Type de fichier invalide") {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Veuillez choisir un fichier de type (Xls, Xlsx ou csv)',
                                showConfirmButton: true,

                            });
                        } else if (response == "Veuillez  choisir un fichier") {
                            Swal.fire({
                                position: 'center',
                                icon: 'error',
                                title: 'Veuillez choisir un fichier',
                                showConfirmButton: true,

                            });
                        } else {
                            console.log(response)
                        }
                    },
                    error: function () {
                        alert('Erreur');
                    },
                    complete: function () {
                        $("#btnImporterDonneesExcel").text('Importer')
                        $("#btnImporterDonneesExcel").prop('disabled', false);
                    }
                });
            });


            $("#statistiquesparnature").click(function () {
                event.preventDefault();
                $("#modalVoirStatsGloblesParNature").modal("show");
            })

            $("#statistiquesparprovince").click(function () {
                event.preventDefault();
                $("#modalVoirStatsGloblesParProvince").modal("show");
            })


            $("#formulaireVoirStatsGlobalesParNature").submit(function () {
                event.preventDefault()

                var annee = $("#anneeStatsGlobalesParNature").val();

                if (annee != "") {
                    location.href = "globalesnature/" + annee
                } else {
                    alert('Veuillez choisir une année ')
                }
            })

            $("#formulaireVoirStatsGlobalesPaProvince").submit(function () {
                event.preventDefault()

                var annee = $("#anneeStatsGlobalesParProvince").val();

                if (annee != "") {
                    location.href = "globalesprovince/" + annee
                } else {
                    alert('Veuillez choisir une année ')
                }
            })




            $("#anneeVoirDonnees").change(function () {
                var exerciceM = $(this).val();

                $.ajax({
                    url: 'traitement/selectServicesParExercice.php',
                    method: 'POST',
                    data: {
                        exerciceM: exerciceM
                    },
                    error: function (error) {
                        console.log("Erreur lors de la requête" + error);
                    },
                    dataType: 'html',
                    success: function (response) {
                        $("#services").html(response);
                    }
                })
            })

            $("#annee").change(function(){
                var exerciceM = $(this).val();
                
                $.ajax({
                    url: 'traitement/selectServicesParExercice.php',
                    method: 'POST',
                    data: {exerciceM: exerciceM},
                    error: function(error){
                        console.log("Erreur lors de la requête"+error);
                    },
                    dataType: 'html',
                    success: function(response){
                    $("#servicesI").html(response);
                    }
                })
            })



        })
    </script>
</body>

</html>
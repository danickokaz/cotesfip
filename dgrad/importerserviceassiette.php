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


    $req = database()->prepare(query: "SELECT * FROM dgrad_categorie_recette");
    $req->execute();

    if($req->rowCount() > 0){
      $donnees = $req->fetchAll(PDO::FETCH_OBJ);
    }


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
    <?php require 'header/header.php'; ?>
    <style>
        .card {
            max-width: 500px;
            margin: 0 auto;
            border-radius: 8px;
            border: 1px solid #eaeaea;
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 8px;
        }

        .form-control {
            height: calc(2.5rem + 2px);
            font-size: 1rem;
            border-radius: 6px;
            border: 1px solid #ced4da;
            transition: border-color 0.2s ease-in-out;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            font-size: 1.2rem;
            padding: 10px 30px;
            border-radius: 6px;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        h3 {
            font-size: 1.8rem;
            font-weight: 600;
        }
    </style>



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

                    </li>
                </ul>
                <ul class="navbar-nav navbar-nav-right">



                    <li class="nav-item dropdown d-flex mr-4 ">
                        <button class="btn btn-info" id="btnOuvrirModalImportation">Importer donnees</button>

                    </li>

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
                <?php require 'menu/sidebar.php'; ?>
            </nav>
            <!-- partial -->
            <div class="main-panel">
                <div class="content-wrapper">

                    <h1>LISTE DE CENTRES DE PERCEPTION</h1>

                    <div class="row">
                        <div class="col-md-4 mb-5">
                            <label for="anneeSelection">Choisir l'exercice</label>

                            <select class="form-control" id="anneeSelection" name="anneeSelection">
                                <option value="">Choisr l'exerice</option>
                                <?php for($i=2024;$i<=date('Y');$i++): ?>
                                <option value="<?= $i ?>"><?= $i ?></option>
                                <?php endfor; ?>
                            </select>
                        </div>
                    </div>

                    <div id="tableau_service_assiette"></div>



                    <!-- Modal -->
                    <div id="selectionModal" class="modal" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Modifier les informations</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="formulaireModification" method="post">
                                        <select name="categorieM" id="categorieM" class="form-control">
                                            <option value="">Veuillez choisir</option>
                                            <?php foreach($donnees as $d): ?>
                                            <option value="<?= $d->id ?>"><?= $d->libelle_categorie_recette ?></option>
                                            <?php endforeach; ?>
                                        </select>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-info"
                                                id="confirmAction">Confirmer</button>
                                            <button type="button" class="btn btn-secondary"
                                                data-dismiss="modal">Fermer</button>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>


                    <div id="modalImporterDonnees" class="modal" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Importer les donnees</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form method="POST" enctype="multipart/form-data" id="formulaireImporter">
                                        <!-- File Input -->
                                        <div class="form-group">
                                            <label for="fichier" class="form-label">Choisir fichier excel File</label>
                                            <input type="file" id="fichier" name="fichier" class="form-control">
                                        </div>

                                        <div class="form-group">
                                            <label for="exercice">Choisir l'exercice</label>
                                            <select class="form-control" id="exercice" name="exercice">
                                                <?php for($i=2024;$i<=date('Y');$i++): ?>
                                                <option value="<?= $i ?>"><?= $i ?></option>
                                                <?php endfor; ?>
                                            </select>
                                        </div>

                                        <!-- Submit Button -->
                                        <div class="form-group text-center mt-4">
                                            <button type="submit" id="btnImporter"
                                                class="btn btn-info btn-lg">Importer</button>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>

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
                                                    <label for="mois">Choisir le mois</label>
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
                                                    <label for="services">Choisir le service</label>
                                                    <select class="form-control" id="services" name="services">

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


                    <div class="modal fade" id="modalVoirStatsGloblesParActeGenerateur" tabindex="-1" role="dialog"
                        aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <ERA class="modal-title" id="exampleModalLabel">STATISTIQUES GLOBALES PAR ACTE
                                        GENERATEUR</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                </div>
                                <div class="modal-body">
                                    <form id="formulaireVoirStatsGlobalesParActeGenerateur" method="post">
                                        <div class="form-group">
                                            <label for="anneeStatsGlobalesParActeGenerateur">Choisir l'annee</label>
                                            <select class="form-control" id="anneeStatsGlobalesParActeGenerateur"
                                                name="anneeStatsGlobalesParActeGenerateur">
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





                </div>
                <!-- content-wrapper ends -->

            </div>
            <!-- main-panel ends -->
        </div>
        <!-- page-body-wrapper ends -->
    </div>
    <!-- container-scroller -->

    <?php require 'footer/footer.php' ?>



    <script>
        $(document).ready(function () {

            // centre_perception()



            $("#anneeSelection").change(function () {
                var anneeSelection = $(this).val();

                if (anneeSelection != "") {
                    $.ajax({
                        url: 'traitement/tableau_services_assiettes.php',
                        method: 'POST',
                        dataType: 'html',
                        data: {
                            anneeSelection: anneeSelection
                        },
                        success: function (response) {
                            document.getElementById('tableau_service_assiette').innerHTML =
                                response
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            console.log(xhr.status);
                            console.log(thrownError);
                        }
                    })
                }
            })



            $("#btnOuvrirModalImportation").on('click', function () {
                $("#modalImporterDonnees").modal("show");
            })

            function services_assiettes() {

                var anneeSelection = $("#anneeSelection").val();
                $.ajax({
                    url: 'traitement/tableau_services_assiettes.php',
                    method: 'POST',
                    dataType: 'html',
                    data: {
                        anneeSelection: anneeSelection
                    },
                    success: function (response) {
                        document.getElementById('tableau_service_assiette').innerHTML = response
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(thrownError);
                    }
                })
            }

            // $('#btnImporter').click(function () {
            //     event.preventDefault()
            //     var formulaireImporter = new FormData($('#formulaireImporter')[0]);
            //     $("#btnImporter").text('Chargement...')
            //     $("#btnImporter").prop('disabled', true);
            //     $.ajax({
            //         url: 'traitement/importeserviceassiette.php',
            //         type: 'POST',
            //         data: formulaireImporter,
            //         contentType: false,
            //         processData: false,
            //         success: function (response) {
            //             if (response === "Success") {
            //                 // centre_perception()
            //                 Swal.fire({
            //                     position: 'center',
            //                     icon: 'success',
            //                     title: 'Importation réussie',
            //                     showConfirmButton: false,
            //                     timer: 1500
            //                 });
            //                 $("#modalImporterDonnees").modal("hide");

            //             } else if (response === "Type de fichier invalide") {
            //                 Swal.fire({
            //                     position: 'center',
            //                     icon: 'error',
            //                     title: 'Veuillez choisir un fichier de type (Xls, Xlsx ou csv)',
            //                     showConfirmButton: true,

            //                 });
            //             } else if (response == "Veuillez  choisir un fichier") {
            //                 Swal.fire({
            //                     position: 'center',
            //                     icon: 'error',
            //                     title: 'Veuillez choisir un fichier',
            //                     showConfirmButton: true,

            //                 });
            //             } else {
            //                 console.log(response)
            //             }
            //         },
            //         error: function () {
            //             alert('Erreur');
            //         },
            //         complete: function () {
            //             $("#btnImporter").text('Importer')
            //             $("#btnImporter").prop('disabled', false);
            //         }
            //     });
            // });


            // Désactiver le menu contextuel par défaut
            $(document).on('contextmenu', function (e) {
                e.preventDefault();
            });

            // Fonction pour obtenir les éléments sélectionnés
            function getSelectedItems() {
                const selected = [];
                $('.row-checkbox:checked').each(function () {
                    selected.push($(this).val());
                });
                return selected;
            }

            // Gérer le clic droit pour ouvrir le modal
            $(document).on('mousedown', function (e) {
                if (e.which === 3) { // Vérifie si le clic droit est effectué
                    var selectedItems = getSelectedItems();
                    if (selectedItems.length > 0) {
                        // Ouvrir le modal
                        $('#selectionModal').modal('show');
                    } else {
                        Swal.fire({
                            title: "Erreur!",
                            text: "Veuillez sélectionner au moins un élément avant de continuer",
                            icon: "error"
                        });

                    }
                }
            });

            // Gérer la soumission à partir du bouton dans le modal
            $('#confirmAction').on('click', function () {
                // Récupérer les valeurs des cases cochées
                var selectedIds = getSelectedItems();
                var categorie = $("#categorieM").val(); // Récupérer la province

                // Vérifier si au moins une case est cochée
                if (selectedIds.length === 0) {
                    Swal.fire({
                        title: "Erreur!",
                        text: "Veuillez selectionner au moins un service",
                        icon: "error"
                    });
                    return;
                }

                // Envoi des données via Ajax
                $.ajax({
                    url: 'traitement/affecter_categorie_recette_dans_service.php', // URL du script PHP
                    method: 'POST', // Méthode HTTP
                    data: {
                        ids: selectedIds,
                        categorie: categorie
                    }, // Données envoyées
                    success: function (response) {
                        console.log('Réponse brute du serveur:',
                            response); // Affichez la réponse brute
                        try {
                            const jsonResponse = JSON.parse(
                                response); // Tentez de parser en JSON
                            if (jsonResponse.status === 'success') {
                                // Mettre à jour la vue
                                services_assiettes();

                                // Message de succès
                                Swal.fire({
                                    title: "Operation reussie!",
                                    text: "Centre ajoute avec succes",
                                    icon: "success"
                                });

                                $('#selectionModal').modal('hide'); // Fermer le modal
                            } else {
                                // Message d'erreur

                                Swal.fire({
                                    title: "Erreur!",
                                    text: "Une erreur est survennue",
                                    icon: "error"
                                });
                            }
                        } catch (e) {
                            Swal.fire({
                                title: "Erreur!",
                                text: "Une erreur est survennue",
                                icon: "error"
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        Swal.fire({
                            title: "Erreur!",
                            text: "Une erreur est survennue",
                            icon: "error"
                        });
                    }
                });
            });



            $('#formulaireImporter').submit(function () {
                event.preventDefault()
                var formulaireImporter = new FormData($('#formulaireImporter')[0]);

                $("#btnImporter").text('Chargement...')
                $("#btnImporter").prop('disabled', true);
                $.ajax({
                    url: 'traitement/importeserviceassiette.php',
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
                            // location.href = "consulterdonnees"

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
                        $("#btnImporter").text('Importer')
                        $("#btnImporter").prop('disabled', false);
                    }
                });
            });


            $("#statistiquesparactegenerateur").click(function () {
                event.preventDefault();
                $("#modalVoirStatsGloblesParActeGenerateur").modal("show");
            })

            $("#statistiquesparprovince").click(function () {
                event.preventDefault();
                $("#modalVoirStatsGloblesParProvince").modal("show");
            })


            $("#formulaireVoirStatsGlobalesParActeGenerateur").submit(function () {
                event.preventDefault()

                var annee = $("#anneeStatsGlobalesParActeGenerateur").val();

                if (annee != "") {
                location.href = "globalactegenerateur/" + annee
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


            $("#annee").change(function () {
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



        })
    </script>
</body>

</html>
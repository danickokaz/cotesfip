<?php
session_start();
require __DIR__.'../../settings/bdd.php';
if(isset($_SESSION['access']) and !empty($_SESSION['access'])){
  $session = htmlspecialchars($_SESSION['access']);

  $req = database()->prepare("SELECT  
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
  LEFT JOIN dgda_centre_perception ON  dgda_centre_perception.id = dgda_utilisateur.id_centre_perception
  WHERE token_utilisateur=?");
  $req->execute([$session]);

  if($req->rowCount() == 1){
    $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);

    $pseudo = $donneesUtilisateur->pseudo;
    $service_utilisateur  = $donneesUtilisateur->service_utilisateur;
    $role_utilisateur = $donneesUtilisateur->role_utilisateur;
    $id_service_pourvoyeur = $donneesUtilisateur->id_service_pourvoyeur;
    $centre_perception = $donneesUtilisateur->centre_perception;
    $id_role = $donneesUtilisateur->id_role;


    $req = database()->prepare("SELECT * FROM dgda_type_secteur_activite");
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
            <?= $pseudo. " ({$service_utilisateur} / {$centre_perception})" ?>
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

          <h1>NATURES ECONOMIQUES</h1>

          <div class="container">
            <div id="tableau_nature_economique"></div>
          </div>



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
                    <div class="form-group mb-2">
                        <label for="typeSecteur">Type *</label>
                        <select name="typeSecteur" id="typeSecteur" class="form-control">
                            <option value="">Veuillez choisir un type</option>
                        <?php foreach($donnees as $d): ?>
                        <option value="<?= $d->id ?>"><?= $d->libelle_type_secteur ?></option>
                        <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="form-group mb-2">
                        <label for="categorieSecteur">Catégorie *</label>
                        <select name="categorieSecteur" id="categorieSecteur" class="form-control"></select>
                    </div>

                    <div class="form-group mb-2">
                        <label for="secteur">Secteur *</label>
                        <select name="secteur" id="secteur" class="form-control"></select>
                    </div>

                    <div class="modal-footer">
                      <button type="button" class="btn btn-info" id="confirmAction">Confirmer</button>
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
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

                    <!-- Submit Button -->
                    <div class="form-group text-center mt-4">
                      <button type="submit" id="btnImporter" class="btn btn-info btn-lg">Importer</button>
                    </div>
                  </form>
                </div>

              </div>
            </div>
          </div>

          <div class="modal fade bd-example-modal-lg" id="modalImporterDonneesExcel" tabindex="-1" role="dialog"
            aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">IMPORTER LES DONNEES DEPUIS UNE FEUILLE EXCEL</h5>
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
                          <input type="file" class="form-control-file" id="fichierExcelDonnees"
                            name="fichierExcelDonnees">
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
                            <?php for($i=2024;$i<=date('Y');$i++): ?>
                            <option value="<?= $i ?>"><?= $i ?></option>
                            <?php endfor; ?>
                          </select>

                        </div>
                      </div>
                    </div>
                    <div class="container">
                      <button class="btn btn-info" id="btnImporterDonneesExcel" type="submit">Importer</button>
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
                      <select class="form-control" id="anneeStatsGlobalesParNature" name="anneeStatsGlobalesParNature">
                        <?php for($i=2024;$i<=date('Y');$i++): ?>
                        <option value="<?= $i ?>"><?= $i ?></option>
                        <?php endfor; ?>
                      </select>

                    </div>

                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
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
                  <h5 class="modal-title" id="exampleModalLabel">STATISTIQUES GLOBALES PAR PROVINCES</h5>
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
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Annuler</button>
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

    nature_economique()

    function nature_economique() {
        $.ajax({
          url: 'traitement/tableau_nature_economique.php',
          method: 'POST',
          dataType: 'html',
          success: function (response) {
            document.getElementById('tableau_nature_economique').innerHTML = response
          },
          error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status);
            console.log(thrownError);
          }
        })
    }


    $("#typeSecteur").change(function(){
        var id_type_secteur = $(this).val();

        $.ajax({
            url: 'traitement/select_categorie_secteur.php',
            method: 'POST',
            data: {id_type_secteur: id_type_secteur},
            dataType: 'html',
            success: function(data) {
                $("#categorieSecteur").html(data)
            },
            // beforeSend: function(){
            //     $("#categorieSecteur").html('<option value="">Chargement...</option>');
            // },
            error: function(xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(thrownError);
            }
        })
    })

    $("#categorieSecteur").change(function(){
        var id_categorie_secteur = $(this).val();

        $.ajax({
            url: 'traitement/select_secteur.php',
            method: 'POST',
            data: {id_categorie_secteur: id_categorie_secteur},
            dataType: 'html',
            success: function(data) {
                $("#secteur").html(data)
            },
            // beforeSend: function(){
            //     $("#categorieSecteur").html('<option value="">Chargement...</option>');
            // },
            error: function(xhr, ajaxOptions, thrownError) {
                console.log(xhr.status);
                console.log(thrownError);
            }
        })
    })



      $("#btnOuvrirModalImportation").on('click', function () {
        $("#modalImporterDonnees").modal("show");
      })

      

      $('#btnImporter').click(function () {
        event.preventDefault()
        var formulaireImporter = new FormData($('#formulaireImporter')[0]);
        $("#btnImporter").text('Chargement...')
        $("#btnImporter").prop('disabled', true);
        $.ajax({
          url: 'traitement/importercentre.php',
          type: 'POST',
          data: formulaireImporter,
          contentType: false,
          processData: false,
          success: function (response) {
            if (response === "Success") {
              nature_economique()
              Swal.fire({
                position: 'center',
                icon: 'success',
                title: 'Importation réussie',
                showConfirmButton: false,
                timer: 1500
              });
              $("#modalImporterDonnees").modal("hide");

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
        var typeSecteur = $("#typeSecteur").val(); // Récupérer les types de secteurs 
        var categorieSecteur = $("#categorieSecteur").val(); // Récupérer les categories
        var secteur = $("#secteur").val(); // Recuperer les secteurs d'activites

        // Vérifier si au moins une case est cochée
        if (selectedIds.length === 0) {
          Swal.fire({
            title: "Erreur!",
            text: "Veuillez selectionner au moins un centre de perception",
            icon: "error"
          });
          return;
        }

        // Envoi des données via Ajax
        $.ajax({
          url: 'traitement/affecterSecteurDansNatureEconomique.php', // URL du script PHP
          method: 'POST', // Méthode HTTP
          data: {
            ids: selectedIds,
            typeSecteur: typeSecteur,
            categorieSecteur: categorieSecteur,
            secteur: secteur
          }, // Données envoyées
          success: function (response) {
            try {
              var jsonResponse = JSON.parse(response); // Tentez de parser en JSON
              if (jsonResponse.status === 'success') {
                // Mettre à jour la vue
                nature_economique();

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



    })
  </script>
</body>

</html>
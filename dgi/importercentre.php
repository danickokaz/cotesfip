<?php
session_start();
require __DIR__.'../../settings/bdd.php';
if(isset($_SESSION['visa']) and !empty($_SESSION['visa'])){
  $session = htmlspecialchars($_SESSION['visa']);

  $req = database()->prepare("SELECT 
  utilisateur.token_utilisateur,
  utilisateur.pseudo,
  utilisateur.id,
  utilisateur.id_service_pourvoyeur,
  service_pourvoyeur.abreviation as service_utilisateur,
  role_utilisateur.libelle_role as role_utilisateur
  FROM utilisateur 
  INNER JOIN service_pourvoyeur ON utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
  INNER JOIN role_utilisateur ON utilisateur.id_role = role_utilisateur.id
  WHERE token_utilisateur=?");
  $req->execute([$session]);

  if($req->rowCount() == 1){
    $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);

    $pseudo = $donneesUtilisateur->pseudo;
    $service_utilisateur  = $donneesUtilisateur->service_utilisateur;
    $role_utilisateur = $donneesUtilisateur->role_utilisateur;
    $id_service_pourvoyeur = $donneesUtilisateur->id_service_pourvoyeur;

    $req = database()->prepare("SELECT * FROM province WHERE id_service=?");
    $req->execute([$id_service_pourvoyeur]);

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
            <?= $pseudo. " ({$service_utilisateur})" ?>
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

          <div class="container">
            <div id="tableau_centre"></div>
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
                    <select name="provinceM" id="provinceM" class="form-control">
                      <?php foreach($donnees as $d): ?>
                      <option value="<?= $d->id ?>"><?= $d->libelle_province ?></option>
                      <?php endforeach; ?>
                    </select>
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

      centre_perception()



      $("#btnOuvrirModalImportation").on('click', function () {
        $("#modalImporterDonnees").modal("show");
      })

      function centre_perception() {
        $.ajax({
          url: 'traitement/tableau_centre_perception.php',
          method: 'POST',
          dataType: 'html',
          success: function (response) {
            document.getElementById('tableau_centre').innerHTML = response
          },
          error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status);
            console.log(thrownError);
          }
        })
      }

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
              centre_perception()
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
        var province = $("#provinceM").val(); // Récupérer la province

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
          url: 'traitement/affecter_centre_dans_province.php', // URL du script PHP
          method: 'POST', // Méthode HTTP
          data: {
            ids: selectedIds,
            province: province
          }, // Données envoyées
          success: function (response) {
            console.log('Réponse brute du serveur:', response); // Affichez la réponse brute
            try {
              const jsonResponse = JSON.parse(response); // Tentez de parser en JSON
              if (jsonResponse.status === 'success') {
                // Mettre à jour la vue
                centre_perception();

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

      

    })
  </script>
</body>

</html>
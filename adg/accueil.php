<?php
session_start();
require __DIR__.'../../settings/bdd.php';
if(isset($_SESSION['kedadaje']) and !empty($_SESSION['kedadaje'])){
  $session = htmlspecialchars($_SESSION['kedadaje']);

  $req = database()->prepare("SELECT 
  administrateur.token_admin,
  administrateur.pseudo,
  administrateur.id,
  administrateur.id_role,
  administrateur.id_service_affecte,
  service_pourvoyeur.abreviation as service_utilisateur,
  role_admin.libelle_role as role_utilisateur
  FROM administrateur 
  LEFT JOIN service_pourvoyeur ON administrateur.id_service_affecte = service_pourvoyeur.id
  LEFT JOIN role_admin ON administrateur.id_role = role_admin.id
  WHERE administrateur.token_admin=?");
  $req->execute([$session]);

  if($req->rowCount() == 1){
    $donneesUtilisateur = $req->fetch(PDO::FETCH_OBJ);

    $pseudo = $donneesUtilisateur->pseudo;
    $service_utilisateur  = $donneesUtilisateur->service_utilisateur;
    $role_utilisateur = $donneesUtilisateur->role_utilisateur;
    $id_role = $donneesUtilisateur->id_role;
    $id_service_affecte = $donneesUtilisateur->id_service_affecte;

    // requette pour recuperer les provinces de l'utilisateur

    $req = database()->prepare("SELECT * FROM province WHERE id_service=?");
    $req->execute([$id_service_affecte]);
    $provinces = $req->fetchAll(PDO::FETCH_OBJ);


    $req2 = database()->prepare("SELECT * FROM province_finale");
    $req2->execute();
    $provinces_finales = $req2->fetchAll(PDO::FETCH_OBJ); 



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
<style>
  /* Conteneur des cartes */
  .card-container {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    /* 4 colonnes */
    gap: 20px;
    /* Espacement entre les cartes */
    padding: 20px;
  }

  /* Style de chaque carte */
  .card {
    background-color: #fff;
    border-radius: 10px;
    padding: 20px;
    text-align: center;
    box-shadow: 10px 5px 15px rgba(55, 148, 252, 0.3);
    /* Ombre décalée à droite */
    transition: box-shadow 0.3s ease-in-out;
  }

  /* Effet au survol des cartes */
  .card:hover {
    box-shadow: 15px 10px 25px rgba(55, 148, 252, 0.5);
  }

  /* Style de l'icône */
  .card i {
    font-size: 40px;
    color: #3794fc;
  }

  /* Style du nombre aléatoire */
  .random-number {
    font-size: 36px;
    font-weight: bold;
    margin: 20px 0;
  }

  /* Style du label */
  .label {
    font-size: 16px;
    color: #555;
  }
</style>

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
            <?= $pseudo. " {$service_utilisateur }" ?>
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





          <div class="container">
            <h2>PREPRARER LES DONNEES PAR MOIS</h2>
            <div class="container">
              <form method="post" id="formualireTransfererDonnees">
                <div class="row">
                  <div class="col-md-3">
                    <div class="form-group">
                      <label class="label" for="moisVoirDonnees">Mois</label>
                      <select class="form-control" id="moisVoirDonnees" name="moisVoirDonnees">
                        <option value="">Veuillez choisir un mois</option>
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
                  <div class="col-md-3">
                    <div class="form-group">
                      <label for="anneeVoirDonnees">Choisir l'annee</label>
                      <select class="form-control" id="anneeVoirDonnees" name="anneeVoirDonnees">
                        <option value="">Veuillez choisir une annee</option>
                        <?php for($i=2024;$i<=date('Y');$i++): ?>
                        <option value="<?= $i ?>"><?= $i ?></option>
                        <?php endfor; ?>
                      </select>

                    </div>
                  </div>

                  
                  <div class="col-md-3">
                    <div class="form-group">
                      <label for="provinces">Province de départ</label>
                      <select class="form-control" id="provinces" name="provinces">
                        <option value="">Veuillez choisir une province</option>
                        <?php foreach($provinces as $province): ?>
                        <option value="<?= $province->id ?>"><?= $province->libelle_province ?></option>
                        <?php endforeach; ?>
                      </select>

                    </div>
                  </div>

                  <div class="col-md-3">
                    <div class="form-group">
                      <label for="provinces_finales">Province de finale</label>
                      <select class="form-control" id="provinces_finales" name="provinces_finales">
                        <option value="">Veuillez choisir une province</option>
                        <?php foreach($provinces_finales as $province_finale): ?>
                        <option value="<?= $province_finale->id ?>"><?= $province_finale->libelle_province_fin ?></option>
                        <?php endforeach; ?>
                      </select>

                    </div>
                  </div>
                  
                </div>
                <div class="container">
                  <button type="submit" id="btnFormulaire" class="btn btn-info">Valider</button>
                </div>

              </form>
            </div>
          </div>

          <div class="container">
            <div id="tableau"></div>
          </div>

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
  <script src="https://kit.fontawesome.com/a076d05399.js"></script>

  <script>
    $(document).ready(function () {


      tableau()

      function tableau() {
        $.ajax({
          url: 'traitement/tableau_donnees_preparees.php',
          method: 'POST',
          dataType: 'html',
          success: function (response) {
            console.log(response);
            document.getElementById('tableau').innerHTML = response
          },
          error: function (xhr, ajaxOptions, thrownError) {
            console.log(xhr.status);
            console.log(thrownError);
          }

        })
        }

      $("#formualireTransfererDonnees").submit(function () {
                event.preventDefault()

                $("#btnFormulaire").text('Chargement...')
                $("#btnFormulaire").prop('disabled', true);

                $.ajax({
                    url: 'traitement/transfererDonnees.php',
                    type: 'POST',
                    data: $("#formualireTransfererDonnees").serialize(),
                    dataType: 'text',
                    success: function (response) {
                        console.log(response);
                        if (response == 'success') {
                            tableau()

                            Swal.fire({
                                title: "Operation reussie!",
                                text: "Donnees ajoutees",
                                icon: "success"
                            });
                            
                        } else if(response == 'Veuillez sélectionner tous les champs') {
                            Swal.fire({
                                title: "Important!",
                                text: "Veuillez sélectionner tous les champs",
                                icon: "error"
                            });
                        }else if(response == 'Pas pretes') {
                            Swal.fire({
                                title: "Important!",
                                text: "Les données n'ont pas encore été validées par le DEP pour le mois indiqué",
                                icon: "info"
                            });
                        }
                        else{
                          console.log(response)
                        }
                    },
                    error: function () {
                        alert('Erreur');
                    },
                    complete: function () {
                        $("#btnFormulaire").text('Valider')
                        $("#btnFormulaire").prop('disabled', false);
                    }
                })
            })


            $(document).on('click','.supprimer',function(){
              var id = $(this).attr('id');
              Swal.fire({
                title: "Important",
                text: "Voulez-vous vraiment supprimer cette préparation",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Oui",  // Texte du bouton de confirmation
                cancelButtonText: "Annuler",    // Texte du bouton d'annulation
              }).then((result) => {
                if (result.isConfirmed) {

                  $.ajax({
                    url: 'traitement/supprimer_preparation.php',
                    type: 'POST',
                    data: {id: id},
                    dataType: 'text',
                    success: function (response) {
                      console.log(response);
                      if (response == 'success') {
                          tableau()
                          Swal.fire({
                              title: "Operation reussie!",
                              text: "Preparation supprimee",
                              icon: "success"
                          });     
                      } else {
                          console.log(response)
                      }
                    },
                    error: function () {
                      alert('Erreur');
                    },
                    
                  })

                  
                }
              });
            })

    })
  </script>
</body>

</html>
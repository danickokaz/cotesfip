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
                        <button class="btn btn-info" id="btnOuvrirModalCreerUtilisateur">Créer utilisateur</button>

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

                    <h1>LISTE D'UTILISATEURS (DGI)</h1>

                    <div class="container">
                        <div id="tableau_utilisateur"></div>
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


                    <div id="modalCreerUtilisateur" class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog"
                        aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Importer les donnees</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form method="POST" enctype="multipart/form-data" id="formulaireCreerUtilisateur">
                                        <!-- File Input -->
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="province" class="form-label">Province</label>
                                                    <select name="province" id="province" class="form-control">
                                                        <option value="">Veuillez choisir une province</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="centre" class="form-label">Centre de perception</label>
                                                    <select name="centre" id="centre" class="form-control">
                                                        <option value="">Veuillez choisir un centre de perception
                                                        </option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="role" class="form-label">Role</label>
                                                    <select name="role" id="role" class="form-control">
                                                        <option value="">Veuillez choisir un role</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="pseudo" class="form-label">Pseudo</label>
                                                    <input type="text" name="pseudo" id="pseudo" class="form-control">
                                                </div>
                                            </div>
                                        </div>

                                        <div id="messageRetour"></div>

                                        <!-- Submit Button -->
                                        <div class="form-group text-center mt-4">
                                            <button type="submit" id="btnEnregistrer"
                                                class="btn btn-info btn-lg">Enregistrer</button>
                                        </div>

                                       
                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>


                    <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog"
                        aria-labelledby="myLargeModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                ...
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

            utilisateur()

            province()
            role()



            function utilisateur(){
                $.ajax({
                    url: 'traitement/tableau_utilisateur.php',
                    method: 'POST',
                    dataType: 'html',
                    success: function (response) {
                        console.log(response);
                        document.getElementById('tableau_utilisateur').innerHTML =  response
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(thrownError);
                    }
                    
                })
            }




            function province() {
                $.ajax({
                    url: 'traitement/selectProvince.php',
                    method: 'POST',
                    dataType: 'html',
                    success: function (response) {
                        console.log(response);
                        $("#province").html(response)
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(thrownError);
                    },
                    beforeSend: function () {
                        $("#province").html("<option value=''>Chargement...</option>")
                    }
                })
            }


            function role() {
                $.ajax({
                    url: 'traitement/selectRole.php',
                    method: 'POST',
                    dataType: 'html',
                    success: function (response) {
                        console.log(response);
                        $("#role").html(response)
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(thrownError);
                    },
                    beforeSend: function () {
                        $("#role").html("<option value=''>Chargement...</option>")
                    }
                })
            }

            $("#province").on('change', function () {
                var province = $(this).val();
                $.ajax({
                    url: 'traitement/selectCentre.php',
                    method: 'POST',
                    data: {
                        id_province: province
                    },
                    dataType: 'html',
                    success: function (response) {
                        console.log(response);
                        $("#centre").html(response)
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(thrownError);
                    },
                    beforeSend: function () {
                        $("#centre").html("<option value=''>Chargement...</option>")
                    }
                })
            })

            $("#btnOuvrirModalCreerUtilisateur").on('click', function () {
                $("#modalCreerUtilisateur").modal("show");
            })


            $("#formulaireCreerUtilisateur").submit(function(){
                event.preventDefault();
                $("#btnEnregistrer").prop('disabled', true);
                $("#btnEnregistrer").text("Chargement...")
                var formData = new FormData(this);
                $.ajax({
                    url: 'traitement/creerUtilisateur.php',
                    method: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: 'text',
                    success: function (response) {
                        console.log(response);
                       
                        
                        if(response == "success"){
                            utilisateur()
                            // province()
                            // role()
                            $("#pseudo").val('')
                            // $("#role").val('')
                            $("#messageRetour").html(`
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <strong>Félications!</strong> Utilisateur ajouté avec succès.
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            `);
                            setTimeout(() => {
                                $("#messageRetour").html('<div></div>')
                            }, 1000);
                        }else if (response == "Champs vides"){
                            $("#messageRetour").html(`
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <strong>Import!</strong> Veuillez saisir les champs obligatoires.
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            `);
                            setTimeout(() => {
                                $("#messageRetour").html('<div></div>')
                            }, 2500);
                        }else if (response == "deja"){
                            $("#messageRetour").html(`
                                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                    <strong>Important!</strong> Utilsateur existe déjà.
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            `);
                            setTimeout(() => {
                                $("#messageRetour").html('<div></div>')
                            }, 2500);
                        }else{
                            console.log(response)
                        }
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        console.log(xhr.status);
                        console.log(thrownError);
                    },
                    complete: function(){
                        $("#btnEnregistrer").prop('disabled', false);
                        $("#btnEnregistrer").text("Enregistrer")

                    }
                    
                })
            })










        })
    </script>
</body>

</html>
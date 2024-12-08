<?php
session_start();
require __DIR__.'../../settings/bdd.php';
if(isset($_SESSION['visa']) and !empty($_SESSION['visa'])){
  $session = htmlspecialchars($_SESSION['visa']);

  $req = database()->prepare("SELECT token_utilisateur FROM utilisateur WHERE token_utilisateur=?");
  $req->execute([$session]);

  if($req->rowCount() == 1){
    header("location: accueil");
  }else{

  }

}else{

}

?>
<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>Regal Admin</title>
  <!-- base:css -->
  <link rel="stylesheet" href="../vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="../vendors/feather/feather.css">
  <link rel="stylesheet" href="../vendors/base/vendor.bundle.base.css">
  <!-- endinject -->
  <!-- plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="../css/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="../images/favicon.png" />
  <style>
        .form-group {
            margin-bottom: 15px;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        .form-group input:focus {
            outline: none;
            border-color: #007BFF;
        }

        .form-group input.error {
            border-color: red;
        }
  </style>
</head>

<body>
  <div class="container-scroller">
    <div class="container-fluid page-body-wrapper full-page-wrapper">
      <div class="content-wrapper d-flex align-items-center auth px-0">
        <div class="row w-100 mx-0">
          <div class="col-lg-4 mx-auto">
            <div class="auth-form-light text-left py-5 px-4 px-sm-5">
              <div class="brand-logo" style="text-align: center;">
                <img src="../images/armoiri.png"  alt="logo">
              </div>
              <h4 class="text-center">Bienvenue sur le portail COTESFIP</h4>
              <!-- <h6 class="font-weight-light text-center">Connectez-vous pour continuer.</h6> -->
              <form method="POST" id="formulaireConnexion" class="pt-3">
                <div class="form-group">
                  <input type="text" class="form-control form-control-lg" id="nomutilisateur" name="nomutilisateur" placeholder="Nom d'utilisateur">
                </div>
                <div class="form-group">
                  <input type="password" class="form-control form-control-lg" id="motdepasse" name="motdepasse" placeholder="Mot de passe">
                </div>
                <div class="mt-3">
                <button type="submit" id="btnFormulaire" class="btn btn-block btn btn-info auth-form-btn">
                    <i class="mdi mdi-login"></i> Se connecter
                  </button>
                </div>
                <div class="my-2 d-flex justify-content-between align-items-center">
                  
                  <a href="#" class="auth-link text-black">Mot de passe oublié ?</a>
                </div>
                
                
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- content-wrapper ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  <!-- base:js -->
  <script src="../vendors/base/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- inject:js -->
  <script src="../js/off-canvas.js"></script>
  <script src="../js/hoverable-collapse.js"></script>
  <script src="../js/template.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <!-- endinject -->

  <script>
    $(document).ready(function() {
        // Vérification des champs lors de la soumission du formulaire
        $('#formulaireConnexion').on('submit', function(e) {
            e.preventDefault(); // Empêche l'envoi du formulaire
            
            let isValid = true;

            // Vérifie chaque champ
            $('#formulaireConnexion input').each(function() {
                if ($(this).val().trim() === '') {
                    $(this).addClass('error'); // Ajoute une classe pour marquer l'erreur
                    isValid = false;
                }
            });

            if (isValid) {
              $("#btnFormulaire").prop('disabled', true);
              $("#btnFormulaire").text('Chargement...');
              $.ajax({
                url: 'traitement/connexion.php',
                method: 'POST',
                dataType: 'text',
                data: $("#formulaireConnexion").serialize(),
                error: function(error){
                  Swal.fire({
                    title: "Erreur!",
                    text: "Une erreur s'est produite",
                    icon: "error"
                  });
                  console.log(error);
                },
                success: function(data) {
                    if(data === "Success"){
                      location.href = "accueil";
                    }else if(data == "Informations incorrectes"){
                      Swal.fire({
                        title: "Erreur!",
                        text: "Nom d'utilisateur ou mot de passe incorrect",
                        icon: "error"
                      });
                    }else if(data === "vide"){
                      Swal.fire({
                        title: "Erreur!",
                        text: "Erreur inconnue",
                        icon: "question"
                      });
                    }else{
                      console.log(data);
                    }
                },
                complete: function(){
                  $("#btnFormulaire").prop('disabled', false);
                  $("#btnFormulaire").text('Se connecter');
                }
              })

            }
        });

        // Remet les bordures normales lorsqu'on commence à taper
        $('#formulaireConnexion input').on('input', function() {
            if ($(this).val().trim() !== '') {
                $(this).removeClass('error');
            }
        });
    });
  </script>

</body>

</html>

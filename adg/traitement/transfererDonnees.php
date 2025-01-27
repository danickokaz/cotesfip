<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';


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
  
      
      $id_service_affecte = $donneesUtilisateur->id_service_affecte;
  
      

        if(isset($_POST['moisVoirDonnees'],$_POST['anneeVoirDonnees'],$_POST['provinces'],$_POST['provinces_finales'])
        and !empty($_POST['moisVoirDonnees']) and !empty($_POST['anneeVoirDonnees']) and !empty($_POST['provinces'])  and !empty($_POST['provinces_finales'])){
            $mois = htmlspecialchars($_POST['moisVoirDonnees']);
            $annee = htmlspecialchars($_POST['anneeVoirDonnees']);
            $provinces = $_POST['provinces'];
            $provinces_finales = $_POST['provinces_finales'];

            //DGI
            if($id_service_affecte==1){
                $req = database()->prepare("SELECT * FROM dgi_statistique WHERE id_mois=? AND annee=? AND id_province=? AND id_etat_donnee=?");
                $req->execute([$mois,$annee,$provinces,3]);

                if($req->rowCount()>=1){
                    $donneesDGI = $req->fetchAll(PDO::FETCH_OBJ);

                    foreach($donneesDGI as $donneeDGI){
                        $id_ordre = $donneeDGI->id_ordre;
                        $id_province = $donneeDGI->id_province;
                        $id_centre_perception = $donneeDGI->id_centre_perception;
                        $code_nature = $donneeDGI->code_nature;
                        $libelle_nature_recette = $donneeDGI->libelle_nature_recette;
                        $id_type_nature_recette =$donneeDGI->id_type_nature_recette;
                        $id_categorie_nature_recette = $donneeDGI->id_categorie_nature_recette;
                        $id_mois = $donneeDGI->id_mois;
                        $anneeDGI = $donneeDGI->annee;
                        $prevision = $donneeDGI->prevision;
                        $realisation = $donneeDGI->realisation;
                        

                        $req = database()->prepare("SELECT * FROM statistiques_globales WHERE
                        id_mois=? AND annee=? AND dgi_id_centre_perception=?  AND dgi_province=? AND id_province_finale=? AND code_recette=? AND libelle_recette=?");
                        $req->execute([$mois, $annee,$id_centre_perception,$provinces,$provinces_finales,$code_nature,$libelle_nature_recette]);

                        if($req->rowCount()==0){
                            $req = database()->prepare("INSERT INTO statistiques_globales (code_transfert,id_etat_donnee,id_service_pourvoyeur,id_mois,annee,
                            prevision,realisation,date_transfert,id_province_finale,code_recette,libelle_recette,
                            dgi_id_centre_perception,id_dgi_ordre,dgi_province,dgi_type_nature_recette,dgi_categorie_nature_recette)
                            VALUES (?,?,?, ?,?,?,?,?,?,?,?,?,?,?,?,?)");
                            $req->execute([time()."/".$id_service_affecte,3,$id_service_affecte,$id_mois,$anneeDGI,$prevision,$realisation,date('Y-m-d'),$provinces_finales,$code_nature, $libelle_nature_recette,$id_centre_perception,$id_ordre,$id_province, $id_type_nature_recette, $id_categorie_nature_recette]);
                        }
                    }

                    echo "success";
                }else{
                    echo "Pas pretes";
                }
            }
            //DGDA
            else if($id_service_affecte==2){

                $req = database()->prepare("SELECT * FROM dgda_statistique WHERE id_mois=? AND annee=? AND id_province=? AND id_etat_donnee=?");
                $req->execute([$mois,$annee,$provinces,3]);

                if($req->rowCount()>=1){
                    $donneesDGDA = $req->fetchAll(PDO::FETCH_OBJ);

                    foreach($donneesDGDA as $donneeDGDA){
                        $id_ordre = $donneeDGDA->id_ordre;
                        $id_province = $donneeDGDA->id_province;
                        $id_centre_perception = $donneeDGDA->id_centre_perception;
                        $code_nature = $donneeDGDA->code_nature;
                        $libelle_nature_recette = $donneeDGDA->libelle_nature_economique;
                        $id_type_nature_recette =$donneeDGDA->id_type_nature_economique;
                        $id_categorie_nature_recette = $donneeDGDA->id_categorie_nature_economique;
                        $id_mois = $donneeDGDA->id_mois;
                        $anneeDGDA = $donneeDGDA->annee;
                        $prevision = $donneeDGDA->prevision;
                        $realisation = $donneeDGDA->realisation;

                        $id_type_secteur_activite = $donneeDGDA->id_type_secteur_activite;
                        $id_categorie_secteur_activite = $donneeDGDA->id_categorie_secteur_activite;
                        $id_secteur_activite = $donneeDGDA->id_secteur_activite;
                        

                        $req = database()->prepare("SELECT * FROM statistiques_globales WHERE
                        id_mois=? AND annee=? AND dgda_id_centre_perception=?  AND dgda_id_province=? AND id_province_finale=? AND code_recette=? AND libelle_recette=?");
                        $req->execute([$mois, $annee,$id_centre_perception,$provinces,$provinces_finales,$code_nature,$libelle_nature_recette]);

                        if($req->rowCount()==0){
                            $req = database()->prepare("INSERT INTO statistiques_globales (code_transfert,id_etat_donnee,id_service_pourvoyeur,id_mois,annee,
                            prevision,realisation,date_transfert,id_province_finale,code_recette,libelle_recette,
                            dgda_id_province,dgda_id_centre_perception,id_dgda_ordre,dgda_id_type_secteur_activite,dgda_id_categorie_secteur_activite,dgda_id_secteur_activite,dgda_id_type_nature_economique,dgda_id_categorie_nature_economique)
                            VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
                            $req->execute([time()."/".$id_service_affecte,3,$id_service_affecte,$id_mois,$anneeDGDA,$prevision,$realisation,date('Y-m-d'),$provinces_finales,$code_nature, $libelle_nature_recette,
                            $id_province,$id_centre_perception,$id_ordre,$id_type_secteur_activite, $id_categorie_secteur_activite,
                            $id_secteur_activite,$id_type_nature_recette, $id_categorie_nature_recette]);
                        }
                    }

                    echo "success";
                }else{
                    echo "Pas pretes";
                }

            }
            //DGRAD
            else if($id_service_affecte==3){

            }else{

            }


        }else{
            echo "Veuillez sélectionner tous les champs";
        }

      
  
  
  
    }else{
        echo "Erreur";
    }
  
  }else{
    echo "Erreur";
  }
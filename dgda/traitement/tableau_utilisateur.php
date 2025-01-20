<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['access']) and !empty($_SESSION['access'])){
    $session = htmlspecialchars($_SESSION['access']);
  
    $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgda_utilisateur WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $id_service_pourvoyeur = $data->id_service_pourvoyeur;

        try{
            $req = database()->prepare("SELECT 
            dgda_utilisateur.token_utilisateur,
            dgda_utilisateur.pseudo,
            dgda_utilisateur.id,
            dgda_utilisateur.id_role,
            province.libelle_province,
            dgda_centre_perception.libelle_centre_perception as libelle_centre,
            etat_utilisateur.libelle_etat as libelle_etat,
            service_pourvoyeur.abreviation as service_utilisateur,
            role_utilisateur.libelle_role as role_utilisateur,
            dgda_centre_perception.libelle_centre_perception as centre_perception
            FROM dgda_utilisateur 
            INNER JOIN service_pourvoyeur ON dgda_utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
            INNER JOIN role_utilisateur ON dgda_utilisateur.id_role = role_utilisateur.id
            INNER JOIN etat_utilisateur ON dgda_utilisateur.id_etat_utilisateur = etat_utilisateur.id
            LEFT JOIN province ON province.id = dgda_utilisateur.id_province
            LEFT JOIN dgda_centre_perception ON  dgda_centre_perception.id = dgda_utilisateur.id_centre_perception
            WHERE dgda_utilisateur.id_service_pourvoyeur=?");
            $req->execute([$id_service_pourvoyeur]);

            $output = '
            <table class="table table-striped">
                <thead>
                    <th>N</th>
                    <th>Pseudo</th>
                    <th>Role</th>
                    <th>Province</th>
                    <th>Centre</th>
                    <th>Etat</th>
                </thead>
                <tbody>';

            if($req->rowCount()>0){
                $data  = $req->fetchAll(PDO::FETCH_OBJ);
                $i = 1;
                foreach($data as $d){
                    $output.= '
                        <tr>
                            <td>'.$i.'</td>
                            <td>'.$d->pseudo.'</td>
                            <td>'.$d->role_utilisateur.'</td>
                            <td>'.$d->libelle_province.'</td>
                            <td>'.$d->libelle_centre.'</td>
                            <td>'.$d->libelle_etat.'</td>

                        </tr>';
                    $i++;
                }
                $output.= '
                    </tbody>
                    </table>
                ';

                echo $output;
            }


            

        }catch(PDOException $e){

        }

        


        

    }else{
        $output .= '
            <tr>
                <td colspan="6" align="center">Aucun utilisateur</td>
            </tr>
            </tbody>
            </table>
        ';
        echo $output;
    }
}
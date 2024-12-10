<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['visa']) and !empty($_SESSION['visa'])){
    $session = htmlspecialchars($_SESSION['visa']);
  
    $req = database()->prepare("SELECT id_service_pourvoyeur FROM utilisateur WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $id_service_pourvoyeur = $data->id_service_pourvoyeur;

        try{
            $req = database()->prepare("SELECT 
            utilisateur.id,
            utilisateur.pseudo,
            service_pourvoyeur.libelle_service,
            role_utilisateur.libelle_role,
            province.libelle_province,
            dgi_centre_perception.libelle_centre,
            etat_utilisateur.libelle_etat
            FROM utilisateur 
            INNER JOIN service_pourvoyeur ON service_pourvoyeur.id = utilisateur.id_service_pourvoyeur
            INNER JOIN role_utilisateur ON role_utilisateur.id = utilisateur.id_role
            LEFT JOIN province ON province.id  = utilisateur.id_province
            LEFT JOIN dgi_centre_perception ON dgi_centre_perception.id = utilisateur.id_centre_perception
            INNER JOIN etat_utilisateur ON etat_utilisateur.id = utilisateur.id_etat_utilisateur
            WHERE utilisateur.id_service_pourvoyeur =?");
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
                            <td>'.$d->libelle_role.'</td>
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
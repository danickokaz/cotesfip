<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['jlk']) and !empty($_SESSION['jlk'])){
    $session = htmlspecialchars($_SESSION['jlk']);
  
    $req = database()->prepare("SELECT id_service_pourvoyeur FROM dgrad_utilisateur WHERE token_utilisateur=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $id_service_pourvoyeur = $data->id_service_pourvoyeur;

        try{
            $req = database()->prepare("SELECT 
                dgrad_utilisateur.pseudo,
                dgrad_utilisateur.id,
                dgrad_utilisateur.id_role,
                service_pourvoyeur.abreviation as service_utilisateur,
                role_utilisateur.libelle_role as role_utilisateur,
                province.libelle_province as libelle_province,
                etat_utilisateur.libelle_etat as libelle_etat
                FROM dgrad_utilisateur 
                INNER JOIN service_pourvoyeur ON dgrad_utilisateur.id_service_pourvoyeur = service_pourvoyeur.id
                INNER JOIN role_utilisateur ON dgrad_utilisateur.id_role = role_utilisateur.id
                LEFT JOIN province ON  province.id = dgrad_utilisateur.id_province
                INNER JOIN etat_utilisateur ON dgrad_utilisateur.id_etat_utilisateur = etat_utilisateur.id
                WHERE id_service_pourvoyeur=?");
            $req->execute([$id_service_pourvoyeur]);

            $output = '
            <table class="table table-striped">
                <thead>
                    <th>N</th>
                    <th>Pseudo</th>
                    <th>Role</th>
                    <th>Province</th>
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
            echo "<p>Ohhhhh</p>";
        }

        


        

    }else{
        $output .= '
            <tr>
                <td colspan="5" align="center">Aucun utilisateur</td>
            </tr>
            </tbody>
            </table>
        ';
        echo $output;
    }
}
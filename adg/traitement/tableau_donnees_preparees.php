<?php 
session_start();
require __DIR__ .'../../../settings/bdd.php';

if(isset($_SESSION['kedadaje']) and !empty($_SESSION['kedadaje'])){
    $session = htmlspecialchars($_SESSION['kedadaje']);
  
    $req = database()->prepare("SELECT id_service_affecte FROM administrateur WHERE token_admin=?");
    $req->execute([$session]);
  
    if($req->rowCount() == 1){
        $data = $req->fetch(PDO::FETCH_OBJ);
        $id_service_affecte = $data->id_service_affecte;



        try{
            $req = database()->prepare("SELECT 
            statistiques_globales.id,
            DATE_FORMAT(statistiques_globales.date_transfert, '%e/%m/%Y') AS date_transfert,
            statistiques_globales.code_transfert,
            mois.libelle_mois,
            statistiques_globales.annee,
            province_dgi.libelle_province AS dgi_province_depart,
            province_dgda.libelle_province AS dgda_province_depart,
            province_finale.libelle_province_fin
            FROM statistiques_globales
            LEFT JOIN mois ON mois.id = statistiques_globales.id_mois
            LEFT JOIN province AS province_dgi ON province_dgi.id = statistiques_globales.dgi_province
            LEFT JOIN province AS province_dgda ON province_dgda.id = statistiques_globales.dgda_id_province
            LEFT JOIN province_finale ON province_finale.id = statistiques_globales.id_province_finale
            WHERE statistiques_globales.id_service_pourvoyeur = ?
            GROUP BY code_transfert ORDER BY id DESC");
            $req->execute([$id_service_affecte]);



            $output = '
            <table class="table table-striped">
                <thead>
                    <th>N</th>
                    <th>DATE</th>
                    <th>CODE</th>
                    <th>MOIS ET ANNEE</th>
                    <th>PROVINCE DEPART</th>
                    <th>PROVINCE FINALE</th>
                    <th>Action</th>
                </thead>
                <tbody>';

            if($req->rowCount()>0){
                $data  = $req->fetchAll(PDO::FETCH_OBJ);
                $i = 1;

                if($id_service_affecte==1){
                    foreach($data as $d){
                        $output.= '
                            <tr>
                                <td>'.$i.'</td>
                                <td>'.$d->date_transfert.'</td>
                                <td>'.$d->code_transfert.'</td>
                                <td>'.$d->libelle_mois.' '.$d->annee.'</td>
                                <td>'.$d->dgi_province_depart.'</td>
                                <td>'.$d->libelle_province_fin.'</td>
                                <td><i class="fa fa-trash supprimer" style="color:red;cursor:pointer;" id="'.$d->code_transfert.'" ></i></td>
                            </tr>';
                        $i++;
                    }
                    $output.= '
                        </tbody>
                        </table>
                    ';
                }
                else if($id_service_affecte==2){
                    foreach($data as $d){
                        $output.= '
                            <tr>
                                <td>'.$i.'</td>
                                <td>'.$d->date_transfert.'</td>
                                <td>'.$d->code_transfert.'</td>
                                <td>'.$d->libelle_mois.' '.$d->annee.'</td>
                                <td>'.$d->dgda_province_depart.'</td>
                                <td>'.$d->libelle_province_fin.'</td>
                                <td><i class="fa fa-trash supprimer" style="color:red;cursor:pointer;" id="'.$d->code_transfert.'" ></i></td>

                            </tr>';
                        $i++;
                    }
                    $output.= '
                        </tbody>
                        </table>
                    ';
                }else{
                    
                }

                

                echo $output;
            }else{
                $output .= '
                    <tr>
                        <td colspan="6" align="center">Aucune information</td>
                    </tr>
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
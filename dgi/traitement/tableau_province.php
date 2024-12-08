<?php
session_start();
require __DIR__ .'../../../settings/bdd.php';



$req =  database()->prepare("SELECT province.id,province.libelle_province,configuration_province.libelle_configuration_province FROM province INNER JOIN configuration_province ON configuration_province.id = province.id_configuration ");
$req->execute();

$output = '
    <table class="table table-striped">
        <thead>
            <th>N</th>
            <th>Libelle</th>
             <th>Configuration</th>
        </thead>
        <tbody>';
if($req->rowCount() > 0){
    $i = 1;
    while($donnees = $req->fetch(PDO::FETCH_OBJ)){
        $output.= '
            <tr>
                <td>'.$i.'</td>
                <td>'.$donnees->libelle_province.'</td>
                <td>'.$donnees->libelle_configuration_province.'</td>
            </tr>';
        $i++;
    }
    $output.= '
        </tbody>
        </table>
    ';
    echo $output;
}else{
    $output .='
        <tr>
            <td colspan="2" align="center">Aucun centre de perception trouvé</td>
        </tr>
        </tbody>
        </table>

    ';
    echo $output;
}
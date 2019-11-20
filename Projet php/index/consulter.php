<?php

    include('configBDD.inc.php'); 
    include_once('connexion.php');
    
    if (isset($_SESSION['UTI_MAIL'])){
        
        $req=$PDO_BDD->prepare("Select UTI_MAIL,UTI_PWD from utilisateur where UTI_MAIL= :mail AND UTI_PWD = :mdp");

        $req->execute(
            array(
                'mail' => $_SESSION['UTI_MAIL'], 'mdp' => $_SESSION['UTI_PWD'])
        );

        if(($req-> rowCount()==1)){
            $resultat = $req->fetch(PDO::FETCH_ASSOC);

            
        }
        
    }

    
    
    

?>
<?php

    if (isset($_REQUEST['connexion'])){
            
        include_once('configBDD.inc.php');

            //  Récupération de l'utilisateur et de son pass hashé
        $req = $PDO_BDD->prepare('SELECT * FROM utilisateur WHERE UTI_MAIL = :mail AND UTI_PWD = :mdp');
        $req->execute(array(
            'mail' => $_REQUEST['mail'], 'mdp' => sha1($_REQUEST['mdp']) ));

        if(($req-> rowCount()==1)){
            $resultat = $req->fetch(PDO::FETCH_ASSOC);
            session_start();

            
            $_SESSION['UTI_MAIL'] = $resultat['UTI_MAIL'];
            $_SESSION['UTI_PWD'] = $resultat['UTI_PWD'];

            echo 'vous êtes connectés';
            header('location:index.php');

            
        }
        else{
            echo 'Erreur de mail et/ou mdp';
        }
    


    }

    

    
?>
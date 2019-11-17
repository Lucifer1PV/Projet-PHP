<?php
	// traitment des données du formulaire
	if (isset($_REQUEST['valid']))
		{
			// vérification de la validité des données
			if (   !empty($_REQUEST['mail']) 
				&& !empty($_REQUEST['mdp'])
				&& !empty($_REQUEST['nom'])
				&& !empty($_REQUEST['date'])
				&& !empty($_REQUEST['diplome'])
				&& !empty($_REQUEST['prenom'])

				&& ($_REQUEST['mdp']== $_REQUEST['confirm']) )
				{
					// connexion à la BDD
					include('configBDD.inc.php');
					
					// insertion des données dans la table
					if (is_null($_REQUEST['tel']))
						$tel='NULL';
					else
						$tel="'$_REQUEST[tel]'";

					// création et exécution de la requête, avec gestion des erreurs de requête		
					try{
						$PDO_BDD->exec("UPDATE utilisateur SET idUser= idUser + 1");
						$PDO_BDD->exec("INSERT into utilisateur(mail,mdp,nom,prenom,status) values('$_REQUEST[mail]',SHA1('$_REQUEST[mdp]'),'$_REQUEST[nom]','$_REQUEST[prenom]', 'Membre')");
						$PDO_BDD->exec("INSERT into membre(dateNais,tel,diplomeP) values ('$_REQUEST[date]','$_REQUEST[tel]','$_REQUEST[diplome]')");
					}
					catch(Exception $e){
						die ('Erreur : '.$e->getMessage().'<br/>');
					}

					// redirection vers la pas d'authentification
					header('location:signin.php');
				}
			else
				echo "Les champs marqués d'une * sont obligatoires et le mdp doit correspondre à la confirmation</br>";
				
		}
		
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author"      content="Sergey Pozhilov (GetTemplate.com)">
	
	<title>Sign up</title>

	<link rel="shortcut icon" href="assets/images/gt_favicon.png">
	
	<link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/css/font-awesome.min.css">

	<!-- Custom styles for our template -->
	<link rel="stylesheet" href="assets/css/bootstrap-theme.css" media="screen" >
	<link rel="stylesheet" href="assets/css/main.css">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="assets/js/html5shiv.js"></script>
	<script src="assets/js/respond.min.js"></script>
	<![endif]-->
</head>

<body>
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse navbar-fixed-top headroom" >
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
				<a class="navbar-brand" href="index.php"><img src="assets/images/logo.png" alt="Progressus HTML5 template"></a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right">
					<li><a href="index.php">Home</a></li>
					<li><a href="stage.php">Stage</a></li>
					<li><a href="contact.php">Contact</a></li>
					<li class="active"><a class="btn" href="signin.php">SIGN IN / SIGN UP</a></li>
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div> 
	<!-- /.navbar -->

	<header id="head" class="secondary"></header>

	<!-- container -->
	<div class="container">

		<ol class="breadcrumb">
			<li><a href="index.php">Home</a></li>
			<li class="active">Registration</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title">Création compte membre</h1>
				</header>
				
				<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
					<div class="panel panel-default">
						<div class="panel-body">

								<script>
										function check(input) {
										  if (input.value != document.getElementById('mdp').value) {
											input.setCustomValidity('les mots de passe doivent identiques');
										  } else {
											// input is valid -- reset the error message
											input.setCustomValidity('');
										  }
										}
								</script>

							<p class="text-center text-muted">Déjà inscrit? connectez vous ici, <a href="signin.php">Login</a> </p>
							<hr>

							<form>
								<div class="top-margin">
									<label>Prenom</label>
									<input type="text" class="form-control" name="prenom">
								</div>
								<div class="top-margin">
									<label>Nom</label>
									<input type="text" class="form-control" name="nom">
								</div>
								<div class="top-margin">
									<label>Email Address <span class="text-danger">*</span></label>
									<input type="email" class="form-control" name="mail">
								</div>
								<div class="top-margin">
									<label>Telephone <span class="text-danger">*</span></label>
									<input type="tel" class="form-control" name="tel">
									
								</div>
								<div class="top-margin">
									<label>Date de naissance <span class="text-danger">*</span></label>
									<input type="date" class="form-control" name="date">
									
								</div>
								<div class="top-margin">
									<label>Diplome <span class="text-danger">*</span></label>
									<input type="text" class="form-control" name="diplome">
									
								</div>

								<div class="row top-margin">
									<div class="col-sm-6">
										<label>Password <span class="text-danger">*</span></label>
										<input type="password" class="form-control" name="mdp">
									</div>
									<div class="col-sm-6">
										<label>Confirm Password <span class="text-danger">*</span></label>
										<input type="password" class="form-control" name="confirm">
									</div>
								</div>

								<div class="row">
									<div class="col-lg-8 text-right">
                                        <button class="btn btn-action" type="submit" name="valid">Register</button>
                                        
									</div>
								</div>
							</form>
						</div>
					</div>

				</div>
				
			</article>
			<!-- /Article -->

		</div>
	</div>	<!-- /container -->
	

	<footer id="footer" class="top-space">

		<div class="footer1">
			<div class="container">
				<div class="row">
					
					<div class="col-md-3 widget">
						<h3 class="widget-title">Contact</h3>
						<div class="widget-body">
							<p>+234 23 9873237<br>
								<a href="mailto:#">some.email@somewhere.com</a><br>
								<br>
								234 Hidden Pond Road, Ashland City, TN 37015
							</p>	
						</div>
					</div>

					<div class="col-md-3 widget">
						<h3 class="widget-title">Follow me</h3>
						<div class="widget-body">
							<p class="follow-me-icons clearfix">
								<a href=""><i class="fa fa-twitter fa-2"></i></a>
								<a href=""><i class="fa fa-dribbble fa-2"></i></a>
								<a href=""><i class="fa fa-github fa-2"></i></a>
								<a href=""><i class="fa fa-facebook fa-2"></i></a>
							</p>	
						</div>
					</div>

					<div class="col-md-6 widget">
						<h3 class="widget-title">Text widget</h3>
						<div class="widget-body">
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Excepturi, dolores, quibusdam architecto voluptatem amet fugiat nesciunt placeat provident cumque accusamus itaque voluptate modi quidem dolore optio velit hic iusto vero praesentium repellat commodi ad id expedita cupiditate repellendus possimus unde?</p>
							<p>Eius consequatur nihil quibusdam! Laborum, rerum, quis, inventore ipsa autem repellat provident assumenda labore soluta minima alias temporibus facere distinctio quas adipisci nam sunt explicabo officia tenetur at ea quos doloribus dolorum voluptate reprehenderit architecto sint libero illo et hic.</p>
						</div>
					</div>

				</div> <!-- /row of widgets -->
			</div>
		</div>

		<div class="footer2">
			<div class="container">
				<div class="row">
					
					<div class="col-md-6 widget">
						<div class="widget-body">
							<p class="simplenav">
								<a href="#">Home</a> | 
								<a href="stage.php">Stage</a> |
								<a href="contact.php">Contact</a> |
								<b><a href="TypeSignUp.php">Sign up</a></b>
							</p>
						</div>
					</div>

					<div class="col-md-6 widget">
						<div class="widget-body">
							<p class="text-right">
								Copyright &copy; 2014, Your name. Designed by <a href="http://gettemplate.com/" rel="designer">gettemplate</a> 
							</p>
						</div>
					</div>

				</div> <!-- /row of widgets -->
			</div>
		</div>
	</footer>	
		




	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="assets/js/headroom.min.js"></script>
	<script src="assets/js/jQuery.headroom.min.js"></script>
	<script src="assets/js/template.js"></script>
</body>
</html>

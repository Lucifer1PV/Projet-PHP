drop database ma_base;
drop user u_stage@localhost;

CREATE DATABASE `ma_base` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
use `ma_base`;

CREATE USER 'u_stage'@'localhost' IDENTIFIED BY 'abcd';
GRANT USAGE ON * . * TO 'u_stage'@'localhost' IDENTIFIED BY 'abcd' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
GRANT ALL PRIVILEGES ON `ma_base` . * TO 'u_stage'@'localhost';
-- 
-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Structure de la table `entreprise`
--

CREATE TABLE `entreprise` (
  `idEnt` int(11) NOT NULL,
  `raisonSociale` varchar(25) NOT NULL,
  `tel` varchar(10) NOT NULL,
  `actif` tinyint(1) NOT NULL
);

-- --------------------------------------------------------

--
-- Structure de la table `likes`
--

CREATE TABLE `likes` (
  `nbLikes` int(11) DEFAULT NULL,
  `idOffre` int(11) DEFAULT NULL,
  `idUser` int(11) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

CREATE TABLE `membre` (
  `id_membre` int(11) DEFAULT 0 ,
  `dateNais` date DEFAULT NULL,
  `tel` varchar(10) NOT NULL,
  `diplomeP` varchar(50) DEFAULT NULL
);

-- --------------------------------------------------------

--
-- Structure de la table `offre`
--

CREATE TABLE `offre` (
  `idOffre` int(11) NOT NULL UNIQUE,
  `titre` varchar(40) NOT NULL,
  `duree` int(11) NOT NULL,
  `dateDebut` date NOT NULL,
  `mission` varchar(150) NOT NULL,
  `contact` varchar(60) NOT NULL,
  `pieceJointe` varchar(150) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `idUser` int(11) NOT NULL UNIQUE DEFAULT 1,
  `nom` varchar(25) NOT NULL,
  `prenom` varchar(25) NOT NULL,
  `mail` varchar(50) NOT NULL,
  `mdp` varchar(50) NOT NULL,
  `status` varchar(10) NOT NULL
) ;

-- ----------------------------------------------------------
--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `texte` varchar(200) DEFAULT NULL,
  `idOffre` int(11) NOT NULL,
  `idUser` int(11) NOT NULL
);

-- --------------------------------------------------------

--
-- Index pour les tables exportées
--

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `FK_Comment_Offre` FOREIGN KEY (`idOffre`) REFERENCES `offre` (`idOffre`),
  ADD CONSTRAINT `FK_Comment_User` FOREIGN KEY (`idUser`) REFERENCES `utilisateur` (`idUser`);


--
-- Index pour la table `entreprise`
--
ALTER TABLE `entreprise`
  ADD PRIMARY KEY (`idEnt`);

--
-- Index pour la table `likes`
--
ALTER TABLE `likes`
  ADD KEY `FK_Likes_Offre` (`idOffre`),
  ADD KEY `FK_Likes_Utilisateur` (`idUser`);

--
-- Index pour la table `membre`
--
ALTER TABLE `membre`
  ADD PRIMARY KEY (`id_membre`);

--
-- Index pour la table `offre`
--
ALTER TABLE `offre`
  ADD PRIMARY KEY (`idOffre`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`idUser`);

--
-- Contraintes pour les tables exportées
--


--
-- Contraintes pour la table `entreprise`
--
ALTER TABLE `entreprise`
  ADD CONSTRAINT `Entreprise_User_FK` FOREIGN KEY (`idEnt`) REFERENCES `utilisateur` (`idUser`);

--
-- Contraintes pour la table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `FK_Likes_Offre` FOREIGN KEY (`idOffre`) REFERENCES `offre` (`idOffre`),
  ADD CONSTRAINT `FK_Likes_Utilisateur` FOREIGN KEY (`idUser`) REFERENCES `utilisateur` (`idUser`);

--
-- Contraintes pour la table `membre`
--
ALTER TABLE `membre`
  ADD CONSTRAINT `Membre_User_FK` FOREIGN KEY (`id_membre`) REFERENCES `utilisateur` (`idUser`);


insert into  utilisateur  values(1,'adminBDD','..','johan.bosquet@etu.univ-amu.fr',sha1('abcd'),'admin');

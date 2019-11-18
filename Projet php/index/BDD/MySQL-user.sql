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
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `idUser` SERIAL NOT NULL  primary key,
  `nom` varchar(25) NULL,
  `prenom` varchar(25) NULL,
  `mail` varchar(50) NOT NULL,
  `mdp` varchar(50) NOT NULL,
  `status` varchar(10) NOT NULL
) ;


--
-- Structure de la table `entreprise`
--

CREATE TABLE `entreprise` (
  `idEnt` int NOT NULL primary key,
  `idUser` SERIAL NOT NULL,
  `raisonSociale` varchar(150) NOT NULL,
  `tel` varchar(10) NOT NULL,
  `actif` boolean NOT NULL,
  CONSTRAINT Entreprise_User_FK FOREIGN KEY(idUser) REFERENCES utilisateur(idUser)
);

-- --------------------------------------------------------

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

CREATE TABLE membre
(
    idMembre INT NOT NULL DEFAULT 1 primary key,
    `idUser` SERIAL NOT NULL,
    dateNaiss DATE NOT NULL,
    tel VARCHAR(14) NOT NULL,
    diplomePrep VARCHAR(50),
    CONSTRAINT Membre_UserSite_FK FOREIGN KEY (idUSer)
        REFERENCES utilisateur(idUser)
);

-- --------------------------------------------------------

--
-- Structure de la table `offre`
--

CREATE TABLE `offre` (
   idOffre int NOT NULL primary key,
  `idUser` SERIAL NOT NULL,
  `titre` varchar(40) NOT NULL,
  `duree` int(11) NOT NULL,
  `dateDebut` date NOT NULL,
  `mission` varchar(150) NOT NULL,
  `contact` varchar(60) NOT NULL,
  `pieceJointe` varchar(150) NOT NULL
) ;

-- --------------------------------------------------------



-- ----------------------------------------------------------
--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `texte` varchar(200) DEFAULT NULL,
   idOffre int NOT NULL,
  `idUser` SERIAL NOT NULL
);

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `FK_Comment_Offre` FOREIGN KEY (`idOffre`) REFERENCES `offre` (`idOffre`),
  ADD CONSTRAINT `FK_Comment_User` FOREIGN KEY (`idUser`) REFERENCES `utilisateur` (`idUser`);

-- -------------------------------------------------------------
--
-- Structure de la table `likes`
--

CREATE TABLE `likes` (
  `nbLikes` int DEFAULT NULL,
  `idUser` SERIAL NOT NULL,
  `idOffre` int NOT NULL
);

--
-- Contraintes pour la table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `FK_Likes_Offre` FOREIGN KEY (`idOffre`) REFERENCES `offre` (`idOffre`),
  ADD CONSTRAINT `FK_Likes_Utilisateur` FOREIGN KEY (`idUser`) REFERENCES `utilisateur` (`idUser`);

--
-- ---------------------------------------------------------------
--





insert into  utilisateur  values(1,'adminBDD','..','johan.bosquet@etu.univ-amu.fr',sha1('abcd'),'admin');

drop database ma_base;
drop user u_stage@localhost;

CREATE DATABASE `ma_base` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
use `ma_base`;

CREATE USER 'u_stage'@'localhost' IDENTIFIED BY 'abcd';
GRANT USAGE ON * . * TO 'u_stage'@'localhost' IDENTIFIED BY 'abcd' WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0 ;
GRANT ALL PRIVILEGES ON `ma_base` . * TO 'u_stage'@'localhost';
-- 
-- --------------------------------------------------------

-- 
-- Table statut qui va stocker les différents statut possible (entreprise,membre,admin)un id correspondra a un statut
CREATE TABLE IF NOT EXISTS `STATUT`(
	ID_STATUT int(2) PRIMARY KEY,
	NOM_STATUT varchar (255) NOT NULL
);
-- Table des utilisateurs

CREATE TABLE IF NOT EXISTS `UTILISATEUR` (
  ID_USER SERIAL NOT NULL  PRIMARY KEY ,
  UTI_PWD  varchar(255) NOT NULL,
  UTI_MAIL varchar(255) NOT NULL,
  UTI_NOM varchar(255) NOT NULL,
  UTI_PRENOM varchar(255) NOT NULL,
  ID_STATUT int(2),
  FOREIGN KEY (`ID_STATUT`) references `STATUT`(`ID_STATUT`) on delete no action on update cascade
);
-- Table entreprise
CREATE TABLE IF NOT EXISTS `ENTREPRISE`(
	ID_ENTREPRISE int(2) PRIMARY KEY,
	RAISON_SOCIALE varchar(255) NOT NULL,
	TEL varchar(16) NOT NULL,
	ID_USER SERIAL NOT NULL,
	FOREIGN KEY (ID_USER) REFERENCES UTILISATEUR(ID_USER)on delete cascade on update cascade,
	actif boolean default false
);
-- Table membre
CREATE TABLE IF NOT EXISTS `MEMBRE`(
	ID_MEMBRE int(2) PRIMARY KEY,
	DATE_NAIS date NOT NULL,
	TEL varchar(16) NOT NULL,
	ID_USER SERIAL NOT NULL,
	FOREIGN KEY (ID_USER) REFERENCES UTILISATEUR(ID_USER)on delete cascade on update cascade,
	DIPLOME_PREP varchar(255) NOT NULL
);
-- Table offre de stage 
CREATE TABLE IF NOT EXISTS `OFFRE`(
	ID_OFFRE int(10) PRIMARY KEY,
	TITRE varchar(255) NOT NULL,
	DATE_DEBUT date NOT NULL,
	MISSION varchar(255) NOT NULL,
	CONTACT varchar(255) NOT NULL
);
-- Table commentaire 
CREATE TABLE IF NOT EXISTS `COMMENTAIRE`(
	ID_USER SERIAL NOT NULL,
	ID_OFFRE int(10),
    FOREIGN KEY (ID_USER) REFERENCES UTILISATEUR(ID_USER)on delete no action on update cascade,
	FOREIGN KEY (ID_OFFRE) REFERENCES OFFRE(ID_OFFRE)on delete no action on update cascade,
	TEXTE varchar(255) NOT NULL
);
-- Table gestion des likes sur un articles
CREATE TABLE IF NOT EXISTS `LIKE`(
	ID_USER SERIAL NOT NULL,
	FOREIGN KEY (ID_USER) REFERENCES UTILISATEUR(ID_USER)on delete no action on update cascade,
	ID_OFFRE int(10),
	FOREIGN KEY (ID_OFFRE) REFERENCES OFFRE(ID_OFFRE)on delete no action on update cascade,
	ouiLIKER boolean
);

INSERT INTO STATUT VALUES(1,"membre");
INSERT INTO STATUT VALUES(2,"entreprise");
INSERT INTO STATUT VALUES(3,"admin");

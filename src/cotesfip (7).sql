-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : sam. 14 déc. 2024 à 14:02
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `cotesfip`
--

-- --------------------------------------------------------

--
-- Structure de la table `affectation_province_utilisateur`
--

CREATE TABLE `affectation_province_utilisateur` (
  `id` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `id_province` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `affectation_province_utilisateur`
--

INSERT INTO `affectation_province_utilisateur` (`id`, `id_utilisateur`, `id_province`) VALUES
(1, 1, 14);

-- --------------------------------------------------------

--
-- Structure de la table `configuration_province`
--

CREATE TABLE `configuration_province` (
  `id` int(11) NOT NULL,
  `libelle_configuration_province` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `configuration_province`
--

INSERT INTO `configuration_province` (`id`, `libelle_configuration_province`) VALUES
(1, 'Ancienne'),
(2, 'Nouvelle');

-- --------------------------------------------------------

--
-- Structure de la table `dgi_affectation_centre_perception`
--

CREATE TABLE `dgi_affectation_centre_perception` (
  `id` int(11) NOT NULL,
  `id_centre_perception` int(11) NOT NULL,
  `id_province` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dgi_categorie_nature_impot`
--

CREATE TABLE `dgi_categorie_nature_impot` (
  `id` int(11) NOT NULL,
  `libelle_categorie_nature_impot` text NOT NULL,
  `id_type_nature_impot` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgi_categorie_nature_impot`
--

INSERT INTO `dgi_categorie_nature_impot` (`id`, `libelle_categorie_nature_impot`, `id_type_nature_impot`) VALUES
(1, 'IMPÔTS SUR LES REMUNERATIONS', 1),
(2, 'IMPÔTS SUR LES BENEFICES ET PROFITS ET SUR LES REVENUS DES CAPITAUX MOBILIERS', 1),
(3, 'IMPOTS ET TAXES SUR LES BIENS ET SERVICES', 1),
(4, 'AUTRES RECETTES', 1);

-- --------------------------------------------------------

--
-- Structure de la table `dgi_centre_perception`
--

CREATE TABLE `dgi_centre_perception` (
  `id` int(11) NOT NULL,
  `libelle_centre` text NOT NULL,
  `id_province` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgi_centre_perception`
--

INSERT INTO `dgi_centre_perception` (`id`, `libelle_centre`, `id_province`) VALUES
(1, 'DGE ', 1),
(2, 'CDI', 1),
(3, ' BUREAU VEHICULES', 1),
(4, 'BANDALUNGWA', 1),
(5, 'BARUMBU', 1),
(6, 'BUMBU', 1),
(7, 'GOMBE', 1),
(8, 'KALAMU', 1),
(9, 'KASA-VUBU', 1),
(10, 'KIMBANSEKE', 1),
(11, 'KINSHASA', 1),
(12, 'KINTAMBO', 1),
(13, 'KISENSO', 1),
(14, 'LEMBA', 1),
(15, 'LIMETE', 1),
(16, 'LINGWALA', 1),
(17, 'MAKALA', 1),
(18, 'MALUKU', 1),
(19, 'MASINA', 1),
(20, 'MATETE', 1),
(21, 'MONT-NGAFULA', 1),
(22, 'N\'DJILI', 1),
(23, 'NGABA', 1),
(24, 'NGALIEMA', 1),
(25, 'NGIRI NGIRI', 1),
(26, 'NSELE', 1),
(27, 'SELEMBAO', 1),
(28, 'CIS BONDO', 2),
(29, 'CIS BUTA', 2),
(30, 'SMM/ MBANDAKA', 3),
(31, ' BUREAU VEHICULES', 3),
(32, 'CIS MBANDAKA', 3),
(33, 'CIS BASANKUSU', 3),
(34, 'CIS LUKOLELA', 3),
(35, 'CDI /LUBUMBASHI', 4),
(36, ' BUREAU VEHICULES', 4),
(37, 'CIS LUBUMBASHI', 4),
(38, 'CIS LIKASI', 4),
(39, 'CIS KAMALONDO', 4),
(40, 'CIS ANNEXE', 4),
(41, 'CIS KAPEMBA-RUASHI', 4),
(42, 'CIS KATUBA', 4),
(43, 'CIS KENYA', 4),
(44, 'CIS KIPUSHI', 4),
(45, 'CIS SAKANIA', 4),
(46, 'CIS KAMINA', 5),
(47, 'CIS KANIAMA-KASESE', 5),
(48, 'CIS ISIRO', 6),
(49, 'CIS WATSA', 6),
(50, 'CIS DUNGU', 6),
(51, 'CIS BUNIA', 7),
(52, 'CIS DJUGU', 7),
(53, 'CIS ARU', 7),
(54, 'CIS MAHAGI', 7),
(55, 'CIS MAMBASA', 7),
(56, 'SIEGE/TPA', 8),
(57, 'LUEBO', 8),
(58, 'TSHIKAPA I', 8),
(59, 'TSHIKAPA II', 8),
(60, 'ILEBO', 8),
(61, 'KAMONIA', 8),
(62, 'MUEKA', 8),
(63, 'DEKESE', 8),
(64, 'SIEGE(KNGA)', 9),
(65, ' BUREAU VEHICULES', 9),
(66, 'KANANGA I', 9),
(67, 'KANANGA II', 9),
(68, 'KANANGA III', 9),
(69, 'DEMBA', 9),
(70, 'DIBAYA', 9),
(71, 'DIMBELENGE', 9),
(72, 'KAZUMBA', 9),
(73, 'LUIZA', 9),
(74, 'SIEGE', 10),
(75, ' BUREAU VEHICULES', 10),
(76, 'CIS MUYA', 10),
(77, 'CIS DIULU', 10),
(78, 'CIS MIABI', 10),
(79, 'CIS DIBINDI', 10),
(80, 'CDI MATADI', 11),
(81, ' BUREAU VEHICULES', 11),
(82, 'CIS BOMA', 11),
(83, 'CIS INKISI', 11),
(84, 'CIS KASANGULU', 11),
(85, 'CIS KIMPESE', 11),
(86, 'CIS KINZAU-MVUETE', 11),
(87, 'CIS LUOZI', 11),
(88, 'CIS MATADI', 11),
(89, 'CIS MBANZA-NGUNGU', 11),
(90, 'CIS MUANDA', 11),
(91, 'CIS NZAMVU', 11),
(92, 'CIS TSHELA', 11),
(94, 'CIS KAHEMBA', 12),
(95, 'CIS KASONGO-LUNDA', 12),
(96, 'CIS KENGE', 12),
(97, 'SMM/BANDUNDU', 13),
(98, ' BUREAU VEHICULES', 13),
(99, 'CIS BANDUNDU', 13),
(100, 'CIS BULUNGU', 13),
(101, 'CIS IDIOFA', 13),
(102, 'CIS KIKWIT', 13),
(103, 'CIS MASI MANIMBA', 13),
(104, 'CIS MWENE DITU', 14),
(105, 'CIS NGANDAJIKA', 14),
(106, 'CIS KABINDA', 14),
(107, 'CIS LUILU', 14),
(108, 'CIS KOLWEZI', 15),
(109, 'CIS KASAJI', 15),
(110, 'CIS BOLOBO', 16),
(111, 'CIS INONGO', 16),
(112, 'CIS NIOKI', 16),
(113, 'I.SIEGE/DIRECTION', 17),
(114, ' BUREAU VEHICULES', 17),
(115, 'CIS KINDU', 17),
(116, 'CIS KASONGO', 17),
(117, 'CIS KALIMA', 17),
(118, 'CIS KABAMBARE', 17),
(119, 'CIS PUNIA', 17),
(120, 'CIS LUBUTU', 17),
(121, 'CIS LISALA', 18),
(122, 'CIS BUMBA', 18),
(123, 'CDI- GOMA', 19),
(124, ' BUREAU VEHICULES', 19),
(125, 'CIS BENI', 19),
(126, 'CIS BUTEMBO 1', 19),
(127, 'CIS BUTEMBO 2', 19),
(128, 'CIS GOMA 1', 19),
(129, 'CIS GOMA 2', 19),
(130, 'CIS LUBERO', 19),
(131, 'CIS MASISI', 19),
(132, 'CIS RUTSHURU', 19),
(133, 'CIS WALIKALE', 19),
(135, 'CIS GBADOLITE', 20),
(136, 'CIS BUSINGA', 20),
(137, 'CIS LODJA', 21),
(138, 'CIS LUSAMBO', 21),
(139, 'SIEGE', 22),
(140, ' BUREAU VEHICULES', 22),
(141, 'CIS BAGIRA', 22),
(142, 'CIS FIZI', 22),
(143, 'CIS IBANDA ', 22),
(144, 'CIS KADUTU', 22),
(145, 'CIS KALEHE', 22),
(146, 'CIS MWENGA ', 22),
(147, 'CIS SHABUNDA', 22),
(148, 'CIS UVIRA ', 22),
(149, 'CIS WALUNGU', 22),
(150, 'CIS GEMENA', 23),
(151, 'CIS ZONGO', 23),
(152, 'CIS KUNGU', 23),
(153, 'CIS KALEMIE', 24),
(154, 'CIS KONGOLO', 24),
(155, 'CDI KISANGANI', 25),
(156, ' BUREAU VEHICULES', 25),
(157, 'CIS KISANGANI I', 25),
(158, 'CIS KISANGANI II', 25),
(159, 'CIS  ISANGI', 25),
(160, 'CIS BAFWASENDE', 25),
(161, 'CIS BOENDE', 26),
(162, 'CIS BOKUNGU ', 26);

-- --------------------------------------------------------

--
-- Structure de la table `dgi_nature_impot`
--

CREATE TABLE `dgi_nature_impot` (
  `id` int(11) NOT NULL,
  `code_nature_impot` varchar(50) DEFAULT NULL,
  `libelle_nature_impot` text NOT NULL,
  `id_type_nature_impot` int(11) DEFAULT NULL,
  `id_categorie_nature_impot` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgi_nature_impot`
--

INSERT INTO `dgi_nature_impot` (`id`, `code_nature_impot`, `libelle_nature_impot`, `id_type_nature_impot`, `id_categorie_nature_impot`) VALUES
(1, '171 111 10', 'Impôt sur les revenus salariaux des Nationaux/Hors membres des Institutions politiques et fonctionnaires et agents publics', 1, 1),
(2, '171 111 20', 'Impôt sur les revenus salariaux des Nationaux/Membres des Institutions Politiques', 1, 1),
(3, '171 111 30', 'Impôt sur les revenus salariaux des Nationaux/Fonctionnaires et Agents publics', 1, 1),
(4, '171 111 31', 'Impôt sur les revenus salariaux des Nationaux/Autres fonctionnaires et Agents publics', 1, 1),
(5, '171 111 32', 'Impôt sur les revenus salariaux des Nationaux/Agents des Régies financières', 1, 1),
(6, '171 112 00', 'Impôt sur les revenus salariaux des Expatriés', 1, 1),
(7, '171 114 00', 'Impôt Exceptionnel sur les rémunérations versées aux Expatriés (IERE)', 1, 1),
(8, '171 121 00', 'Impôt sur les bénéfices et profits des grandes et moyennes entreprises non pétrolières de production', 1, 2),
(9, '999 999 01', 'impôt spécial sur les profits excédentaires', 1, 2),
(10, '999 999 02', 'Impôt Spécial sur les Plus-Values de cessions d\'actions ou de parts sociales', 1, 2),
(11, '171 123 00', 'Impôt sur les bénéfices et profits des entreprises de petite taille', 1, 2),
(12, '171 123 10/171 123 20', 'Impôt sur les bénéfices et profits des petites entreprises', 1, 2),
(13, '171 123 30', 'Impôt sur les bénéfices et profits des micro-entreprises', 1, 2),
(14, '171 124 00', 'Impôt professionnel sur les prestations de services des non résidents', 1, 2),
(15, '171 130 00', 'Impôt sur les revenus des capitaux mobiliers', 1, 2),
(16, '999 999 03', 'Impôt sur le Chiffre d\'Affaires à l\'Intérieur', 1, 3),
(17, '171 341 10', 'Immatriculation des véhicules', 1, 4),
(18, '270 122 29', 'Vente des imprimés', 1, 4),
(19, '371 370 00', 'Amendes et pénalités', 1, 4),
(20, '171 311 00', 'TAXE SUR LA VALEUR AJOUTEE SUR DECLARATIONS', 2, NULL),
(21, '999 999 04', 'TAXE SUR LA VALEUR AJOUTEE RECOUVREE SUR AMR A', 2, NULL),
(22, '999 999 05', 'IBP DES PETROLIERS PRODUCTEURS', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `dgi_statistique`
--

CREATE TABLE `dgi_statistique` (
  `id` int(11) NOT NULL,
  `id_ordre` int(11) NOT NULL,
  `id_province` int(11) NOT NULL,
  `id_centre_perception` int(11) NOT NULL,
  `code_nature` varchar(50) DEFAULT NULL,
  `libelle_nature_recette` text DEFAULT NULL,
  `id_type_nature_recette` int(11) DEFAULT NULL,
  `id_categorie_nature_recette` int(11) DEFAULT NULL,
  `id_mois` int(11) NOT NULL,
  `annee` varchar(4) NOT NULL,
  `prevision` decimal(15,2) DEFAULT NULL,
  `realisation` decimal(15,2) DEFAULT NULL,
  `date_ajout` date NOT NULL,
  `id_etat_donnee` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgi_statistique`
--

INSERT INTO `dgi_statistique` (`id`, `id_ordre`, `id_province`, `id_centre_perception`, `code_nature`, `libelle_nature_recette`, `id_type_nature_recette`, `id_categorie_nature_recette`, `id_mois`, `annee`, `prevision`, `realisation`, `date_ajout`, `id_etat_donnee`) VALUES
(1, 1, 1, 1, '171 111 10', 'Impôt sur les revenus salariaux des Nationaux/Hors membres des Institutions politiques et fonctionnaires et agents publics', 1, 1, 1, '2024', 323540.62, 298545.80, '2024-12-14', 1),
(2, 2, 1, 1, '171 111 20', 'Impôt sur les revenus salariaux des Nationaux/Membres des Institutions Politiques', 1, 1, 1, '2024', 334551.63, 183378.72, '2024-12-14', 1),
(3, 3, 1, 1, '171 111 30', 'Impôt sur les revenus salariaux des Nationaux/Fonctionnaires et Agents publics', 1, 1, 1, '2024', 387635.08, 186025.50, '2024-12-14', 1),
(4, 4, 1, 1, '171 111 31', 'Impôt sur les revenus salariaux des Nationaux/Autres fonctionnaires et Agents publics', 1, 1, 1, '2024', 319827.57, 293239.31, '2024-12-14', 1),
(5, 5, 1, 1, '171 111 32', 'Impôt sur les revenus salariaux des Nationaux/Agents des Régies financières', 1, 1, 1, '2024', 233274.50, 179821.74, '2024-12-14', 1),
(6, 6, 1, 1, '171 112 00', 'Impôt sur les revenus salariaux des Expatriés', 1, 1, 1, '2024', 123034.27, 119001.96, '2024-12-14', 1),
(7, 7, 1, 1, '171 114 00', 'Impôt Exceptionnel sur les rémunérations versées aux Expatriés (IERE)', 1, 1, 1, '2024', 333903.35, 146960.30, '2024-12-14', 1),
(8, 8, 1, 1, '171 121 00', 'Impôt sur les bénéfices et profits des grandes et moyennes entreprises non pétrolières de production', 1, 2, 1, '2024', 499556.97, 410205.82, '2024-12-14', 1),
(9, 9, 1, 1, '999 999 01', 'Impôt spécial sur les profits excédentaires', 1, 2, 1, '2024', 10835.84, 9268.91, '2024-12-14', 1),
(10, 10, 1, 1, '999 999 02', 'Impôt Spécial sur les Plus-Values de cessions d\'actions ou de parts sociales', 1, 2, 1, '2024', 495195.60, 258572.42, '2024-12-14', 1),
(11, 11, 1, 1, '171 123 00', 'Impôt sur les bénéfices et profits des entreprises de petite taille', 1, 2, 1, '2024', 438794.76, 281242.16, '2024-12-14', 1),
(12, 12, 1, 1, '171 123 10/171 123 20', 'Impôt sur les bénéfices et profits des petites entreprises', 1, 2, 1, '2024', 69394.29, 39308.78, '2024-12-14', 1),
(13, 13, 1, 1, '171 123 30', 'Impôt sur les bénéfices et profits des micro-entreprises', 1, 2, 1, '2024', 343251.39, 282077.02, '2024-12-14', 1),
(14, 14, 1, 1, '171 124 00', 'Impôt professionnel sur les prestations de services des non résidents', 1, 2, 1, '2024', 197038.26, 42162.75, '2024-12-14', 1),
(15, 15, 1, 1, '171 130 00', 'Impôt sur les revenus des capitaux mobiliers', 1, 2, 1, '2024', 123455.55, 94041.67, '2024-12-14', 1),
(16, 16, 1, 1, '999 999 03', 'Impôt sur le Chiffre d\'Affaires à l\'Intérieur', 1, 3, 1, '2024', 483105.31, 74726.24, '2024-12-14', 1),
(17, 17, 1, 1, '171 341 10', 'Immatriculation des véhicules', 1, 4, 1, '2024', 301455.67, 168613.64, '2024-12-14', 1),
(18, 18, 1, 1, '270 122 29', 'Vente des imprimés', 1, 4, 1, '2024', 294699.31, 215442.03, '2024-12-14', 1),
(19, 19, 1, 1, '371 370 00', 'Amendes et pénalités', 1, 4, 1, '2024', 377775.40, 238017.00, '2024-12-14', 1),
(20, 20, 1, 1, '171 311 00', 'TAXE SUR LA VALEUR AJOUTEE SUR DECLARATIONS', 2, NULL, 1, '2024', 176344.08, 164310.03, '2024-12-14', 1),
(21, 21, 1, 1, '999 999 04', 'TAXE SUR LA VALEUR AJOUTEE RECOUVREE SUR AMR A', 2, NULL, 1, '2024', 256166.47, 215530.06, '2024-12-14', 1),
(22, 22, 1, 1, '999 999 05', 'IBP DES PETROLIERS PRODUCTEURS', NULL, NULL, 1, '2024', 170456.00, 11117.93, '2024-12-14', 1);

-- --------------------------------------------------------

--
-- Structure de la table `dgi_type_nature_impot`
--

CREATE TABLE `dgi_type_nature_impot` (
  `id` int(11) NOT NULL,
  `libelle_nature_impot` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgi_type_nature_impot`
--

INSERT INTO `dgi_type_nature_impot` (`id`, `libelle_nature_impot`) VALUES
(1, 'HORS TVA'),
(2, 'TVA');

-- --------------------------------------------------------

--
-- Structure de la table `dgi_utilisateur_centre_perception`
--

CREATE TABLE `dgi_utilisateur_centre_perception` (
  `id` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `id_centre_perception` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dgi_utilisateur_province`
--

CREATE TABLE `dgi_utilisateur_province` (
  `id` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  `id_province` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `etat_donnee`
--

CREATE TABLE `etat_donnee` (
  `id` int(11) NOT NULL,
  `libelle_etat_donnee` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `etat_donnee`
--

INSERT INTO `etat_donnee` (`id`, `libelle_etat_donnee`) VALUES
(1, 'En attente'),
(2, 'Validation 1'),
(3, 'Validation 2');

-- --------------------------------------------------------

--
-- Structure de la table `etat_utilisateur`
--

CREATE TABLE `etat_utilisateur` (
  `id` int(11) NOT NULL,
  `libelle_etat` varchar(50) NOT NULL,
  `description_etat` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `etat_utilisateur`
--

INSERT INTO `etat_utilisateur` (`id`, `libelle_etat`, `description_etat`) VALUES
(1, 'Activé', NULL),
(2, 'Désactivé', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `mois`
--

CREATE TABLE `mois` (
  `id` int(11) NOT NULL,
  `libelle_mois` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `mois`
--

INSERT INTO `mois` (`id`, `libelle_mois`) VALUES
(1, 'JANVIER'),
(2, 'FEVRIER'),
(3, 'MARS'),
(4, 'AVRIL'),
(5, 'MAI'),
(6, 'JUIN'),
(7, 'JUILLET'),
(8, 'AOUT'),
(9, 'SEPTEMBRE'),
(10, 'OCTOBRE'),
(11, 'NOVEMBRE'),
(12, 'DECEMBRE');

-- --------------------------------------------------------

--
-- Structure de la table `province`
--

CREATE TABLE `province` (
  `id` int(11) NOT NULL,
  `libelle_province` text NOT NULL,
  `id_configuration` int(1) NOT NULL COMMENT 'Configuration des provinces (Anciennes et nouvelles)',
  `id_service` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `province`
--

INSERT INTO `province` (`id`, `libelle_province`, `id_configuration`, `id_service`) VALUES
(1, 'KINSHASA', 2, 1),
(2, 'BAS-UELE', 2, 1),
(3, 'EQUATEUR', 2, 1),
(4, 'HAUT- KATANGA', 2, 1),
(5, 'HAUT-LOMAMI', 2, 1),
(6, 'HAUT-UELE', 2, 1),
(7, 'ITURI', 2, 1),
(8, 'KASAI', 2, 1),
(9, 'KASAI CENTRAL', 2, 1),
(10, 'KASAI-ORIENTAL', 2, 1),
(11, 'KONGO CENTRAL', 2, 1),
(12, 'KWANGO', 2, 1),
(13, 'KWILU', 2, 1),
(14, 'LOMAMI', 2, 1),
(15, 'LUALABA', 2, 1),
(16, 'MAI-NDOMBE', 2, 1),
(17, 'MANIEMA', 2, 1),
(18, 'MONGALA', 2, 1),
(19, 'NORD-KIVU', 2, 1),
(20, 'NORD-UBANGI', 2, 1),
(21, 'SANKURU', 2, 1),
(22, 'SUD-KIVU', 2, 1),
(23, 'SUD-UBANGI', 2, 1),
(24, 'TANGANYIKA', 2, 1),
(25, 'TSHOPO', 2, 1),
(26, 'TSHUAPA', 2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `role_utilisateur`
--

CREATE TABLE `role_utilisateur` (
  `id` int(11) NOT NULL,
  `libelle_role` varchar(50) NOT NULL,
  `description_role` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `role_utilisateur`
--

INSERT INTO `role_utilisateur` (`id`, `libelle_role`, `description_role`) VALUES
(1, 'Administrateur Service', NULL),
(2, 'Validateur DEP', NULL),
(3, 'Opérateur des saisies', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `service_pourvoyeur`
--

CREATE TABLE `service_pourvoyeur` (
  `id` int(11) NOT NULL,
  `libelle_service` text NOT NULL,
  `abreviation` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `service_pourvoyeur`
--

INSERT INTO `service_pourvoyeur` (`id`, `libelle_service`, `abreviation`) VALUES
(1, 'Direction Générale des Impôts', 'DGI');

-- --------------------------------------------------------

--
-- Structure de la table `service_province`
--

CREATE TABLE `service_province` (
  `id` int(11) NOT NULL,
  `id_service_pourvoyeur` int(11) NOT NULL,
  `id_province` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `pseudo` varchar(50) NOT NULL,
  `motdepasse` varchar(255) NOT NULL,
  `id_service_pourvoyeur` int(4) DEFAULT NULL COMMENT 'Le service pourvoyeur des données (DGI, DGRAD, etc...)',
  `id_role` int(1) NOT NULL COMMENT 'Role de l''utilisateur dans le système(OPS, validateur, Admin)',
  `id_province` int(11) DEFAULT NULL,
  `id_centre_perception` int(11) DEFAULT NULL,
  `id_etat_utilisateur` int(1) NOT NULL COMMENT 'L''état de l''utilisateur dans le système ',
  `token_utilisateur` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `pseudo`, `motdepasse`, `id_service_pourvoyeur`, `id_role`, `id_province`, `id_centre_perception`, `id_etat_utilisateur`, `token_utilisateur`) VALUES
(1, 'KKDAN', '7c222fb2927d828af22f592134e8932480637c0d', 1, 1, NULL, NULL, 1, 'e910f586e005605e0e21e845562c750f7de9f507'),
(3, 'KKCLEBERG', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 1, 1, '58a9d4137a438a55f5549deb6e27b81da2e70df8'),
(7, 'VHDANIEL', '7c222fb2927d828af22f592134e8932480637c0d', 1, 2, NULL, NULL, 1, '022358e92440e2f29472f79a4edfe6b477246a10'),
(8, 'OJLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 2, 1, '95d56e01223fd4d581dc0aa352e79732a312c199'),
(9, 'OJJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 3, 1, 'a91f02ff899957594ec1de979b74a67be2fc024e'),
(10, 'RUPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 4, 1, '6fcb7514290a6e59c8ce9d749ff5772166e7face'),
(11, 'CWClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 5, 1, 'a123810f52620a205309bbebd70c13c79cb91984'),
(12, 'IQLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 6, 1, '96b93b7fec121b6b9c753bc63bccbaf3b52267d2'),
(13, 'SYLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 7, 1, '7b0be978c6703b62883dbbdc53d02cd17e033eac'),
(14, 'DGVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 8, 1, '096b527c8602e908a94b41a9444199451c48bf46'),
(15, 'QCPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 9, 1, 'c45afc319044ba69e9b9bb7d0ac70cc4d9ad2b3e'),
(16, 'VIGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 10, 1, '6307dd878f8f61aca94ffcd2a744f6da65674a26'),
(17, 'FPAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 11, 1, '8475099cd9046be10b9678ce833f2d3780265962'),
(18, 'ADMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 12, 1, '6933428334609d84cb817e0c82eb4ad02aac0d58'),
(19, 'FGJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 13, 1, 'db31f33c4bfdef3c3bfda4d05a2ebb10f3177d44'),
(20, 'IFEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 14, 1, '31af26affa1e8e412707cf1e7d2af4eec03fad6c'),
(21, 'AMPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 15, 1, '72708bf6f247ba926f687bfe6bd75ecf3a7ab6cb'),
(22, 'UBLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 16, 1, 'dbec639fcbcc175d2276c23154e3abd323b01385'),
(23, 'XBAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 17, 1, '7ab917ec63bce05a6342ed04a34b50cbf3f4843d'),
(24, 'JWEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 18, 1, 'afbd8b4227d816c9e896833e1de9c3027aea097f'),
(25, 'MIAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 19, 1, 'bf8b5af854d6693580968a1528c43664269a9816'),
(26, 'WVJacques', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 20, 1, '363310e8944af2fd5993b760479affb5370d092b'),
(27, 'PAEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 21, 1, '59059e6499c215e8d48ce494fb8067d845fc0a23'),
(28, 'MPAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 22, 1, '80d8459fe278d01af8b8a17092e5c88abffe57e6'),
(29, 'LRPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 23, 1, '716ae1584120a4352e9996e18d4e5527a2ef373d'),
(30, 'NMElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 24, 1, '1a7d16a55ed07c7d5c03d83a7a4bb5ab86c2b1a3'),
(31, 'AAMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 25, 1, 'aa393e805f3b293b9a0492716c8a98ec91d80096'),
(32, 'SLClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 26, 1, '7b51ce3dc6dfc44e4ecb9750d419cd9f940bb9cd'),
(33, 'TOAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 27, 1, 'd051582322a5eade640de0d58d3669f010576184'),
(34, 'QDLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 2, 28, 1, 'cc00d7f57dfe49b6e0c8366e19537fb79a1d31a3'),
(35, 'HQClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 2, 29, 1, '579891e5bdd9980b65aa7de9c53a7158b0bce261'),
(36, 'DXSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 30, 1, '0dedc9082bd4831e232c204bcd6399958935636d'),
(37, 'PFClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 31, 1, 'c0ebb0661b4fd5ab6298eb20f519b82bbff372a2'),
(38, 'WBAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 32, 1, 'b2a6448efe3fb02b61ca4b7d45da7abc014a482c'),
(39, 'VSClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 33, 1, '271c90b361290b3b9c067e9ca597743ca434ee88'),
(40, 'QWLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 34, 1, '5384d0d2a97df730670fe1f2a0560a0af27fbca9'),
(41, 'XKLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 35, 1, '38110f818cc79c8ab828b4d50a40273e094561a0'),
(42, 'AQSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 36, 1, '588e11976c06db4073a99770db1be4c2a2c65e8e'),
(43, 'PAAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 37, 1, '888a0e6954e4c6293fcde6dc17140e0a77ef54e5'),
(44, 'RGVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 38, 1, 'ded83d7d6c81f25242fef6da993db6acc3215a94'),
(45, 'URSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 39, 1, 'c7f2b447f72b1b3381e9ff9732ba3c7e9e7d8bba'),
(46, 'RVLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 40, 1, '1d817dac6267f8489bdb68f4f0f09fc983811ec3'),
(47, 'CQGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 41, 1, '500eadbe20135434414ef39dd2a2c9a0b61e43e0'),
(48, 'KRElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 42, 1, '1f629b0aa19247144bb6aaee7ccf8a90427bbd6b'),
(49, 'AKPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 43, 1, '0916573152bd99db511f78fa9726db169854a664'),
(50, 'BQJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 44, 1, '12f75668cc330f64de4120b3b98fb4a8b315bb6c'),
(51, 'RFElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 45, 1, 'cbb935fcaa8a8b960a302e13bd2dea85a55ce755'),
(52, 'YLPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 5, 46, 1, 'bd0ca3794cf2f7ce116dad8f5680a4cd00aca4b6'),
(53, 'MHLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 5, 47, 1, 'd4984589ebe43f94d58b310a0cf865845e06aaca'),
(54, 'WUGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 6, 48, 1, 'f2f62df3970da74c2d93289d7ee9edb0a1c05b74'),
(55, 'FKElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 6, 49, 1, '1a1e3011d902a504839fc5b3f1b014e56473e7c7'),
(56, 'SFVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 6, 50, 1, '0a6ce5b47f2a52a509482a3cd6168e0af6508d89'),
(57, 'RMJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 51, 1, '50db001ef5d965b33ddc129208794a7577ad6e78'),
(58, 'YNMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 52, 1, '5e0fcc6eac5d4d6622c36a0fa911eac7d958c8f3'),
(59, 'GYLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 53, 1, '21b04e12d3c4c7c3817347c0c22394f726a8570c'),
(60, 'TLMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 54, 1, '4972ec2b24cc22a227945c66f148e28dfea4a848'),
(61, 'VRAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 55, 1, '258015834fdb9489e5d616a5d4bd892dde578f5e'),
(62, 'TLLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 56, 1, '1cdd7641ffca3daf70550c2d9905663ceaaead43'),
(63, 'PMJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 57, 1, '6b0c8a475e97aa6f33a37ceb347f47c902649761'),
(64, 'VZElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 58, 1, '9c8e92713cdb9dd6eb3a97aff6de420df2a46202'),
(65, 'BGLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 59, 1, 'a86df6df2cc97f932a2b5467f560b3506946bd34'),
(66, 'BHPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 60, 1, 'ed1ee37d5ed88adfc92100329cb7d84e2694bbed'),
(67, 'VQLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 61, 1, 'ffa1391a687049d61002709a98e24344103873d6'),
(68, 'GSLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 62, 1, '1a7c62bc062b6f98994a088b53574258b7d37cc9'),
(69, 'XVVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 63, 1, 'bec669c25f467ab84a7313bcc8384d0b940684e0'),
(70, 'RBAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 64, 1, '98f9bd781efe00feed08ffc9ee299674f01bcace'),
(71, 'QSJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 65, 1, '726f2676b92c40297cfa147e0f04f4bd0802e338'),
(72, 'BKMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 66, 1, '97678b62dd6178422452e91355d3711c4476dfda'),
(73, 'VAEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 67, 1, '3194ad9b40237a0db0b12872dcc628282762fe00'),
(74, 'DFGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 68, 1, '2581f1df98e545cd5817fd6d7dffaeb8c79c4c8a'),
(75, 'PRAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 69, 1, '35a410b838070de2ba00fea58089ae37d70c2a9b'),
(76, 'MKLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 70, 1, '8156b73b1bf6e8d851879c4fcdbe3a3feff74771'),
(77, 'PZMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 71, 1, 'e9ba0323de6b85612c96b149bdeb6aff0ba21784'),
(78, 'ISMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 72, 1, '2bc6aa71a3538cc77dfcb05dc62057036006443b'),
(79, 'ZYLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 73, 1, '95d1d3c1b7524869784cd0455a07551434b79306'),
(80, 'KCJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 74, 1, 'd12ba6ee7ed15a8ecb4a1278b73b74745bb7929a'),
(81, 'MHPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 75, 1, 'e9428dbc639c37cb9ebfc716f4b29133fe3ca16f'),
(82, 'MJNoemie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 76, 1, 'adc68ce788278417d6263a11405e538643d3940b'),
(83, 'NOEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 77, 1, 'fd3072d94e7d2158af2c39acbd4b3ff322c325cd'),
(84, 'CHAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 78, 1, '62131fc70563c9a8d3c19d3cb515f730d3e6f217'),
(85, 'FBJacques', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 79, 1, '39eacea6bc14e5eac47863cafbc16b04e2404d08'),
(86, 'UAClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 80, 1, '126b79fd6d32fffbdb3da11f89ecdbb13f870ffc'),
(87, 'IDVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 81, 1, '775bafcd2f74ce7b9ec636e74d068c951652c71d'),
(88, 'JRMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 82, 1, '5c953738c10b86d2c08bf4ff580760f10e22adfa'),
(89, 'HBGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 83, 1, '6f0f39bbedccab8848028a19831ab2486d5353d9'),
(90, 'MRPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 84, 1, '5dcceced807c167b5ebd34ab92ea3abe04a8051e'),
(91, 'LENoemie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 85, 1, 'dc5800d8bd78fbe365fb96f315d0c7de4292da2f'),
(92, 'VZLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 86, 1, 'b2038604cc96c7d3d2e946da154042215bec53f0'),
(93, 'PAGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 87, 1, 'c169fc6c08f0074a0f4088c1b4862c6e80105f7a'),
(94, 'UEPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 88, 1, '4346361523bf1f03e142bca043048d860d5321b3'),
(95, 'UDVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 89, 1, '157969f40b66b50506d2c39e4a67e618ca1f00f8'),
(96, 'BMJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 90, 1, '5dadcd6e7e6e3471a3a484632e4df4909fe67eb1'),
(97, 'TKAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 91, 1, 'ca050c4026f1da81dbb93225baac324a5581f6b9'),
(98, 'GZPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 92, 1, '20375fbc037eca0493edf87a67ee5f77c5a63f16'),
(99, 'WUMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 12, 94, 1, '826bd2f7afa56a6dd08859a9f54fc895ab1a56ef'),
(100, 'RSLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 12, 95, 1, '6bef9d256b8e1c0bb4d9f7931b9656a700fd1ad1'),
(101, 'VSJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 12, 96, 1, '0e072d8d97159df01568ab46b56ac82267d3fc4f'),
(102, 'XGMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 97, 1, '5581437d8bbc9d07f83db32dc4474521ebb476de'),
(103, 'BTClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 98, 1, 'c7b26f8e2d2fe75732632686c1e8752b24643796'),
(104, 'GWLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 99, 1, '906941ae164e8e96e943e590f6286c7a53ebde9d'),
(105, 'SAPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 100, 1, 'c9ca84c8b336f209ee18b74440ba9de3a910605b'),
(106, 'TIAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 101, 1, '5208adc0076e169029ce339ce9ab08675b14979c'),
(107, 'DEJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 102, 1, '0afb35b860e515a66968f292d28ddf51abf835e4'),
(108, 'HCLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 103, 1, '5ab716936e87402592fc5dcce6de970a5e072dc5'),
(109, 'LXAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 14, 104, 1, '0421c0632aabfbd5ef8ca2a8f29e74d658c22973'),
(110, 'ARElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 14, 105, 1, '6545050fd048c4524eb26e2f281d20c4b97a9415'),
(111, 'SJElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 14, 106, 1, 'e78ea330463ed1d1ebdc93196235e662f2f286fc'),
(112, 'PVEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 14, 107, 1, 'cf6a8b3e335438c0166e7916286b749fe9ada001'),
(113, 'OYJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 15, 108, 1, '0452fca5cdc7cb3dc394cb61f6411434b45a2698'),
(114, 'TMAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 15, 109, 1, '37453ae0833f95fa5ef9c658c4ba5bfce91ce27b'),
(115, 'XDVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 16, 110, 1, 'd129ee6bae2837a02a72ca233fd7718096e22566'),
(116, 'VAClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 16, 111, 1, '224bd45cc4f1f4911c61dc1aa5aea704182b2d6a'),
(117, 'NSGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 16, 112, 1, '9b3922cf8daefe03409f1834f96e17f5e7aa52c8'),
(118, 'IGElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 113, 1, 'e325cdced5c9c524d74f7cd59c17a0f69c4a2225'),
(119, 'HNPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 114, 1, '43d9adcd1565f9f20c84552ece10cc6a5936383c'),
(120, 'ETGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 115, 1, '19f0238438e89b2791c41f56abd2a82c08cd9834'),
(121, 'MDMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 116, 1, 'dd53f8d4744d8a3b79ec44943a2c53ad4f910f9a'),
(122, 'OSAlain', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 117, 1, 'f92a6c5ba91bdfdbe72a16b6987131b77b0aaf28'),
(123, 'ZFGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 118, 1, 'f9e775c19096fd04feb74a2936c506115b39e4d8'),
(124, 'YUAlain', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 119, 1, 'd186e2c483b291ea63effdec553417aa65facacd'),
(125, 'SGJacques', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 120, 1, '930efe90301634d5a5d06884e2b145296b2544b6'),
(126, 'GVJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 18, 121, 1, 'd1dcf7d58e2513772da737e45029070373858378'),
(127, 'OGMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 18, 122, 1, '4c9a705eebdb8c3501aa986bace92b1b84b7a141'),
(128, 'XTGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 123, 1, '7e07409f22c5740e7e91618328f953551de42486'),
(129, 'IXAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 124, 1, 'a5b5733a6a83e3bdc0a71dc896d87bc5c5a60f26'),
(130, 'SPAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 125, 1, '79bf038a3bce1f40b36e61f88e0f8b8c43cc69e9'),
(131, 'MUGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 126, 1, 'bff6ed08f7ebca899d459d00f78d7544f7e5363b'),
(132, 'YFJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 127, 1, 'deb2ec327376720d9fca70ff3c5071d8b3d7db2a'),
(133, 'NZLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 128, 1, '382d60323908a639b7d7909a26e427a879b187ba'),
(134, 'CYSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 129, 1, 'af4606770a720507b7a55d64551c1033c9f0fcdf'),
(135, 'ZJSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 130, 1, '11a9e3500cd687f2d2f5676e5e6e1cf8a588e3a2'),
(136, 'CJEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 131, 1, '0520f53855de9262ad958b04bb78fb0203e89802'),
(137, 'LMVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 132, 1, '8ec8450347c7a6f35340625b6964456d0f7bc05b'),
(138, 'MILucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 133, 1, 'b85d16062c5b387c49561918a30b51635ce48dc7'),
(139, 'OMElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 20, 135, 1, '7429ed6472e457d3b16167a182c3977343f704c1'),
(140, 'EOMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 20, 136, 1, 'dc671ab8dc4f3a48ddaea9960898a955b7d5ef92'),
(141, 'YNElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 21, 137, 1, '125269dc1fb30b768f7ae6948fe83be1d17c4bc8'),
(142, 'SCJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 21, 138, 1, '4d5790d74c9d6b7c71f15cc8ddfe8596846eb277'),
(143, 'XZNoemie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 139, 1, '1755a20a51885c5e525135fbba2adb8b68a19c46'),
(144, 'HNMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 140, 1, '1a0bfc0062b495742985ffe8ff5fb762d4329d21'),
(145, 'IXAlain', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 141, 1, 'f0011036ce0de28d63df390903843c2fcf927372'),
(146, 'MWGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 142, 1, '20acbbd1a2467c1ad1b667d69ffa5e731ee920d2'),
(147, 'FZEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 143, 1, '8ce9d5cf76788c1c62d540541b90a37a7e71c3e7'),
(148, 'RTLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 144, 1, 'a419c776579d95a676f907bf4bd2992ca1474fa9'),
(149, 'ROLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 145, 1, '2e6baf4e315e73606bfe1537676c7264d5c1ecf1'),
(150, 'JGGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 146, 1, '2c4adedfed0fde3a99902d764cc80824511fa0dd'),
(151, 'BRAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 147, 1, 'b95775bd843bebc83612d4e2f9e6a39a06918d8f'),
(152, 'VYVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 148, 1, '482c507d78fd6340ecad89476d742eae03a2165d'),
(153, 'LQJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 149, 1, 'd29e268b75d5502f68549ef6a0f1d5351eef8a35'),
(154, 'CTMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 23, 150, 1, '916f26c384e04489e07205b98c15b6620c00a981'),
(155, 'EHGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 23, 151, 1, '7fe0241ac3b07bd961aac5c982d5eb369bce5099'),
(156, 'DWMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 23, 152, 1, '053347a53c88a7c5b920652950b4523caade296c'),
(157, 'XRLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 24, 153, 1, '96e14aadfe26f01be665f1e5d12a161e6646d1b8'),
(158, 'SASophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 24, 154, 1, '2030a12dcfaca0a021e649af53bf9ff3fec483b7'),
(159, 'ONEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 155, 1, '13030d5f4d5a5410ddc1d394d27d7ba639505cef'),
(160, 'SSMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 156, 1, 'd08af8f252c66c886d8f242e667f37f944e8d941'),
(161, 'QAElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 157, 1, '44b754203e4885b063a9442a0402f47e949b661d'),
(162, 'APVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 158, 1, 'a79db01b4d4a9f6408e46f45ed708a2b053da30a'),
(163, 'XFLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 159, 1, '5feab8689044cae0718015f3a1e8870b81054087'),
(164, 'HNJules', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 160, 1, '7c5d9891addafeea3700641d9ff54f6c42a27641'),
(165, 'MGLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 26, 161, 1, '1234d3c19465ed9e9f87171a8295764fb5b7d4a1'),
(166, 'KVPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 26, 162, 1, '4fe4b50c0dd9adb27efe914c2fc2a62c6b18e1ee');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `affectation_province_utilisateur`
--
ALTER TABLE `affectation_province_utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_utilisateur` (`id_utilisateur`),
  ADD KEY `id_province` (`id_province`);

--
-- Index pour la table `configuration_province`
--
ALTER TABLE `configuration_province`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `dgi_affectation_centre_perception`
--
ALTER TABLE `dgi_affectation_centre_perception`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_centre_perception` (`id_centre_perception`),
  ADD KEY `id_province` (`id_province`);

--
-- Index pour la table `dgi_categorie_nature_impot`
--
ALTER TABLE `dgi_categorie_nature_impot`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_nature_impot` (`id_type_nature_impot`);

--
-- Index pour la table `dgi_centre_perception`
--
ALTER TABLE `dgi_centre_perception`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_province` (`id_province`);

--
-- Index pour la table `dgi_nature_impot`
--
ALTER TABLE `dgi_nature_impot`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_nature_impot` (`id_type_nature_impot`),
  ADD KEY `id_categorie_nature_impot` (`id_categorie_nature_impot`);

--
-- Index pour la table `dgi_statistique`
--
ALTER TABLE `dgi_statistique`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_province` (`id_province`),
  ADD KEY `id_centre_perception` (`id_centre_perception`),
  ADD KEY `id_mois` (`id_mois`),
  ADD KEY `id_etat_donnee` (`id_etat_donnee`),
  ADD KEY `id_type_nature_recette` (`id_type_nature_recette`),
  ADD KEY `id_categorie_nature_recette` (`id_categorie_nature_recette`),
  ADD KEY `id_ordre` (`id_ordre`);

--
-- Index pour la table `dgi_type_nature_impot`
--
ALTER TABLE `dgi_type_nature_impot`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `dgi_utilisateur_centre_perception`
--
ALTER TABLE `dgi_utilisateur_centre_perception`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_utilisateur` (`id_utilisateur`),
  ADD KEY `id_centre_perception` (`id_centre_perception`);

--
-- Index pour la table `dgi_utilisateur_province`
--
ALTER TABLE `dgi_utilisateur_province`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_utilisateur` (`id_utilisateur`),
  ADD KEY `id_province` (`id_province`);

--
-- Index pour la table `etat_donnee`
--
ALTER TABLE `etat_donnee`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `etat_utilisateur`
--
ALTER TABLE `etat_utilisateur`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `mois`
--
ALTER TABLE `mois`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `province`
--
ALTER TABLE `province`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_configuration` (`id_configuration`),
  ADD KEY `id_service` (`id_service`);

--
-- Index pour la table `role_utilisateur`
--
ALTER TABLE `role_utilisateur`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `service_pourvoyeur`
--
ALTER TABLE `service_pourvoyeur`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `service_province`
--
ALTER TABLE `service_province`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_service_pourvoyeur` (`id_service_pourvoyeur`),
  ADD KEY `id_province` (`id_province`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service pourvoyeur des données (DGI, DGRAD, etc...)` (`id_service_pourvoyeur`),
  ADD KEY `Role de l'utilisateur dans le système(OPS, validateur, Admin)` (`id_role`),
  ADD KEY `id_etat_utilisateur` (`id_etat_utilisateur`),
  ADD KEY `id_province` (`id_province`),
  ADD KEY `id_centre_perception` (`id_centre_perception`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `affectation_province_utilisateur`
--
ALTER TABLE `affectation_province_utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `configuration_province`
--
ALTER TABLE `configuration_province`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `dgi_affectation_centre_perception`
--
ALTER TABLE `dgi_affectation_centre_perception`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `dgi_categorie_nature_impot`
--
ALTER TABLE `dgi_categorie_nature_impot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `dgi_centre_perception`
--
ALTER TABLE `dgi_centre_perception`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT pour la table `dgi_nature_impot`
--
ALTER TABLE `dgi_nature_impot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `dgi_statistique`
--
ALTER TABLE `dgi_statistique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT pour la table `dgi_type_nature_impot`
--
ALTER TABLE `dgi_type_nature_impot`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `dgi_utilisateur_centre_perception`
--
ALTER TABLE `dgi_utilisateur_centre_perception`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `dgi_utilisateur_province`
--
ALTER TABLE `dgi_utilisateur_province`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `etat_donnee`
--
ALTER TABLE `etat_donnee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `etat_utilisateur`
--
ALTER TABLE `etat_utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `mois`
--
ALTER TABLE `mois`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `province`
--
ALTER TABLE `province`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `role_utilisateur`
--
ALTER TABLE `role_utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `service_pourvoyeur`
--
ALTER TABLE `service_pourvoyeur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `service_province`
--
ALTER TABLE `service_province`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=167;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `affectation_province_utilisateur`
--
ALTER TABLE `affectation_province_utilisateur`
  ADD CONSTRAINT `affectation_province_utilisateur_ibfk_1` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `affectation_province_utilisateur_ibfk_2` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgi_affectation_centre_perception`
--
ALTER TABLE `dgi_affectation_centre_perception`
  ADD CONSTRAINT `dgi_affectation_centre_perception_ibfk_1` FOREIGN KEY (`id_centre_perception`) REFERENCES `dgi_centre_perception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_affectation_centre_perception_ibfk_2` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgi_categorie_nature_impot`
--
ALTER TABLE `dgi_categorie_nature_impot`
  ADD CONSTRAINT `dgi_categorie_nature_impot_ibfk_1` FOREIGN KEY (`id_type_nature_impot`) REFERENCES `dgi_type_nature_impot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgi_centre_perception`
--
ALTER TABLE `dgi_centre_perception`
  ADD CONSTRAINT `dgi_centre_perception_ibfk_1` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgi_nature_impot`
--
ALTER TABLE `dgi_nature_impot`
  ADD CONSTRAINT `dgi_nature_impot_ibfk_1` FOREIGN KEY (`id_type_nature_impot`) REFERENCES `dgi_type_nature_impot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_nature_impot_ibfk_2` FOREIGN KEY (`id_categorie_nature_impot`) REFERENCES `dgi_categorie_nature_impot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgi_statistique`
--
ALTER TABLE `dgi_statistique`
  ADD CONSTRAINT `dgi_statistique_ibfk_1` FOREIGN KEY (`id_centre_perception`) REFERENCES `dgi_centre_perception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_statistique_ibfk_2` FOREIGN KEY (`id_mois`) REFERENCES `mois` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_statistique_ibfk_4` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_statistique_ibfk_5` FOREIGN KEY (`id_etat_donnee`) REFERENCES `etat_donnee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_statistique_ibfk_6` FOREIGN KEY (`id_type_nature_recette`) REFERENCES `dgi_type_nature_impot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_statistique_ibfk_7` FOREIGN KEY (`id_categorie_nature_recette`) REFERENCES `dgi_categorie_nature_impot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_statistique_ibfk_8` FOREIGN KEY (`id_ordre`) REFERENCES `dgi_nature_impot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgi_utilisateur_centre_perception`
--
ALTER TABLE `dgi_utilisateur_centre_perception`
  ADD CONSTRAINT `dgi_utilisateur_centre_perception_ibfk_1` FOREIGN KEY (`id_centre_perception`) REFERENCES `dgi_centre_perception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_utilisateur_centre_perception_ibfk_2` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgi_utilisateur_province`
--
ALTER TABLE `dgi_utilisateur_province`
  ADD CONSTRAINT `dgi_utilisateur_province_ibfk_1` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgi_utilisateur_province_ibfk_2` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `province`
--
ALTER TABLE `province`
  ADD CONSTRAINT `province_ibfk_1` FOREIGN KEY (`id_configuration`) REFERENCES `configuration_province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `province_ibfk_2` FOREIGN KEY (`id_service`) REFERENCES `service_pourvoyeur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `service_province`
--
ALTER TABLE `service_province`
  ADD CONSTRAINT `service_province_ibfk_1` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `service_province_ibfk_2` FOREIGN KEY (`id_service_pourvoyeur`) REFERENCES `service_pourvoyeur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `utilisateur_ibfk_1` FOREIGN KEY (`id_etat_utilisateur`) REFERENCES `etat_utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `utilisateur_ibfk_2` FOREIGN KEY (`id_role`) REFERENCES `role_utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `utilisateur_ibfk_3` FOREIGN KEY (`id_service_pourvoyeur`) REFERENCES `service_pourvoyeur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `utilisateur_ibfk_4` FOREIGN KEY (`id_centre_perception`) REFERENCES `dgi_centre_perception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `utilisateur_ibfk_5` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : dim. 09 fév. 2025 à 17:36
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
-- Structure de la table `administrateur`
--

CREATE TABLE `administrateur` (
  `id` int(11) NOT NULL,
  `pseudo` text NOT NULL,
  `motdepasse` text NOT NULL,
  `id_role` int(11) NOT NULL,
  `id_etat_utilisateur` int(11) NOT NULL,
  `id_service_affecte` int(11) DEFAULT NULL,
  `token_admin` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `administrateur`
--

INSERT INTO `administrateur` (`id`, `pseudo`, `motdepasse`, `id_role`, `id_etat_utilisateur`, `id_service_affecte`, `token_admin`) VALUES
(1, 'KKDAN', '7c222fb2927d828af22f592134e8932480637c0d', 1, 1, 1, 'a07586a0934c8bfa61480578f43368ac0e966aaa'),
(2, 'MBROSSY', '7c222fb2927d828af22f592134e8932480637c0d', 2, 1, 2, '9dcbe76142345586e26dd354767323781a0e961c'),
(3, 'MLGUY', '7c222fb2927d828af22f592134e8932480637c0d', 3, 1, 3, '57846abf3bc5d49192c4e23cb4e962ff074c2890');

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
-- Structure de la table `dgda_categorie_nature_economique`
--

CREATE TABLE `dgda_categorie_nature_economique` (
  `id` int(11) NOT NULL,
  `libelle_nature_economique` text NOT NULL,
  `id_type_nature_economique` int(11) NOT NULL,
  `code_categorie_nature_economique` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgda_categorie_nature_economique`
--

INSERT INTO `dgda_categorie_nature_economique` (`id`, `libelle_nature_economique`, `id_type_nature_economique`, `code_categorie_nature_economique`) VALUES
(1, 'Accises perçues en régime intérieur', 2, '17132100'),
(2, 'Accises perçues  à l\'importation', 2, '17132200'),
(3, 'Droits de douanes', 4, '17151110'),
(4, 'Autres droits à l\'importation', 4, '17151120'),
(5, 'Droits de sortie des minerais', 5, '17152100'),
(6, 'Droits de sortie des produits agricoles et végétaux', 5, '17152200'),
(7, 'Droits de sortie sur les autres produits', 5, '17152300'),
(8, 'Amendes et pénalités à l\'importation', 6, '37156100'),
(9, 'Amendes et pénalités à l\'exportation', 6, '37156200');

-- --------------------------------------------------------

--
-- Structure de la table `dgda_categorie_secteur_actvite`
--

CREATE TABLE `dgda_categorie_secteur_actvite` (
  `id` int(11) NOT NULL,
  `code_categorie_secteur_activite` varchar(20) NOT NULL,
  `libelle_categorie_secteur` text NOT NULL,
  `id_type_secteur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgda_categorie_secteur_actvite`
--

INSERT INTO `dgda_categorie_secteur_actvite` (`id`, `code_categorie_secteur_activite`, `libelle_categorie_secteur`, `id_type_secteur`) VALUES
(1, '11', 'Mines', 1),
(2, '12', 'Hydrocarbures', 1),
(3, '13', 'Forêt', 1),
(4, '14', 'Agriculture, pêche, aquaculture et élevage', 1),
(5, '18', 'Autres recettes du secteur primaire', 1),
(6, '21', 'Electricité', 2),
(7, '22', 'Eau', 2),
(8, '23', 'Infrastructures', 2),
(9, '24', 'Industrie et artisanat', 2),
(10, '28', 'Autres recettes du secteur secondaire', 2),
(11, '31', 'Poste et Télécommunication', 3),
(12, '32', 'Transport', 3),
(13, '33', 'Administration', 3),
(14, '34', 'Assurance', 3),
(15, '35', 'Banque et crédit', 3),
(16, '36', 'Commerce', 3),
(17, '38', 'Autres recettes du secteur tertiaire', 3);

-- --------------------------------------------------------

--
-- Structure de la table `dgda_centre_perception`
--

CREATE TABLE `dgda_centre_perception` (
  `id` int(11) NOT NULL,
  `libelle_centre_perception` text NOT NULL,
  `id_province` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgda_centre_perception`
--

INSERT INTO `dgda_centre_perception` (`id`, `libelle_centre_perception`, `id_province`) VALUES
(1, 'Kinshasa/DG', 52),
(2, 'Kinshasa Aéroport', 52),
(3, 'Kinshasa Ville', 52),
(4, 'Katanga', 29),
(5, 'Katanga', 39),
(6, 'Katanga', 30),
(7, 'Katanga', 49),
(8, 'BAS-CONGO', 35),
(9, 'BANDUNDU', 37),
(10, 'BANDUNDU', 36),
(11, 'BANDUNDU', 41),
(12, 'KASAI-ORIENTAL', 34),
(13, 'KASAI-ORIENTAL', 38),
(14, 'KASAI-ORIENTAL', 46),
(15, 'KASAI-OCCIDENTAL', 33),
(16, 'KASAI-OCCIDENTAL', 40),
(17, 'PROVNCE-ORIENTALE', 50),
(18, 'PROVNCE-ORIENTALE', 27),
(19, 'PROVNCE-ORIENTALE', 31),
(20, 'PROVNCE-ORIENTALE', 32),
(21, 'EQUATEUR', 28),
(22, 'EQUATEUR', 43),
(23, 'EQUATEUR', 45),
(24, 'EQUATEUR', 48),
(25, 'EQUATEUR', 51),
(26, 'NORD-KIVU', 44),
(27, 'SUD-KIVU', 47),
(28, 'MANIEMA', 42);

-- --------------------------------------------------------

--
-- Structure de la table `dgda_nature_economique`
--

CREATE TABLE `dgda_nature_economique` (
  `id` int(11) NOT NULL,
  `libelle_nature_economique` text NOT NULL,
  `code_nature_economique` varchar(20) DEFAULT NULL,
  `id_type_secteur_activite` int(11) DEFAULT NULL,
  `id_categorie_secteur_activite` int(11) DEFAULT NULL,
  `id_secteur_activite` int(11) DEFAULT NULL,
  `id_type_nature_economique` int(11) DEFAULT NULL,
  `id_categorie_nature_economique` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgda_nature_economique`
--

INSERT INTO `dgda_nature_economique` (`id`, `libelle_nature_economique`, `code_nature_economique`, `id_type_secteur_activite`, `id_categorie_secteur_activite`, `id_secteur_activite`, `id_type_nature_economique`, `id_categorie_nature_economique`) VALUES
(1, 'Taxe sur la Valeur Ajoutée à l\'importation', '17131120', 3, 17, 52, 1, NULL),
(2, 'Accises sur les boissons alcoolisées', '17132111', 3, 16, 48, 2, 1),
(3, 'Tabacs fabriqués et leurs sccédanés ainsi que les produits et instruments servant à fumer', '17132131', 3, 16, 48, 2, 1),
(4, 'Eaux de table, limonades et jus', '17132113', 3, 16, 48, 2, 1),
(5, 'Parfums liquides', '17132171', 3, 16, 49, 2, 1),
(6, 'Lubrifiants et huiles de graissage', '17132142', 3, 16, 50, 2, 1),
(7, 'cosmétiques et autres produits d\'entretien', '17132173', 3, 16, 49, 2, 1),
(8, 'Préparation capillaire', '17132162', 3, 16, 49, 2, 1),
(9, 'Préparation pour hygiène buccale', '17132161', 3, 16, 49, 2, 1),
(10, 'Savons, agents de surface organique, cirage et crème pour chaussure', '17132172', 3, 16, 49, 2, 1),
(11, 'Article et ouvrage en matière plastique', '17132151', 3, 16, 49, 2, 1),
(12, 'Article et ouvrage en caoutchouc synthétique', '17132152', 3, 16, 49, 2, 1),
(13, 'Services des télécommunications', '17132120', 3, 11, 30, 2, 1),
(14, 'Alcools, boissons alcooliques', '17132112', 3, 16, 48, 2, 1),
(15, 'Tabacs fabriqués et leurs sccédanés ainsi que les produits et instruments servant à fumer', '17132130', 3, 16, 48, 2, 1),
(16, 'Droits d\'accises spécial', '17132132', 3, 16, 50, 2, 1),
(17, 'Produits pétroliers', '17132141', 3, 16, 50, 2, 1),
(18, 'Boissons alcoolisées', '17132211', 3, 16, 48, 2, 2),
(19, 'Tabacs importés et leurs sccédanés ainsi que les produits et instruments servant à fumer', '17132231', 3, 16, 48, 2, 2),
(20, 'Eaux de table, limonades et jus', '17132213', 3, 16, 48, 2, 2),
(21, 'Alcools et boissons alcooliques', '17132212', 3, 16, 48, 2, 2),
(22, 'Parfums liquides', '17132281', 3, 16, 49, 2, 2),
(23, 'Produits pétroliers', '17132241', 3, 16, 50, 2, 2),
(24, 'Lubrifiants et huiles de graissage', '17132242', 3, 16, 50, 2, 2),
(25, 'cosmétiques et autres produits d\'entretien', '17132283', 3, 16, 49, 2, 2),
(26, 'Préparation capillaire', '17132262', 3, 16, 49, 2, 2),
(27, 'Préparation pour hygiène buccale', '17132261', 3, 16, 49, 2, 2),
(28, 'Savons, agents de surface organique, cirage et crème pour chaussure', '17132282', 3, 16, 49, 2, 2),
(29, 'Article et ouvrage en matière plastique', '17132251', 3, 16, 49, 2, 2),
(30, 'Article et ouvrage en caoutchouc synthétique', '17132252', 3, 16, 49, 2, 2),
(31, 'Véhicule', '17132270', 3, 16, 51, 2, 2),
(32, 'Services des télécommunications', '17132220', 3, 11, 32, 2, 2),
(33, 'Droit d\'accise spécial', '17132232', 3, 16, 50, 2, 2),
(34, 'Amendes et pénalités relevant des accises perçues en régime intérieur', '37137100', 3, 16, 51, 3, NULL),
(35, 'Amendes et pénalités relevant des accises perçues à l\'importation', '37137200', 3, 16, 51, 3, NULL),
(36, 'Produits partiels des ventes publiques', '17151121', 3, 16, 51, 4, 4),
(37, 'Retenues sur restitutions douanières', '17151122', 3, 16, 51, 4, 4),
(38, 'Taxes sur vente publique', '17151123', 3, 16, 51, 4, 4),
(39, 'Droits de sortie sur le diamant artisanal', '17152120', 1, 1, 2, 5, 5),
(40, 'Droits de sortie sur l\'or artisanal', '17152140', 1, 1, 3, 5, 5),
(41, 'Droits de sortie sur le diamant industriel', '17152110', 1, 1, 2, 5, 5),
(42, 'Droits de sortie sur l\'or industriel', '17152130', 1, 1, 3, 5, 5),
(43, 'Droits de sortie sur les autres produits minéraux', '17152150', 1, 1, 4, 5, 5),
(44, 'Droits de sortie sur le café Robusta', '17152210', 1, 4, 12, 5, 6),
(45, 'Droits de sortie sur le café Arabica', '17152220', 1, 4, 12, 5, 6),
(46, 'Droits de sortie sur le bois en grumes', '17152230', 1, 3, 9, 5, 6),
(47, 'Droits de sortie sur le bois sciés', '17152240', 1, 3, 9, 5, 6),
(48, 'Droits de sortie sur autres produits végétaux', '17152250', 1, 4, 12, 5, 6),
(49, 'Droits de sortie sur l\'énergie électrique et gaz butane', '17152310', 2, 6, 18, 5, 7),
(50, 'Droits de sortie sur l\'huile brute de pétrole', '17152320', 1, 2, 5, 5, 7),
(51, 'Droits de sortie sur l\'eau et autres produits énergétiques', '17152330', 2, 7, 19, 5, 7),
(52, 'Amendes et pénalités à l\'importation', '37156100', 3, 17, 52, 6, 8),
(53, 'Amendes et pénalités à l\'exportation', '37156200', 3, 17, 52, 6, 9);

-- --------------------------------------------------------

--
-- Structure de la table `dgda_secteur_activite`
--

CREATE TABLE `dgda_secteur_activite` (
  `id` int(11) NOT NULL,
  `code_secteur` varchar(50) DEFAULT NULL,
  `libelle_secteur` text NOT NULL,
  `id_type_secteur` int(11) NOT NULL,
  `id_categorie_secteur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgda_secteur_activite`
--

INSERT INTO `dgda_secteur_activite` (`id`, `code_secteur`, `libelle_secteur`, `id_type_secteur`, `id_categorie_secteur`) VALUES
(1, '111', 'Cuivre', 1, 1),
(2, '112', 'Diamant', 1, 1),
(3, '113', 'Or', 1, 1),
(4, '118', 'Autres minerais', 1, 1),
(5, '121', 'Pétrole brut', 1, 2),
(6, '122', 'Eau naturelle (Eau minérale, thermale, …)', 1, 2),
(7, '123', 'Gaz naturel', 1, 2),
(8, '128', 'autres hydrocarbures', 1, 2),
(9, '131', 'Exploitation forestière (bois)', 1, 3),
(10, '132', 'Sylviculture', 1, 3),
(11, '138', 'Autres activités liées à la foresterie', 1, 3),
(12, '141', 'Agriculture', 1, 4),
(13, '142', 'Pêche', 1, 4),
(14, '143', 'Aquaculture', 1, 4),
(15, '144', 'Elevage', 1, 4),
(16, '148', 'Autres agriculture', 1, 4),
(17, '181', 'Autres recettes du secteur primaire', 1, 5),
(18, '211', 'Production d\'électricité', 2, 6),
(19, '221', 'Transformation de l\'eau', 2, 7),
(20, '231', 'Construction (bâtiment)', 2, 8),
(21, '232', 'Infrastructure aéropotuaire', 2, 8),
(22, '233', 'Infrastructure fluviale, maritime et lacustre', 2, 8),
(23, '238', 'Autres infrastructures', 2, 8),
(24, '241', 'Industrie manufacturière', 2, 9),
(25, '242', 'Industrie agro-alimentaire', 2, 9),
(26, '243', 'Artisanat', 2, 9),
(27, '248', 'Autres industrie', 2, 9),
(28, NULL, 'Autres recettes du secteur secondaire', 2, 10),
(29, '311', 'Poste', 3, 11),
(30, '312', 'Télécommunication', 3, 11),
(31, '313', 'Nouvelle technologie de l\'information et de la communication', 3, 11),
(32, '318', 'Autres poste et telecom', 3, 11),
(33, '321', 'Transport terrestre', 3, 12),
(34, '322', 'Transport maritime', 3, 12),
(35, '323', 'Transport aérien', 3, 12),
(36, '328', 'Autres transport', 3, 12),
(37, '331', 'Administration publique', 3, 13),
(38, '341', 'Assurance vie', 3, 14),
(39, '342', 'Assurance véhicule', 3, 14),
(40, '343', 'Assurance voyage', 3, 14),
(41, '348', 'Autres assurance', 3, 14),
(42, '351', 'Service bancaire', 3, 15),
(43, '352', 'Microcrédit', 3, 15),
(44, '358', 'Autres banque', 3, 15),
(45, '361', 'Electricité', 3, 16),
(46, '362', 'Eau', 3, 16),
(47, '363', 'Minérais', 3, 16),
(48, '364', 'Produits agricoles', 3, 16),
(49, '365', 'Produits manufacturiers', 3, 16),
(50, '366', 'Produits pétroliers', 3, 16),
(51, '368', 'Autres commerce', 3, 16),
(52, NULL, 'Autres recettes du secteur tertiaire', 3, 17);

-- --------------------------------------------------------

--
-- Structure de la table `dgda_statistique`
--

CREATE TABLE `dgda_statistique` (
  `id` int(11) NOT NULL,
  `id_ordre` int(11) NOT NULL,
  `id_province` int(11) NOT NULL,
  `id_centre_perception` int(11) NOT NULL,
  `code_nature` varchar(30) NOT NULL,
  `libelle_nature_economique` text NOT NULL,
  `id_type_secteur_activite` int(11) DEFAULT NULL,
  `id_categorie_secteur_activite` int(11) DEFAULT NULL,
  `id_secteur_activite` int(11) DEFAULT NULL,
  `id_type_nature_economique` int(11) DEFAULT NULL,
  `id_categorie_nature_economique` int(11) DEFAULT NULL,
  `id_mois` int(11) NOT NULL,
  `annee` varchar(4) NOT NULL,
  `prevision` decimal(20,2) DEFAULT NULL,
  `realisation` decimal(20,2) DEFAULT NULL,
  `date_ajout` date NOT NULL,
  `id_etat_donnee` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgda_statistique`
--

INSERT INTO `dgda_statistique` (`id`, `id_ordre`, `id_province`, `id_centre_perception`, `code_nature`, `libelle_nature_economique`, `id_type_secteur_activite`, `id_categorie_secteur_activite`, `id_secteur_activite`, `id_type_nature_economique`, `id_categorie_nature_economique`, `id_mois`, `annee`, `prevision`, `realisation`, `date_ajout`, `id_etat_donnee`) VALUES
(1, 1, 52, 1, '17131120', 'Taxe sur la Valeur Ajoutée à l\'importation', 3, 17, 52, 1, NULL, 1, '2024', 323540.62, 298545.80, '2025-01-20', 3),
(2, 2, 52, 1, '17132111', 'Accises sur les boissons alcoolisées', 3, 16, 48, 2, 1, 1, '2024', 334551.63, 183378.72, '2025-01-20', 3),
(3, 3, 52, 1, '17132131', 'Tabacs fabriqués et leurs sccédanés ainsi que les produits et instruments servant à fumer', 3, 16, 48, 2, 1, 1, '2024', 387635.08, 186025.50, '2025-01-20', 3),
(4, 4, 52, 1, '17132113', 'Eaux de table, limonades et jus', 3, 16, 48, 2, 1, 1, '2024', 319827.57, 293239.31, '2025-01-20', 3),
(5, 5, 52, 1, '17132171', 'Parfums liquides', 3, 16, 49, 2, 1, 1, '2024', 233274.50, 179821.74, '2025-01-20', 3),
(6, 6, 52, 1, '17132142', 'Lubrifiants et huiles de graissage', 3, 16, 50, 2, 1, 1, '2024', 123034.27, 119001.96, '2025-01-20', 3),
(7, 7, 52, 1, '17132173', 'cosmétiques et autres produits d\'entretien', 3, 16, 49, 2, 1, 1, '2024', 333903.35, 146960.30, '2025-01-20', 3),
(8, 8, 52, 1, '17132162', 'Préparation capillaire', 3, 16, 49, 2, 1, 1, '2024', 499556.97, 410205.82, '2025-01-20', 3),
(9, 9, 52, 1, '17132161', 'Préparation pour hygiène buccale', 3, 16, 49, 2, 1, 1, '2024', 10835.84, 9268.91, '2025-01-20', 3),
(10, 10, 52, 1, '17132172', 'Savons, agents de surface organique, cirage et crème pour chaussure', 3, 16, 49, 2, 1, 1, '2024', 495195.60, 258572.42, '2025-01-20', 3),
(11, 11, 52, 1, '17132151', 'Article et ouvrage en matière plastique', 3, 16, 49, 2, 1, 1, '2024', 438794.76, 281242.16, '2025-01-20', 3),
(12, 12, 52, 1, '17132152', 'Article et ouvrage en caoutchouc synthétique', 3, 16, 49, 2, 1, 1, '2024', 69394.29, 39308.78, '2025-01-20', 3),
(13, 13, 52, 1, '17132120', 'Services des télécommunications', 3, 11, 30, 2, 1, 1, '2024', 343251.39, 282077.02, '2025-01-20', 3),
(14, 14, 52, 1, '17132112', 'Alcools, boissons alcooliques ', 3, 16, 48, 2, 1, 1, '2024', 197038.26, 42162.75, '2025-01-20', 3),
(15, 15, 52, 1, '17132130', 'Tabacs fabriqués et leurs sccédanés ainsi que les produits et instruments servant à fumer', 3, 16, 48, 2, 1, 1, '2024', 123455.55, 94041.67, '2025-01-20', 3),
(16, 16, 52, 1, '17132132', 'Droits d\'accises spécial', 3, 16, 50, 2, 1, 1, '2024', 483105.31, 74726.24, '2025-01-20', 3),
(17, 17, 52, 1, '17132141', 'Produits pétroliers', 3, 16, 50, 2, 1, 1, '2024', 301455.67, 168613.64, '2025-01-20', 3),
(18, 18, 52, 1, '17132211', 'Boissons alcoolisées', 3, 16, 48, 2, 2, 1, '2024', 294699.31, 215442.03, '2025-01-20', 3),
(19, 19, 52, 1, '17132231', 'Tabacs importés et leurs sccédanés ainsi que les produits et instruments servant à fumer', 3, 16, 48, 2, 2, 1, '2024', 377775.40, 238017.00, '2025-01-20', 3),
(20, 20, 52, 1, '17132213', 'Eaux de table, limonades et jus', 3, 16, 48, 2, 2, 1, '2024', 176344.08, 164310.03, '2025-01-20', 3),
(21, 21, 52, 1, '17132212', 'Alcools et boissons alcooliques', 3, 16, 48, 2, 2, 1, '2024', 256166.47, 215530.06, '2025-01-20', 3),
(22, 22, 52, 1, '17132281', 'Parfums liquides', 3, 16, 49, 2, 2, 1, '2024', 170456.06, 11117.93, '2025-01-20', 3),
(23, 23, 52, 1, '17132241', 'Produits pétroliers', 3, 16, 50, 2, 2, 1, '2024', 334551.63, 183378.72, '2025-01-20', 3),
(24, 24, 52, 1, '17132242', 'Lubrifiants et huiles de graissage', 3, 16, 50, 2, 2, 1, '2024', 387635.08, 186025.50, '2025-01-20', 3),
(25, 25, 52, 1, '17132283', 'cosmétiques et autres produits d\'entretien', 3, 16, 49, 2, 2, 1, '2024', 319827.57, 293239.31, '2025-01-20', 3),
(26, 26, 52, 1, '17132262', 'Préparation capillaire', 3, 16, 49, 2, 2, 1, '2024', 233274.50, 179821.74, '2025-01-20', 3),
(27, 27, 52, 1, '17132261', 'Préparation pour hygiène buccale', 3, 16, 49, 2, 2, 1, '2024', 123034.27, 119001.96, '2025-01-20', 3),
(28, 28, 52, 1, '17132282', 'Savons, agents de surface organique, cirage et crème pour chaussure', 3, 16, 49, 2, 2, 1, '2024', 333903.35, 146960.30, '2025-01-20', 3),
(29, 29, 52, 1, '17132251', 'Article et ouvrage en matière plastique', 3, 16, 49, 2, 2, 1, '2024', 499556.97, 410205.82, '2025-01-20', 3),
(30, 30, 52, 1, '17132252', 'Article et ouvrage en caoutchouc synthétique', 3, 16, 49, 2, 2, 1, '2024', 10835.84, 9268.91, '2025-01-20', 3),
(31, 31, 52, 1, '17132270', 'Véhicule', 3, 16, 51, 2, 2, 1, '2024', 495195.60, 258572.42, '2025-01-20', 3),
(32, 32, 52, 1, '17132220', 'Services des télécommunications', 3, 11, 32, 2, 2, 1, '2024', 438794.76, 281242.16, '2025-01-20', 3),
(33, 33, 52, 1, '17132232', 'Droit d\'accise spécial', 3, 16, 50, 2, 2, 1, '2024', 69394.29, 39308.78, '2025-01-20', 3),
(34, 34, 52, 1, '37137100', 'Amendes et pénalités relevant des accises perçues en régime intérieur', 3, 16, 51, 3, NULL, 1, '2024', 343251.39, 282077.02, '2025-01-20', 3),
(35, 35, 52, 1, '37137200', 'Amendes et pénalités relevant des accises perçues à l\'importation', 3, 16, 51, 3, NULL, 1, '2024', 197038.26, 42162.75, '2025-01-20', 3),
(36, 36, 52, 1, '17151121', 'Produits partiels des ventes publiques', 3, 16, 51, 4, 4, 1, '2024', 123455.55, 94041.67, '2025-01-20', 3),
(37, 37, 52, 1, '17151122', 'Retenues sur restitutions douanières', 3, 16, 51, 4, 4, 1, '2024', 483105.31, 74726.24, '2025-01-20', 3),
(38, 38, 52, 1, '17151123', 'Taxes sur vente publique', 3, 16, 51, 4, 4, 1, '2024', 301455.67, 168613.64, '2025-01-20', 3),
(39, 39, 52, 1, '17152120', 'Droits de sortie sur le diamant artisanal', 1, 1, 2, 5, 5, 1, '2024', 294699.31, 215442.03, '2025-01-20', 3),
(40, 40, 52, 1, '17152140', 'Droits de sortie sur l\'or artisanal', 1, 1, 3, 5, 5, 1, '2024', 377775.40, 238017.00, '2025-01-20', 3),
(41, 41, 52, 1, '17152110', 'Droits de sortie sur le diamant industriel', 1, 1, 2, 5, 5, 1, '2024', 176344.08, 164310.03, '2025-01-20', 3),
(42, 42, 52, 1, '17152130', 'Droits de sortie sur l\'or industriel', 1, 1, 3, 5, 5, 1, '2024', 256166.47, 215530.06, '2025-01-20', 3),
(43, 43, 52, 1, '17152150', 'Droits de sortie sur les autres produits minéraux', 1, 1, 4, 5, 5, 1, '2024', 170456.06, 11117.93, '2025-01-20', 3),
(44, 44, 52, 1, '17152210', 'Droits de sortie sur le café Robusta', 1, 4, 12, 5, 6, 1, '2024', 334551.63, 183378.72, '2025-01-20', 3),
(45, 45, 52, 1, '17152220', 'Droits de sortie sur le café Arabica', 1, 4, 12, 5, 6, 1, '2024', 387635.08, 186025.50, '2025-01-20', 3),
(46, 46, 52, 1, '17152230', 'Droits de sortie sur le bois en grumes', 1, 3, 9, 5, 6, 1, '2024', 319827.57, 293239.31, '2025-01-20', 3),
(47, 47, 52, 1, '17152240', 'Droits de sortie sur le bois sciés', 1, 3, 9, 5, 6, 1, '2024', 233274.50, 179821.74, '2025-01-20', 3),
(48, 48, 52, 1, '17152250', 'Droits de sortie sur autres produits végétaux', 1, 4, 12, 5, 6, 1, '2024', 123034.27, 119001.96, '2025-01-20', 3),
(49, 49, 52, 1, '17152310', 'Droits de sortie sur l\'énergie électrique et gaz butane', 2, 6, 18, 5, 7, 1, '2024', 333903.35, 146960.30, '2025-01-20', 3),
(50, 50, 52, 1, '17152320', 'Droits de sortie sur l\'huile brute de pétrole', 1, 2, 5, 5, 7, 1, '2024', 499556.97, 410205.82, '2025-01-20', 3),
(51, 51, 52, 1, '17152330', 'Droits de sortie sur l\'eau et autres produits énergétiques', 2, 7, 19, 5, 7, 1, '2024', 10835.84, 9268.91, '2025-01-20', 3),
(52, 52, 52, 1, '37156100', 'Amendes et pénalités à l\'importation', 3, 17, 52, 6, 8, 1, '2024', 495195.60, 258572.42, '2025-01-20', 3),
(53, 53, 52, 1, '37156200', 'Amendes et pénalités à l\'exportation', 3, 17, 52, 6, 9, 1, '2024', 438794.76, 281242.16, '2025-01-20', 3),
(54, 1, 27, 18, '17131120', 'Taxe sur la Valeur Ajoutée à l\'importation', 3, 17, 52, 1, NULL, 1, '2024', 323540.62, 298545.80, '2025-01-20', 3),
(55, 2, 27, 18, '17132111', 'Accises sur les boissons alcoolisées', 3, 16, 48, 2, 1, 1, '2024', 334551.63, 183378.72, '2025-01-20', 3),
(56, 3, 27, 18, '17132131', 'Tabacs fabriqués et leurs sccédanés ainsi que les produits et instruments servant à fumer', 3, 16, 48, 2, 1, 1, '2024', 387635.08, 186025.50, '2025-01-20', 3),
(57, 4, 27, 18, '17132113', 'Eaux de table, limonades et jus', 3, 16, 48, 2, 1, 1, '2024', 319827.57, 293239.31, '2025-01-20', 3),
(58, 5, 27, 18, '17132171', 'Parfums liquides', 3, 16, 49, 2, 1, 1, '2024', 233274.50, 179821.74, '2025-01-20', 3),
(59, 6, 27, 18, '17132142', 'Lubrifiants et huiles de graissage', 3, 16, 50, 2, 1, 1, '2024', 123034.27, 119001.96, '2025-01-20', 3),
(60, 7, 27, 18, '17132173', 'cosmétiques et autres produits d\'entretien', 3, 16, 49, 2, 1, 1, '2024', 333903.35, 146960.30, '2025-01-20', 3),
(61, 8, 27, 18, '17132162', 'Préparation capillaire', 3, 16, 49, 2, 1, 1, '2024', 499556.97, 410205.82, '2025-01-20', 3),
(62, 9, 27, 18, '17132161', 'Préparation pour hygiène buccale', 3, 16, 49, 2, 1, 1, '2024', 10835.84, 9268.91, '2025-01-20', 3),
(63, 10, 27, 18, '17132172', 'Savons, agents de surface organique, cirage et crème pour chaussure', 3, 16, 49, 2, 1, 1, '2024', 495195.60, 258572.42, '2025-01-20', 3),
(64, 11, 27, 18, '17132151', 'Article et ouvrage en matière plastique', 3, 16, 49, 2, 1, 1, '2024', 438794.76, 281242.16, '2025-01-20', 3),
(65, 12, 27, 18, '17132152', 'Article et ouvrage en caoutchouc synthétique', 3, 16, 49, 2, 1, 1, '2024', 69394.29, 39308.78, '2025-01-20', 3),
(66, 13, 27, 18, '17132120', 'Services des télécommunications', 3, 11, 30, 2, 1, 1, '2024', 343251.39, 282077.02, '2025-01-20', 3),
(67, 14, 27, 18, '17132112', 'Alcools, boissons alcooliques ', 3, 16, 48, 2, 1, 1, '2024', 197038.26, 42162.75, '2025-01-20', 3),
(68, 15, 27, 18, '17132130', 'Tabacs fabriqués et leurs sccédanés ainsi que les produits et instruments servant à fumer', 3, 16, 48, 2, 1, 1, '2024', 123455.55, 94041.67, '2025-01-20', 3),
(69, 16, 27, 18, '17132132', 'Droits d\'accises spécial', 3, 16, 50, 2, 1, 1, '2024', 483105.31, 74726.24, '2025-01-20', 3),
(70, 17, 27, 18, '17132141', 'Produits pétroliers', 3, 16, 50, 2, 1, 1, '2024', 301455.67, 168613.64, '2025-01-20', 3),
(71, 18, 27, 18, '17132211', 'Boissons alcoolisées', 3, 16, 48, 2, 2, 1, '2024', 294699.31, 215442.03, '2025-01-20', 3),
(72, 19, 27, 18, '17132231', 'Tabacs importés et leurs sccédanés ainsi que les produits et instruments servant à fumer', 3, 16, 48, 2, 2, 1, '2024', 377775.40, 238017.00, '2025-01-20', 3),
(73, 20, 27, 18, '17132213', 'Eaux de table, limonades et jus', 3, 16, 48, 2, 2, 1, '2024', 176344.08, 164310.03, '2025-01-20', 3),
(74, 21, 27, 18, '17132212', 'Alcools et boissons alcooliques', 3, 16, 48, 2, 2, 1, '2024', 256166.47, 215530.06, '2025-01-20', 3),
(75, 22, 27, 18, '17132281', 'Parfums liquides', 3, 16, 49, 2, 2, 1, '2024', 170456.06, 11117.93, '2025-01-20', 3),
(76, 23, 27, 18, '17132241', 'Produits pétroliers', 3, 16, 50, 2, 2, 1, '2024', 334551.63, 183378.72, '2025-01-20', 3),
(77, 24, 27, 18, '17132242', 'Lubrifiants et huiles de graissage', 3, 16, 50, 2, 2, 1, '2024', 387635.08, 186025.50, '2025-01-20', 3),
(78, 25, 27, 18, '17132283', 'cosmétiques et autres produits d\'entretien', 3, 16, 49, 2, 2, 1, '2024', 319827.57, 293239.31, '2025-01-20', 3),
(79, 26, 27, 18, '17132262', 'Préparation capillaire', 3, 16, 49, 2, 2, 1, '2024', 233274.50, 179821.74, '2025-01-20', 3),
(80, 27, 27, 18, '17132261', 'Préparation pour hygiène buccale', 3, 16, 49, 2, 2, 1, '2024', 123034.27, 119001.96, '2025-01-20', 3),
(81, 28, 27, 18, '17132282', 'Savons, agents de surface organique, cirage et crème pour chaussure', 3, 16, 49, 2, 2, 1, '2024', 333903.35, 146960.30, '2025-01-20', 3),
(82, 29, 27, 18, '17132251', 'Article et ouvrage en matière plastique', 3, 16, 49, 2, 2, 1, '2024', 499556.97, 410205.82, '2025-01-20', 3),
(83, 30, 27, 18, '17132252', 'Article et ouvrage en caoutchouc synthétique', 3, 16, 49, 2, 2, 1, '2024', 10835.84, 9268.91, '2025-01-20', 3),
(84, 31, 27, 18, '17132270', 'Véhicule', 3, 16, 51, 2, 2, 1, '2024', 495195.60, 258572.42, '2025-01-20', 3),
(85, 32, 27, 18, '17132220', 'Services des télécommunications', 3, 11, 32, 2, 2, 1, '2024', 438794.76, 281242.16, '2025-01-20', 3),
(86, 33, 27, 18, '17132232', 'Droit d\'accise spécial', 3, 16, 50, 2, 2, 1, '2024', 69394.29, 39308.78, '2025-01-20', 3),
(87, 34, 27, 18, '37137100', 'Amendes et pénalités relevant des accises perçues en régime intérieur', 3, 16, 51, 3, NULL, 1, '2024', 343251.39, 282077.02, '2025-01-20', 3),
(88, 35, 27, 18, '37137200', 'Amendes et pénalités relevant des accises perçues à l\'importation', 3, 16, 51, 3, NULL, 1, '2024', 197038.26, 42162.75, '2025-01-20', 3),
(89, 36, 27, 18, '17151121', 'Produits partiels des ventes publiques', 3, 16, 51, 4, 4, 1, '2024', 123455.55, 94041.67, '2025-01-20', 3),
(90, 37, 27, 18, '17151122', 'Retenues sur restitutions douanières', 3, 16, 51, 4, 4, 1, '2024', 483105.31, 74726.24, '2025-01-20', 3),
(91, 38, 27, 18, '17151123', 'Taxes sur vente publique', 3, 16, 51, 4, 4, 1, '2024', 301455.67, 168613.64, '2025-01-20', 3),
(92, 39, 27, 18, '17152120', 'Droits de sortie sur le diamant artisanal', 1, 1, 2, 5, 5, 1, '2024', 294699.31, 215442.03, '2025-01-20', 3),
(93, 40, 27, 18, '17152140', 'Droits de sortie sur l\'or artisanal', 1, 1, 3, 5, 5, 1, '2024', 377775.40, 238017.00, '2025-01-20', 3),
(94, 41, 27, 18, '17152110', 'Droits de sortie sur le diamant industriel', 1, 1, 2, 5, 5, 1, '2024', 176344.08, 164310.03, '2025-01-20', 3),
(95, 42, 27, 18, '17152130', 'Droits de sortie sur l\'or industriel', 1, 1, 3, 5, 5, 1, '2024', 256166.47, 215530.06, '2025-01-20', 3),
(96, 43, 27, 18, '17152150', 'Droits de sortie sur les autres produits minéraux', 1, 1, 4, 5, 5, 1, '2024', 170456.06, 11117.93, '2025-01-20', 3),
(97, 44, 27, 18, '17152210', 'Droits de sortie sur le café Robusta', 1, 4, 12, 5, 6, 1, '2024', 334551.63, 183378.72, '2025-01-20', 3),
(98, 45, 27, 18, '17152220', 'Droits de sortie sur le café Arabica', 1, 4, 12, 5, 6, 1, '2024', 387635.08, 186025.50, '2025-01-20', 3),
(99, 46, 27, 18, '17152230', 'Droits de sortie sur le bois en grumes', 1, 3, 9, 5, 6, 1, '2024', 319827.57, 293239.31, '2025-01-20', 3),
(100, 47, 27, 18, '17152240', 'Droits de sortie sur le bois sciés', 1, 3, 9, 5, 6, 1, '2024', 233274.50, 179821.74, '2025-01-20', 3),
(101, 48, 27, 18, '17152250', 'Droits de sortie sur autres produits végétaux', 1, 4, 12, 5, 6, 1, '2024', 123034.27, 119001.96, '2025-01-20', 3),
(102, 49, 27, 18, '17152310', 'Droits de sortie sur l\'énergie électrique et gaz butane', 2, 6, 18, 5, 7, 1, '2024', 333903.35, 146960.30, '2025-01-20', 3),
(103, 50, 27, 18, '17152320', 'Droits de sortie sur l\'huile brute de pétrole', 1, 2, 5, 5, 7, 1, '2024', 499556.97, 410205.82, '2025-01-20', 3),
(104, 51, 27, 18, '17152330', 'Droits de sortie sur l\'eau et autres produits énergétiques', 2, 7, 19, 5, 7, 1, '2024', 10835.84, 9268.91, '2025-01-20', 3),
(105, 52, 27, 18, '37156100', 'Amendes et pénalités à l\'importation', 3, 17, 52, 6, 8, 1, '2024', 495195.60, 258572.42, '2025-01-20', 3),
(106, 53, 27, 18, '37156200', 'Amendes et pénalités à l\'exportation', 3, 17, 52, 6, 9, 1, '2024', 438794.76, 281242.16, '2025-01-20', 3),
(107, 1, 52, 1, '17131120', 'Taxe sur la Valeur Ajoutée à l\'importation', 3, 17, 52, 1, NULL, 2, '2024', 3203540.62, 2908545.80, '2025-01-21', 3),
(108, 2, 52, 1, '17132111', 'Accises sur les boissons alcoolisées', 3, 16, 48, 2, 1, 2, '2024', 334551.63, 183378.72, '2025-01-21', 3),
(109, 3, 52, 1, '17132131', 'Tabacs fabriqués et leurs sccédanés ainsi que les produits et instruments servant à fumer', 3, 16, 48, 2, 1, 2, '2024', 387635.08, 186025.50, '2025-01-21', 3),
(110, 4, 52, 1, '17132113', 'Eaux de table, limonades et jus', 3, 16, 48, 2, 1, 2, '2024', 319827.57, 293239.31, '2025-01-21', 3),
(111, 5, 52, 1, '17132171', 'Parfums liquides', 3, 16, 49, 2, 1, 2, '2024', 233274.50, 179821.74, '2025-01-21', 3),
(112, 6, 52, 1, '17132142', 'Lubrifiants et huiles de graissage', 3, 16, 50, 2, 1, 2, '2024', 123034.27, 119001.96, '2025-01-21', 3),
(113, 7, 52, 1, '17132173', 'cosmétiques et autres produits d\'entretien', 3, 16, 49, 2, 1, 2, '2024', 333903.35, 146960.30, '2025-01-21', 3),
(114, 8, 52, 1, '17132162', 'Préparation capillaire', 3, 16, 49, 2, 1, 2, '2024', 499556.97, 410205.82, '2025-01-21', 3),
(115, 9, 52, 1, '17132161', 'Préparation pour hygiène buccale', 3, 16, 49, 2, 1, 2, '2024', 10835.84, 9268.91, '2025-01-21', 3),
(116, 10, 52, 1, '17132172', 'Savons, agents de surface organique, cirage et crème pour chaussure', 3, 16, 49, 2, 1, 2, '2024', 495195.60, 258572.42, '2025-01-21', 3),
(117, 11, 52, 1, '17132151', 'Article et ouvrage en matière plastique', 3, 16, 49, 2, 1, 2, '2024', 438794.76, 281242.16, '2025-01-21', 3),
(118, 12, 52, 1, '17132152', 'Article et ouvrage en caoutchouc synthétique', 3, 16, 49, 2, 1, 2, '2024', 69394.29, 39308.78, '2025-01-21', 3),
(119, 13, 52, 1, '17132120', 'Services des télécommunications', 3, 11, 30, 2, 1, 2, '2024', 343251.39, 282077.02, '2025-01-21', 3),
(120, 14, 52, 1, '17132112', 'Alcools, boissons alcooliques ', 3, 16, 48, 2, 1, 2, '2024', 197038.26, 42162.75, '2025-01-21', 3),
(121, 15, 52, 1, '17132130', 'Tabacs fabriqués et leurs sccédanés ainsi que les produits et instruments servant à fumer', 3, 16, 48, 2, 1, 2, '2024', 123455.55, 94041.67, '2025-01-21', 3),
(122, 16, 52, 1, '17132132', 'Droits d\'accises spécial', 3, 16, 50, 2, 1, 2, '2024', 483105.31, 74726.24, '2025-01-21', 3),
(123, 17, 52, 1, '17132141', 'Produits pétroliers', 3, 16, 50, 2, 1, 2, '2024', 301455.67, 168613.64, '2025-01-21', 3),
(124, 18, 52, 1, '17132211', 'Boissons alcoolisées', 3, 16, 48, 2, 2, 2, '2024', 294699.31, 215442.03, '2025-01-21', 3),
(125, 19, 52, 1, '17132231', 'Tabacs importés et leurs sccédanés ainsi que les produits et instruments servant à fumer', 3, 16, 48, 2, 2, 2, '2024', 377775.40, 238017.00, '2025-01-21', 3),
(126, 20, 52, 1, '17132213', 'Eaux de table, limonades et jus', 3, 16, 48, 2, 2, 2, '2024', 176344.08, 164310.03, '2025-01-21', 3),
(127, 21, 52, 1, '17132212', 'Alcools et boissons alcooliques', 3, 16, 48, 2, 2, 2, '2024', 256166.47, 215530.06, '2025-01-21', 3),
(128, 22, 52, 1, '17132281', 'Parfums liquides', 3, 16, 49, 2, 2, 2, '2024', 170456.06, 11117.93, '2025-01-21', 3),
(129, 23, 52, 1, '17132241', 'Produits pétroliers', 3, 16, 50, 2, 2, 2, '2024', 334551.63, 183378.72, '2025-01-21', 3),
(130, 24, 52, 1, '17132242', 'Lubrifiants et huiles de graissage', 3, 16, 50, 2, 2, 2, '2024', 387635.08, 186025.50, '2025-01-21', 3),
(131, 25, 52, 1, '17132283', 'cosmétiques et autres produits d\'entretien', 3, 16, 49, 2, 2, 2, '2024', 319827.57, 293239.31, '2025-01-21', 3),
(132, 26, 52, 1, '17132262', 'Préparation capillaire', 3, 16, 49, 2, 2, 2, '2024', 233274.50, 179821.74, '2025-01-21', 3),
(133, 27, 52, 1, '17132261', 'Préparation pour hygiène buccale', 3, 16, 49, 2, 2, 2, '2024', 123034.27, 119001.96, '2025-01-21', 3),
(134, 28, 52, 1, '17132282', 'Savons, agents de surface organique, cirage et crème pour chaussure', 3, 16, 49, 2, 2, 2, '2024', 333903.35, 146960.30, '2025-01-21', 3),
(135, 29, 52, 1, '17132251', 'Article et ouvrage en matière plastique', 3, 16, 49, 2, 2, 2, '2024', 499556.97, 410205.82, '2025-01-21', 3),
(136, 30, 52, 1, '17132252', 'Article et ouvrage en caoutchouc synthétique', 3, 16, 49, 2, 2, 2, '2024', 10835.84, 9268.91, '2025-01-21', 3),
(137, 31, 52, 1, '17132270', 'Véhicule', 3, 16, 51, 2, 2, 2, '2024', 495195.60, 258572.42, '2025-01-21', 3),
(138, 32, 52, 1, '17132220', 'Services des télécommunications', 3, 11, 32, 2, 2, 2, '2024', 438794.76, 281242.16, '2025-01-21', 3),
(139, 33, 52, 1, '17132232', 'Droit d\'accise spécial', 3, 16, 50, 2, 2, 2, '2024', 69394.29, 39308.78, '2025-01-21', 3),
(140, 34, 52, 1, '37137100', 'Amendes et pénalités relevant des accises perçues en régime intérieur', 3, 16, 51, 3, NULL, 2, '2024', 343251.39, 282077.02, '2025-01-21', 3),
(141, 35, 52, 1, '37137200', 'Amendes et pénalités relevant des accises perçues à l\'importation', 3, 16, 51, 3, NULL, 2, '2024', 197038.26, 42162.75, '2025-01-21', 3),
(142, 36, 52, 1, '17151121', 'Produits partiels des ventes publiques', 3, 16, 51, 4, 4, 2, '2024', 123455.55, 94041.67, '2025-01-21', 3),
(143, 37, 52, 1, '17151122', 'Retenues sur restitutions douanières', 3, 16, 51, 4, 4, 2, '2024', 483105.31, 74726.24, '2025-01-21', 3),
(144, 38, 52, 1, '17151123', 'Taxes sur vente publique', 3, 16, 51, 4, 4, 2, '2024', 301455.67, 168613.64, '2025-01-21', 3),
(145, 39, 52, 1, '17152120', 'Droits de sortie sur le diamant artisanal', 1, 1, 2, 5, 5, 2, '2024', 294699.31, 215442.03, '2025-01-21', 3),
(146, 40, 52, 1, '17152140', 'Droits de sortie sur l\'or artisanal', 1, 1, 3, 5, 5, 2, '2024', 377775.40, 238017.00, '2025-01-21', 3),
(147, 41, 52, 1, '17152110', 'Droits de sortie sur le diamant industriel', 1, 1, 2, 5, 5, 2, '2024', 176344.08, 164310.03, '2025-01-21', 3),
(148, 42, 52, 1, '17152130', 'Droits de sortie sur l\'or industriel', 1, 1, 3, 5, 5, 2, '2024', 256166.47, 215530.06, '2025-01-21', 3),
(149, 43, 52, 1, '17152150', 'Droits de sortie sur les autres produits minéraux', 1, 1, 4, 5, 5, 2, '2024', 170456.06, 11117.93, '2025-01-21', 3),
(150, 44, 52, 1, '17152210', 'Droits de sortie sur le café Robusta', 1, 4, 12, 5, 6, 2, '2024', 334551.63, 183378.72, '2025-01-21', 3),
(151, 45, 52, 1, '17152220', 'Droits de sortie sur le café Arabica', 1, 4, 12, 5, 6, 2, '2024', 387635.08, 186025.50, '2025-01-21', 3),
(152, 46, 52, 1, '17152230', 'Droits de sortie sur le bois en grumes', 1, 3, 9, 5, 6, 2, '2024', 319827.57, 293239.31, '2025-01-21', 3),
(153, 47, 52, 1, '17152240', 'Droits de sortie sur le bois sciés', 1, 3, 9, 5, 6, 2, '2024', 233274.50, 179821.74, '2025-01-21', 3),
(154, 48, 52, 1, '17152250', 'Droits de sortie sur autres produits végétaux', 1, 4, 12, 5, 6, 2, '2024', 123034.27, 119001.96, '2025-01-21', 3),
(155, 49, 52, 1, '17152310', 'Droits de sortie sur l\'énergie électrique et gaz butane', 2, 6, 18, 5, 7, 2, '2024', 333903.35, 146960.30, '2025-01-21', 3),
(156, 50, 52, 1, '17152320', 'Droits de sortie sur l\'huile brute de pétrole', 1, 2, 5, 5, 7, 2, '2024', 499556.97, 410205.82, '2025-01-21', 3),
(157, 51, 52, 1, '17152330', 'Droits de sortie sur l\'eau et autres produits énergétiques', 2, 7, 19, 5, 7, 2, '2024', 10835.84, 9268.91, '2025-01-21', 3),
(158, 52, 52, 1, '37156100', 'Amendes et pénalités à l\'importation', 3, 17, 52, 6, 8, 2, '2024', 495195.60, 258572.42, '2025-01-21', 3),
(159, 53, 52, 1, '37156200', 'Amendes et pénalités à l\'exportation', 3, 17, 52, 6, 9, 2, '2024', 438794.76, 281242.16, '2025-01-21', 3);

-- --------------------------------------------------------

--
-- Structure de la table `dgda_type_nature_economique`
--

CREATE TABLE `dgda_type_nature_economique` (
  `id` int(11) NOT NULL,
  `libelle_type_nature_economique` text NOT NULL,
  `code_type_nature_economique` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgda_type_nature_economique`
--

INSERT INTO `dgda_type_nature_economique` (`id`, `libelle_type_nature_economique`, `code_type_nature_economique`) VALUES
(1, 'Impôts  généraux sur les biens et services', '17130000'),
(2, 'Droits d\'Accises', '17132000'),
(3, 'Amendes et pénalités sur impôts et taxes sur les biens et services', '31137000'),
(4, 'Droit de douane et autres droits à l\'importation', '17151100'),
(5, 'Taxe à l\'exportation', '17152000'),
(6, 'Amendes et pénalités sur impôts sur le commerce et transactions internationales', '37156000');

-- --------------------------------------------------------

--
-- Structure de la table `dgda_type_secteur_activite`
--

CREATE TABLE `dgda_type_secteur_activite` (
  `id` int(11) NOT NULL,
  `libelle_type_secteur` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgda_type_secteur_activite`
--

INSERT INTO `dgda_type_secteur_activite` (`id`, `libelle_type_secteur`) VALUES
(1, 'SECTEUR PRIMAIRE'),
(2, 'SECTEUR SECONDAIRE'),
(3, 'SECTEUR TERTIAIRE');

-- --------------------------------------------------------

--
-- Structure de la table `dgda_utilisateur`
--

CREATE TABLE `dgda_utilisateur` (
  `id` int(11) NOT NULL,
  `pseudo` text NOT NULL,
  `motdepasse` text NOT NULL,
  `token_utilisateur` text NOT NULL,
  `id_centre_perception` int(11) DEFAULT NULL,
  `id_province` int(11) DEFAULT NULL,
  `id_role` int(11) NOT NULL,
  `id_etat_utilisateur` int(11) NOT NULL,
  `id_service_pourvoyeur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgda_utilisateur`
--

INSERT INTO `dgda_utilisateur` (`id`, `pseudo`, `motdepasse`, `token_utilisateur`, `id_centre_perception`, `id_province`, `id_role`, `id_etat_utilisateur`, `id_service_pourvoyeur`) VALUES
(1, 'KKDAN', '7c222fb2927d828af22f592134e8932480637c0d', 'eb860fd7346ac60cb36875c4b140d555309df01c', NULL, NULL, 1, 1, 2),
(2, 'WLJOEL', '7c222fb2927d828af22f592134e8932480637c0d', '38349b40b47ceb5a7a4386ee1c6edb989096ca53', NULL, NULL, 2, 1, 2),
(3, 'KKCLEBERG', '7c222fb2927d828af22f592134e8932480637c0d', '0df6b642545331f611f0c931c0f5deb63c0d084a', 1, 52, 3, 1, 2),
(4, 'JMJean', '7c222fb2927d828af22f592134e8932480637c0d', '71d62da61576b0e483d0b9895248b3fa7eef065d', 18, 27, 3, 1, 2),
(5, 'APAnna', '7c222fb2927d828af22f592134e8932480637c0d', 'b5456364ca96b4565e26dea9b2685c190fa37a2a', 21, 28, 3, 1, 2),
(6, 'TKThomas', '7c222fb2927d828af22f592134e8932480637c0d', '9a586deaeda3df1803270731fe0d5a37b86837cd', 4, 29, 3, 1, 2),
(7, 'CBClara', '7c222fb2927d828af22f592134e8932480637c0d', '12535b0226c6c687d54a4cadee1ed45d7966dc14', 6, 30, 3, 1, 2),
(8, 'LDLucas', '7c222fb2927d828af22f592134e8932480637c0d', 'c4431678f987e74088884abf0264c664013a87c0', 19, 31, 3, 1, 2),
(9, 'RGRobert', '7c222fb2927d828af22f592134e8932480637c0d', '781c925b7624e9d70bc46df4b3c37372a49e0fc3', 20, 32, 3, 1, 2),
(10, 'SVSophie', '7c222fb2927d828af22f592134e8932480637c0d', 'efa3f9b80856dfccd053d4a826e36db2d4b5e4c6', 15, 33, 3, 1, 2),
(11, 'FTFrançois', '7c222fb2927d828af22f592134e8932480637c0d', '1ba86e593b2f5ed0a11f814c2bad97f153d4da8a', 12, 34, 3, 1, 2),
(12, 'MLMarie', '7c222fb2927d828af22f592134e8932480637c0d', 'e704842e466b07461d624d2e341cf3dfbe37af3d', 8, 35, 3, 1, 2),
(13, 'JBJulien', '7c222fb2927d828af22f592134e8932480637c0d', '3a4648fcb7491be2b29d1d0a0e0d77da2740f667', 10, 36, 3, 1, 2),
(14, 'OKOscar', '7c222fb2927d828af22f592134e8932480637c0d', 'a79d0e125cffeefe203725cc189f9cd6b1ed6d50', 9, 37, 3, 1, 2),
(15, 'PPPaul', '7c222fb2927d828af22f592134e8932480637c0d', '17c34d71a6504312d3c440116d1d0991b14000ea', 13, 38, 3, 1, 2),
(16, 'NTNathan', '7c222fb2927d828af22f592134e8932480637c0d', '17acc8e4e4eef7f7b2535b2fc88453f9829988b8', 5, 39, 3, 1, 2),
(17, 'EHElisa', '7c222fb2927d828af22f592134e8932480637c0d', 'bff29c9d610404d104e2841757c891f6ada62b71', 16, 40, 3, 1, 2),
(18, 'AMAlice', '7c222fb2927d828af22f592134e8932480637c0d', 'cdd7be57a80e432fc84ce51af73240b5d8d20823', 11, 41, 3, 1, 2),
(19, 'CRChloé', '7c222fb2927d828af22f592134e8932480637c0d', '5082934641f8ab1b5e5752d7d2ee79abbe7dc6a0', 28, 42, 3, 1, 2),
(20, 'ZJZoé', '7c222fb2927d828af22f592134e8932480637c0d', '0c2452e5be1b891d863f24525094049d06e4d2b5', 22, 43, 3, 1, 2),
(21, 'DVDavid', '7c222fb2927d828af22f592134e8932480637c0d', 'fe898319bec95e981d4b81aec8bfa5ee3fcd3ed0', 26, 44, 3, 1, 2),
(22, 'FNFiona', '7c222fb2927d828af22f592134e8932480637c0d', 'b616fdda554b04b2682ce51abe3f1116af5f9b83', 23, 45, 3, 1, 2),
(23, 'GLGabriel', '7c222fb2927d828af22f592134e8932480637c0d', 'dd4b9d204f0a87af5f015b34feb4810d590e2702', 14, 46, 3, 1, 2),
(24, 'HRHugo', '7c222fb2927d828af22f592134e8932480637c0d', '8249917234345e33ec00f7f1582773aabb433197', 27, 47, 3, 1, 2),
(25, 'LELaura', '7c222fb2927d828af22f592134e8932480637c0d', '794264a1a3028a83477b9bb70cac07f4022d491a', 24, 48, 3, 1, 2),
(26, 'MBMathieu', '7c222fb2927d828af22f592134e8932480637c0d', 'ba88edea183de45f2d78ce6a1ae760d92fb988f0', 7, 49, 3, 1, 2),
(27, 'SKSarah', '7c222fb2927d828af22f592134e8932480637c0d', '283e919d126d9aed6697e388d957e924978d2e02', 17, 50, 3, 1, 2),
(28, 'YAYann', '7c222fb2927d828af22f592134e8932480637c0d', '5ae21cc9521deb045f9ed0ea478f6dd7faa01505', 25, 51, 3, 1, 2),
(29, 'TCTimo', '7c222fb2927d828af22f592134e8932480637c0d', 'af192cbe4e0149f37fc1141809c172d2468ecb1b', 2, 52, 3, 1, 2),
(30, 'NRNora', '7c222fb2927d828af22f592134e8932480637c0d', '85991d3fd765d86609dad6979765eedaee9429bf', 3, 52, 3, 1, 2);

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
  `prevision` decimal(20,2) DEFAULT NULL,
  `realisation` decimal(20,2) DEFAULT NULL,
  `date_ajout` date NOT NULL,
  `id_etat_donnee` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgi_statistique`
--

INSERT INTO `dgi_statistique` (`id`, `id_ordre`, `id_province`, `id_centre_perception`, `code_nature`, `libelle_nature_recette`, `id_type_nature_recette`, `id_categorie_nature_recette`, `id_mois`, `annee`, `prevision`, `realisation`, `date_ajout`, `id_etat_donnee`) VALUES
(1, 1, 1, 1, '171 111 10', 'Impôt sur les revenus salariaux des Nationaux/Hors membres des Institutions politiques et fonctionnaires et agents publics', 1, 1, 1, '2024', 323540.62, 298545.80, '2025-02-07', 3),
(2, 2, 1, 1, '171 111 20', 'Impôt sur les revenus salariaux des Nationaux/Membres des Institutions Politiques', 1, 1, 1, '2024', 334551.63, 183378.72, '2025-02-07', 3),
(3, 3, 1, 1, '171 111 30', 'Impôt sur les revenus salariaux des Nationaux/Fonctionnaires et Agents publics', 1, 1, 1, '2024', 387635.08, 186025.50, '2025-02-07', 3),
(4, 4, 1, 1, '171 111 31', 'Impôt sur les revenus salariaux des Nationaux/Autres fonctionnaires et Agents publics', 1, 1, 1, '2024', 319827.57, 293239.31, '2025-02-07', 3),
(5, 5, 1, 1, '171 111 32', 'Impôt sur les revenus salariaux des Nationaux/Agents des Régies financières', 1, 1, 1, '2024', 233274.50, 179821.74, '2025-02-07', 3),
(6, 6, 1, 1, '171 112 00', 'Impôt sur les revenus salariaux des Expatriés', 1, 1, 1, '2024', 123034.27, 119001.96, '2025-02-07', 3),
(7, 7, 1, 1, '171 114 00', 'Impôt Exceptionnel sur les rémunérations versées aux Expatriés (IERE)', 1, 1, 1, '2024', 333903.35, 146960.30, '2025-02-07', 3),
(8, 8, 1, 1, '171 121 00', 'Impôt sur les bénéfices et profits des grandes et moyennes entreprises non pétrolières de production', 1, 2, 1, '2024', 499556.97, 410205.82, '2025-02-07', 3),
(9, 9, 1, 1, '999 999 01', 'Impôt spécial sur les profits excédentaires', 1, 2, 1, '2024', 10835.84, 9268.91, '2025-02-07', 3),
(10, 10, 1, 1, '999 999 02', 'Impôt Spécial sur les Plus-Values de cessions d\'actions ou de parts sociales', 1, 2, 1, '2024', 495195.60, 258572.42, '2025-02-07', 3),
(11, 11, 1, 1, '171 123 00', 'Impôt sur les bénéfices et profits des entreprises de petite taille', 1, 2, 1, '2024', 438794.76, 281242.16, '2025-02-07', 3),
(12, 12, 1, 1, '171 123 10/171 123 20', 'Impôt sur les bénéfices et profits des petites entreprises', 1, 2, 1, '2024', 69394.29, 39308.78, '2025-02-07', 3),
(13, 13, 1, 1, '171 123 30', 'Impôt sur les bénéfices et profits des micro-entreprises', 1, 2, 1, '2024', 343251.39, 282077.02, '2025-02-07', 3),
(14, 14, 1, 1, '171 124 00', 'Impôt professionnel sur les prestations de services des non résidents', 1, 2, 1, '2024', 197038.26, 42162.75, '2025-02-07', 3),
(15, 15, 1, 1, '171 130 00', 'Impôt sur les revenus des capitaux mobiliers', 1, 2, 1, '2024', 123455.55, 94041.67, '2025-02-07', 3),
(16, 16, 1, 1, '999 999 03', 'Impôt sur le Chiffre d\'Affaires à l\'Intérieur', 1, 3, 1, '2024', 483105.31, 74726.24, '2025-02-07', 3),
(17, 17, 1, 1, '171 341 10', 'Immatriculation des véhicules', 1, 4, 1, '2024', 301455.67, 168613.64, '2025-02-07', 3),
(18, 18, 1, 1, '270 122 29', 'Vente des imprimés', 1, 4, 1, '2024', 294699.31, 215442.03, '2025-02-07', 3),
(19, 19, 1, 1, '371 370 00', 'Amendes et pénalités', 1, 4, 1, '2024', 377775.40, 238017.00, '2025-02-07', 3),
(20, 20, 1, 1, '171 311 00', 'TAXE SUR LA VALEUR AJOUTEE SUR DECLARATIONS', 2, NULL, 1, '2024', 176344.08, 164310.03, '2025-02-07', 3),
(21, 21, 1, 1, '999 999 04', 'TAXE SUR LA VALEUR AJOUTEE RECOUVREE SUR AMR A', 2, NULL, 1, '2024', 256166.47, 215530.06, '2025-02-07', 3),
(22, 22, 1, 1, '999 999 05', 'IBP DES PETROLIERS PRODUCTEURS', NULL, NULL, 1, '2024', 170456.00, 11117.93, '2025-02-07', 3),
(23, 1, 2, 28, '171 111 10', 'Impôt sur les revenus salariaux des Nationaux/Hors membres des Institutions politiques et fonctionnaires et agents publics', 1, 1, 1, '2024', 323540.62, 298545.80, '2025-02-07', 3),
(24, 2, 2, 28, '171 111 20', 'Impôt sur les revenus salariaux des Nationaux/Membres des Institutions Politiques', 1, 1, 1, '2024', 334551.63, 183378.72, '2025-02-07', 3),
(25, 3, 2, 28, '171 111 30', 'Impôt sur les revenus salariaux des Nationaux/Fonctionnaires et Agents publics', 1, 1, 1, '2024', 387635.08, 186025.50, '2025-02-07', 3),
(26, 4, 2, 28, '171 111 31', 'Impôt sur les revenus salariaux des Nationaux/Autres fonctionnaires et Agents publics', 1, 1, 1, '2024', 319827.57, 293239.31, '2025-02-07', 3),
(27, 5, 2, 28, '171 111 32', 'Impôt sur les revenus salariaux des Nationaux/Agents des Régies financières', 1, 1, 1, '2024', 233274.50, 179821.74, '2025-02-07', 3),
(28, 6, 2, 28, '171 112 00', 'Impôt sur les revenus salariaux des Expatriés', 1, 1, 1, '2024', 123034.27, 119001.96, '2025-02-07', 3),
(29, 7, 2, 28, '171 114 00', 'Impôt Exceptionnel sur les rémunérations versées aux Expatriés (IERE)', 1, 1, 1, '2024', 333903.35, 146960.30, '2025-02-07', 3),
(30, 8, 2, 28, '171 121 00', 'Impôt sur les bénéfices et profits des grandes et moyennes entreprises non pétrolières de production', 1, 2, 1, '2024', 499556.97, 410205.82, '2025-02-07', 3),
(31, 9, 2, 28, '999 999 01', 'Impôt spécial sur les profits excédentaires', 1, 2, 1, '2024', 10835.84, 9268.91, '2025-02-07', 3),
(32, 10, 2, 28, '999 999 02', 'Impôt Spécial sur les Plus-Values de cessions d\'actions ou de parts sociales', 1, 2, 1, '2024', 495195.60, 258572.42, '2025-02-07', 3),
(33, 11, 2, 28, '171 123 00', 'Impôt sur les bénéfices et profits des entreprises de petite taille', 1, 2, 1, '2024', 438794.76, 281242.16, '2025-02-07', 3),
(34, 12, 2, 28, '171 123 10/171 123 20', 'Impôt sur les bénéfices et profits des petites entreprises', 1, 2, 1, '2024', 69394.29, 39308.78, '2025-02-07', 3),
(35, 13, 2, 28, '171 123 30', 'Impôt sur les bénéfices et profits des micro-entreprises', 1, 2, 1, '2024', 343251.39, 282077.02, '2025-02-07', 3),
(36, 14, 2, 28, '171 124 00', 'Impôt professionnel sur les prestations de services des non résidents', 1, 2, 1, '2024', 197038.26, 42162.75, '2025-02-07', 3),
(37, 15, 2, 28, '171 130 00', 'Impôt sur les revenus des capitaux mobiliers', 1, 2, 1, '2024', 123455.55, 94041.67, '2025-02-07', 3),
(38, 16, 2, 28, '999 999 03', 'Impôt sur le Chiffre d\'Affaires à l\'Intérieur', 1, 3, 1, '2024', 483105.31, 74726.24, '2025-02-07', 3),
(39, 17, 2, 28, '171 341 10', 'Immatriculation des véhicules', 1, 4, 1, '2024', 301455.67, 168613.64, '2025-02-07', 3),
(40, 18, 2, 28, '270 122 29', 'Vente des imprimés', 1, 4, 1, '2024', 294699.31, 215442.03, '2025-02-07', 3),
(41, 19, 2, 28, '371 370 00', 'Amendes et pénalités', 1, 4, 1, '2024', 377775.40, 238017.00, '2025-02-07', 3),
(42, 20, 2, 28, '171 311 00', 'TAXE SUR LA VALEUR AJOUTEE SUR DECLARATIONS', 2, NULL, 1, '2024', 176344.08, 164310.03, '2025-02-07', 3),
(43, 21, 2, 28, '999 999 04', 'TAXE SUR LA VALEUR AJOUTEE RECOUVREE SUR AMR A', 2, NULL, 1, '2024', 256166.47, 215530.06, '2025-02-07', 3),
(44, 22, 2, 28, '999 999 05', 'IBP DES PETROLIERS PRODUCTEURS', NULL, NULL, 1, '2024', 170456.00, 11117.93, '2025-02-07', 3),
(45, 1, 1, 1, '171 111 10', 'Impôt sur les revenus salariaux des Nationaux/Hors membres des Institutions politiques et fonctionnaires et agents publics', 1, 1, 2, '2024', 323540.62, 298545.80, '2025-02-07', 3),
(46, 2, 1, 1, '171 111 20', 'Impôt sur les revenus salariaux des Nationaux/Membres des Institutions Politiques', 1, 1, 2, '2024', 334551.63, 183378.72, '2025-02-07', 3),
(47, 3, 1, 1, '171 111 30', 'Impôt sur les revenus salariaux des Nationaux/Fonctionnaires et Agents publics', 1, 1, 2, '2024', 387635.08, 186025.50, '2025-02-07', 3),
(48, 4, 1, 1, '171 111 31', 'Impôt sur les revenus salariaux des Nationaux/Autres fonctionnaires et Agents publics', 1, 1, 2, '2024', 319827.57, 293239.31, '2025-02-07', 3),
(49, 5, 1, 1, '171 111 32', 'Impôt sur les revenus salariaux des Nationaux/Agents des Régies financières', 1, 1, 2, '2024', 233274.50, 179821.74, '2025-02-07', 3),
(50, 6, 1, 1, '171 112 00', 'Impôt sur les revenus salariaux des Expatriés', 1, 1, 2, '2024', 123034.27, 119001.96, '2025-02-07', 3),
(51, 7, 1, 1, '171 114 00', 'Impôt Exceptionnel sur les rémunérations versées aux Expatriés (IERE)', 1, 1, 2, '2024', 333903.35, 146960.30, '2025-02-07', 3),
(52, 8, 1, 1, '171 121 00', 'Impôt sur les bénéfices et profits des grandes et moyennes entreprises non pétrolières de production', 1, 2, 2, '2024', 499556.97, 410205.82, '2025-02-07', 3),
(53, 9, 1, 1, '999 999 01', 'Impôt spécial sur les profits excédentaires', 1, 2, 2, '2024', 10835.84, 9268.91, '2025-02-07', 3),
(54, 10, 1, 1, '999 999 02', 'Impôt Spécial sur les Plus-Values de cessions d\'actions ou de parts sociales', 1, 2, 2, '2024', 495195.60, 258572.42, '2025-02-07', 3),
(55, 11, 1, 1, '171 123 00', 'Impôt sur les bénéfices et profits des entreprises de petite taille', 1, 2, 2, '2024', 438794.76, 281242.16, '2025-02-07', 3),
(56, 12, 1, 1, '171 123 10/171 123 20', 'Impôt sur les bénéfices et profits des petites entreprises', 1, 2, 2, '2024', 69394.29, 39308.78, '2025-02-07', 3),
(57, 13, 1, 1, '171 123 30', 'Impôt sur les bénéfices et profits des micro-entreprises', 1, 2, 2, '2024', 343251.39, 282077.02, '2025-02-07', 3),
(58, 14, 1, 1, '171 124 00', 'Impôt professionnel sur les prestations de services des non résidents', 1, 2, 2, '2024', 197038.26, 42162.75, '2025-02-07', 3),
(59, 15, 1, 1, '171 130 00', 'Impôt sur les revenus des capitaux mobiliers', 1, 2, 2, '2024', 123455.55, 94041.67, '2025-02-07', 3),
(60, 16, 1, 1, '999 999 03', 'Impôt sur le Chiffre d\'Affaires à l\'Intérieur', 1, 3, 2, '2024', 483105.31, 74726.24, '2025-02-07', 3),
(61, 17, 1, 1, '171 341 10', 'Immatriculation des véhicules', 1, 4, 2, '2024', 301455.67, 168613.64, '2025-02-07', 3),
(62, 18, 1, 1, '270 122 29', 'Vente des imprimés', 1, 4, 2, '2024', 294699.31, 215442.03, '2025-02-07', 3),
(63, 19, 1, 1, '371 370 00', 'Amendes et pénalités', 1, 4, 2, '2024', 377775.40, 238017.00, '2025-02-07', 3),
(64, 20, 1, 1, '171 311 00', 'TAXE SUR LA VALEUR AJOUTEE SUR DECLARATIONS', 2, NULL, 2, '2024', 176344.08, 164310.03, '2025-02-07', 3),
(65, 21, 1, 1, '999 999 04', 'TAXE SUR LA VALEUR AJOUTEE RECOUVREE SUR AMR A', 2, NULL, 2, '2024', 256166.47, 215530.06, '2025-02-07', 3),
(66, 22, 1, 1, '999 999 05', 'IBP DES PETROLIERS PRODUCTEURS', NULL, NULL, 2, '2024', 170456.00, 11117.93, '2025-02-07', 3);

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
-- Structure de la table `dgrad_acte_generateur`
--

CREATE TABLE `dgrad_acte_generateur` (
  `id` int(11) NOT NULL,
  `code_acte` varchar(50) DEFAULT NULL,
  `libelle_acte_generateur` text NOT NULL,
  `categorie_acte_generateur` int(11) DEFAULT NULL,
  `id_service_assiette` int(11) DEFAULT NULL,
  `id_categorie_recette` int(11) DEFAULT NULL,
  `id_type_recette` int(11) DEFAULT NULL,
  `exercice` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgrad_acte_generateur`
--

INSERT INTO `dgrad_acte_generateur` (`id`, `code_acte`, `libelle_acte_generateur`, `categorie_acte_generateur`, `id_service_assiette`, `id_categorie_recette`, `id_type_recette`, `exercice`) VALUES
(1, '27421100', 'Droits de délivrance de laissez-passer tenant lieu de passeport', 1, 1, 1, 1, '2024'),
(2, '27421200', 'Droits de légalisation par la représentation diplomatique ou consulaire (Droits de légalisation simple) ', 1, 1, 1, 1, '2024'),
(3, '27421500', 'Taxe de délivrance de la Note verbale', 1, 1, 1, 1, '2024'),
(4, '27421600', 'Droits de délivrance du Passeport ordinaire', 1, 1, 1, 1, '2024'),
(5, '27421710', 'Droits de délivrance des Visas d\'entrée', 1, 1, 1, 1, '2024'),
(6, '27012220', 'Droits d\'octroi de la Carte consulaire', 2, 1, 1, 1, '2024'),
(7, '27012284', 'Droits sur les actes d\'état civil délivrés à l\'étranger par les ambassades et consulats de la RDC', 2, 1, 1, 1, '2024'),
(8, '17134700', 'Droits de délivrance ou de renouvellement de Permis de port d\'armes d\'autodéfense, de chasse ou de sport ', 3, 2, 1, 1, '2024'),
(9, '17136120', 'Taxe sur l\'autorisation spéciale de fabrication artisanale, d\'importation et/ou de vente d\'armes de chasse ou d\'autodéfense', 4, 2, 1, 1, '2024'),
(10, '27426820', 'Droits de délivrance du Permis d\'exploitation d\'une société de gardiennage', 5, 2, 1, 1, '2024'),
(11, '27426111', 'Redevance annuelle d’exploitation d\'une société de gardiennage', 6, 2, 1, 1, '2024'),
(12, '27426112', 'Redevance annuelle d’exploitation des services de vente de recharge et de maintenance des dispositifs anti incendie', 6, 2, 1, 1, '2024'),
(13, '17182600', '(Produits de vente de carte de résidence pour étranger)', 7, 2, 1, 1, '2024'),
(14, '17182500', 'Droits de vente de la carte d\'identité', 7, 2, 1, 1, '2024'),
(15, '27022321', ' Droits d\'enregistrement d\'un parti ou regroupement politique', 8, 3, 1, 1, '2024'),
(16, '27022360', 'Droits de dépôt des candidatures aux élections ', 8, 3, 1, 1, '2024'),
(17, '37441000', 'Amendes transactionnelles administratives', 9, 3, 1, 1, '2024'),
(18, '17135300', 'Taxe sur autorisation ou renouvellement de l\'autorisation de l\'importation, fabrication, achat, vente, transport ou emmagasinnage des produits explosifs', 10, 4, 2, 1, '2024'),
(19, '17136322', 'Taxe d\'agrément de boutefeu', 10, 4, 2, 1, '2024'),
(20, '17136326', 'Taxe d\'agrément des dépôts d\'explosifs (mine ou carrière)', 10, 4, 2, 1, '2024'),
(21, '17136228', 'Taxe sur autorisation ou renouvellement de l\'autorisation de minage ', 10, 4, 2, 1, '2024'),
(22, '17136223', 'Droits d\'octroi du numéro d\'identification nationale', 11, 5, 1, 1, '2024'),
(23, '27012233', 'Droits de vente  d\'une revue économique', 12, 5, 1, 1, '2024'),
(24, '37444000', 'Amendes transactionnelles pour infraction à la législation sur le prix et le commerce', 13, 5, 1, 1, '2024'),
(25, '37442000', 'Astreintes pour défaut ou retard de transmission des tableaux de synthèse exigés par le système comptable', 14, 6, 1, 1, '2024'),
(26, '37443000', 'Amendes pour non respect de la legislation de change', 14, 6, 1, 1, '2024'),
(27, '27482100', 'Droits sur le recouvrement de débet comptable', 15, 6, 1, 1, '2024'),
(28, '27482300', 'Droits su la récupération des sommes indûment payées par le Trésor public', 15, 6, 1, 1, '2024'),
(29, '27482400', 'Droits sur le remboursement des créances des biens nationalisés', 15, 6, 1, 1, '2024'),
(30, '27012281', 'Droits de vente de Dossier d\'Appel d\'Offres(DAO)', 16, 7, 1, 1, '2024'),
(31, '27012282', 'Droits sur dossier de marché passé par la procedure de gré à gré', 16, 7, 1, 1, '2024'),
(32, '17136381', 'Taxe d\'agrément pour la distribution de l\'aide alimentaire', 17, 8, 1, 1, '2024'),
(33, '27427220', 'Droits d\'enregistrement d\'une association sans but lucratif', 18, 8, 1, 1, '2024'),
(34, '37441000', 'Amendes transactionnelles administratives ', 19, 8, 1, 1, '2024'),
(35, '27012111', 'Droits de vente d\'un bien saisi et confisqué', 20, 9, 3, 1, '2024'),
(36, '27022540', 'Quotité du Trésor Public sur la vente du journal officiel ', 20, 9, 3, 1, '2024'),
(37, '27022570', 'Droits d\'insertion payante dans le journal officiel d\'un document dactylographié ou manuscrit', 20, 9, 3, 1, '2024'),
(38, '27022220', 'Quotité du Trésor Public sur la vente du journal officiel ', 21, 9, 3, 1, '2024'),
(39, '27022331', 'Droits relatifs au fonctionnement d\'une Association Sans But Lucratif', 21, 9, 3, 1, '2024'),
(40, '27425710', ' Droits sur l\'acte relatif à la nationalité congolaise', 21, 9, 3, 1, '2024'),
(41, '27484300', 'Droits pour la censure d\'une chanson ou d\'un spectacle', 22, 9, 3, 1, '2024'),
(42, '27484620', 'Autres recettes judiciaires', 22, 9, 3, 1, '2024'),
(43, '27484600', 'Droits d\'utilisation de la main d\'œuvre pénitentiaire', 22, 9, 3, 1, '2024'),
(44, '37448100', 'Amendes judiciaires', 23, 9, 3, 1, '2024'),
(45, '37448300', 'Amendes transactionnelles Brigade anti-fraude', 23, 9, 3, 1, '2024'),
(46, '17135120', 'Taxe sur l\'autorisation de mise sur le marché des produits pharmaceutiques', 24, 10, 1, 1, '2024'),
(47, '17135250', 'Taxe sur autorisation d\'ouverture d\'un laboratoire pharmaceutique, d\'analyse clinique et bio médical, d\'imagérie médicale et radiodiagnostic ', 24, 10, 1, 1, '2024'),
(48, '17135261', 'Autorisation d\'ouverture d\'une maison de vente en gros des produits pharmaceutiques', 24, 10, 1, 1, '2024'),
(49, '17135262', 'Taxe sur autorisation d’ouverture d’une maison de vente en gros de réactifs de laboratoire', 24, 10, 1, 1, '2024'),
(50, '17135263', 'Taxe sur autorisation d’ouverture d’une maison de vente en gros de dispositifs médicaux', 24, 10, 1, 1, '2024'),
(51, '17135264', 'Taxe sur autorisation d’ouverture d’une maison de vente en gros de tabacs', 24, 10, 1, 1, '2024'),
(52, '17135265', 'Taxe sur autorisation d’ouverture d’une maison de vente en gros de produits cosmétiques et d’hygiène corporelle', 24, 10, 1, 1, '2024'),
(53, '17153140', 'Taxe sur l\'autorisation d\'importation de médicament ou de tabac', 25, 10, 1, 1, '2024'),
(54, '27423400', 'Taxe de contrôle sanitaires aux postes frontaliers des produits d\'origine toxique, toxiques, soporifiques et stupéfiants', 26, 10, 1, 1, '2024'),
(55, '27423300', 'Taxe pour la délivrance de l\'attestation de qualité des produits pharmaceutiques exportés', 26, 10, 1, 1, '2024'),
(56, '27425720', 'Taxe pour la délivrance du certificat international de vaccination', 26, 10, 1, 1, '2024'),
(57, '27425833', 'Taxe sur la desinfection et le contrôle sanitaire de friperie', 26, 10, 1, 1, '2024'),
(58, '27428140', 'Droit d\'enregistrement de professionnel de la santé', 26, 10, 1, 1, '2024'),
(59, '27022222', 'Droits d\'Authentification des titres scolaires des Instituts Techniques Médicaux ', 27, 10, 1, 1, '2024'),
(60, '27425831', 'Taxe de désinsectisation, désinfection et/ou de dératisation de navire, aéronef et train', 27, 10, 1, 1, '2024'),
(61, '27425832', 'Taxe de désinsectisation, désinfection et/ou de dératisation de véhicules d\'occasion à l\'importation et véhicule routier transfrontalier', 27, 10, 1, 1, '2024'),
(62, '37441000', 'Amendes transactionnelles ', 28, 10, 1, 1, '2024'),
(63, '17136334', 'Taxe d\'agrément d’un établissement privé d\'enseignement supérieur  et universitaire', 29, 11, 1, 1, '2024'),
(64, '27022232', 'Droits pour l\'octroi d\'équivalence de diplôme', 30, 11, 1, 1, '2024'),
(65, '27022223', 'Droits d\'authentification d\'un titre académique d\'une université ou d\'un institut supérieur', 30, 11, 1, 1, '2024'),
(66, '27022411', 'Taxe de délivrance d\'une attestation en vue d\'une exonération pour frais d’études', 30, 11, 1, 1, '2024'),
(67, '27022483', 'Taxe de délivrance d\'une attestation d\'exonération pour rapatriement de l\'étranger des effets personnels d’un diplomé', 30, 11, 1, 1, '2024'),
(68, '27022233', 'Droits d\'enterinement ou d\'homologation de titre academique', 30, 11, 1, 1, '2024'),
(69, '37441000', ' Amendes transactionnelles administratifs(quotite du tresor public sur les frais academiques) ', 31, 11, 1, 1, '2024'),
(70, '17136171', 'Taxe sur le permis de recherche dans le domaine scientifique', 32, 12, 1, 1, '2024'),
(71, '17136172', 'Taxe d\'agrément et d\'identification d\'un Centre privé de recherche', 32, 12, 1, 1, '2024'),
(72, '27416210', 'Taxe d\'enregistrement des résultats en matière de recherche scientifique', 33, 12, 1, 1, '2024'),
(73, '27428160', 'Droits d\'octroi ou de renouvellement de la carte de chercheur indépendant', 34, 12, 1, 1, '2024'),
(74, '37441000', 'Amendes transactionnelles administratifs ', 35, 12, 1, 1, '2024'),
(75, '17136315', 'Taxe d\'agrément des bureaux d\'études du secteur des travaux publics et infrastructures', 37, 13, 1, 1, '2024'),
(76, '17136314', 'Taxe d\'agrément des entreprises de construction', 37, 13, 1, 1, '2024'),
(77, '27021100', 'Droits relatifs aux prestations diverses', 38, 13, 1, 1, '2024'),
(78, '27012112', 'Droits de Vente de matériel ou mobilier déclassé', 39, 13, 1, 1, '2024'),
(79, '37441000', 'Amendes transactionnelles administratives', 40, 13, 1, 1, '2024'),
(80, '17136143', 'Autorisation de transformation d\'immeuble à étage', 41, 14, 2, 1, '2024'),
(81, '17136142', 'Taxe sur permis de construire(autorisation de batir) un immeuble à usage non résidentiel et celui résidentiel de plus de deux étages', 41, 14, 2, 1, '2024'),
(82, '17136146', 'Taxe sur permis de construire d\'une station service de plus de trois pompes', 41, 14, 2, 1, '2024'),
(83, '27428223', 'Taxe sur établissement d\'avis urbanistique sur la concession foncière de 50 ares et plus pour la terre urbaine ou de 10 ha et plus pour la terre rurale', 41, 14, 2, 1, '2024'),
(84, '27428231', 'Taxe sur morcellement d\'une parcelle ou d\'une concession foncière de 50 ares et plus pour les terres urbaines ou de 10 ha et plus pour les terres rurales', 41, 14, 2, 1, '2024'),
(85, '27023324', 'Taxe d\'agrément et d\'enregistrement d\'un agent immobilier', 41, 14, 2, 1, '2024'),
(86, '27022322', 'Taxe d\'agrement et d\'enregistrement d\'une agence immobilière', 41, 14, 2, 1, '2024'),
(87, '27022325', 'Taxe d\'agrément et d\'enregistrement d\'un courtier immobilier', 41, 14, 2, 1, '2024'),
(88, '17136311', 'Taxe d\'agrement et d\'enregistrement d\'un bureau d\'études d\'architecture et d\'urbanisme', 41, 14, 2, 1, '2024'),
(89, '27427210', 'Taxe d\'agrement et d\'enregistrement d\'une organisation non gouvernementale/habitat en République Démocratique du Congo', 41, 14, 2, 1, '2024'),
(90, '17136141', 'Taxe sur permis de demolir un immeuble à usage non résidentiel et celui résidentiel de plus de deux étages', 41, 14, 2, 1, '2024'),
(91, '27012212', 'Droits du livret de bail (Baux à loyer)', 42, 14, 2, 1, '2024'),
(92, '27415221', 'Droits de location de maison du domaine privé de l\'État relevant du Pouvoir Central', 43, 14, 2, 1, '2024'),
(93, '27415222', 'Preavis bail non professionnel à usage commercial, industriel et socio-culturel', 43, 14, 2, 1, '2024'),
(94, '37441000', 'Amendes transactionnelles administratives', 44, 14, 2, 1, '2024'),
(95, '17135231', 'Taxe sur l’autorisation d’ouverture d’une officine de vente d’intrants agricoles', 45, 15, 1, 1, '2024'),
(96, '27423121', 'Taxe sur l\'autorisation d\'importation ou d\'exportation  des végétaux, produits végétaux et produits d\'origine végétale', 46, 15, 1, 1, '2024'),
(97, '27423122', 'Taxe sur l\'autorisation d’importation des produits phytosanitaires ou intrants agricoles', 46, 15, 1, 1, '2024'),
(98, '27423123', 'Taxe sur l\'Autorisation d\'exportation des végétaux, des produits végétaux et produits d\'origine végétale', 46, 15, 1, 1, '2024'),
(99, '27423124', 'Taxe sur l’autorisation d’exportation de produits phytosanitaires ou intrants agricoles', 46, 15, 1, 1, '2024'),
(100, '27425110', 'Taxe sur l\'acte de traitement phytosanitaire de végétaux', 47, 15, 1, 1, '2024'),
(101, '27425140', 'Taxe sur l’inspection sanitaire aux postes frontaliers des végétaux, produits végétaux, produits d’origine végétale, produits phytosanitaires ou intrants agricoles ', 47, 15, 1, 1, '2024'),
(102, '27425122', 'Taxe à l\'exportation sur la délivrance d\'un certificat phytosanitaire ou d\'origine', 47, 15, 1, 1, '2024'),
(103, '27423220', 'Taxe sur l’autorisation d’importation ou d’exportation de denrées alimentaires d’origine minérale ', 47, 15, 1, 1, '2024'),
(104, '27022432', 'Taxe sur la mise en quarantaine aux postes frontaliers de végétaux , produits végétaux et produits d\'origine végétale', 48, 15, 1, 1, '2024'),
(105, '27022435', 'Taxe sur la destruction des denrées alimentaires périmées ou avariées aux postes frontaliers', 48, 15, 1, 1, '2024'),
(106, '37441000', 'Amendes transactionnelles administratives', 49, 15, 1, 1, '2024'),
(107, '17134510', 'Taxes relatives aux opérations de vérification et de détention des instruments de mesure à usage industriel et/ou commercial utilisant le mètre comme unité de longueur', 50, 16, 1, 1, '2024'),
(108, '17134520', 'Taxes relatives aux opérations de vérification et de détention des instruments de mesure à usage industriel et/ou commercial utilisant le kilogramme comme unité de masse', 50, 16, 1, 1, '2024'),
(109, '17134530', 'Taxes relatives aux opérations de vérification et de détention des instruments de mesure à usage industriel et/ou commercial utilisant le carat comme unité de masse', 50, 16, 1, 1, '2024'),
(110, '17134540', 'Taxes relatives aux opérations de vérification et de détention des instruments de mesure à usage industriel et/ou commercial utilisant lemôle comme unité de masse', 50, 16, 1, 1, '2024'),
(111, '17134550', 'Taxes relatives aux opérations de vérification et de détention des instruments de mesure à usage industriel et/ou commercial utilisant l\'ampère comme unité de courant électrique', 50, 16, 1, 1, '2024'),
(112, '17134560', 'Taxes relatives aux opérations de vérification et de détention des instruments de mesure à usage industriel et/ou commercial utilisant  unité de température', 50, 16, 1, 1, '2024'),
(113, '17134570', 'Taxes relatives aux opérations de vérification et de détention des instruments de mesure à usage industriel et/ou commercial de conditionnement en masse et en volume', 50, 16, 1, 1, '2024'),
(114, '17134580', 'Autres Taxes relatives aux opérations de vérification et de détention des instruments de mesure à usage industriel et/ou commercial ', 50, 16, 1, 1, '2024'),
(115, '17134610', 'Taxe relative à la normalisation', 50, 16, 1, 1, '2024'),
(116, '27416310', 'Taxe relative à la protection de la propriété industrielle', 50, 16, 1, 1, '2024'),
(117, '27416330', 'Taxe sur le transfert des royalties, le savoir-faire d’entreprise ou know-how et le contrat d\'assistance en matière de propriété industrielle', 50, 16, 1, 1, '2024'),
(118, '27012236', 'Droits sur la vente du recueil des normes', 51, 16, 1, 1, '2024'),
(119, '37441000', 'Amendes transactionnelles administratives', 52, 16, 1, 1, '2024'),
(120, '17136224', 'Taxe sur l\'octroi du numéro import / export (personne physique/personne morale)', 53, 17, 1, 1, '2024'),
(121, '17153240', 'Taxe sur l\'autorisation annuelle d\'exportation des mitrailles(personne physique/personne morale)', 54, 17, 1, 1, '2024'),
(122, '37445000', 'Amendes transactionnelles pour infraction à la législation sur le commerce', 55, 17, 1, 1, '2024'),
(123, '17136131', 'Taxe sur l\'autorisation de traitement ou de transformation des substances autre que des produits d\'exploitation artisanale', 56, 18, 2, 1, '2024'),
(124, '17136312', 'Taxe d\'agrément d’un bureau d’études environnementales, minières, de recherche minière', 56, 18, 2, 1, '2024'),
(125, '17136323', 'Taxe d\'agrément des mandataires en Mines et des carrières', 56, 18, 2, 1, '2024'),
(126, '17136327', 'Taxe d\'agrement des achéteurs de comptoirs d\'achat et de vente des substances minérales de production artisanale', 56, 18, 2, 1, '2024'),
(127, '17136214', 'Redevance pour agrément de comptoirs d\'achat et de vente des substances minérales ', 56, 18, 2, 1, '2024'),
(128, '17136225', 'Taxe sur l\'autorisation d’achat des substances minérales autres que l’or et le diamant (cassiterite)', 56, 18, 2, 1, '2024'),
(129, '17136251', 'Taxe d\'agrément de coopérative minière', 56, 18, 2, 1, '2024'),
(130, '17153220', 'Taxe sur l\'autorisation d’exportation des matières minérales à l\'état brut', 56, 18, 2, 1, '2024'),
(131, '17153210', 'Taxe sur l\'autorisation d’exportation des produits miniers autres que l’or et le diamant', 56, 18, 2, 1, '2024'),
(132, '27415422', 'Quotité de 50% sur les droits superficiaires annuels par carré sur Certificat (permis) d’exploitation ', 57, 18, 2, 1, '2024'),
(133, '27415424', 'Quotité de 50% sur les droits superficiaires annuels par carré sur Certificat (permis) de recherche des rejets', 57, 18, 2, 1, '2024'),
(134, '27415423', 'Quotité 50% sur les droits superficiaires annuels par carré sur Certificat (permis) d’exploitation de petites Mines', 57, 18, 2, 1, '2024'),
(135, '27415421', 'Quotité de 50% sur les droits superficiaires annuels par carré sur Certificat (permis) de recherche ', 57, 18, 2, 1, '2024'),
(136, '27415410', 'Redevance minière', 57, 18, 2, 1, '2024'),
(137, '27415430', 'Redevance pour acheteur supplémentaire', 57, 18, 2, 1, '2024'),
(138, '27415441', 'Taxe pour approbation et Enregistrement d’hypothèque, de cession, d\'amodiation, de contrat d\'option et/ou de transmission ', 57, 18, 2, 1, '2024'),
(139, '27415442', 'Droits d\'enregistrement d\'une drague extractrice de plus 4 pouces', 57, 18, 2, 1, '2024'),
(140, '27415482', 'Quotité de 50% de pas des Portes dont bénéficient les Entreprises du portefeuille de l\'Etat', 57, 18, 2, 1, '2024'),
(141, '27415483', 'Quotité de 50% des royalties ou prime de cession dont bénéficient les entreprises du Portefeuille de l’Etat', 57, 18, 2, 1, '2024'),
(142, '27415484', 'Quotité de 50% de la redevance supplémentaire dont bénéficient les entreprises du Portefeuille de l’Etat', 57, 18, 2, 1, '2024'),
(143, NULL, 'Royalties des Entreprises Minières d\' Exploitation', 57, 18, 2, 1, '2024'),
(144, '27415488', 'Taxe sur l’autorisation de la vente des substances minérales précieuses trouvées occasionnellement', 57, 18, 2, 1, '2024'),
(145, '27021300', 'Taxe rémunératoire de la valeur expertisée des substances précieuses', 58, 18, 2, 1, '2024'),
(146, '27426160', 'Redevance annuelle pour les entités de traitement et/ou de transformation de toutes catégories et tailleries', 59, 18, 2, 1, '2024'),
(147, '27426185', 'Redevance annuelle anticipative pour le laboratoire d\'analyses des produits miniers marchands', 59, 18, 2, 1, '2024'),
(148, '27426189', 'Redevance annuelle anticipative pour le bureau d’études Géologiques', 59, 18, 2, 1, '2024'),
(149, '27428271', 'Frais de dépôt d\'un bureau d\'étude environnementale', 59, 18, 2, 1, '2024'),
(150, '27428272', 'Frais de dépôt bureau d\'études Géologique', 59, 18, 2, 1, '2024'),
(151, '27428274', 'Frais de dépôt pour autorisation d\'exportation des produits marchands', 59, 18, 2, 1, '2024'),
(152, '27011300', 'Quotité de la taxe ad valorem à payer à chaque exportation d\'Or , de Diamant ou des pierres de couleur de production artisanale pour le Trésor Public', 60, 18, 2, 1, '2024'),
(153, '27012241', 'Droits sur la vente des publications du Ministère des Mines', 61, 18, 2, 1, '2024'),
(154, '27012285', 'Droits sur la vente de cahier des charges pour l\'attribution des gisements miniers', 61, 18, 2, 1, '2024'),
(155, '37156300', 'Imposition sur l\'exportation des échantillons destinés aux analyses et essais industriels', 62, 18, 2, 1, '2024'),
(156, '37441000', 'Amendes transactionnelles administratives', 62, 18, 2, 1, '2024'),
(157, '27483100', 'Caution des comptoirs d’or, de diamant, des pierres de couleur et de autres substances autorisées ', 63, 18, 2, 1, '2024'),
(158, '27483400', 'Caution pour bureau d\'études Géologiques', 63, 18, 2, 1, '2024'),
(159, '27418110', 'Taxe d\'agrément de laboratoire d\'analyses des produits miniers marchands', 64, 18, 2, 1, '2024'),
(160, '27418120', 'Taxe d’agrément d’acheteur de tout comptoir de l’or et/ou diamant', 64, 18, 2, 1, '2024'),
(161, '27418140', 'Taxe d’agrément d’entité de traitement et/ou de transformation de toutes catégories (A, B et C) et tailleries ', 64, 18, 2, 1, '2024'),
(162, '17122600', 'Taxe sur plus-value réalisée suite à la cession', 65, 19, 2, 1, '2024'),
(163, '17122610', 'Taxe sur plus-value réalisée suite à la cession d’intérêt des droits à l’exploration', 65, 19, 2, 1, '2024'),
(164, '17122620', 'Taxe sur plus-value réalisée suite à la cession d’intérêt des droits en exploitation', 65, 19, 2, 1, '2024'),
(165, '17136351', 'Agrément pour installation ou construction des installations de stockage et/ou d’entreposage des produits pétroliers', 66, 19, 2, 1, '2024'),
(166, '17136352', 'Agrément de prestataire de services dans le secteur des hydrocarbures', 66, 19, 2, 1, '2024'),
(167, '17136353', 'Agrément pour laboratoire d’analyse de certification des produits pétroliers', 66, 19, 2, 1, '2024'),
(168, '17136600', 'Autorisation d’importation et/ou de transformation de dérivés d’hydrocarbures', 67, 19, 2, 1, '2024'),
(169, '17153110', 'Taxe sur l\'autorisation d\'importation et de commercialisation des produits pétroliers et des Bitumes', 67, 19, 2, 1, '2024'),
(170, '17153120', 'Taxe sur l\'autorisation de Transport et stockage des produits pétroliers et bitumes ', 67, 19, 2, 1, '2024'),
(171, '27415131', 'Redevances superficiaires sur permis d’exploration', 68, 19, 2, 1, '2024'),
(172, '27415132', 'Redevances superficiaires sur le droit d’exploitation', 68, 19, 2, 1, '2024'),
(173, '27415133', 'Redevances superficiaires sur la canalisation des produits pétroliers (Transfrontalier, National, Local et Gazoduc)', 68, 19, 2, 1, '2024'),
(174, '27415134', 'Redevances superficiaires sur le bloc gazier', 68, 19, 2, 1, '2024'),
(175, '27415151', 'Bonus de signature des conventions de canalisation (Transfrontalier, National, Local ou provincial, signature de l’avenant, cession d’intérêt)', 68, 19, 2, 1, '2024'),
(176, '27415141', 'Bonus de signature des contrats de fourniture des produits pétroliers', 68, 19, 2, 1, '2024'),
(177, '27415142', 'Bonus de signature de l’avenant aux contrats de fourniture des produits pétroliers', 68, 19, 2, 1, '2024'),
(178, '27415143', 'Bonus de renouvellement des contrats de fourniture des produits pétroliers', 68, 19, 2, 1, '2024'),
(179, '27415144', 'Bonus de signature des contrats de fourniture des huiles de base', 68, 19, 2, 1, '2024'),
(180, '27415145', 'Bonus de signature de l’avenant aux contrats de fourniture des huiles de base', 68, 19, 2, 1, '2024'),
(181, '27415146', 'Bonus de signature de renouvellement des contrats de fourniture des huiles de base', 68, 19, 2, 1, '2024'),
(182, '27415147', 'Bonus de signature d’un contrat d’implantation (d’une raffinerie, d’une unité Blending et pétrochimique)', 68, 19, 2, 1, '2024'),
(183, '27415148', 'Bonus de signature de l’avenant (d’une raffinerie, d’une unité Blending et pétrochimique)', 68, 19, 2, 1, '2024'),
(184, '27415149', 'Bonus de renouvellement d’un contrat d’implantation (d’une raffinerie, d’une unité Blending et pétrochimique)', 68, 19, 2, 1, '2024'),
(185, '27415151', 'Bonus de signature des conventions de canalisation (Transfrontalier, National, Local ou provincial, signature de l’avenant, cession d’intérêt)', 68, 19, 2, 1, '2024'),
(186, '27415152', 'Bonus sur cession d’intérêt (d’une raffinerie, d’une unité Blending et pétrochimique)', 68, 19, 2, 1, '2024'),
(187, '27415153', 'Bonus de la première production', 68, 19, 2, 1, '2024'),
(188, '27415154', 'Bonus 10 millionième baril', 68, 19, 2, 1, '2024'),
(189, '27415155', 'Bonus 50 millionième baril', 68, 19, 2, 1, '2024'),
(190, '27415161', 'Bonus de signature du droit d’exploration zone fiscale (A, B, C et D)', 68, 19, 2, 1, '2024'),
(191, '27415162', 'Bonus de signature de renouvellement du droit d’exploration zone fiscale (A, B, C et D)', 68, 19, 2, 1, '2024'),
(192, '27415163', 'Bonus de signature du contrat sur les hydrocarbures non conventionnels zone fiscale (A, B, C et D)', 68, 19, 2, 1, '2024'),
(193, '27415164', 'Bonus de signature de renouvellement du contrat sur les hydrocarbures non conventionnels zone fiscale (A, B, C et D)', 68, 19, 2, 1, '2024'),
(194, '27415171', 'Bonus de signature zone fiscale (A, B, C et D)', 68, 19, 2, 1, '2024'),
(195, '27415172', '  Bonus de signature du droit d’exploration zone fiscale (A, B, C et D)', 68, 19, 2, 1, '2024'),
(196, '27415173', 'Bonus de signature de renouvellement du droit d’exploration zone fiscale (A, B, C et D)', 68, 19, 2, 1, '2024'),
(197, '27415174', 'Bonus de signature de renouvellement du droit d’exploitation zone fiscale (A, B, C et D)', 68, 19, 2, 1, '2024'),
(198, '27415175', 'Bonus de signature du contrat gazier ', 68, 19, 2, 1, '2024'),
(199, '27415176', 'Bonus de signature de renouvellement du permis d’exploitation gazière ', 68, 19, 2, 1, '2024'),
(200, '27415177', 'Bonus de signature à l’avenant contrat pétrolier', 68, 19, 2, 1, '2024'),
(201, '27415178', 'Bonus de signature à l’avenant du contrat gazier', 68, 19, 2, 1, '2024'),
(202, '27415181', 'Part du profit-oïl ', 68, 19, 2, 1, '2024'),
(203, '27415182', 'Excess Oil ', 68, 19, 2, 1, '2024'),
(204, '27415183', 'Super profit Oil', 68, 19, 2, 1, '2024'),
(205, '27012251', 'Droits de vente de rapports (annuel, accès aux données (gaz), accès aux données bassins   sédimentaires, accès aux données rendues)', 69, 19, 2, 1, '2024'),
(206, '27012252', 'Droits de vente de cartes géologiques détaillées', 69, 19, 2, 1, '2024'),
(207, '27012277', 'Fiche d’autorisation de torchage', 69, 19, 2, 1, '2024'),
(208, '27424810', 'Taxe sur l’autorisation de construction de la canalisation', 70, 19, 2, 1, '2024'),
(209, '27426871', 'Taxe sur cession des droits en exploration', 71, 19, 2, 1, '2024'),
(210, '27426872', 'Taxe sur cession des droits en exploitation', 71, 19, 2, 1, '2024'),
(211, '37446000', 'Amendes pour non-exécution de programme en matière d’hydrocarbures', 72, 19, 2, 1, '2024'),
(212, '37441000', 'Amendes transactionnelles administratives', 72, 19, 2, 1, '2024'),
(213, '17136411', 'Taxe d’agrément d’un organisme de contrôle de la qualité de l’eau de consommation ', 73, 20, 1, 1, '2024'),
(214, '17136412', 'Taxe d’agrément d’un fournisseur des équipements et appareillages des installations de production, de transport, de distribution et de commercialisation de l’énergie ou de l’eau de consommation', 73, 20, 1, 1, '2024'),
(215, '17136413', 'Taxe d’agrément d’un prestataire de service pour les études, la conception, le conseil, la surveillance et le contrôle, la maintenance, l’extension, la mise en normes, la rénovation sur l’installation de production, de transport, de distribution et de commercialisation de l’électricité ou de l’eau de consommation', 73, 20, 1, 1, '2024'),
(216, '17153130', 'Taxe sur l\'autorisation d\'importation, de commercialisation et de stockage de carbure de calcium', 74, 20, 1, 1, '2024'),
(217, '17153140', 'Taxe sur l\'autorisation d\'importation, de commercialisation et de stockage des gaz autres que les hydrocarbures (gaz comprimés, liquéfiés ou dissous; gaz naturels; gaz rares et gaz frigorifiques non polluants)', 75, 20, 1, 1, '2024'),
(218, '27422312', 'Taxe sur l’octroi du certificat de conformité de tout ou partie des ouvrages et installations de production, de transport, de distribution et commercialisation des eaux naturelles de surface ou souterraines, thermales, des lacs ou du fleuve et de ses affluents', 76, 20, 1, 1, '2024'),
(219, '27422220', 'Taxe sur l\'approbation d\'une étude, d\'un shéma et d\'un plan des infrastructures de production et de transport d\'eau et d\'electricité', 76, 20, 1, 1, '2024'),
(220, '27426510', 'Taxe sur l’octroi ou la modification des concessions et/ou des licences de production de l’énergie électrique pour les projets d’intérêt national', 76, 20, 1, 1, '2024'),
(221, '27426520', 'Taxe sur l’octroi ou la modification des concessions et/ou des licences de transport de l’électricité ou de l’eau naturelle de surface ou souterraine, thermale, des fleuves, des lacs, et de leurs affluents ', 76, 20, 1, 1, '2024'),
(222, '27426530', 'Taxe sur l’octroi ou la modification des concessions et/ou des licences d’exploitation des eaux naturelles de surface ou souterraines, thermales, des fleuves, des lacs et de leurs affluents ', 76, 20, 1, 1, '2024'),
(223, '27426540', 'Taxe sur l’octroi ou la modification des concessions et/ou des licences de commercialisation, d’importation et d’exportation de l’électricité ', 76, 20, 1, 1, '2024'),
(224, '27426550', 'Taxe sur l’octroi ou la modification des concessions et/ou des licences d’implantation des postes de transformation d’électricité', 76, 20, 1, 1, '2024'),
(225, '27426560', 'Taxe sur l’octroi ou la modification des contrats de délégation de gestion d’un ouvrage ou d’une installation de production et/ou de transport appartenant à l’Etat', 76, 20, 1, 1, '2024'),
(226, '27426860', 'Taxe d’homologation d’un permis des personnes physiques et morales, prestataires des services ou des travaux, non établies en République Démocratique du Congo', 76, 20, 1, 1, '2024'),
(227, '27426610', 'Redevance sur l’exercice d’une activité ou le service public de production, de transport, d’importation, d’exportation ou de commercialisation de l\'énergie électrique et d\'eau', 76, 20, 1, 1, '2024'),
(228, '27426621', 'Redevance sur l’utilisation de la ressource énergétique par les infrastructures de production de l\'electricité d’intérêt national', 76, 20, 1, 1, '2024'),
(229, '27426622', 'Redevance sur l’exploitation des eaux naturelles de surface ou souterraines, thermales, des lacs ou du fleuve et de ses affluents', 76, 20, 1, 1, '2024'),
(230, '27426623', 'Redevance sur la consommation de l’électricité par les usagers finaux', 76, 20, 1, 1, '2024'),
(231, '27418211', 'Frais d’instruction des dossiers des requérants, d’arbitrage, de rémunération des services de l’Autorité de Régulation du secteur de l’Electricité (ARE) ', 76, 20, 1, 1, '2024'),
(232, '27418212', 'Frais d’instruction des dossiers des requérants, d’arbitrage, de rémunération des services de l’Autorité de Régulation du secteur de l’eau ', 76, 20, 1, 1, '2024'),
(233, '27418213', 'Frais d’instruction des dossiers des requérants, d’arbitrage, de rémunération des services de l’Autorité de Régulation des services attitrés', 76, 20, 1, 1, '2024'),
(234, '27012241', 'Droit de vente des publications du ministère de l\'Energie et ressources hydrauliques', 76, 20, 1, 1, '2024'),
(235, '27422230', 'Taxe sur l\'accès ou le raccordement aux réseaux de transport de l\'électricité, des eaux naturelles de surface ou souterraines, thermales, des fleuves, des lacs et de leurs affluents, pour immeuble à usage non résidentiel et celui résidentiel de plus de deux étages', 76, 20, 1, 1, '2024'),
(236, '37441000', 'Amendes Transactionnelles ', 77, 20, 1, 1, '2024'),
(237, '17136150', 'Taxe sur autorisation d\'extraction de sable dans le lit mineur  ou majeur d\'une voie navigable et ses abords', 78, 21, 1, 1, '2024'),
(238, '17136216', 'Taxe de delivrance d\'une licence d\'exploitation des services aériens de transport public', 78, 21, 1, 1, '2024'),
(239, '17136226', 'Droits sur la delivrance de la patente de pilote et du role d\'équipage', 78, 21, 1, 1, '2024'),
(240, '17136333', 'Taxe d\'agrément des services publics et professions auxiliaires de transport terrestre (transporteur public routier, transporteur public ferroviaire)', 78, 21, 1, 1, '2024'),
(241, '17136382', 'Taxe d\'agrément d\'un service ou d\'une profession lié(e) à l\'aéronautique ', 78, 21, 1, 1, '2024'),
(242, '17134860', 'Taxe d\'agrément et d\'autorisation de construction d\'un bateau ou d\'une embarcation', 78, 21, 1, 1, '2024'),
(243, '17134870', 'Taxe sur l\'autorisation d\'installation d\'une balise d\'approche sur une piste privée d\'aviation ', 78, 21, 1, 1, '2024'),
(244, '17134880', 'Taxe sur l\'autorisation d’exécuter un ouvrage d\'art d\'accostage ou d\'opérer une fouille', 78, 21, 1, 1, '2024'),
(245, '17136261', 'Taxe d\'homologation d\'un port ou beach', 78, 21, 1, 1, '2024'),
(246, '17151130', 'Taxe sur l\'autorisation  d’importation d’un aéronef', 79, 21, 1, 1, '2024'),
(247, '17182210', 'Droits  de circulation au-dessus du territoire national aux aéronefs immatriculés à l\'étranger', 80, 21, 1, 1, '2024'),
(248, '17182300', 'Taxe sur l\'autorisation de sortie d\'aéronefs, immatriculés  à l\'étranger, basés sur le territoire national', 80, 21, 1, 1, '2024'),
(249, '27422120', 'Droit de delivrance d\'un permis de conduire national et international ou son duplicata', 81, 21, 1, 1, '2024'),
(250, '27422130', 'Taxe sur le permis de naviguer ou son duplicata', 81, 21, 1, 1, '2024'),
(251, '27422110', 'Taxe sur permis de sortie des bateaux et  ou son renouvellement  ', 81, 21, 1, 1, '2024'),
(252, '27422240', 'Taxe sur délivrance d\'une lettre de mer ou son renouvellement', 81, 21, 1, 1, '2024'),
(253, '27422400', 'Taxe d’octroi d\'une fréquence aéronautique', 81, 21, 1, 1, '2024'),
(254, '27424410', 'Droits du livret matricule et du carnet de paie ou de son duplicata', 81, 21, 1, 1, '2024'),
(255, '27424420', 'Droit de visite annuelle d\'un port ou d\'un beach', 81, 21, 1, 1, '2024'),
(256, '27425231', 'Droit de contrôle technique des aéronefs', 81, 21, 1, 1, '2024'),
(257, '27425241', 'Droits de jaugeage d\'un bateau ', 81, 21, 1, 1, '2024'),
(258, '27425210', 'Redevance de surveillance des véhicules de transport routier ', 81, 21, 1, 1, '2024'),
(259, '27425220', 'Frais de surveillance des véhicules de transport ferroviaire', 81, 21, 1, 1, '2024'),
(260, '27426310', 'Taxe sur la délivrance de certificat de navigabilité ou son duplicata', 81, 21, 1, 1, '2024'),
(261, '27426840', 'Taxe d\'homologation des installations pétrolières d\'aviation ', 81, 21, 1, 1, '2024'),
(262, '27426320', 'Taxe de délivrance du certificat de radiation d\'un aéronef', 81, 21, 1, 1, '2024'),
(263, '27426410', 'Droits sur la delivrance des titres de sécurité des navires et bateaux', 81, 21, 1, 1, '2024'),
(264, '27428132', 'Droits d\'inscription d\'un aéronef au matricule aéronautique de la RDC', 81, 21, 1, 1, '2024'),
(265, '27428131', 'Droits de delivrance ou validation d\'une licence ou autres documents liés à l\'aéronautique civile', 81, 21, 1, 1, '2024'),
(266, '27428211', 'Droits fixes de police fluviale et lacustre pour le transport des marchandises et des personnes', 81, 21, 1, 1, '2024'),
(267, '27428212', 'Droit fixe de police maritime', 81, 21, 1, 1, '2024'),
(268, '27022350', 'Droit d\'admission aux examens en vue d\'obtention d ’une licence ou d\'un certificat pour certains métiers de l’aéronautique.', 82, 21, 1, 1, '2024'),
(269, '27022323', 'Droit d\'enregistrement d\'un aéronef étranger basé en R.D.C.', 82, 21, 1, 1, '2024'),
(270, '37441000', 'Amendes transactionnelles', 83, 21, 1, 1, '2024'),
(271, '17133100', 'Taxe de numérotation', 84, 22, 1, 1, '2024'),
(272, '17133200', 'Taxe de régulation des télécommunications', 84, 22, 1, 1, '2024'),
(273, '37441000', 'Amendes transactionnelles', 85, 22, 1, 1, '2024'),
(274, '17133300', 'Droits sur la déclaration d\'autorisation d\'exploitation d\'un réseau indépendant d\'Internet (Intranet)', 86, 23, 1, 1, '2024'),
(275, '17136234', 'Taxe sur l\'autorisation d\'exploitation, de commercialisation des matériels spécifiques de la poste', 86, 23, 1, 1, '2024'),
(276, '17134610', 'Taxe sur l\'autorisation d\'exploitation des concessions des cabines publiques ou télé centre', 86, 23, 1, 1, '2024'),
(277, '17136160', 'Taxe d\'homologation des équipements de télécommunication à fabriquer, importer ou commercialiser sur le territoire national', 86, 23, 1, 1, '2024'),
(278, '17134651', 'Taxe sur l\'autorisation de détention, d\'installation et d\'exploitation des stations radio électriques privées de toute catégorie', 86, 23, 1, 1, '2024'),
(279, '17134652', 'Taxe sur l’autorisation de détention, d\'installation et d\'exploitation des faisceaux hertziens', 86, 23, 1, 1, '2024'),
(280, '17134653', 'Taxe sur l’autorisation de détention, d’installation et d’exploitation de stations terriennes de toute catégorie ou terminal satellitaire ', 86, 23, 1, 1, '2024'),
(281, '17134620', 'Taxe sur l\'autorisation d\'exploitation des chaînes de radiodiffusion sonore et télévisuelle commerciale', 86, 23, 1, 1, '2024'),
(282, '17134630', 'Taxe sur l\'autorisation d\'exploitation de cabine radiophonique (phonie à usage public)', 86, 23, 1, 1, '2024'),
(283, '17134640', 'Taxe sur l’autorisation d’exploitation de service support', 86, 23, 1, 1, '2024'),
(284, '17136231', 'Taxe sur l\'autorisation d\'exploitation du service courrier professionnel, amateur ou social', 86, 23, 1, 1, '2024'),
(285, '17136232', 'Taxe sur l’autorisation d’exploitation de messagerie financière ou transfert des fonds', 86, 23, 1, 1, '2024'),
(286, '17136233', 'Taxe sur l’autorisation d’exploitation de courriers et transactions électroniques ou activité promotionnelle à valeur ajoutée en ligne ', 86, 23, 1, 1, '2024'),
(287, '17134654', 'Taxe sur l\'autorisation de detention d\'installation et d\'exploitation du système trunking ou paging', 86, 23, 1, 1, '2024'),
(288, '17134660', 'Taxe sur l’autorisation d’installation et d’exploitation d’un réseau VSAT  ', 86, 23, 1, 1, '2024'),
(289, '17181220', 'Taxe sur l\'autorisation d\'installation, d\'établissement , de fourniture et/ou d\'exploitation d\'un reseau à fibre optique ou d\'une autre infrastricture à haut débit', 86, 23, 1, 1, '2024'),
(290, '17181210', 'Taxe sur l’autorisation d’implémentation d’une variante de génération technologique', 86, 23, 1, 1, '2024'),
(291, '27415510', 'Taxe sur la concession ou le contrat d\'exploitation de service public des télécommunications (Licence) ou son renouvellement', 87, 23, 1, 1, '2024'),
(292, '27415520', 'Taxe sur l\'autorisation de concession de gestion du country code (cc 243)', 87, 23, 1, 1, '2024'),
(293, '27415530', 'Taxe sur l\'autorisation de concession de gestion de nom du domaine (.cd)', 87, 23, 1, 1, '2024'),
(294, '27415540', 'Taxe sur l\'autorisation de fourniture des services  publics ou accès Internet ', 87, 23, 1, 1, '2024'),
(295, '27415550', 'Taxe sur l\'autorisation de télédistribution des signaux de radio et/ou de télévision par cable, onde radio ou satellite ', 87, 23, 1, 1, '2024'),
(296, '27021210', 'Redevance annuelle sur la concession et/ou contrat d’exploitation de Téléphonie (chiffre d’affaires et fréquences)', 88, 23, 1, 1, '2024'),
(297, '27021220', 'Redevance annuelle sur la concession et/ou contrat d’exploitation d’Internet (chiffre d’affaires et fréquences)', 88, 23, 1, 1, '2024'),
(298, '27021230', 'Redevance annuelle sur la concession et/ou contrat d’exploitation de télédistribution (chiffre d’affaires et fréquences)', 88, 23, 1, 1, '2024'),
(299, '27021240', 'Redevance annuelle sur la concession et/ou contrat d’exploitation de gestion du country code (au prorata du traffic écoulé)', 88, 23, 1, 1, '2024'),
(300, '27021250', 'Redevance annuelle sur la concession et/ou contrat d’exploitation de gestion de nom du domaine (au prorata des enregistrements)', 88, 23, 1, 1, '2024'),
(301, '27422700', 'Droits sur la déclaration de distribution des signaux audio et/ou vidéo dans un hôtel ou un bâtiment d\'utilité publique', 89, 23, 1, 1, '2024'),
(302, '27422810', 'Droits sur la déclaration semestrielle d\'équipements de télécommunications établis à bord des navires ou bateaux étrangers accostés dans les ports nationaux ou en rade dans les eaux territoriales nationales', 89, 23, 1, 1, '2024'),
(303, '27425600', 'Taxe de renouvelement ou de modification d\'un titre obtenu de télécommunications ou de service postal', 89, 23, 1, 1, '2024'),
(304, '27426121', 'Redevance annuelle sur l\'exploitation du service courrier professionnel, amateur ou social', 89, 23, 1, 1, '2024'),
(305, '27426122', 'Redevance annuelle sur l\'exploitation du système TRUNKING', 89, 23, 1, 1, '2024'),
(306, '27426123', 'Redevance annuelle sur l’exploitation de service support', 89, 23, 1, 1, '2024'),
(307, '27426124', 'Redevance annuelle sur l\'exploitation de messagerie financière ou transfert de fonds', 89, 23, 1, 1, '2024'),
(308, '27426125', 'Redevance annuelle sur l’exploitation de courriers et transactions électroniques ou activité promotionnelle à valeur ajoutée en ligne', 89, 23, 1, 1, '2024'),
(309, '27426126', 'Redevance annuelle sur l’exploitation de commercialisation de matériels spécifiques à la poste', 89, 23, 1, 1, '2024'),
(310, '27426127', 'Redevance annuelle sur la collecte ou distribution des colis ', 89, 23, 1, 1, '2024'),
(311, '27426151', 'Redevance annuelle sur l’implémentation d’une variante de génération technologique ', 89, 23, 1, 1, '2024'),
(312, '27426152', 'Redevance annuelle sur l’installation, établissement, fourniture et/ou exploitation d’un réseau à fibre optique ou autre infrastructure à haut débit ', 89, 23, 1, 1, '2024'),
(313, '27426153', 'Redevance annuelle sur l’installation et exploitation d’un réseau VSAT', 89, 23, 1, 1, '2024'),
(314, '27426181', 'Redevance annuelle d\'exploitation de concession des cabines publiques ou télécentres', 89, 23, 1, 1, '2024'),
(315, '27426183', 'Redevance annuelle sur la detention, l\'installation et l\'exploitation des stations terriennes de toute catégorie ou terminal stellitaire', 89, 23, 1, 1, '2024'),
(316, '27426184', 'Redevance annuelle sur la detention, l\'installation et l\'exploitation des faisceaux hertziens', 89, 23, 1, 1, '2024'),
(317, '27426182', 'Redevance annuelle sur la detention, l\'installation et l\'exploitation des radios électriques privées de toute catégorie', 89, 23, 1, 1, '2024'),
(318, '27426131', 'Redevance annuelle sur la déclaration de distribution des signaux audio et/ou vidéo dans un hôtel ou un bâtiment d\'utilité publique', 89, 23, 1, 1, '2024'),
(319, '27426132', 'Redevance annuelle sur la déclaration d’exploitation d’un réseau indépendant (intranet, téléphonie et multimédia interne)', 89, 23, 1, 1, '2024'),
(320, '27426133', 'Redevance annuelle sur la déclaration de detention, intallation et exploitation d\'un commutateur (PABX, serveur), service des contenus et applications mobiles, agrégation et intégration des applications', 89, 23, 1, 1, '2024'),
(321, '27426186', 'Redevance annuelle sur l\'exploitation des chaînes de radiodiffusion sonore ou télévisuelle commerciale', 89, 23, 1, 1, '2024'),
(322, '27422850', 'Droits sur la déclaration de détention, d\'installation et d\'exploitation d\'un commutateur (PABX,serveurs), service des contenus et application mobiles, agrégation et intégration des applications', 89, 23, 1, 1, '2024'),
(323, '27428111', 'Redevance annuelle sur la déclaration d\'agrement de fabricant, monteur de réseau, d\'équipements de télécommunications, de fourreaux de conduite allégées, enrobées et aériennes, de pylônes ou mâts d\'antennes', 89, 23, 1, 1, '2024'),
(324, '27428115', 'Droit sur la déclaration d\'agrement des vendeur, installateur, dépanneur d\'équipements et matériels de télécommunications', 89, 23, 1, 1, '2024'),
(325, '27428114', 'Droit sur la déclaration d\'agrement de fabricant, monteur de réseau, d\'équipements de télécommunications, de fourreaux de conduite allégées, enrobées et aériennes, de pylônes ou mâts d\'antennes', 89, 23, 1, 1, '2024'),
(326, '27428112', 'Redevance annuelle sur la déclaration d\'agrement de vendeur, installateur, dépanneur d\'équipements et matériels de télécommunications', 89, 23, 1, 1, '2024'),
(327, '27428113', 'Redevance annuelle sur la déclaration d\'installateur d\'équipements mutualisés et/ou de gestion et de partage d\'infrastructures des télécommunications', 89, 23, 1, 1, '2024'),
(328, '27428117', 'Déclaration d\'agrément d\'importateur, d\'exportateur d\'équipement et matériels de télécomunications', 89, 23, 1, 1, '2024'),
(329, '27428116', 'Droits sur la déclaration d’agrément d’installateur d’équipements mutualisés et/ou de gestion et de partage d’infrastructures de télécommunications', 89, 23, 1, 1, '2024'),
(330, '27428118', 'Redevance sur la déclaration d\'importateur, d\'exportateur d\'équipement et matériels de télécomunications', 89, 23, 1, 1, '2024'),
(331, '27022280', 'Droit de délivrance du duplicata de titre obtenu de télécommunication ou de service postal', 90, 23, 1, 1, '2024'),
(332, '37441000', 'Amendes Transactionnelles ', 91, 23, 1, 1, '2024'),
(333, '17133810', 'Droits sur la diffusion de la publicité dans la presse', 92, 24, 1, 1, '2024'),
(334, '17135282', 'Droit sur la déclaration préalable d\'ouverture d\'une maison de presse écrite (journal, texte périodique ou agence)', 92, 24, 1, 1, '2024'),
(335, '17136321', 'Droit d\'accréditation d\'un journaliste étranger', 92, 24, 1, 1, '2024'),
(336, '17136271', 'Droit sur la déclaration préalable d\'exploitation d\'une station privée de radio ou d\'une chaine de télévision pour une radio ou une télévision à caractère non commercial(confessionnel, associatif ou communautaire)', 92, 24, 1, 1, '2024'),
(337, '17136272', 'Droit sur la déclaration préalable d\'exploitation d\'une station privée de radio ou d\'une chaine de télévision pour une radio ou une télévision à caractère commercial', 92, 24, 1, 1, '2024'),
(338, '27484420', 'Redevance de contrôle de conformité d\'une radio ou télévision privée', 93, 24, 1, 1, '2024'),
(339, '37441000', 'Amendes transactionnelles', 94, 24, 1, 1, '2024'),
(340, '17122211', 'Nouveau certificat ', 96, 25, 2, 1, '2024'),
(341, '17122212', 'Remplacement d’un ancien certificat', 96, 25, 2, 1, '2024'),
(342, '17122220', 'Page supplémentaire', 96, 25, 2, 1, '2024'),
(343, '17122231', 'Changement dénomination', 96, 25, 2, 1, '2024'),
(344, '17122240', 'Insertion d’une mention substantielle', 96, 25, 2, 1, '2024'),
(345, '17122213', 'Annulation d’un certificat d’enregistrement', 96, 25, 2, 1, '2024'),
(346, '17122310', 'Mutation ', 97, 25, 2, 1, '2024'),
(347, '17122320', 'Inscription hypothécaire sur concession ordinaire', 97, 25, 2, 1, '2024'),
(348, '17122330', 'Réinscription hypothécaire sur concession ordinaire', 97, 25, 2, 1, '2024'),
(349, '17122340', 'Radiation hypothécaire sur concession ordinaire', 97, 25, 2, 1, '2024'),
(350, '17122350', 'Contrat de location de plus de 9 ans', 97, 25, 2, 1, '2024'),
(351, '17122410', 'Annotation', 98, 25, 2, 1, '2024'),
(352, '17122420', 'Cession de bail', 98, 25, 2, 1, '2024'),
(353, '17122430', 'Transfert des contrats de location', 98, 25, 2, 1, '2024'),
(354, '27415210', 'Redevances sur concession ordinaire (par les étrangers, les personnes morales et physiques ainsi que les associations détenteurs d\'un titre foncier ou immobilier', 99, 25, 2, 1, '2024'),
(355, '27428221', 'Frais de mesurage et de bornage de parcelle', 100, 25, 2, 1, '2024'),
(356, NULL, 'Parcelle de 4400 m ou plus de périmètre', 100, 25, 2, 1, '2024'),
(357, NULL, 'Parcelle de moins de 4400 m de périmètre', 100, 25, 2, 1, '2024'),
(358, NULL, 'Parcelle à usage agricole', 100, 25, 2, 1, '2024'),
(359, NULL, 'Placement des bornes', 100, 25, 2, 1, '2024'),
(360, NULL, 'Reconstitution des limites', 100, 25, 2, 1, '2024'),
(361, '27428222', 'Frais d\'enqûete et de constat en matières foncières', 100, 25, 2, 1, '2024'),
(362, NULL, 'Journée perte de temps', 100, 25, 2, 1, '2024'),
(363, NULL, 'Journée indivisible', 100, 25, 2, 1, '2024'),
(364, NULL, 'P.V. d’enquête', 100, 25, 2, 1, '2024'),
(365, NULL, 'P.V. de mesurage et de bornage', 100, 25, 2, 1, '2024'),
(366, NULL, 'P.V. d’audition en cas de conflit', 100, 25, 2, 1, '2024'),
(367, NULL, 'P.V. de constat de lieu', 100, 25, 2, 1, '2024'),
(368, NULL, 'P.V. de constat de mise en valeur', 100, 25, 2, 1, '2024'),
(369, '27428240', 'Droits de consultation registres fonciers, immobiliers et cadastraux', 100, 25, 2, 1, '2024'),
(370, '27428250', 'Droits d’ établissement des contrats en matière foncière  (concession ordinaire)', 100, 25, 2, 1, '2024'),
(371, '27012114', 'Droits sur la vente des biens privés, immobiliers, abandonnés (sans maîtres)', 101, 25, 2, 1, '2024'),
(372, '37441000', ' Amendes Transactionnelles ', 102, 25, 2, 1, '2024'),
(373, '17134410', 'Taxe sur le certificat de légitime détention des produits de la chasse (animaux totalement ou partiellement protégés, autres animaux, trophées)', 103, 26, 2, 1, '2024'),
(374, '17136213', 'Taxe sur le permis d\'exploitation des produits et sous -produits de la faune sauvage (capture, abattage, importation, exportation ou réexportation) et de la flore sauvage (recolte, exportation d\'espèces végétales ligneuses et non ligneuses grumes et bois sciés)', 103, 26, 2, 1, '2024'),
(375, '27415311', 'Redevance sur la superficie concédée', 104, 26, 2, 1, '2024'),
(376, '27415330', 'Quotité du Trésor public sur la taxe de déboisement', 104, 26, 2, 1, '2024'),
(377, '27415340', 'Permis de coupe de bois industrielle', 104, 26, 2, 1, '2024'),
(378, '27415360', 'Quotité du Trésor public sur le droit d\'exploitation ou la vente du crédit carbone', 104, 26, 2, 1, '2024'),
(379, '27415313', 'Taxe d\'inventaire et de reconnaissance forestière', 105, 26, 2, 1, '2024'),
(380, '27427240', 'Taxe d\'homologation d\'une O.N.G nationale ou Internationale', 105, 26, 2, 1, '2024'),
(381, '17135150', 'Taxe sur la délivrance d\'une autorisations d\'achat, de vente ou d\'exportation de bois d\'œuvre', 105, 26, 2, 1, '2024'),
(382, '27424120', 'Taxe rémunératoire annuelle ', 105, 26, 2, 1, '2024'),
(383, '27424110', 'Taxe d\'implantation ', 105, 26, 2, 1, '2024'),
(384, '27424130', 'Taxe de pollution', 105, 26, 2, 1, '2024'),
(385, '27425121', 'Taxe à l\'exportation sur delivrance d\'un certificat phytosanitaire ', 105, 26, 2, 1, '2024'),
(386, '27425122', 'Taxe à l\'exportation sur délivrance d\'un certificat d\'origine', 105, 26, 2, 1, '2024'),
(387, '37448410', 'Amendes transactionnelles en matière de chasse', 106, 26, 2, 1, '2024'),
(388, '37448420', 'Amendes transactionnelles en matière des installations classées', 106, 26, 2, 1, '2024'),
(389, '37448430', 'Amendes transactionnelles en matière de législation forestière', 106, 26, 2, 1, '2024'),
(390, '17133841', 'Redevance sur les nuitées (hôtel à partir de 2 étoiles)', 108, 27, 1, 1, '2024'),
(391, '17133842', 'Redevance sur les repas et boissons (restaurant à partir de 2 fourchettes)', 108, 27, 1, 1, '2024'),
(392, '17133710', 'Redevance sur les billets d’avion du réseau domestique', 108, 27, 1, 1, '2024'),
(393, '17133720', 'Redevance sur les billets d\'avion du réseau international', 108, 27, 1, 1, '2024'),
(394, '17133740', 'Redevance sur les voyages ferroviaires Dépassant les frontières d\'une province', 108, 27, 1, 1, '2024');
INSERT INTO `dgrad_acte_generateur` (`id`, `code_acte`, `libelle_acte_generateur`, `categorie_acte_generateur`, `id_service_assiette`, `id_categorie_recette`, `id_type_recette`, `exercice`) VALUES
(395, '17133730', 'Redevance sur les billets d’un voyage lacustre ou maritime dépassant les frontières d’une province', 108, 27, 1, 1, '2024'),
(396, '17136241', 'Taxe sur la licence d\'exploitation pour hôtel (à partir de deux étoiles)', 109, 27, 1, 1, '2024'),
(397, '17136242', 'Taxe sur la licence d\'exploitation pour restaurant (à partir de deux fourchettes) ', 109, 27, 1, 1, '2024'),
(398, '17136243', 'Taxe sur la licence d\'exploitation pour agence de voyage ou similaire (catégorie A et B)', 109, 27, 1, 1, '2024'),
(399, '17136244', 'Taxe sur le permis d\'exploitation d\'un site touristique appartenant à l\'Etat', 109, 27, 1, 1, '2024'),
(400, '27426230', 'Taxe d’homologation pour hôtel (à partir de 2 étoiles), restaurant (à partir de 2 fourchettes) et agence de voyage  et similaire (catégorie A et B) ', 109, 27, 1, 1, '2024'),
(401, '27426221', 'Taxe d\'agrément d\'un hôtel ', 109, 27, 1, 1, '2024'),
(402, '27426222', 'Taxe d\'agrément d\'un restaurant', 109, 27, 1, 1, '2024'),
(403, '27426223', 'Taxe d\'agrément d\'une agence de voyage', 109, 27, 1, 1, '2024'),
(404, '27426210', 'Taxe d\'agrément d\'une association touristique', 109, 27, 1, 1, '2024'),
(405, '37441000', 'Amendes Transactionnelles ', 110, 27, 1, 1, '2024'),
(406, '17136211', 'Taxe sur l\'autorisation annuelle d’exercer une activité cinématographique', 112, 28, 1, 1, '2024'),
(407, '17153230', 'Taxe sur autorisation d’exportation d\'oeuvre d’art et d’artisanat', 113, 28, 1, 1, '2024'),
(408, '27416111', 'Taxe sur la propriété intellectuelle', 114, 28, 1, 1, '2024'),
(409, '27416112', 'Taxe sur les revenus des œuvres des artistes', 114, 28, 1, 1, '2024'),
(410, '27422831', 'Taxe sur la délivrance de la carte nationale pour artiste, écrivain ou autre professionnel de la culture et des arts', 115, 28, 1, 1, '2024'),
(411, '27022512', 'Droits sur le produit de vente de billet, de reservantion ou de frais de participation dans une manifestation culturelle à caractère national ou international', 116, 28, 1, 1, '2024'),
(412, '37441000', 'Amendes transactionnelles', 117, 28, 1, 1, '2024'),
(413, '17113810', 'Taxe ad valorem sur les gains des joueurs des jeux de hasard, loterie, concours de pronostic ou pari et activités similaires, par tous les (en dur, à travers les voies de télécommunication et des technologies de l\'information et de la communication)', 118, 29, 1, 1, '2024'),
(414, '17133500', 'Taxe sur la publicité dans un stade national', 119, 29, 1, 1, '2024'),
(415, '17133410', 'Droits sur le transfert international d\'athlète', 119, 29, 1, 1, '2024'),
(416, '17136215', 'Taxe sur l’autorisation d’exploitation d’une entreprise de jeux du hasard ou d\'une loterie', 120, 29, 1, 1, '2024'),
(417, '17136332', 'Taxe d\'agrément d\'un établissement de loisir', 120, 29, 1, 1, '2024'),
(418, '17134830', 'Taxe sur le droit de retransmission radio télévisée d\'une rencontre sportive à caracère national ou international', 121, 29, 1, 1, '2024'),
(419, '27415221', 'Droits de location d\'un complexe sportif (aire de jeux, tribune, local et autres espaces)', 122, 29, 1, 1, '2024'),
(420, '27022511', 'Quotité du Trésor Public sur la vente de billets d\'accès à une manifestation de loisir dans une installation sportive à caratère national', 123, 29, 1, 1, '2024'),
(421, '27022513', 'Quotité du trésor public sur le produit d\'une rencontre sportive (nationale ou internationale )', 123, 29, 1, 1, '2024'),
(422, '37441000', 'Amendes Transactionnelles ', 124, 29, 1, 1, '2024'),
(423, '17182400', 'Droits d\'octroi de la carte de travail pour étrangers', 125, 30, 1, 1, '2024'),
(424, '27012181', 'Droits sur la vente d\'une revue de travail et de la prevoyance sociale', 126, 30, 1, 1, '2024'),
(425, '27427230', 'Droits d\'enregistrement d\'une organisation syndicale', 126, 30, 1, 1, '2024'),
(426, '27021122', 'Agrément ou autorisation d\'un service de santé et sécurité au travail à titre préventif ou médicale', 126, 30, 1, 1, '2024'),
(427, '27021121', 'Visa d\'inspection du travail ', 126, 30, 1, 1, '2024'),
(428, '27427232', 'Droit d’enregistrement d\'une mutuelle', 126, 30, 1, 1, '2024'),
(429, '37441000', 'Amendes transactionnelles ', 127, 30, 1, 1, '2024'),
(430, '37441000', ' Amendes Transactionnelles administratives', 128, 31, 1, 1, '2024'),
(431, '17136332', 'Taxe d\'agrément d\'un service d\'action sociale ou d\'un centre privé à vocation sociale', 129, 32, 1, 1, '2024'),
(432, '17134210', 'Taxe pour l\'octroi de Permis de pêche (industriel, semi-industriel)', 130, 33, 1, 1, '2024'),
(433, '17134220', 'Taxe sur le permis d\'exploitation du matériel de pêche placé dans les engins et embarcations (ligne en main, de traine, palangre, filet, senne,chalut,…)', 130, 33, 1, 1, '2024'),
(434, '17135232', 'Taxe sur l’autorisation d’ouverture d’une officine de vente de produits(médicaments) vétérinaires,  d’élevage ou de pêche ou de produits vétérinaires', 130, 33, 1, 1, '2024'),
(435, '17136325', 'Taxe sur l\'agrément de professionnel privé en santé animale pour exercer une mission de service officiel (nationaux et étrangers)', 130, 33, 1, 1, '2024'),
(436, '27423131', 'Taxe sur l\'autorisation d\'importation d\'animaux, de produits d\'origine animale ou halieutique (alimentaire ou non alimentaire)', 131, 33, 1, 1, '2024'),
(437, '27423132', 'Taxe sur l’autorisation d’exportation  d’animaux, de produits d’origine animale ou halieutique (alimentaire ou non alimentaire)', 131, 33, 1, 1, '2024'),
(438, '27423142', 'Taxe sur l\'autorisation d\'exportation de produits vétérinaire et d\'intrats d\'élevage ou de pèche', 131, 33, 1, 1, '2024'),
(439, '27425131', 'Taxe sur l’inspection sanitaire aux postes frontaliers d’ animaux, produits d’origine animale ou halieutique (alimentaire ou non alimentaire)', 132, 33, 1, 1, '2024'),
(440, '27425132', 'Taxe sur l’inspection sanitaire aux postes frontaliers de boissons (alcoolique ou non alcoolique)', 132, 33, 1, 1, '2024'),
(441, '27425133', 'Taxe sur l’inspection sanitaire aux postes frontaliers de denrées alimentaires d’origine minérale', 132, 33, 1, 1, '2024'),
(442, '27425134', 'Taxe sur l’inspection sanitaire aux postes frontaliers de produits vétérinaires, d’intrants d’élevage ou de pèche', 132, 33, 1, 1, '2024'),
(443, '27022433', 'Taxe sur la mise en quarantaine aux postes frontaliers des animaux', 133, 33, 1, 1, '2024'),
(444, '27022435', 'Taxe sur la destruction des denrées alimentaires périmées ou avariées aux postes frontaliers', 133, 33, 1, 1, '2024'),
(445, '37441000', 'Amendes transactionnelles administratives', 134, 33, 1, 1, '2024'),
(446, '27022450', 'Taxes de gardiennage par la Police Nationale Congolaise (personne physique et morale)', 136, 34, 3, 1, '2024'),
(447, '27022481', 'Droits de délivrance d\'une attestation de perte de pièces de bord', 136, 34, 3, 1, '2024'),
(448, '27022270', 'Droits d\'octroi du casier judiciaire ', 136, 34, 3, 1, '2024'),
(449, '37447200', 'Amendes transactionnelles de police territoriale', 137, 34, 3, 1, '2024'),
(450, '37447100', 'Amendes transactionnelles de police spéciale de roulage', 137, 34, 3, 1, '2024'),
(451, '37447300', 'Amendes transactionnelles de police judiciare', 137, 34, 3, 1, '2024'),
(452, '27421400', 'Droits de délivances de laissez - passer individuel', 138, 35, 1, 1, '2024'),
(453, '27421720', 'Droits de délivrance de visa d\'établissement', 138, 35, 1, 1, '2024'),
(454, '27421721', 'Droits de délivrance de visa d\'établissement spécial, permanent, ordinaire ou de travail', 138, 35, 1, 1, '2024'),
(455, '27421722', 'Droits de délivrance du visa d\'établissement de travail spécifique', 138, 35, 1, 1, '2024'),
(456, '27421723', 'Droits de transposition visa d\'établissement ', 138, 35, 1, 1, '2024'),
(457, '27421730', 'Droits de délivrance de visa de voyage', 138, 35, 1, 1, '2024'),
(458, '27421731', 'Droits de délivrance de visa de voyage ou de transit', 138, 35, 1, 1, '2024'),
(459, '27421724', 'Droits de délivrance de visa pour mineur ou étudiant', 138, 35, 1, 1, '2024'),
(460, '27421733', 'Droits de délivrance de visa de sortie ou de retour  (un ou plusieurs voyages)', 138, 35, 1, 1, '2024'),
(461, '27421732', 'Droits de delivrance de visa de portuaire ou aéroportuaire', 138, 35, 1, 1, '2024'),
(462, '27421740', 'Frais de prorogation de séjour des étrangers porteurs de laissez-passer des pays limitrophes', 138, 35, 1, 1, '2024'),
(463, '27421800', 'Droits de validation de prise en charge', 138, 35, 1, 1, '2024'),
(464, '37441000', 'Amendes Transactionnelles administratives', 139, 35, 1, 1, '2024'),
(465, '17181100', 'Droits proportionnels sur société anonyme', 140, 36, 3, 1, '2024'),
(466, '27428260', 'Frais de justice', 141, 36, 3, 1, '2024'),
(467, '27022310', 'Redevance d\'inscription au nouveau registre de commerce et crédit mobilier RCCM', 142, 36, 3, 1, '2024'),
(468, '37441000', 'Amendes transactionnelles ', 143, 36, 3, 1, '2024'),
(469, '37448100', 'Amendes judiciaires', 144, 36, 3, 1, '2024'),
(470, '27483300', 'Caution de mise en liberté provisoire', 145, 36, 3, 1, '2024'),
(471, '27012116', 'Droits sur le produit de ventes publiques', 146, 36, 3, 1, '2024'),
(472, '27484100', 'Droits proportionnels sur les sommes accordées en cas d\'exécution forcée', 146, 36, 3, 1, '2024'),
(473, '27484200', 'Droits sur les sommes allouées aux parties civiles', 146, 36, 3, 1, '2024'),
(474, '27484620', 'Autres recettes judiciaires', 146, 36, 3, 1, '2024'),
(475, '47722110', 'Dividendes des sociétés commerciales ', 148, 37, 4, 1, '2024'),
(476, '47722120', 'Dividendes des sociétés d\'économie mixte', 148, 37, 4, 1, '2024'),
(477, '47681300', 'Excédent de gestion d’un établissement public', 148, 37, 4, 1, '2024'),
(478, '47722000', 'ON SHORE', 150, NULL, NULL, 2, '2024'),
(479, '47722100', 'OFF SHORE', 150, NULL, NULL, 2, '2024'),
(480, '47722000', 'MARGE DISTRIBUABLE', 151, NULL, NULL, 2, '2024'),
(481, '47722100', 'ROYALTIESDES SOCIETES PETROLIERES', 151, NULL, NULL, 2, '2024');

-- --------------------------------------------------------

--
-- Structure de la table `dgrad_categorie_acte_generateur`
--

CREATE TABLE `dgrad_categorie_acte_generateur` (
  `id` int(11) NOT NULL,
  `code_categorie_acte` varchar(50) DEFAULT NULL,
  `libelle_categorie_acte` text NOT NULL,
  `id_service_assiette` int(11) DEFAULT NULL,
  `exercice` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgrad_categorie_acte_generateur`
--

INSERT INTO `dgrad_categorie_acte_generateur` (`id`, `code_categorie_acte`, `libelle_categorie_acte`, `id_service_assiette`, `exercice`) VALUES
(1, '27,420,000', 'Droits administratifs', 1, '2024'),
(2, '27,012,000', 'Ventes résiduelles de biens des établissements non marchands', 1, '2024'),
(3, '17,134,000', 'Taxes sur la détention ou l\'utilisation  des biens et services', 2, '2024'),
(4, '17,136,000', 'Taxes sur l\'autorisation d\'exercer une activité de production, de traitement, d\'extraction, de recherche, d\'exploitation, professionnelle et d\'agrément', 2, '2024'),
(5, '27,426,000', 'Droits administratifs d\'autorisation d\'exploitation', 2, '2024'),
(6, '27,420,000', 'Droits administratifs', 2, '2024'),
(7, '17,181,000', 'Autres recettes à la charge des sociétés et autres entreprises', 2, '2024'),
(8, '27,022,300', 'Droits d\'inscription, d\'enregistrements, d\'examen et de concours', 3, '2024'),
(9, '37,440,000', 'Amendes transactionnelles ', 3, '2024'),
(10, '17,135,000', 'Taxes sur l\'autorisation de commercialisation de divers produits ou d\'ouverture d\'établissements', 4, '2024'),
(11, '17,135,000', 'Taxes sur l\'autorisation de commercialisation de divers produits ou d\'ouverture d\'établissements', 5, '2024'),
(12, '27,012,000', 'Vente résiduelle de biens des établissements non marchands', 5, '2024'),
(13, '37,440,000', 'Amendes transactionnelles ', 5, '2024'),
(14, '37,440,000', 'Amendes transactionnelles ', 6, '2024'),
(15, '27,482,000', 'Restitution au Trésor Public', 6, '2024'),
(16, '27,012,000', 'Vente résiduelle de biens des établissements non marchands', 7, '2024'),
(17, '17,136,300', 'Taxes d\'agrément', 8, '2024'),
(18, '27,420,000', 'Droits administratifs', 8, '2024'),
(19, '37,440,000', 'Amendes transactionnelles ', 8, '2024'),
(20, '27,012,000', 'Vente résiduelle de biens des établissements non marchands', 9, '2024'),
(21, '27,022,000', 'Vente résiduelle des services des établissements non marchands', 9, '2024'),
(22, '27,484,000', ' Recettes diverses ', 9, '2024'),
(23, '37,440,000', 'Amendes transactionnelles ', 9, '2024'),
(24, '17,135,000', 'Taxes sur l\'autorisation de commercialisation de divers produits ou d\'ouverture d\'établissements', 10, '2024'),
(25, '17,153,000', 'Taxes diverses non douanières sur le commerce extérieur', 10, '2024'),
(26, '27,420,000', 'Droits administratifs', 10, '2024'),
(27, '27,022,000', 'Ventes résiduelles de services des établissements non marchands', 10, '2024'),
(28, '37,440,000', 'Amendes transactionnelles ', 10, '2024'),
(29, '17,136,300', 'Taxes d\'agrément', 11, '2024'),
(30, '27,022,000', 'Ventes résiduelles de services des établissements non marchands', 11, '2024'),
(31, '37,440,000', 'Amendes transactionnelles ', 11, '2024'),
(32, '17,136,000', 'Taxes sur  l\'autorisation  d\'exercer une activité de production, de traitement, d\'extraction, de recherche, d\'exploitation, professionnelle et d\'agrément', 12, '2024'),
(33, '27,416,000', 'Revenus sur droits d\'auteur, recherche scientifique, brevets et marques', 12, '2024'),
(34, '27,420,000', 'Droits administratifs', 12, '2024'),
(35, '37,440,000', 'Amendes transactionnelles ', 12, '2024'),
(36, '17,134,800', 'Autres taxes sur la détention ou l\'utilisation des biens et services', 13, '2024'),
(37, '17,136,300', 'Taxes d\'agrément', 13, '2024'),
(38, '27,021,000', 'Ventes de services des établissements marchands', 13, '2024'),
(39, '27,012,000', 'Vente résiduelle de biens des établissements non marchands', 13, '2024'),
(40, '37,440,000', 'Amendes transactionnelles ', 13, '2024'),
(41, '17,136,100', 'Taxes sur  l\'autorisation  d\'exercer une activité de production, de traitement, d\'extraction et de recherche', 14, '2024'),
(42, '7,162', 'Autres recettes fiscales à la charge d\'autres entités ou non identifiables', 14, '2024'),
(43, '27,415,100', 'Loyers', 14, '2024'),
(44, '37,440,000', 'Amendes transactionnelles ', 14, '2024'),
(45, '17,134,000', 'Taxes sur la détation ou l\'utilisation  des biens et services', 15, '2024'),
(46, '27,423,000', 'Taxes rémunératoire sur les opérations de commerce, la circulation, l\'importation des végétaux et des animaux', 15, '2024'),
(47, '27,420,000', 'Droits administratifs', 15, '2024'),
(48, '27,022,400', 'Ventes de services des établissements non marchands', 15, '2024'),
(49, '37,440,000', 'Amendes transactionnelles ', 15, '2024'),
(50, '27,416,000', 'Revenus sur droits d’auteur, recherche scientifique, brevets et marques', 16, '2024'),
(51, '27,428,000', 'Autres droits administratifs ', 16, '2024'),
(52, '37,440,000', 'Amendes transactionnelles ', 16, '2024'),
(53, '17,136,220', 'Taxes diverses produits sur l\'exercice des activités professionnelles', 17, '2024'),
(54, '17,153,000', 'Taxes diverses non douanières sur le commerce extérieur', 17, '2024'),
(55, '37,440,000', 'Amendes transactionnelles ', 17, '2024'),
(56, '17,150,000', 'Impôts sur le commerce extérieur et les transactions internationales', 18, '2024'),
(57, '27,415,000', 'Loyers', 18, '2024'),
(58, '27,021,000', 'Ventes des services des établissements  marchands', 18, '2024'),
(59, '27,420,000', 'Droits administratifs', 18, '2024'),
(60, '27,011,000', 'Ventes de biens des établissements  marchands', 18, '2024'),
(61, '27,012,000', 'Vente résiduelle de biens des établissements non marchands', 18, '2024'),
(62, '37,440,000', 'Amendes transactionnelles ', 18, '2024'),
(63, '27,483,000', 'Caution', 18, '2024'),
(64, '27,418,000', 'Autres revenus de la propriété', 18, '2024'),
(65, '17,122,000', 'Droits et taxes sur les transactions financières et en capital', 19, '2024'),
(66, '17,136,000', 'Taxe sur l\'autorisation d\'exercer une activité de production,  de traitement, d\'extraction, de recherche, d\'exploitation, professionnelle et agrément', 19, '2024'),
(67, '17,150,000', 'Impôts sur le commerce extérieur et les transactions internationales', 19, '2024'),
(68, '27,415,000', 'Loyers', 19, '2024'),
(69, '27,012,000', 'Ventes résiduelles de biens des établissements non marchands', 19, '2024'),
(70, '27,420,000', 'Droits administratifs', 19, '2024'),
(71, '27,426,000', 'Droits administratifs d’autorisations d’exploitation', 19, '2024'),
(72, '37,440,000', 'Amendes transactionnelles ', 19, '2024'),
(73, '17,130,000', 'Impôts généraux sur les biens et services', 20, '2024'),
(74, '17,150,000', 'Impôts sur le commerce extérieur et les transactions internationales', 20, '2024'),
(75, '17,180,000', 'Autres recettes à caractère fiscal', 20, '2024'),
(76, '27,424,000', 'Droits administratifs', 20, '2024'),
(77, '37,440,000', 'Amendes transactionnelles ', 20, '2024'),
(78, '17,130,000', 'Impôts généraux sur les biens et services', 21, '2024'),
(79, '17,150,000', 'Impôts sur le commerce extérieur et les transactions internationales', 21, '2024'),
(80, '17,180,000', 'Autres recettes à caractère fiscal', 21, '2024'),
(81, '27,420,000', 'Droits administratifs', 21, '2024'),
(82, '27,022,000', 'Ventes résiduelles de service des établissements non marchands', 21, '2024'),
(83, '37,440,000', 'Amendes transactionnelles ', 21, '2024'),
(84, '17,133,000', 'Taxes sur des services déterminés', 22, '2024'),
(85, '37,440,000', 'Amendes transactionnelles ', 22, '2024'),
(86, '17,130,000', 'Impôts et taxes sur les biens et services', 23, '2024'),
(87, '27,415,000', 'Loyers', 23, '2024'),
(88, '27,021,000', 'Ventes de services des établissements marchands', 23, '2024'),
(89, '27,420,000', 'Droits administratifs', 23, '2024'),
(90, '27,022,000', 'Ventes résiduelles des établissements non marchands', 23, '2024'),
(91, '37,440,000', 'Amendes transactionnelles ', 23, '2024'),
(92, '17,130,000', 'Impôts et taxes sur les biens et services', 24, '2024'),
(93, '27,484,000', 'Recettes  diverses', 24, '2024'),
(94, '37,440,000', 'Amendes transactionnelles ', 24, '2024'),
(95, '17,120,000', 'Impôts réels et impôts sur les transactions financières et en capital', 25, '2024'),
(96, '17,122,200', 'Droits fixes d\'enregistrement', 25, '2024'),
(97, '17,122,300', 'Droits proportionnels d\'enregistrement', 25, '2024'),
(98, '17,122,400', 'Taxe spéciale sur le transfert des contrats de location', 25, '2024'),
(99, '27,415,000', 'Loyers', 25, '2024'),
(100, '27,420,000', 'Droits administratifs ', 25, '2024'),
(101, '27,012,000', 'Ventes résiduelles de biens des établissements non marchands', 25, '2024'),
(102, '37,440,000', 'Amendes transactionnelles ', 25, '2024'),
(103, '17,130,000', 'Impôts et taxes sur les biens et services', 26, '2024'),
(104, '27,415,000', 'Loyers', 26, '2024'),
(105, '27,420,000', 'Droits administratifs', 26, '2024'),
(106, '37,440,000', 'Amendes transactionnelles ', 26, '2024'),
(107, '17,133,000', 'Taxes sur des services déterminés', 27, '2024'),
(108, '17,133,700', 'Redevance sur les billets de voyage', 27, '2024'),
(109, '27,420,000', 'Droits administratifs', 27, '2024'),
(110, '37,440,000', 'Amendes transactionnelles ', 27, '2024'),
(111, '27,480,000', 'Autres recettes non fiscales', 27, '2024'),
(112, '17,136,200', 'Taxes sur l\'autorisation d\'exercer une activité d\'explotation ou professionnelle et d\'agrément', 28, '2024'),
(113, '17,153,000', 'Taxes diverses non douanières sur le commerce extérieur', 28, '2024'),
(114, '27,416,000', 'Revenus sur droits d\'auteur, recherche scientifique, brevets et marques', 28, '2024'),
(115, '27,420,000', 'Droits administratifs', 28, '2024'),
(116, '27,022,000', 'Ventes résiduelles des établissements non marchands', 28, '2024'),
(117, '37,440,000', 'Amendes transactionnelles administratives', 28, '2024'),
(118, '17,111,000', 'Impôts professionnels des personnes physiques', 29, '2024'),
(119, '17,133,000', 'Taxes sur des services déterminés', 29, '2024'),
(120, '17,136,000', 'Taxes sur l\'autorisation  d\'exercer une activité de production, de traitement, d\'extraction, de recherche, d\'exploitation professionnel et d\'agrément', 29, '2024'),
(121, '17,134,000', 'Taxe sur la détention ou l\'utilisation des biens et services', 29, '2024'),
(122, '27,415,000', 'Loyers', 29, '2024'),
(123, '27,022,400', 'Ventes de services des établissements non marchands', 29, '2024'),
(124, '37,440,000', 'Amendes transactionnelles ', 29, '2024'),
(125, '17,182,000', 'Autres recettes fiscales à la charge d\'autres entités ou non identifiables', 30, '2024'),
(126, '27,022,000', 'Ventes résiduelles des établissements non marchands', 30, '2024'),
(127, '37,440,000', 'Amendes transactionnelles administratives', 30, '2024'),
(128, '37,440,000', 'Amendes transactionnelles ', 31, '2024'),
(129, '17,136,000', 'Taxes sur l\'utilisation ou l\'autorisation d\'utiliser des biens ou d\'exercer des activités', 32, '2024'),
(130, '17,134,000', 'Taxes sur la détation ou l\'utilisation  des biens et services', 33, '2024'),
(131, '27,423,000', 'Taxes rémunératoire sur les opérations de commerce, la circulation, l\'importation des végétaux et des animaux', 33, '2024'),
(132, '27,420,000', 'Droits administratifs', 33, '2024'),
(133, '27,022,400', 'Ventes de services des établissements non marchands', 33, '2024'),
(134, '37,440,000', 'Amendes transactionnelles ', 33, '2024'),
(135, '17,136,000', 'Taxes sur l\'utilisation ou l\'autorisation d\'utiliser des biens ou d\'exercer des activités', NULL, '2024'),
(136, '27,022,000', 'Ventes résiduelles des établissements non marchands', 34, '2024'),
(137, '37,447,000', 'Amendes de police', 34, '2024'),
(138, '27,420,000', 'Droits administratifs', 35, '2024'),
(139, '37,440,000', 'Amendes transactionnelles ', 35, '2024'),
(140, '17,181,000', 'Autres recettes fiscales à la charge des sociétés et autres entreprises', 36, '2024'),
(141, '27,428,000', 'Autres droits administratifs', 36, '2024'),
(142, '27,022,000', 'Ventes résiduelles des établissements non marchands', 36, '2024'),
(143, '37,440,000', 'Amendes transactionnelles administratives', 36, '2024'),
(144, '37,448,000', 'Amendes judiciaires', 36, '2024'),
(145, '27,483,000', 'Cautions', 36, '2024'),
(146, '27,484,000', 'Autres recettes diverses non classées ailleurs', 36, '2024'),
(147, '47,722,000', 'Dividendes', 37, '2024'),
(148, '47,722,100', 'Dividendes d\'une entreprise du portefeuille', 37, '2024'),
(149, '47,722,500', 'Boni de liquidation d’une entreprise du portefeuille', 37, '2024'),
(150, NULL, 'PETROLIERS PARTICIPATIONS', NULL, '2024'),
(151, NULL, 'PETROLIERS HYDROCARBURES', NULL, '2024');

-- --------------------------------------------------------

--
-- Structure de la table `dgrad_categorie_recette`
--

CREATE TABLE `dgrad_categorie_recette` (
  `id` int(11) NOT NULL,
  `libelle_categorie_recette` text NOT NULL,
  `id_type_recette` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgrad_categorie_recette`
--

INSERT INTO `dgrad_categorie_recette` (`id`, `libelle_categorie_recette`, `id_type_recette`) VALUES
(1, 'RECETTES ADMINISTRATIVES', 1),
(2, 'RECETTES DOMANIALES', 1),
(3, 'RECETTES JUDICIAIRES', 1),
(4, 'RECETTES DE PARTICIPATION', 1);

-- --------------------------------------------------------

--
-- Structure de la table `dgrad_servives_assiettes`
--

CREATE TABLE `dgrad_servives_assiettes` (
  `id` int(11) NOT NULL,
  `libelle_service` text NOT NULL,
  `code_service_assiette` varchar(255) DEFAULT NULL,
  `id_type_recette` int(11) DEFAULT NULL,
  `id_categorie_recette` int(11) DEFAULT NULL,
  `exercice` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgrad_servives_assiettes`
--

INSERT INTO `dgrad_servives_assiettes` (`id`, `libelle_service`, `code_service_assiette`, `id_type_recette`, `id_categorie_recette`, `exercice`) VALUES
(1, 'AFFAIRES ÉTRANGÈRES ET COOPÉRATION INTERNATIONALE', '22', 1, 1, '2024'),
(2, 'INTÉRIEUR  ET SECURITE', '25 a', 1, 1, '2024'),
(3, 'INTÉRIEUR / RELATION AVEC LES PARTIS POLITIQUES', '25 b', 1, 1, '2024'),
(4, 'DEFENSE NATIONALE', '27', 1, 2, '2024'),
(5, 'ÉCONOMIE NATIONALE', '29', 1, 1, '2024'),
(6, 'FINANCES', '30', 1, 1, '2024'),
(7, 'BUDGET', '31', 1, 1, '2024'),
(8, 'PLAN ', '32', 1, 1, '2024'),
(9, 'JUSTICE ET GARDE DES SCEAUX', '34', 1, 3, '2024'),
(10, 'SANTE PUBLIQUE', '37', 1, 1, '2024'),
(11, 'ENSEIGNEMENT SUPÉRIEUR ET UNIVERSITAIRE ', '40', 1, 1, '2024'),
(12, 'RECHERCHE SCIENTIFIQUE ET INNOVATION TECHNOLOGIQUE', '41', 1, 1, '2024'),
(13, 'INFRASTRUCTURES ET TRAVAUX PUBLICS', '42', 1, 1, '2024'),
(14, 'URBANISME ET HABITAT', '43', 1, 2, '2024'),
(15, 'AGRICULTURE', '44', 1, 1, '2024'),
(16, 'INDUSTRIE', '46', 1, 1, '2024'),
(17, 'COMMERCE EXTÉRIEUR', '47', 1, 1, '2024'),
(18, 'MINES (Sécrétariat Général & CAMI)', '48', 1, 2, '2024'),
(19, 'HYDROCARBURES', '49', 1, 2, '2024'),
(20, 'RESSOURCES HYDRAULIQUES ET ELECTRICITE (Secrétariat Général & CNE)', '50', 1, 1, '2024'),
(21, 'TRANSPORTS, VOIES DE COMMUNICATION ET DESENCLAVEMENT ', '51', 1, 1, '2024'),
(22, 'AUTORITÉ DE RÉGULATION DES PTT / ARPTC', '52', 1, 1, '2024'),
(23, 'POSTES, TÉLÉCOMMUNICATIONS ET NOUVELLES TECHNOLOGIES DE L\'INFORMATION ET DE LA COMMUNICATION (PT-NTIC)', '52', 1, 1, '2024'),
(24, 'COMMUNICATION ET MEDIAS', '53', 1, 1, '2024'),
(25, 'AFFAIRES FONCIÈRES', '55', 1, 2, '2024'),
(26, 'ENVIRONNEMENT ET DEVELOPPEMENT DURABLE', '56', 1, 2, '2024'),
(27, 'TOURISME', '57', 1, 1, '2024'),
(28, 'CULTURE ET ARTS', '58', 1, 1, '2024'),
(29, 'SPORTS ET LOISIRS', '60', 1, 1, '2024'),
(30, 'EMPLOI ET TRAVAIL ', '62', 1, 1, '2024'),
(31, ' PRÉVOYANCE SOCIALE', '63', 1, 1, '2024'),
(32, 'AFFAIRES SOCIALES', '64', 1, 1, '2024'),
(33, 'PÊCHE ET ÉLEVAGE', '82', 1, 1, '2024'),
(34, 'POLICE NATIONALE', '85', 1, 3, '2024'),
(35, 'DIRECTION GÉNÉRALE DES MIGRATIONS (DGM)', '86', 1, 1, '2024'),
(36, 'COURS, TRIBUNAUX ET PARQUETS', '87', 1, 3, '2024'),
(37, 'PORTEFEUILLE (Secrétariat Général)', '74', 1, 4, '2024');

-- --------------------------------------------------------

--
-- Structure de la table `dgrad_statistique`
--

CREATE TABLE `dgrad_statistique` (
  `id` int(11) NOT NULL,
  `id_ordre` int(11) NOT NULL,
  `id_type_recette` int(11) DEFAULT NULL,
  `id_categorie_recette` int(11) DEFAULT NULL,
  `id_service_assiette` int(11) DEFAULT NULL,
  `id_categorie_acte` int(11) DEFAULT NULL,
  `id_province` int(11) DEFAULT NULL,
  `code_acte` varchar(50) DEFAULT NULL,
  `libelle_acte` text DEFAULT NULL,
  `prevision` decimal(20,2) DEFAULT NULL,
  `realisation` decimal(20,2) DEFAULT NULL,
  `id_etat_donnee` int(11) DEFAULT NULL,
  `mois` int(11) NOT NULL,
  `annee` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgrad_statistique`
--

INSERT INTO `dgrad_statistique` (`id`, `id_ordre`, `id_type_recette`, `id_categorie_recette`, `id_service_assiette`, `id_categorie_acte`, `id_province`, `code_acte`, `libelle_acte`, `prevision`, `realisation`, `id_etat_donnee`, `mois`, `annee`) VALUES
(1, 1, 1, 1, 1, 1, 53, '27421100', 'Droits de délivrance de laissez-passer tenant lieu de passeport', 80816.05, 378299.48, 3, 1, '2024'),
(2, 2, 1, 1, 1, 1, 53, '27421200', 'Droits de légalisation par la représentation diplomatique ou consulaire (Droits de légalisation simple) ', 800285.72, 281816.43, 3, 1, '2024'),
(3, 3, 1, 1, 1, 1, 53, '27421500', 'Taxe de délivrance de la Note verbale', 392797.58, 351023.23, 3, 1, '2024'),
(4, 4, 1, 1, 1, 1, 53, '27421600', 'Droits de délivrance du Passeport ordinaire', 339463.39, 333725.72, 3, 1, '2024'),
(5, 5, 1, 1, 1, 1, 53, '27421710', 'Droits de délivrance des Visas d\'entrée', 162407.46, 460463.20, 3, 1, '2024'),
(6, 6, 1, 1, 1, 2, 53, '27012220', 'Droits d\'octroi de la Carte consulaire', 162397.81, 118178.55, 3, 1, '2024'),
(7, 7, 1, 1, 1, 2, 53, '27012284', 'Droits sur les actes d\'état civil délivrés à l\'étranger par les ambassades et consulats de la RDC', 123233.44, 212385.28, 3, 1, '2024'),
(8, 478, 2, NULL, 1, 150, 53, '47722000', 'ON SHORE', 321541.71, 166513.35, 3, 1, '2024'),
(9, 479, 2, NULL, 1, 150, 53, '47722100', 'OFF SHORE', 487721.01, 395213.45, 3, 1, '2024'),
(10, 480, 2, NULL, 1, 151, 53, '47722000', 'MARGE DISTRIBUABLE', 309239.14, 133119.47, 3, 1, '2024'),
(11, 481, 2, NULL, 1, 151, 53, '47722100', 'ROYALTIESDES SOCIETES PETROLIERES', 351759.46, 341260.84, 3, 1, '2024'),
(12, 8, 1, 1, 2, 3, 53, '17134700', 'Droits de délivrance ou de renouvellement de Permis de port d\'armes d\'autodéfense, de chasse ou de sport ', 446470.46, 480164.59, 3, 1, '2024'),
(13, 9, 1, 1, 2, 4, 53, '17136120', 'Taxe sur l\'autorisation spéciale de fabrication artisanale, d\'importation et/ou de vente d\'armes de chasse ou d\'autodéfense', 340446.00, 456105.51, 3, 1, '2024'),
(14, 10, 1, 1, 2, 5, 53, '27426820', 'Droits de délivrance du Permis d\'exploitation d\'une société de gardiennage', 383229.03, 282262.70, 3, 1, '2024'),
(15, 11, 1, 1, 2, 6, 53, '27426111', 'Redevance annuelle d’exploitation d\'une société de gardiennage', 108233.80, 348053.04, 3, 1, '2024'),
(16, 12, 1, 1, 2, 6, 53, '27426112', 'Redevance annuelle d’exploitation des services de vente de recharge et de maintenance des dispositifs anti incendie', 487963.94, 210952.47, 3, 1, '2024'),
(17, 13, 1, 1, 2, 7, 53, '17182600', '(Produits de vente de carte de résidence pour étranger)', 432977.06, 175248.46, 3, 1, '2024'),
(18, 14, 1, 1, 2, 7, 53, '17182500', 'Droits de vente de la carte d\'identité', 184935.64, 285479.36, 3, 1, '2024'),
(19, 478, 2, NULL, 2, 150, 53, '47722000', 'ON SHORE', 321541.71, 166513.35, 3, 1, '2024'),
(20, 479, 2, NULL, 2, 150, 53, '47722100', 'OFF SHORE', 487721.01, 395213.45, 3, 1, '2024'),
(21, 480, 2, NULL, 2, 151, 53, '47722000', 'MARGE DISTRIBUABLE', 309239.14, 133119.47, 3, 1, '2024'),
(22, 481, 2, NULL, 2, 151, 53, '47722100', 'ROYALTIESDES SOCIETES PETROLIERES', 351759.46, 341260.84, 3, 1, '2024'),
(23, 1, 1, 1, 1, 1, 58, '27421100', 'Droits de délivrance de laissez-passer tenant lieu de passeport', 249816.05, 378299.48, 3, 1, '2024'),
(24, 2, 1, 1, 1, 1, 58, '27421200', 'Droits de légalisation par la représentation diplomatique ou consulaire (Droits de légalisation simple) ', 480285.72, 281816.43, 3, 1, '2024'),
(25, 3, 1, 1, 1, 1, 58, '27421500', 'Taxe de délivrance de la Note verbale', 392797.58, 351023.23, 3, 1, '2024'),
(26, 4, 1, 1, 1, 1, 58, '27421600', 'Droits de délivrance du Passeport ordinaire', 339463.39, 333725.72, 3, 1, '2024'),
(27, 5, 1, 1, 1, 1, 58, '27421710', 'Droits de délivrance des Visas d\'entrée', 162407.46, 460463.20, 3, 1, '2024'),
(28, 6, 1, 1, 1, 2, 58, '27012220', 'Droits d\'octroi de la Carte consulaire', 162397.81, 118178.55, 3, 1, '2024'),
(29, 7, 1, 1, 1, 2, 58, '27012284', 'Droits sur les actes d\'état civil délivrés à l\'étranger par les ambassades et consulats de la RDC', 123233.44, 212385.28, 3, 1, '2024'),
(30, 478, 2, NULL, 1, 150, 58, '47722000', 'ON SHORE', 321541.71, 166513.35, 3, 1, '2024'),
(31, 479, 2, NULL, 1, 150, 58, '47722100', 'OFF SHORE', 487721.01, 395213.45, 3, 1, '2024'),
(32, 480, 2, NULL, 1, 151, 58, '47722000', 'MARGE DISTRIBUABLE', 309239.14, 133119.47, 3, 1, '2024'),
(33, 481, 2, NULL, 1, 151, 58, '47722100', 'ROYALTIESDES SOCIETES PETROLIERES', 351759.46, 341260.84, 3, 1, '2024'),
(34, 8, 1, 1, 2, 3, 58, '17134700', 'Droits de délivrance ou de renouvellement de Permis de port d\'armes d\'autodéfense, de chasse ou de sport ', 446470.46, 480164.59, 3, 1, '2024'),
(35, 9, 1, 1, 2, 4, 58, '17136120', 'Taxe sur l\'autorisation spéciale de fabrication artisanale, d\'importation et/ou de vente d\'armes de chasse ou d\'autodéfense', 340446.00, 456105.51, 3, 1, '2024'),
(36, 10, 1, 1, 2, 5, 58, '27426820', 'Droits de délivrance du Permis d\'exploitation d\'une société de gardiennage', 383229.03, 282262.70, 3, 1, '2024'),
(37, 11, 1, 1, 2, 6, 58, '27426111', 'Redevance annuelle d’exploitation d\'une société de gardiennage', 108233.80, 348053.04, 3, 1, '2024'),
(38, 12, 1, 1, 2, 6, 58, '27426112', 'Redevance annuelle d’exploitation des services de vente de recharge et de maintenance des dispositifs anti incendie', 487963.94, 210952.47, 3, 1, '2024'),
(39, 13, 1, 1, 2, 7, 58, '17182600', '(Produits de vente de carte de résidence pour étranger)', 432977.06, 175248.46, 3, 1, '2024'),
(40, 14, 1, 1, 2, 7, 58, '17182500', 'Droits de vente de la carte d\'identité', 184935.64, 285479.36, 3, 1, '2024'),
(41, 478, 2, NULL, 2, 150, 58, '47722000', 'ON SHORE', 321541.71, 166513.35, 3, 1, '2024'),
(42, 479, 2, NULL, 2, 150, 58, '47722100', 'OFF SHORE', 487721.01, 395213.45, 3, 1, '2024'),
(43, 480, 2, NULL, 2, 151, 58, '47722000', 'MARGE DISTRIBUABLE', 309239.14, 133119.47, 3, 1, '2024'),
(44, 481, 2, NULL, 2, 151, 58, '47722100', 'ROYALTIESDES SOCIETES PETROLIERES', 351759.46, 341260.84, 3, 1, '2024'),
(45, 16, 1, 1, 3, 8, 53, '27022360', 'Droits de dépôt des candidatures aux élections ', 173361.80, 333462.44, 3, 1, '2024'),
(46, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes transactionnelles administratives', 221696.90, 131093.85, 3, 1, '2024'),
(47, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes transactionnelles administratives ', 479554.21, 118087.47, 3, 1, '2024'),
(48, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes transactionnelles administratives', 243386.29, 348123.82, 3, 1, '2024'),
(49, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes transactionnelles administratives', 324510.88, 444945.48, 3, 1, '2024'),
(50, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes transactionnelles administratives', 199716.89, 130345.33, 3, 1, '2024'),
(51, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes transactionnelles administratives', 457023.60, 116347.45, 3, 1, '2024'),
(52, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes transactionnelles administratives', 196822.11, 313046.91, 3, 1, '2024'),
(53, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes transactionnelles administratives', 376758.08, 303044.15, 3, 1, '2024'),
(54, 17, 1, 1, 3, 9, 53, '37441000', ' Amendes Transactionnelles administratives', 146826.81, 336117.98, 3, 1, '2024'),
(55, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes transactionnelles administratives', 425119.83, 108987.72, 3, 1, '2024'),
(56, 17, 1, 1, 3, 9, 53, '37441000', 'Amendes Transactionnelles administratives', 333347.51, 182568.51, 3, 1, '2024'),
(57, 478, 2, NULL, 3, 150, 53, '47722000', 'ON SHORE', 321541.71, 166513.35, 3, 1, '2024'),
(58, 479, 2, NULL, 3, 150, 53, '47722100', 'OFF SHORE', 487721.01, 395213.45, 3, 1, '2024'),
(59, 480, 2, NULL, 3, 151, 53, '47722000', 'MARGE DISTRIBUABLE', 309239.14, 133119.47, 3, 1, '2024'),
(60, 481, 2, NULL, 3, 151, 53, '47722100', 'ROYALTIESDES SOCIETES PETROLIERES', 351759.46, 341260.84, 3, 1, '2024');

-- --------------------------------------------------------

--
-- Structure de la table `dgrad_type_recette`
--

CREATE TABLE `dgrad_type_recette` (
  `id` int(2) NOT NULL,
  `libelle_type_recette` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgrad_type_recette`
--

INSERT INTO `dgrad_type_recette` (`id`, `libelle_type_recette`) VALUES
(1, 'RECETTES HORS PETROLIERS'),
(2, 'RECETTES PETROLIERS PRODUCTEURS');

-- --------------------------------------------------------

--
-- Structure de la table `dgrad_utilisateur`
--

CREATE TABLE `dgrad_utilisateur` (
  `id` int(11) NOT NULL,
  `pseudo` text NOT NULL,
  `motdepasse` text NOT NULL,
  `id_province` int(11) DEFAULT NULL,
  `id_service_pourvoyeur` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  `id_etat_utilisateur` int(11) NOT NULL,
  `token_utilisateur` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dgrad_utilisateur`
--

INSERT INTO `dgrad_utilisateur` (`id`, `pseudo`, `motdepasse`, `id_province`, `id_service_pourvoyeur`, `id_role`, `id_etat_utilisateur`, `token_utilisateur`) VALUES
(1, 'KKDAN', '7c222fb2927d828af22f592134e8932480637c0d', NULL, 3, 1, 1, '9fd0b37b5609a4ef6170216f542dbf90b7802c40'),
(2, 'TOCLAUDE', '7c222fb2927d828af22f592134e8932480637c0d', NULL, 3, 2, 1, '86e35486e9a708de1ce66e1ace241d0e7f44c674'),
(3, 'JDJean', '7c222fb2927d828af22f592134e8932480637c0d', 53, 3, 3, 1, '74ef72036a5b90654d20da5010cd3fcf1e376994'),
(4, 'MSMarie', '7c222fb2927d828af22f592134e8932480637c0d', 58, 3, 3, 1, '57092d345d08c6206f8834040718e949ba351be8'),
(6, 'ALAlice', '7c222fb2927d828af22f592134e8932480637c0d', 59, 3, 3, 1, '6436518c986f5b801eb289c1d489464f7f6a65f3'),
(7, 'BBoris', '7c222fb2927d828af22f592134e8932480637c0d', 60, 3, 3, 1, '1244e12d1e963f1d9bd4310f5b0f83f4a867c796'),
(8, 'CClara', '7c222fb2927d828af22f592134e8932480637c0d', 61, 3, 3, 1, '4ca4c9dbbdbad42d9f3132351645c9b314a9548e'),
(9, 'EEric', '7c222fb2927d828af22f592134e8932480637c0d', 62, 3, 3, 1, '0a5eaf3d536c341f55a83cc26099d60690aa2e5e'),
(10, 'FSFranck', '7c222fb2927d828af22f592134e8932480637c0d', 63, 3, 3, 1, '889b8e9b2117b109521978e6f4f90a2eaad24625'),
(11, 'GGeorge', '7c222fb2927d828af22f592134e8932480637c0d', 64, 3, 3, 1, '5c36caf54d2b70b71475ac3b756e7beedfbb26fc'),
(12, 'HHelen', '7c222fb2927d828af22f592134e8932480637c0d', 65, 3, 3, 1, 'd96168689729529524c8138efc5c325bcc010462'),
(13, 'IKIris', '7c222fb2927d828af22f592134e8932480637c0d', 66, 3, 3, 1, '212e5724a2c7fd4a227f20da764600be90af30ca'),
(14, 'JLJohn', '7c222fb2927d828af22f592134e8932480637c0d', 67, 3, 3, 1, 'dab47d43dcec247204bbdc04da7c05893debc4d3'),
(15, 'KMKatherine', '7c222fb2927d828af22f592134e8932480637c0d', 68, 3, 3, 1, '4556d0bbdb8e59cf7c6201c9bf723ffd913b4796'),
(16, 'LLouis', '7c222fb2927d828af22f592134e8932480637c0d', 69, 3, 3, 1, 'b70087b706ef962a3dc0b2e2e60720e56d7669ae'),
(17, 'NNina', '7c222fb2927d828af22f592134e8932480637c0d', 70, 3, 3, 1, 'c641aaa93f47c76dbc0d587f43bd19173b99cd31'),
(18, 'OOscar', '7c222fb2927d828af22f592134e8932480637c0d', 71, 3, 3, 1, '04e253b8b9942ab2cec181e41fcd73dbf6240c33'),
(19, 'PPedro', '7c222fb2927d828af22f592134e8932480637c0d', 72, 3, 3, 1, 'b32363542c3ccc8ec49cb80d7d0f3a8ffaaaeb4c'),
(20, 'QQuentin', '7c222fb2927d828af22f592134e8932480637c0d', 73, 3, 3, 1, 'fc9e172f23a25d008dac26a81abbe951fbbdb818'),
(21, 'RRachel', '7c222fb2927d828af22f592134e8932480637c0d', 74, 3, 3, 1, '4701ef7b8a0515ff65ed605b7bfb04e0e5116756'),
(22, 'SSteven', '7c222fb2927d828af22f592134e8932480637c0d', 75, 3, 3, 1, '21018fd88028061806dcd17998b4aa110adace9f'),
(23, 'TThomas', '7c222fb2927d828af22f592134e8932480637c0d', 76, 3, 3, 1, 'e46ca47d11dea534740a229e8ff7c9a0ca63f845'),
(24, 'UUrsula', '7c222fb2927d828af22f592134e8932480637c0d', 77, 3, 3, 1, '4767c1b9904309e3d1c45e794b28f926bfeddda3'),
(25, 'VVictor', '7c222fb2927d828af22f592134e8932480637c0d', 78, 3, 3, 1, 'a71acc8b433952c14fb765d8970ca2fe97bd5dbb'),
(26, 'WWilliam', '7c222fb2927d828af22f592134e8932480637c0d', 79, 3, 3, 1, '7053d8331c4c49985b053de7c47c0c41264fa526'),
(27, 'XXena', '7c222fb2927d828af22f592134e8932480637c0d', 80, 3, 3, 1, '557de6ae7dcdfed6dddc420890ed40c012a3bc45'),
(28, 'YYvonne', '7c222fb2927d828af22f592134e8932480637c0d', 81, 3, 3, 1, '2845f73f9db737f93b314eb5cba22aa2791bf9cb'),
(29, 'ZZoe', '7c222fb2927d828af22f592134e8932480637c0d', 82, 3, 3, 1, '1c272cec06257d3b2821e2fa37d0433da4e9a950');

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
(2, 'Validation Administrateur Service'),
(3, 'Validation DEP');

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
(26, 'TSHUAPA', 2, 1),
(27, 'BAS-UELE', 2, 2),
(28, 'EQUATEUR', 2, 2),
(29, 'HAUT-KATANGA', 2, 2),
(30, 'HAUT-LOMAMI', 2, 2),
(31, 'HAUT-UELE', 2, 2),
(32, 'ITURI', 2, 2),
(33, 'KASAI', 2, 2),
(34, 'KASAI-ORIENTAL', 2, 2),
(35, 'KONGO-CENTRAL', 2, 2),
(36, 'KWANGO', 2, 2),
(37, 'KWILU', 2, 2),
(38, 'LOMAMI', 2, 2),
(39, 'LUALABA', 2, 2),
(40, 'KASAI-CENTRAL', 2, 2),
(41, 'MAI-NDOMBE', 2, 2),
(42, 'MANIEMA', 2, 2),
(43, 'MONGALA', 2, 2),
(44, 'NORD-KIVU', 2, 2),
(45, 'NORD-UBANGI', 2, 2),
(46, 'SANKURU', 2, 2),
(47, 'SUD-KIVU', 2, 2),
(48, 'SUD-UBANGI', 2, 2),
(49, 'TANGANYIKA', 2, 2),
(50, 'TSHOPO', 2, 2),
(51, 'TSHUAPA', 2, 2),
(52, 'KINSHASA', 2, 2),
(53, 'KINSHASA', 2, 3),
(58, 'BAS-UELE', 2, 3),
(59, 'ÉQUATEUR', 2, 3),
(60, 'HAUT-KATANGA', 2, 3),
(61, 'HAUT-LOMAMI', 2, 3),
(62, 'HAUT-UELÉ', 2, 3),
(63, 'ITURI', 2, 3),
(64, 'KASAÏ', 2, 3),
(65, 'KASAÏ-CENTRAL', 2, 3),
(66, 'KASAÏ-ORIENTAL', 2, 3),
(67, 'KONGO-CENTRAL', 2, 3),
(68, 'KWILU', 2, 3),
(69, 'KWANGO', 2, 3),
(70, 'LUALABA', 2, 3),
(71, 'LOMAMI', 2, 3),
(72, 'MANIEMA', 2, 3),
(73, 'MAI-NDOMBE', 2, 3),
(74, 'MONGALA', 2, 3),
(75, 'NORD-KIVU', 2, 3),
(76, 'NORD-UBANGI', 2, 3),
(77, 'SANKURU', 2, 3),
(78, 'SUD-KIVU', 2, 3),
(79, 'SUD-UBANGI', 2, 3),
(80, 'TANGANYIKA', 2, 3),
(81, 'TSHOPO', 2, 3),
(82, 'TSHUAPA', 2, 3);

-- --------------------------------------------------------

--
-- Structure de la table `province_finale`
--

CREATE TABLE `province_finale` (
  `id` int(11) NOT NULL,
  `libelle_province_fin` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `province_finale`
--

INSERT INTO `province_finale` (`id`, `libelle_province_fin`) VALUES
(1, 'BAS-UELE'),
(2, 'ÉQUATEUR'),
(3, 'HAUT-KATANGA'),
(4, 'HAUT-LOMAMI'),
(5, 'HAUT-UELE'),
(6, 'ITURI'),
(7, 'KASAÏ'),
(8, 'KASAÏ CENTRAL'),
(9, 'KASAÏ ORIENTAL'),
(10, 'KINSHASA'),
(11, 'KONGO-CENTRAL'),
(12, 'KWANGO'),
(13, 'KWILU'),
(14, 'LOMAMI'),
(15, 'LUALABA'),
(16, 'MAI-NDOMBE'),
(17, 'MANIEMA'),
(18, 'MONGALA'),
(19, 'NORD-KIVU'),
(20, 'NORD-UBANGI'),
(21, 'SANKURU'),
(22, 'SUD-KIVU'),
(23, 'SUD-UBANGI'),
(24, 'TANGANYIKA'),
(25, 'TSHOPO'),
(26, 'TSHUAPA');

-- --------------------------------------------------------

--
-- Structure de la table `role_admin`
--

CREATE TABLE `role_admin` (
  `id` int(11) NOT NULL,
  `libelle_role` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `role_admin`
--

INSERT INTO `role_admin` (`id`, `libelle_role`) VALUES
(1, 'Administrateur DSI (DGI)'),
(2, 'Administrateur DSI (DGDA)'),
(3, 'Administrateur DSI (DGRAD)');

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
(1, 'Direction Générale des Impôts', 'DGI'),
(2, 'Direction générale des douanes et accises', 'DGDA'),
(3, 'La Direction Générale des Recettes Administratives, Judiciaires, Domaniales et de Participations', 'DGRAD');

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
-- Structure de la table `statistiques_globales`
--

CREATE TABLE `statistiques_globales` (
  `id` int(11) NOT NULL,
  `code_transfert` varchar(255) NOT NULL,
  `id_etat_donnee` int(11) NOT NULL,
  `id_service_pourvoyeur` int(11) NOT NULL,
  `id_mois` int(11) NOT NULL,
  `annee` varchar(4) NOT NULL,
  `prevision` float NOT NULL,
  `realisation` float NOT NULL,
  `date_transfert` date NOT NULL,
  `id_province_finale` int(11) DEFAULT NULL,
  `code_recette` varchar(30) NOT NULL,
  `libelle_recette` text NOT NULL,
  `dgi_id_centre_perception` int(11) DEFAULT NULL,
  `id_dgi_ordre` int(11) DEFAULT NULL,
  `dgi_province` int(11) DEFAULT NULL,
  `dgi_type_nature_recette` int(11) DEFAULT NULL,
  `dgi_categorie_nature_recette` int(11) DEFAULT NULL,
  `dgda_id_province` int(11) DEFAULT NULL,
  `dgda_id_centre_perception` int(11) DEFAULT NULL,
  `id_dgda_ordre` int(11) DEFAULT NULL,
  `dgda_id_type_secteur_activite` int(11) DEFAULT NULL,
  `dgda_id_categorie_secteur_activite` int(11) DEFAULT NULL,
  `dgda_id_secteur_activite` int(11) DEFAULT NULL,
  `dgda_id_type_nature_economique` int(11) DEFAULT NULL,
  `dgda_id_categorie_nature_economique` int(11) DEFAULT NULL,
  `dgrad_id_type_recette` int(11) DEFAULT NULL,
  `dgrad_id_categorie_recette` int(11) DEFAULT NULL,
  `dgrad_id_service_assiette` int(11) DEFAULT NULL,
  `dgrad_id_categorie_acte` int(11) DEFAULT NULL,
  `dgrad_id_province` int(11) DEFAULT NULL
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
(1, 'KKDAN', '7c222fb2927d828af22f592134e8932480637c0d', 1, 1, NULL, NULL, 1, '984c95c087d91e47155453e48b756d74e6b56369'),
(3, 'KKCLEBERG', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 1, 1, '978f4e27147f195e5bfa3e8b62aee63ab9e1edcd'),
(7, 'VHDANIEL', '7c222fb2927d828af22f592134e8932480637c0d', 1, 2, NULL, NULL, 1, 'ced318f25ccd44fe619cbb4c8f2923c47b94ddea'),
(8, 'OJLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 2, 1, '4af59304486467768088b4d1a08883b547feefc9'),
(9, 'OJJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 3, 1, 'dfd4ecb4027ffff4604350ecc1c19f4d5acc102f'),
(10, 'RUPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 4, 1, '6121f03b20b722fd1b7c0f5e46fd1839d0a07e61'),
(11, 'CWClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 5, 1, '43a3752b2fe7614ae97156404ddae3de8fdc7cd3'),
(12, 'IQLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 6, 1, 'f42ed88a4d37a6fdb34d05202427aebd469c9279'),
(13, 'SYLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 7, 1, 'b6f4899632b5a62f9fd011d6ca2572df476a9a34'),
(14, 'DGVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 8, 1, '7291489b3cf3e3ad3591123bd9be4f787c3048cc'),
(15, 'QCPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 9, 1, '55e09c00f780a14d5927b30a2b8f319d0a7adfa7'),
(16, 'VIGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 10, 1, 'af4d2652bbfefdfda28060f3fae3595b8d2bf20c'),
(17, 'FPAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 11, 1, 'aa488acab640d0ebcc174ad47df4d6203c230948'),
(18, 'ADMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 12, 1, '0ab3f7c891c7ee58d6a334a29901d37d754c2b6c'),
(19, 'FGJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 13, 1, 'bb7c6bb28668119e594a7edbb9142e65fe860426'),
(20, 'IFEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 14, 1, 'a7a015e9964ad2a72ea1a2cca1040bfcccb1f5f7'),
(21, 'AMPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 15, 1, 'ee4c4d39967379c5b95ca3604d4164485150c951'),
(22, 'UBLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 16, 1, '504eb0b160c124c32a70b5360dbd182a3bac6a8e'),
(23, 'XBAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 17, 1, 'a0b85d217e30489ff75526baa47fd361aa75b868'),
(24, 'JWEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 18, 1, '8407c3e96a5764b06d84b26404fe70317e6635ff'),
(25, 'MIAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 19, 1, '86d579666fd7e4efdcd1fdef9f1c5966f620725b'),
(26, 'WVJacques', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 20, 1, 'a1668bee382f04f74d56a3d917d41e6a175209e6'),
(27, 'PAEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 21, 1, 'e62b143c369ec971a428b7dba32c2e96a47a4fa2'),
(28, 'MPAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 22, 1, 'fefd8643638b121e7df9231f05fe304cbc46eeb5'),
(29, 'LRPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 23, 1, '6cd263f892945eeef2a624b56c606cc5c7aa0d80'),
(30, 'NMElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 24, 1, '2a5ea0f5267709347ef9b4688f11fb7f0c92d5b2'),
(31, 'AAMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 25, 1, '1678b61f47ae9e14095516ecd487c3aa15749993'),
(32, 'SLClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 26, 1, 'cb664b70c1023c3d1f72f1ba98e44a333594d6c4'),
(33, 'TOAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 1, 27, 1, '6787e60939f75e0c89b0f70708f3700867823b49'),
(34, 'QDLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 2, 28, 1, '2bbf2fb82bb2989fb844324a2c40e9b18dc38018'),
(35, 'HQClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 2, 29, 1, 'fbf9c034d7fc0b3179f6f1e83a1df7ab774da937'),
(36, 'DXSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 30, 1, '508cbb9ad648dd8c26a9bb38443d05a5349766ed'),
(37, 'PFClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 31, 1, '78666db933d8a39b29fc16317f8e4940790ad50f'),
(38, 'WBAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 32, 1, 'e94c6aa99f1733ec3479b5400461ffad1c559dab'),
(39, 'VSClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 33, 1, 'dcdabe9590a3a06edebb39408871598477c963c5'),
(40, 'QWLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 3, 34, 1, 'c88d8716e048b1afbadf7d7cd1fea92b9f78fd13'),
(41, 'XKLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 35, 1, 'd9eb36db6624ee08c5a68c2746ae717f89c2efc0'),
(42, 'AQSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 36, 1, '6cf8d95ddb78ccdf8d9de5787df25bf7ce06f444'),
(43, 'PAAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 37, 1, 'e2753c0dd381aa8e322c5823b87246715f0dc060'),
(44, 'RGVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 38, 1, 'b1660f0f31350005baf98914d0d5275554cf72ed'),
(45, 'URSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 39, 1, 'bad1bac69e831854a32137434bea457d8bf15e8d'),
(46, 'RVLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 40, 1, '3b0be4cf91e8ca7a6bf0cb1ccc7fce8dd1efbc7e'),
(47, 'CQGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 41, 1, '6922dbdd15726b71396cf1fc4a6b7a4a694ba557'),
(48, 'KRElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 42, 1, 'bfa7258715d470906f24402e81fd34b9ee1d6d03'),
(49, 'AKPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 43, 1, 'bc2f2461931f7b92ca0fe015ab479a02e2c77893'),
(50, 'BQJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 44, 1, '327fc49df45a79d5f83982fb9de6939a2baa4c3e'),
(51, 'RFElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 4, 45, 1, '3da8d18607f525a50ea2a81301f6cffd22a5e18a'),
(52, 'YLPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 5, 46, 1, '6ca72b2d56a43b69d2a36015ddc3a9afd3cd65da'),
(53, 'MHLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 5, 47, 1, '2a42fe9165d0c92973361cf1cb82fbcd7ea033f8'),
(54, 'WUGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 6, 48, 1, '6396eaf3017b93bb943ff92a8457ba3ca0bb0f77'),
(55, 'FKElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 6, 49, 1, 'e030b9d9626f95d7611e82d86596ff53487de95d'),
(56, 'SFVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 6, 50, 1, '32921361e4f6784df4fffa4e6873244c1b593f04'),
(57, 'RMJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 51, 1, '586d13c437894d4dd227424c8957628f0fdd659d'),
(58, 'YNMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 52, 1, 'be81498f94f500e95e162042aa87719996858d44'),
(59, 'GYLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 53, 1, 'ab89cef930c73c0e3229533a5e2d1c7db49c93b0'),
(60, 'TLMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 54, 1, '00a53d1107a62dcfc0118cb902a239d898aff771'),
(61, 'VRAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 7, 55, 1, '63035e1eedf62bc6ec7dc2d2883c79905b4566a5'),
(62, 'TLLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 56, 1, 'b0354e6a406560c4d908bfcdf8e54f9c60af8d0b'),
(63, 'PMJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 57, 1, 'f838f041ad880a2133388dd4614c53c68876cd67'),
(64, 'VZElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 58, 1, 'fb06f086f84e68859a69cc577fcdfad4234036a8'),
(65, 'BGLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 59, 1, '243ca16e25d76ea5e43f8e4a091ec00d9817c475'),
(66, 'BHPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 60, 1, 'ef9d6e5e72102d519f665157d63b65bdc3a97c51'),
(67, 'VQLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 61, 1, '34cc8698deff73f14520b6fc9ab368775714e715'),
(68, 'GSLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 62, 1, '3bb385b774e62d8393cfe22a1b5320b559c05b8a'),
(69, 'XVVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 8, 63, 1, '47053c8e828c703d0d177fd842c3e51d3b6c3ace'),
(70, 'RBAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 64, 1, '2ed4bb7cbbde604f1103ed99a79661fa4dc5970a'),
(71, 'QSJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 65, 1, '8edddb912de75b9a2aab0622c016d89aa200afc3'),
(72, 'BKMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 66, 1, 'f8b901b612b1773298722239c9e14c65bb392333'),
(73, 'VAEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 67, 1, '9a44484af8c0027453edfef9683c9925c267af3d'),
(74, 'DFGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 68, 1, 'a860a542d1740dbae8be76d5df2b796a87d2f710'),
(75, 'PRAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 69, 1, '61e245ae9383325f330a99e780b3545c90bace5e'),
(76, 'MKLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 70, 1, 'cc0caf566902c6b0c443efcd7d2f3abf3a2d6eb4'),
(77, 'PZMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 71, 1, 'b749963a02a4a6aaf08e1683910cd4197ca807e7'),
(78, 'ISMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 72, 1, '86b7c4dda0ca72b3cee6ef17f091e5bcf0ec8e0f'),
(79, 'ZYLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 9, 73, 1, '777b7093930892ca5e80db0c725ab990e14816c6'),
(80, 'KCJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 74, 1, '99614e7df216a4252798af46c80c78c93f62a1a7'),
(81, 'MHPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 75, 1, '4cf61a3a11967d6045ff8d4ae113cc34fd66bc68'),
(82, 'MJNoemie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 76, 1, 'cb997adec08633c86490030b1a339aea95145f88'),
(83, 'NOEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 77, 1, '7e8c7b2bcd612106a5f05693adefc063a12be450'),
(84, 'CHAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 78, 1, '094b97d4b991af47232aa2ebc164e06b976136ee'),
(85, 'FBJacques', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 10, 79, 1, '2ee8ce28005baf5f6c5cecc5d754a4d5d28c2025'),
(86, 'UAClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 80, 1, '8f498a5bcc158b1a45916bc3b1ae1dcf2cedac31'),
(87, 'IDVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 81, 1, '3a091c8920df814a8a3105204b8bce4ea64acef9'),
(88, 'JRMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 82, 1, 'b3e1e38db7a05cd94d9691bc7fd0b0e84212fc9e'),
(89, 'HBGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 83, 1, '917049ccb8c569544b0d70ed3f67e7d9553a68e9'),
(90, 'MRPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 84, 1, '57178637bf7482b77044372302d6387b00237911'),
(91, 'LENoemie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 85, 1, 'ff48878ed03de2651758796aaec9c8acc45c2e28'),
(92, 'VZLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 86, 1, 'bd59cbe14f1b071fd27a248de6d41280e8225593'),
(93, 'PAGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 87, 1, 'eed9889e297f01a8175cccf65a013c80a0c4717d'),
(94, 'UEPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 88, 1, '6ca7507024e744e5f1250c9426e14c154db3b8fc'),
(95, 'UDVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 89, 1, 'b5753030bdf7e3a365d9cd996a194cdf2d392bfe'),
(96, 'BMJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 90, 1, '740c473d093eeff11dfae8d80870323838cd586c'),
(97, 'TKAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 91, 1, 'f0c9c6a3433b139933c9934baab2a7c1e6120568'),
(98, 'GZPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 11, 92, 1, '84bf448c4bffcd914b88c0e126712f3f5fd84ccc'),
(99, 'WUMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 12, 94, 1, '5c4bd9e335157302a1a50164a1ca3524224be7f5'),
(100, 'RSLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 12, 95, 1, 'cc0e8311c5f403742add82feb90a3fd042edbe15'),
(101, 'VSJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 12, 96, 1, '4ab17a07a1a8a3e1327109d3b35797eb32cc3dfe'),
(102, 'XGMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 97, 1, '945af46825799a1f8aa792da9d5d1f11ec7bcf5f'),
(103, 'BTClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 98, 1, '0a6934d625658c37ac7583afaaaa6f956cd218af'),
(104, 'GWLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 99, 1, '19ec6523e0f06d04fe30e4f68ed800950b904dc9'),
(105, 'SAPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 100, 1, 'ca204e4d47b50d7686233a908d6d87a29d15b3e7'),
(106, 'TIAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 101, 1, 'df049bed91c9e23668fc91161b70dd7abc66c53e'),
(107, 'DEJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 102, 1, '161bc3b7010548d7c4e393fd9877c796832ed94f'),
(108, 'HCLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 13, 103, 1, '9b659edeb9254201832b09003a30a239c7edf575'),
(109, 'LXAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 14, 104, 1, '758625fc801f74f635aee2b7686fec4bbfff3b07'),
(110, 'ARElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 14, 105, 1, '9f23acd47f8b41e77b00ed0e4d249b20512367a5'),
(111, 'SJElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 14, 106, 1, 'ec0fe72b636e8b6174e05874ccab3285faee79e6'),
(112, 'PVEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 14, 107, 1, '2569617c4c8ceeaa615093943027f1bffe181af6'),
(113, 'OYJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 15, 108, 1, '13a80f7a03fbe183bd0b10a036bec3f8877a6943'),
(114, 'TMAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 15, 109, 1, '132aa51698a47f845823674f9d470ade1637ddeb'),
(115, 'XDVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 16, 110, 1, '525adeb47776b30fa71f5a4be7ce027fdbf27cf1'),
(116, 'VAClaire', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 16, 111, 1, '967eefe0acb2cf88af9276b7c492bf872968f89d'),
(117, 'NSGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 16, 112, 1, '2ecfc6f9a249f4537de0d8fe61e4809d04cf2473'),
(118, 'IGElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 113, 1, 'b2458f60066ca7e578501faa1cdd6c43d26fb10c'),
(119, 'HNPaul', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 114, 1, '4150ff358b4d444c843813b8f74416f927da9908'),
(120, 'ETGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 115, 1, '5f6fc5ea0f804b4df04a6370c56a429825415d3d'),
(121, 'MDMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 116, 1, '5dbb1d730462bd7d58af9f3d688fe410edf79df6'),
(122, 'OSAlain', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 117, 1, '79138151d8cfa1330a137c3a1e7be6609b343248'),
(123, 'ZFGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 118, 1, '2c287763757531038752eff0375a98bfaacdd89e'),
(124, 'YUAlain', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 119, 1, '51c49666e56539321f3f433e0249584cfe48cde8'),
(125, 'SGJacques', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 17, 120, 1, 'e2b70410d57c38a607317aa58f0bfc621a3ca886'),
(126, 'GVJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 18, 121, 1, '0164daadea519fda18cef8f0865877516102581f'),
(127, 'OGMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 18, 122, 1, '536debb9dec3f84ee1f2640683566230682c4dd3'),
(128, 'XTGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 123, 1, '37925c3a77070673fc4ff63371dc6b3c9f9689ef'),
(129, 'IXAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 124, 1, '5efa5f5710a7e64f88891d599951a5708ab85f24'),
(130, 'SPAntoine', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 125, 1, 'c93783314a2783eaf31031cfeb954b98d9ed8091'),
(131, 'MUGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 126, 1, '67d2dd262572172bfa3d45f71d78b276404f0c81'),
(132, 'YFJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 127, 1, 'bbe8482688bd4f0368361164c52cf5151e200142'),
(133, 'NZLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 128, 1, '0024c0c81b9fde8d190ae54229c169caedef3596'),
(134, 'CYSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 129, 1, '2b53a846542da2b6190ee5d5243792a9ce985923'),
(135, 'ZJSophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 130, 1, '16ec07ae27f66651f7da430f033320bb73bdaebf'),
(136, 'CJEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 131, 1, 'f0b9fe9653fc809b7cac20c9164f82744e1b32d6'),
(137, 'LMVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 132, 1, '2ad0fefe41be2b9e2a6b6d30220fa2aee3de1344'),
(138, 'MILucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 19, 133, 1, '025674814ba353764e301304e419c8ccccb353a3'),
(139, 'OMElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 20, 135, 1, 'b9f4d862544524b201601fef3b6eb716853c574f'),
(140, 'EOMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 20, 136, 1, '30845c0016ac4261bba92ffad4a254dbdd92b1d3'),
(141, 'YNElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 21, 137, 1, '9c4e03cdea8ebcbd3df0d13e8558de5f6bb71e59'),
(142, 'SCJean', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 21, 138, 1, 'ca1378d631d22a7a783615959142e82ab16cee5d'),
(143, 'XZNoemie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 139, 1, 'ea85de772e5b2fd4bf3ecce8ea7586fe79e498f4'),
(144, 'HNMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 140, 1, 'f869484298dea48aa52b54afbc545d0de47b0c0b'),
(145, 'IXAlain', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 141, 1, 'c918dc5197126f372c7058097758a22877245dca'),
(146, 'MWGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 142, 1, '9cf6c9e12146920193b68ccb25302520b7b422e7'),
(147, 'FZEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 143, 1, '2679d911b658a84ed14ccb0d355bf61f6c81e43f'),
(148, 'RTLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 144, 1, 'd21098d600781a715a3ba2697e1d0b030d13d9a1'),
(149, 'ROLea', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 145, 1, '330b682418dd18e61b3a338ba2039ecbcac92ed5'),
(150, 'JGGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 146, 1, '40844c1062bced3dca2b5525b944ad3be3b535d4'),
(151, 'BRAnna', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 147, 1, 'b9322c4190ff393492e36953fcfb217421bed36c'),
(152, 'VYVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 148, 1, 'b47ce745200ad705c4ebdfc6460f0bf6ca3840c8'),
(153, 'LQJulie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 22, 149, 1, '4c27c391c61e5a114471e50e286d4699b6b19bc6'),
(154, 'CTMarc', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 23, 150, 1, '9ec493540bc04dc0d033a106c2f00335612864e6'),
(155, 'EHGerard', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 23, 151, 1, '6206b9985d6edc6909cc48172c361500cea47c08'),
(156, 'DWMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 23, 152, 1, '6d2bac7f79de304f78737be05bc76f654f10da8b'),
(157, 'XRLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 24, 153, 1, '3658f49c0217557a2e9531b16ce856498b464199'),
(158, 'SASophie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 24, 154, 1, 'bdf70f12d9a0cd2ec9f9b2736009c1e5fb6949f3'),
(159, 'ONEmma', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 155, 1, '6bedce8ba028f6e5c8127bdfb41386b89d38abdf'),
(160, 'SSMarie', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 156, 1, '41e775e945745cd1b52c33484d9efab2ad9c585d'),
(161, 'QAElise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 157, 1, 'a24fe94efe58327d7c5da2038714d9eda8fa0702'),
(162, 'APVictor', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 158, 1, '9492c47de9e22d2a72880be00fb4d9ec22884089'),
(163, 'XFLucas', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 159, 1, 'facb432128f9e1da9dba0c2c7364b0068d5ca247'),
(164, 'HNJules', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 25, 160, 1, 'c07af5f1ddf6d1335d5fec182a343d247dba46e5'),
(165, 'MGLouise', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 26, 161, 1, 'd3368ab53bc4a3fc25f120be8075f23ae0c0f116'),
(166, 'KVPierre', '7c222fb2927d828af22f592134e8932480637c0d', 1, 3, 26, 162, 1, 'c632b7b9ce068f465e7d556402437514633c1170');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `administrateur`
--
ALTER TABLE `administrateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_role` (`id_role`),
  ADD KEY `id_etat_utilisateur` (`id_etat_utilisateur`),
  ADD KEY `id_service_affecte` (`id_service_affecte`);

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
-- Index pour la table `dgda_categorie_nature_economique`
--
ALTER TABLE `dgda_categorie_nature_economique`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_nature_economique` (`id_type_nature_economique`);

--
-- Index pour la table `dgda_categorie_secteur_actvite`
--
ALTER TABLE `dgda_categorie_secteur_actvite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_secteur` (`id_type_secteur`);

--
-- Index pour la table `dgda_centre_perception`
--
ALTER TABLE `dgda_centre_perception`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_province` (`id_province`);

--
-- Index pour la table `dgda_nature_economique`
--
ALTER TABLE `dgda_nature_economique`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_secteur_activite` (`id_type_secteur_activite`),
  ADD KEY `id_categorie_secteur_activite` (`id_categorie_secteur_activite`),
  ADD KEY `id_secteur_activite` (`id_secteur_activite`),
  ADD KEY `id_type_nature_economique` (`id_type_nature_economique`),
  ADD KEY `id_categorie_nature_economique` (`id_categorie_nature_economique`);

--
-- Index pour la table `dgda_secteur_activite`
--
ALTER TABLE `dgda_secteur_activite`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_secteur` (`id_type_secteur`),
  ADD KEY `id_categorie_secteur` (`id_categorie_secteur`);

--
-- Index pour la table `dgda_statistique`
--
ALTER TABLE `dgda_statistique`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_province` (`id_province`),
  ADD KEY `id_centre_perception` (`id_centre_perception`),
  ADD KEY `id_type_secteur_activite` (`id_type_secteur_activite`),
  ADD KEY `id_categorie_secteur_activite` (`id_categorie_secteur_activite`),
  ADD KEY `id_secteur_activite` (`id_secteur_activite`),
  ADD KEY `id_type_nature_economique` (`id_type_nature_economique`),
  ADD KEY `id_categorie_nature_economique` (`id_categorie_nature_economique`),
  ADD KEY `id_mois` (`id_mois`),
  ADD KEY `id_etat_donnee` (`id_etat_donnee`),
  ADD KEY `id_ordre` (`id_ordre`);

--
-- Index pour la table `dgda_type_nature_economique`
--
ALTER TABLE `dgda_type_nature_economique`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `dgda_type_secteur_activite`
--
ALTER TABLE `dgda_type_secteur_activite`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `dgda_utilisateur`
--
ALTER TABLE `dgda_utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_centre_perception` (`id_centre_perception`),
  ADD KEY `id_province` (`id_province`),
  ADD KEY `id_role_utilisateur` (`id_role`),
  ADD KEY `id_etat_utilisateur` (`id_etat_utilisateur`),
  ADD KEY `id_service_pourvoyeur` (`id_service_pourvoyeur`);

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
-- Index pour la table `dgrad_acte_generateur`
--
ALTER TABLE `dgrad_acte_generateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categorie_acte_generateur` (`categorie_acte_generateur`),
  ADD KEY `id_service_assiette` (`id_service_assiette`),
  ADD KEY `id_categorie_recette` (`id_categorie_recette`),
  ADD KEY `id_type_recette` (`id_type_recette`);

--
-- Index pour la table `dgrad_categorie_acte_generateur`
--
ALTER TABLE `dgrad_categorie_acte_generateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_service_assiette` (`id_service_assiette`);

--
-- Index pour la table `dgrad_categorie_recette`
--
ALTER TABLE `dgrad_categorie_recette`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_recette` (`id_type_recette`);

--
-- Index pour la table `dgrad_servives_assiettes`
--
ALTER TABLE `dgrad_servives_assiettes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_recette` (`id_type_recette`),
  ADD KEY `id_categorie_recette` (`id_categorie_recette`);

--
-- Index pour la table `dgrad_statistique`
--
ALTER TABLE `dgrad_statistique`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type_recette` (`id_type_recette`),
  ADD KEY `id_categorie_recette` (`id_categorie_recette`),
  ADD KEY `id_service_assiette` (`id_service_assiette`),
  ADD KEY `id_categorie_acte` (`id_categorie_acte`),
  ADD KEY `id_province` (`id_province`),
  ADD KEY `id_etat_donnee` (`id_etat_donnee`);

--
-- Index pour la table `dgrad_type_recette`
--
ALTER TABLE `dgrad_type_recette`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `dgrad_utilisateur`
--
ALTER TABLE `dgrad_utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_province` (`id_province`),
  ADD KEY `id_service_pourvoyeur` (`id_service_pourvoyeur`),
  ADD KEY `id_role` (`id_role`),
  ADD KEY `id_etat_utilisateur` (`id_etat_utilisateur`);

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
-- Index pour la table `province_finale`
--
ALTER TABLE `province_finale`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `role_admin`
--
ALTER TABLE `role_admin`
  ADD PRIMARY KEY (`id`);

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
-- Index pour la table `statistiques_globales`
--
ALTER TABLE `statistiques_globales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_service_pourvoyeur` (`id_service_pourvoyeur`),
  ADD KEY `id_mois` (`id_mois`),
  ADD KEY `dgi_id_centre_perception` (`dgi_id_centre_perception`),
  ADD KEY `dgi_province` (`dgi_province`),
  ADD KEY `dgi_type_nature_recette` (`dgi_type_nature_recette`),
  ADD KEY `dgi_categorie_nature_recette` (`dgi_categorie_nature_recette`),
  ADD KEY `id_etat_donnee` (`id_etat_donnee`),
  ADD KEY `dgda_id_province` (`dgda_id_province`),
  ADD KEY `dgda_id_centre_perception` (`dgda_id_centre_perception`),
  ADD KEY `dgda_id_type_secteur_activite` (`dgda_id_type_secteur_activite`),
  ADD KEY `dgda_id_categorie_secteur_activite` (`dgda_id_categorie_secteur_activite`),
  ADD KEY `dgda_id_secteur_activite` (`dgda_id_secteur_activite`),
  ADD KEY `dgda_id_type_nature_economique` (`dgda_id_type_nature_economique`),
  ADD KEY `dgda_id_categorie_nature_economique` (`dgda_id_categorie_nature_economique`),
  ADD KEY `id_province_finale` (`id_province_finale`),
  ADD KEY `id_dgi_ordre` (`id_dgi_ordre`),
  ADD KEY `id_dgda_ordre` (`id_dgda_ordre`),
  ADD KEY `dgrad_id_categorie_recette` (`dgrad_id_categorie_recette`),
  ADD KEY `dgrad_id_type_recette` (`dgrad_id_type_recette`),
  ADD KEY `dgrad_id_service_assiette` (`dgrad_id_service_assiette`),
  ADD KEY `dgrad_id_categorie_acte` (`dgrad_id_categorie_acte`),
  ADD KEY `dgrad_id_province` (`dgrad_id_province`);

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
-- AUTO_INCREMENT pour la table `administrateur`
--
ALTER TABLE `administrateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
-- AUTO_INCREMENT pour la table `dgda_categorie_nature_economique`
--
ALTER TABLE `dgda_categorie_nature_economique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `dgda_categorie_secteur_actvite`
--
ALTER TABLE `dgda_categorie_secteur_actvite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `dgda_centre_perception`
--
ALTER TABLE `dgda_centre_perception`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `dgda_nature_economique`
--
ALTER TABLE `dgda_nature_economique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT pour la table `dgda_secteur_activite`
--
ALTER TABLE `dgda_secteur_activite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT pour la table `dgda_statistique`
--
ALTER TABLE `dgda_statistique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;

--
-- AUTO_INCREMENT pour la table `dgda_type_nature_economique`
--
ALTER TABLE `dgda_type_nature_economique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `dgda_type_secteur_activite`
--
ALTER TABLE `dgda_type_secteur_activite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `dgda_utilisateur`
--
ALTER TABLE `dgda_utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

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
-- AUTO_INCREMENT pour la table `dgrad_acte_generateur`
--
ALTER TABLE `dgrad_acte_generateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=482;

--
-- AUTO_INCREMENT pour la table `dgrad_categorie_acte_generateur`
--
ALTER TABLE `dgrad_categorie_acte_generateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT pour la table `dgrad_categorie_recette`
--
ALTER TABLE `dgrad_categorie_recette`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `dgrad_servives_assiettes`
--
ALTER TABLE `dgrad_servives_assiettes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT pour la table `dgrad_statistique`
--
ALTER TABLE `dgrad_statistique`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT pour la table `dgrad_type_recette`
--
ALTER TABLE `dgrad_type_recette`
  MODIFY `id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `dgrad_utilisateur`
--
ALTER TABLE `dgrad_utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT pour la table `province_finale`
--
ALTER TABLE `province_finale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT pour la table `role_admin`
--
ALTER TABLE `role_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `role_utilisateur`
--
ALTER TABLE `role_utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `service_pourvoyeur`
--
ALTER TABLE `service_pourvoyeur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `service_province`
--
ALTER TABLE `service_province`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `statistiques_globales`
--
ALTER TABLE `statistiques_globales`
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
-- Contraintes pour la table `administrateur`
--
ALTER TABLE `administrateur`
  ADD CONSTRAINT `administrateur_ibfk_1` FOREIGN KEY (`id_etat_utilisateur`) REFERENCES `etat_utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `administrateur_ibfk_2` FOREIGN KEY (`id_service_affecte`) REFERENCES `service_pourvoyeur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `administrateur_ibfk_3` FOREIGN KEY (`id_role`) REFERENCES `role_admin` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `affectation_province_utilisateur`
--
ALTER TABLE `affectation_province_utilisateur`
  ADD CONSTRAINT `affectation_province_utilisateur_ibfk_1` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `affectation_province_utilisateur_ibfk_2` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgda_categorie_nature_economique`
--
ALTER TABLE `dgda_categorie_nature_economique`
  ADD CONSTRAINT `dgda_categorie_nature_economique_ibfk_1` FOREIGN KEY (`id_type_nature_economique`) REFERENCES `dgda_type_nature_economique` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgda_categorie_secteur_actvite`
--
ALTER TABLE `dgda_categorie_secteur_actvite`
  ADD CONSTRAINT `dgda_categorie_secteur_actvite_ibfk_1` FOREIGN KEY (`id_type_secteur`) REFERENCES `dgda_type_secteur_activite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgda_centre_perception`
--
ALTER TABLE `dgda_centre_perception`
  ADD CONSTRAINT `dgda_centre_perception_ibfk_1` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgda_nature_economique`
--
ALTER TABLE `dgda_nature_economique`
  ADD CONSTRAINT `dgda_nature_economique_ibfk_1` FOREIGN KEY (`id_categorie_nature_economique`) REFERENCES `dgda_categorie_nature_economique` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_nature_economique_ibfk_2` FOREIGN KEY (`id_categorie_secteur_activite`) REFERENCES `dgda_categorie_secteur_actvite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_nature_economique_ibfk_3` FOREIGN KEY (`id_secteur_activite`) REFERENCES `dgda_secteur_activite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_nature_economique_ibfk_4` FOREIGN KEY (`id_type_nature_economique`) REFERENCES `dgda_type_nature_economique` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_nature_economique_ibfk_5` FOREIGN KEY (`id_type_secteur_activite`) REFERENCES `dgda_type_secteur_activite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgda_secteur_activite`
--
ALTER TABLE `dgda_secteur_activite`
  ADD CONSTRAINT `dgda_secteur_activite_ibfk_1` FOREIGN KEY (`id_categorie_secteur`) REFERENCES `dgda_categorie_secteur_actvite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_secteur_activite_ibfk_2` FOREIGN KEY (`id_type_secteur`) REFERENCES `dgda_type_secteur_activite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgda_statistique`
--
ALTER TABLE `dgda_statistique`
  ADD CONSTRAINT `dgda_statistique_ibfk_1` FOREIGN KEY (`id_categorie_nature_economique`) REFERENCES `dgda_categorie_nature_economique` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_statistique_ibfk_10` FOREIGN KEY (`id_ordre`) REFERENCES `dgda_nature_economique` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_statistique_ibfk_2` FOREIGN KEY (`id_categorie_secteur_activite`) REFERENCES `dgda_categorie_secteur_actvite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_statistique_ibfk_3` FOREIGN KEY (`id_centre_perception`) REFERENCES `dgda_centre_perception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_statistique_ibfk_4` FOREIGN KEY (`id_etat_donnee`) REFERENCES `etat_donnee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_statistique_ibfk_5` FOREIGN KEY (`id_mois`) REFERENCES `mois` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_statistique_ibfk_6` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_statistique_ibfk_7` FOREIGN KEY (`id_secteur_activite`) REFERENCES `dgda_secteur_activite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_statistique_ibfk_8` FOREIGN KEY (`id_type_nature_economique`) REFERENCES `dgda_type_nature_economique` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_statistique_ibfk_9` FOREIGN KEY (`id_type_secteur_activite`) REFERENCES `dgda_type_secteur_activite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgda_utilisateur`
--
ALTER TABLE `dgda_utilisateur`
  ADD CONSTRAINT `dgda_utilisateur_ibfk_1` FOREIGN KEY (`id_centre_perception`) REFERENCES `dgda_centre_perception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_utilisateur_ibfk_2` FOREIGN KEY (`id_etat_utilisateur`) REFERENCES `etat_utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_utilisateur_ibfk_3` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_utilisateur_ibfk_4` FOREIGN KEY (`id_role`) REFERENCES `role_utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgda_utilisateur_ibfk_5` FOREIGN KEY (`id_service_pourvoyeur`) REFERENCES `service_pourvoyeur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Contraintes pour la table `dgrad_acte_generateur`
--
ALTER TABLE `dgrad_acte_generateur`
  ADD CONSTRAINT `dgrad_acte_generateur_ibfk_1` FOREIGN KEY (`categorie_acte_generateur`) REFERENCES `dgrad_categorie_acte_generateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_acte_generateur_ibfk_2` FOREIGN KEY (`id_categorie_recette`) REFERENCES `dgrad_categorie_recette` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_acte_generateur_ibfk_3` FOREIGN KEY (`id_service_assiette`) REFERENCES `dgrad_servives_assiettes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_acte_generateur_ibfk_4` FOREIGN KEY (`id_type_recette`) REFERENCES `dgrad_type_recette` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgrad_categorie_acte_generateur`
--
ALTER TABLE `dgrad_categorie_acte_generateur`
  ADD CONSTRAINT `dgrad_categorie_acte_generateur_ibfk_1` FOREIGN KEY (`id_service_assiette`) REFERENCES `dgrad_servives_assiettes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgrad_categorie_recette`
--
ALTER TABLE `dgrad_categorie_recette`
  ADD CONSTRAINT `dgrad_categorie_recette_ibfk_1` FOREIGN KEY (`id_type_recette`) REFERENCES `dgrad_type_recette` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgrad_servives_assiettes`
--
ALTER TABLE `dgrad_servives_assiettes`
  ADD CONSTRAINT `dgrad_servives_assiettes_ibfk_1` FOREIGN KEY (`id_categorie_recette`) REFERENCES `dgrad_categorie_recette` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_servives_assiettes_ibfk_2` FOREIGN KEY (`id_type_recette`) REFERENCES `dgrad_type_recette` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgrad_statistique`
--
ALTER TABLE `dgrad_statistique`
  ADD CONSTRAINT `dgrad_statistique_ibfk_1` FOREIGN KEY (`id_categorie_acte`) REFERENCES `dgrad_categorie_acte_generateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_statistique_ibfk_2` FOREIGN KEY (`id_etat_donnee`) REFERENCES `etat_donnee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_statistique_ibfk_3` FOREIGN KEY (`id_categorie_recette`) REFERENCES `dgrad_categorie_recette` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_statistique_ibfk_4` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_statistique_ibfk_5` FOREIGN KEY (`id_service_assiette`) REFERENCES `dgrad_servives_assiettes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_statistique_ibfk_6` FOREIGN KEY (`id_type_recette`) REFERENCES `dgrad_type_recette` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `dgrad_utilisateur`
--
ALTER TABLE `dgrad_utilisateur`
  ADD CONSTRAINT `dgrad_utilisateur_ibfk_1` FOREIGN KEY (`id_etat_utilisateur`) REFERENCES `etat_utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_utilisateur_ibfk_2` FOREIGN KEY (`id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_utilisateur_ibfk_3` FOREIGN KEY (`id_role`) REFERENCES `role_utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `dgrad_utilisateur_ibfk_4` FOREIGN KEY (`id_service_pourvoyeur`) REFERENCES `service_pourvoyeur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Contraintes pour la table `statistiques_globales`
--
ALTER TABLE `statistiques_globales`
  ADD CONSTRAINT `statistiques_globales_ibfk_1` FOREIGN KEY (`dgda_id_categorie_nature_economique`) REFERENCES `dgda_categorie_nature_economique` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_10` FOREIGN KEY (`dgi_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_11` FOREIGN KEY (`dgi_type_nature_recette`) REFERENCES `dgi_type_nature_impot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_12` FOREIGN KEY (`id_etat_donnee`) REFERENCES `etat_donnee` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_13` FOREIGN KEY (`id_mois`) REFERENCES `mois` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_14` FOREIGN KEY (`id_province_finale`) REFERENCES `province_finale` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_15` FOREIGN KEY (`id_service_pourvoyeur`) REFERENCES `service_pourvoyeur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_16` FOREIGN KEY (`dgrad_id_categorie_acte`) REFERENCES `dgrad_categorie_acte_generateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_17` FOREIGN KEY (`dgrad_id_categorie_recette`) REFERENCES `dgrad_categorie_recette` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_18` FOREIGN KEY (`dgrad_id_service_assiette`) REFERENCES `dgrad_servives_assiettes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_19` FOREIGN KEY (`dgrad_id_type_recette`) REFERENCES `dgrad_type_recette` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_2` FOREIGN KEY (`dgda_id_categorie_secteur_activite`) REFERENCES `dgda_categorie_secteur_actvite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_20` FOREIGN KEY (`dgrad_id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_3` FOREIGN KEY (`dgda_id_centre_perception`) REFERENCES `dgda_centre_perception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_4` FOREIGN KEY (`dgda_id_province`) REFERENCES `province` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_5` FOREIGN KEY (`dgda_id_secteur_activite`) REFERENCES `dgda_secteur_activite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_6` FOREIGN KEY (`dgda_id_type_nature_economique`) REFERENCES `dgda_type_nature_economique` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_7` FOREIGN KEY (`dgda_id_type_secteur_activite`) REFERENCES `dgda_type_secteur_activite` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_8` FOREIGN KEY (`dgi_categorie_nature_recette`) REFERENCES `dgi_categorie_nature_impot` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `statistiques_globales_ibfk_9` FOREIGN KEY (`dgi_id_centre_perception`) REFERENCES `dgi_centre_perception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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

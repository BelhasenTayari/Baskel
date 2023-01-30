-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2023 at 11:50 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `baskel`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_agence`
--

CREATE TABLE `admin_agence` (
  `id_agence` varchar(8) NOT NULL,
  `cin` varchar(8) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tel` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `agence`
--

CREATE TABLE `agence` (
  `id_agence` varchar(8) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `description` varchar(150) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `website` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `agence`
--

INSERT INTO `agence` (`id_agence`, `nom`, `adresse`, `description`, `photo`, `email`, `website`) VALUES
('2001', 'Agence 1', 'adresse 1', 'Description 1', 'photo1.jpg', 'email 1', 'website 1'),
('2002', 'Agence 2', 'adresse 2', 'Description 2', 'photo2.jpg', 'email 2', 'website 2'),
('2003', 'Agence 3', 'adresse 3', 'Description 3', 'photo3.jpg', 'email 3', 'website 3');

-- --------------------------------------------------------

--
-- Table structure for table `authentification`
--

CREATE TABLE `authentification` (
  `login` varchar(200) NOT NULL,
  `password` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `authentification`
--

INSERT INTO `authentification` (`login`, `password`) VALUES
('belhassentayari09@gmail.com', '123qwe');

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `email` varchar(200) NOT NULL,
  `cin` varchar(8) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL,
  `tel` varchar(10) NOT NULL,
  `adresse` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`email`, `cin`, `nom`, `prenom`, `image`, `tel`, `adresse`) VALUES
('belhassentayari09@gmail.com', '09643569', 'belhassen', 'tayari', 'belha.jpg', '20324541', 'Stah jabeur, monastir');

-- --------------------------------------------------------

--
-- Table structure for table `evenement`
--

CREATE TABLE `evenement` (
  `id` varchar(8) NOT NULL,
  `id_organization` varchar(8) NOT NULL,
  `id_piste` int(11) NOT NULL,
  `date` date NOT NULL,
  `heure` varchar(6) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `description` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `forum`
--

CREATE TABLE `forum` (
  `id` varchar(8) NOT NULL,
  `nom` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `liked_agencies`
--

CREATE TABLE `liked_agencies` (
  `email` varchar(200) NOT NULL,
  `id` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `liked_agencies`
--

INSERT INTO `liked_agencies` (`email`, `id`) VALUES
('belhassentayari09@gmail.com', '2001'),
('belhassentayari09@gmail.com', '2002'),
('belhassentayari09@gmail.com', '2003');

-- --------------------------------------------------------

--
-- Table structure for table `liked_bikes`
--

CREATE TABLE `liked_bikes` (
  `email` varchar(200) NOT NULL,
  `id` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `liked_bikes`
--

INSERT INTO `liked_bikes` (`email`, `id`) VALUES
('belhassentayari09@gmail.com', 'XAB21'),
('belhassentayari09@gmail.com', 'XAB24');

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `email` varchar(200) NOT NULL,
  `id_vehicule` varchar(8) NOT NULL,
  `id_agence` varchar(8) NOT NULL,
  `date` date NOT NULL,
  `periode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id` int(8) NOT NULL,
  `id_forum` varchar(8) NOT NULL,
  `id_client` varchar(8) NOT NULL,
  `date` date NOT NULL,
  `heure` varchar(6) NOT NULL,
  `content` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `organization`
--

CREATE TABLE `organization` (
  `id` varchar(8) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `description` varchar(150) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `photo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `piste_cyclable`
--

CREATE TABLE `piste_cyclable` (
  `id` int(11) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `ville` varchar(20) NOT NULL,
  `description` varchar(150) NOT NULL,
  `centerlat` varchar(100) NOT NULL,
  `startlat` varchar(100) NOT NULL,
  `endlat` varchar(100) NOT NULL,
  `startlag` varchar(100) NOT NULL,
  `endlag` varchar(100) NOT NULL,
  `centerlag` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `piste_cyclable`
--

INSERT INTO `piste_cyclable` (`id`, `nom`, `ville`, `description`, `centerlat`, `startlat`, `endlat`, `startlag`, `endlag`, `centerlag`) VALUES
(5, 'Bourgiba', 'Monastir', 'Cette piste est créer par le fameux elhabib bourgiba', '35.76898725779185', '35.76459737760868', '35.77271977581136', '10.84073978652491', '10.830883131202585', '10.83553161737524'),
(6, 'Qaraiya', 'Monastir', 'Ce Piste est le plus longue piste a cycler dans monastir, elle à une belle vue sur mer', '35.77681168853714', '35.77531414366615', '35.780568563100736', '10.835997504787002', '10.802319023132148', '10.818316301699666'),
(7, 'Falaise', 'Monastir', 'avec ce piste, vous devez explorer la beauté de la ville de monastir a partir du falaise', '35.774736136213704', '35.78146177980617', '35.765986693856725', '10.816405695359872', '10.804132479231662', '10.810317661734668'),
(8, 'Jardin-Bora', 'Monastir', 'explorer la ville de monastir a partir de la souk vers la jardin de \"BO RA\"', '35.75736913731421', '35.75725528194401', '35.75953235694001', '10.830064407727559', '10.798262537691016', '10.814266360933289'),
(9, 'Corniche', 'Mahdia', 'Le corniche de MAHDIA est une place incroyable est à éxplorer. ', '35.51312496005796', '35.50667521822766', '35.52170559280356', '11.063208099620276', '11.04272820830582', '11.049745088898227');

-- --------------------------------------------------------

--
-- Table structure for table `vehicule`
--

CREATE TABLE `vehicule` (
  `id_agence` varchar(8) NOT NULL,
  `id` varchar(8) NOT NULL,
  `type` enum('bike','scooter') NOT NULL,
  `marque` varchar(20) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `prix` double(5,3) NOT NULL,
  `couleur` varchar(20) NOT NULL,
  `rate` double(5,3) NOT NULL,
  `speed` double(5,3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `vehicule`
--

INSERT INTO `vehicule` (`id_agence`, `id`, `type`, `marque`, `nom`, `image`, `description`, `prix`, `couleur`, `rate`, `speed`) VALUES
('2001', 'XAB21', 'bike', 'marque 1', 'nom 1', 'bike1.png', 'description 1', 70.000, 'Rouge', 4.500, 99.999),
('2001', 'XAB22', 'bike', 'marque 2', 'nom 2', 'bike2.png', 'description 2', 99.999, 'Vert', 2.600, 99.999),
('2001', 'XAB23', 'bike', 'marque 3', 'nom 3', 'bike3.png', 'description 3', 60.000, 'Noire', 2.800, 40.000),
('2002', 'XAB24', 'bike', 'marque 4', 'nom 4', 'bike4.png', 'description 4', 80.000, 'Beige', 5.000, 50.000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_agence`
--
ALTER TABLE `admin_agence`
  ADD PRIMARY KEY (`id_agence`,`cin`);

--
-- Indexes for table `agence`
--
ALTER TABLE `agence`
  ADD PRIMARY KEY (`id_agence`);

--
-- Indexes for table `authentification`
--
ALTER TABLE `authentification`
  ADD PRIMARY KEY (`login`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `evenement`
--
ALTER TABLE `evenement`
  ADD PRIMARY KEY (`id`,`id_organization`,`id_piste`,`date`),
  ADD KEY `id_piste` (`id_piste`),
  ADD KEY `id_organization` (`id_organization`);

--
-- Indexes for table `forum`
--
ALTER TABLE `forum`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `liked_agencies`
--
ALTER TABLE `liked_agencies`
  ADD PRIMARY KEY (`email`,`id`),
  ADD KEY `liked_agencies_ibfk_2` (`id`);

--
-- Indexes for table `liked_bikes`
--
ALTER TABLE `liked_bikes`
  ADD PRIMARY KEY (`email`,`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`email`,`id_vehicule`,`id_agence`,`date`),
  ADD KEY `id_agence` (`id_agence`),
  ADD KEY `id_vehicule` (`id_vehicule`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_client` (`id_client`),
  ADD KEY `id_forum` (`id_forum`);

--
-- Indexes for table `organization`
--
ALTER TABLE `organization`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `piste_cyclable`
--
ALTER TABLE `piste_cyclable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicule`
--
ALTER TABLE `vehicule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vehicule_ibfk_1` (`id_agence`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `piste_cyclable`
--
ALTER TABLE `piste_cyclable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_agence`
--
ALTER TABLE `admin_agence`
  ADD CONSTRAINT `admin_agence_ibfk_1` FOREIGN KEY (`id_agence`) REFERENCES `agence` (`id_agence`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `authentification`
--
ALTER TABLE `authentification`
  ADD CONSTRAINT `authentification_ibfk_1` FOREIGN KEY (`login`) REFERENCES `client` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `evenement`
--
ALTER TABLE `evenement`
  ADD CONSTRAINT `evenement_ibfk_2` FOREIGN KEY (`id_organization`) REFERENCES `organization` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evenement_ibfk_3` FOREIGN KEY (`id_piste`) REFERENCES `piste_cyclable` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `liked_agencies`
--
ALTER TABLE `liked_agencies`
  ADD CONSTRAINT `liked_agencies_ibfk_1` FOREIGN KEY (`email`) REFERENCES `client` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `liked_agencies_ibfk_2` FOREIGN KEY (`id`) REFERENCES `agence` (`id_agence`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `liked_bikes`
--
ALTER TABLE `liked_bikes`
  ADD CONSTRAINT `liked_bikes_ibfk_1` FOREIGN KEY (`email`) REFERENCES `client` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `liked_bikes_ibfk_2` FOREIGN KEY (`id`) REFERENCES `vehicule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `location_ibfk_2` FOREIGN KEY (`id_agence`) REFERENCES `agence` (`id_agence`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `location_ibfk_3` FOREIGN KEY (`id_vehicule`) REFERENCES `vehicule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `location_ibfk_4` FOREIGN KEY (`email`) REFERENCES `client` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `client` (`cin`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `message_ibfk_2` FOREIGN KEY (`id_forum`) REFERENCES `forum` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `vehicule`
--
ALTER TABLE `vehicule`
  ADD CONSTRAINT `vehicule_ibfk_1` FOREIGN KEY (`id_agence`) REFERENCES `agence` (`id_agence`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 10, 2025 at 02:23 PM
-- Server version: 9.0.1
-- PHP Version: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bowlingcentrebrooklyn`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `SP_GetCustomersAndContacts`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_GetCustomersAndContacts` (IN `givLIMIT` INT, IN `givOFFSET` INT)   BEGIN
    SELECT 
        CUST.Id AS CustomerId,
        CUST.Name AS CustomerName,
        CUST.Email AS CustomerEmail,
        CUST.Phone AS CustomerPhone,
        CUST.Isactive AS CustomerIsActive,
        CUST.DateCreated AS CustomerDateCreated,
        CUST.DateChanged AS CustomerDateChanged,
        CNT.Id AS ContactId,
        CNT.Firstname AS ContactFirstname,
        CNT.Infix AS ContactInfix,
        CNT.Lastname AS ContactLastname,
        CONCAT_WS(" ", CNT.Firstname, CNT.Infix, CNT.Lastname) AS ContactFullname,
        CNT.Email AS ContactEmail,
        CNT.Phone AS ContactPhone,
        CNT.Isactive AS ContactIsActive,
        CNT.Note AS ContactNote,
        CNT.DateCreated AS ContactDateCreated,
        CNT.DateChanged AS ContactDateChanged

    FROM
        customers AS CUST 
        LEFT JOIN 
        Users AS USR ON CUST.UserId = USR.Id
        LEFT JOIN 
            contacts AS CNT ON CNT.Id = USR.ContactId
    LIMIT 
        givLIMIT OFFSET givOFFSET;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bowlinglanes`
--

DROP TABLE IF EXISTS `bowlinglanes`;
CREATE TABLE IF NOT EXISTS `bowlinglanes` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `LaneNr` int NOT NULL,
  `LaneType` varchar(20) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
CREATE TABLE IF NOT EXISTS `contacts` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `Infix` varchar(10) DEFAULT NULL,
  `LastName` varchar(50) NOT NULL,
  `FullName` varchar(110) GENERATED ALWAYS AS (concat_ws(_utf8mb4' ',`FirstName`,`Infix`,`LastName`)) STORED,
  `Phone` varchar(10) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`Id`, `FirstName`, `Infix`, `LastName`, `Phone`, `Email`, `IsActief`, `Opmerking`, `created_at`, `updated_at`) VALUES
(1, 'Laney', NULL, 'Beatty', '999999999', 'cassidy39@hansen.net', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(2, 'Keyshawn', NULL, 'Keebler', '999999999', 'samson15@lang.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(3, 'Dangelo', NULL, 'Strosin', '1000000000', 'leanne53@lindgren.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(4, 'Lester', NULL, 'Denesik', '999999999', 'dbecker@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(5, 'Sabryna', NULL, 'Considine', '999999999', 'maltenwerth@zboncak.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(6, 'Raul', NULL, 'Pfannerstill', '999999999', 'esmeralda.rutherford@jacobs.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(7, 'Carlie', NULL, 'Hintz', '999999999', 'tkuphal@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(8, 'Walker', NULL, 'Bednar', '999999999', 'joseph.koelpin@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(9, 'Alessandra', NULL, 'Wolf', '999999999', 'lori.okon@moore.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(10, 'Stefanie', NULL, 'Collins', '999999999', 'ole77@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(11, 'Christiana', NULL, 'Zboncak', '999999999', 'miller.luna@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(12, 'Weston', NULL, 'Little', '1000000000', 'heathcote.malvina@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(13, 'Cheyenne', NULL, 'Kassulke', '999999999', 'helena69@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(14, 'Claudia', NULL, 'Mosciski', '1000000000', 'zherman@beer.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(15, 'Melody', NULL, 'Keeling', '999999999', 'thelma.howe@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(16, 'Gregg', NULL, 'Kozey', '999999999', 'bleuschke@nitzsche.net', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(17, 'Derick', NULL, 'Gulgowski', '999999999', 'lrogahn@reilly.info', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(18, 'Shirley', NULL, 'Yundt', '999999999', 'kohler.rosalee@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(19, 'Alford', NULL, 'Borer', '999999999', 'jarrell77@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(20, 'Eunice', NULL, 'Gerlach', '999999999', 'von.garnett@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(21, 'Ona', NULL, 'Denesik', '1000000000', 'schulist.moses@jakubowski.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(22, 'Clement', NULL, 'Hudson', '999999999', 'eunice.tromp@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(23, 'Frederic', NULL, 'Williamson', '1000000000', 'carleton.price@nikolaus.biz', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(24, 'Trenton', NULL, 'Simonis', '999999999', 'sophie.konopelski@mckenzie.biz', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(25, 'Cleta', NULL, 'O\'Connell', '1000000000', 'jedidiah72@hotmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(26, 'Tanya', NULL, 'Kuhn', '999999999', 'schumm.megane@hotmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(27, 'Camryn', NULL, 'Carroll', '999999999', 'lionel40@hotmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(28, 'Candice', NULL, 'Jast', '999999999', 'leffler.maudie@kohler.org', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(29, 'Magdalena', NULL, 'Dare', '999999999', 'mireya.halvorson@reichel.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(30, 'Aylin', NULL, 'Ondricka', '999999999', 'reynold.mante@hotmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(31, 'Dameon', NULL, 'Satterfield', '1000000000', 'ashtyn.mueller@collins.info', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(32, 'Leland', NULL, 'Hickle', '999999999', 'ywiegand@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(33, 'Minnie', NULL, 'Connelly', '999999999', 'bzemlak@dare.biz', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(34, 'Madaline', NULL, 'Gutmann', '1000000000', 'hmurazik@towne.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(35, 'Flavio', NULL, 'Rice', '999999999', 'swift.kennith@pacocha.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(36, 'Eleonore', NULL, 'Fahey', '999999999', 'goyette.susan@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(37, 'Shannon', NULL, 'Reilly', '1000000000', 'pchristiansen@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(38, 'Marianne', NULL, 'Leannon', '999999999', 'schmitt.josephine@goyette.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(39, 'Dayana', NULL, 'Smith', '999999999', 'marcellus71@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(40, 'Coy', NULL, 'Harber', '1000000000', 'jerel46@hotmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(41, 'Felicia', NULL, 'Smitham', '999999999', 'lou.kohler@feil.net', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(42, 'Constantin', NULL, 'McCullough', '999999999', 'quigley.carleton@dubuque.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(43, 'Edgar', NULL, 'Windler', '999999999', 'okuneva.kameron@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(44, 'Dawson', NULL, 'Kertzmann', '999999999', 'hills.tiffany@orn.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(45, 'Aileen', NULL, 'Gleichner', '1000000000', 'prosacco.jamison@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(46, 'Hoyt', NULL, 'Wilkinson', '1000000000', 'pgrant@hotmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(47, 'Gwen', NULL, 'Ankunding', '1000000000', 'imani.erdman@yahoo.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(48, 'Maxie', NULL, 'Block', '999999999', 'dlindgren@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(49, 'Sabryna', NULL, 'Daugherty', '999999999', 'mklocko@gmail.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(50, 'Verdie', NULL, 'Jacobson', '999999999', 'demario.dubuque@hayes.com', b'1', NULL, '2025-04-10 14:13:39.000000', '2025-04-10 14:13:39.000000'),
(51, 'Ned', NULL, 'Heaney', '999999999', 'bartholome64@schuppe.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(52, 'Aubree', NULL, 'Bernhard', '1000000000', 'elna.stehr@douglas.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(53, 'Arely', NULL, 'Tillman', '1000000000', 'qmetz@wintheiser.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(54, 'Dorothea', NULL, 'Stroman', '999999999', 'deborah88@paucek.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(55, 'Gaetano', NULL, 'Windler', '999999999', 'imani.crooks@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(56, 'Clemens', NULL, 'Gislason', '1000000000', 'nash61@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(57, 'Walton', NULL, 'Hane', '999999999', 'eliane41@wyman.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(58, 'Randy', NULL, 'Klocko', '1000000000', 'nicklaus.kovacek@gottlieb.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(59, 'Harmon', NULL, 'Gusikowski', '999999999', 'mara94@oreilly.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(60, 'Jerald', NULL, 'O\'Hara', '999999999', 'xbotsford@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(61, 'Afton', NULL, 'Mohr', '1000000000', 'brakus.alexandrine@harris.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(62, 'Liliana', NULL, 'Windler', '1000000000', 'xhessel@hegmann.info', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(63, 'Dax', NULL, 'Dach', '1000000000', 'celestine.adams@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(64, 'Nick', NULL, 'Satterfield', '999999999', 'andreanne.oconner@mcclure.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(65, 'Tyler', NULL, 'Moore', '1000000000', 'ayla12@blick.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(66, 'Yoshiko', NULL, 'Walker', '1000000000', 'dorris22@kuhic.info', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(67, 'Vince', NULL, 'Spinka', '999999999', 'audie53@harris.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(68, 'Leone', NULL, 'Watsica', '999999999', 'paucek.ara@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(69, 'Abby', NULL, 'Ondricka', '1000000000', 'keegan.altenwerth@beatty.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(70, 'Justyn', NULL, 'Jenkins', '1000000000', 'hferry@wunsch.biz', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(71, 'Breanne', NULL, 'Ankunding', '999999999', 'isaias.oconner@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(72, 'Nakia', NULL, 'Adams', '1000000000', 'corkery.rosemarie@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(73, 'Zachery', NULL, 'Johns', '999999999', 'sarah.ledner@schumm.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(74, 'Nicolette', NULL, 'Gerhold', '999999999', 'zemlak.natalie@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(75, 'Napoleon', NULL, 'Monahan', '999999999', 'little.clarabelle@hayes.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(76, 'Marques', NULL, 'Schoen', '1000000000', 'cmedhurst@weissnat.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(77, 'Alana', NULL, 'Welch', '1000000000', 'mara.dietrich@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(78, 'Willard', NULL, 'Lakin', '999999999', 'eloy72@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(79, 'Amaya', NULL, 'Lynch', '1000000000', 'sschroeder@dach.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(80, 'Danika', NULL, 'Cassin', '999999999', 'dedrick75@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(81, 'Dortha', NULL, 'Gottlieb', '999999999', 'marcellus.koelpin@dooley.info', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(82, 'Grover', NULL, 'Lehner', '999999999', 'fgrimes@lang.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(83, 'Luisa', NULL, 'Schiller', '999999999', 'triston82@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(84, 'Callie', NULL, 'Hills', '1000000000', 'kirlin.mellie@aufderhar.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(85, 'Liliana', NULL, 'Kunze', '1000000000', 'lilly22@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(86, 'Jasmin', NULL, 'Watsica', '999999999', 'jruecker@monahan.org', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(87, 'Angela', NULL, 'Fritsch', '1000000000', 'labadie.eladio@nienow.net', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(88, 'Josh', NULL, 'Mayert', '1000000000', 'homenick.jude@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(89, 'Brayan', NULL, 'Nicolas', '999999999', 'bdibbert@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(90, 'Graham', NULL, 'Roberts', '1000000000', 'gottlieb.june@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(91, 'Gussie', NULL, 'Koepp', '999999999', 'trogahn@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(92, 'Muriel', NULL, 'Gaylord', '1000000000', 'mbrakus@kshlerin.info', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(93, 'Friedrich', NULL, 'Heathcote', '1000000000', 'mosciski.sam@runte.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(94, 'Randal', NULL, 'Green', '1000000000', 'bernhard.jordi@schumm.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(95, 'Jessica', NULL, 'Schimmel', '1000000000', 'luettgen.van@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(96, 'Yesenia', NULL, 'Streich', '999999999', 'kenny60@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(97, 'Freddy', NULL, 'Ruecker', '999999999', 'tillman.zaria@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(98, 'Carole', NULL, 'Hackett', '999999999', 'horn@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(99, 'Henri', NULL, 'Daugherty', '1000000000', 'golda34@schultz.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(100, 'Ellis', NULL, 'Hayes', '999999999', 'alana.leannon@homenick.biz', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(101, 'Kian', NULL, 'Nitzsche', '999999999', 'barrows.gretchen@crist.net', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(102, 'Darlene', NULL, 'Schimmel', '1000000000', 'rgutkowski@schroeder.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(103, 'Reymundo', NULL, 'Rolfson', '1000000000', 'kilback.georgette@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(104, 'Alfonzo', NULL, 'Hackett', '1000000000', 'janie86@trantow.biz', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(105, 'Eleonore', NULL, 'McCullough', '999999999', 'arely.shields@deckow.biz', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(106, 'Aglae', NULL, 'Hamill', '999999999', 'bethany67@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(107, 'Asia', NULL, 'Simonis', '999999999', 'jcremin@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(108, 'Enrico', NULL, 'Schamberger', '999999999', 'kaelyn72@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(109, 'Otho', NULL, 'Bosco', '999999999', 'geovanni57@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(110, 'Grayce', NULL, 'McClure', '1000000000', 'douglas.kailee@roob.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(111, 'Durward', NULL, 'Yundt', '999999999', 'stan.considine@muller.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(112, 'Guadalupe', NULL, 'Koch', '1000000000', 'sweber@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(113, 'Brook', NULL, 'Steuber', '1000000000', 'lakin.elisa@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(114, 'Reuben', NULL, 'Jaskolski', '1000000000', 'toni70@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(115, 'Ole', NULL, 'White', '999999999', 'jayme.weimann@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(116, 'Webster', NULL, 'Macejkovic', '999999999', 'aufderhar.audreanne@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(117, 'Jakob', NULL, 'Kuhn', '1000000000', 'barton.lauren@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(118, 'Americo', NULL, 'Bosco', '999999999', 'dana89@stehr.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(119, 'Deion', NULL, 'Gusikowski', '999999999', 'lbergstrom@mcclure.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(120, 'Brigitte', NULL, 'Welch', '1000000000', 'beatrice77@bailey.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(121, 'Verdie', NULL, 'Schultz', '1000000000', 'bmonahan@jacobson.biz', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(122, 'Pearl', NULL, 'Powlowski', '999999999', 'halvorson.zakary@carter.org', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(123, 'Martine', NULL, 'Jones', '999999999', 'littel.ettie@price.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(124, 'Timothy', NULL, 'Hoppe', '1000000000', 'keshawn23@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(125, 'Margarita', NULL, 'Hickle', '1000000000', 'clifford.gorczany@reichel.net', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(126, 'Alanis', NULL, 'Romaguera', '1000000000', 'gulgowski.tressa@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(127, 'Coralie', NULL, 'Torp', '999999999', 'gleichner.aniya@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(128, 'Garrick', NULL, 'Hickle', '1000000000', 'lfadel@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(129, 'Jaquan', NULL, 'Considine', '999999999', 'quitzon.sienna@friesen.org', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(130, 'Bobbie', NULL, 'Reichel', '1000000000', 'abdiel53@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(131, 'Chase', NULL, 'Hansen', '999999999', 'tess44@legros.org', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(132, 'Wilma', NULL, 'Moore', '999999999', 'name.murray@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(133, 'Dora', NULL, 'Miller', '1000000000', 'hertha51@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(134, 'Chauncey', NULL, 'Stamm', '1000000000', 'marjolaine.quigley@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(135, 'Hollis', NULL, 'Hackett', '999999999', 'ankunding.jasen@jacobson.info', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(136, 'Chloe', NULL, 'Larkin', '1000000000', 'joshua.kerluke@johnson.info', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(137, 'Ansley', NULL, 'Hackett', '1000000000', 'pschamberger@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(138, 'Enos', NULL, 'Jones', '999999999', 'taurean53@dibbert.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(139, 'Samir', NULL, 'Hermann', '1000000000', 'vince18@fadel.org', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(140, 'Cecil', NULL, 'Hoeger', '999999999', 'jgoodwin@gmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(141, 'Malinda', NULL, 'Dooley', '1000000000', 'sonya.hermann@kris.info', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(142, 'Tyshawn', NULL, 'Abernathy', '999999999', 'kellie.price@stroman.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(143, 'Raul', NULL, 'Adams', '999999999', 'josiane.zieme@jenkins.net', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(144, 'Elroy', NULL, 'Feest', '1000000000', 'roselyn13@hagenes.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(145, 'Adrien', NULL, 'Stoltenberg', '999999999', 'kshlerin.rey@yahoo.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(146, 'Haleigh', NULL, 'Leannon', '1000000000', 'telly78@grimes.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(147, 'Rodrick', NULL, 'Mitchell', '999999999', 'benny.jacobson@shanahan.org', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(148, 'Christine', NULL, 'Cormier', '999999999', 'jjacobson@waters.org', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(149, 'Gabriel', NULL, 'Bogisich', '1000000000', 'fbins@hammes.org', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(150, 'Adah', NULL, 'Schmitt', '999999999', 'susie83@mcglynn.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(151, 'Kayleigh', NULL, 'Kovacek', '999999999', 'denis.toy@hotmail.com', b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserId` int UNSIGNED NOT NULL,
  `CustomerNr` int NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`Id`, `UserId`, `CustomerNr`, `IsActief`, `Opmerking`, `created_at`, `updated_at`) VALUES
(1, 51, 39602, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(2, 52, 44771, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(3, 53, 86940, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(4, 54, 67770, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(5, 55, 74539, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(6, 56, 93934, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(7, 57, 73082, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(8, 58, 33475, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(9, 59, 96814, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(10, 60, 25910, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(11, 61, 99667, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(12, 62, 37313, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(13, 63, 26101, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(14, 64, 39208, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(15, 65, 14801, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(16, 66, 86933, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(17, 67, 54003, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(18, 68, 25480, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(19, 69, 93236, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(20, 70, 85551, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(21, 71, 56753, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(22, 72, 64350, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(23, 73, 39368, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(24, 74, 90981, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(25, 75, 74388, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(26, 76, 70224, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(27, 77, 21331, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(28, 78, 70639, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(29, 79, 16650, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(30, 80, 68768, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(31, 81, 68918, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(32, 82, 98750, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(33, 83, 26336, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(34, 84, 15901, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(35, 85, 87612, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(36, 86, 95611, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(37, 87, 45665, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(38, 88, 28768, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(39, 89, 16964, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(40, 90, 24454, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(41, 91, 31197, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(42, 92, 84134, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(43, 93, 64392, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(44, 94, 24227, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(45, 95, 79889, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(46, 96, 12206, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(47, 97, 89201, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(48, 98, 31228, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(49, 99, 46138, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000'),
(50, 100, 49881, b'1', NULL, '2025-04-10 14:13:40.000000', '2025-04-10 14:13:40.000000');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `UserId` int UNSIGNED NOT NULL,
  `EmployeeNr` int NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `UserId` (`UserId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `extras`
--

DROP TABLE IF EXISTS `extras`;
CREATE TABLE IF NOT EXISTS `extras` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` varchar(10) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '0001_01_01_000002_create_jobs_table', 1),
(3, '0001_04_10_078000_create_users_table', 1),
(4, '2025_04_10_074921_roles', 1),
(5, '2025_04_10_075051_contacts', 1),
(6, '2025_04_10_080035_employees', 1),
(7, '2025_04_10_080437_customers', 1),
(8, '2025_04_10_081139_bowling_lanes', 1),
(9, '2025_04_10_081245_extras', 1),
(10, '2025_04_10_081427_reservations', 1),
(11, '2025_04_10_081534_reservation_extras', 1),
(12, '2025_04_10_081637_people', 1),
(13, '2025_04_10_081803_scores', 1),
(14, '2025_04_10_121921_create_stored_procedure_get_contacts', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `Email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`Email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
CREATE TABLE IF NOT EXISTS `people` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ReservationId` int UNSIGNED NOT NULL,
  `Adults` int NOT NULL,
  `Kids` int NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `ReservationId` (`ReservationId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservationextras`
--

DROP TABLE IF EXISTS `reservationextras`;
CREATE TABLE IF NOT EXISTS `reservationextras` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `ReservationId` int UNSIGNED NOT NULL,
  `ExtrasId` int UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `ReservationId` (`ReservationId`),
  KEY `ExtrasId` (`ExtrasId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE IF NOT EXISTS `reservations` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `CustomerId` int UNSIGNED NOT NULL,
  `BowlingLaneId` int UNSIGNED NOT NULL,
  `ReservationExtrasId` int UNSIGNED NOT NULL,
  `ReservationDateTime` datetime(6) NOT NULL,
  `Price` decimal(5,2) NOT NULL,
  `PeopleId` tinyint UNSIGNED NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `CustomerId` (`CustomerId`),
  KEY `BowlingLaneId` (`BowlingLaneId`),
  KEY `ReservationExtrasId` (`ReservationExtrasId`),
  KEY `PeopleId` (`PeopleId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `Role` varchar(10) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
CREATE TABLE IF NOT EXISTS `scores` (
  `Id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `PeopleId` int UNSIGNED NOT NULL,
  `Score` varchar(100) NOT NULL,
  `IsActief` bit(1) NOT NULL DEFAULT b'1',
  `Opmerking` varchar(250) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`Id`),
  KEY `PeopleId` (`PeopleId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('h9a72YnHRfTh0EOoKlen6svdXzgjS2ndfwtszy6I', 101, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMmNsZUdmblZpd29UTXVWM0FUNHVHQlAzeGlmeENtSXNic2N2NlhPWiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jdXN0b21lcnMiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxMDE7fQ==', 1744294773);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `ContactId` bigint UNSIGNED NOT NULL,
  `RoleId` bigint UNSIGNED NOT NULL,
  `Username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `ContactId`, `RoleId`, `Username`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 7, 'padberg.nedra', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '73HBhEGTZt', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(2, 2, 3, 'lynch.gonzalo', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'UnmQ4eYxXs', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(3, 3, 1, 'hackett.lawson', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '3PQ1O5SUtH', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(4, 4, 0, 'laila.predovic', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'JjkRJ5bKUl', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(5, 5, 1, 'kreiger.valentina', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'iEF4Oxw236', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(6, 6, 7, 'franz60', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'Pl3Ls1vNR5', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(7, 7, 3, 'llarson', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '4UH9pJnOq8', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(8, 8, 8, 'alvena.jacobs', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'wovfZal5VB', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(9, 9, 0, 'ubaldo.leannon', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'eWbE1DQgxy', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(10, 10, 7, 'dessie.heaney', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'uOOJW3YJee', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(11, 11, 7, 'schroeder.micaela', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'qT9uVWc7lZ', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(12, 12, 2, 'annamae52', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'sCzyrKEEts', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(13, 13, 3, 'fisher.abbigail', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'RmrIRW8U3y', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(14, 14, 9, 'dayton30', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'M6XLPM8JKP', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(15, 15, 0, 'nwehner', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'RiSf41TAZf', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(16, 16, 4, 'lilyan65', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'GG0eVxIJvm', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(17, 17, 0, 'ustroman', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'm42k1d2Zat', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(18, 18, 3, 'west.rey', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'I6WOt5eW1e', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(19, 19, 1, 'quentin.zboncak', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'smOcJIq2q5', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(20, 20, 9, 'wbradtke', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'wtYRTfvE6v', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(21, 21, 0, 'tblick', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'LmxNzlW7mP', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(22, 22, 6, 'augusta32', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'O1gs3xcoO8', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(23, 23, 8, 'kirlin.lupe', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'UDrAmVZQz9', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(24, 24, 0, 'lauren.oconnell', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'DXPMQx2mzz', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(25, 25, 5, 'coleman.ohara', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'ODg4og01N1', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(26, 26, 0, 'davis.yasmeen', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'vLF4qt3UiQ', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(27, 27, 8, 'bquigley', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '02zzmPqGn1', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(28, 28, 3, 'oreilly.devante', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '3zq9vDJHXr', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(29, 29, 6, 'ycormier', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'NUApzniUVC', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(30, 30, 0, 'gzieme', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'ewTUGfrzFN', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(31, 31, 1, 'dcarroll', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'MmQwrKKiKG', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(32, 32, 2, 'qblick', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '3q8jz6MNAs', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(33, 33, 9, 'lester90', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'QAVGR12kwo', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(34, 34, 5, 'frances.halvorson', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'MQqoR1D5q0', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(35, 35, 9, 'abdul.turner', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'BLROs10OfA', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(36, 36, 4, 'wrogahn', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '48LgEjMwwn', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(37, 37, 2, 'sharon.little', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'R2YVqCdqqe', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(38, 38, 8, 'vena73', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'm9tN91wkzw', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(39, 39, 6, 'libbie68', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'ISvDJvYX4q', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(40, 40, 9, 'kchamplin', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'BND5DvwRZx', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(41, 41, 1, 'igrady', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'ccKrxpHXy5', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(42, 42, 2, 'ckeebler', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'aExFZCF2Sg', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(43, 43, 3, 'syble.shields', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'dAD3viJpXp', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(44, 44, 0, 'keanu.reilly', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'x4fEPPs7kA', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(45, 45, 8, 'ada.auer', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'NL6oBwKxoZ', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(46, 46, 0, 'jazlyn67', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '9l8y6AjYCp', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(47, 47, 2, 'candida.considine', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'gbNY4bpjYv', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(48, 48, 2, 'kmorar', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '5cX7jx1FL6', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(49, 49, 8, 'roger.barrows', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '06PAG6kV1i', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(50, 50, 8, 'aoberbrunner', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'emUdjHR4Lt', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(51, 101, 0, 'trey.mueller', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'XwHpJzOQYL', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(52, 102, 2, 'heathcote.kaleigh', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'Ad5w5CnX5R', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(53, 103, 5, 'kuvalis.isabel', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'tFOxVRXnQG', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(54, 104, 4, 'qgerhold', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '2kYVYytg6B', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(55, 105, 7, 'beer.shaun', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '4pTvOGJWwp', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(56, 106, 4, 'annabel.cormier', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '7aApyWEew6', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(57, 107, 5, 'fern.spencer', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'MHEyBpIqUh', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(58, 108, 2, 'alfreda.johns', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'lpq5cp13pb', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(59, 109, 0, 'trever.kuhn', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'E5gNtCp4aV', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(60, 110, 0, 'lacy.leuschke', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'DAM6bAb4hq', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(61, 111, 2, 'towne.casimer', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'MYUjymEGm7', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(62, 112, 0, 'hilpert.adriel', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'efRiAStWxP', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(63, 113, 0, 'hkassulke', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'XpXblywTWb', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(64, 114, 7, 'kulas.branson', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '1V4ywQlmiP', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(65, 115, 7, 'pmorissette', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'H6utPbRrEW', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(66, 116, 5, 'amari.hessel', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '7BiwJz9YFC', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(67, 117, 0, 'hlehner', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'wFee2fLCVR', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(68, 118, 9, 'donnelly.dallin', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '7m5ZpKnf3w', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(69, 119, 2, 'breanna86', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'ROtRdt8WhY', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(70, 120, 2, 'harvey.kristy', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'KPt2cCO24i', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(71, 121, 9, 'konopelski.scot', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'VZFf7cCTiC', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(72, 122, 0, 'nasir63', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'SJ5dEXG0Il', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(73, 123, 5, 'keegan71', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'iPD5ec0MXK', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(74, 124, 0, 'krista.champlin', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'pRJWEVH3IK', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(75, 125, 6, 'kstoltenberg', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'FgmCzr89md', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(76, 126, 5, 'augustine.schamberger', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'Au59HFNfM5', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(77, 127, 3, 'pollich.hettie', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '4dqdZ42hXO', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(78, 128, 0, 'dhowell', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'TmCI5Xlmg6', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(79, 129, 6, 'monroe.veum', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'VTcC0GoA8S', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(80, 130, 8, 'fbayer', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'faTlSEZPf2', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(81, 131, 1, 'misael.kub', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'wEQwXXYmNY', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(82, 132, 4, 'ubergstrom', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'ouNnN7WA78', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(83, 133, 4, 'michelle.fahey', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'bsLzjojyNe', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(84, 134, 0, 'ylynch', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'BpPqaI3Fhf', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(85, 135, 8, 'abigail.ruecker', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'wf6uFrHK9n', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(86, 136, 6, 'maxime.kiehn', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'xp8uviLyRu', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(87, 137, 5, 'hickle.zackary', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'iHOCVRRfHT', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(88, 138, 3, 'kristofer.tromp', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'JalAXxabjT', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(89, 139, 9, 'matilde66', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'ji2NsLVfFf', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(90, 140, 3, 'furman.fadel', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '5x9LUvrqGv', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(91, 141, 9, 'ukeeling', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'rs9rh51Wyv', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(92, 142, 9, 'vskiles', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', '9mOQ4j86F6', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(93, 143, 3, 'daren84', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'yG2EqyoF9L', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(94, 144, 2, 'aliyah34', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'sYJUfBaWJ3', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(95, 145, 6, 'cummerata.johanna', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'wfwSJtYLwZ', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(96, 146, 1, 'vmoore', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'ELmgVqiyor', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(97, 147, 3, 'kacey.harris', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'ksNsozlJMz', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(98, 148, 4, 'streich.elbert', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'LJJ8dkd0qq', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(99, 149, 9, 'josiah.koelpin', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'WVjeU0XysP', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(100, 150, 2, 'dschneider', '$2y$12$RIq0XJMNvpRFDFKVFMvZrusWJgwv052c0vt16TSjs16pYgwpTgPaa', 'KwiMXAraoW', '2025-04-10 12:13:40', '2025-04-10 12:13:40'),
(101, 151, 3, 'Test', '$2y$12$pq/epMn.exeGse73tgYL2uGev0wd7k3DdyPGwKDOh7Kdr3y1C147S', 'WiozFrIzYR', '2025-04-10 12:13:40', '2025-04-10 12:13:40');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

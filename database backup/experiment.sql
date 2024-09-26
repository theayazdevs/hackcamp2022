-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 22, 2023 at 05:20 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hackcamp`
--

-- --------------------------------------------------------

--
-- Table structure for table `experiment`
--

CREATE TABLE `experiment` (
  `id` int(11) NOT NULL,
  `type` text NOT NULL,
  `name` text NOT NULL,
  `totaltime` text NOT NULL,
  `date` text NOT NULL,
  `description` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `experiment`
--

INSERT INTO `experiment` (`id`, `type`, `name`, `totaltime`, `date`, `description`) VALUES
(0, 'Survey', 'gdfgd', '4', '4', 0),
(1, 'Survey', 'gdfgd', '4', '4', 0),
(2, 'Poll', 'gfsd', '43', '543', 123),
(3, 'discussion', 'hgdf', 'hgf', 'hgf', 545),
(4, 'Prototype', 'bgdfbg', 'bdfgbf', 'gfbgfb', 423);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `experiment`
--
ALTER TABLE `experiment`
  ADD UNIQUE KEY `theExperimentID` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

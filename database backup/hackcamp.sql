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
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminID` int(11) NOT NULL,
  `adminEmail` text NOT NULL,
  `adminPassword` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`adminID`, `adminEmail`, `adminPassword`) VALUES
(0, 'admin@admin.com', '$2y$10$oQFyswGxeqsY./JtjX/3FeXnKgyiNn/jA.5mVacBhBdsNCJnXlMjW');

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

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `totalExperiments` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `password` text NOT NULL,
  `DoB` text NOT NULL,
  `email` text NOT NULL,
  `gender` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `password`, `DoB`, `email`, `gender`) VALUES
(1, 'test', 'test', '$2y$10$AwnSNj6A12G9tnntdEArdOphoQZlIYcQpoO1JcSPreuyFYmeTscpu', '2000-01-01', 'test@test.com', 'MALE'),
(2, 'vdfvgfd', 'bdbfg', '$2y$10$.WoEAi8FGRNny9wsiTPPBeiYLxqzMUWbbvmBJTLELc1QaPsS7S50q', '2000-01-01', 'try@try.com', 'Prefer Not To Say');

-- --------------------------------------------------------

--
-- Table structure for table `userexperiment`
--

CREATE TABLE `userexperiment` (
  `userID` text NOT NULL,
  `experimentID` text NOT NULL,
  `date` text NOT NULL,
  `time` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD KEY `adminIndex` (`adminID`);

--
-- Indexes for table `experiment`
--
ALTER TABLE `experiment`
  ADD UNIQUE KEY `theExperimentID` (`id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD KEY `notificationID` (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `theIndex` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

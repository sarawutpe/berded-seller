-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jan 05, 2022 at 09:30 AM
-- Server version: 10.2.37-MariaDB-1:10.2.37+maria~bionic
-- PHP Version: 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `admin_berded`
--

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE `package` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `quota` int(11) NOT NULL,
  `recommend` int(11) NOT NULL,
  `berded` int(11) NOT NULL,
  `day` int(11) NOT NULL,
  `guarantee` tinyint(1) NOT NULL,
  `stat_7days` tinyint(1) NOT NULL,
  `stat_15days` tinyint(1) NOT NULL,
  `stat_month` tinyint(1) NOT NULL,
  `stat_year` tinyint(1) NOT NULL,
  `advertise` tinyint(1) NOT NULL,
  `additional_service` tinyint(1) NOT NULL,
  `number_analysis_tool` tinyint(1) NOT NULL,
  `enable_sort_by` tinyint(1) NOT NULL,
  `enable_ems` tinyint(1) NOT NULL,
  `enable_article` tinyint(1) NOT NULL,
  `order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`id`, `name`, `price`, `quota`, `recommend`, `berded`, `day`, `guarantee`, `stat_7days`, `stat_15days`, `stat_month`, `stat_year`, `advertise`, `additional_service`, `number_analysis_tool`, `enable_sort_by`, `enable_ems`, `enable_article`, `order`) VALUES
(1, 'Trial', 0, 20, 0, 0, 30, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1),
(2, 'Basic', 500, 500, 1, 10, 30, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 4),
(3, 'Smart', 900, 1000, 10, 20, 30, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 5),
(5, 'Pro', 1500, 1500, 20, 100, 30, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6),
(6, 'Premier', 2500, 3500, 30, 150, 30, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7),
(8, 'Mini', 300, 200, 0, 0, 30, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 3),
(9, 'Premier Plus', 3000, 4500, 30, 150, 30, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 8),
(10, 'Lite', 0, 10, 0, 0, 30, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `package`
--
ALTER TABLE `package`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `package`
--
ALTER TABLE `package`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

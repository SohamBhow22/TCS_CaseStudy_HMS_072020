-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 02, 2020 at 10:34 AM
-- Server version: 5.7.23
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hms_tcs`
--

-- --------------------------------------------------------

--
-- Table structure for table `med_issued`
--

DROP TABLE IF EXISTS `med_issued`;
CREATE TABLE IF NOT EXISTS `med_issued` (
  `Pid` int(9) NOT NULL,
  `Mid` int(10) NOT NULL,
  `Quantity` int(5) NOT NULL,
  KEY `Pid` (`Pid`),
  KEY `Mid` (`Mid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `med_issued`
--

INSERT INTO `med_issued` (`Pid`, `Mid`, `Quantity`) VALUES
(900900902, 200200203, 1),
(900900903, 200200201, 20),
(900900901, 200200201, 15),
(900900901, 200200202, 6);

-- --------------------------------------------------------

--
-- Table structure for table `med_mstr`
--

DROP TABLE IF EXISTS `med_mstr`;
CREATE TABLE IF NOT EXISTS `med_mstr` (
  `Mid` int(10) NOT NULL,
  `Mname` varchar(20) NOT NULL,
  `Quantity` int(5) NOT NULL,
  `Rate` float NOT NULL,
  PRIMARY KEY (`Mid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `med_mstr`
--

INSERT INTO `med_mstr` (`Mid`, `Mname`, `Quantity`, `Rate`) VALUES
(200200201, 'Limcee', 100, 13),
(200200202, 'Aspirin', 250, 20.5),
(200200203, 'Burnol', 50, 65);

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
CREATE TABLE IF NOT EXISTS `patients` (
  `SSN_ID` int(9) NOT NULL,
  `Pid` int(9) NOT NULL,
  `Pname` varchar(30) NOT NULL,
  `Page` int(3) NOT NULL,
  `AdmitDate` date NOT NULL,
  `BedType` varchar(15) NOT NULL,
  `Addr` varchar(50) NOT NULL,
  `City` varchar(20) NOT NULL,
  `State` varchar(20) NOT NULL,
  `Status` varchar(10) NOT NULL,
  PRIMARY KEY (`Pid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`SSN_ID`, `Pid`, `Pname`, `Page`, `AdmitDate`, `BedType`, `Addr`, `City`, `State`, `Status`) VALUES
(100100101, 900900901, 'Albert', 35, '2020-06-29', 'Single Room', 'Tokyo Apartments', 'Surat', 'Gujarat', 'Active'),
(100100102, 900900902, 'Luis', 65, '2020-06-05', 'Semi Sharing', 'Nairobi Park', 'Kolkata', 'West Bengal', 'Active'),
(100100103, 900900903, 'Luis', 58, '2020-06-30', 'Semi Sharing', 'Budapest Towers', 'Bengaluru', 'Karnataka', 'Discharged'),
(100100104, 900900904, 'Wayne', 44, '2020-06-20', 'General Ward', 'London Bridge', 'Indore', 'Madhya Pradesh', 'Active');

-- --------------------------------------------------------

--
-- Table structure for table `test_con`
--

DROP TABLE IF EXISTS `test_con`;
CREATE TABLE IF NOT EXISTS `test_con` (
  `Pid` int(9) NOT NULL,
  `Tid` int(10) NOT NULL,
  `Quantity` int(5) NOT NULL,
  KEY `Pid` (`Pid`),
  KEY `Tid` (`Tid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test_con`
--

INSERT INTO `test_con` (`Pid`, `Tid`, `Quantity`) VALUES
(900900903, 300300301, 1),
(900900901, 300300301, 1),
(900900901, 300300301, 1),
(900900902, 300300303, 1),
(900900901, 300300304, 1),
(900900904, 300300302, 1),
(900900901, 300300304, 1);

-- --------------------------------------------------------

--
-- Table structure for table `test_mstr`
--

DROP TABLE IF EXISTS `test_mstr`;
CREATE TABLE IF NOT EXISTS `test_mstr` (
  `Tid` int(10) NOT NULL,
  `Tname` varchar(20) NOT NULL,
  `Rate` float NOT NULL,
  PRIMARY KEY (`Tid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test_mstr`
--

INSERT INTO `test_mstr` (`Tid`, `Tname`, `Rate`) VALUES
(300300301, 'Blood Test', 150),
(300300302, 'CT Scan', 2000),
(300300303, 'Urine Test', 250),
(300300304, 'ECG Test', 5500);

-- --------------------------------------------------------

--
-- Table structure for table `userstore`
--

DROP TABLE IF EXISTS `userstore`;
CREATE TABLE IF NOT EXISTS `userstore` (
  `login` varchar(15) NOT NULL,
  `password` varchar(15) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userstore`
--

INSERT INTO `userstore` (`login`, `password`, `timestamp`) VALUES
('101', 'hello', '2020-06-28 13:56:14'),
('102', 'hell', '2020-06-28 13:56:47'),
('103', 'hel', '2020-06-28 13:57:12');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `med_issued`
--
ALTER TABLE `med_issued`
  ADD CONSTRAINT `med_issued_ibfk_1` FOREIGN KEY (`Mid`) REFERENCES `med_mstr` (`Mid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `med_issued_ibfk_2` FOREIGN KEY (`Pid`) REFERENCES `patients` (`Pid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `test_con`
--
ALTER TABLE `test_con`
  ADD CONSTRAINT `test_con_ibfk_1` FOREIGN KEY (`Pid`) REFERENCES `patients` (`Pid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `test_con_ibfk_2` FOREIGN KEY (`Tid`) REFERENCES `test_mstr` (`Tid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

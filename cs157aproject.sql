-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2014 at 07:30 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cs157aproject`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddToWishlist`(IN `cusID` INT, IN `prodID` INT)
    NO SQL
INSERT INTO wishlist(customerID,productID,quantity,dateAdded)
VALUES (cusID,prodID,
        (SELECT quantity FROM product WHERE productID=prodID)
        ,NOW())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BrandsWithAtLeast`(IN `p` INT)
    NO SQL
SELECT brand, SUM(price) as "total"
FROM product
GROUP BY brand
HAVING total > p$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckStock`(IN `ID` INT)
    NO SQL
BEGIN
SELECT quantity FROM product WHERE productID = ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWishlistedItems`(IN `cusID` INT)
    NO SQL
SELECT * 
FROM product p,wishlist w 
WHERE customerID=cusID AND p.productID=w.productID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertPurchase`(IN `cusID` INT, IN `prodID` INT, IN `quant` INT, IN `card` VARCHAR(15))
    NO SQL
INSERT INTO purchases(customerID,productID,buyquantity,creditcard,datetime)
VALUES (cusID,prodID,quant,card,NOW())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SetUpdatedAt`(IN `prodID` INT)
    NO SQL
UPDATE product SET updatedAt=NOW() WHERE productID=prodID$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customerID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `creditcard` varchar(16) NOT NULL,
  `lastpurchase` datetime NOT NULL,
  `username` varchar(20) NOT NULL,
  PRIMARY KEY (`customerID`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `name`, `address`, `phone`, `creditcard`, `lastpurchase`, `username`) VALUES
(14, 'Tester', 'test', '(408)111-1111', '1234123412341234', '2014-12-04 22:25:44', 'test'),
(15, 'Administrator', '', '', '', '0000-00-00 00:00:00', 'admin'),
(16, 'Tester2', '', '', '', '0000-00-00 00:00:00', 'test2');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `productID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` varchar(10) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`productID`),
  KEY `quantity` (`quantity`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productID`, `name`, `quantity`, `price`, `brand`, `updatedAt`) VALUES
(17, 'Umbrella', 2, '9.99', 'Kirkland', '2014-12-04 21:57:45'),
(18, 'Lighter', 28, '1.99', 'BIC', '2014-12-04 22:01:11'),
(19, 'Facial Tissue', 91, '4.99', 'Kleenex', '2014-12-04 22:25:44');

--
-- Triggers `product`
--
DROP TRIGGER IF EXISTS `productUpdate`;
DELIMITER //
CREATE TRIGGER `productUpdate` AFTER UPDATE ON `product`
 FOR EACH ROW BEGIN
UPDATE wishlist SET quantity = NEW.quantity
WHERE productID = NEW.productID;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE IF NOT EXISTS `purchases` (
  `purchaseID` int(11) NOT NULL AUTO_INCREMENT,
  `customerID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `buyquantity` int(11) NOT NULL,
  `creditcard` varchar(20) NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`purchaseID`),
  KEY `productID` (`productID`),
  KEY `customerID` (`customerID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`purchaseID`, `customerID`, `productID`, `buyquantity`, `creditcard`, `datetime`) VALUES
(19, 14, 17, 1, '123412341234123', '2014-12-04 21:57:45'),
(22, 14, 18, 2, '123412341234123', '2014-12-04 22:01:11'),
(23, 14, 19, 2, '123412341234123', '2014-12-04 22:01:38'),
(24, 14, 19, 2, '123412341234123', '2014-12-04 22:09:16'),
(25, 14, 19, 2, '123412341234123', '2014-12-04 22:09:59'),
(26, 14, 19, 2, '123412341234123', '2014-12-04 22:19:50'),
(27, 14, 19, 1, '123412341234123', '2014-12-04 22:25:44');

--
-- Triggers `purchases`
--
DROP TRIGGER IF EXISTS `updateLastPurchase`;
DELIMITER //
CREATE TRIGGER `updateLastPurchase` AFTER INSERT ON `purchases`
 FOR EACH ROW BEGIN
UPDATE customer SET lastpurchase = NEW.datetime
WHERE customerID = NEW.customerID;

UPDATE product SET quantity = quantity - NEW.buyquantity
WHERE productID = NEW.productID;

UPDATE wishlist SET quantity = quantity - NEW.buyquantity
WHERE productID = NEW.productID;

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `customerID` int(11) NOT NULL,
  `role` enum('A','U') NOT NULL,
  PRIMARY KEY (`username`),
  KEY `customerID` (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `customerID`, `role`) VALUES
('admin', 'password', 15, 'A'),
('test', 'test123', 14, 'U'),
('test2', 'test123', 16, 'U');

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE IF NOT EXISTS `wishlist` (
  `customerID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `dateAdded` datetime NOT NULL,
  `quantity` int(11) NOT NULL,
  UNIQUE KEY `customerID` (`customerID`,`productID`),
  KEY `quantity` (`quantity`),
  KEY `wishlist_ibfk_2` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`customerID`, `productID`, `dateAdded`, `quantity`) VALUES
(14, 19, '2014-12-04 22:19:46', 91),
(16, 17, '2014-12-04 22:10:32', 2),
(16, 19, '2014-12-04 22:10:34', 91);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

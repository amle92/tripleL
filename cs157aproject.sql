-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2014 at 06:15 AM
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `BrandsWithAtLeast`(IN `p` INT)
    NO SQL
SELECT brand, SUM(price) as "total"
FROM product
GROUP BY brand
HAVING SUM(price) > p$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckStock`(IN `ID` INT)
    NO SQL
BEGIN
SELECT quantity FROM product WHERE productID = ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertPurchase`(IN purchase_ID  INT, IN customer_ID  INT, IN product_ID   INT,
IN buy_quantity  INT, IN credit_card   INT)
BEGIN
INSERT INTO purchases(purchaseID,customerID,productID,buyquantity,creditcard,datetime) VALUES (purchase_ID, customer_ID, product_ID, buy_quantity, credit_card, NOW());
END$$

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `name`, `address`, `phone`, `creditcard`, `lastpurchase`, `username`) VALUES
(14, 'Tester', 'test', '(408)111-1111', '1234123412341234', '0000-00-00 00:00:00', 'test'),
(15, 'Administrator', '', '', '', '0000-00-00 00:00:00', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `productID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` varchar(6) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`productID`),
  KEY `quantity` (`quantity`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productID`, `name`, `quantity`, `price`, `brand`, `updatedAt`) VALUES
(17, 'Umbrella', 5, '9.99', 'Kirkland', '2014-12-03 20:37:46'),
(18, 'Lighter', 30, '1.99', 'BIC', '2014-12-03 20:44:39'),
(19, 'Facial Tissue', 100, '4.99', 'Kleenex', '2014-12-03 20:46:24');

--
-- Triggers `product`
--
DROP TRIGGER IF EXISTS `productUpdate`;
DELIMITER //
CREATE TRIGGER `productUpdate` AFTER UPDATE ON `product`
 FOR EACH ROW BEGIN
UPDATE product SET updatedAt = NOW()
WHERE productID = NEW.productID;
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
  `creditcard` int(11) NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`purchaseID`),
  UNIQUE KEY `customerID` (`customerID`,`productID`),
  KEY `customerID_2` (`customerID`),
  KEY `productID` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
('test', 'test123', 14, 'U');

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
  KEY `productID` (`productID`),
  KEY `quantity` (`quantity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`),
  ADD CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`),
  ADD CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

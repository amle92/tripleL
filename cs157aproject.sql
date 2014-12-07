-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2014 at 02:19 AM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `ChangeStock`(IN `ID` INT, IN `quant` INT)
    NO SQL
BEGIN
UPDATE product SET quantity=quant WHERE productID = ID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPurchases`(IN `custID` INT)
    NO SQL
SELECT prod.name,pur.buyquantity,pur.creditcard,prod.productID,pur.datetime
FROM product prod, purchases pur
WHERE pur.customerID=custID AND prod.productID=pur.productID
ORDER BY pur.datetime DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetUserInfo`()
    NO SQL
SELECT *
FROM customer c JOIN users u ON c.customerID=u.customerID
WHERE role='U' OR role='A'
ORDER BY role ASC$$

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `name`, `address`, `phone`, `creditcard`, `lastpurchase`, `username`) VALUES
(14, 'Tester', 'test', '(408)111-1111', '1234123412341234', '2014-12-04 22:25:44', 'test'),
(15, 'Administrator', '', '', '', '0000-00-00 00:00:00', 'admin'),
(16, 'Tester2', '', '', '', '0000-00-00 00:00:00', 'test2'),
(17, 'Store Master', '', '', '', '0000-00-00 00:00:00', 'master');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43 ;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productID`, `name`, `quantity`, `price`, `brand`, `updatedAt`) VALUES
(17, 'Umbrella', 5, '4.99', 'Kirkland', '2014-12-04 21:57:45'),
(18, 'Lighter', 28, '1.99', 'BIC', '2014-12-04 22:01:11'),
(19, 'Facial Tissue', 91, '4.99', 'Kleenex', '2014-12-04 22:25:44'),
(20, 'Laptop', 50, '849.99', 'Lenovo\r\n', '2014-12-06 16:03:50'),
(21, 'Laptop', 50, '869.99', 'Asus\r\n', '2014-12-06 16:03:50'),
(22, 'iPod', 30, '199.99', 'Apple\r\n', '2014-12-06 16:03:50'),
(23, 'BBQ Chips', 50, '2.99', 'Lays\r\n', '2014-12-06 16:03:50'),
(24, 'Mac and Cheese', 40, '1.00', 'Kraft\r\n', '2014-12-06 16:03:50'),
(25, 'Deathadder Mouse', 15, '69.99', 'Razer\r\n', '2014-12-06 16:03:50'),
(26, 'Television', 5, '1999.99', 'Sharp\r\n', '2014-12-06 16:03:50'),
(27, 'Anime', 70, '24.99', 'Funimation\r\n', '2014-12-06 16:03:50'),
(28, 'iPad', 34, '499.99', 'Apple\r\n', '2014-12-06 16:03:50'),
(29, 'Coffee', 200, '5.00', 'Starbucks\r\n', '2014-12-06 16:03:50'),
(30, 'Cereal', 30, '3.99', 'Kelloggs\r\n', '2014-12-06 16:03:50'),
(31, 'Backpack', 15, '10.00', 'Jansport\r\n', '2014-12-06 16:03:50'),
(32, 'Candy Bar', 60, '1.00', 'Hersheys\r\n', '2014-12-06 16:03:50'),
(33, 'Gift Card', 40, '25.00', 'Amazon\r\n', '2014-12-06 16:03:50'),
(34, 'Gift Card', 40, '25.00', 'Facebook\r\n', '2014-12-06 16:03:50'),
(35, 'Gift Card', 40, '25.00', 'Riot Games\r\n', '2014-12-06 16:03:50'),
(36, 'Blue Shirt', 10, '200.00', 'Lacoste\r\n', '2014-12-06 16:03:50'),
(37, 'Red Shirt', 10, '180.00', 'Lacoste\r\n', '2014-12-06 16:03:50'),
(38, 'Halo', 10, '69.99', 'Bungie\r\n', '2014-12-06 16:03:50'),
(39, 'Half Life 3', 1, '1337.33', 'Valve\r\n', '2014-12-06 16:03:50'),
(40, 'Underwear', 10, '5.99', 'Fruit of the Loom\r\n', '2014-12-06 16:03:50'),
(41, 'Shoes', 30, '22.49', 'Nike\r\n', '2014-12-06 16:03:50'),
(42, 'Klondike Bar', 15, '2.99', 'Klondike', '2014-12-06 16:03:50');

--
-- Triggers `product`
--
DROP TRIGGER IF EXISTS `productUpdate`;
DELIMITER //
CREATE TRIGGER `productUpdate` AFTER UPDATE ON `product`
 FOR EACH ROW BEGIN
UPDATE wishlist SET quantity = NEW.quantity
WHERE productID = NEW.productID;

DELETE FROM productarchive
WHERE productID = NEW.productID;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `productarchive`
--

CREATE TABLE IF NOT EXISTS `productarchive` (
  `productID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` varchar(10) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE IF NOT EXISTS `purchases` (
  `purchaseID` int(11) NOT NULL AUTO_INCREMENT,
  `customerID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `buyquantity` int(11) NOT NULL,
  `creditcard` varchar(16) NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`purchaseID`),
  KEY `productID` (`productID`),
  KEY `customerID` (`customerID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`purchaseID`, `customerID`, `productID`, `buyquantity`, `creditcard`, `datetime`) VALUES
(19, 14, 17, 1, '1234123412341234', '2014-12-04 21:57:45'),
(22, 14, 18, 2, '1234123412341234', '2014-12-04 22:01:11'),
(23, 14, 19, 2, '1234123412341234', '2014-12-04 22:01:38'),
(24, 14, 19, 2, '1234123412341234', '2014-12-04 22:09:16'),
(25, 14, 19, 2, '1234123412341234', '2014-12-04 22:09:59'),
(26, 14, 19, 2, '1234123412341234', '2014-12-04 22:19:50'),
(27, 14, 19, 1, '1234123412341234', '2014-12-04 22:25:44');

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
  `role` enum('A','U','M') NOT NULL,
  PRIMARY KEY (`username`),
  KEY `customerID` (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `customerID`, `role`) VALUES
('admin', 'password', 15, 'A'),
('master', 'password', 17, 'M'),
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
(16, 17, '2014-12-04 22:10:32', 5),
(16, 19, '2014-12-04 22:10:34', 91);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `purchases`
--
ALTER TABLE `purchases`
  ADD CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `archiveproduct` ON SCHEDULE EVERY 1 DAY STARTS '2014-12-06 17:10:08' ON COMPLETION NOT PRESERVE ENABLE DO INSERT INTO productarchive
SELECT * FROM product p
WHERE (DATEDIFF(p.updatedAt, NOW())) > 7$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE DATABASE  IF NOT EXISTS `laptop_ordering` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laptop_ordering`;
-- MySQL dump 10.13  Distrib 8.0.27, for macos11 (x86_64)
--
-- Host: 127.0.0.1    Database: laptop_ordering
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `addressID` int NOT NULL AUTO_INCREMENT,
  `buildingNo` int NOT NULL,
  `city` varchar(30) NOT NULL,
  `state` varchar(30) NOT NULL,
  `country` varchar(30) NOT NULL,
  `zipcode` int NOT NULL,
  `custID` int NOT NULL,
  PRIMARY KEY (`addressID`),
  KEY `cust_address_fk` (`custID`),
  CONSTRAINT `cust_address_fk` FOREIGN KEY (`custID`) REFERENCES `customer` (`customerID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,12,'Boston','MA','USA',21153,1),(2,12,'Boston','MA','USA',21152,2),(3,12,'Boston','MA','USA',42115,3),(4,12,'Boston','MA','USA',62115,4),(5,12,'Boston','MA','USA',32115,5),(6,12,'Boston','MA','USA',12115,6),(7,12,'Boston','MA','USA',62115,7),(8,12,'Boston','MA','USA',72115,8),(9,12,'Boston','MA','USA',92115,9),(10,12,'Boston','MA','USA',22115,10),(11,12,'Boston','MA','USA',2115,11);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deletePlacesCustomer` AFTER DELETE ON `address` FOR EACH ROW BEGIN
DELETE FROM customer 
WHERE customerID=OLD.custID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `assists`
--

DROP TABLE IF EXISTS `assists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assists` (
  `storeID` int NOT NULL,
  `customerID` int NOT NULL,
  `employeeID` int NOT NULL,
  PRIMARY KEY (`storeID`,`customerID`,`employeeID`),
  KEY `customer_assists_fk` (`customerID`),
  KEY `employee_assists_fk` (`employeeID`),
  CONSTRAINT `customer_assists_fk` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_assists_fk` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`employeeID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `stores_assists_fk` FOREIGN KEY (`storeID`) REFERENCES `store` (`storeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assists`
--

LOCK TABLES `assists` WRITE;
/*!40000 ALTER TABLE `assists` DISABLE KEYS */;
INSERT INTO `assists` VALUES (2,1,1),(1,2,4),(1,3,2),(2,4,3),(2,5,3),(1,6,2),(2,7,7),(1,8,10),(2,9,9),(2,10,8),(2,11,8);
/*!40000 ALTER TABLE `assists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brand` (
  `brandSymbol` varchar(50) NOT NULL,
  `brandName` varchar(50) NOT NULL,
  `numOfProducts` int DEFAULT '0',
  PRIMARY KEY (`brandSymbol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES ('AAPL','Apple',41),('ASUS','Asus',26),('DELL','Dell',69),('HP','Hewlett-Packard ',37),('LEN','Lenovo',7);
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customerID` int NOT NULL AUTO_INCREMENT,
  `customerFirstName` varchar(40) NOT NULL,
  `customerLastName` varchar(40) NOT NULL,
  `customerEmail` varchar(50) NOT NULL,
  `customerPhone` varchar(50) NOT NULL,
  `customerPassword` varchar(50) NOT NULL,
  PRIMARY KEY (`customerID`),
  UNIQUE KEY `customerEmail` (`customerEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Shillman','Sandy','smith@gmail.com','98457435543','dsj'),(2,'Sam','Manny','sam@gmail.com','9343929903','abcde'),(3,'John','Benny','john@gmail.com','931334203','abcde'),(4,'Smith','Sandy','smith1@gmail.com','931330933','abcde'),(5,'Sam','Manny','sam1@gmail.com','9343929903','abcde'),(6,'John','Benny','john1@gmail.com','931334203','abcde'),(7,'Smith','Sandy','smith2@gmail.com','931330933','abcde'),(8,'Sam','Manny','sam2@gmail.com','9343929903','abcde'),(9,'John','Benny','john2@gmail.com','931334203','abcde'),(10,'John','Benny','john3@gmail.com','931334203','abcde'),(11,'David','Brown','cusail679@gmail.com','1234567890','password');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employeeID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `employeeEmail` varchar(50) NOT NULL,
  `employeePhone` varchar(50) NOT NULL,
  `employeeAge` int NOT NULL,
  `storeID` int NOT NULL,
  `employeePassword` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeID`),
  UNIQUE KEY `employeeEmail` (`employeeEmail`),
  KEY `employee_store_fk` (`storeID`),
  CONSTRAINT `employee_store_fk` FOREIGN KEY (`storeID`) REFERENCES `store` (`storeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Vikram','Sandy','vikram@gmail.com','98457435543',25,2,'dsj'),(2,'Kushal','Manny','kushal@gmail.com','9343929903',35,1,'abcde'),(3,'Nandan','Benny','nandan@gmail.com','931334203',25,2,'abcde'),(4,'Nandan','Sandy','nandan1@gmail.com','931330933',35,1,'abcde'),(5,'Kushal','Manny','kushal1@gmail.com','9343929903',27,3,'abcde'),(6,'Vikram','Benny','vikram1@gmail.com','931334203',35,1,'abcde'),(7,'Pavan','Sandy','pavan1@gmail.com','931330933',35,2,'abcde'),(8,'Kushal','Manny','kushal2@gmail.com','9343929903',25,2,'abcde'),(9,'Vikram','Benny','vikram2@gmail.com','931334203',35,2,'abcde'),(10,'Pavan','Benny','pavan2@gmail.com','931334203',55,1,'abcde'),(11,'fname','lname','empemail1@gmail.com','1234567890',34,1,'password');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laptop_model`
--

DROP TABLE IF EXISTS `laptop_model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laptop_model` (
  `modelID` int NOT NULL AUTO_INCREMENT,
  `modelName` varchar(40) NOT NULL,
  `modelSymbol` varchar(50) NOT NULL,
  `RAM` enum('4','8','16','32','64') NOT NULL,
  `SSD` enum('128','256','512','1024') NOT NULL,
  `screenSize` enum('11','13','14','15','16','17') NOT NULL,
  `gpu` enum('8','16','32') NOT NULL,
  `operatingSystem` enum('macOS','Windows','Ubuntu') NOT NULL,
  `storeID` int NOT NULL,
  `numOfLaptops` int DEFAULT '0',
  PRIMARY KEY (`modelID`),
  KEY `store_model_fk` (`storeID`),
  KEY `brand_model_fk` (`modelSymbol`),
  CONSTRAINT `brand_model_fk` FOREIGN KEY (`modelSymbol`) REFERENCES `brand` (`brandSymbol`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `store_model_fk` FOREIGN KEY (`storeID`) REFERENCES `store` (`storeID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laptop_model`
--

LOCK TABLES `laptop_model` WRITE;
/*!40000 ALTER TABLE `laptop_model` DISABLE KEYS */;
INSERT INTO `laptop_model` VALUES (1,'Inspiron','DELL','8','512','14','8','Windows',1,34),(2,'Latitude','DELL','16','1024','16','8','Windows',4,23),(3,'Thinkpad','DELL','16','512','13','8','Windows',1,12),(4,'MacBook Air','AAPL','32','1024','14','8','macOS',2,23),(5,'MacBook Pro','AAPL','16','512','16','8','macOS',3,18),(6,'Pavilion','HP','8','512','13','8','Windows',1,12),(7,'Spectre','HP','32','1024','14','8','Windows',2,6),(8,'ENVY','HP','16','512','16','8','Windows',3,18),(9,'Zenbook','ASUS','32','1024','16','8','Windows',3,21),(10,'Zephyre','ASUS','16','1024','16','8','Windows',3,5);
/*!40000 ALTER TABLE `laptop_model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laptopOrder`
--

DROP TABLE IF EXISTS `laptopOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laptopOrder` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `deliveryDate` date NOT NULL,
  `orderStatus` varchar(40) NOT NULL,
  `orderDate` date NOT NULL,
  `custID` int NOT NULL,
  PRIMARY KEY (`orderID`),
  KEY `cust_order_fk` (`custID`),
  CONSTRAINT `cust_order_fk` FOREIGN KEY (`custID`) REFERENCES `customer` (`customerID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laptopOrder`
--

LOCK TABLES `laptopOrder` WRITE;
/*!40000 ALTER TABLE `laptopOrder` DISABLE KEYS */;
INSERT INTO `laptopOrder` VALUES (1,'2015-11-18','processing','2015-11-11',1),(2,'2015-12-20','created','2015-12-12',4),(3,'2016-11-18','delivered','2016-11-11',3),(4,'2016-11-18','cancelled','2016-11-11',1),(5,'2017-11-18','created','2017-11-11',2),(6,'2015-11-18','created','2015-11-11',4),(7,'2015-12-20','created','2015-12-12',4),(8,'2016-11-18','delivered','2016-11-11',3),(9,'2016-11-18','cancelled','2016-11-11',1),(10,'2017-11-18','delivered','2017-11-11',2),(11,'2022-12-16','created','2022-12-09',9),(12,'2022-12-16','processing','2022-12-09',2);
/*!40000 ALTER TABLE `laptopOrder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `paymentID` int NOT NULL AUTO_INCREMENT,
  `paymentMode` varchar(50) NOT NULL,
  `cardNumber` varchar(50) NOT NULL,
  `nameOnCard` varchar(50) NOT NULL,
  `employeeID` int NOT NULL,
  `paymentStatus` varchar(64) NOT NULL,
  `orderID` int NOT NULL,
  `customerID` int NOT NULL,
  PRIMARY KEY (`paymentID`),
  KEY `payment_employee_fk` (`employeeID`),
  KEY `payment_order_fk` (`orderID`),
  KEY `payment_customer_fk` (`customerID`),
  CONSTRAINT `payment_customer_fk` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `payment_employee_fk` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`employeeID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `payment_order_fk` FOREIGN KEY (`orderID`) REFERENCES `laptopOrder` (`orderID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'Credit Card','4287482913','Shillman',1,'Completed',1,1),(2,'Debit Card','4287482913','Ashok',2,'Pending',3,3),(3,'Credit Card','4287482913','Smith',3,'refund',2,4),(4,'Credit Card','4287482913','Sam',4,'Pending',5,2),(5,'Debit Card','4287482913','Smith',3,'Pending',7,4),(6,'Debit Card','4287482913','Shillman',1,'Pending',4,1),(7,'Debit Card','4287482913','Ashok',2,'Pending',8,3),(8,'Debit Card','4287482913','Shillman',1,'Pending',9,1),(9,'Debit Card','4287482913','Smith',3,'Pending',6,4),(10,'Debit Card','4287482913','Sam',4,'Pending',10,2),(11,'Credit Card','4543484593','David',3,'Pending',11,4),(12,'Credit Card','123456789','Sam',4,'Completed',12,2);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deletePlaces` AFTER DELETE ON `payment` FOR EACH ROW BEGIN
DELETE FROM places 
WHERE orderID=OLD.orderID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `places`
--

DROP TABLE IF EXISTS `places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `places` (
  `modelID` int NOT NULL,
  `customerID` int NOT NULL,
  `orderID` int NOT NULL,
  PRIMARY KEY (`modelID`,`customerID`,`orderID`),
  KEY `customer_places_fk` (`customerID`),
  KEY `order_places_fk` (`orderID`),
  CONSTRAINT `customer_places_fk` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `model_places_fk` FOREIGN KEY (`modelID`) REFERENCES `laptop_model` (`modelID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `order_places_fk` FOREIGN KEY (`orderID`) REFERENCES `laptopOrder` (`orderID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `places`
--

LOCK TABLES `places` WRITE;
/*!40000 ALTER TABLE `places` DISABLE KEYS */;
INSERT INTO `places` VALUES (1,1,1),(4,1,4),(4,1,9),(4,2,12),(5,2,5),(5,2,10),(3,3,3),(3,3,8),(1,4,6),(2,4,2),(2,4,7),(7,9,11);
/*!40000 ALTER TABLE `places` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `addLapBrand` AFTER INSERT ON `places` FOR EACH ROW BEGIN
DECLARE m INT;
DECLARE n VARCHAR(50);
UPDATE brand
SET numOfProducts=numOfProducts+1
WHERE brandSymbol = (SELECT modelSymbol from laptop_model where modelID = NEW.modelID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `addLapModel` AFTER INSERT ON `places` FOR EACH ROW BEGIN
UPDATE laptop_model
SET numOfLaptops=numOfLaptops+1
WHERE modelID = NEW.modelID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `deleteOrder` AFTER DELETE ON `places` FOR EACH ROW BEGIN
DELETE FROM laptopOrder 
WHERE orderID=OLD.orderID;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `store`
--

DROP TABLE IF EXISTS `store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store` (
  `storeID` int NOT NULL AUTO_INCREMENT,
  `phoneNo` varchar(50) NOT NULL,
  `location` varchar(50) NOT NULL,
  `brandSymbol` varchar(50) NOT NULL,
  PRIMARY KEY (`storeID`),
  KEY `store_brand_fk` (`brandSymbol`),
  CONSTRAINT `store_brand_fk` FOREIGN KEY (`brandSymbol`) REFERENCES `brand` (`brandSymbol`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store`
--

LOCK TABLES `store` WRITE;
/*!40000 ALTER TABLE `store` DISABLE KEYS */;
INSERT INTO `store` VALUES (1,'931330933','Boston','AAPL'),(2,'931330933','Sayreville','DELL'),(3,'931330933','NYC','AAPL'),(4,'931330933','Seattle','DELL');
/*!40000 ALTER TABLE `store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'laptop_ordering'
--

--
-- Dumping routines for database 'laptop_ordering'
--
/*!50003 DROP FUNCTION IF EXISTS `getCustomerID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getCustomerID`(
customerEmail_IN VARCHAR(50)
) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN

DECLARE result INT;

IF customerEmail_IN NOT IN (SELECT customerEmail from customer) THEN
SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Customer Email not found in customer table', MYSQL_ERRNO = 1001;
END IF;

SELECT customerID from customer where customerEmail = customerEmail_IN INTO result;

RETURN result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `getEmployeeID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `getEmployeeID`(
employeeEmail_IN VARCHAR(50)
) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN

DECLARE result INT;

IF employeeEmail_IN NOT IN (SELECT employeeEmail from employee) THEN
SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Employee Email not found in employee table', MYSQL_ERRNO = 1001;
END IF;

SELECT employeeID from employee where employeeEmail = employeeEmail_IN INTO result;

RETURN result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `returnOrderStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `returnOrderStatus`(
lapOrderID INT
) RETURNS varchar(64) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN

DECLARE result VARCHAR(64);

IF lapOrderID NOT IN (SELECT orderID from laptopOrder) THEN
SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'orderID not found in order table', MYSQL_ERRNO = 1001;
END IF;

SELECT orderStatus FROM laptopOrder WHERE orderID=lapOrderID INTO result;

RETURN result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `returnPaymentStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `returnPaymentStatus`(
orderIDInput INT
) RETURNS varchar(64) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN

DECLARE result VARCHAR(64);

IF orderIDInput NOT IN (SELECT orderID from payment) THEN
SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'orderID not found in payment table', MYSQL_ERRNO = 1001;
END IF;

SELECT paymentStatus FROM payment WHERE orderIDInput=orderID INTO result;

RETURN result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cancelOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancelOrder`(IN orderID_IN INT, IN customerID_IN INT)
BEGIN
      DECLARE errno INT;
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
		GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
		SELECT errno AS MYSQL_ERROR;
		ROLLBACK;
		END;
		START TRANSACTION;
        IF (SELECT custID from laptopOrder where orderID = orderID_IN) not in (customerID_IN) THEN
		SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Customer is not allowed to cancel', MYSQL_ERRNO = 1002;
		END IF;
        IF (SELECT orderStatus from laptopOrder where orderID = orderID_IN) in ("cancelled") THEN
		SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Order has already been cancelled', MYSQL_ERRNO = 1001;
		END IF;
        IF (SELECT orderStatus from laptopOrder where orderID = orderID_IN) in ("delivered") THEN
		SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Order has already been delivered', MYSQL_ERRNO = 1100;
		END IF;
      UPDATE laptopOrder SET orderStatus = "cancelled" where orderID =  orderID_IN and custID = customerID_IN ;
      UPDATE payment SET paymentStatus = "refund" where orderID =  orderID_IN ;
      COMMIT WORK;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkCustomerPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkCustomerPassword`(IN customerEmail_IN VARCHAR(50))
BEGIN
      SELECT customerPassword from customer where customerEmail = customerEmail_IN;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkEmployeePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkEmployeePassword`(IN employeeEmail_IN VARCHAR(50))
BEGIN
      SELECT employeePassword from employee where employeeEmail = employeeEmail_IN;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createCustomer`( IN customerFirstName VARCHAR(30),
IN customerLastName VARCHAR(30),
IN customerEmail VARCHAR(30),
IN customerMobile VARCHAR(30),
IN customerPassword VARCHAR(30),
IN buildingNo INT,
IN city VARCHAR(30),
IN state VARCHAR(30),
IN zipcode INT)
BEGIN
DECLARE errno INT;
DECLARE custID INT;
DECLARE randEmp INT;
DECLARE randEmpStore INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    SELECT errno AS MYSQL_ERROR;
    ROLLBACK;
    END;

    START TRANSACTION;
INSERT INTO customer VALUES (null, customerFirstName, customerLastName, customerEmail, customerMobile, customerPassword);
SELECT MAX(customerID) FROM customer INTO custID;
INSERT INTO address values(null, buildingNo, city, state, "USA", zipcode, custID);
select (ceil( RAND( ) * custID)) FROM employee LIMIT 1  into randEmp;
select storeID FROM employee where employeeID = randEmp into randEmpStore;
INSERT INTO assists(storeID, customerID, employeeID) VALUES  (randEmpStore, custID, randEmp);
COMMIT WORK;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `createEmployee` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createEmployee`(
IN employeeFirstName VARCHAR(30),
IN employeeLastName VARCHAR(30),
IN employeeEmail VARCHAR(30),
IN employeeMobile VARCHAR(30),
IN employeeAge INT,
IN employeeStoreID INT,
IN employeePassword VARCHAR(30))
BEGIN
DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    SELECT errno AS MYSQL_ERROR;
    ROLLBACK;
    END;

    START TRANSACTION;
INSERT INTO employee VALUES (null, employeeFirstName, employeeLastName, employeeEmail, employeeMobile, employeeAge, employeeStoreID, employeePassword);
COMMIT WORK;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `deleteCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteCustomer`(IN customerID_IN INT)
BEGIN

IF customerID_IN IN (SELECT customerID FROM assists) THEN
DELETE FROM assists WHERE customerID = customerID_IN;
COMMIT;
END IF;

IF customerID_IN IN (SELECT customerID FROM payment) THEN
DELETE FROM payment WHERE customerID = customerID_IN;
COMMIT;
END IF;

IF customerID_IN NOT IN (SELECT customerID FROM places) THEN
DELETE FROM address WHERE custID = customerID_IN;
COMMIT;
END IF;

IF customerID_IN IN (SELECT custID FROM address) THEN
DELETE FROM address WHERE custID = customerID_IN;
COMMIT;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getListCustomers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getListCustomers`(IN employeeID_IN INT)
BEGIN
      SELECT customerID from assists where employeeID = employeeID_IN;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getOrdersListCust` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getOrdersListCust`(IN customerID_IN INT, IN employeeID_IN INT)
BEGIN
      SELECT orderID, nameOnCard from payment where paymentStatus = "Pending" and customerID = customerID_IN and employeeID = employeeID_IN;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertOrder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertOrder`(IN customerID_IN INT, IN modelID_IN INT)
BEGIN
      DECLARE currDate DATE;
      DECLARE delDate DATE;
      DECLARE orderID_var INT;
		DECLARE errno INT;
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
		GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
		SELECT errno AS MYSQL_ERROR;
		ROLLBACK;
		END;
		START TRANSACTION;
      SELECT CAST( CURDATE() AS DATE ) INTO currDate;
      SELECT DATE_ADD(currDate, INTERVAL 7 DAY) INTO delDate;
      INSERT INTO laptopOrder VALUES (null, delDate, "created", currDate, customerID_IN);
      SELECT MAX(orderID) FROM laptopOrder INTO orderID_var;
     INSERT INTO places VALUES (modelID_IN, customerID_IN, orderID_var);
	  COMMIT WORK;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertPayment`(IN customerID_IN INT, IN paymentMode_IN VARCHAR(50), IN cardNumber_IN VARCHAR(50), IN nameOnCard_IN VARCHAR(50))
BEGIN
      DECLARE orderID_var INT;
      DECLARE employeeID_var INT;
      DECLARE errno INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
    GET CURRENT DIAGNOSTICS CONDITION 1 errno = MYSQL_ERRNO;
    SELECT errno AS MYSQL_ERROR;
    ROLLBACK;
    END;

    START TRANSACTION;
      SELECT MAX(orderID) FROM laptopOrder INTO orderID_var;
      select DISTINCT a1.employeeID INTO employeeID_var from places as p join laptopOrder as lo on p.orderID = lo.orderID 
      join customer as c on p.customerID = c.customerID join assists as a1 on a1.customerID = customerID_IN;
      INSERT INTO payment(paymentID, paymentMode, cardNumber, nameOnCard, employeeID, paymentStatus, orderID, customerID) 
	  VALUES  (null, paymentMode_IN, cardNumber_IN, nameOnCard_IN, employeeID_var, "Pending", orderID_var, customerID_IN);
	  COMMIT WORK;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listLaptopModels` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listLaptopModels`()
BEGIN
      SELECT modelID, modelName, modelSymbol, RAM, SSD, screenSize, gpu, operatingSystem from laptop_model;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `listOrdersCustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `listOrdersCustomer`(IN customerID_IN INT)
BEGIN
      SELECT * from laptopOrder where custID = customerID_IN;
      COMMIT;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `returnBrandCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `returnBrandCount`()
BEGIN
      SELECT brandName, numOfProducts from brand;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `returnCustomerEmails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `returnCustomerEmails`()
BEGIN
      SELECT customerEmail from customer;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `returnEmployeeEmails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `returnEmployeeEmails`()
BEGIN
      SELECT employeeEmail from employee;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `returnLaptopModelCount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `returnLaptopModelCount`()
BEGIN
      SELECT concat(modelSymbol,"  ",modelName) AS model, numOfLaptops from laptop_model;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCustomerPassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCustomerPassword`(IN customerID_IN INT, IN customerPassword_IN VARCHAR(50))
BEGIN
      UPDATE customer SET customerPassword = customerPassword_IN where customerID =  customerID_IN;
      COMMIT;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateCustomerPhone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCustomerPhone`(IN customerID_IN INT, IN customerPhone_IN VARCHAR(50))
BEGIN
      UPDATE customer SET customerPhone = customerPhone_IN where customerID =  customerID_IN;
      COMMIT;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEmployeePassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeePassword`(IN employeeID_IN INT, IN employeePassword_IN VARCHAR(50))
BEGIN
      UPDATE employee SET employeePassword = employeePassword_IN where employeeID =  employeeID_IN;
      COMMIT;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updateEmployeePhone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateEmployeePhone`(IN employeeID_IN INT, IN employeePhone_IN VARCHAR(50))
BEGIN
      UPDATE employee SET employeePhone = employeePhone_IN where employeeID =  employeeID_IN;
      COMMIT;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `updatePaymentStatus` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePaymentStatus`(IN employeeID_IN INT, IN orderID_IN INT, IN customerID_IN INT)
BEGIN
      DECLARE employeeID_var INT;
      UPDATE payment SET paymentStatus = "Completed" where employeeID =  employeeID_IN and orderID = orderID_IN;
      SELECT employeeID into employeeID_var from assists where customerID = customerID_IN;
      UPDATE laptopOrder SET orderStatus = "processing" where orderID =  orderID_IN and custID = customerID_IN;
      COMMIT;
      END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-09 19:59:58

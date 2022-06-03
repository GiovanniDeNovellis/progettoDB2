CREATE DATABASE  IF NOT EXISTS `new_schema` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `new_schema`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: new_schema
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `activation-schedule`
--

DROP TABLE IF EXISTS `activation-schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activation-schedule` (
  `package` int NOT NULL,
  `orderid` int NOT NULL,
  `optproduct` int DEFAULT NULL,
  `actdate` datetime DEFAULT NULL,
  `deactdate` datetime DEFAULT NULL,
  `bridge_id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`bridge_id`),
  UNIQUE KEY `bridge_id_UNIQUE` (`bridge_id`),
  KEY `package_idx` (`package`),
  KEY `order_idx` (`orderid`),
  KEY `product_idx` (`optproduct`),
  CONSTRAINT `orderid` FOREIGN KEY (`orderid`) REFERENCES `order` (`id`),
  CONSTRAINT `package` FOREIGN KEY (`package`) REFERENCES `service-package` (`ID`),
  CONSTRAINT `product` FOREIGN KEY (`optproduct`) REFERENCES `optional-product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `activation-schedule_AFTER_INSERT` AFTER INSERT ON `activation-schedule` FOR EACH ROW BEGIN
	IF new.status = 'Valid' AND new.optproduct IS NOT NULL
    THEN
		UPDATE `new_schema`.`avg-opt-for-package`
		SET numopttot = numopttot + 1,
		avgoptforsale = numopttot / numsales
		WHERE servicePackage = new.package;
		
		UPDATE `new_schema`.`sales-package`
		SET totalwithopt = totalwithopt + (SELECT monthlyfee FROM `optional-product` WHERE ID = new.optproduct) * (SELECT valperiod from `order` WHERE id = new.orderid)
		WHERE servicePackage = new.package;
		
		UPDATE `new_schema`.`sales-optional-product`
		SET totalsalesvalue = totalsalesvalue + (SELECT monthlyfee FROM `optional-product` WHERE ID = new.optproduct) * (SELECT valperiod from `order` WHERE id = new.orderid)
		WHERE optproductid = new.optproduct;
    END IF;
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `package-opt-bridge_AFTER_UPDATE` AFTER UPDATE ON `activation-schedule` FOR EACH ROW BEGIN
	IF new.status = 'Valid' AND old.status <> 'Valid' AND new.optproduct IS NOT null
    THEN
		UPDATE `new_schema`.`avg-opt-for-package`
		SET numopttot = numopttot + 1,
		avgoptforsale = numopttot / numsales
		WHERE servicePackage = new.package;
		
		UPDATE `new_schema`.`sales-package`
		SET totalwithopt = totalwithopt + (SELECT monthlyfee FROM `optional-product` WHERE ID = new.optproduct) * (SELECT valperiod from `order` WHERE id = new.orderid)
		WHERE servicePackage = new.package;
		
		UPDATE `new_schema`.`sales-optional-product`
		SET totalsalesvalue = totalsalesvalue + (SELECT monthlyfee FROM `optional-product` WHERE ID = new.optproduct) * (SELECT valperiod from `order` WHERE id = new.orderid)
		WHERE optproductid = new.optproduct;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert` (
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `amount` float NOT NULL,
  `datetimelastrejection` datetime NOT NULL,
  PRIMARY KEY (`username`),
  KEY `mail_idx` (`email`),
  CONSTRAINT `alertusername` FOREIGN KEY (`username`) REFERENCES `user` (`username`),
  CONSTRAINT `mail` FOREIGN KEY (`email`) REFERENCES `user` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `alert_AFTER_INSERT` AFTER INSERT ON `alert` FOR EACH ROW BEGIN
	INSERT INTO `new_schema`.`alert-history`(username, amount, datetimerejection)
    VALUES (new.username, new.amount, new.datetimelastrejection);
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `alert_AFTER_UPDATE` AFTER UPDATE ON `alert` FOR EACH ROW BEGIN
	INSERT INTO `new_schema`.`alert-history`(username, amount, datetimerejection)
    VALUES (new.username, new.amount, new.datetimelastrejection);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `alert-history`
--

DROP TABLE IF EXISTS `alert-history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert-history` (
  `username` varchar(64) NOT NULL,
  `amount` float NOT NULL,
  `datetimerejection` datetime NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `usernickname_idx` (`username`),
  CONSTRAINT `user` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `avg-opt-for-package`
--

DROP TABLE IF EXISTS `avg-opt-for-package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avg-opt-for-package` (
  `servicePackage` int NOT NULL,
  `numopttot` int DEFAULT '0',
  `numsales` int NOT NULL DEFAULT '0',
  `avgoptforsale` float DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `avgpckgid_idx` (`servicePackage`),
  CONSTRAINT `avgpckgid` FOREIGN KEY (`servicePackage`) REFERENCES `service-package` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `avgoptforpackage`
--

DROP TABLE IF EXISTS `avgoptforpackage`;
/*!50001 DROP VIEW IF EXISTS `avgoptforpackage`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `avgoptforpackage` AS SELECT 
 1 AS `average`,
 1 AS `package`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `best-opt-product`
--

DROP TABLE IF EXISTS `best-opt-product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `best-opt-product` (
  `productid` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `opprod_idx` (`productid`),
  CONSTRAINT `opprod` FOREIGN KEY (`productid`) REFERENCES `optional-product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `bestoptproductview`
--

DROP TABLE IF EXISTS `bestoptproductview`;
/*!50001 DROP VIEW IF EXISTS `bestoptproductview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bestoptproductview` AS SELECT 
 1 AS `optproductid`,
 1 AS `totalsalesvalue`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `insolvent-users`
--

DROP TABLE IF EXISTS `insolvent-users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insolvent-users` (
  `idinsolventuser` varchar(64) NOT NULL,
  PRIMARY KEY (`idinsolventuser`),
  CONSTRAINT `idinsolvent` FOREIGN KEY (`idinsolventuser`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `num-purch-package`
--

DROP TABLE IF EXISTS `num-purch-package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `num-purch-package` (
  `packageid` int NOT NULL,
  `numpurchases` int DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `packageid_idx` (`packageid`),
  CONSTRAINT `pkid` FOREIGN KEY (`packageid`) REFERENCES `service-package` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `num-purch-package-val-period`
--

DROP TABLE IF EXISTS `num-purch-package-val-period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `num-purch-package-val-period` (
  `packageid` int NOT NULL,
  `valperiod` int NOT NULL,
  `numpurchases` int DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `packid_idx` (`packageid`),
  CONSTRAINT `packid` FOREIGN KEY (`packageid`) REFERENCES `service-package` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `numprodforpackage`
--

DROP TABLE IF EXISTS `numprodforpackage`;
/*!50001 DROP VIEW IF EXISTS `numprodforpackage`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `numprodforpackage` AS SELECT 
 1 AS `numProd`,
 1 AS `package`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `numpurchpackage`
--

DROP TABLE IF EXISTS `numpurchpackage`;
/*!50001 DROP VIEW IF EXISTS `numpurchpackage`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `numpurchpackage` AS SELECT 
 1 AS `packageid`,
 1 AS `numpurchases`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `numpurchpackagevalperiod`
--

DROP TABLE IF EXISTS `numpurchpackagevalperiod`;
/*!50001 DROP VIEW IF EXISTS `numpurchpackagevalperiod`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `numpurchpackagevalperiod` AS SELECT 
 1 AS `packageid`,
 1 AS `numpurchases`,
 1 AS `valperiod`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `optional-product`
--

DROP TABLE IF EXISTS `optional-product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optional-product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `monthlyfee` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `optional-product_AFTER_INSERT` AFTER INSERT ON `optional-product` FOR EACH ROW BEGIN
	INSERT INTO `new_schema`.`sales-optional-product`(optproductid, totalsalesvalue)
    VALUES(new.id, 0);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `creationdate` datetime NOT NULL,
  `valperiod` int NOT NULL,
  `totalvalue` int NOT NULL,
  `startdate` datetime NOT NULL,
  `status` varchar(45) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `packageid` int DEFAULT NULL,
  `fee` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `username_idx` (`username`),
  KEY `packageid_idx` (`packageid`),
  CONSTRAINT `packageid` FOREIGN KEY (`packageid`) REFERENCES `service-package` (`ID`),
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `order_AFTER_INSERT` AFTER INSERT ON `order` FOR EACH ROW BEGIN
	IF new.status = 'Valid' 
    THEN
    UPDATE `new_schema`.`num-purch-package`
		SET numpurchases = numpurchases + 1
		WHERE packageid = new.packageid;
        
		UPDATE `new_schema`.`num-purch-package-val-period` 
		SET numpurchases = numpurchases + 1
		WHERE packageid = new.packageid
		AND valperiod = new.valperiod;
        
		UPDATE `new_schema`.`sales-package`
		SET totalwithoutopt = totalwithoutopt + new.fee * new.valperiod
        WHERE servicePackage = new.packageid;
        
        UPDATE `new_schema`.`sales-package`
		SET totalwithopt = totalwithopt + new.fee * new.valperiod
        WHERE servicePackage = new.packageid;
        
        UPDATE `new_schema`.`avg-opt-for-package`
		SET numsales = numsales + 1,
		avgoptforsale = numopttot / numsales
		WHERE servicePackage = new.packageid;
        
	END IF;
    
    IF new.status = 'Suspended' THEN
		INSERT INTO `new_schema`.`suspended-orders`(idsuspendedorders)
		VALUES(new.id);
	END IF;
		
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `order_AFTER_UPDATE` AFTER UPDATE ON `order` FOR EACH ROW BEGIN
	IF new.status = 'Valid' AND old.status <> 'Valid'
    THEN
		UPDATE `new_schema`.`num-purch-package`
		SET numpurchases = numpurchases + 1
		WHERE packageid = new.packageid;
        
		UPDATE `new_schema`.`num-purch-package-val-period` 
		SET numpurchases = numpurchases + 1
		WHERE packageid = new.packageid
		AND valperiod = new.valperiod;
        
		UPDATE `new_schema`.`sales-package`
		SET totalwithoutopt = totalwithoutopt + new.fee * new.valperiod
        WHERE servicePackage = new.packageid;
        
        UPDATE `new_schema`.`sales-package`
		SET totalwithopt = totalwithopt + new.fee * new.valperiod
        WHERE servicePackage = new.packageid;
        
        UPDATE `new_schema`.`avg-opt-for-package`
		SET numsales = numsales + 1,
		avgoptforsale = numopttot / numsales
		WHERE servicePackage = new.packageid;
        
	END IF;
    
    IF old.status = 'Suspended' AND new.status <> 'Suspended' 
    AND new.id IN (SELECT idsuspendedorders FROM `suspended-orders`)
    THEN
		DELETE FROM `new_schema`.`suspended-orders`
        WHERE idsuspendedorders = new.id;
	END IF;
    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `package-opt-association`
--

DROP TABLE IF EXISTS `package-opt-association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package-opt-association` (
  `packageid` int NOT NULL,
  `optprodid` int NOT NULL,
  PRIMARY KEY (`packageid`,`optprodid`),
  KEY `assproduct_idx` (`optprodid`),
  CONSTRAINT `asspackage` FOREIGN KEY (`packageid`) REFERENCES `service-package` (`ID`),
  CONSTRAINT `assproduct` FOREIGN KEY (`optprodid`) REFERENCES `optional-product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sales-optional-product`
--

DROP TABLE IF EXISTS `sales-optional-product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales-optional-product` (
  `optproductid` int NOT NULL,
  `totalsalesvalue` float NOT NULL DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productid_UNIQUE` (`optproductid`),
  CONSTRAINT `optprodid` FOREIGN KEY (`optproductid`) REFERENCES `optional-product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `sales-optional-product_BEFORE_UPDATE` BEFORE UPDATE ON `sales-optional-product` FOR EACH ROW BEGIN
	IF NOT EXISTS (SELECT * FROM `best-opt-product`)
    THEN
		INSERT INTO `new_schema`.`best-opt-product`(productid)
		VALUES(new.optproductid);
	ELSEIF new.totalsalesvalue > (SELECT totalsalesvalue FROM `sales-optional-product` 
			WHERE optproductid = (SELECT productid from `best-opt-product`))
	THEN 
        UPDATE `new_schema`.`best-opt-product`
        SET productid = new.optproductid;
    END IF;    
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sales-package`
--

DROP TABLE IF EXISTS `sales-package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales-package` (
  `servicePackage` int NOT NULL,
  `totalwithopt` float DEFAULT '0',
  `totalwithoutopt` float DEFAULT '0',
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `spid_idx` (`servicePackage`),
  CONSTRAINT `spid` FOREIGN KEY (`servicePackage`) REFERENCES `service-package` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `salesoptionalproduct`
--

DROP TABLE IF EXISTS `salesoptionalproduct`;
/*!50001 DROP VIEW IF EXISTS `salesoptionalproduct`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `salesoptionalproduct` AS SELECT 
 1 AS `optproductid`,
 1 AS `totalsalesvalue`,
 1 AS `servicepackageid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `salespackageonlyopt`
--

DROP TABLE IF EXISTS `salespackageonlyopt`;
/*!50001 DROP VIEW IF EXISTS `salespackageonlyopt`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `salespackageonlyopt` AS SELECT 
 1 AS `sum2`,
 1 AS `id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `salespackagewithopt`
--

DROP TABLE IF EXISTS `salespackagewithopt`;
/*!50001 DROP VIEW IF EXISTS `salespackagewithopt`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `salespackagewithopt` AS SELECT 
 1 AS `totalVal`,
 1 AS `packageid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `salespackagewithoutopt`
--

DROP TABLE IF EXISTS `salespackagewithoutopt`;
/*!50001 DROP VIEW IF EXISTS `salespackagewithoutopt`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `salespackagewithoutopt` AS SELECT 
 1 AS `sum1`,
 1 AS `packageid`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `serviceid` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `minutes` int DEFAULT '0',
  `sms` int DEFAULT '0',
  `extraminfee` float DEFAULT '0',
  `extrasmsfee` float DEFAULT '0',
  `giga` int DEFAULT '0',
  `extragigafee` float DEFAULT '0',
  `service_package_id` int DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`serviceid`),
  UNIQUE KEY `serviceid_UNIQUE` (`serviceid`),
  KEY `service_package_id_idx` (`service_package_id`),
  CONSTRAINT `service_package_id` FOREIGN KEY (`service_package_id`) REFERENCES `service-package` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `service-package`
--

DROP TABLE IF EXISTS `service-package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service-package` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `monthscost12` float NOT NULL,
  `monthscost24` float NOT NULL,
  `monthscost36` float NOT NULL,
  PRIMARY KEY (`ID`,`name`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `service-package_AFTER_INSERT` AFTER INSERT ON `service-package` FOR EACH ROW BEGIN
	INSERT INTO `new_schema`.`num-purch-package`(packageid, numpurchases)
    VALUES(new.ID, 0);
    INSERT INTO `new_schema`.`num-purch-package-val-period`(packageid, numpurchases, valperiod)
    VALUES(new.ID, 0, 12);
    INSERT INTO `new_schema`.`num-purch-package-val-period`(packageid, numpurchases, valperiod)
    VALUES(new.ID, 0, 24);
    INSERT INTO `new_schema`.`num-purch-package-val-period`(packageid, numpurchases, valperiod)
    VALUES(new.ID, 0, 36);
    INSERT INTO `new_schema`.`sales-package`(servicePackage, totalwithopt, totalwithoutopt)
    VALUES(new.ID, 0, 0);
    INSERT INTO `new_schema`.`avg-opt-for-package`(servicePackage, numopttot, numsales, avgoptforsale)
    VALUES(new.ID, 0, 0, 0);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `suspended-orders`
--

DROP TABLE IF EXISTS `suspended-orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suspended-orders` (
  `idsuspendedorders` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `ordid` (`idsuspendedorders`),
  CONSTRAINT `ordid` FOREIGN KEY (`idsuspendedorders`) REFERENCES `order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `username` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `type` varchar(8) NOT NULL,
  `isInsolvent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `numrejections` int DEFAULT '0',
  PRIMARY KEY (`username`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `user_AFTER_UPDATE` AFTER UPDATE ON `user` FOR EACH ROW BEGIN
	IF new.isInsolvent = '1' AND old.isInsolvent = '0' THEN
		INSERT INTO `new_schema`.`insolvent-users`(idinsolventuser)
		VALUES (new.username);
    END IF;
    
    IF new.isInsolvent = '0' AND old.isInsolvent = '1' 
	AND new.username IN (SELECT idinsolventuser FROM `new_schema`.`insolvent-users`)
	THEN
		DELETE FROM `new_schema`.`insolvent-users`
		WHERE idinsolventuser = new.username;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `avgoptforpackage`
--

/*!50001 DROP VIEW IF EXISTS `avgoptforpackage`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `avgoptforpackage` AS select (`n2`.`numpurchases` / `n1`.`numProd`) AS `average`,`n1`.`package` AS `package` from (`numprodforpackage` `n1` join `numpurchpackage` `n2` on((`n1`.`package` = `n2`.`packageid`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `bestoptproductview`
--

/*!50001 DROP VIEW IF EXISTS `bestoptproductview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bestoptproductview` AS select `salesoptionalproduct`.`optproductid` AS `optproductid`,`salesoptionalproduct`.`totalsalesvalue` AS `totalsalesvalue` from `salesoptionalproduct` limit 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `numprodforpackage`
--

/*!50001 DROP VIEW IF EXISTS `numprodforpackage`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `numprodforpackage` AS select count(0) AS `numProd`,`a`.`package` AS `package` from `activation-schedule` `a` where (`a`.`optproduct` is not null) group by `a`.`package` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `numpurchpackage`
--

/*!50001 DROP VIEW IF EXISTS `numpurchpackage`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `numpurchpackage` AS select `order`.`packageid` AS `packageid`,count(`order`.`packageid`) AS `numpurchases` from `order` group by `order`.`packageid` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `numpurchpackagevalperiod`
--

/*!50001 DROP VIEW IF EXISTS `numpurchpackagevalperiod`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `numpurchpackagevalperiod` AS select `order`.`packageid` AS `packageid`,count(`order`.`packageid`) AS `numpurchases`,`order`.`valperiod` AS `valperiod` from `order` group by `order`.`packageid` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `salesoptionalproduct`
--

/*!50001 DROP VIEW IF EXISTS `salesoptionalproduct`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `salesoptionalproduct` AS select `activation-schedule`.`optproduct` AS `optproductid`,sum((`opt`.`monthlyfee` * `ord`.`valperiod`)) AS `totalsalesvalue`,`activation-schedule`.`package` AS `servicepackageid` from ((`activation-schedule` join `order` `ord` on((`activation-schedule`.`orderid` = `ord`.`id`))) join `optional-product` `opt` on((`activation-schedule`.`optproduct` = `opt`.`id`))) group by `activation-schedule`.`optproduct` order by `totalsalesvalue` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `salespackageonlyopt`
--

/*!50001 DROP VIEW IF EXISTS `salespackageonlyopt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `salespackageonlyopt` AS select sum((`opt`.`monthlyfee` * `ord`.`valperiod`)) AS `sum2`,`p`.`ID` AS `id` from (((`activation-schedule` `a` join `optional-product` `opt`) join `service-package` `p`) join `order` `ord` on(((`a`.`optproduct` = `opt`.`id`) and (`a`.`package` = `p`.`ID`) and (`a`.`orderid` = `ord`.`id`)))) where (`a`.`status` = 'Valid') group by `p`.`ID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `salespackagewithopt`
--

/*!50001 DROP VIEW IF EXISTS `salespackagewithopt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `salespackagewithopt` AS select (`s1`.`sum1` + `s2`.`sum2`) AS `totalVal`,`s1`.`packageid` AS `packageid` from (`salespackagewithoutopt` `s1` join `salespackageonlyopt` `s2` on((`s1`.`packageid` = `s2`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `salespackagewithoutopt`
--

/*!50001 DROP VIEW IF EXISTS `salespackagewithoutopt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `salespackagewithoutopt` AS select sum((`o`.`fee` * `o`.`valperiod`)) AS `sum1`,`o`.`packageid` AS `packageid` from `order` `o` where (`o`.`status` = 'Valid') group by `o`.`packageid` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-03 21:48:52

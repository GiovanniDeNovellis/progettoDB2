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
-- Table structure for table `alert`
--

DROP TABLE IF EXISTS `alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert` (
  `userid` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `amount` float NOT NULL,
  `datelastrejection` datetime NOT NULL,
  PRIMARY KEY (`userid`),
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert-history`
--

DROP TABLE IF EXISTS `alert-history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert-history` (
  `idalerthistory` int NOT NULL,
  `username` varchar(64) NOT NULL,
  `amount` float NOT NULL,
  `daterejection` datetime NOT NULL,
  PRIMARY KEY (`idalerthistory`),
  KEY `usernickname_idx` (`username`),
  CONSTRAINT `usernickname` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert-history`
--

LOCK TABLES `alert-history` WRITE;
/*!40000 ALTER TABLE `alert-history` DISABLE KEYS */;
/*!40000 ALTER TABLE `alert-history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avg-opt-for-package`
--

DROP TABLE IF EXISTS `avg-opt-for-package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avg-opt-for-package` (
  `id` int NOT NULL,
  `numopttot` int DEFAULT '0',
  `numsales` int NOT NULL DEFAULT '0',
  `avgoptforsale` float DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `avgpckgid` FOREIGN KEY (`id`) REFERENCES `service-package` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avg-opt-for-package`
--

LOCK TABLES `avg-opt-for-package` WRITE;
/*!40000 ALTER TABLE `avg-opt-for-package` DISABLE KEYS */;
INSERT INTO `avg-opt-for-package` VALUES (1,3,1,3);
/*!40000 ALTER TABLE `avg-opt-for-package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `best-optional-product`
--

DROP TABLE IF EXISTS `best-optional-product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `best-optional-product` (
  `id` int NOT NULL,
  `salesvalue` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `prodid` FOREIGN KEY (`id`) REFERENCES `optional-product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `best-optional-product`
--

LOCK TABLES `best-optional-product` WRITE;
/*!40000 ALTER TABLE `best-optional-product` DISABLE KEYS */;
INSERT INTO `best-optional-product` VALUES (4,75);
/*!40000 ALTER TABLE `best-optional-product` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `insolvent-users`
--

LOCK TABLES `insolvent-users` WRITE;
/*!40000 ALTER TABLE `insolvent-users` DISABLE KEYS */;
/*!40000 ALTER TABLE `insolvent-users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `num-purch-package`
--

DROP TABLE IF EXISTS `num-purch-package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `num-purch-package` (
  `packageid` int NOT NULL,
  `numpurchases` int DEFAULT '0',
  PRIMARY KEY (`packageid`),
  CONSTRAINT `id` FOREIGN KEY (`packageid`) REFERENCES `service-package` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `num-purch-package`
--

LOCK TABLES `num-purch-package` WRITE;
/*!40000 ALTER TABLE `num-purch-package` DISABLE KEYS */;
INSERT INTO `num-purch-package` VALUES (1,1);
/*!40000 ALTER TABLE `num-purch-package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `num-purch-package-val-period`
--

DROP TABLE IF EXISTS `num-purch-package-val-period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `num-purch-package-val-period` (
  `packageid` int NOT NULL,
  `valperiod` int DEFAULT NULL,
  `numpurchases` int DEFAULT '0',
  PRIMARY KEY (`packageid`),
  CONSTRAINT `idpack` FOREIGN KEY (`packageid`) REFERENCES `service-package` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `num-purch-package-val-period`
--

LOCK TABLES `num-purch-package-val-period` WRITE;
/*!40000 ALTER TABLE `num-purch-package-val-period` DISABLE KEYS */;
/*!40000 ALTER TABLE `num-purch-package-val-period` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optional-product`
--

DROP TABLE IF EXISTS `optional-product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `optional-product` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `monthlyfee` float NOT NULL,
  `totalSalesValue` float DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional-product`
--

LOCK TABLES `optional-product` WRITE;
/*!40000 ALTER TABLE `optional-product` DISABLE KEYS */;
INSERT INTO `optional-product` VALUES (1,'firstprod',15,0),(2,'secprod',20,100),(3,'thirdprod',18,90),(4,'fourthprod',15,75);
/*!40000 ALTER TABLE `optional-product` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `optional-product_AFTER_UPDATE` AFTER UPDATE ON `optional-product` FOR EACH ROW BEGIN
	IF  NOT EXISTS (SELECT salesvalue FROM `new_schema`.`best-optional-product`) THEN
		INSERT INTO `new_schema`.`best-optional-product`(id, salesvalue)
		VALUES(new.id, new.totalSalesValue);
    ELSEIF new.totalSalesValue > (SELECT salesvalue FROM `new_schema`.`best-optional-product`) THEN
		UPDATE `new_schema`.`best-optional-product` SET
			id = new.id,
            salesvalue = new.totalSalesValue;
	END IF;
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
  `id` int NOT NULL,
  `creationdate` datetime NOT NULL,
  `valperiod` int NOT NULL,
  `totalvalue` int NOT NULL,
  `startdate` datetime NOT NULL,
  `status` varchar(45) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `packageid` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `username_idx` (`username`),
  KEY `packageid_idx` (`packageid`),
  CONSTRAINT `packageid` FOREIGN KEY (`packageid`) REFERENCES `service-package` (`ID`),
  CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2022-03-29 00:00:00',5,45,'2022-03-29 00:00:00','Valid','giova',1);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `UPDATESALES` AFTER UPDATE ON `order` FOR EACH ROW BEGIN
	IF new.status = 'Valid' AND old.status <> 'Valid' THEN
		UPDATE `new_schema`.`avg-opt-for-package`
		SET numsales = numsales + 1,
		avgoptforsale = numopttot / numsales
		WHERE id = new.packageid;
        
        UPDATE `new_schema`.`num-purch-package`
        SET numpurchases = numpurchases + 1
        WHERE packageid = new.packageid;
	END IF;	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `package-opt-bridge`
--

DROP TABLE IF EXISTS `package-opt-bridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package-opt-bridge` (
  `package` int NOT NULL,
  `optproduct` int NOT NULL,
  `actdate` datetime DEFAULT NULL,
  `deactdate` datetime DEFAULT NULL,
  `order` int NOT NULL,
  PRIMARY KEY (`package`,`optproduct`,`order`),
  KEY `optproduct_idx` (`optproduct`),
  KEY `orderid_idx` (`order`),
  CONSTRAINT `optproduct` FOREIGN KEY (`optproduct`) REFERENCES `optional-product` (`id`),
  CONSTRAINT `orderid` FOREIGN KEY (`order`) REFERENCES `order` (`id`),
  CONSTRAINT `package` FOREIGN KEY (`package`) REFERENCES `service-package` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package-opt-bridge`
--

LOCK TABLES `package-opt-bridge` WRITE;
/*!40000 ALTER TABLE `package-opt-bridge` DISABLE KEYS */;
INSERT INTO `package-opt-bridge` VALUES (1,2,'2022-03-25 00:00:00','2022-04-05 00:00:00',1),(1,3,'2022-03-25 00:00:00','2022-04-06 00:00:00',1),(1,4,'2022-03-25 00:00:00','2022-04-06 00:00:00',1);
/*!40000 ALTER TABLE `package-opt-bridge` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `package-opt-bridge_AFTER_INSERT` AFTER INSERT ON `package-opt-bridge` FOR EACH ROW BEGIN
	DECLARE fee int;
    SELECT monthlyfee into fee FROM `optional-product` WHERE id = new.optproduct;
    
    UPDATE `new_schema`.`avg-opt-for-package`
    SET numopttot = numopttot + 1,
    avgoptforsale = numopttot / numsales
    WHERE id = new.package;
    
    UPDATE `new_schema`.`optional-product`
    set totalSalesValue = totalSalesValue + (SELECT ValPeriod FROM `order` WHERE id = new.order) *
				fee
    WHERE id = new.optproduct;
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
  `id` int NOT NULL,
  `totalwithopt` float DEFAULT '0',
  `totalwithoutopt` float DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `spid` FOREIGN KEY (`id`) REFERENCES `service-package` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales-package`
--

LOCK TABLES `sales-package` WRITE;
/*!40000 ALTER TABLE `sales-package` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales-package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `serviceid` int NOT NULL,
  `type` varchar(45) NOT NULL,
  `minutes` int DEFAULT NULL,
  `sms` int DEFAULT NULL,
  `extraminfee` float DEFAULT NULL,
  `extrasmsfee` float DEFAULT NULL,
  `giga` int DEFAULT NULL,
  `extragigafee` float DEFAULT NULL,
  `activationdate` date NOT NULL,
  `deactivationdate` date NOT NULL,
  `service_package_id` int NOT NULL,
  PRIMARY KEY (`serviceid`),
  UNIQUE KEY `serviceid_UNIQUE` (`serviceid`),
  KEY `service_package_id_idx` (`service_package_id`),
  CONSTRAINT `service_package_id` FOREIGN KEY (`service_package_id`) REFERENCES `service-package` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service-package`
--

DROP TABLE IF EXISTS `service-package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service-package` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `valperiod` int NOT NULL,
  `fee` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service-package`
--

LOCK TABLES `service-package` WRITE;
/*!40000 ALTER TABLE `service-package` DISABLE KEYS */;
INSERT INTO `service-package` VALUES (1,'package1',12,50);
/*!40000 ALTER TABLE `service-package` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `service-package_AFTER_INSERT_1` AFTER INSERT ON `service-package` FOR EACH ROW BEGIN
	INSERT INTO `new_schema`.`avg-opt-for-package`(id, numopttot, numsales, avgoptforsale)
    VALUES(new.ID, 0, 0, 0);
    INSERT INTO `new_schema`.`num-purch-package`(packageid, numpurchases)
    VALUES(new.ID, 0);
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
  PRIMARY KEY (`idsuspendedorders`),
  CONSTRAINT `suspenderorderid` FOREIGN KEY (`idsuspendedorders`) REFERENCES `order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suspended-orders`
--

LOCK TABLES `suspended-orders` WRITE;
/*!40000 ALTER TABLE `suspended-orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `suspended-orders` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`username`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('giova','thegiova99@gmail.com','123','User','0');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-30  0:05:26
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activation-schedule`
--

LOCK TABLES `activation-schedule` WRITE;
/*!40000 ALTER TABLE `activation-schedule` DISABLE KEYS */;
INSERT INTO `activation-schedule` VALUES (1,1,1,'2022-03-25 00:00:00','2022-03-25 00:00:00',1,''),(1,1,2,'2022-03-25 00:00:00','2022-04-25 00:00:00',2,''),(1,1,3,'2022-03-25 00:00:00','2022-04-25 00:00:00',3,''),(1,1,4,'2022-03-25 00:00:00','2022-04-25 00:00:00',4,''),(2,21,1,'2022-04-17 23:04:36','2023-04-17 23:04:36',8,''),(2,26,1,'2022-04-17 23:44:39','2023-04-17 23:44:39',9,''),(2,26,4,'2022-04-17 23:44:39','2023-04-17 23:44:39',10,''),(2,27,4,'2022-04-17 23:47:34','2023-04-17 23:47:34',11,''),(2,27,1,'2022-04-17 23:47:34','2023-04-17 23:47:34',12,''),(60,28,4,'2022-04-19 14:36:16','2023-04-19 14:36:16',13,'Valid'),(60,28,1,'2022-04-19 14:36:16','2023-04-19 14:36:16',14,'Valid'),(59,29,3,'2022-04-19 15:07:07','2023-04-19 15:07:07',15,'Valid'),(59,29,2,'2022-04-19 15:07:07','2023-04-19 15:07:07',16,'Valid'),(1,33,NULL,'2022-05-11 00:00:00','2023-05-11 00:00:00',19,'Valid'),(60,40,4,'2022-05-27 00:00:00','2023-05-27 00:00:00',30,'Valid'),(60,40,1,'2022-05-27 00:00:00','2023-05-27 00:00:00',31,'Valid'),(59,41,NULL,'2022-05-12 00:00:00','2024-05-12 00:00:00',32,'Valid');
/*!40000 ALTER TABLE `activation-schedule` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `activation-schedule_AFTER_INSERT` AFTER INSERT ON `activation-schedule` FOR EACH ROW BEGIN
	IF new.status = 'Valid' AND new.optproduct <> null
    THEN
		UPDATE `new_schema`.`avg-opt-for-package`
		SET numopttot = numopttot + 1,
		avgoptforsale = numopttot / numsales
		WHERE id = new.package;
		
		UPDATE `new_schema`.`sales-package`
		SET totalwithopt = totalwithopt + (SELECT monthlyfee FROM `optional-product` WHERE ID = new.optproduct) * (SELECT valperiod from `order` WHERE id = new.orderid)
		WHERE id = new.package;
		
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
	IF new.status = 'Valid' AND old.status <> 'Valid' AND new.optproduct <> null
    THEN
		UPDATE `new_schema`.`avg-opt-for-package`
		SET numopttot = numopttot + 1,
		avgoptforsale = numopttot / numsales
		WHERE id = new.package;
		
		UPDATE `new_schema`.`sales-package`
		SET totalwithopt = totalwithopt + (SELECT monthlyfee FROM `optional-product` WHERE ID = new.optproduct) * (SELECT valperiod from `order` WHERE id = new.orderid)
		WHERE id = new.package;
		
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

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
INSERT INTO `alert` VALUES ('carlo','carlo@gmail.com',30,'2022-03-25 00:00:00'),('giova','thegiova99@gmail.com',1080,'2022-05-04 19:14:24'),('leo','leo@gmail.com',50,'2022-04-18 23:52:05');
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert-history`
--

LOCK TABLES `alert-history` WRITE;
/*!40000 ALTER TABLE `alert-history` DISABLE KEYS */;
INSERT INTO `alert-history` VALUES ('giova',1080,'2022-05-04 19:14:24',11);
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
INSERT INTO `avg-opt-for-package` VALUES (1,4,4,1),(2,6,7,0.857143),(58,0,0,0),(59,2,2,1),(60,2,5,0.4);
/*!40000 ALTER TABLE `avg-opt-for-package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `best-opt-product`
--

DROP TABLE IF EXISTS `best-opt-product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `best-opt-product` (
  `productid` int NOT NULL,
  PRIMARY KEY (`productid`),
  CONSTRAINT `opprod` FOREIGN KEY (`productid`) REFERENCES `optional-product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `best-opt-product`
--

LOCK TABLES `best-opt-product` WRITE;
/*!40000 ALTER TABLE `best-opt-product` DISABLE KEYS */;
INSERT INTO `best-opt-product` VALUES (2);
/*!40000 ALTER TABLE `best-opt-product` ENABLE KEYS */;
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
INSERT INTO `insolvent-users` VALUES ('giova');
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
INSERT INTO `num-purch-package` VALUES (1,4),(2,7),(58,0),(59,2),(60,5);
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
  `valperiod` int NOT NULL,
  `numpurchases` int DEFAULT '0',
  PRIMARY KEY (`packageid`,`valperiod`),
  CONSTRAINT `idpack` FOREIGN KEY (`packageid`) REFERENCES `service-package` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `num-purch-package-val-period`
--

LOCK TABLES `num-purch-package-val-period` WRITE;
/*!40000 ALTER TABLE `num-purch-package-val-period` DISABLE KEYS */;
INSERT INTO `num-purch-package-val-period` VALUES (1,12,3),(1,24,1),(1,36,0),(2,12,7),(2,24,0),(2,36,0),(58,12,0),(58,24,0),(58,36,0),(59,12,1),(59,24,1),(59,36,0),(60,12,5),(60,24,0),(60,36,0);
/*!40000 ALTER TABLE `num-purch-package-val-period` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional-product`
--

LOCK TABLES `optional-product` WRITE;
/*!40000 ALTER TABLE `optional-product` DISABLE KEYS */;
INSERT INTO `optional-product` VALUES (1,'opt1',50),(2,'opt2',2000),(3,'opt3',20),(4,'opt4',20),(5,'skyCalcio',20),(6,'filmService',40),(7,'foodDelivery',5);
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2022-04-17 00:00:00',12,50,'2022-04-17 00:00:00','Created','carlo',2,5),(2,'2022-03-25 00:00:00',24,32,'2022-03-25 00:00:00','Rejected','carlo',1,15),(20,'2022-04-17 00:00:00',12,50,'2022-04-17 00:00:00','Created','leo',2,5),(21,'2022-04-17 00:00:00',12,50,'2022-04-17 00:00:00','Created','leo',2,5),(22,'2022-04-17 00:00:00',12,50,'2022-04-17 00:00:00','Created','leo',2,5),(23,'2022-04-17 00:00:00',12,50,'2022-04-17 00:00:00','Valid','leo',2,5),(24,'2022-04-17 00:00:00',12,50,'2022-04-17 00:00:00','Valid','leo',2,5),(25,'2022-04-17 00:00:00',12,50,'2022-04-17 00:00:00','Created','leo',2,5),(26,'2022-04-17 00:00:00',12,50,'2022-04-17 00:00:00','Valid','leo',2,5),(27,'2022-04-17 00:00:00',12,50,'2022-04-17 00:00:00','Valid','leo',2,5),(28,'2022-04-19 00:00:00',12,1020,'2022-04-19 00:00:00','Valid','peppe',60,15),(29,'2022-04-19 00:00:00',12,24420,'2022-04-19 00:00:00','Valid','peppe',59,15),(33,'2022-05-03 00:00:00',12,0,'2022-05-11 00:00:00','Valid','giova',1,0),(34,'2022-05-03 00:00:00',12,1080,'2022-05-19 00:00:00','Suspended','giova',60,20),(35,'2022-05-03 00:00:00',12,1080,'2022-05-27 00:00:00','Suspended','giova',60,20),(40,'2022-05-03 00:00:00',12,1080,'2022-05-27 00:00:00','Valid','giova',60,20),(41,'2022-05-03 00:00:00',24,720,'2022-05-12 00:00:00','Valid','giova',59,30);
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
        WHERE id = new.packageid;
        
        UPDATE `new_schema`.`sales-package`
		SET totalwithopt = totalwithopt + new.fee * new.valperiod
        WHERE id = new.packageid;
        
        UPDATE `new_schema`.`avg-opt-for-package`
		SET numsales = numsales + 1,
		avgoptforsale = numopttot / numsales
		WHERE id = new.packageid;
        
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
        WHERE id = new.packageid;
        
        UPDATE `new_schema`.`sales-package`
		SET totalwithopt = totalwithopt + new.fee * new.valperiod
        WHERE id = new.packageid;
        
        UPDATE `new_schema`.`avg-opt-for-package`
		SET numsales = numsales + 1,
		avgoptforsale = numopttot / numsales
		WHERE id = new.packageid;
        
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
-- Dumping data for table `package-opt-association`
--

LOCK TABLES `package-opt-association` WRITE;
/*!40000 ALTER TABLE `package-opt-association` DISABLE KEYS */;
INSERT INTO `package-opt-association` VALUES (60,1),(59,2),(59,3),(60,4);
/*!40000 ALTER TABLE `package-opt-association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales-optional-product`
--

DROP TABLE IF EXISTS `sales-optional-product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales-optional-product` (
  `optproductid` int NOT NULL,
  `totalsalesvalue` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`optproductid`),
  UNIQUE KEY `productid_UNIQUE` (`optproductid`),
  CONSTRAINT `optprodid` FOREIGN KEY (`optproductid`) REFERENCES `optional-product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales-optional-product`
--

LOCK TABLES `sales-optional-product` WRITE;
/*!40000 ALTER TABLE `sales-optional-product` DISABLE KEYS */;
INSERT INTO `sales-optional-product` VALUES (1,2402),(2,72004),(3,243),(4,728),(5,0),(6,0),(7,0);
/*!40000 ALTER TABLE `sales-optional-product` ENABLE KEYS */;
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
INSERT INTO `sales-package` VALUES (1,25440,1080),(2,26700,420),(58,0,0),(59,25140,900),(60,1860,1020);
/*!40000 ALTER TABLE `sales-package` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`serviceid`),
  UNIQUE KEY `serviceid_UNIQUE` (`serviceid`),
  KEY `service_package_id_idx` (`service_package_id`),
  CONSTRAINT `service_package_id` FOREIGN KEY (`service_package_id`) REFERENCES `service-package` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'MobilePhone',23,24,25,26,NULL,NULL,1),(2,'FixedPhone',1,1,1,1,1,1,60),(3,'FixedPhone',1,1,1,1,1,1,NULL),(4,'MobilePhone',200,50,0.2,1,0,0,60),(5,'MobilePhone',100,20,0.1,1,0,0,NULL),(6,'FixedInternetA',1,1,1,1,50,1,60),(7,'FixedInternetB',1,1,1,1,100,2,NULL),(8,'MobileInternetA',1,1,1,1,20,3,60),(9,'MobileInternetB',1,1,1,1,80,4,NULL);
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
  `monthscost12` float NOT NULL,
  `monthscost24` float NOT NULL,
  `monthscost36` float NOT NULL,
  PRIMARY KEY (`ID`,`name`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service-package`
--

LOCK TABLES `service-package` WRITE;
/*!40000 ALTER TABLE `service-package` DISABLE KEYS */;
INSERT INTO `service-package` VALUES (1,'pckgA',0,0,0),(2,'pckgB',0,0,0),(58,'allInclusive',20,30,40),(59,'packagewithproducts',20,30,40),(60,'packagewithdiffproducts',20,30,40);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `service-package_AFTER_INSERT` AFTER INSERT ON `service-package` FOR EACH ROW BEGIN
	INSERT INTO `new_schema`.`num-purch-package`(packageid, numpurchases)
    VALUES(new.ID, 0);
    INSERT INTO `new_schema`.`num-purch-package-val-period`(packageid, numpurchases, valperiod)
    VALUES(new.ID, 0, 12);
    INSERT INTO `new_schema`.`num-purch-package-val-period`(packageid, numpurchases, valperiod)
    VALUES(new.ID, 0, 24);
    INSERT INTO `new_schema`.`num-purch-package-val-period`(packageid, numpurchases, valperiod)
    VALUES(new.ID, 0, 36);
    INSERT INTO `new_schema`.`sales-package`(id, totalwithopt, totalwithoutopt)
    VALUES(new.ID, 0, 0);
    INSERT INTO `new_schema`.`avg-opt-for-package`(id, numopttot, numsales, avgoptforsale)
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
  `idsuspendedorders` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idsuspendedorders`),
  CONSTRAINT `ordid` FOREIGN KEY (`idsuspendedorders`) REFERENCES `order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
  `numrejections` int DEFAULT '0',
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
INSERT INTO `user` VALUES ('carlo','carlo@gmail.com','123456','User','0',0),('giova','thegiova99@gmail.com','123','Customer','1',5),('leo','leo@gmail.com','123','User','0',5),('peppe','peppe@gmail.com','123','Customer','0',0),('stronzo','stronzo@gmail.com','123456','User','0',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-05  0:08:10

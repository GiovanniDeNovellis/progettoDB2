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
  `timelastrejection` time NOT NULL,
  PRIMARY KEY (`userid`),
  KEY `mail_idx` (`email`),
  CONSTRAINT `mail` FOREIGN KEY (`email`) REFERENCES `user` (`email`),
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert`
--

LOCK TABLES `alert` WRITE;
/*!40000 ALTER TABLE `alert` DISABLE KEYS */;
INSERT INTO `alert` VALUES ('carlo','carlo@gmail.com',30,'2022-03-25 00:00:00','00:12:03');
/*!40000 ALTER TABLE `alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alert-history`
--

DROP TABLE IF EXISTS `alert-history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alert-history` (
  `username` varchar(64) NOT NULL,
  `amount` float NOT NULL,
  `daterejection` datetime NOT NULL,
  `timerejection` time NOT NULL,
  KEY `usernickname_idx` (`username`),
  CONSTRAINT `user` FOREIGN KEY (`username`) REFERENCES `user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alert-history`
--

LOCK TABLES `alert-history` WRITE;
/*!40000 ALTER TABLE `alert-history` DISABLE KEYS */;
INSERT INTO `alert-history` VALUES ('carlo',30,'2022-03-25 00:00:00','00:00:03'),('carlo',30,'2022-03-25 00:00:00','00:00:03'),('carlo',30,'2022-03-25 00:00:00','00:12:03');
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
INSERT INTO `avg-opt-for-package` VALUES (1,4,3,1.33333);
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
  CONSTRAINT `prodid` FOREIGN KEY (`productid`) REFERENCES `optional-product` (`id`) ON UPDATE CASCADE
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
INSERT INTO `num-purch-package` VALUES (1,3);
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
INSERT INTO `num-purch-package-val-period` VALUES (1,12,2),(1,24,1),(1,36,0);
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optional-product`
--

LOCK TABLES `optional-product` WRITE;
/*!40000 ALTER TABLE `optional-product` DISABLE KEYS */;
INSERT INTO `optional-product` VALUES (1,'opt1',50),(2,'opt2',2000),(3,'opt3',20),(4,'opt4',20);
/*!40000 ALTER TABLE `optional-product` ENABLE KEYS */;
UNLOCK TABLES;

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
  `fee` int NOT NULL,
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
INSERT INTO `order` VALUES (1,'2022-03-25 00:00:00',12,50,'2022-03-25 00:00:00','Valid','carlo',1,30),(2,'2022-03-25 00:00:00',24,32,'2022-03-25 00:00:00','Valid','carlo',1,15);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

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
  `bridge_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`bridge_id`),
  UNIQUE KEY `bridge_id_UNIQUE` (`bridge_id`),
  KEY `package_idx` (`package`),
  KEY `optproduct_idx` (`optproduct`),
  KEY `order_idx` (`order`),
  CONSTRAINT `optproduct` FOREIGN KEY (`optproduct`) REFERENCES `optional-product` (`id`),
  CONSTRAINT `order` FOREIGN KEY (`order`) REFERENCES `order` (`id`),
  CONSTRAINT `package` FOREIGN KEY (`package`) REFERENCES `service-package` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package-opt-bridge`
--

LOCK TABLES `package-opt-bridge` WRITE;
/*!40000 ALTER TABLE `package-opt-bridge` DISABLE KEYS */;
INSERT INTO `package-opt-bridge` VALUES (1,1,'2022-03-25 00:00:00','2022-03-25 00:00:00',1,1),(1,2,'2022-03-25 00:00:00','2022-04-25 00:00:00',1,2),(1,3,'2022-03-25 00:00:00','2022-04-25 00:00:00',1,3),(1,4,'2022-03-25 00:00:00','2022-04-25 00:00:00',1,4);
/*!40000 ALTER TABLE `package-opt-bridge` ENABLE KEYS */;
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
  CONSTRAINT `optproductid` FOREIGN KEY (`optproductid`) REFERENCES `optional-product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales-optional-product`
--

LOCK TABLES `sales-optional-product` WRITE;
/*!40000 ALTER TABLE `sales-optional-product` DISABLE KEYS */;
INSERT INTO `sales-optional-product` VALUES (1,2),(2,24004),(3,3),(4,8);
/*!40000 ALTER TABLE `sales-optional-product` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `sales-package` VALUES (1,25440,1080);
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
  PRIMARY KEY (`ID`,`name`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service-package`
--

LOCK TABLES `service-package` WRITE;
/*!40000 ALTER TABLE `service-package` DISABLE KEYS */;
INSERT INTO `service-package` VALUES (1,'pckgA');
/*!40000 ALTER TABLE `service-package` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `user` VALUES ('carlo','carlo@gmail.com','123456','User','0'),('stronzo','stronzo@gmail.com','123456','User','0');
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

-- Dump completed on 2022-04-10 22:25:10

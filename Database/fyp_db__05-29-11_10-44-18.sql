-- MySQL dump 10.13  Distrib 5.1.44, for apple-darwin8.11.1 (i386)
--
-- Host: localhost    Database: fyp_db
-- ------------------------------------------------------
-- Server version	5.1.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_list`
--

DROP TABLE IF EXISTS `admin_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_list`
--

LOCK TABLES `admin_list` WRITE;
/*!40000 ALTER TABLE `admin_list` DISABLE KEYS */;
INSERT INTO `admin_list` VALUES (1,'eiefypadmin','3dd210203f21cdf2c2a0eb689dd0574caac059b2'),(2,'eiefypadmin','3dd210203f21cdf2c2a0eb689dd0574caac059b2');
/*!40000 ALTER TABLE `admin_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_info`
--

DROP TABLE IF EXISTS `menu_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `intro` varchar(100) DEFAULT NULL,
  `kind` varchar(20) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_info`
--

LOCK TABLES `menu_info` WRITE;
/*!40000 ALTER TABLE `menu_info` DISABLE KEYS */;
INSERT INTO `menu_info` VALUES (33,'test delegate method','some sample intro','2',7.99,12),(2,'cola','coca cola','1',6.5,50),(3,'western soup','sweet and sour','2',7,20),(4,'ice cream','strawberry ice cream','3',15,20),(5,'take away extra','take away surcharge','4',1,100),(19,'cola with burger','test new url','1',25,100),(18,'Vege salad','to test if new class is correct','0',8,20),(21,'Super Big Sandwich','It\'s big enough for two people to enjoy','0',20,50),(20,'Pizza','Delicious italian hand made pizza','0',108,188),(35,'Fish and pork','Traditional chinese food','0',30,20),(36,'Fried chicken meal','Delicious fried chicken','0',50,12),(25,'nothing','nothing','2',99999,0),(30,'name after change','introduction','2',778,23),(29,'test name','test add','2',1010,9988),(31,'cocktail','mild alcoholic drink','1',50,10),(32,'meal set','good taste','0',9,20),(34,'chicken with salad','meat plus vegetable makes it healthy','0',25.99,20),(37,'fried noodles','delicious','0',20,20);
/*!40000 ALTER TABLE `menu_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_list`
--

DROP TABLE IF EXISTS `order_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(30) DEFAULT NULL,
  `customer_phone` int(11) DEFAULT NULL,
  `delivery_address` varchar(300) DEFAULT NULL,
  `udid` varchar(50) DEFAULT NULL,
  `customer_comment` varchar(200) DEFAULT NULL,
  `order_status` tinyint(4) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_list`
--

LOCK TABLES `order_list` WRITE;
/*!40000 ALTER TABLE `order_list` DISABLE KEYS */;
INSERT INTO `order_list` VALUES (6,'Kobe Bryant',12345678,'united states','53BB3AC9-BE50-55E1-86DB-064D352AB99A','no, thanks',-1,'2011-05-08 21:30:30'),(3,'Josh',69394003,'PolyU campus','53BB3AC9-BE50-55E1-86DB-064D352AB99A','nothing special~',2,'2011-04-25 12:23:17'),(4,'name',77883344,'nowhere','53BB3AC9-BE50-55E1-86DB-064D352AB99A','',1,'2011-04-25 12:31:44'),(5,'josh',12345678,'de636','53BB3AC9-BE50-55E1-86DB-064D352AB99A','',2,'2011-04-29 10:31:44'),(7,'Liang Xiao',12345678,'1hung lai rd,hung hom,kowloon,hong kong','53BB3AC9-BE50-55E1-86DB-064D352AB99A','',1,'2011-05-08 22:08:06'),(8,'Liang',12800183,'hong kong polytechnic university','53BB3AC9-BE50-55E1-86DB-064D352AB99A','',0,'2011-05-08 22:16:52'),(9,'Xiao',2910293,'99 baker street, hung hom, kowloon, hong kong','53BB3AC9-BE50-55E1-86DB-064D352AB99A','test delegate method',0,'2011-05-09 18:07:44'),(10,'test name',91029870,'tiananmen square, beijing, china','53BB3AC9-BE50-55E1-86DB-064D352AB99A','',0,'2011-05-09 18:09:31'),(11,'Tiger SX',12345678,'Polyu student hall, hung hom, kowloon, hong kong','53BB3AC9-BE50-55E1-86DB-064D352AB99A','',3,'2011-05-24 14:23:02'),(12,'josh Liang',69394003,'polyu campus, hong kong','53BB3AC9-BE50-55E1-86DB-064D352AB99A','Extra spicy',1,'2011-05-24 14:50:20'),(13,'',0,'','','',0,'2011-05-26 00:01:35');
/*!40000 ALTER TABLE `order_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_list_item`
--

DROP TABLE IF EXISTS `order_list_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_list_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `itemID` int(11) DEFAULT NULL,
  `quantity` smallint(6) DEFAULT NULL,
  `orderID` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_list_item`
--

LOCK TABLES `order_list_item` WRITE;
/*!40000 ALTER TABLE `order_list_item` DISABLE KEYS */;
INSERT INTO `order_list_item` VALUES (20,21,1,6),(2,1,10,8),(3,2,20,8),(24,18,1,7),(23,32,1,6),(22,18,1,6),(21,20,1,6),(8,1,10,5),(9,2,20,5),(10,1,1,3),(11,21,1,3),(12,20,4,3),(13,18,1,3),(14,23,1,4),(15,5,1,4),(16,24,1,4),(17,1,1,5),(18,18,1,5),(19,21,1,5),(25,19,1,8),(26,2,1,8),(27,18,1,8),(28,31,1,8),(29,18,1,9),(30,23,1,10),(31,2,2,11),(32,35,2,11),(33,18,1,12),(34,20,3,12),(35,19,1,12);
/*!40000 ALTER TABLE `order_list_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant_info`
--

DROP TABLE IF EXISTS `restaurant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `intro` varchar(200) DEFAULT NULL,
  `location` varchar(300) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `picversion` datetime DEFAULT NULL,
  `recommended` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant_info`
--

LOCK TABLES `restaurant_info` WRITE;
/*!40000 ALTER TABLE `restaurant_info` DISABLE KEYS */;
INSERT INTO `restaurant_info` VALUES (1,'delicious restaurant','Great pizzas only here','hong kong polytechnic university',66723226,'2011-05-24 14:44:08',32);
/*!40000 ALTER TABLE `restaurant_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-05-29 10:44:19

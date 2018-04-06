-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 192.168.1.5    Database: restaurant
-- ------------------------------------------------------
-- Server version	5.7.21-log

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
-- Table structure for table `const_status_orderdetails`
--

DROP TABLE IF EXISTS `const_status_orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `const_status_orderdetails` (
  `status_id` int(11) NOT NULL,
  `status_name` varchar(45) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `const_status_orderdetails`
--

LOCK TABLES `const_status_orderdetails` WRITE;
/*!40000 ALTER TABLE `const_status_orderdetails` DISABLE KEYS */;
INSERT INTO `const_status_orderdetails` VALUES (1,'เสริฟแล้ว'),(2,'รอเสริฟ');
/*!40000 ALTER TABLE `const_status_orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `const_status_ordermaster`
--

DROP TABLE IF EXISTS `const_status_ordermaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `const_status_ordermaster` (
  `status_id` int(11) NOT NULL,
  `status_name` varchar(45) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `const_status_ordermaster`
--

LOCK TABLES `const_status_ordermaster` WRITE;
/*!40000 ALTER TABLE `const_status_ordermaster` DISABLE KEYS */;
INSERT INTO `const_status_ordermaster` VALUES (1,'ชำระแล้ว'),(2,'รอเสริฟ'),(3,'รอเช็คบิล'),(4,'ค้างชำระ'),(5,'ยกเลิก');
/*!40000 ALTER TABLE `const_status_ordermaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `const_status_table`
--

DROP TABLE IF EXISTS `const_status_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `const_status_table` (
  `status_id` int(11) NOT NULL,
  `status_name` varchar(45) NOT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `const_status_table`
--

LOCK TABLES `const_status_table` WRITE;
/*!40000 ALTER TABLE `const_status_table` DISABLE KEYS */;
INSERT INTO `const_status_table` VALUES (0,'ไม่พร้อมใช้งาน'),(1,'ว่าง'),(2,'รอเสริฟ'),(3,'รอเช็คบิล'),(4,'Other');
/*!40000 ALTER TABLE `const_status_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_menu`
--

DROP TABLE IF EXISTS `food_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food_menu` (
  `food_id` int(11) NOT NULL,
  `foodtype_code` varchar(45) NOT NULL,
  `food_name` varchar(45) NOT NULL,
  `food_price` decimal(12,2) NOT NULL,
  PRIMARY KEY (`food_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_menu`
--

LOCK TABLES `food_menu` WRITE;
/*!40000 ALTER TABLE `food_menu` DISABLE KEYS */;
INSERT INTO `food_menu` VALUES (1,'3','แกงฮังเล',40.00),(2,'1','ต้มจืด',45.00),(3,'4','ปลาทอด',60.00),(4,'2','ผัดไทย',50.00),(5,'1','ต้มยำกุ้งน้ำข้น',70.00),(6,'3','ผัดพริกแกง',45.00),(7,'1','ต้มโคล้ง',55.00),(8,'6','ข้าวเปล่า',10.00),(9,'2','ผัดกระเพรา',45.00);
/*!40000 ALTER TABLE `food_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_type`
--

DROP TABLE IF EXISTS `food_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `food_type` (
  `foodtype_code` varchar(10) NOT NULL,
  `foodtype_name` varchar(45) NOT NULL,
  PRIMARY KEY (`foodtype_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_type`
--

LOCK TABLES `food_type` WRITE;
/*!40000 ALTER TABLE `food_type` DISABLE KEYS */;
INSERT INTO `food_type` VALUES ('1','ต้ม'),('2','ผัด'),('3','แกง'),('4','ทอด'),('5','ยำ'),('6','ข้าว');
/*!40000 ALTER TABLE `food_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `main_table`
--

DROP TABLE IF EXISTS `main_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `main_table` (
  `table_no` varchar(11) NOT NULL,
  `order_no` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  PRIMARY KEY (`table_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `main_table`
--

LOCK TABLES `main_table` WRITE;
/*!40000 ALTER TABLE `main_table` DISABLE KEYS */;
INSERT INTO `main_table` VALUES ('01',NULL,1),('02',NULL,1),('03',NULL,0),('04',1,2),('05',2,2),('06',NULL,1),('07',3,2),('08',NULL,1),('09',NULL,1),('10',NULL,1);
/*!40000 ALTER TABLE `main_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_details` (
  `order_detail_no` int(11) NOT NULL,
  `order_no` int(11) DEFAULT NULL,
  `food_id` int(11) DEFAULT NULL,
  `standard_price` decimal(12,2) DEFAULT NULL,
  `actual_price` decimal(12,2) DEFAULT NULL,
  `order_status` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`order_detail_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (1,1,1,40.00,50.00,2,'2018-04-02 17:50:00','2018-04-05 20:55:06'),(2,1,2,45.00,40.00,1,'2018-04-02 17:50:00','2018-04-02 17:50:00'),(3,1,3,60.00,45.00,1,'2018-04-02 17:50:00','2018-04-04 18:02:58'),(4,2,1,40.00,40.00,2,'2018-04-02 17:51:12','2018-04-02 17:51:12'),(5,2,2,45.00,40.00,2,'2018-04-02 17:51:12','2018-04-02 17:51:12'),(6,2,3,60.00,40.00,2,'2018-04-02 17:51:12','2018-04-02 17:51:12'),(7,3,3,60.00,60.00,1,'2018-04-05 16:36:13','2018-04-05 19:35:44'),(8,3,3,60.00,60.00,1,'2018-04-05 16:36:13','2018-04-05 19:35:35'),(9,3,4,50.00,50.00,2,'2018-04-05 16:36:13','2018-04-05 20:55:23'),(10,3,8,10.00,10.00,2,'2018-04-05 16:40:33','2018-04-05 20:55:35');
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_master`
--

DROP TABLE IF EXISTS `order_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_master` (
  `order_no` int(11) NOT NULL,
  `table_no` varchar(11) DEFAULT NULL,
  `customer_no` int(11) DEFAULT NULL,
  `order_status` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`order_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_master`
--

LOCK TABLES `order_master` WRITE;
/*!40000 ALTER TABLE `order_master` DISABLE KEYS */;
INSERT INTO `order_master` VALUES (1,'04',4,2,'2018-04-02 17:50:00','2018-04-05 20:55:06'),(2,'05',4,2,'2018-04-02 17:51:12','2018-04-03 19:17:47'),(3,'07',5,2,'2018-04-05 16:36:13','2018-04-05 20:55:35');
/*!40000 ALTER TABLE `order_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-06 15:12:34

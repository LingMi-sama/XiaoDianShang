-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: di
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `df_goods_sku`
--

DROP TABLE IF EXISTS `df_goods_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_goods_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `desc` varchar(256) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `unite` varchar(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_sku_type_id_576de3b4_fk_df_goods_type_id` (`type_id`),
  KEY `df_goods_sku_goods_id_31622280_fk_df_goods_id` (`goods_id`),
  CONSTRAINT `df_goods_sku_goods_id_31622280_fk_df_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `df_goods` (`id`),
  CONSTRAINT `df_goods_sku_type_id_576de3b4_fk_df_goods_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_goods_sku`
--

LOCK TABLES `df_goods_sku` WRITE;
/*!40000 ALTER TABLE `df_goods_sku` DISABLE KEYS */;
INSERT INTO `df_goods_sku` VALUES (1,'2017-11-15 03:10:14.045538','2017-11-14 08:24:49.138489',0,'草莓','草莓简\n介',10.00,'500g','/images/goods/goods015.jpg',9,1,1,1,1),(2,'2017-11-15 03:11:04.490384','2017-11-14 08:44:43.484243',0,'青柿','青柿简\n介',10.00,'盒','/images/goods/goods003.jpg',4,6,1,1,1),(3,'2017-11-15 03:12:32.165020','2017-11-14 08:25:22.505620',0,'核桃','核桃简\n介',20.00,'500g','/images/goods/goods002.jpg',10,0,1,3,1),(4,'2017-11-15 03:13:16.457844','2017-11-14 08:25:34.181904',0,'白菜','简\n介',2.00,'500g','/images/goods/goods001.jpg',10,0,1,4,2),(5,'2017-11-15 03:14:05.799352','2017-11-14 08:25:56.427676',0,'菩提果','简\n介',12.12,'500g','/images/goods/goods012.jpg',10,0,1,5,1),(6,'2017-11-15 03:15:09.971968','2017-11-14 08:26:09.113586',0,'椰子','简\n介',4.00,'500g','/images/goods/goods018.jpg',10,0,1,6,2),(7,'2017-11-15 03:15:53.812181','2017-11-14 08:26:19.094675',0,'梅子','简\n介',5.00,'500g','/images/goods/goods020.jpg',7,3,1,8,1),(8,'2017-11-15 03:16:24.763232','2017-11-14 08:26:31.121824',0,'菠萝','简\n介',6.60,'500g','/images/goods/goods019.jpg',7,3,1,7,1),(9,'2017-11-15 03:17:13.426611','2017-11-14 08:26:58.739624',0,'苹果','简\n介',10.90,'500g','/images/goods/goods021.jpg',10,0,1,9,1),(10,'2017-11-15 03:17:47.656066','2017-11-14 08:29:56.158261',0,'杏仁','简\n介',23.99,'500g','/images/goods/goods004.jpg',10,0,1,13,2),(11,'2017-11-15 03:18:15.497630','2017-11-14 08:31:27.169999',0,'生姜','简\n介',3.99,'500g','/images/goods/goods005.jpg',10,0,1,14,2),(12,'2017-11-15 03:18:44.453933','2017-11-14 08:32:22.493340',0,'南瓜','简\n介',5.99,'500g','/images/goods/goods006.jpg',10,0,1,15,2);
/*!40000 ALTER TABLE `df_goods_sku` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-20 13:05:58

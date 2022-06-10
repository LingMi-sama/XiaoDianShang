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
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add 用户',6,'add_user'),(22,'Can change 用户',6,'change_user'),(23,'Can delete 用户',6,'delete_user'),(24,'Can view 用户',6,'view_user'),(25,'Can add 地址',7,'add_address'),(26,'Can change 地址',7,'change_address'),(27,'Can delete 地址',7,'delete_address'),(28,'Can view 地址',7,'view_address'),(29,'Can add 主页促销活动',8,'add_indexpromotionbanner'),(30,'Can change 主页促销活动',8,'change_indexpromotionbanner'),(31,'Can delete 主页促销活动',8,'delete_indexpromotionbanner'),(32,'Can view 主页促销活动',8,'view_indexpromotionbanner'),(33,'Can add 主页分类展示商品',9,'add_indextypegoodsbanner'),(34,'Can change 主页分类展示商品',9,'change_indextypegoodsbanner'),(35,'Can delete 主页分类展示商品',9,'delete_indextypegoodsbanner'),(36,'Can view 主页分类展示商品',9,'view_indextypegoodsbanner'),(37,'Can add 首页轮播商品',10,'add_indexgoodsbanner'),(38,'Can change 首页轮播商品',10,'change_indexgoodsbanner'),(39,'Can delete 首页轮播商品',10,'delete_indexgoodsbanner'),(40,'Can view 首页轮播商品',10,'view_indexgoodsbanner'),(41,'Can add 商品SPU',11,'add_goods'),(42,'Can change 商品SPU',11,'change_goods'),(43,'Can delete 商品SPU',11,'delete_goods'),(44,'Can view 商品SPU',11,'view_goods'),(45,'Can add 商品图片',12,'add_goodsimage'),(46,'Can change 商品图片',12,'change_goodsimage'),(47,'Can delete 商品图片',12,'delete_goodsimage'),(48,'Can view 商品图片',12,'view_goodsimage'),(49,'Can add 商品种类',13,'add_goodstype'),(50,'Can change 商品种类',13,'change_goodstype'),(51,'Can delete 商品种类',13,'delete_goodstype'),(52,'Can view 商品种类',13,'view_goodstype'),(53,'Can add 商品',14,'add_goodssku'),(54,'Can change 商品',14,'change_goodssku'),(55,'Can delete 商品',14,'delete_goodssku'),(56,'Can view 商品',14,'view_goodssku'),(57,'Can add 订单商品',15,'add_ordergoods'),(58,'Can change 订单商品',15,'change_ordergoods'),(59,'Can delete 订单商品',15,'delete_ordergoods'),(60,'Can view 订单商品',15,'view_ordergoods'),(61,'Can add 订单',16,'add_orderinfo'),(62,'Can change 订单',16,'change_orderinfo'),(63,'Can delete 订单',16,'delete_orderinfo'),(64,'Can view 订单',16,'view_orderinfo');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-20 13:05:55

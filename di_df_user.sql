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
-- Table structure for table `df_user`
--

DROP TABLE IF EXISTS `df_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_user`
--

LOCK TABLES `df_user` WRITE;
/*!40000 ALTER TABLE `df_user` DISABLE KEYS */;
INSERT INTO `df_user` VALUES (1,'pbkdf2_sha256$180000$qKnMUZbYYTry$ZehVkbaGTdkioKpRQuReCVZaGRohuOPavyuWIgUhv88=',NULL,0,'konn','','','konn@qq.com',0,0,'2021-06-07 06:26:17.113451','2021-06-07 06:26:17.285084','2021-06-07 06:26:17.285084',0),(2,'pbkdf2_sha256$180000$HNv0A3KgxmC6$tYSqRlPlVfGOiy9ZTCt0k9D+Xf3iCnza1mrIY6mowtM=','2021-06-19 03:15:54.933668',0,'kooo','','','kooo@qq.com',0,0,'2021-06-07 06:43:50.486587','2021-06-07 06:43:50.607264','2021-06-07 06:43:50.607264',0),(3,'pbkdf2_sha256$180000$xYXvSFPBgSsW$fc19vpZ4NTKVunn01O1s8gzmTn4MYqvPEn6xspI0f2Y=','2021-06-07 10:25:44.833080',0,'oko','','','oko@qq.com',0,0,'2021-06-07 10:24:56.688194','2021-06-07 10:24:56.812896','2021-06-07 10:24:56.812896',0),(4,'pbkdf2_sha256$180000$c7pBft7B7VOC$4DSzrnuRflJKPy8A50IC7VJvu1pd5Fbt/5CIe3y12Ek=','2021-06-07 10:31:10.439143',0,'kon','','','QQ@qq.com',0,0,'2021-06-07 10:29:23.967522','2021-06-07 10:29:24.092225','2021-06-07 10:29:24.092225',0),(5,'pbkdf2_sha256$180000$594CwAyglLUY$ctjCbDvvGuaLmK3LP0PDIAwlQzg8VIEepADA4ZsnlW4=',NULL,0,'jin','','','jin@qq.com',0,0,'2021-06-07 10:30:34.028058','2021-06-07 10:30:34.730216','2021-06-07 10:30:34.730216',0),(6,'pbkdf2_sha256$180000$dv5blKTs2YYT$qvaYQfyYZ7shPEZ90uH5AH4AD0FC40AbUzj1LZi8Vrc=','2021-06-19 01:19:30.662362',0,'popo','','','popo@qq.com',0,0,'2021-06-19 01:19:09.241034','2021-06-19 01:19:09.392636','2021-06-19 01:19:09.392636',0),(7,'pbkdf2_sha256$180000$O5wdk0mVsVHy$vhwcJxnYHDEAsD5reH3S9bTYCcsHz3+xpBVga6unP/0=','2021-06-19 05:31:13.002452',0,'ali','','','123456@qq.com',0,0,'2021-06-19 05:31:00.102392','2021-06-19 05:31:00.402065','2021-06-19 05:31:00.402065',0);
/*!40000 ALTER TABLE `df_user` ENABLE KEYS */;
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

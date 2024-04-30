CREATE DATABASE  IF NOT EXISTS `crazysorteo_test` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `crazysorteo_test`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: crazysorteo_test
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `articulos`
--

DROP TABLE IF EXISTS `articulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulos` (
  `IdArticulo` int NOT NULL AUTO_INCREMENT,
  `TipoCompra` enum('Gemas','Dinero','Gratis') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NombreArticulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DescripcionArticulo` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `PrecioArticulo` decimal(10,2) NOT NULL,
  `ClaseArticulo` int NOT NULL,
  `ExclusivoCofre` tinyint(1) NOT NULL,
  `TipoArticuloID` int DEFAULT NULL,
  PRIMARY KEY (`IdArticulo`),
  KEY `TipoArticuloID` (`TipoArticuloID`),
  CONSTRAINT `articulos_ibfk_1` FOREIGN KEY (`TipoArticuloID`) REFERENCES `tipoarticulo` (`TipoArticuloID`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulos`
--

LOCK TABLES `articulos` WRITE;
/*!40000 ALTER TABLE `articulos` DISABLE KEYS */;
INSERT INTO `articulos` VALUES (1,'Dinero','Paquete de Gemas Pequeño','Un paquete pequeño de gemas',50.00,1,0,5),(2,'Dinero','Paquete de Gemas Mediano','Un paquete mediano de gemas',100.00,1,0,5),(3,'Dinero','Paquete de Gemas Grande','Un paquete grande de gemas',200.00,1,0,5),(4,'Dinero','Paquete de Gemas Pequeño','Un paquete pequeño de gemas',50.00,1,0,5),(5,'Dinero','Paquete de Gemas Mediano','Un paquete mediano de gemas',100.00,1,0,5),(6,'Dinero','Paquete de Gemas Grande','Un paquete grande de gemas',200.00,1,0,5),(7,'Gemas','Caja de Botín Bronce','Una caja de botín de nivel bronce',100.00,2,0,6),(8,'Gemas','Caja de Botín Plata','Una caja de botín de nivel plata',200.00,3,0,6),(9,'Gemas','Caja de Botín Oro','Una caja de botín de nivel oro',300.00,4,0,6),(10,'Gratis','Camiseta Sorteo Tec','Una camiseta azul con el logo de Sorteo Tec',0.00,1,0,4),(11,'Gemas','Marco Futurista','Un marco con diseño futurista para tu perfil',40.00,3,0,1),(13,'Gemas','Casco Espacial','Un casco con diseño de astronauta',35.00,3,0,3),(14,'Gemas','Armadura de Batalla','Una armadura inspirada en guerreros futuristas',80.00,3,0,4),(15,'Gemas','Sombrero de Vaquero','Un sombrero clásico del oeste',20.00,2,0,3),(16,'Gemas','Marco de Lujo','Un marco decorado con joyas y oro',0.00,4,1,1),(18,'Gemas','Visera Cibernética','Una visera con tecnología del futuro',0.00,3,1,3),(19,'Gemas','Capa de Superhéroe','Una capa digna de un superhéroe',0.00,3,1,4),(20,'Gemas','Antifaz Misterioso','Un antifaz para ocultar tu identidad',0.00,2,1,3),(22,'Gratis','Marco Estándar Sorteo Tec','Un marco estandarizado para todos los usuarios',0.00,1,0,1),(23,'Gratis','Delivery Van Sorteo Tec','Una furgoneta de entrega básica con el logo de Sorteo Tec',0.00,1,0,2),(24,'Gratis','Gorra Sorteo Tec','Una gorra básica con el logo de Sorteo Tec',0.00,1,0,3),(25,'Gratis','Camiseta Sorteo Tec','Una camiseta básica con el logo de Sorteo Tec',0.00,1,0,4),(26,'Gemas','Premio','Compra de premio real con gemas',0.00,7,0,NULL),(27,'Gemas','Xbox_Series_X','Premio real de Consola Xbox Series X. Sujeto a terminos y condiciones.',100000.00,5,0,7),(28,'Gemas','Playstation_5','Premio real de Consola Playstation 5. Sujeto a terminos y condiciones.',100000.00,5,0,7),(29,'Gemas','Xbox_Live_Gold_3M','Codigo digital canjeable por 3 meses de suscrpcion a Xbox Live Gold por 3 meses. Sujeto a terminos y condiciones.',4200.00,5,0,7),(30,'Gemas','Playstation_Plus_3M','Codigo digital canjeable por 3 meses de suscrpcion a Playstation Plus por 3 meses. Sujeto a terminos y condiciones.',4200.00,5,0,7),(31,'Gemas','2x1_en_Dinero_X_Vida','Cupon por 2x1 al comprar boletos del sorteo \'Dinero de X Vida\'. Sujeto a terminos y condiciones.',10000.00,5,0,7),(32,'Gemas','-10%_boleto_Aventurat','Cupon por 10% de descuento al comprar boletos de Aventurat. Sujeto a terminos y condiciones.',3000.00,5,0,7),(33,'Gemas','Piel de Coche Batman','Piel de vehículo inspirada en Batman, con un diseño elegante y oscuro que recuerda al Caballero de la Noche',0.00,4,1,2),(34,'Gemas','Piel de Coche Superman','Piel de vehículo con el estilo icónico de Superman, colores vivos con el emblema del superhéroe',0.00,4,1,2),(35,'Gemas','Piel de Coche Mariobros','Piel de vehículo inspirada en el mundo de Mario Bros, con colores brillantes y elementos característicos del juego',0.00,3,1,2),(36,'Gemas','Piel de Coche Pacman','Piel de vehículo temática de Pacman, con colores vibrantes y diseño nostálgico del clásico juego de arcade',0.00,3,1,2),(37,'Gemas','Piel de Coche Cubo Rubik','Piel de vehículo con diseño basado en el Cubo de Rubik, con un patrón colorido y desafiante',0.00,3,1,2),(38,'Gemas','Piel de Coche Afro','Piel de vehículo con un estilo Afro vibrante, destacando la cultura y el arte con colores llamativos y patrones únicos',0.00,2,1,2),(39,'Gemas','Piel de Coche Tortuga Ninja','Piel de vehículo inspirada en las Tortugas Ninja, con detalles y colores representativos de estos héroes',0.00,2,1,2),(40,'Gemas','Piel de Coche Minecraft','Piel de vehículo con el diseño pixelado característico de Minecraft, transportando el estilo del juego al mundo real',0.00,2,1,2),(41,'Gemas','Piel de Coche Fortnite','Piel de vehículo inspirada en Fortnite, con un diseño moderno y elementos icónicos del popular juego',0.00,1,1,2),(42,'Gemas','Piel de Coche Pikachu','Piel de vehículo con la temática de Pikachu, combinando colores amarillos vibrantes y detalles del querido personaje',0.00,1,1,2),(43,'Gemas','Piel de Coche Vikingo','Piel de vehículo con una estética vikinga, con detalles rústicos y un diseño que evoca la era de los vikingos',0.00,1,1,2),(44,'Gemas','Piel de Coche Vaquero','Piel de vehículo al estilo del oeste, con un diseño que recuerda a los vaqueros y la cultura del rodeo',0.00,1,1,2);
/*!40000 ALTER TABLE `articulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articulousuario`
--

DROP TABLE IF EXISTS `articulousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulousuario` (
  `IdUsuario` int NOT NULL,
  `IdArticulo` int NOT NULL,
  PRIMARY KEY (`IdArticulo`,`IdUsuario`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `articulousuario_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `articulousuario_ibfk_2` FOREIGN KEY (`IdArticulo`) REFERENCES `articulos` (`IdArticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulousuario`
--

LOCK TABLES `articulousuario` WRITE;
/*!40000 ALTER TABLE `articulousuario` DISABLE KEYS */;
INSERT INTO `articulousuario` VALUES (1,15),(1,18),(1,19),(1,22),(1,23),(1,24),(1,25),(2,22),(2,23),(2,24),(2,25),(3,22),(3,23),(3,24),(3,25),(4,22),(4,23),(4,24),(4,25),(5,22),(5,23),(5,24),(5,25),(6,22),(6,23),(6,24),(6,25),(7,22),(7,23),(7,24),(7,25),(8,22),(8,23),(8,24),(8,25),(9,22),(9,23),(9,24),(9,25),(10,22),(10,23),(10,24),(10,25),(11,22),(11,23),(11,24),(11,25),(12,22),(12,23),(12,24),(12,25),(13,22),(13,23),(13,24),(13,25),(14,22),(14,23),(14,24),(14,25),(15,22),(15,23),(15,24),(15,25),(16,22),(16,23),(16,24),(16,25),(17,22),(17,23),(17,24),(17,25),(18,22),(18,23),(18,24),(18,25),(19,22),(19,23),(19,24),(19,25),(20,22),(20,23),(20,24),(20,25),(21,22),(21,23),(21,24),(21,25),(22,22),(22,23),(22,24),(22,25),(23,22),(23,23),(23,24),(23,25),(24,22),(24,23),(24,24),(24,25),(25,22),(25,23),(25,24),(25,25),(26,22),(26,23),(26,24),(26,25),(27,22),(27,23),(27,24),(27,25),(28,22),(28,23),(28,24),(28,25),(29,22),(29,23),(29,24),(29,25),(42,22),(42,23),(42,24),(42,25),(43,22),(43,23),(43,24),(43,25),(44,22),(44,23),(44,24),(44,25),(45,22),(45,23),(45,24),(45,25),(46,22),(46,23),(46,24),(46,25),(47,22),(47,23),(47,24),(47,25),(48,22),(48,23),(48,24),(48,25),(49,22),(49,23),(49,24),(49,25),(50,22),(50,23),(50,24),(50,25),(51,22),(51,23),(51,24),(51,25),(52,22),(52,23),(52,24),(52,25),(53,22),(53,23),(53,24),(53,25),(54,22),(54,23),(54,24),(54,25),(55,22),(55,23),(55,24),(55,25),(56,22),(56,23),(56,24),(56,25),(57,22),(57,23),(57,24),(57,25),(58,22),(58,23),(58,24),(58,25),(59,22),(59,23),(59,24),(59,25),(60,22),(60,23),(60,24),(60,25),(61,22),(61,23),(61,24),(61,25),(62,22),(62,23),(62,24),(62,25),(63,22),(63,23),(63,24),(63,25),(64,22),(64,23),(64,24),(64,25),(65,22),(65,23),(65,24),(65,25),(66,22),(66,23),(66,24),(66,25);
/*!40000 ALTER TABLE `articulousuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventariousuario`
--

DROP TABLE IF EXISTS `inventariousuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventariousuario` (
  `IdInventario` int NOT NULL AUTO_INCREMENT,
  `IdUsuario` int NOT NULL,
  `IdMarco` int DEFAULT NULL,
  `IdVehiculo` int DEFAULT NULL,
  `IdCabeza` int DEFAULT NULL,
  `IdCuerpo` int DEFAULT NULL,
  PRIMARY KEY (`IdInventario`),
  KEY `IdUsuario` (`IdUsuario`),
  KEY `IdMarco` (`IdMarco`,`IdUsuario`),
  KEY `IdVehiculo` (`IdVehiculo`,`IdUsuario`),
  KEY `IdCabeza` (`IdCabeza`,`IdUsuario`),
  KEY `IdCuerpo` (`IdCuerpo`,`IdUsuario`),
  CONSTRAINT `inventariousuario_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `inventariousuario_ibfk_2` FOREIGN KEY (`IdMarco`, `IdUsuario`) REFERENCES `articulousuario` (`IdArticulo`, `IdUsuario`),
  CONSTRAINT `inventariousuario_ibfk_3` FOREIGN KEY (`IdVehiculo`, `IdUsuario`) REFERENCES `articulousuario` (`IdArticulo`, `IdUsuario`),
  CONSTRAINT `inventariousuario_ibfk_4` FOREIGN KEY (`IdCabeza`, `IdUsuario`) REFERENCES `articulousuario` (`IdArticulo`, `IdUsuario`),
  CONSTRAINT `inventariousuario_ibfk_5` FOREIGN KEY (`IdCuerpo`, `IdUsuario`) REFERENCES `articulousuario` (`IdArticulo`, `IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventariousuario`
--

LOCK TABLES `inventariousuario` WRITE;
/*!40000 ALTER TABLE `inventariousuario` DISABLE KEYS */;
INSERT INTO `inventariousuario` VALUES (1,10,22,23,24,25),(2,11,22,23,24,25),(3,12,22,23,24,25),(4,13,22,23,24,25),(5,14,22,23,24,25),(6,15,22,23,24,25),(7,16,22,23,24,25),(8,17,22,23,24,25),(9,18,22,23,24,25),(10,19,22,23,24,25),(11,20,22,23,24,25),(12,21,22,23,24,25),(13,22,22,23,24,25),(14,23,22,23,24,25),(15,24,22,23,24,25),(16,25,22,23,24,25),(17,26,22,23,24,25),(18,27,22,23,24,25),(19,28,22,23,24,25),(20,29,22,23,24,25),(33,1,22,23,24,25),(34,2,22,23,24,25),(35,3,22,23,24,25),(36,4,22,23,24,25),(37,5,22,23,24,25),(38,6,22,23,24,25),(39,7,22,23,24,25),(40,8,22,23,24,25),(41,9,22,23,24,25),(42,42,22,23,24,25),(43,43,22,23,24,25),(44,44,22,23,24,25),(45,45,22,23,24,25),(46,46,22,23,24,25),(47,47,22,23,24,25),(48,48,22,23,24,25),(49,49,22,23,24,25),(50,50,22,23,24,25),(51,51,22,23,24,25),(52,52,22,23,24,25),(53,53,22,23,24,25),(54,54,22,23,24,25),(55,55,22,23,24,25),(56,56,22,23,24,25),(57,57,22,23,24,25),(58,58,22,23,24,25),(59,59,22,23,24,25),(60,60,22,23,24,25),(61,61,22,23,24,25),(62,62,22,23,24,25),(63,63,22,23,24,25),(64,64,22,23,24,25),(65,65,22,23,24,25),(66,66,22,23,24,25);
/*!40000 ALTER TABLE `inventariousuario` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `CheckArticleUserRelation` BEFORE INSERT ON `inventariousuario` FOR EACH ROW BEGIN
    DECLARE articleCount INT;
    
    -- Verificar si existe una relación en articulousuario para el IdUsuario y IdArticulo específicos
    SELECT COUNT(*) INTO articleCount 
    FROM articulousuario 
    WHERE IdUsuario = NEW.IdUsuario 
    AND IdArticulo IN (NEW.IdMarco, NEW.IdVehiculo, NEW.IdCabeza, NEW.IdCuerpo);

    -- Si no existe la relación, se produce un error y se detiene la inserción
    IF articleCount != 4 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede añadir el artículo al inventario, no existe relación en articulousuario.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `logjuego`
--

DROP TABLE IF EXISTS `logjuego`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logjuego` (
  `IdUsuario` int DEFAULT NULL,
  `idlogJuego` int NOT NULL AUTO_INCREMENT,
  `TiempoInicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DuracionJuego` bigint DEFAULT NULL,
  `Puntuacion` int DEFAULT NULL,
  `GemasGanadas` int DEFAULT '0',
  PRIMARY KEY (`idlogJuego`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `logjuego_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logjuego`
--

LOCK TABLES `logjuego` WRITE;
/*!40000 ALTER TABLE `logjuego` DISABLE KEYS */;
INSERT INTO `logjuego` VALUES (1,1,'2023-11-23 04:45:13',400,400,200),(1,2,'2023-11-23 04:45:16',400,400,200),(1,3,'2023-11-23 04:47:48',400,400,1000),(1,4,'2023-11-23 04:57:26',100,100,0),(1,5,'2023-11-23 04:57:40',100,100,0),(1,6,'2023-11-23 05:01:36',0,0,0),(1,7,'2023-11-23 05:01:45',0,0,0),(1,8,'2023-11-23 05:01:46',0,0,0),(1,9,'2023-11-23 05:01:47',0,0,0),(1,10,'2023-11-23 05:02:14',0,0,0),(1,11,'2023-11-23 06:09:19',3000,3000,1000),(1,12,'2023-11-23 06:09:25',3000,3000,1000),(1,13,'2023-11-23 06:09:26',3000,3000,1000),(1,16,'2023-11-12 15:35:36',1000000,1000000,1000),(1,17,'2020-09-22 19:35:41',100000000,100000000,1000),(1,18,'2023-11-24 05:55:11',200,10000,500),(10,19,'2023-11-24 06:42:06',300,500,100);
/*!40000 ALTER TABLE `logjuego` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logusuario`
--

DROP TABLE IF EXISTS `logusuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logusuario` (
  `IdLog` int NOT NULL AUTO_INCREMENT,
  `IdUsuario` int DEFAULT NULL,
  `TiempoLog` datetime DEFAULT NULL,
  `TipoLog` enum('login','logoff') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`IdLog`),
  KEY `IdUsuario` (`IdUsuario`),
  CONSTRAINT `logusuario_ibfk_1` FOREIGN KEY (`IdUsuario`) REFERENCES `usuarios` (`IdUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logusuario`
--

LOCK TABLES `logusuario` WRITE;
/*!40000 ALTER TABLE `logusuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `logusuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoarticulo`
--

DROP TABLE IF EXISTS `tipoarticulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipoarticulo` (
  `TipoArticuloID` int NOT NULL AUTO_INCREMENT,
  `DescripcionTipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`TipoArticuloID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoarticulo`
--

LOCK TABLES `tipoarticulo` WRITE;
/*!40000 ALTER TABLE `tipoarticulo` DISABLE KEYS */;
INSERT INTO `tipoarticulo` VALUES (1,'Marco'),(2,'Vehiculo'),(3,'Cabeza'),(4,'Cuerpo'),(5,'Gemas'),(6,'Cofres'),(7,'premio');
/*!40000 ALTER TABLE `tipoarticulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaccionesdineroreal`
--

DROP TABLE IF EXISTS `transaccionesdineroreal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaccionesdineroreal` (
  `idTransaccion` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int DEFAULT NULL,
  `TiempoTransaccion` datetime DEFAULT NULL,
  `idArticulo` int DEFAULT NULL,
  `Tipo` enum('Compra','Retorno','Regalo') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CantidadGemasOtorgadas` int DEFAULT NULL,
  PRIMARY KEY (`idTransaccion`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idArticulo` (`idArticulo`),
  CONSTRAINT `transaccionesdineroreal_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `transaccionesdineroreal_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`IdArticulo`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaccionesdineroreal`
--

LOCK TABLES `transaccionesdineroreal` WRITE;
/*!40000 ALTER TABLE `transaccionesdineroreal` DISABLE KEYS */;
INSERT INTO `transaccionesdineroreal` VALUES (1,1,'2023-11-21 15:52:55',NULL,'Regalo',500),(2,2,'2023-11-21 15:52:55',NULL,'Regalo',500),(3,3,'2023-11-21 15:52:55',NULL,'Regalo',500),(4,4,'2023-11-21 15:52:55',NULL,'Regalo',500),(5,5,'2023-11-21 15:52:55',NULL,'Regalo',500),(6,6,'2023-11-21 15:52:55',NULL,'Regalo',500),(7,7,'2023-11-21 15:52:55',NULL,'Regalo',500),(8,8,'2023-11-21 15:52:55',NULL,'Regalo',500),(9,9,'2023-11-21 15:52:55',NULL,'Regalo',500),(10,10,'2023-11-21 15:52:55',NULL,'Regalo',500),(11,11,'2023-11-21 15:52:55',NULL,'Regalo',500),(12,12,'2023-11-21 15:52:55',NULL,'Regalo',500),(13,13,'2023-11-21 15:52:55',NULL,'Regalo',500),(14,14,'2023-11-21 15:52:55',NULL,'Regalo',500),(15,15,'2023-11-21 15:52:55',NULL,'Regalo',500),(16,16,'2023-11-21 15:52:55',NULL,'Regalo',500),(17,17,'2023-11-21 15:52:55',NULL,'Regalo',500),(18,18,'2023-11-21 15:52:55',NULL,'Regalo',500),(19,19,'2023-11-21 15:52:55',NULL,'Regalo',500),(20,20,'2023-11-21 15:52:55',NULL,'Regalo',500),(21,21,'2023-11-21 15:52:55',NULL,'Regalo',500),(22,22,'2023-11-21 15:52:55',NULL,'Regalo',500),(23,23,'2023-11-21 15:52:55',NULL,'Regalo',500),(24,24,'2023-11-21 15:52:55',NULL,'Regalo',500),(25,25,'2023-11-21 15:52:55',NULL,'Regalo',500),(26,26,'2023-11-21 15:52:55',NULL,'Regalo',500),(27,27,'2023-11-21 15:52:55',NULL,'Regalo',500),(28,28,'2023-11-21 15:52:55',NULL,'Regalo',500),(29,29,'2023-11-21 15:52:55',NULL,'Regalo',500),(30,42,'2023-11-21 15:52:55',NULL,'Regalo',500),(31,43,'2023-11-21 15:52:55',NULL,'Regalo',500),(32,44,'2023-11-21 15:52:55',NULL,'Regalo',500),(33,45,'2023-11-21 15:52:55',NULL,'Regalo',500),(34,46,'2023-11-21 15:52:55',NULL,'Regalo',500),(35,47,'2023-11-21 15:52:55',NULL,'Regalo',500),(36,48,'2023-11-21 15:52:55',NULL,'Regalo',500),(37,49,'2023-11-21 15:52:55',NULL,'Regalo',500),(38,50,'2023-11-21 15:52:55',NULL,'Regalo',500),(39,51,'2023-11-21 15:52:55',NULL,'Regalo',500),(40,52,'2023-11-21 15:52:55',NULL,'Regalo',500),(41,53,'2023-11-21 15:52:55',NULL,'Regalo',500),(42,54,'2023-11-21 15:52:55',NULL,'Regalo',500),(43,55,'2023-11-21 15:52:55',NULL,'Regalo',500),(44,56,'2023-11-21 15:52:55',NULL,'Regalo',500),(45,57,'2023-11-21 15:52:55',NULL,'Regalo',500),(46,58,'2023-11-21 15:52:55',NULL,'Regalo',500),(47,59,'2023-11-21 15:52:55',NULL,'Regalo',500),(48,60,'2023-11-21 15:52:55',NULL,'Regalo',500),(49,61,'2023-11-21 15:52:55',NULL,'Regalo',500),(50,62,'2023-11-21 15:52:55',NULL,'Regalo',500),(51,63,'2023-11-21 15:52:55',NULL,'Regalo',500),(52,64,'2023-11-21 15:52:55',NULL,'Regalo',500),(53,65,'2023-11-21 15:52:55',NULL,'Regalo',500),(54,66,'2023-11-21 15:52:55',NULL,'Regalo',500),(64,1,'2023-11-22 18:32:07',NULL,'Regalo',100),(65,1,'2023-11-22 18:57:14',NULL,'Regalo',100),(66,1,'2023-11-22 19:08:07',NULL,'Regalo',100),(67,1,'2023-11-24 11:39:23',NULL,'Regalo',100000),(69,1,'2023-11-24 11:57:19',NULL,'Regalo',100000),(70,1,'2023-11-24 16:28:57',NULL,'Regalo',1000000),(71,1,'2023-11-24 18:04:27',NULL,'Regalo',100000),(72,1,'2023-11-24 18:04:29',NULL,'Regalo',100000),(73,1,'2023-11-24 18:04:51',NULL,'Regalo',100000),(74,1,'2023-11-24 18:04:52',NULL,'Regalo',100000),(75,1,'2023-11-24 18:04:52',NULL,'Regalo',100000),(76,1,'2023-11-24 18:04:52',NULL,'Regalo',100000),(77,1,'2023-11-24 18:04:53',NULL,'Regalo',100000),(78,1,'2023-11-24 18:04:53',NULL,'Regalo',100000),(79,1,'2023-11-24 18:04:53',NULL,'Regalo',100000),(80,1,'2023-11-24 19:54:59',NULL,'Regalo',1),(81,1,'2023-11-24 19:55:48',NULL,'Regalo',1),(82,1,'2023-11-24 19:55:52',NULL,'Regalo',1000),(83,1,'2023-11-24 19:56:07',NULL,'Regalo',200000),(84,1,'2023-11-24 19:56:40',NULL,'Regalo',100000),(85,1,'2023-11-24 19:57:33',NULL,'Regalo',100000),(86,1,'2023-11-24 21:20:46',NULL,'Regalo',100000),(87,1,'2023-11-27 13:41:12',NULL,'Regalo',100000),(88,2,'2023-11-27 13:50:28',NULL,'Regalo',10000);
/*!40000 ALTER TABLE `transaccionesdineroreal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaccionesgemas`
--

DROP TABLE IF EXISTS `transaccionesgemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaccionesgemas` (
  `idTransaccion` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int DEFAULT NULL,
  `TiempoTransaccion` datetime DEFAULT NULL,
  `idArticulo` int DEFAULT NULL,
  `Tipo` enum('Compra','Regalo') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CantidadGemas` int DEFAULT NULL,
  `Detalle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CompraDineroRealID` int DEFAULT NULL,
  PRIMARY KEY (`idTransaccion`),
  KEY `idUsuario` (`idUsuario`),
  KEY `idArticulo` (`idArticulo`),
  KEY `CompraDineroRealID` (`CompraDineroRealID`),
  CONSTRAINT `transaccionesgemas_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`IdUsuario`),
  CONSTRAINT `transaccionesgemas_ibfk_2` FOREIGN KEY (`idArticulo`) REFERENCES `articulos` (`IdArticulo`),
  CONSTRAINT `transaccionesgemas_ibfk_3` FOREIGN KEY (`CompraDineroRealID`) REFERENCES `transaccionesdineroreal` (`idTransaccion`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaccionesgemas`
--

LOCK TABLES `transaccionesgemas` WRITE;
/*!40000 ALTER TABLE `transaccionesgemas` DISABLE KEYS */;
INSERT INTO `transaccionesgemas` VALUES (1,1,'2023-11-24 11:41:21',27,'Compra',100000,'test',NULL),(2,1,'2023-11-24 16:27:55',32,'Compra',3000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(3,1,'2023-11-24 16:27:58',32,'Compra',3000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(4,1,'2023-11-24 16:27:59',32,'Compra',3000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(5,1,'2023-11-24 16:29:05',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(6,1,'2023-11-24 16:29:06',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(7,1,'2023-11-24 16:29:12',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(8,1,'2023-11-24 16:29:13',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(9,1,'2023-11-24 16:29:14',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(10,1,'2023-11-24 16:29:14',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(11,1,'2023-11-24 16:31:00',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(12,1,'2023-11-24 16:31:01',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(13,1,'2023-11-24 16:31:02',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(14,1,'2023-11-24 16:36:11',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(15,1,'2023-11-24 16:44:02',32,'Compra',3000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(16,1,'2023-11-24 16:44:05',32,'Compra',3000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(17,1,'2023-11-24 16:44:27',32,'Compra',3000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(18,1,'2023-11-24 16:44:29',32,'Compra',3000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(19,1,'2023-11-24 16:44:31',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(20,1,'2023-11-24 16:44:32',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(21,1,'2023-11-24 16:44:33',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(22,1,'2023-11-24 16:44:33',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(23,1,'2023-11-24 16:44:33',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(24,1,'2023-11-24 16:44:33',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(25,1,'2023-11-24 16:44:34',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(26,1,'2023-11-24 16:44:34',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(27,1,'2023-11-24 16:44:34',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(28,1,'2023-11-24 16:44:34',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(29,1,'2023-11-24 16:44:34',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(30,1,'2023-11-24 16:44:34',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(31,1,'2023-11-24 16:44:35',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(32,1,'2023-11-24 16:44:35',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(33,1,'2023-11-24 16:44:35',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(34,1,'2023-11-24 16:44:35',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(35,1,'2023-11-24 16:44:36',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(36,1,'2023-11-24 16:44:36',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(37,1,'2023-11-24 16:44:36',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(38,1,'2023-11-24 16:44:36',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(39,1,'2023-11-24 18:04:34',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(40,1,'2023-11-24 18:04:42',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(41,1,'2023-11-24 18:04:57',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(42,1,'2023-11-24 19:55:57',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(43,1,'2023-11-24 19:55:58',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(44,1,'2023-11-24 19:55:58',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(45,1,'2023-11-24 19:55:59',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(46,1,'2023-11-24 19:56:00',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(47,1,'2023-11-24 19:56:01',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(48,1,'2023-11-24 19:56:09',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(49,1,'2023-11-24 19:56:32',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(50,1,'2023-11-24 19:56:34',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(51,1,'2023-11-24 19:56:34',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(52,1,'2023-11-24 19:56:42',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(53,1,'2023-11-24 19:57:37',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(54,1,'2023-11-24 21:20:49',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(55,1,'2023-11-27 13:41:14',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(56,1,'2023-11-27 13:41:20',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(57,2,'2023-11-27 13:50:31',29,'Compra',4200,'Compra de premio de mundo real por gemas mediante sitio web.',NULL),(58,1,'2023-11-27 20:15:15',28,'Compra',100000,'Compra de premio de mundo real por gemas mediante sitio web.',NULL);
/*!40000 ALTER TABLE `transaccionesgemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `IdUsuario` int NOT NULL AUTO_INCREMENT,
  `UsernameUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `CorreoUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `PasswordUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `NombresUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ApellidoPUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ApellidoMUsuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FechaNacimientoUsuario` date DEFAULT NULL,
  `DireccionUsuarioCalle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `GeneroUsuario` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `TelefonoUsuario` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `FechaCreacionUsuario` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Administrador` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`IdUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','admin@example.com','adminpass','Admin','Admin','Admin','1990-01-01','Admin Street 1','Masculino','555-0001','2023-11-15 19:12:24',1),(2,'maria.garcia','maria.garcia@example.com','password2','Maria','Garcia','Lopez','1991-02-02','Oak Street 2','Femenino','555-0002','2023-11-15 19:12:24',0),(3,'jose.martinez','jose.martinez@example.com','password3','Jose','Martinez','Hernandez','1992-03-03','Pine Street 3','Masculino','555-0003','2023-11-15 19:12:24',0),(4,'laura.hernandez','laura.hernandez@example.com','password4','Laura','Hernandez','Gonzalez','1993-04-04','Maple Street 4','Femenino','555-0004','2023-11-15 19:12:24',0),(5,'david.lopez','david.lopez@example.com','password5','David','Lopez','Perez','1994-05-05','Cedar Street 5','Masculino','555-0005','2023-11-15 19:12:24',0),(6,'sofia.gonzalez','sofia.gonzalez@example.com','password6','Sofia','Gonzalez','Sanchez','1995-06-06','Birch Street 6','Femenino','555-0006','2023-11-15 19:12:24',0),(7,'daniel.sanchez','daniel.sanchez@example.com','password7','Daniel','Sanchez','Ramirez','1996-07-07','Spruce Street 7','Masculino','555-0007','2023-11-15 19:12:24',0),(8,'isabella.perez','isabella.perez@example.com','password8','Isabella','Perez','Flores','1997-08-08','Willow Street 8','Femenino','555-0008','2023-11-15 19:12:24',0),(9,'mateo.ramirez','mateo.ramirez@example.com','password9','Mateo','Ramirez','Castro','1998-09-09','Elm Street 9','Masculino','555-0009','2023-11-15 19:12:24',0),(10,'adminuser','admin@example.com','admin123','Admin','User','Admin','1980-01-01','123 Admin Street','Otro','1234567890','2023-11-14 00:40:41',1),(11,'johndoe','john.doe@example.com','password123','John','Doe','Smith','1992-05-10','456 Main Street','Masculino','2345678901','2023-11-14 00:40:41',0),(12,'janedoe','jane.doe@example.com','janeDoe2023','Jane','Doe','Johnson','1990-03-15','789 Side Street','Femenino','3456789012','2023-11-14 00:40:41',0),(13,'mariagarcia','maria.garcia@example.com','mariaG2023','Maria','Garcia','Lopez','1995-07-20','1010 Long Road','Femenino','4567890123','2023-11-14 00:40:41',0),(14,'davidmartinez','david.martinez@example.com','davidM2023','David','Martinez','Fernandez','1988-11-30','1111 Short Lane','Masculino','5678901234','2023-11-14 00:40:41',0),(15,'sarahbrown','sarah.brown@example.com','sarahB2023','Sarah','Brown','Wilson','1993-02-24','1212 Maple Ave','Femenino','6789012345','2023-11-14 00:40:41',0),(16,'michaelwhite','michael.white@example.com','michaelW2023','Michael','White','Green','1987-09-17','1313 Oak St','Masculino','7890123456','2023-11-14 00:40:41',0),(17,'emilygomez','emily.gomez@example.com','emilyG2023','Emily','Gomez','Davis','1996-12-05','1414 Pine St','Femenino','8901234567','2023-11-14 00:40:41',0),(18,'jamesjohnson','james.johnson@example.com','jamesJ2023','James','Johnson','Miller','1991-06-19','1515 Birch Rd','Masculino','9012345678','2023-11-14 00:40:41',0),(19,'lindasmith','linda.smith@example.com','lindaS2023','Linda','Smith','Martinez','1994-04-08','1616 Cedar Blvd','Femenino','0123456789','2023-11-14 00:40:41',0),(20,'carloslopez','carlos.lopez@example.com','carlosL2023','Carlos','Lopez','Hernandez','1989-08-23','1717 Elm St','Masculino','1234509876','2023-11-14 00:40:41',0),(21,'elizabethgomez','elizabeth.gomez@example.com','elizabethG2023','Elizabeth','Gomez','Perez','1997-10-12','1818 Spruce Ave','Femenino','2345609876','2023-11-14 00:40:41',0),(22,'williamjones','william.jones@example.com','williamJ2023','William','Jones','Garcia','1986-01-22','1919 Fir St','Masculino','3456709876','2023-11-14 00:40:41',0),(23,'amysanchez','amy.sanchez@example.com','amyS2023','Amy','Sanchez','Rodriguez','1999-03-31','2020 Hazel Way','Femenino','4567809876','2023-11-14 00:40:41',0),(24,'joseramirez','jose.ramirez@example.com','joseR2023','Jose','Ramirez','Morales','1998-07-14','2121 Maple Dr','Masculino','5678909876','2023-11-14 00:40:41',0),(25,'laura_martinez','laura.martinez@example.com','LauraM2023','Laura','Martinez','Reyes','1996-08-15','2222 Cherry Ln','Femenino','6678909876','2023-11-14 00:41:25',0),(26,'kevin_rodriguez','kevin.rodriguez@example.com','KevinR2023','Kevin','Rodriguez','Castillo','1991-11-25','2323 Apple Rd','Masculino','7789019876','2023-11-14 00:41:25',0),(27,'sophia_perez','sophia.perez@example.com','SophiaP2023','Sophia','Perez','Vasquez','1994-10-10','2424 Banana St','Femenino','8890129876','2023-11-14 00:41:25',0),(28,'alejandro_gomez','alejandro.gomez@example.com','AlejandroG2023','Alejandro','Gomez','Diaz','1990-02-20','2525 Grape Ave','Masculino','9901239876','2023-11-14 00:41:25',0),(29,'isabella_flores','isabella.flores@example.com','IsabellaF2023','Isabella','Flores','Torres','1998-05-05','2626 Peach Blvd','Femenino','10123459876','2023-11-14 00:41:25',0),(42,'johnsmith45','johnsmith45@example.com','password','John','Smith','Brown','1973-05-21','Maple Street 45','Masculino','555-0015','2023-11-20 06:00:00',0),(43,'emilyjones50','emilyjones50@example.com','password','Emily','Jones','Davis','1968-08-30','Oak Street 50','Femenino','555-0016','2023-11-20 06:00:00',0),(44,'carloslopez55','carloslopez55@example.com','password','Carlos','Lopez','Martinez','1965-12-05','Cedar Blvd 55','Masculino','555-0017','2023-11-20 06:00:00',0),(45,'mariagarcia60','mariagarcia60@example.com','password','Maria','Garcia','Perez','1960-11-02','Birch Street 60','Femenino','555-0018','2023-11-20 06:00:00',0),(46,'davidmartinez65','davidmartinez65@example.com','password','David','Martinez','Fernandez','1955-09-14','Short Lane 65','Masculino','555-0019','2023-11-20 06:00:00',0),(47,'sarahbrown70','sarahbrown70@example.com','password','Sarah','Brown','Wilson','1950-02-17','Maple Ave 70','Femenino','555-0020','2023-11-20 06:00:00',0),(48,'michaelwhite75','michaelwhite75@example.com','password','Michael','White','Green','1945-04-22','Oak St 75','Masculino','555-0021','2023-11-20 06:00:00',0),(49,'jamesjohnson80','jamesjohnson80@example.com','password','James','Johnson','Miller','1940-07-13','Birch Rd 80','Masculino','555-0022','2023-11-20 06:00:00',0),(50,'lindasmith85','lindasmith85@example.com','password','Linda','Smith','Martinez','1935-06-09','Cedar Blvd 85','Femenino','555-0023','2023-11-20 06:00:00',0),(51,'carlosramirez90','carlosramirez90@example.com','password','Carlos','Ramirez','Hernandez','1930-10-18','Elm St 90','Masculino','555-0024','2023-11-20 06:00:00',0),(52,'elizabethgomez','elizabethgomez@example.com','password','Elizabeth','Gomez','Perez','1972-03-15','Spruce Ave 51','Femenino','555-0025','2023-11-20 06:00:00',0),(53,'williamjones','williamjones@example.com','password','William','Jones','Garcia','1971-07-20','First St 52','Masculino','555-0026','2023-11-20 06:00:00',0),(54,'amysanchez','amysanchez@example.com','password','Amy','Sanchez','Rodriguez','1970-11-30','Hazel Way 53','Femenino','555-0027','2023-11-20 06:00:00',0),(55,'joseramirez','joseramirez@example.com','password','Jose','Ramirez','Morales','1969-12-01','Maple Dr 54','Masculino','555-0028','2023-11-20 06:00:00',0),(56,'lauramartinez','lauramartinez@example.com','password','Laura','Martinez','Reyes','1968-10-23','Cherry Ln 55','Femenino','555-0029','2023-11-20 06:00:00',0),(57,'robertwhite','robertwhite@example.com','password','Robert','White','Brown','1967-08-17','Second St 56','Masculino','555-0030','2023-11-20 06:00:00',0),(58,'mariagarcia54','mariagarcia54@example.com','password','Maria','Garcia','Lopez','1973-09-08','Oak St 57','Femenino','555-0031','2023-11-20 06:00:00',0),(59,'davidlopez','davidlopez@example.com','password','David','Lopez','Perez','1974-05-05','Cedar St 58','Masculino','555-0032','2023-11-20 06:00:00',0),(60,'sofiagonzalez','sofiagonzalez@example.com','password','Sofia','Gonzalez','Sanchez','1965-06-06','Birch St 59','Femenino','555-0033','2023-11-20 06:00:00',0),(61,'danielsanchez','danielsanchez@example.com','password','Daniel','Sanchez','Ramirez','1976-07-07','Spruce Ave 60','Masculino','555-0034','2023-11-20 06:00:00',0),(62,'isabellaperez','isabellaperez@example.com','password','Isabella','Perez','Flores','1977-08-08','Willow St 61','Femenino','555-0035','2023-11-20 06:00:00',0),(63,'mateoramirez','mateoramirez@example.com','password','Mateo','Ramirez','Castro','1978-09-09','Elm St 62','Masculino','555-0036','2023-11-20 06:00:00',0),(64,'susanwhite','susanwhite@example.com','password','Susan','White','Green','1979-05-25','Third St 63','Femenino','555-0037','2023-11-20 06:00:00',0),(65,'nancybrown','nancybrown@example.com','password','Nancy','Brown','Wilson','1960-11-11','Fourth St 64','Femenino','555-0038','2023-11-20 06:00:00',0),(66,'gregsmith','gregsmith@example.com','password','Greg','Smith','Miller','1961-12-12','Fifth Rd 65','Masculino','555-0039','2023-11-20 06:00:00',0);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `AfterUserCreation` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    -- Insertar relaciones en articulousuario
    INSERT INTO articulousuario (IdUsuario, IdArticulo) VALUES (NEW.IdUsuario, 22);
    INSERT INTO articulousuario (IdUsuario, IdArticulo) VALUES (NEW.IdUsuario, 23);
    INSERT INTO articulousuario (IdUsuario, IdArticulo) VALUES (NEW.IdUsuario, 24);
    INSERT INTO articulousuario (IdUsuario, IdArticulo) VALUES (NEW.IdUsuario, 25);
    
    -- Luego, insertar en inventariousuario
    INSERT INTO inventariousuario (IdUsuario, IdMarco, IdVehiculo, IdCabeza, IdCuerpo)
    VALUES (NEW.IdUsuario, 22, 23, 24, 25);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'crazysorteo_test'
--

--
-- Dumping routines for database 'crazysorteo_test'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-28 14:33:16

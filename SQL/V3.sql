CREATE DATABASE  IF NOT EXISTS `copa_frisa` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `copa_frisa`;
-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: localhost    Database: copa_frisa
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `coordinador`
--

DROP TABLE IF EXISTS `coordinador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coordinador` (
  `id_coordinador` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_equipo` int DEFAULT NULL,
  PRIMARY KEY (`id_coordinador`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_equipo` (`id_equipo`),
  CONSTRAINT `coordinador_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `coordinador_ibfk_2` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coordinador`
--

LOCK TABLES `coordinador` WRITE;
/*!40000 ALTER TABLE `coordinador` DISABLE KEYS */;
/*!40000 ALTER TABLE `coordinador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `copas`
--

DROP TABLE IF EXISTS `copas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `copas` (
  `id_copa` int NOT NULL AUTO_INCREMENT,
  `edicion` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id_copa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `copas`
--

LOCK TABLES `copas` WRITE;
/*!40000 ALTER TABLE `copas` DISABLE KEYS */;
/*!40000 ALTER TABLE `copas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipos`
--

DROP TABLE IF EXISTS `equipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipos` (
  `id_equipo` int NOT NULL AUTO_INCREMENT,
  `nombre_equipo` varchar(64) DEFAULT NULL,
  `escudo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_equipo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipos`
--

LOCK TABLES `equipos` WRITE;
/*!40000 ALTER TABLE `equipos` DISABLE KEYS */;
INSERT INTO `equipos` VALUES (1,'Team A','storage/img/escudos/logo1.png'),(2,'Team B','storage/img/escudos/logo2.png'),(3,'Team C','storage/img/escudos/logo3.png'),(4,'Team D','storage/img/escudos/logo4.png'),(5,'Team E','storage/img/escudos/logo1.png'),(6,'Team F','storage/img/escudos/logo2.png'),(7,'Team G','storage/img/escudos/logo3.png'),(8,'Team H','storage/img/escudos/logo4.png');
/*!40000 ALTER TABLE `equipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugadores`
--

DROP TABLE IF EXISTS `jugadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugadores` (
  `id_jugador` int NOT NULL AUTO_INCREMENT,
  `fecha_nac` date DEFAULT NULL,
  `CURP` varchar(32) DEFAULT NULL,
  `domicilio` varchar(255) DEFAULT NULL,
  `telefono` varchar(16) DEFAULT NULL,
  `nombre` varchar(128) DEFAULT NULL,
  `apellido_p` varchar(64) DEFAULT NULL,
  `apellido_m` varchar(64) DEFAULT NULL,
  `num_imss` varchar(64) DEFAULT NULL,
  `id_usuario` int NOT NULL,
  `id_equipo` int DEFAULT NULL,
  `doc_carta_responsabilidad` varchar(128) DEFAULT NULL,
  `doc_curp` varchar(128) DEFAULT NULL,
  `doc_ine` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_jugador`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_equipo` (`id_equipo`),
  CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `jugadores_ibfk_2` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugadores`
--

LOCK TABLES `jugadores` WRITE;
/*!40000 ALTER TABLE `jugadores` DISABLE KEYS */;
INSERT INTO `jugadores` VALUES (1,'1995-05-15','MARC950515HDFLRN09','123 Avenida Siempre Viva','555-1010','Carlos','Martinez','Lopez','987654321',4,1,NULL,NULL,NULL),(2,'1998-08-22','GARL980822MDFLRL09','456 Calle de la Luna','555-2020','Laura','Garcia','Hernandez','123456789',5,2,NULL,NULL,NULL),(3,'1992-12-10','RODM921210HDFLRN07','789 Calle del Sol','555-3030','Manuel','Rodriguez','Perez','234567891',6,3,NULL,NULL,NULL),(4,'1997-03-18','FERM970318MDFLRN03','321 Calle del Mar','555-4040','Maria','Fernandez','Gomez','345678912',7,4,NULL,NULL,NULL);
/*!40000 ALTER TABLE `jugadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partidos`
--

DROP TABLE IF EXISTS `partidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partidos` (
  `id_partido` int NOT NULL AUTO_INCREMENT,
  `id_copa` int NOT NULL,
  `equipo_a` int DEFAULT NULL,
  `equipo_b` int DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `ganador` int DEFAULT NULL,
  PRIMARY KEY (`id_partido`),
  KEY `equipo_a` (`equipo_a`),
  KEY `equipo_b` (`equipo_b`),
  KEY `id_copa` (`id_copa`),
  CONSTRAINT `partidos_ibfk_1` FOREIGN KEY (`equipo_a`) REFERENCES `equipos` (`id_equipo`),
  CONSTRAINT `partidos_ibfk_2` FOREIGN KEY (`equipo_b`) REFERENCES `equipos` (`id_equipo`),
  CONSTRAINT `partidos_ibfk_3` FOREIGN KEY (`id_copa`) REFERENCES `copas` (`id_copa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidos`
--

LOCK TABLES `partidos` WRITE;
/*!40000 ALTER TABLE `partidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `partidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicaciones`
--

DROP TABLE IF EXISTS `publicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicaciones` (
  `id_post` int NOT NULL AUTO_INCREMENT,
  `autor` int DEFAULT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `titulo` text NOT NULL,
  `contenido` text,
  `imagen` varchar(255) DEFAULT NULL,
  `id_copa` int NOT NULL,
  PRIMARY KEY (`id_post`),
  KEY `autor` (`autor`),
  KEY `id_copa` (`id_copa`),
  CONSTRAINT `publicaciones_ibfk_1` FOREIGN KEY (`autor`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `publicaciones_ibfk_2` FOREIGN KEY (`id_copa`) REFERENCES `copas` (`id_copa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicaciones`
--

LOCK TABLES `publicaciones` WRITE;
/*!40000 ALTER TABLE `publicaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `publicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puntos`
--

DROP TABLE IF EXISTS `puntos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `puntos` (
  `id_punto` int NOT NULL AUTO_INCREMENT,
  `id_partido` int DEFAULT NULL,
  `id_jugador` int DEFAULT NULL,
  `id_equipo` int DEFAULT NULL,
  `tipo_punto` int DEFAULT NULL,
  `tiempo_punto` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_punto`),
  KEY `id_partido` (`id_partido`),
  KEY `id_jugador` (`id_jugador`),
  KEY `id_equipo` (`id_equipo`),
  KEY `fk_tipo_punto` (`tipo_punto`),
  CONSTRAINT `fk_tipo_punto` FOREIGN KEY (`tipo_punto`) REFERENCES `tipo_puntos` (`id_tipo_punto`),
  CONSTRAINT `puntos_ibfk_1` FOREIGN KEY (`id_partido`) REFERENCES `partidos` (`id_partido`),
  CONSTRAINT `puntos_ibfk_2` FOREIGN KEY (`id_jugador`) REFERENCES `jugadores` (`id_jugador`),
  CONSTRAINT `puntos_ibfk_3` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puntos`
--

LOCK TABLES `puntos` WRITE;
/*!40000 ALTER TABLE `puntos` DISABLE KEYS */;
/*!40000 ALTER TABLE `puntos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_puntos`
--

DROP TABLE IF EXISTS `tipo_puntos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_puntos` (
  `id_tipo_punto` int NOT NULL,
  `nombre_punto` varchar(32) DEFAULT NULL,
  `descripcion_punto` text,
  `valor_punto` int DEFAULT NULL,
  PRIMARY KEY (`id_tipo_punto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_puntos`
--

LOCK TABLES `tipo_puntos` WRITE;
/*!40000 ALTER TABLE `tipo_puntos` DISABLE KEYS */;
INSERT INTO `tipo_puntos` VALUES (1,'gol','gol en alguna partida. se le atribuye a un jugador especifico.',1),(2,'tarjeta verde','tarjeta verde o punto por fair play. se le atribuye a un jugador especifico.',1),(3,'tarjeta amarilla','primera tarjeta amarilla. se le atribuye a un jugador especifico.',1),(4,'tarjeta roja indirecta','segunda tarjeta amarilla o tarjeta roja indirecta. se añade automaticamente al marcar una segunda tarjeta amarilla al mismo jugador. se le atribuye a un jugador especifico.',2),(5,'tarjeta roja directa','tarjeta roja por mal juego o rompimiento de reglas. se le atribuye a un jugador especifico.',3),(6,'partido ganado','3 puntos otorgados automaticamente al ganador de un partido. se le atribuye a un equipo especifico.',3),(7,'partido empatado','1 punto otorgado automaticamentea ambos equipos que queden empatados en un partido. se le atribuye a un equipo especfico.',1);
/*!40000 ALTER TABLE `tipo_puntos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_usuario` (
  `id_tipo` int NOT NULL,
  `nombre_tipo` varchar(64) DEFAULT NULL,
  `descripcion_tipo` text,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_usuario`
--

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `tipo_usuario` int DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'johndoe','John Doe','john.doe@example.com','hashed_password_here',1,'path_to_image','2024-04-29 21:36:12'),(2,'janedoe','Jane Doe','jane.doe@example.com','hashed_password_here',2,'path_to_image','2024-04-29 21:36:12'),(3,'alexsmith','Alex Smith','alex.smith@example.com','hashed_password_here',3,'path_to_image','2024-04-29 21:36:12'),(4,'carlos.martinez','Carlos Martinez','carlos.martinez@example.com','$2b$10$LoMY.q090Tp8JRR6fIn9oOGODv6U4I5WKUdtw3eZNFVEF8lsFxldC',2,'NA','2024-05-16 19:32:56'),(5,'laura.garcia','Laura Garcia','laura.garcia@example.com','$2b$10$f5QxMhXBJ/0aOwuseg5kye7I8Iv8S5Urp.1drZuSB8cWtbAGll676',2,'NA','2024-05-16 19:33:31'),(6,'manuel.rodriguez','Manuel Rodriguez','manuel.rodriguez@example.com','$2b$10$fvyzWWaSQNZfogCdPDw1JOzcpQC7k1WeWetS8e6ce/wXBmNQ65fs.',2,'NA','2024-05-16 19:33:42'),(7,'maria.fernandez','Maria Fernandez','maria.fernandez@example.com','$2b$10$ckzBzPmqMGQdywHAmh7EJuPy5Ng5O6gAQZGvhHM2azK0rzWYWlezC',2,'NA','2024-05-16 19:33:49');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'copa_frisa'
--

--
-- Dumping routines for database 'copa_frisa'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-27 16:22:48

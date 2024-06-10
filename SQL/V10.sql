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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `copas`
--

LOCK TABLES `copas` WRITE;
/*!40000 ALTER TABLE `copas` DISABLE KEYS */;
INSERT INTO `copas` VALUES (1,'2024');
/*!40000 ALTER TABLE `copas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EQUIPOS`
--

DROP TABLE IF EXISTS `EQUIPOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EQUIPOS` (
  `id_equipo` int NOT NULL AUTO_INCREMENT,
  `nombre_equipo` varchar(64) DEFAULT NULL,
  `escudo` varchar(255) DEFAULT NULL,
  `escuela` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id_equipo`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EQUIPOS`
--

LOCK TABLES `EQUIPOS` WRITE;
/*!40000 ALTER TABLE `EQUIPOS` DISABLE KEYS */;
INSERT INTO `EQUIPOS` VALUES (1,'Los Tigres de Juárez','storage/img/escudos/logo1.png','Primaria Benito Juárez'),(2,'Águilas de Hidalgo','storage/img/escudos/logo2.png','Primaria Miguel Hidalgo'),(3,'Leones de Cárdenas','storage/img/escudos/logo3.png','Primaria Lázaro Cárdenas'),(4,'Zorros de Zapata','storage/img/escudos/logo4.png','Primaria Emiliano Zapata'),(5,'Panteras de Carranza','storage/img/escudos/logo1.png','Primaria Venustiano Carranza'),(6,'Toros de Madero','storage/img/escudos/logo2.png','Primaria Francisco I. Madero'),(7,'Jaguares de Morelos','storage/img/escudos/logo3.png','Primaria José María Morelos'),(8,'Halcones de Sor Juana','storage/img/escudos/logo4.png','Primaria Sor Juana Inés de la Cruz'),(12,'tilines','storage/img/escudos/1717824894835-kratos.jpeg','academia tilin'),(13,'tilines2','storage/img/escudos/1717817022417-62b.jpeg','mejor academia tilin'),(14,'tilines3','storage/img/escudos/1717817821154-kratos.jpeg','aun mejor academia tilin'),(15,'pepes','storage/img/escudos/1717822139672-IMG_5753.jpg','academia super pepes');
/*!40000 ALTER TABLE `EQUIPOS` ENABLE KEYS */;
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
  `posicion` varchar(64) DEFAULT NULL,
  `doc_carta_responsabilidad` varchar(128) DEFAULT NULL,
  `doc_curp` varchar(128) DEFAULT NULL,
  `doc_ine` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id_jugador`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_equipo` (`id_equipo`),
  CONSTRAINT `jugadores_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `jugadores_ibfk_2` FOREIGN KEY (`id_equipo`) REFERENCES `equipos` (`id_equipo`)
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugadores`
--

LOCK TABLES `jugadores` WRITE;
/*!40000 ALTER TABLE `jugadores` DISABLE KEYS */;
INSERT INTO `jugadores` VALUES (176,'2011-04-16','FERNL110415HDFLLV','Calle Rosa 987','555-3456','Lucia','Fernandez','Ortega','1234567895',188,2,'Mediocampista',NULL,NULL,NULL),(177,'2010-12-03','LOPEM101202HDFLLX','Calle Naranja 147','555-2345','Sofia','Lopez','Diaz','1234567897',189,2,'Portero',NULL,NULL,NULL),(178,'2012-03-23','RAMIP120322HDFLLW','Calle Blanca 789','555-7654','Pedro','Ramirez','Torres','1234567896',190,2,'Delantero',NULL,NULL,NULL),(179,'2012-01-12','TORRG120111HDFLLZ','Calle Gris 369','555-7890','Gabriela','Torres','Aguilar','1234567899',191,2,'Portero',NULL,NULL,NULL),(180,'2010-09-26','SANCD100925HDFLMA','Calle Violeta 741','555-3214','Diego','Sanchez','Mendoza','1234567810',192,3,'Portero',NULL,NULL,NULL),(181,'2011-06-20','MORAL110619HDFLLY','Calle Negra 258','555-6543','Luis','Morales','Ruiz','1234567898',193,2,'Delantero',NULL,NULL,NULL),(182,'2012-07-14','DIAZR120713HDFLMC','Calle Azul 963','555-9871','Ricardo','Diaz','Moreno','1234567812',194,3,'Portero',NULL,NULL,NULL),(183,'2010-11-19','RUIZV101118HDFLMD','Av. Verde 753','555-1598','Valeria','Ruiz','Jimenez','1234567813',195,3,'Portero',NULL,NULL,NULL),(184,'2011-03-31','ALVEM110330HDFLME','Calle Amarilla 369','555-7531','Miguel','Alvarez','Herrera','1234567814',196,3,'Defensa',NULL,NULL,NULL),(185,'2010-05-15','PEREJ010514HDFLLN','Calle Falsa 123','555-1234','Juan','Perez','Lopez','1234567890',197,1,'Portero',NULL,NULL,NULL),(186,'2011-10-06','REYEL111005HDFLMB','Calle Roja 852','555-6542','Laura','Reyes','Ortega','1234567811',198,3,'Portero',NULL,NULL,NULL),(187,'2011-08-23','GONZM110822HDFLLR','Av. Siempre Viva 742','555-5678','Maria','Gonzalez','Ramirez','1234567891',199,1,'Delantero',NULL,NULL,NULL),(188,'2012-02-10','HERNH120209HDFLLS','Calle Verde 456','555-9876','Carlos','Hernandez','Gomez','1234567892',200,1,'Portero',NULL,NULL,NULL),(189,'2011-12-01','MARTA111130HDFLLT','Av. Azul 321','555-4321','Ana','Martinez','Sanchez','1234567893',201,1,'Defensa',NULL,NULL,NULL),(190,'2010-07-08','RODRJ100707HDFLLU','Calle Amarilla 654','555-8765','Jose','Rodriguez','Morales','1234567894',202,1,'Defensa',NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidos`
--

LOCK TABLES `partidos` WRITE;
/*!40000 ALTER TABLE `partidos` DISABLE KEYS */;
INSERT INTO `partidos` VALUES (1,1,1,2,'2024-06-02 00:00:00',1),(3,1,15,12,'2024-06-19 02:36:00',NULL),(4,1,6,13,'2024-05-30 02:43:00',NULL),(7,1,3,1,'2024-06-01 08:17:00',NULL),(8,1,3,1,'2024-06-05 20:17:00',NULL),(9,1,3,1,'2024-06-09 20:12:00',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicaciones`
--

LOCK TABLES `publicaciones` WRITE;
/*!40000 ALTER TABLE `publicaciones` DISABLE KEYS */;
INSERT INTO `publicaciones` VALUES (5,9,'2024-06-08 00:13:40','when','haces tus momos en un post el futuro es hoy oiste viejo','storage/img/publicaciones/1717827222795-monkey-earbuds.jpeg',1),(14,1,'2024-06-09 16:47:01','ggg','ggggg','storage/img/publicaciones/1717973221910-soundtracks.png',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puntos`
--

LOCK TABLES `puntos` WRITE;
/*!40000 ALTER TABLE `puntos` DISABLE KEYS */;
INSERT INTO `puntos` VALUES (7,1,189,1,1,'2024-06-09 19:47:11'),(8,8,189,1,1,'2024-06-09 20:07:52'),(9,1,189,1,1,'2024-06-09 20:12:39'),(10,7,189,1,1,'2024-06-09 20:13:58'),(11,1,189,1,1,'2024-06-09 20:50:28'),(12,1,189,1,1,'2024-06-09 20:53:59'),(13,1,189,1,2,'2024-06-09 20:54:03'),(24,7,180,3,3,'2024-06-10 00:40:13'),(25,7,180,3,4,'2024-06-10 00:40:15'),(26,7,180,3,5,'2024-06-10 00:40:17'),(27,7,180,3,5,'2024-06-10 00:40:20'),(28,7,180,3,5,'2024-06-10 00:40:22'),(29,1,185,1,3,'2024-06-10 03:50:05'),(30,1,185,1,4,'2024-06-10 03:50:09'),(31,1,176,2,3,'2024-06-10 03:50:12'),(32,1,185,1,5,'2024-06-10 03:50:14'),(33,1,187,1,3,'2024-06-10 03:52:16'),(34,1,187,1,4,'2024-06-10 03:52:24'),(35,1,176,2,5,'2024-06-10 03:52:43');
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
  `first_login` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'johndoe','John Doe','john.doe@example.com','hashed_password_here',1,'NA','2024-04-29 21:36:12',1),(2,'janedoe','Jane Doe','jane.doe@example.com','hashed_password_here',2,'NA','2024-04-29 21:36:12',1),(3,'alexsmith','Alex Smith','alex.smith@example.com','hashed_password_here',3,'NA','2024-04-29 21:36:12',1),(9,'admin','admin','jemilianobustamante@gmail.com','$2a$10$kONDdN4ruGEKKHlPqNIBiOc1.iZeYkmAcmeMh0d7SZ/AaNWFKJKbu',1,'NA','2024-06-03 16:32:30',1),(10,'guest','guest','guest@example.com','$2a$10$w8XnRHRTpyd.LXWim2jK..pLloqtDa47s536HkbuEYZa2KwTdzTeG',3,NULL,'2024-06-06 21:22:28',1),(11,'test','test','test@test.com','$2a$10$0EUu3YJXR5qIAix2aDJyuO/HM9FWJHbzf8AxQ5hie4MoHBfg9NROu',3,NULL,'2024-06-06 21:44:59',1),(12,'2test','2test','2test@gmail.com','$2a$10$R.Zm1Z5f6PcLeEqmZte5xOWDz0u375YFB9czuPO8U2U97.eU5.sS6',3,NULL,'2024-06-06 21:53:53',1),(13,'3test','3test','3test@gmail.com','$2a$10$rhLWxoJwdzbgaFu54wzZ0eGELt6vAlqM0i05Ri0jQmzUPb5Ragram',3,NULL,'2024-06-06 22:22:24',1),(14,'2te','2te','2test','$2a$10$5ElHj1NZnyc25y50LL7k0O.jRTjd7D2yKmAMYcrjQa1sbQOykPj1O',3,NULL,'2024-06-06 22:29:26',1),(15,'5test','5test','5test@gmail.com','$2a$10$FEILHYfkZCaGMIok26TRd.TRzcIRGZsOTtBjmrdqyAHglagkXzkVi',3,NULL,'2024-06-06 22:36:38',1),(32,'invitado','invitado','invitado@example.com','$2a$10$yYhvANcj1H0RTCHUoVcNQ.MkkMCFsWJvx3AxWZHf3DgEU/7L2fD.C',3,NULL,'2024-06-07 05:13:45',1),(33,'JorgeB','JorgeB','jorge@gmail.com','$2a$10$k/SHyGWkrkQQLqJht.2fQOXqMn6sKgNSo2BsPOIIONaBGGGj4pM5C',3,NULL,'2024-06-07 05:27:06',1),(188,'LF786','Lucia Fernandez','lucia.fernandez@example.com','$2a$10$DsszMji0M/gwTLdVNAsYOuji/ccGvMqNWc16cxDWthrIMyXzaZrx.',2,'NA','2024-06-09 19:21:16',0),(189,'SL632','Sofia Lopez','sofia.lopez@example.com','$2a$10$EImSRdUTU6BFsHeIZ3B5Du4U.Ze7VpfMdKeNBvsVw2rIqcrDIxgve',2,'NA','2024-06-09 19:21:16',0),(190,'PR361','Pedro Ramirez','pedro.ramirez@example.com','$2a$10$c7doDrOxEU2bWHOcJhaA4.UBYdoCcJ3j0gK7UH5awOgLF4E8pp0PS',2,'NA','2024-06-09 19:21:16',1),(191,'GT125','Gabriela Torres','gabriela.torres@example.com','$2a$10$Jvbxn7/igF/qjVfs4osC1uXG3KxI/U6znQUp3fN4GvJ4LjqhJHLg2',2,'NA','2024-06-09 19:21:16',1),(192,'DS946','Diego Sanchez','diego.sanchez@example.com','$2a$10$dX/1Oc8jtUws84xDW.hfGu9wvvk6XBhDog.NLu21U2J3Dgu0J3QOq',2,'NA','2024-06-09 19:21:16',1),(193,'LM586','Luis Morales','luis.morales@example.com','$2a$10$.WT.Vb098N6yigAMWtPsxez0KnwjfMwTtTLxSuXyiyt0BxLzlrzxi',2,'NA','2024-06-09 19:21:16',1),(194,'RD225','Ricardo Diaz','ricardo.diaz@example.com','$2a$10$OM6F8.bJ61I6533wybrvFeEmxDS5j0yvdmmtYLVKwOPF0TukEUWAq',2,'NA','2024-06-09 19:21:16',1),(195,'VR529','Valeria Ruiz','valeria.ruiz@example.com','$2a$10$AjEbOa.RLb5MywgbIRpY0.KPdQ3X1dp6pKg7qcYVp.SI4xVEiHhDK',2,'NA','2024-06-09 19:21:16',1),(196,'MA493','Miguel Alvarez','miguel.alvarez@example.com','$2a$10$FhNMEfHof50ZLZqb3IbX/eCr1n77UEHT71YGX9zFQ1PLv7gbMFod6',2,'NA','2024-06-09 19:21:16',1),(197,'JP118','Juan Perez','juan.perez@example.com','$2a$10$avE0qvQYGdLPcW.G6FKaHeVo4s2g9S1buNcb3iv1PoD1XRiseBLiK',2,'NA','2024-06-09 19:21:16',1),(198,'LR393','Laura Reyes','laura.reyes@example.com','$2a$10$xSIgSocezEATSm1WFHnBSe19lcDfArCmHyLLejXrW57f7OICgz5le',2,'NA','2024-06-09 19:21:16',1),(199,'MG430','Maria Gonzalez','maria.gonzalez@example.com','$2a$10$VMC4K99T7E/aeVXcdzIKEOeslhDCroc5e9FavL1sIsU6Oamn0CTKK',2,'NA','2024-06-09 19:21:16',1),(200,'CH957','Carlos Hernandez','carlos.hernandez@example.com','$2a$10$8yFcmY3mk1S011HEzRKLMOH7beIQAEZuopV/I7alebZMnJtmLrnE6',2,'NA','2024-06-09 19:21:17',1),(201,'AM408','Ana Martinez','ana.martinez@example.com','$2a$10$Zq6yNqgDHWsU1g5UlFgaKOSa5/CJjGKbbFyIMOdPxTOkZwS27bypy',2,'NA','2024-06-09 19:21:17',0),(202,'JR524','Jose Rodriguez','jose.rodriguez@example.com','$2a$10$62AyA.g/DeG55LkUf7A1Wuo46lcac9k8klQyUxj01Tcl23F90ISsW',2,'NA','2024-06-09 19:21:17',1);
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

-- Dump completed on 2024-06-09 21:54:31

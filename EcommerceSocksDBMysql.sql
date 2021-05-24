CREATE DATABASE  IF NOT EXISTS `dbproyecto` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dbproyecto`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: dbproyecto
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `Addresses_id` int NOT NULL,
  `Addresses_user` int NOT NULL,
  `Addresses_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Addresses_street` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Addresses_cp` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Addresses_country` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Addresses_province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Addresses_city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Addresses_id`),
  KEY `FK__Addresses_user` (`Addresses_user`),
  CONSTRAINT `FK__Addresses_user` FOREIGN KEY (`Addresses_user`) REFERENCES `users` (`Users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (157995,519874581,'Casa','Bulevar Nueva, 85, 08456, Viver I Serrateix','08456','Spain','Barcelona','Barcelona'),(685744,519874581,'Trabajo','Placeta Catalunya, 32, 04459, Illar','08456','Spain','Barcelona','Barcelona');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `Category_id` int NOT NULL,
  `Category_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Category_description` text,
  PRIMARY KEY (`Category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'MEN','The touch of color and fun your look needed. Trendy and premium quality socks for men.'),(2,'WOMEN','Discover our women\'s socks collection full of color and cute designs. You won\'t be able to choose just one!'),(3,'KIDS','Cool kids deserve cool socks! Discover our large collection of crazy socks for kids of all ages.'),(4,'PACKS','Create your own pack from over 100 designs\r\nor buy one of our pre-made packs.');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections` (
  `Collections_id` int NOT NULL,
  `Collections_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Collections_discount` int DEFAULT NULL,
  PRIMARY KEY (`Collections_id`),
  KEY `FK__Collectio__Colle__4E88ABD4` (`Collections_discount`),
  CONSTRAINT `FK__Collectio__Colle__4E88ABD4` FOREIGN KEY (`Collections_discount`) REFERENCES `discount` (`Discount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` VALUES (1,'BACK TO THE FUTURE',NULL);
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount` (
  `Discount_id` int NOT NULL,
  `Discount_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Discount_value` double DEFAULT NULL,
  `Discount_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Discount_date` datetime DEFAULT NULL,
  PRIMARY KEY (`Discount_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
INSERT INTO `discount` VALUES (1,'SAVE UP TO 30%',30,'SAVE-30','2020-12-31 23:00:00'),(2,'SAVE UP TO 20%',20,'SAVE-20','2020-12-31 23:00:00'),(3,'SAVE UP TO 10%',10,'SAVE-10','2020-12-31 23:00:00'),(4,'BUY ONE GET ONE 50% OFF',50,'SAVE-2-50','2020-12-31 23:00:00'),(5,'OUTLET -25%',25,'OUTLET-25','2020-12-31 23:00:00');
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `Favorite_id` int NOT NULL,
  `Favorite_product` int DEFAULT NULL,
  `Favorite_user` int DEFAULT NULL,
  PRIMARY KEY (`Favorite_id`),
  KEY `FK__Favorite__Favori__00200768` (`Favorite_user`),
  KEY `FK__Favorite__Favori__33D4B598` (`Favorite_product`),
  CONSTRAINT `FK__Favorite__Favori__00200768` FOREIGN KEY (`Favorite_user`) REFERENCES `users` (`Users_id`),
  CONSTRAINT `FK__Favorite__Favori__33D4B598` FOREIGN KEY (`Favorite_product`) REFERENCES `product` (`Product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (1,2,519874581),(2,21,519874581),(3,21,519874581),(4,2,519874581);
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `Order_Details_id` int NOT NULL AUTO_INCREMENT,
  `Order_id` int DEFAULT NULL,
  `Product_id` int DEFAULT NULL,
  `Size_id` int DEFAULT NULL,
  `Amount` int DEFAULT NULL,
  PRIMARY KEY (`Order_Details_id`),
  KEY `FK__Order_det__Order__02FC7413` (`Order_id`),
  KEY `FK__Order_det__Produ__3B75D760` (`Product_id`),
  CONSTRAINT `FK__Order_det__Order__02FC7413` FOREIGN KEY (`Order_id`) REFERENCES `orders` (`Orders_id`),
  CONSTRAINT `FK__Order_det__Produ__3B75D760` FOREIGN KEY (`Product_id`) REFERENCES `product` (`Product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (9,9701,4,4,1),(10,7436,3,3,1),(11,7612,3,4,1),(12,7612,18,3,1),(13,8524,18,3,1),(18,7436,14,1,2),(19,7436,28,1,2),(21,7436,12,1,2),(27,8560,55,6,1);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `Orders_id` int NOT NULL,
  `Orders_user` int DEFAULT NULL,
  `Orders_date` datetime DEFAULT NULL,
  PRIMARY KEY (`Orders_id`),
  KEY `FK__Orders__Orders_u__09A971A2` (`Orders_user`),
  CONSTRAINT `FK__Orders__Orders_u__09A971A2` FOREIGN KEY (`Orders_user`) REFERENCES `users` (`Users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (7436,519874581,'2021-02-15 19:45:56'),(7612,519874581,'2021-02-17 10:44:56'),(8524,519874581,'2021-02-17 12:13:05'),(8560,519874581,'2021-04-13 06:54:58'),(9701,519874581,'2021-02-15 18:40:51');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `orders_view`
--

DROP TABLE IF EXISTS `orders_view`;
/*!50001 DROP VIEW IF EXISTS `orders_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `orders_view` AS SELECT 
 1 AS `Order_Details_id`,
 1 AS `Order_id`,
 1 AS `Product_id`,
 1 AS `Size_id`,
 1 AS `Amount`,
 1 AS `orders_user`,
 1 AS `orders_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `Product_id` int NOT NULL,
  `Product_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Product_description` text,
  `Product_price` double DEFAULT NULL,
  `Product_style` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Product_print` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Product_color` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Product_category` int DEFAULT NULL,
  `Product_subcategory` int DEFAULT NULL,
  `Product_discount` int DEFAULT NULL,
  `Product_collection` int DEFAULT NULL,
  PRIMARY KEY (`Product_id`),
  KEY `FK__Product__Product__4F7CD00D` (`Product_collection`),
  KEY `FK__Product__Product__286302EC` (`Product_category`),
  KEY `FK__Product__Product__29572725` (`Product_subcategory`),
  KEY `FK__Product__Product__4AB81AF0` (`Product_discount`),
  CONSTRAINT `FK__Product__Product__286302EC` FOREIGN KEY (`Product_category`) REFERENCES `category` (`Category_id`),
  CONSTRAINT `FK__Product__Product__29572725` FOREIGN KEY (`Product_subcategory`) REFERENCES `subcategory` (`Subcategory_id`),
  CONSTRAINT `FK__Product__Product__4AB81AF0` FOREIGN KEY (`Product_discount`) REFERENCES `discount` (`Discount_id`),
  CONSTRAINT `FK__Product__Product__4F7CD00D` FOREIGN KEY (`Product_collection`) REFERENCES `collections` (`Collections_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'FOX HEAD','78% Combed Cotton, 20% Polyamide, 2% Elastane. \r\nNot many designs will elevate your outfit like these fox socks. The orange fox head design, \r\ncomplete with red hair and perky ears, really contrast against the dramatic black background. \r\nAdd the finishing touch to your outfit with these original socks. Don’t be without them!',9,'Casual','Animals','Black',1,2,NULL,NULL),(2,'BLACK SHEEP','70% Combed Cotton, 28% Polyamide, 2% Elastane.\r\nDon\'t let anyone tell you you can\'t be the black sheep of the herd, ok? Don\'t be afraid to \r\nstand out and go out there rocking your wool and your funny Black Sheep socks.',7.2,'Casual','Animals','Turquoise',1,2,2,NULL),(3,'EGGS','78% Combed Cotton, 20% Polyamide, 2% Elastane.\r\nSomething smells good! These bacon and egg socks have our mouths watering. \r\nEven better, there are sausages too! What more do you need to get the day \r\noff to a great start? The diet can wait since these patterned socks are more \r\nthan worth it. The best thing of all is that you get to choose between pink or blue. \r\nUp to you!',7.2,'Casual','Food','Pink',2,2,2,NULL),(4,'OCTOPUS','78% Combed Cotton, 20% Polyamide, 2% Elastane',9,'Casual','Animals','Turquoise',2,2,NULL,NULL),(5,'RIBBED','Classic mid-calf socks come in some original colors including \r\nstriking yellow, red and purple to more neutral gray and black. This plain sock collection goes with \r\neverything and can be paired with both classic or more daring looks.',6.3,'Basics','Plain','Red',1,2,1,NULL),(6,'RIBBED','Classic mid-calf socks come in some original colors including \r\nstriking yellow, red and purple to more neutral gray and black. This plain sock collection goes with \r\neverything and can be paired with both classic or more daring looks.',6.3,'Basics','Plain','Yellow',1,2,1,NULL),(7,'RIBBED','Classic mid-calf socks come in some original colors including \r\nstriking yellow, red and purple to more neutral gray and black. This plain sock collection goes with \r\neverything and can be paired with both classic or more daring looks.',6.3,'Basics','Plain','Purple',1,2,1,NULL),(8,'RIBBED','Classic mid-calf socks come in some original colors including \r\nstriking yellow, red and purple to more neutral gray and black. This plain sock collection goes with \r\neverything and can be paired with both classic or more daring looks.',6.3,'Basics','Plain','Grey',1,2,1,NULL),(9,'RIBBED','Classic mid-calf socks come in some original colors including \r\nstriking yellow, red and purple to more neutral gray and black. This plain sock collection goes with \r\neverything and can be paired with both classic or more daring looks.',6.3,'Basics','Plain','Black',1,2,1,NULL),(10,'KIDS JURASSIC BABY','70% Combed Cotton, 28% Polyamide, 2% Elastane\r\nWhat better companion could there be to join kids on their adventures than Baby Dino? He\'s freshly \r\nhatched but already wants to play. These baby dinosaur socks are not only the perfect pet, \r\nbut combine effortlessly with their favorite shoes.',7,'Casual','Adventures','Blue',3,2,NULL,NULL),(11,'KIDS KOALAS','70% Combed Cotton, 28% Polyamide, 2% Elastane\r\nUp until now, you had to pay a visit to Australia to see a koala. Now you can enjoy having \r\nthem close by thanks to these koala socks. Nobody can resist the charms of these adorable \r\nanimals and the same goes for these original socks!',7,'Casual','Animals','Turquoise',3,2,NULL,NULL),(12,'KIDS FAST FOOD','70% Combed Cotton, 28% Polyamide, 2% Elastane',7,'Casual','Food','Dark Red',3,2,NULL,NULL),(13,'KIDS BREAD','70% Combed Cotton, 28% Polyamide, 2% Elastane.\r\nThere is nothing better than the feeling you get when you \r\nwalk into a bakery and it smells like fresh bread. Truth? Kids love it. In addition, the black color \r\naccentuates the pattern of these cool socks and will make your day more fun. Let the feast begin with \r\nthese bread and croissant socks!',7,'Casual','Food','Black',3,2,NULL,NULL),(14,'KIDS CHILLIES','70% Combed Cotton, 28% Polyamide, 2% Elastane.',7,'Casual','Food','Blue',3,2,NULL,NULL),(15,'Reef','78% Combed Cotton, 20% Polyamide, 2% Elastane.Did you know that our planet\'s coral \r\n			reefs started to form over 50 million years ago? Their spectacular colors come from \r\n			the millions of algae they are home to, and now they can adorn your feet. These funky \r\n			socks will make you feel like you\'re gliding through tropical waters. Do you know what \r\n			else? These socks for men and women are the perfect gift for any nature lover.',12,'Casual','Nature','Blue',2,2,NULL,NULL),(16,'Hedgehog','78% Combed Cotton, 20% Polyamide, 2% Elastane.aa',12,'Casual','Animals','Turquoise',2,2,NULL,NULL),(17,'Ribbed','78% Combed Cotton, 20% Polyamide, 2% Elastane.Classic mid-calf socks come in 14 original \r\n			colors including striking yellow, red and purple to more neutral gray and black. This plain \r\n			sock collection goes with everything and can be paired with both classic or more daring looks.',12,'Basics','Plain','Pink',2,2,NULL,NULL),(18,'Toucan Sock','78% Combed Cotton, 20% Polyamide, 2% Elastane.YellowYellow',12,'Casual','Animals','Yellow',2,2,NULL,NULL),(19,'Camo','78% Combed Cotton, 20% Polyamide, 2% Elastane.Camouflage has made a triumphant \r\n			return this season as a truly iconic print. If you’re on the hunt for original socks, \r\n			these are the perfect pair. Featuring a camo pattern available in green and blue hues, \r\n			their versatile nature sets them apart. Perfect for enhancing work wear, as well as outfits \r\n			that are more casual.',12,'Casual','Travel','Dark Green',1,2,NULL,NULL),(20,'Camo','78% Combed Cotton, 20% Polyamide, 2% Elastane.Camouflage has made a triumphant return \r\n			this season as a truly iconic print. If you’re on the hunt for original socks, these are \r\n			the perfect pair. Featuring a camo pattern available in green and blue hues, their versatile \r\n			nature sets them apart. Perfect for enhancing work wear, as well as outfits that are more \r\n			casual.',12,'Casual','Travel','Blue',2,2,NULL,NULL),(21,'Turtles','78% Combed Cotton, 20% Polyamide, 2% Elastane.The Safari socks are made with premium \r\n			quality combed cotton to provide maximum comfort to your feet. Designed in collaboration \r\n			with our friends of B The Travel Brand, these socks will make you stand out with any look.\r\n			Available for men and women in various sizes.',12,'Casual','Animals','Acqua',2,2,NULL,NULL),(22,'Ghosts','78% Combed Cotton, 20% Polyamide, 2% Elastane.',12,'Casual','Adventures','Black',1,2,NULL,NULL),(23,'KH Galaxy','78% Combed Cotton, 20% Polyamide, 2% Elastane.aa',14,'Casual','Adventures','Grey',2,1,NULL,NULL),(24,'KH Fast Food','78% Combed Cotton, 20% Polyamide, 2% Elastane.aa',14,'Casual','Food','Dark Blue',1,1,NULL,NULL),(25,'KH Ribbed','78% Combed Cotton, 20% Polyamide, 2% Elastane.Classic knee-high socks are casual \r\n			and minimalist in style. Perfect for any occasion, add an original touch to your \r\n			signature look. With 14 fun colors to choose from, you\'re sure to find something \r\n			to suit all styles. Plain socks in every color!',14,'Basics','Plain','Dark Blue',1,1,NULL,NULL),(26,'KH Bees','78% Combed Cotton, 20% Polyamide, 2% Elastane.We truly hope you are not allergic to bee stings, \r\n			because these little evil friends of us are gonna be all over your feet and calves! Go all in and \r\n			straight to the knee high version of the Bees design, one of the best sellers in The Farm collection.',14,'Casual','Animals','Grey',2,1,NULL,NULL),(27,'Athletic Wolf Ankle','78% Combed Cotton, 20% Polyamide, 2% Elastane.Are you looking for a training gear that is as \r\n			fierce as your workouts? Don’t search no more! These sport ankle socks have been specially \r\n			designed to help you improve your performance while working out due to its strategic cushioning \r\n			in the toe, heel and footbed. Not only will this help you stay more comfortable while training, \r\n			but will also prevent the appearance of blisters and chuffing caused by sport shoes or long workouts. \r\n			Tennis, golf, football, gym… these athletic ankle socks are perfect for any practice, so score a sock \r\n			point with these Athletic Wolf Ankle!',12,'Athletic','Animals','White',1,3,NULL,NULL),(28,'Penguins Ankle','78% Combed Cotton, 20% Polyamide, 2% Elastane.aa',10,'Casual','Animals','Red',2,3,NULL,NULL),(29,'Winter Deer','36% wool, 27% viscose, 25% nylon, 9% cashmere, 3% spandex \r\nDeer are one of the animals that most remind us of winter and with these fun socks, you can take them with you throughout the season. \r\nThe original drawing of the deer is complemented by geometric figures that give it a very special touch. You dare?',15,'Casual','Animals','Light Blue',1,2,NULL,NULL),(30,'Athletic Wolf','78% Combed Cotton, 20% Polyamide, 2% Elastane.aa',14,'Athletic','Animals','White',2,2,NULL,NULL),(31,'Salad','78% Combed Cotton, 20% Polyamide, 2% Elastane.',12,'Casual','Food','Dark Pink',2,2,NULL,NULL),(32,'Flamingo','78% Combed Cotton, 20% Polyamide, 2% Elastane.TurquoiseTurquoise',12,'Casual','Animals','Turquoise',2,2,NULL,NULL),(33,'HVN Polka Dot','78% Combed Cotton, 20% Polyamide, 2% Elastane.Old-fashioned style? Cuteness overload?  \r\n			There\'s way too much opinions about polka dots, but still they are one of Harley\'s \r\n			favourite prints! Some things just never get old so add this classic HVN Polka Dot \r\n			style to your wardrobe!',12,'Casual','Nature','Red',1,2,NULL,NULL),(34,'Lizard Ankle','78% Combed Cotton, 20% Polyamide, 2% Elastane.aa',10,'Casual','Nature','Blue',2,3,NULL,NULL),(35,'Hedgehog No Show','78% Combed Cotton, 20% Polyamide, 2% Elastane.You\'ve probably tried plenty \r\n			of animal themed socks over the years, but these no-show ones are in a league\r\n			of their own thanks to these unique hedgehogs! If you\'ve always fancied one \r\n			as a pet you\'re in luck! Now you can take them home and get to know them. \r\n			They can\'t wait to meet you!',7,'Casual','Animals','Turquoise',2,4,NULL,NULL),(36,'Mahou Beers No Show','78% Combed Cotton, 20% Polyamide, 2% Elastane.Our Mahou Beer design now available \r\n			as no-show socks. Great summer looks, wearing sneakers or shoes...Who said no-show \r\n			socks were boring?',7,'Casual','Food','Green',1,4,NULL,NULL),(37,'Jurassic Dinos No Show','78% Combed Cotton, 20% Polyamide, 2% Elastane.Attention all those dinosaur fans! \r\n			Far from extinct, these no-show socks are from our official Jurassic World collection, \r\n			ready to be worn daily. What better accessory for your closet is there than a T-Rex? \r\n			Take a walk on the wild side with these dinosaur socks!',7,'Casual','Animals','Blue',1,4,NULL,NULL),(38,'Acqualung','78% Combed Cotton, 20% Polyamide, 2% Elastane.',9,'Casual','Adventures','Blue',1,2,NULL,NULL),(39,'Kids Jurassic T-Rex','78% Combed Cotton, 20% Polyamide, 2% Elastane.The ground is shaking... \r\n			T-Rex has arrived! He roams freely, clad in these original socks. The socks\' vivid \r\n			colors and stunning design will add a wild side to your kids\' outfits, \r\n			while their imagination will go crazy. Perfect fun for the whole family!',7,'Casual','Animals','Black',3,2,NULL,NULL),(40,'Kids Parrots','36% wool, 27% viscose, 25% nylon, 9% cashmere, 3% spandex \r\nEvery bird of great plumage was only a baby bird first, just like you are. So good news for you…the best is yet to come! \r\nLet your imagination fly with our Parrots socks and create the coolest outfits for school. ',7,'Casual','Food','Yellow',3,2,NULL,NULL),(41,'Kids Eggs','78% Combed Cotton, 20% Polyamide, 2% Elastane.\r\n			¡Que bien huele! Se nos hace la boca agua… Con estos calcetines para niños de huevos y bacon, \r\n			tendrán toda la energía que necesitan para afrontar el día. Y además, ¡tienen salchichas! \r\n			Dale un toque divertido a su día a día con estos calcetines estampados. ¡Les encantarán!',7,'Casual','Food','Pink',3,2,NULL,NULL),(42,'Kids Rock','78% Combed Cotton, 20% Polyamide, 2% Elastane.Tonight is the big night, all stadium tickets \r\n			have been sold and everyone’s already on their seats waiting for your big performance. \r\n			Mics, drums and guitars are tuned…so let the show begin! Dreamers gonna dream, so what \r\n			if the stadium is just your home’s living room; the crowd, all your toys, \r\n			and instruments are just part of your imagination? Maybe today’s shows are just the rehearsals \r\n			for the big star that you will tomorrow become. Let your inner star out with these colorful \r\n			kids socks and rock out!',7,'Casual','Adventures','Red',3,2,NULL,NULL),(43,'Kids Sailboat Racing','78% Combed Cotton, 20% Polyamide, 2% Elastane.Las carreras de barcos es uno de los deportes más divertidos. \r\n			El viento, el océano, los colores de las velas… Con los calcetines originales Sailboat Racing, tu hijo se \r\n			sentirá como un auténtico marinero, pero ¡sin salir de casa! Quién sabe, quizá sea el ganador de la carrera \r\n			con estos divertidos calcetines para niños de barcos.',7,'Casual','Adventures','Blue',3,2,NULL,NULL),(44,'Kids Pacha Cherries','78% Combed Cotton, 20% Polyamide, 2% Elastane.\r\n			Who said Pacha is not a kids\' business? The well-known Pacha Cherries are the perfect touch of \r\n			color and fun for the looks of the coolest kids! Thanks to Pacha, fruit will never be boring \r\n			again and every kid will want to bite the Cherries on these funky socks!',7,'Casual','Food','Black',3,2,NULL,NULL),(45,'Dogs','78% Combed Cotton, 20% Polyamide, 2% Elastane.aa',12,'Casual','Nature','Green',1,2,NULL,NULL),(46,'Frida','78% Combed Cotton, 20% Polyamide, 2% Elastane.',12,'Casual','Travel','Blue',2,2,NULL,NULL),(47,'Wine','78% Combed Cotton, 20% Polyamide, 2% Elastane.',12,'Casual','Food','Dark Red',2,2,NULL,NULL),(48,'Byron Bay','78% Combed Cotton, 20% Polyamide, 2% Elastane.Some people say Byron Bay is \r\n			paradise on earth. This little coastal town is Australia\'s easternmost point \r\n			and is more fashionable than ever. Live the Australian dream with these original \r\n			socks, and enjoy the waves, the weather, the environment and Byron Bay\'s good vibes. \r\n			Be a real surfer and go with the flow with these colorful socks for men and women.',12,'Casual','Holliday','Turquoise',2,2,NULL,NULL),(49,'GALAXY PACK','For lovers of outer space we have this pack that will add a \"galactic\" touch to your look',39.95,'Casual','Adventures','Various',4,2,NULL,NULL),(50,'Safari Pack','We´re going on safari! Pack all your things and embark on this adventure \r\nwith our socks inspired by a dangerous safari in the African savannah.',39.95,'Casual','Adventures','Various',4,2,NULL,NULL),(51,'Chef Pack','Show off your culinary skills with these fun food socks. \r\nA cheese board, a Rioja or a good breakfast of eggs and bacon, why choose!	',39.95,'Casual','Food','Various',4,2,NULL,NULL),(52,'Clean Ocean Pack','Inspired by the ocean and its creatures, show your friends that \r\nyou are an animal lover with these fun socks!',39.95,'Casual','Animals','Various',4,2,NULL,NULL),(53,'Pacha Pack','Looking for the perfect gift that represents the spirit of summer? \r\nPacha Ibiza comes to your aid! This 4 Pacha Pack, which includes two \r\nversions of the Pacha Cherries model, accompanied by the Flower Power \r\nand Beach model, brings together the essence of the island and takes \r\nus back to the magical summer nights at the most legendary Pacha parties. \r\nGive this pack of funny socks to whoever you love the most, \r\nor take it with you as a souvenir! ',39.95,'Casual','Holliday','Various',4,2,NULL,NULL),(54,'Babies Piglet Pack','If you were looking for the perfect pair of baby socks, here you’ve found the perfect pack instead!',29.95,'Casual','Holliday','Various',4,2,NULL,NULL),(55,'Babies Pup Pack','Expecting parents often get so overwhelmed with all they need to have ready \r\nbefore their baby comes, that can easily forget about the basic stuff…like cool baby socks!',29.95,'Casual','Holliday','Various',4,2,NULL,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `product_complete`
--

DROP TABLE IF EXISTS `product_complete`;
/*!50001 DROP VIEW IF EXISTS `product_complete`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `product_complete` AS SELECT 
 1 AS `Product_id`,
 1 AS `Product_name`,
 1 AS `Product_description`,
 1 AS `Product_price`,
 1 AS `Product_style`,
 1 AS `Product_print`,
 1 AS `Product_color`,
 1 AS `Product_category`,
 1 AS `Product_subcategory`,
 1 AS `Product_discount`,
 1 AS `Product_collection`,
 1 AS `Category_name`,
 1 AS `category_description`,
 1 AS `subcategory_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `product_size`
--

DROP TABLE IF EXISTS `product_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_size` (
  `Product_size_id` int NOT NULL,
  `Product_id` int DEFAULT NULL,
  `Size_id` int DEFAULT NULL,
  PRIMARY KEY (`Product_size_id`),
  KEY `FK__Product_s__Produ__282DF8C2` (`Product_id`),
  KEY `FK__Product_s__Size___29221CFB` (`Size_id`),
  CONSTRAINT `FK__Product_s__Produ__282DF8C2` FOREIGN KEY (`Product_id`) REFERENCES `product` (`Product_id`),
  CONSTRAINT `FK__Product_s__Size___29221CFB` FOREIGN KEY (`Size_id`) REFERENCES `size` (`Size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_size`
--

LOCK TABLES `product_size` WRITE;
/*!40000 ALTER TABLE `product_size` DISABLE KEYS */;
INSERT INTO `product_size` VALUES (1,1,1),(2,1,2),(3,2,1),(4,2,2),(5,3,3),(6,3,4),(7,4,3),(8,4,4),(9,5,1),(10,5,2),(11,6,1),(12,6,2),(13,7,1),(14,7,2),(15,8,1),(16,8,2),(17,9,1),(18,9,2),(19,10,5),(20,10,6),(21,10,7),(22,11,5),(23,11,6),(24,11,7),(25,12,5),(26,12,6),(27,12,7),(28,13,5),(29,13,6),(30,13,7),(31,14,5),(32,14,6),(33,14,7),(34,11,2),(35,11,3),(36,12,2),(37,12,3),(38,13,2),(39,13,3),(40,14,2),(41,14,3),(42,15,2),(43,15,3),(44,16,2),(45,16,3),(46,17,2),(47,17,3),(48,18,3),(49,19,2),(50,19,3),(51,20,2),(52,20,3),(53,21,2),(54,21,3),(55,22,2),(56,22,3),(57,23,2),(58,23,3),(59,24,2),(60,24,3),(61,25,2),(62,25,3),(63,26,2),(64,26,3),(65,27,2),(66,27,3),(67,28,2),(68,28,3),(69,29,2),(70,29,3),(71,30,2),(72,30,3),(73,31,2),(74,31,3),(75,32,2),(76,32,3),(77,33,2),(78,33,3),(79,34,2),(80,34,3),(81,35,2),(82,35,3),(83,36,2),(84,36,3),(85,37,2),(86,37,3),(87,38,2),(88,38,3),(89,39,5),(90,39,6),(91,39,7),(92,40,5),(93,40,6),(94,40,7),(95,41,5),(96,41,6),(97,41,7),(98,42,5),(99,42,6),(100,42,7),(101,43,5),(102,43,6),(103,43,7),(104,44,5),(105,44,6),(106,44,7),(107,45,2),(108,45,3),(109,46,2),(110,46,3),(111,47,2),(112,47,3),(113,48,2),(114,48,3),(115,49,1),(116,49,2),(117,49,3),(118,49,4),(119,50,1),(120,50,2),(121,50,3),(122,50,4),(123,51,1),(124,51,2),(125,51,3),(126,51,4),(127,52,1),(128,52,2),(129,52,3),(130,52,4),(131,53,1),(132,53,2),(133,53,3),(134,53,4),(135,53,5),(136,53,6),(137,53,7),(138,54,5),(139,54,6),(140,54,7),(141,55,5),(142,55,6),(143,55,7);
/*!40000 ALTER TABLE `product_size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `products_sizes`
--

DROP TABLE IF EXISTS `products_sizes`;
/*!50001 DROP VIEW IF EXISTS `products_sizes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `products_sizes` AS SELECT 
 1 AS `Product_size_id`,
 1 AS `product_id`,
 1 AS `size_id`,
 1 AS `Size_US`,
 1 AS `Size_EUR`,
 1 AS `Size_UK`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `size`
--

DROP TABLE IF EXISTS `size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `size` (
  `Size_id` int NOT NULL,
  `Size_US` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Size_EUR` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Size_UK` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Size_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `size`
--

LOCK TABLES `size` WRITE;
/*!40000 ALTER TABLE `size` DISABLE KEYS */;
INSERT INTO `size` VALUES (1,'4.5-7.5','36-40','4-7'),(2,'7.5-11.5','41-46','8-12'),(3,'3.5-6.5','36-40','6-9'),(4,'10-12.5','41-46','7-11'),(5,'4.5-8','21-25','5.5-9'),(6,'8.5-12','26-30','9.5-13'),(7,'12.5-2.5','31-35','13.5-3.5');
/*!40000 ALTER TABLE `size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subcategory`
--

DROP TABLE IF EXISTS `subcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subcategory` (
  `Subcategory_id` int NOT NULL,
  `Subcategory_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Subcategory_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subcategory`
--

LOCK TABLES `subcategory` WRITE;
/*!40000 ALTER TABLE `subcategory` DISABLE KEYS */;
INSERT INTO `subcategory` VALUES (1,'KNEE-HIGH'),(2,'MID-CALF'),(3,'ANKLE'),(4,'NO-SHOW');
/*!40000 ALTER TABLE `subcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Users_id` int NOT NULL,
  `Users_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Users_lastName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Users_email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Users_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Users_nationality` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Users_phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Users_birthDate` date DEFAULT NULL,
  `Users_salt` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `Users_gender` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`Users_id`),
  UNIQUE KEY `IX_Users_1` (`Users_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (519874581,'admin','admin','admin@gmail.com','1234','españa','659208749','2000-05-06',NULL,'F');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `orders_view`
--

/*!50001 DROP VIEW IF EXISTS `orders_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `orders_view` AS select `od`.`Order_Details_id` AS `Order_Details_id`,`od`.`Order_id` AS `Order_id`,`od`.`Product_id` AS `Product_id`,`od`.`Size_id` AS `Size_id`,`od`.`Amount` AS `Amount`,`o`.`Orders_user` AS `orders_user`,`o`.`Orders_date` AS `orders_date` from (`order_details` `od` join `orders` `o` on((`od`.`Order_id` = `o`.`Orders_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `product_complete`
--

/*!50001 DROP VIEW IF EXISTS `product_complete`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `product_complete` AS select `p`.`Product_id` AS `Product_id`,`p`.`Product_name` AS `Product_name`,`p`.`Product_description` AS `Product_description`,`p`.`Product_price` AS `Product_price`,`p`.`Product_style` AS `Product_style`,`p`.`Product_print` AS `Product_print`,`p`.`Product_color` AS `Product_color`,`p`.`Product_category` AS `Product_category`,`p`.`Product_subcategory` AS `Product_subcategory`,`p`.`Product_discount` AS `Product_discount`,`p`.`Product_collection` AS `Product_collection`,`c`.`Category_name` AS `Category_name`,`c`.`Category_description` AS `category_description`,`s`.`Subcategory_name` AS `subcategory_name` from ((`product` `p` join `category` `c` on((`p`.`Product_category` = `c`.`Category_id`))) join `subcategory` `s` on((`p`.`Product_subcategory` = `s`.`Subcategory_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `products_sizes`
--

/*!50001 DROP VIEW IF EXISTS `products_sizes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `products_sizes` AS select `product_size`.`Product_size_id` AS `Product_size_id`,`product_size`.`Product_id` AS `product_id`,`product_size`.`Size_id` AS `size_id`,`size`.`Size_US` AS `Size_US`,`size`.`Size_EUR` AS `Size_EUR`,`size`.`Size_UK` AS `Size_UK` from (`product_size` join `size` on((`product_size`.`Size_id` = `size`.`Size_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-22  8:38:54

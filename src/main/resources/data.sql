-- data.sql (generated for 'four_weekdays')

CREATE DATABASE IF NOT EXISTS `four_weekdays` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `four_weekdays`;

SET FOREIGN_KEY_CHECKS=0;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcement` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `active` bit(1) NOT NULL,
  `content` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `pinned` bit(1) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `asn`
--

DROP TABLE IF EXISTS `asn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `asn` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `asn_code` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `expected_date` datetime(6) DEFAULT NULL,
  `status` enum('ACCEPTED','REJECTED') DEFAULT NULL,
  `purchase_order_id` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKie199rinybdox1bbnu6mcqfy4` (`asn_code`),
  KEY `FKsvf6syj42hj8akht9309ewfup` (`purchase_order_id`),
  KEY `FKaew56wf07r7vmulaeftrndm7i` (`vendor_id`),
  CONSTRAINT `FKaew56wf07r7vmulaeftrndm7i` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`),
  CONSTRAINT `FKsvf6syj42hj8akht9309ewfup` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `active` bit(1) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2y94svpmqttx80mshyny85wqr` (`parent_id`),
  CONSTRAINT `FK2y94svpmqttx80mshyny85wqr` FOREIGN KEY (`parent_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `franchise_store`
--

DROP TABLE IF EXISTS `franchise_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `franchise_store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `franchise_code` varchar(50) NOT NULL,
  `name` varchar(200) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE','SUSPENDED') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKaawnideifesyiurppmg91ukcu` (`franchise_code`),
  UNIQUE KEY `UKg3qlemaumcvl2pdcweb3eiuik` (`api_key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKmm4cmvteo84wq24upfvucdy08` (`product_id`),
  CONSTRAINT `FKgpextbyee3uk9u6o2381m7ft1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inbound`
--

DROP TABLE IF EXISTS `inbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inbound` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `inbound_code` varchar(255) NOT NULL,
  `manager_name` varchar(255) DEFAULT NULL,
  `scheduled_date` datetime(6) DEFAULT NULL,
  `status` enum('ARRIVED','CANCELLED','COMPLETED','CREATED','INSPECTING','PUTAWAY','SCHEDULED') DEFAULT NULL,
  `worker_name` varchar(255) DEFAULT NULL,
  `purchase_order_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKk006jhk5utmrtsv60kdmgmbhr` (`purchase_order_id`),
  CONSTRAINT `FKsv2i1tb5oi6des029r7980gxp` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inbound_product`
--

DROP TABLE IF EXISTS `inbound_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inbound_product` (
  `inbound_product_item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `location_code` varchar(255) DEFAULT NULL,
  `lot_number` varchar(50) DEFAULT NULL,
  `received_quantity` int(11) NOT NULL,
  `inbound_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `purchase_order_product_item_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`inbound_product_item_id`),
  KEY `FKi4wlj1ac383krg7lifevi57mp` (`inbound_id`),
  KEY `FK9xyuidoew7x97o0h9oufswjql` (`product_id`),
  KEY `FK3inkbc0bcokjeijjlufyg8opm` (`purchase_order_product_item_id`),
  CONSTRAINT `FK3inkbc0bcokjeijjlufyg8opm` FOREIGN KEY (`purchase_order_product_item_id`) REFERENCES `purchase_order_product` (`id`),
  CONSTRAINT `FK9xyuidoew7x97o0h9oufswjql` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FKi4wlj1ac383krg7lifevi57mp` FOREIGN KEY (`inbound_id`) REFERENCES `inbound` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inspection_task`
--

DROP TABLE IF EXISTS `inspection_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inspection_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `inbound_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKl1o73xmyvfldki5dbc0j6miny` (`task_id`),
  CONSTRAINT `FK8srqw86dgls14ph8a6ap36ok2` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `lot_number` varchar(50) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `inbound_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK92222pj555ybijoypeb9lfuri` (`inbound_id`),
  KEY `FKq4qxohkbpt2t6anovkpmjkxh7` (`location_id`),
  KEY `FKp7gj4l80fx8v0uap3b2crjwp5` (`product_id`),
  CONSTRAINT `FK92222pj555ybijoypeb9lfuri` FOREIGN KEY (`inbound_id`) REFERENCES `inbound` (`id`),
  CONSTRAINT `FKp7gj4l80fx8v0uap3b2crjwp5` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FKq4qxohkbpt2t6anovkpmjkxh7` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `capacity` int(11) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `location_code` varchar(20) NOT NULL,
  `section` varchar(10) NOT NULL,
  `status` enum('AVAILABLE','CLOSED') NOT NULL,
  `used_capacity` int(11) NOT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  `zone` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKmar27svme9bekuv7b87jin6sv` (`location_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `join_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `role` enum('ADMIN','MANAGER','WORKER') DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE','LOCK') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `read_at` datetime(6) DEFAULT NULL,
  `status` enum('READ','UNREAD') DEFAULT NULL,
  `inbound_id` bigint(20) DEFAULT NULL,
  `inventory_id` bigint(20) DEFAULT NULL,
  `member_id` bigint(20) NOT NULL,
  `outbound_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKk8oik2u6phgugp3gyx9f8expa` (`inbound_id`),
  KEY `FKnlc54044rf1iof50w3xiioqrn` (`inventory_id`),
  KEY `FK1xep8o2ge7if6diclyyx53v4q` (`member_id`),
  KEY `FKgxfj3rvppknfyh50ecg03skpr` (`outbound_id`),
  CONSTRAINT `FK1xep8o2ge7if6diclyyx53v4q` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `FKgxfj3rvppknfyh50ecg03skpr` FOREIGN KEY (`outbound_id`) REFERENCES `outbound` (`outbound_id`),
  CONSTRAINT `FKk8oik2u6phgugp3gyx9f8expa` FOREIGN KEY (`inbound_id`) REFERENCES `inbound` (`id`),
  CONSTRAINT `FKnlc54044rf1iof50w3xiioqrn` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_product_item`
--

DROP TABLE IF EXISTS `order_product_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_product_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `ordered_quantity` int(11) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKllifwnfboi40h11nvhq1fjumq` (`order_id`),
  KEY `FK8n0wlqutvt5bhk9v2pd8ay04s` (`product_id`),
  CONSTRAINT `FK8n0wlqutvt5bhk9v2pd8ay04s` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FKllifwnfboi40h11nvhq1fjumq` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `due_date` datetime(6) NOT NULL,
  `order_code` varchar(255) DEFAULT NULL,
  `order_date` datetime(6) NOT NULL,
  `rejected_at` datetime(6) DEFAULT NULL,
  `rejected_reason` varchar(255) DEFAULT NULL,
  `status` enum('APPROVED','CANCELLED','DELIVERED','REQUESTED','SHIPPED') DEFAULT NULL,
  `franchise_store_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `FKovbnmwvyloecrxr9bxig1fc9f` (`franchise_store_id`),
  CONSTRAINT `FKovbnmwvyloecrxr9bxig1fc9f` FOREIGN KEY (`franchise_store_id`) REFERENCES `franchise_store` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `outbound`
--

DROP TABLE IF EXISTS `outbound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `outbound` (
  `outbound_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `outbound_code` varchar(255) NOT NULL,
  `outbound_type` enum('RETURN','SALE','TRANSFER') DEFAULT NULL,
  `scheduled_date` datetime(6) DEFAULT NULL,
  `status` enum('APPROVED','CANCELLED','INSPECTION','PACKING','PICKING','REQUESTED','SHIPPED') DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`outbound_id`),
  KEY `FKbhhp60m4sesy2qfilvkrhdpfp` (`order_id`),
  KEY `FKplcb3292ywh3vn47dqlbilo0x` (`member_id`),
  CONSTRAINT `FKbhhp60m4sesy2qfilvkrhdpfp` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `FKplcb3292ywh3vn47dqlbilo0x` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `outbound_inventory_history`
--

DROP TABLE IF EXISTS `outbound_inventory_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `outbound_inventory_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lot_number` varchar(255) DEFAULT NULL,
  `quantity_changed` int(11) NOT NULL,
  `status` enum('CANCELLED','COMPLETED','PENDING') DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `inventory_id` bigint(20) DEFAULT NULL,
  `location_id` bigint(20) DEFAULT NULL,
  `outbound_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqqb9gw9gbjeiqit7mwkkewsd4` (`inventory_id`),
  KEY `FK7g2h6d1kedca78cphn7j73jo0` (`location_id`),
  KEY `FKbdbupgeehv4iwyekon3481nne` (`outbound_id`),
  KEY `FKtmr55yrwfubbr5tur2retg6fo` (`product_id`),
  CONSTRAINT `FK7g2h6d1kedca78cphn7j73jo0` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `FKbdbupgeehv4iwyekon3481nne` FOREIGN KEY (`outbound_id`) REFERENCES `outbound` (`outbound_id`),
  CONSTRAINT `FKqqb9gw9gbjeiqit7mwkkewsd4` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`),
  CONSTRAINT `FKtmr55yrwfubbr5tur2retg6fo` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `outbound_product_item`
--

DROP TABLE IF EXISTS `outbound_product_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `outbound_product_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) DEFAULT NULL,
  `location_code` varchar(255) DEFAULT NULL,
  `ordered_quantity` int(11) NOT NULL,
  `order_product_item_id` bigint(20) DEFAULT NULL,
  `outbound_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKblo3nlqp90nl3ifopho861qgp` (`order_product_item_id`),
  KEY `FK9e4e2dw0lv4rwsc586fxjaer5` (`outbound_id`),
  KEY `FKcerqxjk4ppfi4iah5dca9tc1i` (`product_id`),
  CONSTRAINT `FK9e4e2dw0lv4rwsc586fxjaer5` FOREIGN KEY (`outbound_id`) REFERENCES `outbound` (`outbound_id`),
  CONSTRAINT `FKblo3nlqp90nl3ifopho861qgp` FOREIGN KEY (`order_product_item_id`) REFERENCES `order_product_item` (`id`),
  CONSTRAINT `FKcerqxjk4ppfi4iah5dca9tc1i` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `picking_task`
--

DROP TABLE IF EXISTS `picking_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `picking_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `outbound_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKgb796t3v3m4vpkgoe9tqv31gm` (`task_id`),
  CONSTRAINT `FKb11rno5qaukuicc7mgkgmdenv` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `product_code` varchar(50) NOT NULL,
  `status` enum('ACTIVE','DISCONTINUED','INACTIVE') DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `unit_price` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  UNIQUE KEY `UKhcpr86kgtroqvxu1mxoyx4ahm` (`product_code`),
  KEY `FK9tnjxr4w1dcvbo2qejikpxpfy` (`vendor_id`),
  CONSTRAINT `FK9tnjxr4w1dcvbo2qejikpxpfy` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_status_history`
--

DROP TABLE IF EXISTS `product_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_status_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `changed_by` varchar(255) DEFAULT NULL,
  `new_status` enum('ACTIVE','DISCONTINUED','INACTIVE') DEFAULT NULL,
  `old_status` enum('ACTIVE','DISCONTINUED','INACTIVE') DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKoilnrkjhl5yvk1298umaflgjo` (`product_id`),
  CONSTRAINT `FKoilnrkjhl5yvk1298umaflgjo` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order`
--

DROP TABLE IF EXISTS `purchase_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `expected_date` datetime(6) DEFAULT NULL,
  `order_code` varchar(255) NOT NULL,
  `order_date` datetime(6) DEFAULT NULL,
  `rejected_at` datetime(6) DEFAULT NULL,
  `rejected_reason` varchar(255) DEFAULT NULL,
  `status` enum('APPROVED','AWAITING_DELIVERY','CANCELLED','COMPLETED','REQUESTED') NOT NULL,
  `total_amount` bigint(20) DEFAULT NULL,
  `vendor_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKiw2u5f5k3jbsrn1mf7bm3p5mt` (`order_code`),
  KEY `FK20jcn7pw6hvx0uo0sh4y1d9xv` (`vendor_id`),
  CONSTRAINT `FK20jcn7pw6hvx0uo0sh4y1d9xv` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order_product`
--

DROP TABLE IF EXISTS `purchase_order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `ordered_quantity` int(11) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `purchase_order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK889ubw1t0walyty363ihoyxak` (`product_id`),
  KEY `FK2sqvupap0ec75a1o2uavjdg1m` (`purchase_order_id`),
  CONSTRAINT `FK2sqvupap0ec75a1o2uavjdg1m` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `FK889ubw1t0walyty363ihoyxak` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `putaway_task`
--

DROP TABLE IF EXISTS `putaway_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `putaway_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `assigned_location_code` varchar(20) DEFAULT NULL,
  `inbound_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK2s6xj4yhwjka0n3d2wrexpxal` (`task_id`),
  CONSTRAINT `FKoqipxu0bpkuccf9uae27dkigo` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `assigned_at` datetime(6) DEFAULT NULL,
  `category` enum('INSPECTION','PACKING','PICKING','PUTAWAY') NOT NULL,
  `completed_at` datetime(6) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `reference_id` bigint(20) DEFAULT NULL,
  `started_at` datetime(6) DEFAULT NULL,
  `status` enum('ASSIGNED','CANCELLED','COMPLETED','IN_PROGRESS','PENDING') NOT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtisaouhsp1pjc613txc886xfh` (`member_id`),
  CONSTRAINT `FKtisaouhsp1pjc613txc886xfh` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor` (
  `vendor_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE','SUSPENDED') NOT NULL,
  `vendor_code` varchar(50) NOT NULL,
  PRIMARY KEY (`vendor_id`),
  UNIQUE KEY `UKabema2gvm8psw0jabn5wfd0gd` (`vendor_code`),
  UNIQUE KEY `UK3ipb1dt1j0q4001jb0u6b9r8n` (`api_key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `active` bit(1) DEFAULT b'1',
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- vendor (20)
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (1, '2024-06-02 09:00:00', '2024-06-02 09:00:00', 'City_1', 'Korea', 'Building 1', 'Street 1', '00001', 'API_KEY_V001', 'Main vendor 1', 'vendor001@example.com', 'Vendor_001', '010-1000-0001', 'ACTIVE', 'V001');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (2, '2024-06-03 09:00:00', '2024-06-03 09:00:00', 'City_2', 'Korea', 'Building 2', 'Street 2', '00002', 'API_KEY_V002', 'Main vendor 2', 'vendor002@example.com', 'Vendor_002', '010-1000-0002', 'ACTIVE', 'V002');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (3, '2024-06-04 09:00:00', '2024-06-04 09:00:00', 'City_3', 'Korea', 'Building 3', 'Street 3', '00003', 'API_KEY_V003', 'Main vendor 3', 'vendor003@example.com', 'Vendor_003', '010-1000-0003', 'ACTIVE', 'V003');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (4, '2024-06-05 09:00:00', '2024-06-05 09:00:00', 'City_4', 'Korea', 'Building 4', 'Street 4', '00004', 'API_KEY_V004', 'Main vendor 4', 'vendor004@example.com', 'Vendor_004', '010-1000-0004', 'ACTIVE', 'V004');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (5, '2024-06-06 09:00:00', '2024-06-06 09:00:00', 'City_5', 'Korea', 'Building 5', 'Street 5', '00005', 'API_KEY_V005', 'Main vendor 5', 'vendor005@example.com', 'Vendor_005', '010-1000-0005', 'ACTIVE', 'V005');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (6, '2024-06-07 09:00:00', '2024-06-07 09:00:00', 'City_6', 'Korea', 'Building 6', 'Street 6', '00006', 'API_KEY_V006', 'Main vendor 6', 'vendor006@example.com', 'Vendor_006', '010-1000-0006', 'ACTIVE', 'V006');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (7, '2024-06-08 09:00:00', '2024-06-08 09:00:00', 'City_7', 'Korea', 'Building 7', 'Street 7', '00007', 'API_KEY_V007', 'Main vendor 7', 'vendor007@example.com', 'Vendor_007', '010-1000-0007', 'ACTIVE', 'V007');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (8, '2024-06-09 09:00:00', '2024-06-09 09:00:00', 'City_8', 'Korea', 'Building 8', 'Street 8', '00008', 'API_KEY_V008', 'Main vendor 8', 'vendor008@example.com', 'Vendor_008', '010-1000-0008', 'ACTIVE', 'V008');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (9, '2024-06-10 09:00:00', '2024-06-10 09:00:00', 'City_9', 'Korea', 'Building 9', 'Street 9', '00009', 'API_KEY_V009', 'Main vendor 9', 'vendor009@example.com', 'Vendor_009', '010-1000-0009', 'ACTIVE', 'V009');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (10, '2024-06-11 09:00:00', '2024-06-11 09:00:00', 'City_10', 'Korea', 'Building 10', 'Street 10', '00010', 'API_KEY_V010', 'Main vendor 10', 'vendor010@example.com', 'Vendor_010', '010-1000-0010', 'ACTIVE', 'V010');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (11, '2024-06-12 09:00:00', '2024-06-12 09:00:00', 'City_11', 'Korea', 'Building 11', 'Street 11', '00011', 'API_KEY_V011', 'Main vendor 11', 'vendor011@example.com', 'Vendor_011', '010-1000-0011', 'ACTIVE', 'V011');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (12, '2024-06-13 09:00:00', '2024-06-13 09:00:00', 'City_12', 'Korea', 'Building 12', 'Street 12', '00012', 'API_KEY_V012', 'Main vendor 12', 'vendor012@example.com', 'Vendor_012', '010-1000-0012', 'ACTIVE', 'V012');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (13, '2024-06-14 09:00:00', '2024-06-14 09:00:00', 'City_13', 'Korea', 'Building 13', 'Street 13', '00013', 'API_KEY_V013', 'Main vendor 13', 'vendor013@example.com', 'Vendor_013', '010-1000-0013', 'ACTIVE', 'V013');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (14, '2024-06-15 09:00:00', '2024-06-15 09:00:00', 'City_14', 'Korea', 'Building 14', 'Street 14', '00014', 'API_KEY_V014', 'Main vendor 14', 'vendor014@example.com', 'Vendor_014', '010-1000-0014', 'ACTIVE', 'V014');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (15, '2024-06-16 09:00:00', '2024-06-16 09:00:00', 'City_15', 'Korea', 'Building 15', 'Street 15', '00015', 'API_KEY_V015', 'Main vendor 15', 'vendor015@example.com', 'Vendor_015', '010-1000-0015', 'ACTIVE', 'V015');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (16, '2024-06-17 09:00:00', '2024-06-17 09:00:00', 'City_16', 'Korea', 'Building 16', 'Street 16', '00016', 'API_KEY_V016', 'Main vendor 16', 'vendor016@example.com', 'Vendor_016', '010-1000-0016', 'ACTIVE', 'V016');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (17, '2024-06-18 09:00:00', '2024-06-18 09:00:00', 'City_17', 'Korea', 'Building 17', 'Street 17', '00017', 'API_KEY_V017', 'Main vendor 17', 'vendor017@example.com', 'Vendor_017', '010-1000-0017', 'ACTIVE', 'V017');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (18, '2024-06-19 09:00:00', '2024-06-19 09:00:00', 'City_18', 'Korea', 'Building 18', 'Street 18', '00018', 'API_KEY_V018', 'Main vendor 18', 'vendor018@example.com', 'Vendor_018', '010-1000-0018', 'ACTIVE', 'V018');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (19, '2024-06-20 09:00:00', '2024-06-20 09:00:00', 'City_19', 'Korea', 'Building 19', 'Street 19', '00019', 'API_KEY_V019', 'Main vendor 19', 'vendor019@example.com', 'Vendor_019', '010-1000-0019', 'ACTIVE', 'V019');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (20, '2024-06-21 09:00:00', '2024-06-21 09:00:00', 'City_20', 'Korea', 'Building 20', 'Street 20', '00020', 'API_KEY_V020', 'Main vendor 20', 'vendor020@example.com', 'Vendor_020', '010-1000-0020', 'ACTIVE', 'V020');

-- product (1000)
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (1, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-1', 'Product_001_001', 'P001001', 'ACTIVE', 'EA', 55607, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (2, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-2', 'Product_001_002', 'P001002', 'ACTIVE', 'EA', 97034, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (3, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-3', 'Product_001_003', 'P001003', 'ACTIVE', 'EA', 2332, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (4, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-4', 'Product_001_004', 'P001004', 'ACTIVE', 'EA', 40143, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (5, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-5', 'Product_001_005', 'P001005', 'ACTIVE', 'EA', 49288, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (6, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-6', 'Product_001_006', 'P001006', 'ACTIVE', 'EA', 26383, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (7, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-7', 'Product_001_007', 'P001007', 'ACTIVE', 'EA', 36421, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (8, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-8', 'Product_001_008', 'P001008', 'ACTIVE', 'EA', 75187, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (9, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-9', 'Product_001_009', 'P001009', 'ACTIVE', 'EA', 58177, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (10, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-10', 'Product_001_010', 'P001010', 'ACTIVE', 'EA', 22192, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (11, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-11', 'Product_001_011', 'P001011', 'ACTIVE', 'EA', 49898, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (12, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-12', 'Product_001_012', 'P001012', 'ACTIVE', 'EA', 17287, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (13, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-13', 'Product_001_013', 'P001013', 'ACTIVE', 'EA', 57745, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (14, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-14', 'Product_001_014', 'P001014', 'ACTIVE', 'EA', 35221, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (15, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-15', 'Product_001_015', 'P001015', 'ACTIVE', 'EA', 74672, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (16, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-16', 'Product_001_016', 'P001016', 'ACTIVE', 'EA', 83210, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (17, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-17', 'Product_001_017', 'P001017', 'ACTIVE', 'EA', 23851, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (18, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-18', 'Product_001_018', 'P001018', 'ACTIVE', 'EA', 81185, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (19, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-19', 'Product_001_019', 'P001019', 'ACTIVE', 'EA', 73511, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (20, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-20', 'Product_001_020', 'P001020', 'ACTIVE', 'EA', 25485, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (21, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-21', 'Product_001_021', 'P001021', 'ACTIVE', 'EA', 47517, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (22, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-22', 'Product_001_022', 'P001022', 'ACTIVE', 'EA', 97750, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (23, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-23', 'Product_001_023', 'P001023', 'ACTIVE', 'EA', 97058, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (24, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-24', 'Product_001_024', 'P001024', 'ACTIVE', 'EA', 12966, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (25, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-25', 'Product_001_025', 'P001025', 'ACTIVE', 'EA', 70604, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (26, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-26', 'Product_001_026', 'P001026', 'ACTIVE', 'EA', 97389, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (27, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-27', 'Product_001_027', 'P001027', 'ACTIVE', 'EA', 55017, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (28, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-28', 'Product_001_028', 'P001028', 'ACTIVE', 'EA', 77683, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (29, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-29', 'Product_001_029', 'P001029', 'ACTIVE', 'EA', 67051, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (30, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-30', 'Product_001_030', 'P001030', 'ACTIVE', 'EA', 22833, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (31, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-31', 'Product_001_031', 'P001031', 'ACTIVE', 'EA', 20417, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (32, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-32', 'Product_001_032', 'P001032', 'ACTIVE', 'EA', 27963, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (33, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-33', 'Product_001_033', 'P001033', 'ACTIVE', 'EA', 95236, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (34, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-34', 'Product_001_034', 'P001034', 'ACTIVE', 'EA', 11202, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (35, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-35', 'Product_001_035', 'P001035', 'ACTIVE', 'EA', 25899, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (36, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-36', 'Product_001_036', 'P001036', 'ACTIVE', 'EA', 45769, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (37, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-37', 'Product_001_037', 'P001037', 'ACTIVE', 'EA', 43210, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (38, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-38', 'Product_001_038', 'P001038', 'ACTIVE', 'EA', 4082, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (39, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-39', 'Product_001_039', 'P001039', 'ACTIVE', 'EA', 61140, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (40, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-40', 'Product_001_040', 'P001040', 'ACTIVE', 'EA', 45501, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (41, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-41', 'Product_001_041', 'P001041', 'ACTIVE', 'EA', 4521, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (42, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-42', 'Product_001_042', 'P001042', 'ACTIVE', 'EA', 67939, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (43, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-43', 'Product_001_043', 'P001043', 'ACTIVE', 'EA', 91532, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (44, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-44', 'Product_001_044', 'P001044', 'ACTIVE', 'EA', 98587, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (45, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-45', 'Product_001_045', 'P001045', 'ACTIVE', 'EA', 55457, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (46, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-46', 'Product_001_046', 'P001046', 'ACTIVE', 'EA', 1452, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (47, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-47', 'Product_001_047', 'P001047', 'ACTIVE', 'EA', 1874, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (48, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-48', 'Product_001_048', 'P001048', 'ACTIVE', 'EA', 88018, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (49, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-49', 'Product_001_049', 'P001049', 'ACTIVE', 'EA', 22470, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (50, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'Product description 1-50', 'Product_001_050', 'P001050', 'ACTIVE', 'EA', 77036, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (51, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-1', 'Product_002_001', 'P002001', 'ACTIVE', 'EA', 24445, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (52, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-2', 'Product_002_002', 'P002002', 'ACTIVE', 'EA', 38561, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (53, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-3', 'Product_002_003', 'P002003', 'ACTIVE', 'EA', 14041, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (54, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-4', 'Product_002_004', 'P002004', 'ACTIVE', 'EA', 86529, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (55, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-5', 'Product_002_005', 'P002005', 'ACTIVE', 'EA', 55333, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (56, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-6', 'Product_002_006', 'P002006', 'ACTIVE', 'EA', 14879, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (57, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-7', 'Product_002_007', 'P002007', 'ACTIVE', 'EA', 90314, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (58, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-8', 'Product_002_008', 'P002008', 'ACTIVE', 'EA', 76770, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (59, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-9', 'Product_002_009', 'P002009', 'ACTIVE', 'EA', 24809, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (60, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-10', 'Product_002_010', 'P002010', 'ACTIVE', 'EA', 97545, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (61, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-11', 'Product_002_011', 'P002011', 'ACTIVE', 'EA', 50152, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (62, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-12', 'Product_002_012', 'P002012', 'ACTIVE', 'EA', 31490, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (63, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-13', 'Product_002_013', 'P002013', 'ACTIVE', 'EA', 69628, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (64, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-14', 'Product_002_014', 'P002014', 'ACTIVE', 'EA', 79118, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (65, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-15', 'Product_002_015', 'P002015', 'ACTIVE', 'EA', 93980, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (66, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-16', 'Product_002_016', 'P002016', 'ACTIVE', 'EA', 44239, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (67, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-17', 'Product_002_017', 'P002017', 'ACTIVE', 'EA', 6275, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (68, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-18', 'Product_002_018', 'P002018', 'ACTIVE', 'EA', 31449, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (69, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-19', 'Product_002_019', 'P002019', 'ACTIVE', 'EA', 16702, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (70, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-20', 'Product_002_020', 'P002020', 'ACTIVE', 'EA', 66434, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (71, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-21', 'Product_002_021', 'P002021', 'ACTIVE', 'EA', 29361, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (72, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-22', 'Product_002_022', 'P002022', 'ACTIVE', 'EA', 97625, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (73, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-23', 'Product_002_023', 'P002023', 'ACTIVE', 'EA', 73756, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (74, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-24', 'Product_002_024', 'P002024', 'ACTIVE', 'EA', 88780, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (75, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-25', 'Product_002_025', 'P002025', 'ACTIVE', 'EA', 25356, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (76, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-26', 'Product_002_026', 'P002026', 'ACTIVE', 'EA', 34781, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (77, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-27', 'Product_002_027', 'P002027', 'ACTIVE', 'EA', 78150, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (78, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-28', 'Product_002_028', 'P002028', 'ACTIVE', 'EA', 57842, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (79, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-29', 'Product_002_029', 'P002029', 'ACTIVE', 'EA', 68926, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (80, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-30', 'Product_002_030', 'P002030', 'ACTIVE', 'EA', 18022, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (81, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-31', 'Product_002_031', 'P002031', 'ACTIVE', 'EA', 6444, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (82, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-32', 'Product_002_032', 'P002032', 'ACTIVE', 'EA', 22513, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (83, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-33', 'Product_002_033', 'P002033', 'ACTIVE', 'EA', 40495, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (84, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-34', 'Product_002_034', 'P002034', 'ACTIVE', 'EA', 2226, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (85, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-35', 'Product_002_035', 'P002035', 'ACTIVE', 'EA', 20696, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (86, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-36', 'Product_002_036', 'P002036', 'ACTIVE', 'EA', 31030, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (87, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-37', 'Product_002_037', 'P002037', 'ACTIVE', 'EA', 46839, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (88, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-38', 'Product_002_038', 'P002038', 'ACTIVE', 'EA', 71665, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (89, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-39', 'Product_002_039', 'P002039', 'ACTIVE', 'EA', 45822, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (90, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-40', 'Product_002_040', 'P002040', 'ACTIVE', 'EA', 21575, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (91, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-41', 'Product_002_041', 'P002041', 'ACTIVE', 'EA', 51595, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (92, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-42', 'Product_002_042', 'P002042', 'ACTIVE', 'EA', 43435, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (93, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-43', 'Product_002_043', 'P002043', 'ACTIVE', 'EA', 2683, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (94, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-44', 'Product_002_044', 'P002044', 'ACTIVE', 'EA', 7464, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (95, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-45', 'Product_002_045', 'P002045', 'ACTIVE', 'EA', 8980, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (96, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-46', 'Product_002_046', 'P002046', 'ACTIVE', 'EA', 94280, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (97, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-47', 'Product_002_047', 'P002047', 'ACTIVE', 'EA', 59341, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (98, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-48', 'Product_002_048', 'P002048', 'ACTIVE', 'EA', 11297, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (99, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-49', 'Product_002_049', 'P002049', 'ACTIVE', 'EA', 51869, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (100, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'Product description 2-50', 'Product_002_050', 'P002050', 'ACTIVE', 'EA', 24525, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (101, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-1', 'Product_003_001', 'P003001', 'ACTIVE', 'EA', 2534, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (102, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-2', 'Product_003_002', 'P003002', 'ACTIVE', 'EA', 94367, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (103, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-3', 'Product_003_003', 'P003003', 'ACTIVE', 'EA', 49202, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (104, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-4', 'Product_003_004', 'P003004', 'ACTIVE', 'EA', 29226, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (105, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-5', 'Product_003_005', 'P003005', 'ACTIVE', 'EA', 89959, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (106, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-6', 'Product_003_006', 'P003006', 'ACTIVE', 'EA', 68177, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (107, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-7', 'Product_003_007', 'P003007', 'ACTIVE', 'EA', 16925, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (108, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-8', 'Product_003_008', 'P003008', 'ACTIVE', 'EA', 64016, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (109, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-9', 'Product_003_009', 'P003009', 'ACTIVE', 'EA', 82507, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (110, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-10', 'Product_003_010', 'P003010', 'ACTIVE', 'EA', 9064, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (111, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-11', 'Product_003_011', 'P003011', 'ACTIVE', 'EA', 2811, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (112, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-12', 'Product_003_012', 'P003012', 'ACTIVE', 'EA', 83064, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (113, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-13', 'Product_003_013', 'P003013', 'ACTIVE', 'EA', 65460, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (114, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-14', 'Product_003_014', 'P003014', 'ACTIVE', 'EA', 43698, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (115, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-15', 'Product_003_015', 'P003015', 'ACTIVE', 'EA', 80965, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (116, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-16', 'Product_003_016', 'P003016', 'ACTIVE', 'EA', 56158, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (117, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-17', 'Product_003_017', 'P003017', 'ACTIVE', 'EA', 73064, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (118, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-18', 'Product_003_018', 'P003018', 'ACTIVE', 'EA', 27423, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (119, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-19', 'Product_003_019', 'P003019', 'ACTIVE', 'EA', 48747, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (120, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-20', 'Product_003_020', 'P003020', 'ACTIVE', 'EA', 87880, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (121, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-21', 'Product_003_021', 'P003021', 'ACTIVE', 'EA', 92561, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (122, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-22', 'Product_003_022', 'P003022', 'ACTIVE', 'EA', 16647, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (123, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-23', 'Product_003_023', 'P003023', 'ACTIVE', 'EA', 73949, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (124, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-24', 'Product_003_024', 'P003024', 'ACTIVE', 'EA', 20616, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (125, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-25', 'Product_003_025', 'P003025', 'ACTIVE', 'EA', 11491, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (126, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-26', 'Product_003_026', 'P003026', 'ACTIVE', 'EA', 65866, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (127, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-27', 'Product_003_027', 'P003027', 'ACTIVE', 'EA', 22620, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (128, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-28', 'Product_003_028', 'P003028', 'ACTIVE', 'EA', 44981, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (129, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-29', 'Product_003_029', 'P003029', 'ACTIVE', 'EA', 31230, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (130, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-30', 'Product_003_030', 'P003030', 'ACTIVE', 'EA', 27640, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (131, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-31', 'Product_003_031', 'P003031', 'ACTIVE', 'EA', 22435, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (132, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-32', 'Product_003_032', 'P003032', 'ACTIVE', 'EA', 22332, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (133, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-33', 'Product_003_033', 'P003033', 'ACTIVE', 'EA', 38787, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (134, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-34', 'Product_003_034', 'P003034', 'ACTIVE', 'EA', 20679, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (135, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-35', 'Product_003_035', 'P003035', 'ACTIVE', 'EA', 71401, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (136, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-36', 'Product_003_036', 'P003036', 'ACTIVE', 'EA', 12874, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (137, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-37', 'Product_003_037', 'P003037', 'ACTIVE', 'EA', 69106, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (138, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-38', 'Product_003_038', 'P003038', 'ACTIVE', 'EA', 92189, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (139, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-39', 'Product_003_039', 'P003039', 'ACTIVE', 'EA', 1436, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (140, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-40', 'Product_003_040', 'P003040', 'ACTIVE', 'EA', 20207, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (141, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-41', 'Product_003_041', 'P003041', 'ACTIVE', 'EA', 1417, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (142, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-42', 'Product_003_042', 'P003042', 'ACTIVE', 'EA', 87203, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (143, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-43', 'Product_003_043', 'P003043', 'ACTIVE', 'EA', 66020, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (144, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-44', 'Product_003_044', 'P003044', 'ACTIVE', 'EA', 25229, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (145, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-45', 'Product_003_045', 'P003045', 'ACTIVE', 'EA', 80626, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (146, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-46', 'Product_003_046', 'P003046', 'ACTIVE', 'EA', 13566, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (147, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-47', 'Product_003_047', 'P003047', 'ACTIVE', 'EA', 35639, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (148, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-48', 'Product_003_048', 'P003048', 'ACTIVE', 'EA', 67213, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (149, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-49', 'Product_003_049', 'P003049', 'ACTIVE', 'EA', 99307, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (150, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'Product description 3-50', 'Product_003_050', 'P003050', 'ACTIVE', 'EA', 54233, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (151, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-1', 'Product_004_001', 'P004001', 'ACTIVE', 'EA', 9666, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (152, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-2', 'Product_004_002', 'P004002', 'ACTIVE', 'EA', 99494, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (153, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-3', 'Product_004_003', 'P004003', 'ACTIVE', 'EA', 61406, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (154, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-4', 'Product_004_004', 'P004004', 'ACTIVE', 'EA', 55620, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (155, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-5', 'Product_004_005', 'P004005', 'ACTIVE', 'EA', 24846, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (156, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-6', 'Product_004_006', 'P004006', 'ACTIVE', 'EA', 32885, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (157, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-7', 'Product_004_007', 'P004007', 'ACTIVE', 'EA', 25159, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (158, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-8', 'Product_004_008', 'P004008', 'ACTIVE', 'EA', 4575, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (159, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-9', 'Product_004_009', 'P004009', 'ACTIVE', 'EA', 49878, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (160, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-10', 'Product_004_010', 'P004010', 'ACTIVE', 'EA', 44314, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (161, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-11', 'Product_004_011', 'P004011', 'ACTIVE', 'EA', 24063, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (162, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-12', 'Product_004_012', 'P004012', 'ACTIVE', 'EA', 52743, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (163, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-13', 'Product_004_013', 'P004013', 'ACTIVE', 'EA', 24311, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (164, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-14', 'Product_004_014', 'P004014', 'ACTIVE', 'EA', 24328, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (165, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-15', 'Product_004_015', 'P004015', 'ACTIVE', 'EA', 75926, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (166, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-16', 'Product_004_016', 'P004016', 'ACTIVE', 'EA', 90120, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (167, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-17', 'Product_004_017', 'P004017', 'ACTIVE', 'EA', 68930, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (168, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-18', 'Product_004_018', 'P004018', 'ACTIVE', 'EA', 33629, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (169, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-19', 'Product_004_019', 'P004019', 'ACTIVE', 'EA', 55165, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (170, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-20', 'Product_004_020', 'P004020', 'ACTIVE', 'EA', 68266, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (171, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-21', 'Product_004_021', 'P004021', 'ACTIVE', 'EA', 91686, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (172, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-22', 'Product_004_022', 'P004022', 'ACTIVE', 'EA', 55726, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (173, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-23', 'Product_004_023', 'P004023', 'ACTIVE', 'EA', 43593, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (174, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-24', 'Product_004_024', 'P004024', 'ACTIVE', 'EA', 16747, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (175, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-25', 'Product_004_025', 'P004025', 'ACTIVE', 'EA', 9874, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (176, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-26', 'Product_004_026', 'P004026', 'ACTIVE', 'EA', 85376, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (177, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-27', 'Product_004_027', 'P004027', 'ACTIVE', 'EA', 61359, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (178, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-28', 'Product_004_028', 'P004028', 'ACTIVE', 'EA', 98460, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (179, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-29', 'Product_004_029', 'P004029', 'ACTIVE', 'EA', 26567, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (180, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-30', 'Product_004_030', 'P004030', 'ACTIVE', 'EA', 83332, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (181, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-31', 'Product_004_031', 'P004031', 'ACTIVE', 'EA', 82436, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (182, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-32', 'Product_004_032', 'P004032', 'ACTIVE', 'EA', 75872, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (183, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-33', 'Product_004_033', 'P004033', 'ACTIVE', 'EA', 27462, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (184, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-34', 'Product_004_034', 'P004034', 'ACTIVE', 'EA', 99192, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (185, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-35', 'Product_004_035', 'P004035', 'ACTIVE', 'EA', 18698, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (186, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-36', 'Product_004_036', 'P004036', 'ACTIVE', 'EA', 70594, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (187, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-37', 'Product_004_037', 'P004037', 'ACTIVE', 'EA', 31571, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (188, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-38', 'Product_004_038', 'P004038', 'ACTIVE', 'EA', 44291, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (189, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-39', 'Product_004_039', 'P004039', 'ACTIVE', 'EA', 75431, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (190, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-40', 'Product_004_040', 'P004040', 'ACTIVE', 'EA', 39313, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (191, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-41', 'Product_004_041', 'P004041', 'ACTIVE', 'EA', 17431, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (192, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-42', 'Product_004_042', 'P004042', 'ACTIVE', 'EA', 71550, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (193, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-43', 'Product_004_043', 'P004043', 'ACTIVE', 'EA', 67889, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (194, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-44', 'Product_004_044', 'P004044', 'ACTIVE', 'EA', 91882, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (195, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-45', 'Product_004_045', 'P004045', 'ACTIVE', 'EA', 88948, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (196, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-46', 'Product_004_046', 'P004046', 'ACTIVE', 'EA', 8759, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (197, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-47', 'Product_004_047', 'P004047', 'ACTIVE', 'EA', 35070, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (198, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-48', 'Product_004_048', 'P004048', 'ACTIVE', 'EA', 56951, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (199, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-49', 'Product_004_049', 'P004049', 'ACTIVE', 'EA', 6772, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (200, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'Product description 4-50', 'Product_004_050', 'P004050', 'ACTIVE', 'EA', 48705, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (201, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-1', 'Product_005_001', 'P005001', 'ACTIVE', 'EA', 68723, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (202, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-2', 'Product_005_002', 'P005002', 'ACTIVE', 'EA', 71241, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (203, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-3', 'Product_005_003', 'P005003', 'ACTIVE', 'EA', 76241, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (204, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-4', 'Product_005_004', 'P005004', 'ACTIVE', 'EA', 15098, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (205, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-5', 'Product_005_005', 'P005005', 'ACTIVE', 'EA', 83482, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (206, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-6', 'Product_005_006', 'P005006', 'ACTIVE', 'EA', 9906, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (207, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-7', 'Product_005_007', 'P005007', 'ACTIVE', 'EA', 21469, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (208, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-8', 'Product_005_008', 'P005008', 'ACTIVE', 'EA', 49656, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (209, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-9', 'Product_005_009', 'P005009', 'ACTIVE', 'EA', 93872, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (210, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-10', 'Product_005_010', 'P005010', 'ACTIVE', 'EA', 84205, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (211, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-11', 'Product_005_011', 'P005011', 'ACTIVE', 'EA', 5630, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (212, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-12', 'Product_005_012', 'P005012', 'ACTIVE', 'EA', 37035, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (213, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-13', 'Product_005_013', 'P005013', 'ACTIVE', 'EA', 98810, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (214, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-14', 'Product_005_014', 'P005014', 'ACTIVE', 'EA', 59207, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (215, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-15', 'Product_005_015', 'P005015', 'ACTIVE', 'EA', 90902, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (216, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-16', 'Product_005_016', 'P005016', 'ACTIVE', 'EA', 49324, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (217, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-17', 'Product_005_017', 'P005017', 'ACTIVE', 'EA', 53663, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (218, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-18', 'Product_005_018', 'P005018', 'ACTIVE', 'EA', 41272, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (219, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-19', 'Product_005_019', 'P005019', 'ACTIVE', 'EA', 59873, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (220, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-20', 'Product_005_020', 'P005020', 'ACTIVE', 'EA', 81002, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (221, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-21', 'Product_005_021', 'P005021', 'ACTIVE', 'EA', 35647, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (222, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-22', 'Product_005_022', 'P005022', 'ACTIVE', 'EA', 41874, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (223, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-23', 'Product_005_023', 'P005023', 'ACTIVE', 'EA', 97629, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (224, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-24', 'Product_005_024', 'P005024', 'ACTIVE', 'EA', 65553, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (225, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-25', 'Product_005_025', 'P005025', 'ACTIVE', 'EA', 63967, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (226, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-26', 'Product_005_026', 'P005026', 'ACTIVE', 'EA', 7601, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (227, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-27', 'Product_005_027', 'P005027', 'ACTIVE', 'EA', 35751, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (228, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-28', 'Product_005_028', 'P005028', 'ACTIVE', 'EA', 59400, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (229, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-29', 'Product_005_029', 'P005029', 'ACTIVE', 'EA', 4847, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (230, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-30', 'Product_005_030', 'P005030', 'ACTIVE', 'EA', 29788, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (231, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-31', 'Product_005_031', 'P005031', 'ACTIVE', 'EA', 46229, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (232, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-32', 'Product_005_032', 'P005032', 'ACTIVE', 'EA', 18834, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (233, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-33', 'Product_005_033', 'P005033', 'ACTIVE', 'EA', 1266, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (234, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-34', 'Product_005_034', 'P005034', 'ACTIVE', 'EA', 89623, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (235, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-35', 'Product_005_035', 'P005035', 'ACTIVE', 'EA', 82998, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (236, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-36', 'Product_005_036', 'P005036', 'ACTIVE', 'EA', 11897, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (237, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-37', 'Product_005_037', 'P005037', 'ACTIVE', 'EA', 5011, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (238, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-38', 'Product_005_038', 'P005038', 'ACTIVE', 'EA', 15556, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (239, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-39', 'Product_005_039', 'P005039', 'ACTIVE', 'EA', 79965, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (240, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-40', 'Product_005_040', 'P005040', 'ACTIVE', 'EA', 25635, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (241, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-41', 'Product_005_041', 'P005041', 'ACTIVE', 'EA', 53028, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (242, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-42', 'Product_005_042', 'P005042', 'ACTIVE', 'EA', 65294, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (243, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-43', 'Product_005_043', 'P005043', 'ACTIVE', 'EA', 24833, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (244, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-44', 'Product_005_044', 'P005044', 'ACTIVE', 'EA', 36733, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (245, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-45', 'Product_005_045', 'P005045', 'ACTIVE', 'EA', 46761, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (246, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-46', 'Product_005_046', 'P005046', 'ACTIVE', 'EA', 28335, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (247, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-47', 'Product_005_047', 'P005047', 'ACTIVE', 'EA', 40341, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (248, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-48', 'Product_005_048', 'P005048', 'ACTIVE', 'EA', 96078, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (249, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-49', 'Product_005_049', 'P005049', 'ACTIVE', 'EA', 42327, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (250, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'Product description 5-50', 'Product_005_050', 'P005050', 'ACTIVE', 'EA', 51892, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (251, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-1', 'Product_006_001', 'P006001', 'ACTIVE', 'EA', 10893, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (252, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-2', 'Product_006_002', 'P006002', 'ACTIVE', 'EA', 81851, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (253, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-3', 'Product_006_003', 'P006003', 'ACTIVE', 'EA', 40432, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (254, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-4', 'Product_006_004', 'P006004', 'ACTIVE', 'EA', 49287, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (255, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-5', 'Product_006_005', 'P006005', 'ACTIVE', 'EA', 6302, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (256, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-6', 'Product_006_006', 'P006006', 'ACTIVE', 'EA', 55952, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (257, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-7', 'Product_006_007', 'P006007', 'ACTIVE', 'EA', 25867, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (258, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-8', 'Product_006_008', 'P006008', 'ACTIVE', 'EA', 22040, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (259, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-9', 'Product_006_009', 'P006009', 'ACTIVE', 'EA', 11729, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (260, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-10', 'Product_006_010', 'P006010', 'ACTIVE', 'EA', 19722, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (261, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-11', 'Product_006_011', 'P006011', 'ACTIVE', 'EA', 41175, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (262, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-12', 'Product_006_012', 'P006012', 'ACTIVE', 'EA', 31440, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (263, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-13', 'Product_006_013', 'P006013', 'ACTIVE', 'EA', 44625, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (264, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-14', 'Product_006_014', 'P006014', 'ACTIVE', 'EA', 56612, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (265, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-15', 'Product_006_015', 'P006015', 'ACTIVE', 'EA', 27333, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (266, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-16', 'Product_006_016', 'P006016', 'ACTIVE', 'EA', 2816, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (267, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-17', 'Product_006_017', 'P006017', 'ACTIVE', 'EA', 20647, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (268, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-18', 'Product_006_018', 'P006018', 'ACTIVE', 'EA', 15898, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (269, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-19', 'Product_006_019', 'P006019', 'ACTIVE', 'EA', 68370, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (270, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-20', 'Product_006_020', 'P006020', 'ACTIVE', 'EA', 5132, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (271, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-21', 'Product_006_021', 'P006021', 'ACTIVE', 'EA', 45699, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (272, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-22', 'Product_006_022', 'P006022', 'ACTIVE', 'EA', 52398, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (273, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-23', 'Product_006_023', 'P006023', 'ACTIVE', 'EA', 42857, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (274, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-24', 'Product_006_024', 'P006024', 'ACTIVE', 'EA', 6349, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (275, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-25', 'Product_006_025', 'P006025', 'ACTIVE', 'EA', 32635, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (276, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-26', 'Product_006_026', 'P006026', 'ACTIVE', 'EA', 14056, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (277, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-27', 'Product_006_027', 'P006027', 'ACTIVE', 'EA', 64522, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (278, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-28', 'Product_006_028', 'P006028', 'ACTIVE', 'EA', 20466, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (279, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-29', 'Product_006_029', 'P006029', 'ACTIVE', 'EA', 76810, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (280, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-30', 'Product_006_030', 'P006030', 'ACTIVE', 'EA', 28034, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (281, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-31', 'Product_006_031', 'P006031', 'ACTIVE', 'EA', 34967, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (282, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-32', 'Product_006_032', 'P006032', 'ACTIVE', 'EA', 75691, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (283, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-33', 'Product_006_033', 'P006033', 'ACTIVE', 'EA', 70777, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (284, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-34', 'Product_006_034', 'P006034', 'ACTIVE', 'EA', 48040, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (285, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-35', 'Product_006_035', 'P006035', 'ACTIVE', 'EA', 21759, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (286, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-36', 'Product_006_036', 'P006036', 'ACTIVE', 'EA', 98156, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (287, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-37', 'Product_006_037', 'P006037', 'ACTIVE', 'EA', 38238, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (288, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-38', 'Product_006_038', 'P006038', 'ACTIVE', 'EA', 5982, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (289, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-39', 'Product_006_039', 'P006039', 'ACTIVE', 'EA', 13029, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (290, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-40', 'Product_006_040', 'P006040', 'ACTIVE', 'EA', 13318, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (291, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-41', 'Product_006_041', 'P006041', 'ACTIVE', 'EA', 70154, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (292, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-42', 'Product_006_042', 'P006042', 'ACTIVE', 'EA', 28174, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (293, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-43', 'Product_006_043', 'P006043', 'ACTIVE', 'EA', 73020, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (294, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-44', 'Product_006_044', 'P006044', 'ACTIVE', 'EA', 67086, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (295, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-45', 'Product_006_045', 'P006045', 'ACTIVE', 'EA', 87153, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (296, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-46', 'Product_006_046', 'P006046', 'ACTIVE', 'EA', 54757, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (297, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-47', 'Product_006_047', 'P006047', 'ACTIVE', 'EA', 69680, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (298, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-48', 'Product_006_048', 'P006048', 'ACTIVE', 'EA', 2994, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (299, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-49', 'Product_006_049', 'P006049', 'ACTIVE', 'EA', 69156, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (300, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'Product description 6-50', 'Product_006_050', 'P006050', 'ACTIVE', 'EA', 20870, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (301, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-1', 'Product_007_001', 'P007001', 'ACTIVE', 'EA', 78128, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (302, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-2', 'Product_007_002', 'P007002', 'ACTIVE', 'EA', 70680, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (303, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-3', 'Product_007_003', 'P007003', 'ACTIVE', 'EA', 43645, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (304, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-4', 'Product_007_004', 'P007004', 'ACTIVE', 'EA', 78081, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (305, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-5', 'Product_007_005', 'P007005', 'ACTIVE', 'EA', 22457, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (306, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-6', 'Product_007_006', 'P007006', 'ACTIVE', 'EA', 60962, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (307, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-7', 'Product_007_007', 'P007007', 'ACTIVE', 'EA', 55340, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (308, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-8', 'Product_007_008', 'P007008', 'ACTIVE', 'EA', 58621, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (309, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-9', 'Product_007_009', 'P007009', 'ACTIVE', 'EA', 4220, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (310, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-10', 'Product_007_010', 'P007010', 'ACTIVE', 'EA', 49726, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (311, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-11', 'Product_007_011', 'P007011', 'ACTIVE', 'EA', 87842, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (312, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-12', 'Product_007_012', 'P007012', 'ACTIVE', 'EA', 4585, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (313, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-13', 'Product_007_013', 'P007013', 'ACTIVE', 'EA', 51912, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (314, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-14', 'Product_007_014', 'P007014', 'ACTIVE', 'EA', 47337, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (315, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-15', 'Product_007_015', 'P007015', 'ACTIVE', 'EA', 89362, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (316, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-16', 'Product_007_016', 'P007016', 'ACTIVE', 'EA', 71898, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (317, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-17', 'Product_007_017', 'P007017', 'ACTIVE', 'EA', 87249, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (318, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-18', 'Product_007_018', 'P007018', 'ACTIVE', 'EA', 78893, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (319, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-19', 'Product_007_019', 'P007019', 'ACTIVE', 'EA', 3233, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (320, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-20', 'Product_007_020', 'P007020', 'ACTIVE', 'EA', 42843, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (321, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-21', 'Product_007_021', 'P007021', 'ACTIVE', 'EA', 62635, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (322, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-22', 'Product_007_022', 'P007022', 'ACTIVE', 'EA', 58362, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (323, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-23', 'Product_007_023', 'P007023', 'ACTIVE', 'EA', 6995, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (324, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-24', 'Product_007_024', 'P007024', 'ACTIVE', 'EA', 42813, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (325, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-25', 'Product_007_025', 'P007025', 'ACTIVE', 'EA', 42054, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (326, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-26', 'Product_007_026', 'P007026', 'ACTIVE', 'EA', 52049, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (327, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-27', 'Product_007_027', 'P007027', 'ACTIVE', 'EA', 40120, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (328, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-28', 'Product_007_028', 'P007028', 'ACTIVE', 'EA', 17444, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (329, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-29', 'Product_007_029', 'P007029', 'ACTIVE', 'EA', 50770, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (330, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-30', 'Product_007_030', 'P007030', 'ACTIVE', 'EA', 75104, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (331, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-31', 'Product_007_031', 'P007031', 'ACTIVE', 'EA', 82596, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (332, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-32', 'Product_007_032', 'P007032', 'ACTIVE', 'EA', 8434, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (333, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-33', 'Product_007_033', 'P007033', 'ACTIVE', 'EA', 75744, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (334, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-34', 'Product_007_034', 'P007034', 'ACTIVE', 'EA', 15395, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (335, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-35', 'Product_007_035', 'P007035', 'ACTIVE', 'EA', 64723, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (336, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-36', 'Product_007_036', 'P007036', 'ACTIVE', 'EA', 16557, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (337, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-37', 'Product_007_037', 'P007037', 'ACTIVE', 'EA', 13636, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (338, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-38', 'Product_007_038', 'P007038', 'ACTIVE', 'EA', 81581, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (339, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-39', 'Product_007_039', 'P007039', 'ACTIVE', 'EA', 23821, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (340, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-40', 'Product_007_040', 'P007040', 'ACTIVE', 'EA', 5359, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (341, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-41', 'Product_007_041', 'P007041', 'ACTIVE', 'EA', 7712, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (342, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-42', 'Product_007_042', 'P007042', 'ACTIVE', 'EA', 41481, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (343, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-43', 'Product_007_043', 'P007043', 'ACTIVE', 'EA', 29375, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (344, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-44', 'Product_007_044', 'P007044', 'ACTIVE', 'EA', 69822, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (345, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-45', 'Product_007_045', 'P007045', 'ACTIVE', 'EA', 13642, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (346, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-46', 'Product_007_046', 'P007046', 'ACTIVE', 'EA', 61351, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (347, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-47', 'Product_007_047', 'P007047', 'ACTIVE', 'EA', 66439, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (348, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-48', 'Product_007_048', 'P007048', 'ACTIVE', 'EA', 62485, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (349, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-49', 'Product_007_049', 'P007049', 'ACTIVE', 'EA', 8718, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (350, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'Product description 7-50', 'Product_007_050', 'P007050', 'ACTIVE', 'EA', 56490, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (351, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-1', 'Product_008_001', 'P008001', 'ACTIVE', 'EA', 29842, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (352, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-2', 'Product_008_002', 'P008002', 'ACTIVE', 'EA', 30113, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (353, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-3', 'Product_008_003', 'P008003', 'ACTIVE', 'EA', 44191, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (354, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-4', 'Product_008_004', 'P008004', 'ACTIVE', 'EA', 98667, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (355, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-5', 'Product_008_005', 'P008005', 'ACTIVE', 'EA', 22250, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (356, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-6', 'Product_008_006', 'P008006', 'ACTIVE', 'EA', 51226, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (357, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-7', 'Product_008_007', 'P008007', 'ACTIVE', 'EA', 78088, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (358, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-8', 'Product_008_008', 'P008008', 'ACTIVE', 'EA', 72208, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (359, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-9', 'Product_008_009', 'P008009', 'ACTIVE', 'EA', 32678, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (360, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-10', 'Product_008_010', 'P008010', 'ACTIVE', 'EA', 90919, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (361, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-11', 'Product_008_011', 'P008011', 'ACTIVE', 'EA', 62809, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (362, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-12', 'Product_008_012', 'P008012', 'ACTIVE', 'EA', 24647, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (363, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-13', 'Product_008_013', 'P008013', 'ACTIVE', 'EA', 28324, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (364, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-14', 'Product_008_014', 'P008014', 'ACTIVE', 'EA', 73573, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (365, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-15', 'Product_008_015', 'P008015', 'ACTIVE', 'EA', 76284, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (366, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-16', 'Product_008_016', 'P008016', 'ACTIVE', 'EA', 73241, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (367, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-17', 'Product_008_017', 'P008017', 'ACTIVE', 'EA', 84867, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (368, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-18', 'Product_008_018', 'P008018', 'ACTIVE', 'EA', 29033, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (369, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-19', 'Product_008_019', 'P008019', 'ACTIVE', 'EA', 21891, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (370, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-20', 'Product_008_020', 'P008020', 'ACTIVE', 'EA', 89180, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (371, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-21', 'Product_008_021', 'P008021', 'ACTIVE', 'EA', 96990, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (372, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-22', 'Product_008_022', 'P008022', 'ACTIVE', 'EA', 60696, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (373, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-23', 'Product_008_023', 'P008023', 'ACTIVE', 'EA', 2894, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (374, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-24', 'Product_008_024', 'P008024', 'ACTIVE', 'EA', 86276, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (375, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-25', 'Product_008_025', 'P008025', 'ACTIVE', 'EA', 26548, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (376, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-26', 'Product_008_026', 'P008026', 'ACTIVE', 'EA', 10596, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (377, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-27', 'Product_008_027', 'P008027', 'ACTIVE', 'EA', 10142, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (378, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-28', 'Product_008_028', 'P008028', 'ACTIVE', 'EA', 74476, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (379, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-29', 'Product_008_029', 'P008029', 'ACTIVE', 'EA', 17031, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (380, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-30', 'Product_008_030', 'P008030', 'ACTIVE', 'EA', 13381, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (381, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-31', 'Product_008_031', 'P008031', 'ACTIVE', 'EA', 35767, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (382, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-32', 'Product_008_032', 'P008032', 'ACTIVE', 'EA', 75297, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (383, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-33', 'Product_008_033', 'P008033', 'ACTIVE', 'EA', 31895, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (384, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-34', 'Product_008_034', 'P008034', 'ACTIVE', 'EA', 28995, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (385, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-35', 'Product_008_035', 'P008035', 'ACTIVE', 'EA', 37388, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (386, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-36', 'Product_008_036', 'P008036', 'ACTIVE', 'EA', 30533, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (387, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-37', 'Product_008_037', 'P008037', 'ACTIVE', 'EA', 66230, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (388, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-38', 'Product_008_038', 'P008038', 'ACTIVE', 'EA', 49512, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (389, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-39', 'Product_008_039', 'P008039', 'ACTIVE', 'EA', 97231, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (390, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-40', 'Product_008_040', 'P008040', 'ACTIVE', 'EA', 91312, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (391, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-41', 'Product_008_041', 'P008041', 'ACTIVE', 'EA', 59554, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (392, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-42', 'Product_008_042', 'P008042', 'ACTIVE', 'EA', 87922, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (393, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-43', 'Product_008_043', 'P008043', 'ACTIVE', 'EA', 53893, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (394, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-44', 'Product_008_044', 'P008044', 'ACTIVE', 'EA', 74687, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (395, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-45', 'Product_008_045', 'P008045', 'ACTIVE', 'EA', 33654, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (396, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-46', 'Product_008_046', 'P008046', 'ACTIVE', 'EA', 86285, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (397, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-47', 'Product_008_047', 'P008047', 'ACTIVE', 'EA', 60061, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (398, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-48', 'Product_008_048', 'P008048', 'ACTIVE', 'EA', 67117, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (399, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-49', 'Product_008_049', 'P008049', 'ACTIVE', 'EA', 15214, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (400, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'Product description 8-50', 'Product_008_050', 'P008050', 'ACTIVE', 'EA', 68912, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (401, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-1', 'Product_009_001', 'P009001', 'ACTIVE', 'EA', 4948, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (402, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-2', 'Product_009_002', 'P009002', 'ACTIVE', 'EA', 68223, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (403, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-3', 'Product_009_003', 'P009003', 'ACTIVE', 'EA', 71805, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (404, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-4', 'Product_009_004', 'P009004', 'ACTIVE', 'EA', 90245, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (405, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-5', 'Product_009_005', 'P009005', 'ACTIVE', 'EA', 49231, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (406, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-6', 'Product_009_006', 'P009006', 'ACTIVE', 'EA', 32304, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (407, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-7', 'Product_009_007', 'P009007', 'ACTIVE', 'EA', 53389, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (408, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-8', 'Product_009_008', 'P009008', 'ACTIVE', 'EA', 65646, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (409, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-9', 'Product_009_009', 'P009009', 'ACTIVE', 'EA', 90772, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (410, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-10', 'Product_009_010', 'P009010', 'ACTIVE', 'EA', 11802, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (411, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-11', 'Product_009_011', 'P009011', 'ACTIVE', 'EA', 56248, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (412, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-12', 'Product_009_012', 'P009012', 'ACTIVE', 'EA', 62021, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (413, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-13', 'Product_009_013', 'P009013', 'ACTIVE', 'EA', 15552, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (414, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-14', 'Product_009_014', 'P009014', 'ACTIVE', 'EA', 43959, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (415, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-15', 'Product_009_015', 'P009015', 'ACTIVE', 'EA', 33665, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (416, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-16', 'Product_009_016', 'P009016', 'ACTIVE', 'EA', 59224, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (417, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-17', 'Product_009_017', 'P009017', 'ACTIVE', 'EA', 40809, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (418, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-18', 'Product_009_018', 'P009018', 'ACTIVE', 'EA', 56657, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (419, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-19', 'Product_009_019', 'P009019', 'ACTIVE', 'EA', 75212, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (420, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-20', 'Product_009_020', 'P009020', 'ACTIVE', 'EA', 17332, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (421, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-21', 'Product_009_021', 'P009021', 'ACTIVE', 'EA', 23440, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (422, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-22', 'Product_009_022', 'P009022', 'ACTIVE', 'EA', 29569, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (423, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-23', 'Product_009_023', 'P009023', 'ACTIVE', 'EA', 96503, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (424, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-24', 'Product_009_024', 'P009024', 'ACTIVE', 'EA', 81852, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (425, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-25', 'Product_009_025', 'P009025', 'ACTIVE', 'EA', 51442, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (426, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-26', 'Product_009_026', 'P009026', 'ACTIVE', 'EA', 35370, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (427, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-27', 'Product_009_027', 'P009027', 'ACTIVE', 'EA', 75752, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (428, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-28', 'Product_009_028', 'P009028', 'ACTIVE', 'EA', 84394, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (429, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-29', 'Product_009_029', 'P009029', 'ACTIVE', 'EA', 24069, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (430, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-30', 'Product_009_030', 'P009030', 'ACTIVE', 'EA', 83459, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (431, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-31', 'Product_009_031', 'P009031', 'ACTIVE', 'EA', 1733, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (432, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-32', 'Product_009_032', 'P009032', 'ACTIVE', 'EA', 68701, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (433, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-33', 'Product_009_033', 'P009033', 'ACTIVE', 'EA', 96967, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (434, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-34', 'Product_009_034', 'P009034', 'ACTIVE', 'EA', 95437, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (435, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-35', 'Product_009_035', 'P009035', 'ACTIVE', 'EA', 37212, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (436, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-36', 'Product_009_036', 'P009036', 'ACTIVE', 'EA', 4113, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (437, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-37', 'Product_009_037', 'P009037', 'ACTIVE', 'EA', 63824, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (438, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-38', 'Product_009_038', 'P009038', 'ACTIVE', 'EA', 44555, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (439, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-39', 'Product_009_039', 'P009039', 'ACTIVE', 'EA', 91940, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (440, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-40', 'Product_009_040', 'P009040', 'ACTIVE', 'EA', 83731, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (441, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-41', 'Product_009_041', 'P009041', 'ACTIVE', 'EA', 27426, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (442, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-42', 'Product_009_042', 'P009042', 'ACTIVE', 'EA', 82999, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (443, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-43', 'Product_009_043', 'P009043', 'ACTIVE', 'EA', 40611, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (444, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-44', 'Product_009_044', 'P009044', 'ACTIVE', 'EA', 4686, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (445, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-45', 'Product_009_045', 'P009045', 'ACTIVE', 'EA', 96305, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (446, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-46', 'Product_009_046', 'P009046', 'ACTIVE', 'EA', 53127, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (447, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-47', 'Product_009_047', 'P009047', 'ACTIVE', 'EA', 49106, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (448, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-48', 'Product_009_048', 'P009048', 'ACTIVE', 'EA', 29228, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (449, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-49', 'Product_009_049', 'P009049', 'ACTIVE', 'EA', 74562, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (450, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'Product description 9-50', 'Product_009_050', 'P009050', 'ACTIVE', 'EA', 33824, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (451, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-1', 'Product_010_001', 'P010001', 'ACTIVE', 'EA', 31205, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (452, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-2', 'Product_010_002', 'P010002', 'ACTIVE', 'EA', 13095, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (453, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-3', 'Product_010_003', 'P010003', 'ACTIVE', 'EA', 27742, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (454, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-4', 'Product_010_004', 'P010004', 'ACTIVE', 'EA', 33934, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (455, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-5', 'Product_010_005', 'P010005', 'ACTIVE', 'EA', 74362, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (456, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-6', 'Product_010_006', 'P010006', 'ACTIVE', 'EA', 1766, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (457, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-7', 'Product_010_007', 'P010007', 'ACTIVE', 'EA', 3169, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (458, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-8', 'Product_010_008', 'P010008', 'ACTIVE', 'EA', 20835, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (459, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-9', 'Product_010_009', 'P010009', 'ACTIVE', 'EA', 74854, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (460, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-10', 'Product_010_010', 'P010010', 'ACTIVE', 'EA', 77288, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (461, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-11', 'Product_010_011', 'P010011', 'ACTIVE', 'EA', 18472, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (462, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-12', 'Product_010_012', 'P010012', 'ACTIVE', 'EA', 44042, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (463, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-13', 'Product_010_013', 'P010013', 'ACTIVE', 'EA', 28943, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (464, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-14', 'Product_010_014', 'P010014', 'ACTIVE', 'EA', 17830, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (465, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-15', 'Product_010_015', 'P010015', 'ACTIVE', 'EA', 80885, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (466, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-16', 'Product_010_016', 'P010016', 'ACTIVE', 'EA', 82656, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (467, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-17', 'Product_010_017', 'P010017', 'ACTIVE', 'EA', 41174, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (468, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-18', 'Product_010_018', 'P010018', 'ACTIVE', 'EA', 67873, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (469, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-19', 'Product_010_019', 'P010019', 'ACTIVE', 'EA', 38462, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (470, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-20', 'Product_010_020', 'P010020', 'ACTIVE', 'EA', 4800, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (471, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-21', 'Product_010_021', 'P010021', 'ACTIVE', 'EA', 28540, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (472, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-22', 'Product_010_022', 'P010022', 'ACTIVE', 'EA', 57195, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (473, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-23', 'Product_010_023', 'P010023', 'ACTIVE', 'EA', 52553, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (474, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-24', 'Product_010_024', 'P010024', 'ACTIVE', 'EA', 90418, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (475, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-25', 'Product_010_025', 'P010025', 'ACTIVE', 'EA', 77158, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (476, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-26', 'Product_010_026', 'P010026', 'ACTIVE', 'EA', 53631, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (477, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-27', 'Product_010_027', 'P010027', 'ACTIVE', 'EA', 85731, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (478, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-28', 'Product_010_028', 'P010028', 'ACTIVE', 'EA', 84940, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (479, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-29', 'Product_010_029', 'P010029', 'ACTIVE', 'EA', 96397, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (480, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-30', 'Product_010_030', 'P010030', 'ACTIVE', 'EA', 87573, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (481, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-31', 'Product_010_031', 'P010031', 'ACTIVE', 'EA', 58692, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (482, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-32', 'Product_010_032', 'P010032', 'ACTIVE', 'EA', 75814, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (483, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-33', 'Product_010_033', 'P010033', 'ACTIVE', 'EA', 74724, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (484, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-34', 'Product_010_034', 'P010034', 'ACTIVE', 'EA', 37697, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (485, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-35', 'Product_010_035', 'P010035', 'ACTIVE', 'EA', 66807, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (486, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-36', 'Product_010_036', 'P010036', 'ACTIVE', 'EA', 38023, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (487, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-37', 'Product_010_037', 'P010037', 'ACTIVE', 'EA', 71409, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (488, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-38', 'Product_010_038', 'P010038', 'ACTIVE', 'EA', 10585, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (489, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-39', 'Product_010_039', 'P010039', 'ACTIVE', 'EA', 87287, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (490, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-40', 'Product_010_040', 'P010040', 'ACTIVE', 'EA', 63559, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (491, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-41', 'Product_010_041', 'P010041', 'ACTIVE', 'EA', 93005, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (492, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-42', 'Product_010_042', 'P010042', 'ACTIVE', 'EA', 64248, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (493, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-43', 'Product_010_043', 'P010043', 'ACTIVE', 'EA', 86056, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (494, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-44', 'Product_010_044', 'P010044', 'ACTIVE', 'EA', 21796, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (495, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-45', 'Product_010_045', 'P010045', 'ACTIVE', 'EA', 56312, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (496, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-46', 'Product_010_046', 'P010046', 'ACTIVE', 'EA', 7226, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (497, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-47', 'Product_010_047', 'P010047', 'ACTIVE', 'EA', 93210, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (498, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-48', 'Product_010_048', 'P010048', 'ACTIVE', 'EA', 13888, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (499, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-49', 'Product_010_049', 'P010049', 'ACTIVE', 'EA', 97038, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (500, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'Product description 10-50', 'Product_010_050', 'P010050', 'ACTIVE', 'EA', 16628, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (501, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-1', 'Product_011_001', 'P011001', 'ACTIVE', 'EA', 35912, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (502, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-2', 'Product_011_002', 'P011002', 'ACTIVE', 'EA', 87963, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (503, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-3', 'Product_011_003', 'P011003', 'ACTIVE', 'EA', 42250, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (504, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-4', 'Product_011_004', 'P011004', 'ACTIVE', 'EA', 55096, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (505, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-5', 'Product_011_005', 'P011005', 'ACTIVE', 'EA', 96938, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (506, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-6', 'Product_011_006', 'P011006', 'ACTIVE', 'EA', 52428, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (507, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-7', 'Product_011_007', 'P011007', 'ACTIVE', 'EA', 63496, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (508, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-8', 'Product_011_008', 'P011008', 'ACTIVE', 'EA', 13150, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (509, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-9', 'Product_011_009', 'P011009', 'ACTIVE', 'EA', 52086, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (510, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-10', 'Product_011_010', 'P011010', 'ACTIVE', 'EA', 91228, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (511, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-11', 'Product_011_011', 'P011011', 'ACTIVE', 'EA', 85199, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (512, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-12', 'Product_011_012', 'P011012', 'ACTIVE', 'EA', 16882, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (513, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-13', 'Product_011_013', 'P011013', 'ACTIVE', 'EA', 97923, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (514, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-14', 'Product_011_014', 'P011014', 'ACTIVE', 'EA', 57478, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (515, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-15', 'Product_011_015', 'P011015', 'ACTIVE', 'EA', 31130, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (516, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-16', 'Product_011_016', 'P011016', 'ACTIVE', 'EA', 82353, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (517, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-17', 'Product_011_017', 'P011017', 'ACTIVE', 'EA', 1956, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (518, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-18', 'Product_011_018', 'P011018', 'ACTIVE', 'EA', 99448, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (519, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-19', 'Product_011_019', 'P011019', 'ACTIVE', 'EA', 61142, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (520, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-20', 'Product_011_020', 'P011020', 'ACTIVE', 'EA', 21384, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (521, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-21', 'Product_011_021', 'P011021', 'ACTIVE', 'EA', 83174, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (522, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-22', 'Product_011_022', 'P011022', 'ACTIVE', 'EA', 2877, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (523, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-23', 'Product_011_023', 'P011023', 'ACTIVE', 'EA', 47655, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (524, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-24', 'Product_011_024', 'P011024', 'ACTIVE', 'EA', 21987, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (525, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-25', 'Product_011_025', 'P011025', 'ACTIVE', 'EA', 89988, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (526, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-26', 'Product_011_026', 'P011026', 'ACTIVE', 'EA', 36371, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (527, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-27', 'Product_011_027', 'P011027', 'ACTIVE', 'EA', 19932, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (528, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-28', 'Product_011_028', 'P011028', 'ACTIVE', 'EA', 51759, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (529, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-29', 'Product_011_029', 'P011029', 'ACTIVE', 'EA', 22023, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (530, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-30', 'Product_011_030', 'P011030', 'ACTIVE', 'EA', 41894, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (531, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-31', 'Product_011_031', 'P011031', 'ACTIVE', 'EA', 43271, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (532, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-32', 'Product_011_032', 'P011032', 'ACTIVE', 'EA', 83216, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (533, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-33', 'Product_011_033', 'P011033', 'ACTIVE', 'EA', 79751, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (534, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-34', 'Product_011_034', 'P011034', 'ACTIVE', 'EA', 42443, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (535, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-35', 'Product_011_035', 'P011035', 'ACTIVE', 'EA', 57348, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (536, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-36', 'Product_011_036', 'P011036', 'ACTIVE', 'EA', 6139, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (537, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-37', 'Product_011_037', 'P011037', 'ACTIVE', 'EA', 47423, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (538, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-38', 'Product_011_038', 'P011038', 'ACTIVE', 'EA', 33149, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (539, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-39', 'Product_011_039', 'P011039', 'ACTIVE', 'EA', 91531, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (540, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-40', 'Product_011_040', 'P011040', 'ACTIVE', 'EA', 79714, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (541, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-41', 'Product_011_041', 'P011041', 'ACTIVE', 'EA', 61004, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (542, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-42', 'Product_011_042', 'P011042', 'ACTIVE', 'EA', 4504, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (543, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-43', 'Product_011_043', 'P011043', 'ACTIVE', 'EA', 46468, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (544, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-44', 'Product_011_044', 'P011044', 'ACTIVE', 'EA', 88988, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (545, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-45', 'Product_011_045', 'P011045', 'ACTIVE', 'EA', 52401, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (546, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-46', 'Product_011_046', 'P011046', 'ACTIVE', 'EA', 66250, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (547, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-47', 'Product_011_047', 'P011047', 'ACTIVE', 'EA', 18972, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (548, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-48', 'Product_011_048', 'P011048', 'ACTIVE', 'EA', 80567, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (549, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-49', 'Product_011_049', 'P011049', 'ACTIVE', 'EA', 50025, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (550, '2024-07-12 09:00:00', '2024-07-12 09:00:00', 'Product description 11-50', 'Product_011_050', 'P011050', 'ACTIVE', 'EA', 91436, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (551, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-1', 'Product_012_001', 'P012001', 'ACTIVE', 'EA', 75421, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (552, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-2', 'Product_012_002', 'P012002', 'ACTIVE', 'EA', 40147, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (553, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-3', 'Product_012_003', 'P012003', 'ACTIVE', 'EA', 72759, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (554, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-4', 'Product_012_004', 'P012004', 'ACTIVE', 'EA', 18339, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (555, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-5', 'Product_012_005', 'P012005', 'ACTIVE', 'EA', 66391, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (556, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-6', 'Product_012_006', 'P012006', 'ACTIVE', 'EA', 60169, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (557, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-7', 'Product_012_007', 'P012007', 'ACTIVE', 'EA', 91692, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (558, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-8', 'Product_012_008', 'P012008', 'ACTIVE', 'EA', 2461, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (559, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-9', 'Product_012_009', 'P012009', 'ACTIVE', 'EA', 62115, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (560, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-10', 'Product_012_010', 'P012010', 'ACTIVE', 'EA', 99971, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (561, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-11', 'Product_012_011', 'P012011', 'ACTIVE', 'EA', 49181, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (562, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-12', 'Product_012_012', 'P012012', 'ACTIVE', 'EA', 31245, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (563, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-13', 'Product_012_013', 'P012013', 'ACTIVE', 'EA', 54668, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (564, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-14', 'Product_012_014', 'P012014', 'ACTIVE', 'EA', 62839, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (565, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-15', 'Product_012_015', 'P012015', 'ACTIVE', 'EA', 30547, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (566, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-16', 'Product_012_016', 'P012016', 'ACTIVE', 'EA', 81833, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (567, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-17', 'Product_012_017', 'P012017', 'ACTIVE', 'EA', 67612, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (568, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-18', 'Product_012_018', 'P012018', 'ACTIVE', 'EA', 45571, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (569, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-19', 'Product_012_019', 'P012019', 'ACTIVE', 'EA', 65433, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (570, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-20', 'Product_012_020', 'P012020', 'ACTIVE', 'EA', 39729, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (571, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-21', 'Product_012_021', 'P012021', 'ACTIVE', 'EA', 79010, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (572, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-22', 'Product_012_022', 'P012022', 'ACTIVE', 'EA', 30962, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (573, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-23', 'Product_012_023', 'P012023', 'ACTIVE', 'EA', 55450, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (574, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-24', 'Product_012_024', 'P012024', 'ACTIVE', 'EA', 42895, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (575, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-25', 'Product_012_025', 'P012025', 'ACTIVE', 'EA', 13777, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (576, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-26', 'Product_012_026', 'P012026', 'ACTIVE', 'EA', 20653, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (577, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-27', 'Product_012_027', 'P012027', 'ACTIVE', 'EA', 25341, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (578, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-28', 'Product_012_028', 'P012028', 'ACTIVE', 'EA', 70970, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (579, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-29', 'Product_012_029', 'P012029', 'ACTIVE', 'EA', 7066, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (580, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-30', 'Product_012_030', 'P012030', 'ACTIVE', 'EA', 93716, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (581, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-31', 'Product_012_031', 'P012031', 'ACTIVE', 'EA', 90923, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (582, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-32', 'Product_012_032', 'P012032', 'ACTIVE', 'EA', 99914, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (583, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-33', 'Product_012_033', 'P012033', 'ACTIVE', 'EA', 17114, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (584, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-34', 'Product_012_034', 'P012034', 'ACTIVE', 'EA', 51723, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (585, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-35', 'Product_012_035', 'P012035', 'ACTIVE', 'EA', 17404, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (586, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-36', 'Product_012_036', 'P012036', 'ACTIVE', 'EA', 49563, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (587, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-37', 'Product_012_037', 'P012037', 'ACTIVE', 'EA', 9408, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (588, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-38', 'Product_012_038', 'P012038', 'ACTIVE', 'EA', 27267, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (589, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-39', 'Product_012_039', 'P012039', 'ACTIVE', 'EA', 87386, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (590, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-40', 'Product_012_040', 'P012040', 'ACTIVE', 'EA', 29189, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (591, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-41', 'Product_012_041', 'P012041', 'ACTIVE', 'EA', 1150, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (592, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-42', 'Product_012_042', 'P012042', 'ACTIVE', 'EA', 13536, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (593, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-43', 'Product_012_043', 'P012043', 'ACTIVE', 'EA', 45179, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (594, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-44', 'Product_012_044', 'P012044', 'ACTIVE', 'EA', 35188, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (595, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-45', 'Product_012_045', 'P012045', 'ACTIVE', 'EA', 78026, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (596, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-46', 'Product_012_046', 'P012046', 'ACTIVE', 'EA', 33637, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (597, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-47', 'Product_012_047', 'P012047', 'ACTIVE', 'EA', 86515, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (598, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-48', 'Product_012_048', 'P012048', 'ACTIVE', 'EA', 71551, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (599, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-49', 'Product_012_049', 'P012049', 'ACTIVE', 'EA', 81687, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (600, '2024-07-13 09:00:00', '2024-07-13 09:00:00', 'Product description 12-50', 'Product_012_050', 'P012050', 'ACTIVE', 'EA', 37292, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (601, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-1', 'Product_013_001', 'P013001', 'ACTIVE', 'EA', 81407, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (602, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-2', 'Product_013_002', 'P013002', 'ACTIVE', 'EA', 76111, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (603, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-3', 'Product_013_003', 'P013003', 'ACTIVE', 'EA', 41702, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (604, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-4', 'Product_013_004', 'P013004', 'ACTIVE', 'EA', 46444, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (605, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-5', 'Product_013_005', 'P013005', 'ACTIVE', 'EA', 42286, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (606, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-6', 'Product_013_006', 'P013006', 'ACTIVE', 'EA', 52341, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (607, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-7', 'Product_013_007', 'P013007', 'ACTIVE', 'EA', 3808, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (608, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-8', 'Product_013_008', 'P013008', 'ACTIVE', 'EA', 77154, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (609, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-9', 'Product_013_009', 'P013009', 'ACTIVE', 'EA', 16867, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (610, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-10', 'Product_013_010', 'P013010', 'ACTIVE', 'EA', 78163, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (611, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-11', 'Product_013_011', 'P013011', 'ACTIVE', 'EA', 58432, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (612, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-12', 'Product_013_012', 'P013012', 'ACTIVE', 'EA', 58705, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (613, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-13', 'Product_013_013', 'P013013', 'ACTIVE', 'EA', 85111, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (614, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-14', 'Product_013_014', 'P013014', 'ACTIVE', 'EA', 42356, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (615, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-15', 'Product_013_015', 'P013015', 'ACTIVE', 'EA', 31891, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (616, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-16', 'Product_013_016', 'P013016', 'ACTIVE', 'EA', 34438, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (617, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-17', 'Product_013_017', 'P013017', 'ACTIVE', 'EA', 14032, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (618, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-18', 'Product_013_018', 'P013018', 'ACTIVE', 'EA', 23440, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (619, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-19', 'Product_013_019', 'P013019', 'ACTIVE', 'EA', 90776, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (620, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-20', 'Product_013_020', 'P013020', 'ACTIVE', 'EA', 39003, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (621, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-21', 'Product_013_021', 'P013021', 'ACTIVE', 'EA', 89109, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (622, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-22', 'Product_013_022', 'P013022', 'ACTIVE', 'EA', 8973, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (623, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-23', 'Product_013_023', 'P013023', 'ACTIVE', 'EA', 66586, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (624, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-24', 'Product_013_024', 'P013024', 'ACTIVE', 'EA', 17865, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (625, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-25', 'Product_013_025', 'P013025', 'ACTIVE', 'EA', 19474, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (626, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-26', 'Product_013_026', 'P013026', 'ACTIVE', 'EA', 70182, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (627, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-27', 'Product_013_027', 'P013027', 'ACTIVE', 'EA', 26809, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (628, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-28', 'Product_013_028', 'P013028', 'ACTIVE', 'EA', 92908, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (629, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-29', 'Product_013_029', 'P013029', 'ACTIVE', 'EA', 36140, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (630, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-30', 'Product_013_030', 'P013030', 'ACTIVE', 'EA', 28655, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (631, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-31', 'Product_013_031', 'P013031', 'ACTIVE', 'EA', 34450, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (632, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-32', 'Product_013_032', 'P013032', 'ACTIVE', 'EA', 47982, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (633, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-33', 'Product_013_033', 'P013033', 'ACTIVE', 'EA', 7181, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (634, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-34', 'Product_013_034', 'P013034', 'ACTIVE', 'EA', 11433, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (635, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-35', 'Product_013_035', 'P013035', 'ACTIVE', 'EA', 92917, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (636, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-36', 'Product_013_036', 'P013036', 'ACTIVE', 'EA', 19526, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (637, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-37', 'Product_013_037', 'P013037', 'ACTIVE', 'EA', 98141, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (638, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-38', 'Product_013_038', 'P013038', 'ACTIVE', 'EA', 31576, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (639, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-39', 'Product_013_039', 'P013039', 'ACTIVE', 'EA', 94285, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (640, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-40', 'Product_013_040', 'P013040', 'ACTIVE', 'EA', 6849, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (641, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-41', 'Product_013_041', 'P013041', 'ACTIVE', 'EA', 19267, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (642, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-42', 'Product_013_042', 'P013042', 'ACTIVE', 'EA', 3578, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (643, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-43', 'Product_013_043', 'P013043', 'ACTIVE', 'EA', 5690, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (644, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-44', 'Product_013_044', 'P013044', 'ACTIVE', 'EA', 19868, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (645, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-45', 'Product_013_045', 'P013045', 'ACTIVE', 'EA', 50544, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (646, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-46', 'Product_013_046', 'P013046', 'ACTIVE', 'EA', 56623, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (647, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-47', 'Product_013_047', 'P013047', 'ACTIVE', 'EA', 76963, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (648, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-48', 'Product_013_048', 'P013048', 'ACTIVE', 'EA', 56161, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (649, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-49', 'Product_013_049', 'P013049', 'ACTIVE', 'EA', 4231, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (650, '2024-07-14 09:00:00', '2024-07-14 09:00:00', 'Product description 13-50', 'Product_013_050', 'P013050', 'ACTIVE', 'EA', 23699, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (651, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-1', 'Product_014_001', 'P014001', 'ACTIVE', 'EA', 21238, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (652, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-2', 'Product_014_002', 'P014002', 'ACTIVE', 'EA', 89185, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (653, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-3', 'Product_014_003', 'P014003', 'ACTIVE', 'EA', 67850, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (654, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-4', 'Product_014_004', 'P014004', 'ACTIVE', 'EA', 68722, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (655, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-5', 'Product_014_005', 'P014005', 'ACTIVE', 'EA', 19911, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (656, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-6', 'Product_014_006', 'P014006', 'ACTIVE', 'EA', 65478, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (657, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-7', 'Product_014_007', 'P014007', 'ACTIVE', 'EA', 14729, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (658, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-8', 'Product_014_008', 'P014008', 'ACTIVE', 'EA', 47719, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (659, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-9', 'Product_014_009', 'P014009', 'ACTIVE', 'EA', 99012, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (660, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-10', 'Product_014_010', 'P014010', 'ACTIVE', 'EA', 10813, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (661, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-11', 'Product_014_011', 'P014011', 'ACTIVE', 'EA', 98194, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (662, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-12', 'Product_014_012', 'P014012', 'ACTIVE', 'EA', 21441, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (663, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-13', 'Product_014_013', 'P014013', 'ACTIVE', 'EA', 3939, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (664, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-14', 'Product_014_014', 'P014014', 'ACTIVE', 'EA', 10418, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (665, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-15', 'Product_014_015', 'P014015', 'ACTIVE', 'EA', 47442, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (666, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-16', 'Product_014_016', 'P014016', 'ACTIVE', 'EA', 18320, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (667, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-17', 'Product_014_017', 'P014017', 'ACTIVE', 'EA', 48297, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (668, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-18', 'Product_014_018', 'P014018', 'ACTIVE', 'EA', 45835, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (669, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-19', 'Product_014_019', 'P014019', 'ACTIVE', 'EA', 28769, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (670, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-20', 'Product_014_020', 'P014020', 'ACTIVE', 'EA', 39605, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (671, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-21', 'Product_014_021', 'P014021', 'ACTIVE', 'EA', 26666, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (672, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-22', 'Product_014_022', 'P014022', 'ACTIVE', 'EA', 71976, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (673, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-23', 'Product_014_023', 'P014023', 'ACTIVE', 'EA', 44455, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (674, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-24', 'Product_014_024', 'P014024', 'ACTIVE', 'EA', 54184, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (675, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-25', 'Product_014_025', 'P014025', 'ACTIVE', 'EA', 10271, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (676, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-26', 'Product_014_026', 'P014026', 'ACTIVE', 'EA', 44458, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (677, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-27', 'Product_014_027', 'P014027', 'ACTIVE', 'EA', 22299, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (678, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-28', 'Product_014_028', 'P014028', 'ACTIVE', 'EA', 33937, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (679, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-29', 'Product_014_029', 'P014029', 'ACTIVE', 'EA', 62934, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (680, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-30', 'Product_014_030', 'P014030', 'ACTIVE', 'EA', 73377, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (681, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-31', 'Product_014_031', 'P014031', 'ACTIVE', 'EA', 23227, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (682, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-32', 'Product_014_032', 'P014032', 'ACTIVE', 'EA', 74076, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (683, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-33', 'Product_014_033', 'P014033', 'ACTIVE', 'EA', 94803, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (684, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-34', 'Product_014_034', 'P014034', 'ACTIVE', 'EA', 18301, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (685, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-35', 'Product_014_035', 'P014035', 'ACTIVE', 'EA', 51416, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (686, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-36', 'Product_014_036', 'P014036', 'ACTIVE', 'EA', 4225, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (687, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-37', 'Product_014_037', 'P014037', 'ACTIVE', 'EA', 59240, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (688, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-38', 'Product_014_038', 'P014038', 'ACTIVE', 'EA', 20231, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (689, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-39', 'Product_014_039', 'P014039', 'ACTIVE', 'EA', 34577, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (690, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-40', 'Product_014_040', 'P014040', 'ACTIVE', 'EA', 18870, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (691, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-41', 'Product_014_041', 'P014041', 'ACTIVE', 'EA', 90608, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (692, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-42', 'Product_014_042', 'P014042', 'ACTIVE', 'EA', 21249, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (693, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-43', 'Product_014_043', 'P014043', 'ACTIVE', 'EA', 73810, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (694, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-44', 'Product_014_044', 'P014044', 'ACTIVE', 'EA', 97257, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (695, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-45', 'Product_014_045', 'P014045', 'ACTIVE', 'EA', 79652, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (696, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-46', 'Product_014_046', 'P014046', 'ACTIVE', 'EA', 34142, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (697, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-47', 'Product_014_047', 'P014047', 'ACTIVE', 'EA', 91648, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (698, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-48', 'Product_014_048', 'P014048', 'ACTIVE', 'EA', 34510, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (699, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-49', 'Product_014_049', 'P014049', 'ACTIVE', 'EA', 38986, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (700, '2024-07-15 09:00:00', '2024-07-15 09:00:00', 'Product description 14-50', 'Product_014_050', 'P014050', 'ACTIVE', 'EA', 93084, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (701, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-1', 'Product_015_001', 'P015001', 'ACTIVE', 'EA', 1299, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (702, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-2', 'Product_015_002', 'P015002', 'ACTIVE', 'EA', 68834, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (703, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-3', 'Product_015_003', 'P015003', 'ACTIVE', 'EA', 75005, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (704, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-4', 'Product_015_004', 'P015004', 'ACTIVE', 'EA', 49305, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (705, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-5', 'Product_015_005', 'P015005', 'ACTIVE', 'EA', 94252, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (706, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-6', 'Product_015_006', 'P015006', 'ACTIVE', 'EA', 53572, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (707, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-7', 'Product_015_007', 'P015007', 'ACTIVE', 'EA', 73494, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (708, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-8', 'Product_015_008', 'P015008', 'ACTIVE', 'EA', 27523, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (709, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-9', 'Product_015_009', 'P015009', 'ACTIVE', 'EA', 50377, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (710, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-10', 'Product_015_010', 'P015010', 'ACTIVE', 'EA', 14216, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (711, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-11', 'Product_015_011', 'P015011', 'ACTIVE', 'EA', 15285, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (712, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-12', 'Product_015_012', 'P015012', 'ACTIVE', 'EA', 84927, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (713, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-13', 'Product_015_013', 'P015013', 'ACTIVE', 'EA', 71681, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (714, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-14', 'Product_015_014', 'P015014', 'ACTIVE', 'EA', 23262, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (715, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-15', 'Product_015_015', 'P015015', 'ACTIVE', 'EA', 61807, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (716, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-16', 'Product_015_016', 'P015016', 'ACTIVE', 'EA', 66773, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (717, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-17', 'Product_015_017', 'P015017', 'ACTIVE', 'EA', 25212, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (718, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-18', 'Product_015_018', 'P015018', 'ACTIVE', 'EA', 10831, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (719, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-19', 'Product_015_019', 'P015019', 'ACTIVE', 'EA', 87804, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (720, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-20', 'Product_015_020', 'P015020', 'ACTIVE', 'EA', 77892, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (721, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-21', 'Product_015_021', 'P015021', 'ACTIVE', 'EA', 15295, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (722, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-22', 'Product_015_022', 'P015022', 'ACTIVE', 'EA', 15129, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (723, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-23', 'Product_015_023', 'P015023', 'ACTIVE', 'EA', 55035, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (724, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-24', 'Product_015_024', 'P015024', 'ACTIVE', 'EA', 20933, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (725, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-25', 'Product_015_025', 'P015025', 'ACTIVE', 'EA', 95252, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (726, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-26', 'Product_015_026', 'P015026', 'ACTIVE', 'EA', 6955, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (727, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-27', 'Product_015_027', 'P015027', 'ACTIVE', 'EA', 59875, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (728, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-28', 'Product_015_028', 'P015028', 'ACTIVE', 'EA', 84420, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (729, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-29', 'Product_015_029', 'P015029', 'ACTIVE', 'EA', 16868, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (730, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-30', 'Product_015_030', 'P015030', 'ACTIVE', 'EA', 53975, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (731, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-31', 'Product_015_031', 'P015031', 'ACTIVE', 'EA', 34829, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (732, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-32', 'Product_015_032', 'P015032', 'ACTIVE', 'EA', 38435, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (733, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-33', 'Product_015_033', 'P015033', 'ACTIVE', 'EA', 18347, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (734, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-34', 'Product_015_034', 'P015034', 'ACTIVE', 'EA', 69680, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (735, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-35', 'Product_015_035', 'P015035', 'ACTIVE', 'EA', 69309, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (736, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-36', 'Product_015_036', 'P015036', 'ACTIVE', 'EA', 30512, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (737, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-37', 'Product_015_037', 'P015037', 'ACTIVE', 'EA', 98278, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (738, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-38', 'Product_015_038', 'P015038', 'ACTIVE', 'EA', 24110, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (739, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-39', 'Product_015_039', 'P015039', 'ACTIVE', 'EA', 84502, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (740, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-40', 'Product_015_040', 'P015040', 'ACTIVE', 'EA', 13832, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (741, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-41', 'Product_015_041', 'P015041', 'ACTIVE', 'EA', 56948, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (742, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-42', 'Product_015_042', 'P015042', 'ACTIVE', 'EA', 20305, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (743, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-43', 'Product_015_043', 'P015043', 'ACTIVE', 'EA', 37498, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (744, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-44', 'Product_015_044', 'P015044', 'ACTIVE', 'EA', 32971, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (745, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-45', 'Product_015_045', 'P015045', 'ACTIVE', 'EA', 16693, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (746, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-46', 'Product_015_046', 'P015046', 'ACTIVE', 'EA', 88977, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (747, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-47', 'Product_015_047', 'P015047', 'ACTIVE', 'EA', 42160, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (748, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-48', 'Product_015_048', 'P015048', 'ACTIVE', 'EA', 87980, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (749, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-49', 'Product_015_049', 'P015049', 'ACTIVE', 'EA', 52918, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (750, '2024-07-16 09:00:00', '2024-07-16 09:00:00', 'Product description 15-50', 'Product_015_050', 'P015050', 'ACTIVE', 'EA', 74166, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (751, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-1', 'Product_016_001', 'P016001', 'ACTIVE', 'EA', 97997, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (752, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-2', 'Product_016_002', 'P016002', 'ACTIVE', 'EA', 78185, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (753, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-3', 'Product_016_003', 'P016003', 'ACTIVE', 'EA', 35516, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (754, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-4', 'Product_016_004', 'P016004', 'ACTIVE', 'EA', 28983, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (755, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-5', 'Product_016_005', 'P016005', 'ACTIVE', 'EA', 49960, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (756, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-6', 'Product_016_006', 'P016006', 'ACTIVE', 'EA', 52184, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (757, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-7', 'Product_016_007', 'P016007', 'ACTIVE', 'EA', 41598, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (758, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-8', 'Product_016_008', 'P016008', 'ACTIVE', 'EA', 1686, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (759, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-9', 'Product_016_009', 'P016009', 'ACTIVE', 'EA', 39229, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (760, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-10', 'Product_016_010', 'P016010', 'ACTIVE', 'EA', 94265, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (761, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-11', 'Product_016_011', 'P016011', 'ACTIVE', 'EA', 93990, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (762, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-12', 'Product_016_012', 'P016012', 'ACTIVE', 'EA', 81429, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (763, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-13', 'Product_016_013', 'P016013', 'ACTIVE', 'EA', 57790, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (764, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-14', 'Product_016_014', 'P016014', 'ACTIVE', 'EA', 60101, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (765, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-15', 'Product_016_015', 'P016015', 'ACTIVE', 'EA', 55849, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (766, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-16', 'Product_016_016', 'P016016', 'ACTIVE', 'EA', 64620, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (767, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-17', 'Product_016_017', 'P016017', 'ACTIVE', 'EA', 14781, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (768, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-18', 'Product_016_018', 'P016018', 'ACTIVE', 'EA', 63186, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (769, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-19', 'Product_016_019', 'P016019', 'ACTIVE', 'EA', 63200, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (770, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-20', 'Product_016_020', 'P016020', 'ACTIVE', 'EA', 29852, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (771, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-21', 'Product_016_021', 'P016021', 'ACTIVE', 'EA', 78046, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (772, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-22', 'Product_016_022', 'P016022', 'ACTIVE', 'EA', 7034, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (773, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-23', 'Product_016_023', 'P016023', 'ACTIVE', 'EA', 46910, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (774, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-24', 'Product_016_024', 'P016024', 'ACTIVE', 'EA', 23890, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (775, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-25', 'Product_016_025', 'P016025', 'ACTIVE', 'EA', 67483, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (776, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-26', 'Product_016_026', 'P016026', 'ACTIVE', 'EA', 25860, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (777, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-27', 'Product_016_027', 'P016027', 'ACTIVE', 'EA', 29678, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (778, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-28', 'Product_016_028', 'P016028', 'ACTIVE', 'EA', 99433, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (779, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-29', 'Product_016_029', 'P016029', 'ACTIVE', 'EA', 11095, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (780, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-30', 'Product_016_030', 'P016030', 'ACTIVE', 'EA', 77387, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (781, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-31', 'Product_016_031', 'P016031', 'ACTIVE', 'EA', 73699, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (782, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-32', 'Product_016_032', 'P016032', 'ACTIVE', 'EA', 28348, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (783, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-33', 'Product_016_033', 'P016033', 'ACTIVE', 'EA', 24256, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (784, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-34', 'Product_016_034', 'P016034', 'ACTIVE', 'EA', 18303, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (785, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-35', 'Product_016_035', 'P016035', 'ACTIVE', 'EA', 23985, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (786, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-36', 'Product_016_036', 'P016036', 'ACTIVE', 'EA', 85138, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (787, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-37', 'Product_016_037', 'P016037', 'ACTIVE', 'EA', 1610, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (788, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-38', 'Product_016_038', 'P016038', 'ACTIVE', 'EA', 14366, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (789, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-39', 'Product_016_039', 'P016039', 'ACTIVE', 'EA', 17907, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (790, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-40', 'Product_016_040', 'P016040', 'ACTIVE', 'EA', 2884, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (791, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-41', 'Product_016_041', 'P016041', 'ACTIVE', 'EA', 8693, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (792, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-42', 'Product_016_042', 'P016042', 'ACTIVE', 'EA', 35267, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (793, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-43', 'Product_016_043', 'P016043', 'ACTIVE', 'EA', 16994, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (794, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-44', 'Product_016_044', 'P016044', 'ACTIVE', 'EA', 70876, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (795, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-45', 'Product_016_045', 'P016045', 'ACTIVE', 'EA', 40136, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (796, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-46', 'Product_016_046', 'P016046', 'ACTIVE', 'EA', 2700, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (797, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-47', 'Product_016_047', 'P016047', 'ACTIVE', 'EA', 64115, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (798, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-48', 'Product_016_048', 'P016048', 'ACTIVE', 'EA', 80742, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (799, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-49', 'Product_016_049', 'P016049', 'ACTIVE', 'EA', 77631, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (800, '2024-07-17 09:00:00', '2024-07-17 09:00:00', 'Product description 16-50', 'Product_016_050', 'P016050', 'ACTIVE', 'EA', 30459, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (801, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-1', 'Product_017_001', 'P017001', 'ACTIVE', 'EA', 45362, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (802, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-2', 'Product_017_002', 'P017002', 'ACTIVE', 'EA', 84343, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (803, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-3', 'Product_017_003', 'P017003', 'ACTIVE', 'EA', 13208, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (804, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-4', 'Product_017_004', 'P017004', 'ACTIVE', 'EA', 4285, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (805, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-5', 'Product_017_005', 'P017005', 'ACTIVE', 'EA', 2710, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (806, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-6', 'Product_017_006', 'P017006', 'ACTIVE', 'EA', 85833, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (807, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-7', 'Product_017_007', 'P017007', 'ACTIVE', 'EA', 54994, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (808, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-8', 'Product_017_008', 'P017008', 'ACTIVE', 'EA', 14079, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (809, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-9', 'Product_017_009', 'P017009', 'ACTIVE', 'EA', 41518, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (810, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-10', 'Product_017_010', 'P017010', 'ACTIVE', 'EA', 59146, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (811, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-11', 'Product_017_011', 'P017011', 'ACTIVE', 'EA', 10171, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (812, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-12', 'Product_017_012', 'P017012', 'ACTIVE', 'EA', 10629, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (813, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-13', 'Product_017_013', 'P017013', 'ACTIVE', 'EA', 51279, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (814, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-14', 'Product_017_014', 'P017014', 'ACTIVE', 'EA', 21446, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (815, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-15', 'Product_017_015', 'P017015', 'ACTIVE', 'EA', 60137, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (816, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-16', 'Product_017_016', 'P017016', 'ACTIVE', 'EA', 43987, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (817, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-17', 'Product_017_017', 'P017017', 'ACTIVE', 'EA', 62546, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (818, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-18', 'Product_017_018', 'P017018', 'ACTIVE', 'EA', 97965, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (819, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-19', 'Product_017_019', 'P017019', 'ACTIVE', 'EA', 87391, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (820, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-20', 'Product_017_020', 'P017020', 'ACTIVE', 'EA', 19839, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (821, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-21', 'Product_017_021', 'P017021', 'ACTIVE', 'EA', 84049, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (822, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-22', 'Product_017_022', 'P017022', 'ACTIVE', 'EA', 69621, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (823, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-23', 'Product_017_023', 'P017023', 'ACTIVE', 'EA', 50188, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (824, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-24', 'Product_017_024', 'P017024', 'ACTIVE', 'EA', 33574, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (825, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-25', 'Product_017_025', 'P017025', 'ACTIVE', 'EA', 54846, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (826, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-26', 'Product_017_026', 'P017026', 'ACTIVE', 'EA', 19894, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (827, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-27', 'Product_017_027', 'P017027', 'ACTIVE', 'EA', 57697, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (828, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-28', 'Product_017_028', 'P017028', 'ACTIVE', 'EA', 90821, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (829, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-29', 'Product_017_029', 'P017029', 'ACTIVE', 'EA', 47815, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (830, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-30', 'Product_017_030', 'P017030', 'ACTIVE', 'EA', 93234, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (831, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-31', 'Product_017_031', 'P017031', 'ACTIVE', 'EA', 30522, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (832, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-32', 'Product_017_032', 'P017032', 'ACTIVE', 'EA', 52142, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (833, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-33', 'Product_017_033', 'P017033', 'ACTIVE', 'EA', 2815, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (834, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-34', 'Product_017_034', 'P017034', 'ACTIVE', 'EA', 61518, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (835, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-35', 'Product_017_035', 'P017035', 'ACTIVE', 'EA', 46069, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (836, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-36', 'Product_017_036', 'P017036', 'ACTIVE', 'EA', 16531, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (837, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-37', 'Product_017_037', 'P017037', 'ACTIVE', 'EA', 92499, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (838, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-38', 'Product_017_038', 'P017038', 'ACTIVE', 'EA', 63650, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (839, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-39', 'Product_017_039', 'P017039', 'ACTIVE', 'EA', 49228, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (840, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-40', 'Product_017_040', 'P017040', 'ACTIVE', 'EA', 16701, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (841, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-41', 'Product_017_041', 'P017041', 'ACTIVE', 'EA', 80746, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (842, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-42', 'Product_017_042', 'P017042', 'ACTIVE', 'EA', 36820, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (843, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-43', 'Product_017_043', 'P017043', 'ACTIVE', 'EA', 10950, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (844, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-44', 'Product_017_044', 'P017044', 'ACTIVE', 'EA', 69946, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (845, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-45', 'Product_017_045', 'P017045', 'ACTIVE', 'EA', 27539, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (846, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-46', 'Product_017_046', 'P017046', 'ACTIVE', 'EA', 4449, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (847, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-47', 'Product_017_047', 'P017047', 'ACTIVE', 'EA', 14635, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (848, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-48', 'Product_017_048', 'P017048', 'ACTIVE', 'EA', 53757, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (849, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-49', 'Product_017_049', 'P017049', 'ACTIVE', 'EA', 86946, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (850, '2024-07-18 09:00:00', '2024-07-18 09:00:00', 'Product description 17-50', 'Product_017_050', 'P017050', 'ACTIVE', 'EA', 43392, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (851, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-1', 'Product_018_001', 'P018001', 'ACTIVE', 'EA', 74112, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (852, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-2', 'Product_018_002', 'P018002', 'ACTIVE', 'EA', 65810, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (853, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-3', 'Product_018_003', 'P018003', 'ACTIVE', 'EA', 86035, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (854, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-4', 'Product_018_004', 'P018004', 'ACTIVE', 'EA', 24890, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (855, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-5', 'Product_018_005', 'P018005', 'ACTIVE', 'EA', 32448, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (856, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-6', 'Product_018_006', 'P018006', 'ACTIVE', 'EA', 99271, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (857, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-7', 'Product_018_007', 'P018007', 'ACTIVE', 'EA', 36147, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (858, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-8', 'Product_018_008', 'P018008', 'ACTIVE', 'EA', 57042, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (859, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-9', 'Product_018_009', 'P018009', 'ACTIVE', 'EA', 4222, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (860, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-10', 'Product_018_010', 'P018010', 'ACTIVE', 'EA', 20306, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (861, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-11', 'Product_018_011', 'P018011', 'ACTIVE', 'EA', 16946, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (862, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-12', 'Product_018_012', 'P018012', 'ACTIVE', 'EA', 23391, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (863, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-13', 'Product_018_013', 'P018013', 'ACTIVE', 'EA', 50997, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (864, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-14', 'Product_018_014', 'P018014', 'ACTIVE', 'EA', 31609, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (865, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-15', 'Product_018_015', 'P018015', 'ACTIVE', 'EA', 15281, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (866, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-16', 'Product_018_016', 'P018016', 'ACTIVE', 'EA', 25677, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (867, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-17', 'Product_018_017', 'P018017', 'ACTIVE', 'EA', 96344, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (868, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-18', 'Product_018_018', 'P018018', 'ACTIVE', 'EA', 54451, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (869, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-19', 'Product_018_019', 'P018019', 'ACTIVE', 'EA', 87132, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (870, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-20', 'Product_018_020', 'P018020', 'ACTIVE', 'EA', 2680, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (871, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-21', 'Product_018_021', 'P018021', 'ACTIVE', 'EA', 25630, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (872, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-22', 'Product_018_022', 'P018022', 'ACTIVE', 'EA', 78172, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (873, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-23', 'Product_018_023', 'P018023', 'ACTIVE', 'EA', 59569, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (874, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-24', 'Product_018_024', 'P018024', 'ACTIVE', 'EA', 56156, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (875, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-25', 'Product_018_025', 'P018025', 'ACTIVE', 'EA', 66851, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (876, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-26', 'Product_018_026', 'P018026', 'ACTIVE', 'EA', 44410, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (877, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-27', 'Product_018_027', 'P018027', 'ACTIVE', 'EA', 74862, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (878, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-28', 'Product_018_028', 'P018028', 'ACTIVE', 'EA', 52096, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (879, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-29', 'Product_018_029', 'P018029', 'ACTIVE', 'EA', 56073, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (880, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-30', 'Product_018_030', 'P018030', 'ACTIVE', 'EA', 36747, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (881, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-31', 'Product_018_031', 'P018031', 'ACTIVE', 'EA', 54488, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (882, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-32', 'Product_018_032', 'P018032', 'ACTIVE', 'EA', 8067, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (883, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-33', 'Product_018_033', 'P018033', 'ACTIVE', 'EA', 25218, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (884, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-34', 'Product_018_034', 'P018034', 'ACTIVE', 'EA', 86994, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (885, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-35', 'Product_018_035', 'P018035', 'ACTIVE', 'EA', 94396, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (886, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-36', 'Product_018_036', 'P018036', 'ACTIVE', 'EA', 94904, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (887, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-37', 'Product_018_037', 'P018037', 'ACTIVE', 'EA', 13718, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (888, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-38', 'Product_018_038', 'P018038', 'ACTIVE', 'EA', 49027, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (889, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-39', 'Product_018_039', 'P018039', 'ACTIVE', 'EA', 59070, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (890, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-40', 'Product_018_040', 'P018040', 'ACTIVE', 'EA', 2524, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (891, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-41', 'Product_018_041', 'P018041', 'ACTIVE', 'EA', 41310, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (892, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-42', 'Product_018_042', 'P018042', 'ACTIVE', 'EA', 7401, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (893, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-43', 'Product_018_043', 'P018043', 'ACTIVE', 'EA', 61495, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (894, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-44', 'Product_018_044', 'P018044', 'ACTIVE', 'EA', 87756, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (895, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-45', 'Product_018_045', 'P018045', 'ACTIVE', 'EA', 72466, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (896, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-46', 'Product_018_046', 'P018046', 'ACTIVE', 'EA', 86956, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (897, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-47', 'Product_018_047', 'P018047', 'ACTIVE', 'EA', 14624, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (898, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-48', 'Product_018_048', 'P018048', 'ACTIVE', 'EA', 68887, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (899, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-49', 'Product_018_049', 'P018049', 'ACTIVE', 'EA', 59587, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (900, '2024-07-19 09:00:00', '2024-07-19 09:00:00', 'Product description 18-50', 'Product_018_050', 'P018050', 'ACTIVE', 'EA', 57940, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (901, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-1', 'Product_019_001', 'P019001', 'ACTIVE', 'EA', 18230, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (902, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-2', 'Product_019_002', 'P019002', 'ACTIVE', 'EA', 6486, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (903, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-3', 'Product_019_003', 'P019003', 'ACTIVE', 'EA', 12206, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (904, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-4', 'Product_019_004', 'P019004', 'ACTIVE', 'EA', 22680, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (905, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-5', 'Product_019_005', 'P019005', 'ACTIVE', 'EA', 21272, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (906, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-6', 'Product_019_006', 'P019006', 'ACTIVE', 'EA', 58512, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (907, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-7', 'Product_019_007', 'P019007', 'ACTIVE', 'EA', 75298, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (908, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-8', 'Product_019_008', 'P019008', 'ACTIVE', 'EA', 58456, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (909, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-9', 'Product_019_009', 'P019009', 'ACTIVE', 'EA', 4595, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (910, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-10', 'Product_019_010', 'P019010', 'ACTIVE', 'EA', 42710, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (911, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-11', 'Product_019_011', 'P019011', 'ACTIVE', 'EA', 54999, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (912, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-12', 'Product_019_012', 'P019012', 'ACTIVE', 'EA', 43826, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (913, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-13', 'Product_019_013', 'P019013', 'ACTIVE', 'EA', 46022, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (914, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-14', 'Product_019_014', 'P019014', 'ACTIVE', 'EA', 55168, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (915, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-15', 'Product_019_015', 'P019015', 'ACTIVE', 'EA', 74586, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (916, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-16', 'Product_019_016', 'P019016', 'ACTIVE', 'EA', 72672, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (917, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-17', 'Product_019_017', 'P019017', 'ACTIVE', 'EA', 65035, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (918, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-18', 'Product_019_018', 'P019018', 'ACTIVE', 'EA', 35609, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (919, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-19', 'Product_019_019', 'P019019', 'ACTIVE', 'EA', 84240, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (920, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-20', 'Product_019_020', 'P019020', 'ACTIVE', 'EA', 43354, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (921, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-21', 'Product_019_021', 'P019021', 'ACTIVE', 'EA', 56572, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (922, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-22', 'Product_019_022', 'P019022', 'ACTIVE', 'EA', 11452, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (923, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-23', 'Product_019_023', 'P019023', 'ACTIVE', 'EA', 24524, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (924, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-24', 'Product_019_024', 'P019024', 'ACTIVE', 'EA', 33585, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (925, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-25', 'Product_019_025', 'P019025', 'ACTIVE', 'EA', 65090, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (926, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-26', 'Product_019_026', 'P019026', 'ACTIVE', 'EA', 64168, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (927, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-27', 'Product_019_027', 'P019027', 'ACTIVE', 'EA', 96865, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (928, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-28', 'Product_019_028', 'P019028', 'ACTIVE', 'EA', 75994, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (929, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-29', 'Product_019_029', 'P019029', 'ACTIVE', 'EA', 71220, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (930, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-30', 'Product_019_030', 'P019030', 'ACTIVE', 'EA', 12664, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (931, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-31', 'Product_019_031', 'P019031', 'ACTIVE', 'EA', 45365, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (932, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-32', 'Product_019_032', 'P019032', 'ACTIVE', 'EA', 36237, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (933, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-33', 'Product_019_033', 'P019033', 'ACTIVE', 'EA', 72281, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (934, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-34', 'Product_019_034', 'P019034', 'ACTIVE', 'EA', 42964, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (935, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-35', 'Product_019_035', 'P019035', 'ACTIVE', 'EA', 64257, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (936, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-36', 'Product_019_036', 'P019036', 'ACTIVE', 'EA', 46414, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (937, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-37', 'Product_019_037', 'P019037', 'ACTIVE', 'EA', 73256, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (938, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-38', 'Product_019_038', 'P019038', 'ACTIVE', 'EA', 41612, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (939, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-39', 'Product_019_039', 'P019039', 'ACTIVE', 'EA', 91538, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (940, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-40', 'Product_019_040', 'P019040', 'ACTIVE', 'EA', 70676, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (941, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-41', 'Product_019_041', 'P019041', 'ACTIVE', 'EA', 47279, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (942, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-42', 'Product_019_042', 'P019042', 'ACTIVE', 'EA', 91751, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (943, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-43', 'Product_019_043', 'P019043', 'ACTIVE', 'EA', 24855, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (944, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-44', 'Product_019_044', 'P019044', 'ACTIVE', 'EA', 45397, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (945, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-45', 'Product_019_045', 'P019045', 'ACTIVE', 'EA', 10780, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (946, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-46', 'Product_019_046', 'P019046', 'ACTIVE', 'EA', 14399, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (947, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-47', 'Product_019_047', 'P019047', 'ACTIVE', 'EA', 61050, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (948, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-48', 'Product_019_048', 'P019048', 'ACTIVE', 'EA', 57840, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (949, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-49', 'Product_019_049', 'P019049', 'ACTIVE', 'EA', 61233, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (950, '2024-07-20 09:00:00', '2024-07-20 09:00:00', 'Product description 19-50', 'Product_019_050', 'P019050', 'ACTIVE', 'EA', 60101, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (951, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-1', 'Product_020_001', 'P020001', 'ACTIVE', 'EA', 96941, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (952, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-2', 'Product_020_002', 'P020002', 'ACTIVE', 'EA', 94323, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (953, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-3', 'Product_020_003', 'P020003', 'ACTIVE', 'EA', 76284, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (954, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-4', 'Product_020_004', 'P020004', 'ACTIVE', 'EA', 27740, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (955, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-5', 'Product_020_005', 'P020005', 'ACTIVE', 'EA', 56977, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (956, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-6', 'Product_020_006', 'P020006', 'ACTIVE', 'EA', 30261, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (957, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-7', 'Product_020_007', 'P020007', 'ACTIVE', 'EA', 90932, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (958, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-8', 'Product_020_008', 'P020008', 'ACTIVE', 'EA', 32768, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (959, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-9', 'Product_020_009', 'P020009', 'ACTIVE', 'EA', 47293, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (960, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-10', 'Product_020_010', 'P020010', 'ACTIVE', 'EA', 61205, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (961, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-11', 'Product_020_011', 'P020011', 'ACTIVE', 'EA', 42895, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (962, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-12', 'Product_020_012', 'P020012', 'ACTIVE', 'EA', 58113, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (963, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-13', 'Product_020_013', 'P020013', 'ACTIVE', 'EA', 54328, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (964, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-14', 'Product_020_014', 'P020014', 'ACTIVE', 'EA', 69838, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (965, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-15', 'Product_020_015', 'P020015', 'ACTIVE', 'EA', 13737, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (966, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-16', 'Product_020_016', 'P020016', 'ACTIVE', 'EA', 4211, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (967, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-17', 'Product_020_017', 'P020017', 'ACTIVE', 'EA', 94189, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (968, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-18', 'Product_020_018', 'P020018', 'ACTIVE', 'EA', 47228, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (969, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-19', 'Product_020_019', 'P020019', 'ACTIVE', 'EA', 96716, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (970, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-20', 'Product_020_020', 'P020020', 'ACTIVE', 'EA', 90472, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (971, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-21', 'Product_020_021', 'P020021', 'ACTIVE', 'EA', 58376, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (972, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-22', 'Product_020_022', 'P020022', 'ACTIVE', 'EA', 3947, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (973, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-23', 'Product_020_023', 'P020023', 'ACTIVE', 'EA', 88331, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (974, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-24', 'Product_020_024', 'P020024', 'ACTIVE', 'EA', 32824, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (975, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-25', 'Product_020_025', 'P020025', 'ACTIVE', 'EA', 88304, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (976, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-26', 'Product_020_026', 'P020026', 'ACTIVE', 'EA', 5941, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (977, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-27', 'Product_020_027', 'P020027', 'ACTIVE', 'EA', 19764, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (978, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-28', 'Product_020_028', 'P020028', 'ACTIVE', 'EA', 49920, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (979, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-29', 'Product_020_029', 'P020029', 'ACTIVE', 'EA', 77682, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (980, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-30', 'Product_020_030', 'P020030', 'ACTIVE', 'EA', 83261, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (981, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-31', 'Product_020_031', 'P020031', 'ACTIVE', 'EA', 1025, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (982, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-32', 'Product_020_032', 'P020032', 'ACTIVE', 'EA', 26586, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (983, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-33', 'Product_020_033', 'P020033', 'ACTIVE', 'EA', 4394, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (984, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-34', 'Product_020_034', 'P020034', 'ACTIVE', 'EA', 39117, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (985, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-35', 'Product_020_035', 'P020035', 'ACTIVE', 'EA', 89894, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (986, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-36', 'Product_020_036', 'P020036', 'ACTIVE', 'EA', 52946, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (987, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-37', 'Product_020_037', 'P020037', 'ACTIVE', 'EA', 66697, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (988, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-38', 'Product_020_038', 'P020038', 'ACTIVE', 'EA', 85760, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (989, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-39', 'Product_020_039', 'P020039', 'ACTIVE', 'EA', 24622, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (990, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-40', 'Product_020_040', 'P020040', 'ACTIVE', 'EA', 27316, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (991, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-41', 'Product_020_041', 'P020041', 'ACTIVE', 'EA', 91438, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (992, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-42', 'Product_020_042', 'P020042', 'ACTIVE', 'EA', 44438, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (993, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-43', 'Product_020_043', 'P020043', 'ACTIVE', 'EA', 42628, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (994, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-44', 'Product_020_044', 'P020044', 'ACTIVE', 'EA', 45736, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (995, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-45', 'Product_020_045', 'P020045', 'ACTIVE', 'EA', 56348, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (996, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-46', 'Product_020_046', 'P020046', 'ACTIVE', 'EA', 33091, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (997, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-47', 'Product_020_047', 'P020047', 'ACTIVE', 'EA', 26342, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (998, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-48', 'Product_020_048', 'P020048', 'ACTIVE', 'EA', 62198, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (999, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-49', 'Product_020_049', 'P020049', 'ACTIVE', 'EA', 1309, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (1000, '2024-07-21 09:00:00', '2024-07-21 09:00:00', 'Product description 20-50', 'Product_020_050', 'P020050', 'ACTIVE', 'EA', 31562, 20);

-- member (20)
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (1, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member001@example.com', '2024-06-04 09:00:00', 'Member_001', 'pass001', '010-2000-0001', 'ADMIN', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (2, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member002@example.com', '2024-06-07 09:00:00', 'Member_002', 'pass002', '010-2000-0002', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (3, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member003@example.com', '2024-06-10 09:00:00', 'Member_003', 'pass003', '010-2000-0003', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (4, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member004@example.com', '2024-06-13 09:00:00', 'Member_004', 'pass004', '010-2000-0004', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (5, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member005@example.com', '2024-06-16 09:00:00', 'Member_005', 'pass005', '010-2000-0005', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (6, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member006@example.com', '2024-06-19 09:00:00', 'Member_006', 'pass006', '010-2000-0006', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (7, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member007@example.com', '2024-06-22 09:00:00', 'Member_007', 'pass007', '010-2000-0007', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (8, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member008@example.com', '2024-06-25 09:00:00', 'Member_008', 'pass008', '010-2000-0008', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (9, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member009@example.com', '2024-06-28 09:00:00', 'Member_009', 'pass009', '010-2000-0009', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (10, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member010@example.com', '2024-07-01 09:00:00', 'Member_010', 'pass010', '010-2000-0010', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (11, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member011@example.com', '2024-07-04 09:00:00', 'Member_011', 'pass011', '010-2000-0011', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (12, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member012@example.com', '2024-07-07 09:00:00', 'Member_012', 'pass012', '010-2000-0012', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (13, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member013@example.com', '2024-07-10 09:00:00', 'Member_013', 'pass013', '010-2000-0013', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (14, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member014@example.com', '2024-07-13 09:00:00', 'Member_014', 'pass014', '010-2000-0014', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (15, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member015@example.com', '2024-07-16 09:00:00', 'Member_015', 'pass015', '010-2000-0015', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (16, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member016@example.com', '2024-07-19 09:00:00', 'Member_016', 'pass016', '010-2000-0016', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (17, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member017@example.com', '2024-07-22 09:00:00', 'Member_017', 'pass017', '010-2000-0017', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (18, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member018@example.com', '2024-07-25 09:00:00', 'Member_018', 'pass018', '010-2000-0018', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (19, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member019@example.com', '2024-07-28 09:00:00', 'Member_019', 'pass019', '010-2000-0019', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (20, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'member020@example.com', '2024-07-31 09:00:00', 'Member_020', 'pass020', '010-2000-0020', 'WORKER', 'ACTIVE');

-- warehouse (20)
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (1, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_1', 'Korea', 'Detail_1', 'Street_1', '10001', 'warehouse001@example.com', 'Warehouse_001', '010-3000-0001');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (2, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_2', 'Korea', 'Detail_2', 'Street_2', '10002', 'warehouse002@example.com', 'Warehouse_002', '010-3000-0002');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (3, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_3', 'Korea', 'Detail_3', 'Street_3', '10003', 'warehouse003@example.com', 'Warehouse_003', '010-3000-0003');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (4, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_4', 'Korea', 'Detail_4', 'Street_4', '10004', 'warehouse004@example.com', 'Warehouse_004', '010-3000-0004');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (5, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_5', 'Korea', 'Detail_5', 'Street_5', '10005', 'warehouse005@example.com', 'Warehouse_005', '010-3000-0005');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (6, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_6', 'Korea', 'Detail_6', 'Street_6', '10006', 'warehouse006@example.com', 'Warehouse_006', '010-3000-0006');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (7, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_7', 'Korea', 'Detail_7', 'Street_7', '10007', 'warehouse007@example.com', 'Warehouse_007', '010-3000-0007');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (8, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_8', 'Korea', 'Detail_8', 'Street_8', '10008', 'warehouse008@example.com', 'Warehouse_008', '010-3000-0008');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (9, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_9', 'Korea', 'Detail_9', 'Street_9', '10009', 'warehouse009@example.com', 'Warehouse_009', '010-3000-0009');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (10, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_10', 'Korea', 'Detail_10', 'Street_10', '10010', 'warehouse010@example.com', 'Warehouse_010', '010-3000-0010');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (11, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_11', 'Korea', 'Detail_11', 'Street_11', '10011', 'warehouse011@example.com', 'Warehouse_011', '010-3000-0011');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (12, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_12', 'Korea', 'Detail_12', 'Street_12', '10012', 'warehouse012@example.com', 'Warehouse_012', '010-3000-0012');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (13, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_13', 'Korea', 'Detail_13', 'Street_13', '10013', 'warehouse013@example.com', 'Warehouse_013', '010-3000-0013');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (14, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_14', 'Korea', 'Detail_14', 'Street_14', '10014', 'warehouse014@example.com', 'Warehouse_014', '010-3000-0014');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (15, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_15', 'Korea', 'Detail_15', 'Street_15', '10015', 'warehouse015@example.com', 'Warehouse_015', '010-3000-0015');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (16, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_16', 'Korea', 'Detail_16', 'Street_16', '10016', 'warehouse016@example.com', 'Warehouse_016', '010-3000-0016');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (17, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_17', 'Korea', 'Detail_17', 'Street_17', '10017', 'warehouse017@example.com', 'Warehouse_017', '010-3000-0017');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (18, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_18', 'Korea', 'Detail_18', 'Street_18', '10018', 'warehouse018@example.com', 'Warehouse_018', '010-3000-0018');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (19, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_19', 'Korea', 'Detail_19', 'Street_19', '10019', 'warehouse019@example.com', 'Warehouse_019', '010-3000-0019');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (20, '2024-08-10 09:00:00', '2024-08-10 09:00:00', b'1', 'City_20', 'Korea', 'Detail_20', 'Street_20', '10020', 'warehouse020@example.com', 'Warehouse_020', '010-3000-0020');

-- location (40)
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (1, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 334, 'Location 1', 'LOC0001', 'A', 'AVAILABLE', 149, 1, 'Z');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (2, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 961, 'Location 2', 'LOC0002', 'B', 'AVAILABLE', 118, 2, 'Y');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (3, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 912, 'Location 3', 'LOC0003', 'C', 'AVAILABLE', 435, NULL, 'X');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (4, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 554, 'Location 4', 'LOC0004', 'D', 'AVAILABLE', 90, 4, 'W');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (5, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 874, 'Location 5', 'LOC0005', 'E', 'AVAILABLE', 20, 5, 'V');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (6, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 824, 'Location 6', 'LOC0006', 'A', 'AVAILABLE', 238, NULL, 'Z');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (7, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 242, 'Location 7', 'LOC0007', 'B', 'AVAILABLE', 17, 7, 'Y');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (8, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 577, 'Location 8', 'LOC0008', 'C', 'AVAILABLE', 264, 8, 'X');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (9, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 781, 'Location 9', 'LOC0009', 'D', 'AVAILABLE', 180, NULL, 'W');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (10, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 728, 'Location 10', 'LOC0010', 'E', 'AVAILABLE', 116, 10, 'V');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (11, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 429, 'Location 11', 'LOC0011', 'A', 'AVAILABLE', 7, 11, 'Z');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (12, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 200, 'Location 12', 'LOC0012', 'B', 'AVAILABLE', 20, NULL, 'Y');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (13, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 237, 'Location 13', 'LOC0013', 'C', 'AVAILABLE', 111, 13, 'X');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (14, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 225, 'Location 14', 'LOC0014', 'D', 'AVAILABLE', 99, 14, 'W');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (15, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 827, 'Location 15', 'LOC0015', 'E', 'AVAILABLE', 61, NULL, 'V');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (16, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 436, 'Location 16', 'LOC0016', 'A', 'AVAILABLE', 152, 16, 'Z');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (17, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 545, 'Location 17', 'LOC0017', 'B', 'AVAILABLE', 170, 17, 'Y');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (18, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 894, 'Location 18', 'LOC0018', 'C', 'AVAILABLE', 334, NULL, 'X');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (19, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 620, 'Location 19', 'LOC0019', 'D', 'AVAILABLE', 178, 19, 'W');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (20, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 315, 'Location 20', 'LOC0020', 'E', 'AVAILABLE', 98, 20, 'V');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (21, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 188, 'Location 21', 'LOC0021', 'A', 'AVAILABLE', 54, NULL, 'Z');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (22, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 302, 'Location 22', 'LOC0022', 'B', 'AVAILABLE', 113, 2, 'Y');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (23, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 312, 'Location 23', 'LOC0023', 'C', 'AVAILABLE', 29, 3, 'X');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (24, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 263, 'Location 24', 'LOC0024', 'D', 'AVAILABLE', 45, NULL, 'W');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (25, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 669, 'Location 25', 'LOC0025', 'E', 'AVAILABLE', 190, 5, 'V');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (26, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 214, 'Location 26', 'LOC0026', 'A', 'AVAILABLE', 102, 6, 'Z');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (27, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 227, 'Location 27', 'LOC0027', 'B', 'AVAILABLE', 82, NULL, 'Y');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (28, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 381, 'Location 28', 'LOC0028', 'C', 'AVAILABLE', 36, 8, 'X');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (29, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 448, 'Location 29', 'LOC0029', 'D', 'AVAILABLE', 199, 9, 'W');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (30, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 327, 'Location 30', 'LOC0030', 'E', 'AVAILABLE', 129, NULL, 'V');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (31, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 976, 'Location 31', 'LOC0031', 'A', 'AVAILABLE', 290, 11, 'Z');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (32, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 882, 'Location 32', 'LOC0032', 'B', 'AVAILABLE', 244, 12, 'Y');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (33, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 869, 'Location 33', 'LOC0033', 'C', 'AVAILABLE', 15, NULL, 'X');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (34, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 371, 'Location 34', 'LOC0034', 'D', 'AVAILABLE', 71, 14, 'W');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (35, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 598, 'Location 35', 'LOC0035', 'E', 'AVAILABLE', 170, 15, 'V');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (36, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 929, 'Location 36', 'LOC0036', 'A', 'AVAILABLE', 0, NULL, 'Z');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (37, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 435, 'Location 37', 'LOC0037', 'B', 'AVAILABLE', 191, 17, 'Y');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (38, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 918, 'Location 38', 'LOC0038', 'C', 'AVAILABLE', 259, 18, 'X');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (39, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 774, 'Location 39', 'LOC0039', 'D', 'AVAILABLE', 287, NULL, 'W');
INSERT INTO location (id, created_at, updated_at, capacity, description, location_code, section, status, used_capacity, vendor_id, zone) VALUES (40, '2024-08-15 09:00:00', '2024-08-15 09:00:00', 126, 'Location 40', 'LOC0040', 'E', 'AVAILABLE', 46, 20, 'V');

-- category (20)
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (1, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT001', 'Category description 1', 'Category_1', NULL);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (2, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT002', 'Category description 2', 'Category_2', NULL);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (3, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT003', 'Category description 3', 'Category_3', NULL);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (4, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT004', 'Category description 4', 'Category_4', NULL);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (5, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT005', 'Category description 5', 'Category_5', NULL);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (6, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT006', 'Category description 6', 'Category_6', 5);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (7, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT007', 'Category description 7', 'Category_7', 2);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (8, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT008', 'Category description 8', 'Category_8', 1);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (9, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT009', 'Category description 9', 'Category_9', 1);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (10, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT010', 'Category description 10', 'Category_10', 5);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (11, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT011', 'Category description 11', 'Category_11', 2);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (12, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT012', 'Category description 12', 'Category_12', 2);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (13, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT013', 'Category description 13', 'Category_13', 3);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (14, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT014', 'Category description 14', 'Category_14', 3);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (15, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT015', 'Category description 15', 'Category_15', 4);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (16, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT016', 'Category description 16', 'Category_16', 4);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (17, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT017', 'Category description 17', 'Category_17', 1);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (18, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT018', 'Category description 18', 'Category_18', 1);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (19, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT019', 'Category description 19', 'Category_19', 5);
INSERT INTO category (id, created_at, updated_at, active, code, description, name, parent_id) VALUES (20, '2024-08-20 09:00:00', '2024-08-20 09:00:00', b'1', 'CAT020', 'Category description 20', 'Category_20', 1);

-- franchise_store (20)
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (1, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_1', 'Korea', 'Detail_1', 'Street_1', '20001', 'FS_API_001', 'Franchise 1', 'store001@example.com', 'FS001', 'Franchise_001', '010-4000-0001', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (2, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_2', 'Korea', 'Detail_2', 'Street_2', '20002', 'FS_API_002', 'Franchise 2', 'store002@example.com', 'FS002', 'Franchise_002', '010-4000-0002', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (3, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_3', 'Korea', 'Detail_3', 'Street_3', '20003', 'FS_API_003', 'Franchise 3', 'store003@example.com', 'FS003', 'Franchise_003', '010-4000-0003', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (4, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_4', 'Korea', 'Detail_4', 'Street_4', '20004', 'FS_API_004', 'Franchise 4', 'store004@example.com', 'FS004', 'Franchise_004', '010-4000-0004', 'INACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (5, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_5', 'Korea', 'Detail_5', 'Street_5', '20005', 'FS_API_005', 'Franchise 5', 'store005@example.com', 'FS005', 'Franchise_005', '010-4000-0005', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (6, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_6', 'Korea', 'Detail_6', 'Street_6', '20006', 'FS_API_006', 'Franchise 6', 'store006@example.com', 'FS006', 'Franchise_006', '010-4000-0006', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (7, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_7', 'Korea', 'Detail_7', 'Street_7', '20007', 'FS_API_007', 'Franchise 7', 'store007@example.com', 'FS007', 'Franchise_007', '010-4000-0007', 'INACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (8, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_8', 'Korea', 'Detail_8', 'Street_8', '20008', 'FS_API_008', 'Franchise 8', 'store008@example.com', 'FS008', 'Franchise_008', '010-4000-0008', 'INACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (9, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_9', 'Korea', 'Detail_9', 'Street_9', '20009', 'FS_API_009', 'Franchise 9', 'store009@example.com', 'FS009', 'Franchise_009', '010-4000-0009', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (10, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_10', 'Korea', 'Detail_10', 'Street_10', '20010', 'FS_API_010', 'Franchise 10', 'store010@example.com', 'FS010', 'Franchise_010', '010-4000-0010', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (11, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_11', 'Korea', 'Detail_11', 'Street_11', '20011', 'FS_API_011', 'Franchise 11', 'store011@example.com', 'FS011', 'Franchise_011', '010-4000-0011', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (12, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_12', 'Korea', 'Detail_12', 'Street_12', '20012', 'FS_API_012', 'Franchise 12', 'store012@example.com', 'FS012', 'Franchise_012', '010-4000-0012', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (13, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_13', 'Korea', 'Detail_13', 'Street_13', '20013', 'FS_API_013', 'Franchise 13', 'store013@example.com', 'FS013', 'Franchise_013', '010-4000-0013', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (14, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_14', 'Korea', 'Detail_14', 'Street_14', '20014', 'FS_API_014', 'Franchise 14', 'store014@example.com', 'FS014', 'Franchise_014', '010-4000-0014', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (15, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_15', 'Korea', 'Detail_15', 'Street_15', '20015', 'FS_API_015', 'Franchise 15', 'store015@example.com', 'FS015', 'Franchise_015', '010-4000-0015', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (16, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_16', 'Korea', 'Detail_16', 'Street_16', '20016', 'FS_API_016', 'Franchise 16', 'store016@example.com', 'FS016', 'Franchise_016', '010-4000-0016', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (17, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_17', 'Korea', 'Detail_17', 'Street_17', '20017', 'FS_API_017', 'Franchise 17', 'store017@example.com', 'FS017', 'Franchise_017', '010-4000-0017', 'INACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (18, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_18', 'Korea', 'Detail_18', 'Street_18', '20018', 'FS_API_018', 'Franchise 18', 'store018@example.com', 'FS018', 'Franchise_018', '010-4000-0018', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (19, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_19', 'Korea', 'Detail_19', 'Street_19', '20019', 'FS_API_019', 'Franchise 19', 'store019@example.com', 'FS019', 'Franchise_019', '010-4000-0019', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (20, '2024-08-25 09:00:00', '2024-08-25 09:00:00', 'City_20', 'Korea', 'Detail_20', 'Street_20', '20020', 'FS_API_020', 'Franchise 20', 'store020@example.com', 'FS020', 'Franchise_020', '010-4000-0020', 'INACTIVE');

-- purchase_order (20)
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (1, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 1', '2024-09-20 09:00:00', 'PO001', '2024-08-31 09:00:00', 'COMPLETED', 591509, 7);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (2, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 2', '2024-09-21 09:00:00', 'PO002', '2024-09-01 09:00:00', 'AWAITING_DELIVERY', 539398, 6);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (3, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 3', '2024-09-22 09:00:00', 'PO003', '2024-09-02 09:00:00', 'AWAITING_DELIVERY', 475871, 5);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (4, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 4', '2024-09-23 09:00:00', 'PO004', '2024-09-03 09:00:00', 'APPROVED', 549394, 15);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (5, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 5', '2024-09-24 09:00:00', 'PO005', '2024-09-04 09:00:00', 'CANCELLED', 361793, 10);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (6, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 6', '2024-09-25 09:00:00', 'PO006', '2024-09-05 09:00:00', 'CANCELLED', 358828, 3);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (7, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 7', '2024-09-26 09:00:00', 'PO007', '2024-09-06 09:00:00', 'CANCELLED', 668510, 6);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (8, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 8', '2024-09-27 09:00:00', 'PO008', '2024-09-07 09:00:00', 'COMPLETED', 110239, 17);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (9, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 9', '2024-09-28 09:00:00', 'PO009', '2024-09-08 09:00:00', 'COMPLETED', 388342, 11);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (10, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 10', '2024-09-29 09:00:00', 'PO010', '2024-09-09 09:00:00', 'CANCELLED', 428242, 1);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (11, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 11', '2024-09-30 09:00:00', 'PO011', '2024-09-10 09:00:00', 'CANCELLED', 607143, 9);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (12, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 12', '2024-10-01 09:00:00', 'PO012', '2024-09-11 09:00:00', 'REQUESTED', 453765, 9);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (13, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 13', '2024-10-02 09:00:00', 'PO013', '2024-09-12 09:00:00', 'APPROVED', 107695, 18);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (14, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 14', '2024-10-03 09:00:00', 'PO014', '2024-09-13 09:00:00', 'REQUESTED', 240943, 12);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (15, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 15', '2024-10-04 09:00:00', 'PO015', '2024-09-14 09:00:00', 'APPROVED', 790506, 6);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (16, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 16', '2024-10-05 09:00:00', 'PO016', '2024-09-15 09:00:00', 'AWAITING_DELIVERY', 632957, 13);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (17, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 17', '2024-10-06 09:00:00', 'PO017', '2024-09-16 09:00:00', 'REQUESTED', 721929, 15);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (18, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 18', '2024-10-07 09:00:00', 'PO018', '2024-09-17 09:00:00', 'REQUESTED', 498984, 12);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (19, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 19', '2024-10-08 09:00:00', 'PO019', '2024-09-18 09:00:00', 'REQUESTED', 694619, 19);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (20, '2024-09-04 09:00:00', '2024-09-04 09:00:00', 'Purchase order 20', '2024-10-09 09:00:00', 'PO020', '2024-09-19 09:00:00', 'CANCELLED', 213753, 3);

-- purchase_order_product
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 1', 17, 336, 1);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 2', 20, 311, 1);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 3', 37, 303, 1);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 4', 49, 344, 1);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 5', 49, 349, 1);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 6', 43, 321, 1);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 7', 18, 304, 1);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 8', 47, 291, 2);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 9', 28, 289, 2);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 10', 49, 258, 2);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 11', 29, 292, 2);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 12', 50, 295, 2);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 13', 23, 276, 2);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 14', 48, 260, 2);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (15, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 15', 25, 202, 3);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (16, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 16', 34, 221, 3);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (17, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 17', 17, 720, 4);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (18, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 18', 22, 701, 4);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (19, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 19', 45, 498, 5);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (20, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 20', 5, 452, 5);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (21, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 21', 33, 468, 5);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (22, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 22', 32, 474, 5);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (23, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 23', 38, 133, 6);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (24, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 24', 41, 149, 6);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (25, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 25', 11, 131, 6);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (26, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 26', 30, 101, 6);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (27, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 27', 23, 150, 6);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (28, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 28', 11, 108, 6);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (29, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 29', 46, 105, 6);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (30, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 30', 27, 298, 7);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (31, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 31', 31, 278, 7);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (32, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 32', 9, 256, 7);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (33, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 33', 26, 288, 7);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (34, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 34', 6, 845, 8);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (35, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 35', 17, 849, 8);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (36, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 36', 31, 801, 8);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (37, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 37', 39, 840, 8);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (38, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 38', 47, 834, 8);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (39, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 39', 10, 822, 8);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (40, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 40', 24, 536, 9);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (41, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 41', 5, 518, 9);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (42, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 42', 36, 522, 9);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (43, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 43', 16, 544, 9);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (44, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 44', 50, 25, 10);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (45, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 45', 16, 19, 10);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (46, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 46', 22, 447, 11);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (47, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 47', 49, 448, 11);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (48, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 48', 30, 406, 11);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (49, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 49', 5, 449, 11);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (50, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 50', 29, 416, 11);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (51, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 51', 37, 434, 11);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (52, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 52', 45, 419, 12);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (53, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 53', 10, 405, 12);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (54, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 54', 19, 404, 12);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (55, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 55', 14, 407, 12);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (56, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 56', 5, 408, 12);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (57, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 57', 25, 899, 13);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (58, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 58', 9, 866, 13);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (59, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 59', 20, 863, 13);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (60, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 60', 6, 892, 13);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (61, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 61', 29, 862, 13);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (62, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 62', 27, 873, 13);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (63, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 63', 10, 897, 13);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (64, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 64', 18, 563, 14);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (65, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 65', 32, 567, 14);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (66, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 66', 12, 585, 14);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (67, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 67', 17, 581, 14);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (68, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 68', 32, 592, 14);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (69, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 69', 28, 288, 15);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (70, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 70', 38, 270, 15);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (71, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 71', 21, 280, 15);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (72, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 72', 43, 266, 15);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (73, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 73', 30, 276, 15);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (74, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 74', 12, 636, 16);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (75, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 75', 21, 641, 16);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (76, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 76', 22, 606, 16);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (77, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 77', 37, 601, 16);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (78, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 78', 22, 622, 16);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (79, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 79', 21, 709, 17);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (80, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 80', 10, 733, 17);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (81, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 81', 29, 743, 17);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (82, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 82', 21, 745, 17);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (83, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 83', 21, 728, 17);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (84, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 84', 31, 730, 17);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (85, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 85', 6, 742, 17);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (86, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 86', 26, 585, 18);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (87, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 87', 42, 584, 18);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (88, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 88', 15, 571, 18);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (89, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 89', 20, 575, 18);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (90, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 90', 15, 569, 18);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (91, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 91', 28, 561, 18);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (92, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 92', 20, 924, 19);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (93, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 93', 31, 913, 19);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (94, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 94', 27, 110, 20);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (95, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 95', 50, 123, 20);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (96, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 96', 9, 104, 20);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (97, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 97', 38, 129, 20);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (98, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 98', 48, 141, 20);
INSERT INTO purchase_order_product (id, created_at, updated_at, description, ordered_quantity, product_id, purchase_order_id) VALUES (99, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'PO item 99', 6, 139, 20);

-- asn
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN001', 'ASN for PO 1', '2024-09-30 09:00:00', 'ACCEPTED', 1, 7);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN002', 'ASN for PO 2', '2024-10-01 09:00:00', 'ACCEPTED', 2, 6);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN003', 'ASN for PO 3', '2024-10-02 09:00:00', 'REJECTED', 3, 5);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN004', 'ASN for PO 4', '2024-10-03 09:00:00', 'ACCEPTED', 4, 15);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN005', 'ASN for PO 5', '2024-10-04 09:00:00', 'REJECTED', 5, 10);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN006', 'ASN for PO 6', '2024-10-05 09:00:00', 'ACCEPTED', 6, 3);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN007', 'ASN for PO 7', '2024-10-06 09:00:00', 'ACCEPTED', 7, 6);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN008', 'ASN for PO 8', '2024-10-07 09:00:00', 'REJECTED', 8, 17);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN009', 'ASN for PO 9', '2024-10-08 09:00:00', 'ACCEPTED', 9, 11);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN010', 'ASN for PO 10', '2024-10-09 09:00:00', 'ACCEPTED', 10, 1);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN011', 'ASN for PO 11', '2024-10-10 09:00:00', 'REJECTED', 11, 9);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN012', 'ASN for PO 12', '2024-10-11 09:00:00', 'ACCEPTED', 12, 9);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN013', 'ASN for PO 13', '2024-10-12 09:00:00', 'REJECTED', 13, 18);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN014', 'ASN for PO 14', '2024-10-13 09:00:00', 'ACCEPTED', 14, 12);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (15, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN015', 'ASN for PO 15', '2024-10-14 09:00:00', 'ACCEPTED', 15, 6);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (16, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN016', 'ASN for PO 16', '2024-10-15 09:00:00', 'ACCEPTED', 16, 13);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (17, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN017', 'ASN for PO 17', '2024-10-16 09:00:00', 'REJECTED', 17, 15);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (18, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN018', 'ASN for PO 18', '2024-10-17 09:00:00', 'ACCEPTED', 18, 12);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (19, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN019', 'ASN for PO 19', '2024-10-18 09:00:00', 'ACCEPTED', 19, 19);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (20, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN020', 'ASN for PO 20', '2024-10-19 09:00:00', 'ACCEPTED', 20, 3);

-- inbound
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 1', 'INB001', 'Manager_001', '2024-10-05 09:00:00', 'CREATED', 'Worker_001', 1);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 2', 'INB002', 'Manager_002', '2024-10-06 09:00:00', 'CREATED', 'Worker_002', 2);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 4', 'INB004', 'Manager_004', '2024-10-08 09:00:00', 'PUTAWAY', 'Worker_004', 4);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 6', 'INB006', 'Manager_006', '2024-10-10 09:00:00', 'PUTAWAY', 'Worker_006', 6);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 7', 'INB007', 'Manager_007', '2024-10-11 09:00:00', 'COMPLETED', 'Worker_007', 7);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 9', 'INB009', 'Manager_009', '2024-10-13 09:00:00', 'SCHEDULED', 'Worker_009', 9);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 10', 'INB010', 'Manager_010', '2024-10-14 09:00:00', 'ARRIVED', 'Worker_010', 10);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 12', 'INB012', 'Manager_012', '2024-10-16 09:00:00', 'PUTAWAY', 'Worker_012', 12);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 14', 'INB014', 'Manager_014', '2024-10-18 09:00:00', 'PUTAWAY', 'Worker_014', 14);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 15', 'INB015', 'Manager_015', '2024-10-19 09:00:00', 'COMPLETED', 'Worker_015', 15);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 16', 'INB016', 'Manager_016', '2024-10-20 09:00:00', 'ARRIVED', 'Worker_016', 16);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 18', 'INB018', 'Manager_018', '2024-10-22 09:00:00', 'CREATED', 'Worker_018', 18);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 19', 'INB019', 'Manager_019', '2024-10-23 09:00:00', 'CREATED', 'Worker_019', 19);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound for PO 20', 'INB020', 'Manager_020', '2024-10-24 09:00:00', 'CREATED', 'Worker_020', 20);

-- inbound_product
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 1', 'LOC0019', 'LOT0010001', 17, 1, 336, 1);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 2', 'LOC0025', 'LOT0010002', 20, 1, 311, 2);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 3', 'LOC0009', 'LOT0010003', 37, 1, 303, 3);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 4', 'LOC0029', 'LOT0010004', 49, 1, 344, 4);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 5', 'LOC0020', 'LOT0010005', 49, 1, 349, 5);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 6', 'LOC0030', 'LOT0010006', 43, 1, 321, 6);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 7', 'LOC0028', 'LOT0010007', 18, 1, 304, 7);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 8', 'LOC0017', 'LOT0020008', 47, 2, 291, 8);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 9', 'LOC0031', 'LOT0020009', 28, 2, 289, 9);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 10', 'LOC0011', 'LOT0020010', 49, 2, 258, 10);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 11', 'LOC0009', 'LOT0020011', 29, 2, 292, 11);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 12', 'LOC0006', 'LOT0020012', 50, 2, 295, 12);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 13', 'LOC0026', 'LOT0020013', 23, 2, 276, 13);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 14', 'LOC0035', 'LOT0020014', 48, 2, 260, 14);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (15, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 15', 'LOC0025', 'LOT0040017', 17, 3, 720, 17);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (16, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 16', 'LOC0022', 'LOT0040018', 22, 3, 701, 18);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (17, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 17', 'LOC0026', 'LOT0060023', 38, 4, 133, 23);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (18, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 18', 'LOC0025', 'LOT0060024', 41, 4, 149, 24);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (19, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 19', 'LOC0004', 'LOT0060025', 11, 4, 131, 25);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (20, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 20', 'LOC0001', 'LOT0060026', 30, 4, 101, 26);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (21, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 21', 'LOC0017', 'LOT0060027', 23, 4, 150, 27);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (22, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 22', 'LOC0040', 'LOT0060028', 11, 4, 108, 28);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (23, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 23', 'LOC0018', 'LOT0060029', 46, 4, 105, 29);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (24, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 24', 'LOC0017', 'LOT0070030', 27, 5, 298, 30);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (25, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 25', 'LOC0001', 'LOT0070031', 31, 5, 278, 31);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (26, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 26', 'LOC0012', 'LOT0070032', 9, 5, 256, 32);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (27, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 27', 'LOC0027', 'LOT0070033', 26, 5, 288, 33);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (28, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 28', 'LOC0028', 'LOT0090040', 24, 6, 536, 40);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (29, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 29', 'LOC0027', 'LOT0090041', 5, 6, 518, 41);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (30, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 30', 'LOC0011', 'LOT0090042', 36, 6, 522, 42);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (31, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 31', 'LOC0003', 'LOT0090043', 16, 6, 544, 43);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (32, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 32', 'LOC0003', 'LOT0100044', 50, 7, 25, 44);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (33, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 33', 'LOC0021', 'LOT0100045', 16, 7, 19, 45);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (34, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 34', 'LOC0035', 'LOT0120052', 45, 8, 419, 52);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (35, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 35', 'LOC0028', 'LOT0120053', 10, 8, 405, 53);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (36, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 36', 'LOC0032', 'LOT0120054', 19, 8, 404, 54);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (37, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 37', 'LOC0031', 'LOT0120055', 14, 8, 407, 55);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (38, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 38', 'LOC0014', 'LOT0120056', 5, 8, 408, 56);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (39, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 39', 'LOC0015', 'LOT0140064', 18, 9, 563, 64);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (40, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 40', 'LOC0033', 'LOT0140065', 32, 9, 567, 65);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (41, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 41', 'LOC0018', 'LOT0140066', 12, 9, 585, 66);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (42, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 42', 'LOC0040', 'LOT0140067', 17, 9, 581, 67);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (43, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 43', 'LOC0025', 'LOT0140068', 32, 9, 592, 68);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (44, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 44', 'LOC0035', 'LOT0150069', 28, 10, 288, 69);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (45, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 45', 'LOC0019', 'LOT0150070', 38, 10, 270, 70);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (46, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 46', 'LOC0007', 'LOT0150071', 21, 10, 280, 71);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (47, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 47', 'LOC0027', 'LOT0150072', 43, 10, 266, 72);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (48, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 48', 'LOC0005', 'LOT0150073', 30, 10, 276, 73);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (49, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 49', 'LOC0022', 'LOT0160074', 12, 11, 636, 74);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (50, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 50', 'LOC0037', 'LOT0160075', 21, 11, 641, 75);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (51, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 51', 'LOC0008', 'LOT0160076', 22, 11, 606, 76);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (52, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 52', 'LOC0033', 'LOT0160077', 37, 11, 601, 77);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (53, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 53', 'LOC0010', 'LOT0160078', 22, 11, 622, 78);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (54, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 54', 'LOC0026', 'LOT0180086', 26, 12, 585, 86);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (55, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 55', 'LOC0005', 'LOT0180087', 42, 12, 584, 87);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (56, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 56', 'LOC0017', 'LOT0180088', 15, 12, 571, 88);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (57, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 57', 'LOC0009', 'LOT0180089', 20, 12, 575, 89);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (58, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 58', 'LOC0023', 'LOT0180090', 15, 12, 569, 90);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (59, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 59', 'LOC0010', 'LOT0180091', 28, 12, 561, 91);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (60, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 60', 'LOC0004', 'LOT0190092', 20, 13, 924, 92);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (61, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 61', 'LOC0036', 'LOT0190093', 31, 13, 913, 93);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (62, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 62', 'LOC0008', 'LOT0200094', 27, 14, 110, 94);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (63, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 63', 'LOC0020', 'LOT0200095', 50, 14, 123, 95);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (64, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 64', 'LOC0017', 'LOT0200096', 9, 14, 104, 96);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (65, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 65', 'LOC0014', 'LOT0200097', 38, 14, 129, 97);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (66, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 66', 'LOC0028', 'LOT0200098', 48, 14, 141, 98);
INSERT INTO inbound_product (inbound_product_item_id, created_at, updated_at, description, location_code, lot_number, received_quantity, inbound_id, product_id, purchase_order_product_item_id) VALUES (67, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Inbound item 67', 'LOC0038', 'LOT0200099', 6, 14, 139, 99);

-- task (inspection/putaway seeds)
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 1', 1, '2024-06-03 09:00:00', 'ASSIGNED', 1);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 1', 1, '2024-06-05 09:00:00', 'PENDING', 1);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 2', 2, '2024-06-03 09:00:00', 'ASSIGNED', 2);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 2', 2, '2024-06-05 09:00:00', 'PENDING', 2);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 3', 3, '2024-06-03 09:00:00', 'ASSIGNED', 3);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 3', 3, '2024-06-05 09:00:00', 'PENDING', 3);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 4', 4, '2024-06-03 09:00:00', 'ASSIGNED', 4);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 4', 4, '2024-06-05 09:00:00', 'PENDING', 4);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 5', 5, '2024-06-03 09:00:00', 'ASSIGNED', 5);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 5', 5, '2024-06-05 09:00:00', 'PENDING', 5);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 6', 6, '2024-06-03 09:00:00', 'ASSIGNED', 6);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 6', 6, '2024-06-05 09:00:00', 'PENDING', 6);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 7', 7, '2024-06-03 09:00:00', 'ASSIGNED', 7);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 7', 7, '2024-06-05 09:00:00', 'PENDING', 7);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (15, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 8', 8, '2024-06-03 09:00:00', 'ASSIGNED', 8);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (16, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 8', 8, '2024-06-05 09:00:00', 'PENDING', 8);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (17, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 9', 9, '2024-06-03 09:00:00', 'ASSIGNED', 9);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (18, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 9', 9, '2024-06-05 09:00:00', 'PENDING', 9);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (19, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 10', 10, '2024-06-03 09:00:00', 'ASSIGNED', 10);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (20, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 10', 10, '2024-06-05 09:00:00', 'PENDING', 10);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (21, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 11', 11, '2024-06-03 09:00:00', 'ASSIGNED', 11);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (22, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 11', 11, '2024-06-05 09:00:00', 'PENDING', 11);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (23, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 12', 12, '2024-06-03 09:00:00', 'ASSIGNED', 12);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (24, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 12', 12, '2024-06-05 09:00:00', 'PENDING', 12);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (25, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 13', 13, '2024-06-03 09:00:00', 'ASSIGNED', 13);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (26, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 13', 13, '2024-06-05 09:00:00', 'PENDING', 13);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (27, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'INSPECTION', NULL, 'Inspect inbound 14', 14, '2024-06-03 09:00:00', 'ASSIGNED', 14);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (28, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-04 09:00:00', 'PUTAWAY', NULL, 'Putaway inbound 14', 14, '2024-06-05 09:00:00', 'PENDING', 14);

-- inspection_task
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (1, 1, 1);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (3, 2, 3);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (5, 3, 5);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (7, 4, 7);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (9, 5, 9);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (11, 6, 11);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (13, 7, 13);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (15, 8, 15);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (17, 9, 17);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (19, 10, 19);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (21, 11, 21);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (23, 12, 23);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (25, 13, 25);
INSERT INTO inspection_task (id, inbound_id, task_id) VALUES (27, 14, 27);

-- putaway_task
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (2, 'LOC0002', 1, 2);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (4, 'LOC0003', 2, 4);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (6, 'LOC0004', 3, 6);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (8, 'LOC0005', 4, 8);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (10, 'LOC0006', 5, 10);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (12, 'LOC0007', 6, 12);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (14, 'LOC0008', 7, 14);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (16, 'LOC0009', 8, 16);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (18, 'LOC0010', 9, 18);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (20, 'LOC0011', 10, 20);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (22, 'LOC0012', 11, 22);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (24, 'LOC0013', 12, 24);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (26, 'LOC0014', 13, 26);
INSERT INTO putaway_task (id, assigned_location_code, inbound_id, task_id) VALUES (28, 'LOC0015', 14, 28);

-- inventory
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 1', 'LOT0010001', 17, 1, 1, 336);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 2', 'LOT0010002', 20, 1, 1, 311);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 3', 'LOT0010003', 37, 1, 1, 303);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 4', 'LOT0010004', 49, 1, 1, 344);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 5', 'LOT0010005', 49, 1, 1, 349);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 6', 'LOT0010006', 43, 1, 1, 321);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 7', 'LOT0010007', 18, 1, 1, 304);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 8', 'LOT0020008', 47, 2, 2, 291);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 9', 'LOT0020009', 28, 2, 2, 289);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 10', 'LOT0020010', 49, 2, 2, 258);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 11', 'LOT0020011', 29, 2, 2, 292);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 12', 'LOT0020012', 50, 2, 2, 295);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 13', 'LOT0020013', 23, 2, 2, 276);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 14', 'LOT0020014', 48, 2, 2, 260);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (15, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 15', 'LOT0040017', 17, 3, 3, 720);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (16, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 16', 'LOT0040018', 22, 3, 3, 701);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (17, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 17', 'LOT0060023', 38, 4, 4, 133);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (18, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 18', 'LOT0060024', 41, 4, 4, 149);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (19, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 19', 'LOT0060025', 11, 4, 4, 131);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (20, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 20', 'LOT0060026', 30, 4, 4, 101);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (21, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 21', 'LOT0060027', 23, 4, 4, 150);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (22, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 22', 'LOT0060028', 11, 4, 4, 108);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (23, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 23', 'LOT0060029', 46, 4, 4, 105);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (24, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 24', 'LOT0070030', 27, 5, 5, 298);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (25, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 25', 'LOT0070031', 31, 5, 5, 278);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (26, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 26', 'LOT0070032', 9, 5, 5, 256);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (27, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 27', 'LOT0070033', 26, 5, 5, 288);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (28, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 28', 'LOT0090040', 24, 6, 6, 536);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (29, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 29', 'LOT0090041', 5, 6, 6, 518);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (30, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 30', 'LOT0090042', 36, 6, 6, 522);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (31, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 31', 'LOT0090043', 16, 6, 6, 544);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (32, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 32', 'LOT0100044', 50, 7, 7, 25);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (33, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 33', 'LOT0100045', 16, 7, 7, 19);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (34, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 34', 'LOT0120052', 45, 8, 8, 419);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (35, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 35', 'LOT0120053', 10, 8, 8, 405);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (36, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 36', 'LOT0120054', 19, 8, 8, 404);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (37, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 37', 'LOT0120055', 14, 8, 8, 407);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (38, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 38', 'LOT0120056', 5, 8, 8, 408);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (39, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 39', 'LOT0140064', 18, 9, 9, 563);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (40, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 40', 'LOT0140065', 32, 9, 9, 567);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (41, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 41', 'LOT0140066', 12, 9, 9, 585);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (42, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 42', 'LOT0140067', 17, 9, 9, 581);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (43, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 43', 'LOT0140068', 32, 9, 9, 592);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (44, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 44', 'LOT0150069', 28, 10, 10, 288);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (45, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 45', 'LOT0150070', 38, 10, 10, 270);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (46, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 46', 'LOT0150071', 21, 10, 10, 280);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (47, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 47', 'LOT0150072', 43, 10, 10, 266);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (48, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 48', 'LOT0150073', 30, 10, 10, 276);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (49, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 49', 'LOT0160074', 12, 11, 11, 636);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (50, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 50', 'LOT0160075', 21, 11, 11, 641);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (51, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 51', 'LOT0160076', 22, 11, 11, 606);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (52, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 52', 'LOT0160077', 37, 11, 11, 601);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (53, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 53', 'LOT0160078', 22, 11, 11, 622);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (54, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 54', 'LOT0180086', 26, 12, 12, 585);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (55, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 55', 'LOT0180087', 42, 12, 12, 584);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (56, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 56', 'LOT0180088', 15, 12, 12, 571);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (57, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 57', 'LOT0180089', 20, 12, 12, 575);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (58, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 58', 'LOT0180090', 15, 12, 12, 569);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (59, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 59', 'LOT0180091', 28, 12, 12, 561);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (60, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 60', 'LOT0190092', 20, 13, 13, 924);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (61, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 61', 'LOT0190093', 31, 13, 13, 913);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (62, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 62', 'LOT0200094', 27, 14, 14, 110);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (63, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 63', 'LOT0200095', 50, 14, 14, 123);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (64, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 64', 'LOT0200096', 9, 14, 14, 104);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (65, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 65', 'LOT0200097', 38, 14, 14, 129);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (66, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 66', 'LOT0200098', 48, 14, 14, 141);
INSERT INTO inventory (id, created_at, updated_at, description, lot_number, quantity, inbound_id, location_id, product_id) VALUES (67, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Stock for inbound item 67', 'LOT0200099', 6, 14, 14, 139);

-- orders
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (1, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 1', '2024-09-10 09:00:00', 'ORD001', '2024-08-21 09:00:00', 'REQUESTED', 1);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (2, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 2', '2024-09-11 09:00:00', 'ORD002', '2024-08-22 09:00:00', 'CANCELLED', 2);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (3, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 3', '2024-09-12 09:00:00', 'ORD003', '2024-08-23 09:00:00', 'CANCELLED', 3);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (4, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 4', '2024-09-13 09:00:00', 'ORD004', '2024-08-24 09:00:00', 'SHIPPED', 4);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (5, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 5', '2024-09-14 09:00:00', 'ORD005', '2024-08-25 09:00:00', 'APPROVED', 5);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (6, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 6', '2024-09-15 09:00:00', 'ORD006', '2024-08-26 09:00:00', 'APPROVED', 6);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (7, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 7', '2024-09-16 09:00:00', 'ORD007', '2024-08-27 09:00:00', 'CANCELLED', 7);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (8, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 8', '2024-09-17 09:00:00', 'ORD008', '2024-08-28 09:00:00', 'SHIPPED', 8);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (9, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 9', '2024-09-18 09:00:00', 'ORD009', '2024-08-29 09:00:00', 'DELIVERED', 9);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (10, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 10', '2024-09-19 09:00:00', 'ORD010', '2024-08-30 09:00:00', 'APPROVED', 10);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (11, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 11', '2024-09-20 09:00:00', 'ORD011', '2024-08-31 09:00:00', 'CANCELLED', 11);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (12, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 12', '2024-09-21 09:00:00', 'ORD012', '2024-09-01 09:00:00', 'SHIPPED', 12);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (13, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 13', '2024-09-22 09:00:00', 'ORD013', '2024-09-02 09:00:00', 'SHIPPED', 13);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (14, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 14', '2024-09-23 09:00:00', 'ORD014', '2024-09-03 09:00:00', 'CANCELLED', 14);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (15, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 15', '2024-09-24 09:00:00', 'ORD015', '2024-09-04 09:00:00', 'APPROVED', 15);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (16, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 16', '2024-09-25 09:00:00', 'ORD016', '2024-09-05 09:00:00', 'SHIPPED', 16);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (17, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 17', '2024-09-26 09:00:00', 'ORD017', '2024-09-06 09:00:00', 'SHIPPED', 17);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (18, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 18', '2024-09-27 09:00:00', 'ORD018', '2024-09-07 09:00:00', 'REQUESTED', 18);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (19, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 19', '2024-09-28 09:00:00', 'ORD019', '2024-09-08 09:00:00', 'DELIVERED', 19);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (20, '2024-08-30 09:00:00', '2024-08-30 09:00:00', 'Order description 20', '2024-09-29 09:00:00', 'ORD020', '2024-09-09 09:00:00', 'REQUESTED', 20);

-- order_product_item
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 1', 9, 1, 321);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 2', 13, 1, 105);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 3', 13, 2, 19);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 4', 7, 2, 104);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 5', 8, 2, 133);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 6', 6, 2, 913);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 7', 9, 2, 101);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 8', 2, 2, 321);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 9', 17, 2, 25);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 10', 2, 3, 101);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 11', 2, 3, 150);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 12', 7, 3, 518);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 13', 3, 3, 585);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 14', 19, 3, 592);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (15, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 15', 20, 3, 536);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (16, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 16', 17, 3, 405);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (17, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 17', 16, 4, 407);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (18, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 18', 2, 4, 518);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (19, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 19', 3, 4, 19);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (20, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 20', 19, 4, 336);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (21, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 21', 20, 4, 641);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (22, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 22', 3, 4, 292);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (23, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 23', 9, 5, 304);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (24, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 24', 11, 5, 584);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (25, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 25', 4, 5, 720);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (26, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 26', 17, 6, 291);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (27, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 27', 13, 6, 536);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (28, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 28', 14, 6, 349);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (29, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 29', 6, 6, 701);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (30, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 30', 1, 7, 291);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (31, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 31', 15, 7, 139);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (32, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 32', 10, 8, 585);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (33, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 33', 13, 8, 298);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (34, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 34', 2, 8, 304);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (35, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 35', 15, 8, 139);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (36, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 36', 17, 9, 276);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (37, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 37', 19, 9, 571);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (38, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 38', 9, 9, 561);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (39, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 39', 8, 9, 19);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (40, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 40', 12, 9, 141);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (41, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 41', 3, 9, 569);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (42, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 42', 5, 9, 104);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (43, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 43', 12, 10, 622);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (44, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 44', 15, 10, 561);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (45, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 45', 20, 10, 289);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (46, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 46', 16, 10, 321);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (47, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 47', 10, 10, 585);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (48, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 48', 12, 10, 25);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (49, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 49', 5, 10, 105);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (50, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 50', 9, 11, 544);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (51, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 51', 12, 11, 150);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (52, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 52', 9, 12, 131);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (53, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 53', 18, 12, 518);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (54, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 54', 18, 13, 571);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (55, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 55', 18, 13, 280);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (56, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 56', 20, 13, 289);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (57, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 57', 1, 13, 25);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (58, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 58', 1, 13, 298);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (59, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 59', 4, 13, 349);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (60, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 60', 14, 13, 622);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (61, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 61', 19, 14, 303);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (62, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 62', 5, 14, 571);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (63, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 63', 19, 14, 404);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (64, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 64', 20, 14, 321);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (65, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 65', 11, 15, 720);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (66, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 66', 3, 15, 641);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (67, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 67', 1, 15, 407);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (68, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 68', 10, 15, 129);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (69, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 69', 2, 15, 585);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (70, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 70', 7, 15, 278);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (71, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 71', 7, 15, 419);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (72, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 72', 18, 16, 567);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (73, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 73', 14, 16, 129);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (74, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 74', 5, 16, 270);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (75, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 75', 18, 16, 701);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (76, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 76', 6, 16, 585);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (77, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 77', 12, 16, 518);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (78, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 78', 19, 16, 336);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (79, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 79', 5, 17, 544);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (80, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 80', 7, 17, 575);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (81, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 81', 20, 18, 522);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (82, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 82', 2, 18, 585);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (83, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 83', 14, 18, 601);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (84, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 84', 8, 18, 571);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (85, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 85', 13, 18, 720);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (86, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 86', 5, 18, 584);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (87, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 87', 7, 18, 404);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (88, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 88', 19, 19, 289);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (89, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 89', 10, 19, 601);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (90, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 90', 15, 20, 298);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (91, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 91', 10, 20, 278);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (92, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 92', 16, 20, 536);
INSERT INTO order_product_item (id, created_at, updated_at, description, ordered_quantity, order_id, product_id) VALUES (93, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Order item 93', 12, 20, 924);

-- outbound
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 1', 'OUT001', 'SALE', '2024-10-20 09:00:00', 'APPROVED', 1, 1);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 3', 'OUT003', 'SALE', '2024-10-22 09:00:00', 'PACKING', 3, 3);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 4', 'OUT004', 'SALE', '2024-10-23 09:00:00', 'PICKING', 4, 4);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 7', 'OUT007', 'SALE', '2024-10-26 09:00:00', 'APPROVED', 7, 7);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 8', 'OUT008', 'SALE', '2024-10-27 09:00:00', 'PICKING', 8, 8);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 12', 'OUT012', 'SALE', '2024-10-31 09:00:00', 'APPROVED', 12, 12);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 13', 'OUT013', 'SALE', '2024-11-01 09:00:00', 'PICKING', 13, 13);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 14', 'OUT014', 'SALE', '2024-11-02 09:00:00', 'PICKING', 14, 14);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 15', 'OUT015', 'SALE', '2024-11-03 09:00:00', 'SHIPPED', 15, 15);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 16', 'OUT016', 'SALE', '2024-11-04 09:00:00', 'SHIPPED', 16, 16);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 18', 'OUT018', 'SALE', '2024-11-06 09:00:00', 'SHIPPED', 18, 18);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 19', 'OUT019', 'SALE', '2024-11-07 09:00:00', 'PACKING', 19, 19);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Outbound for order 20', 'OUT020', 'SALE', '2024-11-08 09:00:00', 'APPROVED', 20, 20);

-- task (picking) and picking_task
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (29, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 1', 1, '2024-06-02 11:00:00', 'ASSIGNED', 1);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (29, 1, 29);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (30, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 2', 2, '2024-06-02 11:00:00', 'ASSIGNED', 2);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (30, 2, 30);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (31, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 3', 3, '2024-06-02 11:00:00', 'ASSIGNED', 3);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (31, 3, 31);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (32, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 4', 4, '2024-06-02 11:00:00', 'ASSIGNED', 4);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (32, 4, 32);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (33, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 5', 5, '2024-06-02 11:00:00', 'ASSIGNED', 5);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (33, 5, 33);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (34, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 6', 6, '2024-06-02 11:00:00', 'ASSIGNED', 6);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (34, 6, 34);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (35, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 7', 7, '2024-06-02 11:00:00', 'ASSIGNED', 7);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (35, 7, 35);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (36, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 8', 8, '2024-06-02 11:00:00', 'ASSIGNED', 8);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (36, 8, 36);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (37, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 9', 9, '2024-06-02 11:00:00', 'ASSIGNED', 9);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (37, 9, 37);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (38, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 10', 10, '2024-06-02 11:00:00', 'ASSIGNED', 10);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (38, 10, 38);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (39, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 11', 11, '2024-06-02 11:00:00', 'ASSIGNED', 11);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (39, 11, 39);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (40, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 12', 12, '2024-06-02 11:00:00', 'ASSIGNED', 12);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (40, 12, 40);
INSERT INTO task (id, created_at, updated_at, assigned_at, category, completed_at, note, reference_id, started_at, status, member_id) VALUES (41, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '2024-06-02 09:00:00', 'PICKING', NULL, 'Picking for outbound 13', 13, '2024-06-02 11:00:00', 'ASSIGNED', 13);
INSERT INTO picking_task (id, outbound_id, task_id) VALUES (41, 13, 41);

-- outbound_product_item
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (1, 'Outbound item 1', 'LOC0002', 9, 1, 1, 321);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (2, 'Outbound item 2', 'LOC0002', 13, 2, 1, 105);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (3, 'Outbound item 3', 'LOC0003', 2, 10, 2, 101);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (4, 'Outbound item 4', 'LOC0003', 2, 11, 2, 150);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (5, 'Outbound item 5', 'LOC0003', 7, 12, 2, 518);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (6, 'Outbound item 6', 'LOC0003', 3, 13, 2, 585);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (7, 'Outbound item 7', 'LOC0003', 19, 14, 2, 592);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (8, 'Outbound item 8', 'LOC0003', 20, 15, 2, 536);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (9, 'Outbound item 9', 'LOC0003', 17, 16, 2, 405);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (10, 'Outbound item 10', 'LOC0004', 16, 17, 3, 407);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (11, 'Outbound item 11', 'LOC0004', 2, 18, 3, 518);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (12, 'Outbound item 12', 'LOC0004', 3, 19, 3, 19);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (13, 'Outbound item 13', 'LOC0004', 19, 20, 3, 336);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (14, 'Outbound item 14', 'LOC0004', 20, 21, 3, 641);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (15, 'Outbound item 15', 'LOC0004', 3, 22, 3, 292);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (16, 'Outbound item 16', 'LOC0005', 1, 30, 4, 291);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (17, 'Outbound item 17', 'LOC0005', 15, 31, 4, 139);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (18, 'Outbound item 18', 'LOC0006', 10, 32, 5, 585);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (19, 'Outbound item 19', 'LOC0006', 13, 33, 5, 298);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (20, 'Outbound item 20', 'LOC0006', 2, 34, 5, 304);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (21, 'Outbound item 21', 'LOC0006', 15, 35, 5, 139);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (22, 'Outbound item 22', 'LOC0007', 9, 52, 6, 131);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (23, 'Outbound item 23', 'LOC0007', 18, 53, 6, 518);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (24, 'Outbound item 24', 'LOC0008', 18, 54, 7, 571);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (25, 'Outbound item 25', 'LOC0008', 18, 55, 7, 280);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (26, 'Outbound item 26', 'LOC0008', 20, 56, 7, 289);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (27, 'Outbound item 27', 'LOC0008', 1, 57, 7, 25);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (28, 'Outbound item 28', 'LOC0008', 1, 58, 7, 298);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (29, 'Outbound item 29', 'LOC0008', 4, 59, 7, 349);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (30, 'Outbound item 30', 'LOC0008', 14, 60, 7, 622);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (31, 'Outbound item 31', 'LOC0009', 19, 61, 8, 303);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (32, 'Outbound item 32', 'LOC0009', 5, 62, 8, 571);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (33, 'Outbound item 33', 'LOC0009', 19, 63, 8, 404);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (34, 'Outbound item 34', 'LOC0009', 20, 64, 8, 321);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (35, 'Outbound item 35', 'LOC0010', 11, 65, 9, 720);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (36, 'Outbound item 36', 'LOC0010', 3, 66, 9, 641);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (37, 'Outbound item 37', 'LOC0010', 1, 67, 9, 407);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (38, 'Outbound item 38', 'LOC0010', 10, 68, 9, 129);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (39, 'Outbound item 39', 'LOC0010', 2, 69, 9, 585);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (40, 'Outbound item 40', 'LOC0010', 7, 70, 9, 278);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (41, 'Outbound item 41', 'LOC0010', 7, 71, 9, 419);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (42, 'Outbound item 42', 'LOC0011', 18, 72, 10, 567);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (43, 'Outbound item 43', 'LOC0011', 14, 73, 10, 129);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (44, 'Outbound item 44', 'LOC0011', 5, 74, 10, 270);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (45, 'Outbound item 45', 'LOC0011', 18, 75, 10, 701);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (46, 'Outbound item 46', 'LOC0011', 6, 76, 10, 585);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (47, 'Outbound item 47', 'LOC0011', 12, 77, 10, 518);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (48, 'Outbound item 48', 'LOC0011', 19, 78, 10, 336);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (49, 'Outbound item 49', 'LOC0012', 20, 81, 11, 522);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (50, 'Outbound item 50', 'LOC0012', 2, 82, 11, 585);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (51, 'Outbound item 51', 'LOC0012', 14, 83, 11, 601);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (52, 'Outbound item 52', 'LOC0012', 8, 84, 11, 571);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (53, 'Outbound item 53', 'LOC0012', 13, 85, 11, 720);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (54, 'Outbound item 54', 'LOC0012', 5, 86, 11, 584);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (55, 'Outbound item 55', 'LOC0012', 7, 87, 11, 404);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (56, 'Outbound item 56', 'LOC0013', 19, 88, 12, 289);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (57, 'Outbound item 57', 'LOC0013', 10, 89, 12, 601);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (58, 'Outbound item 58', 'LOC0014', 15, 90, 13, 298);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (59, 'Outbound item 59', 'LOC0014', 10, 91, 13, 278);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (60, 'Outbound item 60', 'LOC0014', 16, 92, 13, 536);
INSERT INTO outbound_product_item (id, description, location_code, ordered_quantity, order_product_item_id, outbound_id, product_id) VALUES (61, 'Outbound item 61', 'LOC0014', 12, 93, 13, 924);

-- outbound_inventory_history
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (1, 'LOT-OB-00001', 9, 'PENDING', 29, 6, 1, 1, 321);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (2, 'LOT-OB-00002', 13, 'CANCELLED', 29, 23, 4, 1, 105);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (3, 'LOT-OB-00003', 2, 'CANCELLED', 30, 20, 4, 2, 101);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (4, 'LOT-OB-00004', 2, 'COMPLETED', 30, 21, 4, 2, 150);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (5, 'LOT-OB-00005', 7, 'COMPLETED', 30, 29, 6, 2, 518);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (6, 'LOT-OB-00006', 3, 'CANCELLED', 30, 41, 9, 2, 585);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (7, 'LOT-OB-00007', 19, 'CANCELLED', 30, 43, 9, 2, 592);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (8, 'LOT-OB-00008', 20, 'COMPLETED', 30, 28, 6, 2, 536);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (9, 'LOT-OB-00009', 17, 'CANCELLED', 30, 35, 8, 2, 405);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (10, 'LOT-OB-00010', 16, 'COMPLETED', 31, 37, 8, 3, 407);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (11, 'LOT-OB-00011', 2, 'CANCELLED', 31, 29, 6, 3, 518);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (12, 'LOT-OB-00012', 3, 'COMPLETED', 31, 33, 7, 3, 19);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (13, 'LOT-OB-00013', 19, 'PENDING', 31, 1, 1, 3, 336);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (14, 'LOT-OB-00014', 20, 'COMPLETED', 31, 50, 11, 3, 641);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (15, 'LOT-OB-00015', 3, 'CANCELLED', 31, 11, 2, 3, 292);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (16, 'LOT-OB-00016', 1, 'PENDING', 32, 8, 2, 4, 291);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (17, 'LOT-OB-00017', 15, 'COMPLETED', 32, 67, 14, 4, 139);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (18, 'LOT-OB-00018', 10, 'PENDING', 33, 54, 12, 5, 585);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (19, 'LOT-OB-00019', 13, 'COMPLETED', 33, 24, 5, 5, 298);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (20, 'LOT-OB-00020', 2, 'COMPLETED', 33, 7, 1, 5, 304);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (21, 'LOT-OB-00021', 15, 'CANCELLED', 33, 67, 14, 5, 139);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (22, 'LOT-OB-00022', 9, 'PENDING', 34, 19, 4, 6, 131);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (23, 'LOT-OB-00023', 18, 'COMPLETED', 34, 29, 6, 6, 518);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (24, 'LOT-OB-00024', 18, 'CANCELLED', 35, 56, 12, 7, 571);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (25, 'LOT-OB-00025', 18, 'PENDING', 35, 46, 10, 7, 280);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (26, 'LOT-OB-00026', 20, 'COMPLETED', 35, 9, 2, 7, 289);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (27, 'LOT-OB-00027', 1, 'CANCELLED', 35, 32, 7, 7, 25);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (28, 'LOT-OB-00028', 1, 'COMPLETED', 35, 24, 5, 7, 298);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (29, 'LOT-OB-00029', 4, 'CANCELLED', 35, 5, 1, 7, 349);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (30, 'LOT-OB-00030', 14, 'CANCELLED', 35, 53, 11, 7, 622);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (31, 'LOT-OB-00031', 19, 'PENDING', 36, 3, 1, 8, 303);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (32, 'LOT-OB-00032', 5, 'PENDING', 36, 56, 12, 8, 571);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (33, 'LOT-OB-00033', 19, 'PENDING', 36, 36, 8, 8, 404);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (34, 'LOT-OB-00034', 20, 'CANCELLED', 36, 6, 1, 8, 321);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (35, 'LOT-OB-00035', 11, 'PENDING', 37, 15, 3, 9, 720);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (36, 'LOT-OB-00036', 3, 'CANCELLED', 37, 50, 11, 9, 641);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (37, 'LOT-OB-00037', 1, 'CANCELLED', 37, 37, 8, 9, 407);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (38, 'LOT-OB-00038', 10, 'COMPLETED', 37, 65, 14, 9, 129);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (39, 'LOT-OB-00039', 2, 'COMPLETED', 37, 41, 9, 9, 585);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (40, 'LOT-OB-00040', 7, 'PENDING', 37, 25, 5, 9, 278);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (41, 'LOT-OB-00041', 7, 'CANCELLED', 37, 34, 8, 9, 419);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (42, 'LOT-OB-00042', 18, 'PENDING', 38, 40, 9, 10, 567);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (43, 'LOT-OB-00043', 14, 'PENDING', 38, 65, 14, 10, 129);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (44, 'LOT-OB-00044', 5, 'CANCELLED', 38, 45, 10, 10, 270);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (45, 'LOT-OB-00045', 18, 'COMPLETED', 38, 16, 3, 10, 701);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (46, 'LOT-OB-00046', 6, 'PENDING', 38, 41, 9, 10, 585);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (47, 'LOT-OB-00047', 12, 'COMPLETED', 38, 29, 6, 10, 518);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (48, 'LOT-OB-00048', 19, 'COMPLETED', 38, 1, 1, 10, 336);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (49, 'LOT-OB-00049', 20, 'COMPLETED', 39, 30, 6, 11, 522);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (50, 'LOT-OB-00050', 2, 'COMPLETED', 39, 41, 9, 11, 585);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (51, 'LOT-OB-00051', 14, 'COMPLETED', 39, 52, 11, 11, 601);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (52, 'LOT-OB-00052', 8, 'COMPLETED', 39, 56, 12, 11, 571);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (53, 'LOT-OB-00053', 13, 'PENDING', 39, 15, 3, 11, 720);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (54, 'LOT-OB-00054', 5, 'COMPLETED', 39, 55, 12, 11, 584);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (55, 'LOT-OB-00055', 7, 'PENDING', 39, 36, 8, 11, 404);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (56, 'LOT-OB-00056', 19, 'PENDING', 40, 9, 2, 12, 289);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (57, 'LOT-OB-00057', 10, 'CANCELLED', 40, 52, 11, 12, 601);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (58, 'LOT-OB-00058', 15, 'COMPLETED', 41, 24, 5, 13, 298);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (59, 'LOT-OB-00059', 10, 'PENDING', 41, 25, 5, 13, 278);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (60, 'LOT-OB-00060', 16, 'CANCELLED', 41, 28, 6, 13, 536);
INSERT INTO outbound_inventory_history (id, lot_number, quantity_changed, status, task_id, inventory_id, location_id, outbound_id, product_id) VALUES (61, 'LOT-OB-00061', 12, 'COMPLETED', 41, 60, 13, 13, 924);

-- product_status_history
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (1, '2024-06-12 09:00:00', '2024-06-12 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_001', 1);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (2, '2024-06-13 09:00:00', '2024-06-13 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_002', 2);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (3, '2024-06-14 09:00:00', '2024-06-14 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_003', 3);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (4, '2024-06-15 09:00:00', '2024-06-15 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_004', 4);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (5, '2024-06-16 09:00:00', '2024-06-16 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_005', 5);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (6, '2024-06-17 09:00:00', '2024-06-17 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_006', 6);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (7, '2024-06-18 09:00:00', '2024-06-18 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_007', 7);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (8, '2024-06-19 09:00:00', '2024-06-19 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_008', 8);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (9, '2024-06-20 09:00:00', '2024-06-20 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_009', 9);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (10, '2024-06-21 09:00:00', '2024-06-21 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_010', 10);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (11, '2024-06-22 09:00:00', '2024-06-22 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_011', 11);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (12, '2024-06-23 09:00:00', '2024-06-23 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_012', 12);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (13, '2024-06-24 09:00:00', '2024-06-24 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_013', 13);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (14, '2024-06-25 09:00:00', '2024-06-25 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_014', 14);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (15, '2024-06-26 09:00:00', '2024-06-26 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_015', 15);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (16, '2024-06-27 09:00:00', '2024-06-27 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_016', 16);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (17, '2024-06-28 09:00:00', '2024-06-28 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_017', 17);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (18, '2024-06-29 09:00:00', '2024-06-29 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_018', 18);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (19, '2024-06-30 09:00:00', '2024-06-30 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_019', 19);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (20, '2024-07-01 09:00:00', '2024-07-01 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_020', 20);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (21, '2024-07-02 09:00:00', '2024-07-02 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_021', 21);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (22, '2024-07-03 09:00:00', '2024-07-03 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_022', 22);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (23, '2024-07-04 09:00:00', '2024-07-04 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_023', 23);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (24, '2024-07-05 09:00:00', '2024-07-05 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_024', 24);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (25, '2024-07-06 09:00:00', '2024-07-06 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_025', 25);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (26, '2024-07-07 09:00:00', '2024-07-07 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_026', 26);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (27, '2024-07-08 09:00:00', '2024-07-08 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_027', 27);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (28, '2024-07-09 09:00:00', '2024-07-09 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_028', 28);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (29, '2024-07-10 09:00:00', '2024-07-10 09:00:00', 'system', 'INACTIVE', 'ACTIVE', 'Product_029', 29);
INSERT INTO product_status_history (id, created_at, updated_at, changed_by, new_status, old_status, product_name, product_id) VALUES (30, '2024-07-11 09:00:00', '2024-07-11 09:00:00', 'system', 'DISCONTINUED', 'ACTIVE', 'Product_030', 30);

-- image
INSERT INTO image (id, file_name, product_id) VALUES (1, 'img_001.jpg', 1);
INSERT INTO image (id, file_name, product_id) VALUES (2, 'img_002.jpg', 2);
INSERT INTO image (id, file_name, product_id) VALUES (3, 'img_003.jpg', 3);
INSERT INTO image (id, file_name, product_id) VALUES (4, 'img_004.jpg', 4);
INSERT INTO image (id, file_name, product_id) VALUES (5, 'img_005.jpg', 5);
INSERT INTO image (id, file_name, product_id) VALUES (6, 'img_006.jpg', 6);
INSERT INTO image (id, file_name, product_id) VALUES (7, 'img_007.jpg', 7);
INSERT INTO image (id, file_name, product_id) VALUES (8, 'img_008.jpg', 8);
INSERT INTO image (id, file_name, product_id) VALUES (9, 'img_009.jpg', 9);
INSERT INTO image (id, file_name, product_id) VALUES (10, 'img_010.jpg', 10);
INSERT INTO image (id, file_name, product_id) VALUES (11, 'img_011.jpg', 11);
INSERT INTO image (id, file_name, product_id) VALUES (12, 'img_012.jpg', 12);
INSERT INTO image (id, file_name, product_id) VALUES (13, 'img_013.jpg', 13);
INSERT INTO image (id, file_name, product_id) VALUES (14, 'img_014.jpg', 14);
INSERT INTO image (id, file_name, product_id) VALUES (15, 'img_015.jpg', 15);
INSERT INTO image (id, file_name, product_id) VALUES (16, 'img_016.jpg', 16);
INSERT INTO image (id, file_name, product_id) VALUES (17, 'img_017.jpg', 17);
INSERT INTO image (id, file_name, product_id) VALUES (18, 'img_018.jpg', 18);
INSERT INTO image (id, file_name, product_id) VALUES (19, 'img_019.jpg', 19);
INSERT INTO image (id, file_name, product_id) VALUES (20, 'img_020.jpg', 20);

-- announcement
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (1, '2024-06-12 09:00:00', '2024-06-12 09:00:00', b'0', 'Content 1', 'System', b'0', 'Announcement 1');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (2, '2024-06-13 09:00:00', '2024-06-13 09:00:00', b'1', 'Content 2', 'System', b'0', 'Announcement 2');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (3, '2024-06-14 09:00:00', '2024-06-14 09:00:00', b'0', 'Content 3', 'System', b'0', 'Announcement 3');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (4, '2024-06-15 09:00:00', '2024-06-15 09:00:00', b'1', 'Content 4', 'System', b'0', 'Announcement 4');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (5, '2024-06-16 09:00:00', '2024-06-16 09:00:00', b'0', 'Content 5', 'System', b'1', 'Announcement 5');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (6, '2024-06-17 09:00:00', '2024-06-17 09:00:00', b'1', 'Content 6', 'System', b'0', 'Announcement 6');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (7, '2024-06-18 09:00:00', '2024-06-18 09:00:00', b'0', 'Content 7', 'System', b'0', 'Announcement 7');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (8, '2024-06-19 09:00:00', '2024-06-19 09:00:00', b'1', 'Content 8', 'System', b'0', 'Announcement 8');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (9, '2024-06-20 09:00:00', '2024-06-20 09:00:00', b'0', 'Content 9', 'System', b'0', 'Announcement 9');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (10, '2024-06-21 09:00:00', '2024-06-21 09:00:00', b'1', 'Content 10', 'System', b'1', 'Announcement 10');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (11, '2024-06-22 09:00:00', '2024-06-22 09:00:00', b'0', 'Content 11', 'System', b'0', 'Announcement 11');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (12, '2024-06-23 09:00:00', '2024-06-23 09:00:00', b'1', 'Content 12', 'System', b'0', 'Announcement 12');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (13, '2024-06-24 09:00:00', '2024-06-24 09:00:00', b'0', 'Content 13', 'System', b'0', 'Announcement 13');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (14, '2024-06-25 09:00:00', '2024-06-25 09:00:00', b'1', 'Content 14', 'System', b'0', 'Announcement 14');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (15, '2024-06-26 09:00:00', '2024-06-26 09:00:00', b'0', 'Content 15', 'System', b'1', 'Announcement 15');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (16, '2024-06-27 09:00:00', '2024-06-27 09:00:00', b'1', 'Content 16', 'System', b'0', 'Announcement 16');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (17, '2024-06-28 09:00:00', '2024-06-28 09:00:00', b'0', 'Content 17', 'System', b'0', 'Announcement 17');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (18, '2024-06-29 09:00:00', '2024-06-29 09:00:00', b'1', 'Content 18', 'System', b'0', 'Announcement 18');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (19, '2024-06-30 09:00:00', '2024-06-30 09:00:00', b'0', 'Content 19', 'System', b'0', 'Announcement 19');
INSERT INTO announcement (id, created_at, updated_at, active, content, name, pinned, title) VALUES (20, '2024-07-01 09:00:00', '2024-07-01 09:00:00', b'1', 'Content 20', 'System', b'1', 'Announcement 20');

-- notification
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 1', '2024-10-30 09:00:00', 'READ', 1, 1, 1, 1);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 2', '2024-10-31 09:00:00', 'READ', 2, 2, 2, 2);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 3', '2024-11-01 09:00:00', 'UNREAD', 3, 3, 3, 3);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 4', '2024-11-02 09:00:00', 'UNREAD', 4, 4, 4, 4);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 5', '2024-11-03 09:00:00', 'READ', 5, 5, 5, 5);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 6', '2024-11-04 09:00:00', 'UNREAD', 6, 6, 6, 6);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 7', '2024-11-05 09:00:00', 'UNREAD', 7, 7, 7, 7);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 8', '2024-11-06 09:00:00', 'UNREAD', 8, 8, 8, 8);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 9', '2024-11-07 09:00:00', 'UNREAD', 9, 9, 9, 9);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 10', '2024-11-08 09:00:00', 'READ', 10, 10, 10, 10);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 11', '2024-11-09 09:00:00', 'UNREAD', 11, 11, 11, 11);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 12', '2024-11-10 09:00:00', 'READ', 12, 12, 12, 12);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 13', '2024-11-11 09:00:00', 'READ', 13, 13, 13, 13);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 14', '2024-11-12 09:00:00', 'UNREAD', 14, 14, 14, 1);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (15, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 15', '2024-11-13 09:00:00', 'READ', 1, 15, 15, 2);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (16, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 16', '2024-11-14 09:00:00', 'READ', 2, 16, 16, 3);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (17, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 17', '2024-11-15 09:00:00', 'READ', 3, 17, 17, 4);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (18, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 18', '2024-11-16 09:00:00', 'UNREAD', 4, 18, 18, 5);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (19, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 19', '2024-11-17 09:00:00', 'UNREAD', 5, 19, 19, 6);
INSERT INTO notification (id, created_at, updated_at, message, read_at, status, inbound_id, inventory_id, member_id, outbound_id) VALUES (20, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'Notification 20', '2024-11-18 09:00:00', 'UNREAD', 6, 20, 20, 7);

SET FOREIGN_KEY_CHECKS=1;
-- END OF DATA
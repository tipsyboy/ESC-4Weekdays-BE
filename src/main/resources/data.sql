-- data_full_latest.sql (generated for 'four_weekdays')

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
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (1, '2024-06-02 09:00:00', '2024-06-02 09:00:00', '서울특별시 용산구', 'Korea', '아모레퍼시픽 본사 100호', '한강대로', '04386', 'API_KEY_V_20240602_BZFQY2', '아모레퍼시픽 화장품 제조 및 유통', '아모레퍼시픽@cosmetic.com', '아모레퍼시픽', '010-1000-0001', 'ACTIVE', 'V-20240602-BZFQY2');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (2, '2024-06-03 09:00:00', '2024-06-03 09:00:00', '서울특별시 강서구', 'Korea', 'LG사이언스파크 71호', '마곡중앙8로', '07795', 'API_KEY_V_20240603_OT5GIB', 'LG생활건강 화장품 제조 및 유통', 'lg생활건강@cosmetic.com', 'LG생활건강', '010-1000-0002', 'ACTIVE', 'V-20240603-OT5GIB');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (3, '2024-06-04 09:00:00', '2024-06-04 09:00:00', '서울특별시 강남구', 'Korea', '토니모리타워 501호', '테헤란로', '06164', 'API_KEY_V_20240604_JRCMCA', '토니모리 화장품 제조 및 유통', '토니모리@cosmetic.com', '토니모리', '010-1000-0003', 'ACTIVE', 'V-20240604-JRCMCA');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (4, '2024-06-05 09:00:00', '2024-06-05 09:00:00', '서울특별시 강남구', 'Korea', '미샤빌딩 861호', '논현로', '06048', 'API_KEY_V_20240605_5OV4IS', '미샤 화장품 제조 및 유통', '미샤@cosmetic.com', '미샤', '010-1000-0004', 'ACTIVE', 'V-20240605-5OV4IS');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (5, '2024-06-06 09:00:00', '2024-06-06 09:00:00', '서울특별시 강남구', 'Korea', '더페이스샵타워 156호', '역삼로', '06253', 'API_KEY_V_20240606_MPQMSO', '더페이스샵 화장품 제조 및 유통', '더페이스샵@cosmetic.com', '더페이스샵', '010-1000-0005', 'ACTIVE', 'V-20240606-MPQMSO');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (6, '2024-06-07 09:00:00', '2024-06-07 09:00:00', '제주특별자치도 서귀포시', 'Korea', '이니스프리 제주하우스 1100호', '안덕면', '63521', 'API_KEY_V_20240607_TEZK7G', '이니스프리 화장품 제조 및 유통', '이니스프리@cosmetic.com', '이니스프리', '010-1000-0006', 'ACTIVE', 'V-20240607-TEZK7G');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (7, '2024-06-08 09:00:00', '2024-06-08 09:00:00', '서울특별시 중구', 'Korea', '에뛰드하우스 본사 281호', '을지로', '04560', 'API_KEY_V_20240608_COD1SB', '에뛰드하우스 화장품 제조 및 유통', '에뛰드하우스@cosmetic.com', '에뛰드하우스', '010-1000-0007', 'ACTIVE', 'V-20240608-COD1SB');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (8, '2024-06-09 09:00:00', '2024-06-09 09:00:00', '서울특별시 강남구', 'Korea', '스킨푸드빌딩 512호', '삼성로', '06174', 'API_KEY_V_20240609_RJWIR8', '스킨푸드 화장품 제조 및 유통', '스킨푸드@cosmetic.com', '스킨푸드', '010-1000-0008', 'ACTIVE', 'V-20240609-RJWIR8');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (9, '2024-06-10 09:00:00', '2024-06-10 09:00:00', '서울특별시 서초구', 'Korea', '네이처리퍼블릭 본사 235호', '반포대로', '06578', 'API_KEY_V_20240610_ISF3IT', '네이처리퍼블릭 화장품 제조 및 유통', '네이처리퍼블릭@cosmetic.com', '네이처리퍼블릭', '010-1000-0009', 'ACTIVE', 'V-20240610-ISF3IT');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (10, '2024-06-11 09:00:00', '2024-06-11 09:00:00', '서울특별시 강남구', 'Korea', '더샘빌딩 396호', '강남대로', '06232', 'API_KEY_V_20240611_9B0R7O', '더샘 화장품 제조 및 유통', '더샘@cosmetic.com', '더샘', '010-1000-0010', 'ACTIVE', 'V-20240611-9B0R7O');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (11, '2024-06-12 09:00:00', '2024-06-12 09:00:00', '서울특별시 송파구', 'Korea', '코스알엑스 본사 201호', '송파대로', '05854', 'API_KEY_V_20240612_W6QZ7S', '코스알엑스 화장품 제조 및 유통', '코스알엑스@cosmetic.com', '코스알엑스', '010-1000-0011', 'ACTIVE', 'V-20240612-W6QZ7S');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (12, '2024-06-13 09:00:00', '2024-06-13 09:00:00', '서울특별시 중구', 'Korea', '메디힐빌딩 100호', '청계천로', '04520', 'API_KEY_V_20240613_6EUR8N', '메디힐 화장품 제조 및 유통', '메디힐@cosmetic.com', '메디힐', '010-1000-0012', 'ACTIVE', 'V-20240613-6EUR8N');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (13, '2024-06-14 09:00:00', '2024-06-14 09:00:00', '서울특별시 강남구', 'Korea', 'CNP차앤박 본사 524호', '봉은사로', '06117', 'API_KEY_V_20240614_D8F040', 'CNP차앤박 화장품 제조 및 유통', 'cnp차앤박@cosmetic.com', 'CNP차앤박', '010-1000-0013', 'ACTIVE', 'V-20240614-D8F040');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (14, '2024-06-15 09:00:00', '2024-06-15 09:00:00', '서울특별시 강남구', 'Korea', '닥터지빌딩 108호', '테헤란로', '06173', 'API_KEY_V_20240615_8URS19', '닥터지 화장품 제조 및 유통', '닥터지@cosmetic.com', '닥터지', '010-1000-0014', 'ACTIVE', 'V-20240615-8URS19');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (15, '2024-06-16 09:00:00', '2024-06-16 09:00:00', '서울특별시 송파구', 'Korea', '클리오 본사 300호', '올림픽로', '05551', 'API_KEY_V_20240616_BVAS9K', '클리오 화장품 제조 및 유통', '클리오@cosmetic.com', '클리오', '010-1000-0015', 'ACTIVE', 'V-20240616-BVAS9K');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (16, '2024-06-17 09:00:00', '2024-06-17 09:00:00', '서울특별시 강남구', 'Korea', '아리따움 본사 709호', '논현로', '06039', 'API_KEY_V_20240617_UHX8BQ', '아리따움 화장품 제조 및 유통', '아리따움@cosmetic.com', '아리따움', '010-1000-0016', 'ACTIVE', 'V-20240617-UHX8BQ');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (17, '2024-06-18 09:00:00', '2024-06-18 09:00:00', '서울특별시 마포구', 'Korea', '페리페라 본사 396호', '월드컵북로', '03925', 'API_KEY_V_20240618_I78A4Z', '페리페라 화장품 제조 및 유통', '페리페라@cosmetic.com', '페리페라', '010-1000-0017', 'ACTIVE', 'V-20240618-I78A4Z');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (18, '2024-06-19 09:00:00', '2024-06-19 09:00:00', '서울특별시 강남구', 'Korea', '투쿨포스쿨 본사 551호', '언주로', '06147', 'API_KEY_V_20240619_LUJ3QL', '투쿨포스쿨 화장품 제조 및 유통', '투쿨포스쿨@cosmetic.com', '투쿨포스쿨', '010-1000-0018', 'ACTIVE', 'V-20240619-LUJ3QL');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (19, '2024-06-20 09:00:00', '2024-06-20 09:00:00', '서울특별시 성동구', 'Korea', '바닐라코 본사 222호', '왕십리로', '04768', 'API_KEY_V_20240620_RU3LLY', '바닐라코 화장품 제조 및 유통', '바닐라코@cosmetic.com', '바닐라코', '010-1000-0019', 'ACTIVE', 'V-20240620-RU3LLY');
INSERT INTO vendor (vendor_id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, name, phone_number, status, vendor_code) VALUES (20, '2024-06-21 09:00:00', '2024-06-21 09:00:00', '서울특별시 용산구', 'Korea', '헉슬리 본사 275호', '이태원로', '04348', 'API_KEY_V_20240621_7G8IQ6', '헉슬리 화장품 제조 및 유통', '헉슬리@cosmetic.com', '헉슬리', '010-1000-0020', 'ACTIVE', 'V-20240621-7G8IQ6');

-- product (1000)
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (1, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '립 메이크업 - 립플럼퍼 3ml', '립플럼퍼 3ml', 'P001001', 'ACTIVE', 'EA', 55607, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (2, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 - 그린티 프레시 토너 200ml', '그린티 프레시 토너 200ml', 'P001002', 'ACTIVE', 'EA', 97034, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (3, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 보습 - 세라마이드 크림 80ml', '세라마이드 크림 80ml', 'P001003', 'ACTIVE', 'EA', 2332, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (4, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '마스크팩 - 모공팩 100ml', '모공팩 100ml', 'P001004', 'ACTIVE', 'EA', 40143, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (5, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '헤어케어 - 헤어스프레이 300ml', '헤어스프레이 300ml', 'P001005', 'ACTIVE', 'EA', 49288, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (6, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '베이스 메이크업 - 파우더 쿠션 15g', '파우더 쿠션 15g', 'P001006', 'ACTIVE', 'EA', 26383, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (7, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 보습 - 톤업 선크림 50ml', '톤업 선크림 50ml', 'P001007', 'ACTIVE', 'EA', 36421, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (8, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '클렌징 - 저자극 클렌징폼 150ml', '저자극 클렌징폼 150ml', 'P001008', 'ACTIVE', 'EA', 75187, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (9, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '마스크팩 - 파우더 팩트 10g', '파우더 팩트 10g', 'P001009', 'ACTIVE', 'EA', 58177, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (10, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '립 메이크업 - 립앤아이 리무버 100ml', '립앤아이 리무버 100ml', 'P001010', 'ACTIVE', 'EA', 22192, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (11, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 보습 - 필링젤 120ml', '필링젤 120ml', 'P001011', 'ACTIVE', 'EA', 49898, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (12, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 보습 - 아이크림 30ml', '아이크림 30ml', 'P001012', 'ACTIVE', 'EA', 17287, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (13, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 트리트먼트 200ml', '트리트먼트 200ml', 'P001013', 'ACTIVE', 'EA', 57745, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (14, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '아이 메이크업 - 아이브로우 펜슬 0.3g', '아이브로우 펜슬 0.3g', 'P001014', 'ACTIVE', 'EA', 35221, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (15, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 집중관리 - 시카 리페어 세럼 50ml', '시카 리페어 세럼 50ml', 'P001015', 'ACTIVE', 'EA', 74672, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (16, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '헤어케어 - 헤어왁스 100g', '헤어왁스 100g', 'P001016', 'ACTIVE', 'EA', 83210, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (17, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 보습 - 선크림 SPF50+ 50ml', '선크림 SPF50+ 50ml', 'P001017', 'ACTIVE', 'EA', 23851, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (18, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '립 메이크업 - 립밤 10g', '립밤 10g', 'P001018', 'ACTIVE', 'EA', 81185, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (19, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '클렌징 - 모공케어 클렌징 150ml', '모공케어 클렌징 150ml', 'P001019', 'ACTIVE', 'EA', 73511, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (20, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '아이 메이크업 - 아이 프라이머 10ml', '아이 프라이머 10ml', 'P001020', 'ACTIVE', 'EA', 25485, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (21, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '바디케어 - 바디버터 200ml', '바디버터 200ml', 'P001021', 'ACTIVE', 'EA', 47517, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (22, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '립 메이크업 - 립밤 10g', '립밤 10g', 'P001022', 'ACTIVE', 'EA', 97750, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (23, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '바디케어 - 바디스크럽 200ml', '바디스크럽 200ml', 'P001023', 'ACTIVE', 'EA', 97058, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (24, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 보습 - 맨즈 선크림 50ml', '맨즈 선크림 50ml', 'P001024', 'ACTIVE', 'EA', 12966, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (25, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '베이스 메이크업 - 파우더 쿠션 15g', '파우더 쿠션 15g', 'P001025', 'ACTIVE', 'EA', 70604, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (26, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '클렌징 - 딥클렌징 오일 200ml', '딥클렌징 오일 200ml', 'P001026', 'ACTIVE', 'EA', 97389, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (27, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 보습 - 시카 크림 50ml', '시카 크림 50ml', 'P001027', 'ACTIVE', 'EA', 55017, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (28, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P001028', 'ACTIVE', 'EA', 77683, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (29, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P001029', 'ACTIVE', 'EA', 67051, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (30, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '립 메이크업 - 립글로스 5ml', '립글로스 5ml', 'P001030', 'ACTIVE', 'EA', 22833, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (31, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P001031', 'ACTIVE', 'EA', 20417, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (32, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 - 알로에 수딩 토너 300ml', '알로에 수딩 토너 300ml', 'P001032', 'ACTIVE', 'EA', 27963, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (33, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 보디파우더 100g', '보디파우더 100g', 'P001033', 'ACTIVE', 'EA', 95236, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (34, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 집중관리 - 시카 리페어 세럼 50ml', '시카 리페어 세럼 50ml', 'P001034', 'ACTIVE', 'EA', 11202, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (35, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P001035', 'ACTIVE', 'EA', 25899, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (36, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 집중관리 - 콜라겐 에센스 50ml', '콜라겐 에센스 50ml', 'P001036', 'ACTIVE', 'EA', 45769, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (37, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 커버 컨실러 6ml', '커버 컨실러 6ml', 'P001037', 'ACTIVE', 'EA', 43210, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (38, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 보습 - 미백 크림 50g', '미백 크림 50g', 'P001038', 'ACTIVE', 'EA', 4082, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (39, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P001039', 'ACTIVE', 'EA', 61140, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (40, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '바디케어 - 바디워시 500ml', '바디워시 500ml', 'P001040', 'ACTIVE', 'EA', 45501, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (41, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 집중관리 - 히알루론산 세럼 30ml', '히알루론산 세럼 30ml', 'P001041', 'ACTIVE', 'EA', 4521, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (42, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 블러셔 6g', '블러셔 6g', 'P001042', 'ACTIVE', 'EA', 67939, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (43, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 집중관리 - 맨즈 에센스 50ml', '맨즈 에센스 50ml', 'P001043', 'ACTIVE', 'EA', 91532, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (44, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '클렌징 - 폼클렌징 150ml', '폼클렌징 150ml', 'P001044', 'ACTIVE', 'EA', 98587, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (45, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '스킨케어 - 미셀라워터 500ml', '미셀라워터 500ml', 'P001045', 'ACTIVE', 'EA', 55457, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (46, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '베이스 메이크업 - 파우더 쿠션 15g', '파우더 쿠션 15g', 'P001046', 'ACTIVE', 'EA', 1452, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (47, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 화장솜 80매', '화장솜 80매', 'P001047', 'ACTIVE', 'EA', 1874, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (48, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '립 메이크업 - 립글로스 5ml', '립글로스 5ml', 'P001048', 'ACTIVE', 'EA', 88018, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (49, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '화장품 - 각질제거 패드 60매', '각질제거 패드 60매', 'P001049', 'ACTIVE', 'EA', 22470, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (50, '2024-07-02 09:00:00', '2024-07-02 09:00:00', '클렌징 - 립 글로우 오일 7ml', '립 글로우 오일 7ml', 'P001050', 'ACTIVE', 'EA', 77036, 1);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (51, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '선케어 - 쿨링 선스틱 20g', '쿨링 선스틱 20g', 'P002001', 'ACTIVE', 'EA', 24445, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (52, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P002002', 'ACTIVE', 'EA', 38561, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (53, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '아이 메이크업 - 아이섀도우 팔레트 10색', '아이섀도우 팔레트 10색', 'P002003', 'ACTIVE', 'EA', 14041, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (54, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 보습 - 베이비 선크림 100ml', '베이비 선크림 100ml', 'P002004', 'ACTIVE', 'EA', 86529, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (55, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P002005', 'ACTIVE', 'EA', 55333, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (56, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P002006', 'ACTIVE', 'EA', 14879, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (57, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '클렌징 - 큐티클 오일 5ml', '큐티클 오일 5ml', 'P002007', 'ACTIVE', 'EA', 90314, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (58, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '클렌징 - 모공케어 클렌징 150ml', '모공케어 클렌징 150ml', 'P002008', 'ACTIVE', 'EA', 76770, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (59, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '헤어케어 - 샴푸 500ml', '샴푸 500ml', 'P002009', 'ACTIVE', 'EA', 24809, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (60, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '립 메이크업 - 매트 립크레용 2.5g', '매트 립크레용 2.5g', 'P002010', 'ACTIVE', 'EA', 97545, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (61, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '클렌징 - 네일케어 오일 10ml', '네일케어 오일 10ml', 'P002011', 'ACTIVE', 'EA', 50152, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (62, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 블러셔 6g', '블러셔 6g', 'P002012', 'ACTIVE', 'EA', 31490, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (63, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '클렌징 - 약산성 클렌징폼 120ml', '약산성 클렌징폼 120ml', 'P002013', 'ACTIVE', 'EA', 69628, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (64, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '립 메이크업 - 립 트리트먼트 15g', '립 트리트먼트 15g', 'P002014', 'ACTIVE', 'EA', 79118, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (65, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 퍼프 5개입', '퍼프 5개입', 'P002015', 'ACTIVE', 'EA', 93980, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (66, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '클렌징 - 큐티클 오일 5ml', '큐티클 오일 5ml', 'P002016', 'ACTIVE', 'EA', 44239, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (67, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 보습 - 주름개선 크림 50ml', '주름개선 크림 50ml', 'P002017', 'ACTIVE', 'EA', 6275, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (68, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P002018', 'ACTIVE', 'EA', 31449, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (69, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '클렌징 - 네일케어 오일 10ml', '네일케어 오일 10ml', 'P002019', 'ACTIVE', 'EA', 16702, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (70, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 - 바디미스트 200ml', '바디미스트 200ml', 'P002020', 'ACTIVE', 'EA', 66434, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (71, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 - 그린티 프레시 토너 200ml', '그린티 프레시 토너 200ml', 'P002021', 'ACTIVE', 'EA', 29361, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (72, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 글로우 스틱 8g', '글로우 스틱 8g', 'P002022', 'ACTIVE', 'EA', 97625, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (73, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 보습 - 톤업 선크림 50ml', '톤업 선크림 50ml', 'P002023', 'ACTIVE', 'EA', 73756, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (74, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 속눈썹 집게 1개', '속눈썹 집게 1개', 'P002024', 'ACTIVE', 'EA', 88780, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (75, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '아이 메이크업 - 섀도우 스틱 1.5g', '섀도우 스틱 1.5g', 'P002025', 'ACTIVE', 'EA', 25356, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (76, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 보습 - 선크림 SPF50+ 50ml', '선크림 SPF50+ 50ml', 'P002026', 'ACTIVE', 'EA', 34781, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (77, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 글로우 스틱 8g', '글로우 스틱 8g', 'P002027', 'ACTIVE', 'EA', 78150, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (78, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 집중관리 - 히알루론산 세럼 30ml', '히알루론산 세럼 30ml', 'P002028', 'ACTIVE', 'EA', 57842, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (79, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 맨즈 올인원 150ml', '맨즈 올인원 150ml', 'P002029', 'ACTIVE', 'EA', 68926, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (80, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 집중관리 - 히알루론산 세럼 30ml', '히알루론산 세럼 30ml', 'P002030', 'ACTIVE', 'EA', 18022, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (81, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '클렌징 - 맨즈 클렌징폼 150ml', '맨즈 클렌징폼 150ml', 'P002031', 'ACTIVE', 'EA', 6444, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (82, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 보습 - 콜라겐 크림 50ml', '콜라겐 크림 50ml', 'P002032', 'ACTIVE', 'EA', 22513, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (83, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 - 비타민C 토너 200ml', '비타민C 토너 200ml', 'P002033', 'ACTIVE', 'EA', 40495, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (84, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 두피스케일러 200ml', '두피스케일러 200ml', 'P002034', 'ACTIVE', 'EA', 2226, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (85, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 보습 - 주름개선 크림 50ml', '주름개선 크림 50ml', 'P002035', 'ACTIVE', 'EA', 20696, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (86, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 면봉 200개입', '면봉 200개입', 'P002036', 'ACTIVE', 'EA', 31030, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (87, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 - 미셀라워터 500ml', '미셀라워터 500ml', 'P002037', 'ACTIVE', 'EA', 46839, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (88, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 트리플 팔레트 18g', '트리플 팔레트 18g', 'P002038', 'ACTIVE', 'EA', 71665, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (89, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '바디케어 - 바디워시 500ml', '바디워시 500ml', 'P002039', 'ACTIVE', 'EA', 45822, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (90, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 보습 - CC크림 50ml', 'CC크림 50ml', 'P002040', 'ACTIVE', 'EA', 21575, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (91, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '아이 메이크업 - 단색 아이섀도우 2g', '단색 아이섀도우 2g', 'P002041', 'ACTIVE', 'EA', 51595, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (92, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P002042', 'ACTIVE', 'EA', 43435, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (93, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 집중관리 - 헤어에센스 100ml', '헤어에센스 100ml', 'P002043', 'ACTIVE', 'EA', 2683, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (94, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 집중관리 - 레티놀 세럼 30ml', '레티놀 세럼 30ml', 'P002044', 'ACTIVE', 'EA', 7464, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (95, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '마스크팩 - 투웨이 팩트 12g', '투웨이 팩트 12g', 'P002045', 'ACTIVE', 'EA', 8980, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (96, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 - 비타민C 토너 200ml', '비타민C 토너 200ml', 'P002046', 'ACTIVE', 'EA', 94280, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (97, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 보습 - 영양 크림 50ml', '영양 크림 50ml', 'P002047', 'ACTIVE', 'EA', 59341, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (98, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '마스크팩 - 쿠션 팩트 SPF50 리필 15g', '쿠션 팩트 SPF50 리필 15g', 'P002048', 'ACTIVE', 'EA', 11297, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (99, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '스킨케어 집중관리 - 헤어에센스 100ml', '헤어에센스 100ml', 'P002049', 'ACTIVE', 'EA', 51869, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (100, '2024-07-03 09:00:00', '2024-07-03 09:00:00', '아이 메이크업 - 단색 아이섀도우 2g', '단색 아이섀도우 2g', 'P002050', 'ACTIVE', 'EA', 24525, 2);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (101, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P003001', 'ACTIVE', 'EA', 2534, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (102, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P003002', 'ACTIVE', 'EA', 94367, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (103, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 수분 크림 50ml', '수분 크림 50ml', 'P003003', 'ACTIVE', 'EA', 49202, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (104, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '마스크팩 - 숯 클레이 마스크 100ml', '숯 클레이 마스크 100ml', 'P003004', 'ACTIVE', 'EA', 29226, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (105, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '클렌징 - 블랙헤드 클렌징 오일 200ml', '블랙헤드 클렌징 오일 200ml', 'P003005', 'ACTIVE', 'EA', 89959, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (106, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '바디케어 - 바디워시 500ml', '바디워시 500ml', 'P003006', 'ACTIVE', 'EA', 68177, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (107, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 - 알로에 수딩 토너 300ml', '알로에 수딩 토너 300ml', 'P003007', 'ACTIVE', 'EA', 16925, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (108, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '베이스 메이크업 - 쿠션 본품+리필 세트', '쿠션 본품+리필 세트', 'P003008', 'ACTIVE', 'EA', 64016, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (109, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 풋크림 100ml', '풋크림 100ml', 'P003009', 'ACTIVE', 'EA', 82507, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (110, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 콜라겐 크림 50ml', '콜라겐 크림 50ml', 'P003010', 'ACTIVE', 'EA', 9064, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (111, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 글로우 스틱 8g', '글로우 스틱 8g', 'P003011', 'ACTIVE', 'EA', 2811, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (112, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 아이크림 30ml', '아이크림 30ml', 'P003012', 'ACTIVE', 'EA', 83064, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (113, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 - 로즈워터 토너 300ml', '로즈워터 토너 300ml', 'P003013', 'ACTIVE', 'EA', 65460, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (114, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '베이스 메이크업 - 파운데이션 30ml', '파운데이션 30ml', 'P003014', 'ACTIVE', 'EA', 43698, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (115, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P003015', 'ACTIVE', 'EA', 80965, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (116, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 멀티 스틱 9g', '멀티 스틱 9g', 'P003016', 'ACTIVE', 'EA', 56158, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (117, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 집중관리 - 프로폴리스 앰플마스크 10매', '프로폴리스 앰플마스크 10매', 'P003017', 'ACTIVE', 'EA', 73064, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (118, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 - 헤어미스트 150ml', '헤어미스트 150ml', 'P003018', 'ACTIVE', 'EA', 27423, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (119, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '마스크팩 - 병풀 마스크팩 10매', '병풀 마스크팩 10매', 'P003019', 'ACTIVE', 'EA', 48747, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (120, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 멀티 스틱 9g', '멀티 스틱 9g', 'P003020', 'ACTIVE', 'EA', 87880, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (121, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '마스크팩 - 병풀 마스크팩 10매', '병풀 마스크팩 10매', 'P003021', 'ACTIVE', 'EA', 92561, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (122, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 핸드크림 50ml', '핸드크림 50ml', 'P003022', 'ACTIVE', 'EA', 16647, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (123, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '마스크팩 - 수면팩 미니 30ml', '수면팩 미니 30ml', 'P003023', 'ACTIVE', 'EA', 73949, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (124, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 - 로즈워터 토너 300ml', '로즈워터 토너 300ml', 'P003024', 'ACTIVE', 'EA', 20616, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (125, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '아이 메이크업 - 아이브로우 펜슬 0.3g', '아이브로우 펜슬 0.3g', 'P003025', 'ACTIVE', 'EA', 11491, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (126, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - CC크림 50ml', 'CC크림 50ml', 'P003026', 'ACTIVE', 'EA', 65866, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (127, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '클렌징 - 폼클렌징 150ml', '폼클렌징 150ml', 'P003027', 'ACTIVE', 'EA', 22620, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (128, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 콜라겐 크림 50ml', '콜라겐 크림 50ml', 'P003028', 'ACTIVE', 'EA', 44981, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (129, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '클렌징 - 모공케어 클렌징 150ml', '모공케어 클렌징 150ml', 'P003029', 'ACTIVE', 'EA', 31230, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (130, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 수딩 선스프레이 150ml', '수딩 선스프레이 150ml', 'P003030', 'ACTIVE', 'EA', 27640, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (131, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 면봉 200개입', '면봉 200개입', 'P003031', 'ACTIVE', 'EA', 22435, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (132, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '헤어케어 - 헤어왁스 100g', '헤어왁스 100g', 'P003032', 'ACTIVE', 'EA', 22332, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (133, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 집중관리 - 히알루론산 세럼 30ml', '히알루론산 세럼 30ml', 'P003033', 'ACTIVE', 'EA', 38787, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (134, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 맨즈 스킨 150ml', '맨즈 스킨 150ml', 'P003034', 'ACTIVE', 'EA', 20679, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (135, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '아이 메이크업 - 섀도우 스틱 1.5g', '섀도우 스틱 1.5g', 'P003035', 'ACTIVE', 'EA', 71401, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (136, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P003036', 'ACTIVE', 'EA', 12874, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (137, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 멀티 스틱 9g', '멀티 스틱 9g', 'P003037', 'ACTIVE', 'EA', 69106, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (138, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 트리플 팔레트 18g', '트리플 팔레트 18g', 'P003038', 'ACTIVE', 'EA', 92189, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (139, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 속눈썹 집게 1개', '속눈썹 집게 1개', 'P003039', 'ACTIVE', 'EA', 1436, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (140, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 멀티 스틱 9g', '멀티 스틱 9g', 'P003040', 'ACTIVE', 'EA', 20207, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (141, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 바디로션 300ml', '바디로션 300ml', 'P003041', 'ACTIVE', 'EA', 1417, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (142, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 향수 기획세트', '향수 기획세트', 'P003042', 'ACTIVE', 'EA', 87203, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (143, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 필링젤 120ml', '필링젤 120ml', 'P003043', 'ACTIVE', 'EA', 66020, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (144, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '화장품 - 보디파우더 100g', '보디파우더 100g', 'P003044', 'ACTIVE', 'EA', 25229, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (145, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 바디로션 300ml', '바디로션 300ml', 'P003045', 'ACTIVE', 'EA', 80626, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (146, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '마스크팩 - 히알루론산 수면팩 80ml', '히알루론산 수면팩 80ml', 'P003046', 'ACTIVE', 'EA', 13566, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (147, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '마스크팩 - 진정 마스크 10매', '진정 마스크 10매', 'P003047', 'ACTIVE', 'EA', 35639, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (148, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '바디케어 - 바디스크럽 200ml', '바디스크럽 200ml', 'P003048', 'ACTIVE', 'EA', 67213, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (149, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '마스크팩 - 투웨이 팩트 12g', '투웨이 팩트 12g', 'P003049', 'ACTIVE', 'EA', 99307, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (150, '2024-07-04 09:00:00', '2024-07-04 09:00:00', '스킨케어 보습 - 바디로션 300ml', '바디로션 300ml', 'P003050', 'ACTIVE', 'EA', 54233, 3);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (151, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '아이 메이크업 - 컬링 마스카라 8ml', '컬링 마스카라 8ml', 'P004001', 'ACTIVE', 'EA', 9666, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (152, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 오드뚜왈렛 100ml', '오드뚜왈렛 100ml', 'P004002', 'ACTIVE', 'EA', 99494, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (153, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 보습 - 넥크림 50ml', '넥크림 50ml', 'P004003', 'ACTIVE', 'EA', 61406, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (154, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '마스크팩 - 수면팩 미니 30ml', '수면팩 미니 30ml', 'P004004', 'ACTIVE', 'EA', 55620, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (155, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 - 병풀 진정 토너 250ml', '병풀 진정 토너 250ml', 'P004005', 'ACTIVE', 'EA', 24846, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (156, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P004006', 'ACTIVE', 'EA', 32885, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (157, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 네일 리무버 100ml', '네일 리무버 100ml', 'P004007', 'ACTIVE', 'EA', 25159, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (158, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '베이스 메이크업 - 커버 쿠션 15g', '커버 쿠션 15g', 'P004008', 'ACTIVE', 'EA', 4575, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (159, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '아이 메이크업 - 브로우 마스카라 5ml', '브로우 마스카라 5ml', 'P004009', 'ACTIVE', 'EA', 49878, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (160, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '립 메이크업 - 벨벳 틴트 4g', '벨벳 틴트 4g', 'P004010', 'ACTIVE', 'EA', 44314, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (161, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '클렌징 - 페이셜 오일 30ml', '페이셜 오일 30ml', 'P004011', 'ACTIVE', 'EA', 24063, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (162, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 메이크업 픽서 80ml', '메이크업 픽서 80ml', 'P004012', 'ACTIVE', 'EA', 52743, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (163, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '마스크팩 - 모공팩 100ml', '모공팩 100ml', 'P004013', 'ACTIVE', 'EA', 24311, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (164, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P004014', 'ACTIVE', 'EA', 24328, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (165, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 퍼퓸 롤온 10ml', '퍼퓸 롤온 10ml', 'P004015', 'ACTIVE', 'EA', 75926, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (166, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 - 미셀라워터 500ml', '미셀라워터 500ml', 'P004016', 'ACTIVE', 'EA', 90120, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (167, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '클렌징 - 립 글로우 오일 7ml', '립 글로우 오일 7ml', 'P004017', 'ACTIVE', 'EA', 68930, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (168, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 보습 - 넥크림 50ml', '넥크림 50ml', 'P004018', 'ACTIVE', 'EA', 33629, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (169, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 듀얼 브로우 펜슬 0.6g', '듀얼 브로우 펜슬 0.6g', 'P004019', 'ACTIVE', 'EA', 55165, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (170, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 집중관리 - 헤어에센스 100ml', '헤어에센스 100ml', 'P004020', 'ACTIVE', 'EA', 68266, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (171, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '마스크팩 - 쿠션 팩트 SPF50 리필 15g', '쿠션 팩트 SPF50 리필 15g', 'P004021', 'ACTIVE', 'EA', 91686, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (172, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 보습 - 필링젤 120ml', '필링젤 120ml', 'P004022', 'ACTIVE', 'EA', 55726, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (173, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 스킨케어 기획세트', '스킨케어 기획세트', 'P004023', 'ACTIVE', 'EA', 43593, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (174, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 집중관리 - 레티놀 세럼 30ml', '레티놀 세럼 30ml', 'P004024', 'ACTIVE', 'EA', 16747, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (175, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '클렌징 - 네일케어 오일 10ml', '네일케어 오일 10ml', 'P004025', 'ACTIVE', 'EA', 9874, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (176, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P004026', 'ACTIVE', 'EA', 85376, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (177, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 향수 기획세트', '향수 기획세트', 'P004027', 'ACTIVE', 'EA', 61359, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (178, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '클렌징 - 더블 클렌징 세트', '더블 클렌징 세트', 'P004028', 'ACTIVE', 'EA', 98460, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (179, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 글로우 스틱 8g', '글로우 스틱 8g', 'P004029', 'ACTIVE', 'EA', 26567, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (180, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '마스크팩 - 진정 마스크 10매', '진정 마스크 10매', 'P004030', 'ACTIVE', 'EA', 83332, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (181, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '클렌징 - 블랙헤드 클렌징 오일 200ml', '블랙헤드 클렌징 오일 200ml', 'P004031', 'ACTIVE', 'EA', 82436, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (182, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '립 메이크업 - 매트 립스틱 3.5g', '매트 립스틱 3.5g', 'P004032', 'ACTIVE', 'EA', 75872, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (183, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 미니 향수 세트 5ml x 5개', '미니 향수 세트 5ml x 5개', 'P004033', 'ACTIVE', 'EA', 27462, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (184, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 집중관리 - 비타민C 세럼 50ml', '비타민C 세럼 50ml', 'P004034', 'ACTIVE', 'EA', 99192, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (185, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P004035', 'ACTIVE', 'EA', 18698, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (186, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P004036', 'ACTIVE', 'EA', 70594, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (187, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '클렌징 - 폼클렌징 150ml', '폼클렌징 150ml', 'P004037', 'ACTIVE', 'EA', 31571, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (188, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '아이 메이크업 - 아이섀도우 팔레트 10색', '아이섀도우 팔레트 10색', 'P004038', 'ACTIVE', 'EA', 44291, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (189, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 집중관리 - 시카 리페어 세럼 50ml', '시카 리페어 세럼 50ml', 'P004039', 'ACTIVE', 'EA', 75431, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (190, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '립 메이크업 - 물들임 립틴트 5ml', '물들임 립틴트 5ml', 'P004040', 'ACTIVE', 'EA', 39313, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (191, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '마스크팩 - 진정 마스크 10매', '진정 마스크 10매', 'P004041', 'ACTIVE', 'EA', 17431, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (192, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 네일 리무버 100ml', '네일 리무버 100ml', 'P004042', 'ACTIVE', 'EA', 71550, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (193, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 각질제거 패드 60매', '각질제거 패드 60매', 'P004043', 'ACTIVE', 'EA', 67889, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (194, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '바디케어 - 바디스크럽 200ml', '바디스크럽 200ml', 'P004044', 'ACTIVE', 'EA', 91882, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (195, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 샘플 세트 10종', '샘플 세트 10종', 'P004045', 'ACTIVE', 'EA', 88948, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (196, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P004046', 'ACTIVE', 'EA', 8759, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (197, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 브러쉬 세트 7종', '브러쉬 세트 7종', 'P004047', 'ACTIVE', 'EA', 35070, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (198, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 스킨케어 체험 세트', '스킨케어 체험 세트', 'P004048', 'ACTIVE', 'EA', 56951, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (199, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P004049', 'ACTIVE', 'EA', 6772, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (200, '2024-07-05 09:00:00', '2024-07-05 09:00:00', '화장품 - 쉐딩 6g', '쉐딩 6g', 'P004050', 'ACTIVE', 'EA', 48705, 4);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (201, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '마스크팩 - 미백 마스크팩 10매', '미백 마스크팩 10매', 'P005001', 'ACTIVE', 'EA', 68723, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (202, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 - 비타민C 토너 200ml', '비타민C 토너 200ml', 'P005002', 'ACTIVE', 'EA', 71241, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (203, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '마스크팩 - 슬리핑팩 100ml', '슬리핑팩 100ml', 'P005003', 'ACTIVE', 'EA', 76241, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (204, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 집중관리 - 레티놀 세럼 30ml', '레티놀 세럼 30ml', 'P005004', 'ACTIVE', 'EA', 15098, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (205, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '화장품 - 트리플 팔레트 18g', '트리플 팔레트 18g', 'P005005', 'ACTIVE', 'EA', 83482, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (206, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P005006', 'ACTIVE', 'EA', 9906, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (207, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '마스크팩 - 수면팩 미니 30ml', '수면팩 미니 30ml', 'P005007', 'ACTIVE', 'EA', 21469, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (208, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '클렌징 - 딥클렌징 오일 200ml', '딥클렌징 오일 200ml', 'P005008', 'ACTIVE', 'EA', 49656, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (209, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 집중관리 - 병풀 앰플 30ml', '병풀 앰플 30ml', 'P005009', 'ACTIVE', 'EA', 93872, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (210, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P005010', 'ACTIVE', 'EA', 84205, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (211, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P005011', 'ACTIVE', 'EA', 5630, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (212, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 - 아하BHA 토너 150ml', '아하BHA 토너 150ml', 'P005012', 'ACTIVE', 'EA', 37035, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (213, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P005013', 'ACTIVE', 'EA', 98810, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (214, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P005014', 'ACTIVE', 'EA', 59207, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (215, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 보습 - 스포츠 선크림 70ml', '스포츠 선크림 70ml', 'P005015', 'ACTIVE', 'EA', 90902, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (216, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '립 메이크업 - 립플럼퍼 3ml', '립플럼퍼 3ml', 'P005016', 'ACTIVE', 'EA', 49324, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (217, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '마스크팩 - 병풀 마스크팩 10매', '병풀 마스크팩 10매', 'P005017', 'ACTIVE', 'EA', 53663, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (218, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 보습 - 영양 크림 50ml', '영양 크림 50ml', 'P005018', 'ACTIVE', 'EA', 41272, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (219, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P005019', 'ACTIVE', 'EA', 59873, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (220, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '클렌징 - 립 글로우 오일 7ml', '립 글로우 오일 7ml', 'P005020', 'ACTIVE', 'EA', 81002, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (221, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '화장품 - 트리플 팔레트 18g', '트리플 팔레트 18g', 'P005021', 'ACTIVE', 'EA', 35647, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (222, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 보습 - 무기자차 선크림 50ml', '무기자차 선크림 50ml', 'P005022', 'ACTIVE', 'EA', 41874, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (223, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P005023', 'ACTIVE', 'EA', 97629, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (224, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 - 에센스 미스트 100ml', '에센스 미스트 100ml', 'P005024', 'ACTIVE', 'EA', 65553, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (225, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '마스크팩 - 히알루론산 수면팩 80ml', '히알루론산 수면팩 80ml', 'P005025', 'ACTIVE', 'EA', 63967, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (226, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 보습 - 수분 크림 50ml', '수분 크림 50ml', 'P005026', 'ACTIVE', 'EA', 7601, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (227, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '화장품 - 스킨케어 체험 세트', '스킨케어 체험 세트', 'P005027', 'ACTIVE', 'EA', 35751, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (228, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '립 메이크업 - 벨벳 틴트 4g', '벨벳 틴트 4g', 'P005028', 'ACTIVE', 'EA', 59400, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (229, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P005029', 'ACTIVE', 'EA', 4847, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (230, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '마스크팩 - 진정 마스크 10매', '진정 마스크 10매', 'P005030', 'ACTIVE', 'EA', 29788, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (231, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 - 쌀 토너 150ml', '쌀 토너 150ml', 'P005031', 'ACTIVE', 'EA', 46229, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (232, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 - 알로에 수딩 토너 300ml', '알로에 수딩 토너 300ml', 'P005032', 'ACTIVE', 'EA', 18834, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (233, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '화장품 - 미니 향수 세트 5ml x 5개', '미니 향수 세트 5ml x 5개', 'P005033', 'ACTIVE', 'EA', 1266, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (234, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '화장품 - 화장솜 80매', '화장솜 80매', 'P005034', 'ACTIVE', 'EA', 89623, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (235, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '화장품 - 프라이머 30ml', '프라이머 30ml', 'P005035', 'ACTIVE', 'EA', 82998, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (236, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '베이스 메이크업 - 커버 쿠션 15g', '커버 쿠션 15g', 'P005036', 'ACTIVE', 'EA', 11897, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (237, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 집중관리 - 펩타이드 세럼 30ml', '펩타이드 세럼 30ml', 'P005037', 'ACTIVE', 'EA', 5011, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (238, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '립 메이크업 - 립 트리트먼트 15g', '립 트리트먼트 15g', 'P005038', 'ACTIVE', 'EA', 15556, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (239, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '화장품 - 커버 컨실러 6ml', '커버 컨실러 6ml', 'P005039', 'ACTIVE', 'EA', 79965, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (240, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '립 메이크업 - 립글로스 5ml', '립글로스 5ml', 'P005040', 'ACTIVE', 'EA', 25635, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (241, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '립 메이크업 - 립 앤 치크 4g', '립 앤 치크 4g', 'P005041', 'ACTIVE', 'EA', 53028, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (242, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P005042', 'ACTIVE', 'EA', 65294, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (243, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P005043', 'ACTIVE', 'EA', 24833, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (244, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '화장품 - 메이크업 픽서 80ml', '메이크업 픽서 80ml', 'P005044', 'ACTIVE', 'EA', 36733, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (245, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '클렌징 - 클렌징 티슈 80매', '클렌징 티슈 80매', 'P005045', 'ACTIVE', 'EA', 46761, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (246, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '립 메이크업 - 립브러쉬 1개', '립브러쉬 1개', 'P005046', 'ACTIVE', 'EA', 28335, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (247, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '아이 메이크업 - 섀도우 스틱 1.5g', '섀도우 스틱 1.5g', 'P005047', 'ACTIVE', 'EA', 40341, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (248, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '아이 메이크업 - 아이섀도우 팔레트 10색', '아이섀도우 팔레트 10색', 'P005048', 'ACTIVE', 'EA', 96078, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (249, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '아이 메이크업 - 아이브로우 펜슬 0.3g', '아이브로우 펜슬 0.3g', 'P005049', 'ACTIVE', 'EA', 42327, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (250, '2024-07-06 09:00:00', '2024-07-06 09:00:00', '스킨케어 보습 - 맨즈 선크림 50ml', '맨즈 선크림 50ml', 'P005050', 'ACTIVE', 'EA', 51892, 5);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (251, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 집중관리 - 비타민C 세럼 50ml', '비타민C 세럼 50ml', 'P006001', 'ACTIVE', 'EA', 10893, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (252, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '클렌징 - 약산성 클렌징폼 120ml', '약산성 클렌징폼 120ml', 'P006002', 'ACTIVE', 'EA', 81851, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (253, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 맨즈 올인원 150ml', '맨즈 올인원 150ml', 'P006003', 'ACTIVE', 'EA', 40432, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (254, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '마스크팩 - 히알루론산 수면팩 80ml', '히알루론산 수면팩 80ml', 'P006004', 'ACTIVE', 'EA', 49287, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (255, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '립 메이크업 - 립 앤 치크 4g', '립 앤 치크 4g', 'P006005', 'ACTIVE', 'EA', 6302, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (256, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 보습 - 세라마이드 크림 80ml', '세라마이드 크림 80ml', 'P006006', 'ACTIVE', 'EA', 55952, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (257, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 - 알로에 수딩 토너 300ml', '알로에 수딩 토너 300ml', 'P006007', 'ACTIVE', 'EA', 25867, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (258, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 집중관리 - 병풀 앰플 30ml', '병풀 앰플 30ml', 'P006008', 'ACTIVE', 'EA', 22040, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (259, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 보습 - 시카 크림 50ml', '시카 크림 50ml', 'P006009', 'ACTIVE', 'EA', 11729, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (260, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 프라이머 30ml', '프라이머 30ml', 'P006010', 'ACTIVE', 'EA', 19722, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (261, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '아이 메이크업 - 리퀴드 아이라이너 5ml', '리퀴드 아이라이너 5ml', 'P006011', 'ACTIVE', 'EA', 41175, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (262, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '선케어 - 쿨링 선스틱 20g', '쿨링 선스틱 20g', 'P006012', 'ACTIVE', 'EA', 31440, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (263, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 집중관리 - 나이아신아마이드 세럼 30ml', '나이아신아마이드 세럼 30ml', 'P006013', 'ACTIVE', 'EA', 44625, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (264, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '클렌징 - 큐티클 오일 5ml', '큐티클 오일 5ml', 'P006014', 'ACTIVE', 'EA', 56612, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (265, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 집중관리 - 나이아신아마이드 세럼 30ml', '나이아신아마이드 세럼 30ml', 'P006015', 'ACTIVE', 'EA', 27333, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (266, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 - 알로에 수딩 토너 300ml', '알로에 수딩 토너 300ml', 'P006016', 'ACTIVE', 'EA', 2816, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (267, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '립 메이크업 - 립밤 10g', '립밤 10g', 'P006017', 'ACTIVE', 'EA', 20647, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (268, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P006018', 'ACTIVE', 'EA', 15898, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (269, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 컨투어 팔레트 15g', '컨투어 팔레트 15g', 'P006019', 'ACTIVE', 'EA', 68370, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (270, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P006020', 'ACTIVE', 'EA', 5132, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (271, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 집중관리 - 헤어에센스 100ml', '헤어에센스 100ml', 'P006021', 'ACTIVE', 'EA', 45699, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (272, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '마스크팩 - 파우더 팩트 10g', '파우더 팩트 10g', 'P006022', 'ACTIVE', 'EA', 52398, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (273, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 스킨케어 체험 세트', '스킨케어 체험 세트', 'P006023', 'ACTIVE', 'EA', 42857, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (274, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '클렌징 - 더블 클렌징 세트', '더블 클렌징 세트', 'P006024', 'ACTIVE', 'EA', 6349, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (275, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '립 메이크업 - 립플럼퍼 3ml', '립플럼퍼 3ml', 'P006025', 'ACTIVE', 'EA', 32635, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (276, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 보습 - 풋크림 100ml', '풋크림 100ml', 'P006026', 'ACTIVE', 'EA', 14056, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (277, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 컨투어링 팔레트 10g', '컨투어링 팔레트 10g', 'P006027', 'ACTIVE', 'EA', 64522, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (278, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '클렌징 - 저자극 클렌징폼 150ml', '저자극 클렌징폼 150ml', 'P006028', 'ACTIVE', 'EA', 20466, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (279, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '헤어케어 - 헤어스프레이 300ml', '헤어스프레이 300ml', 'P006029', 'ACTIVE', 'EA', 76810, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (280, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 탑코트 10ml', '탑코트 10ml', 'P006030', 'ACTIVE', 'EA', 28034, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (281, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '아이 메이크업 - 브로우 마스카라 5ml', '브로우 마스카라 5ml', 'P006031', 'ACTIVE', 'EA', 34967, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (282, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P006032', 'ACTIVE', 'EA', 75691, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (283, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 집중관리 - 시카 리페어 세럼 50ml', '시카 리페어 세럼 50ml', 'P006033', 'ACTIVE', 'EA', 70777, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (284, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 보습 - 젤네일 10ml', '젤네일 10ml', 'P006034', 'ACTIVE', 'EA', 48040, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (285, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 브러쉬 세트 7종', '브러쉬 세트 7종', 'P006035', 'ACTIVE', 'EA', 21759, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (286, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '바디케어 - 바디워시 500ml', '바디워시 500ml', 'P006036', 'ACTIVE', 'EA', 98156, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (287, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 미니 스킨케어 세트 5종', '미니 스킨케어 세트 5종', 'P006037', 'ACTIVE', 'EA', 38238, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (288, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 메이크업 스펀지 10개입', '메이크업 스펀지 10개입', 'P006038', 'ACTIVE', 'EA', 5982, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (289, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 멀티밤 20g', '멀티밤 20g', 'P006039', 'ACTIVE', 'EA', 13029, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (290, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '마스크팩 - 마스크 시트 50매', '마스크 시트 50매', 'P006040', 'ACTIVE', 'EA', 13318, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (291, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 집중관리 - 스네일 에센스 50ml', '스네일 에센스 50ml', 'P006041', 'ACTIVE', 'EA', 70154, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (292, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P006042', 'ACTIVE', 'EA', 28174, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (293, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 컨투어 팔레트 15g', '컨투어 팔레트 15g', 'P006043', 'ACTIVE', 'EA', 73020, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (294, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '마스크팩 - 쿠션 팩트 SPF50 리필 15g', '쿠션 팩트 SPF50 리필 15g', 'P006044', 'ACTIVE', 'EA', 67086, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (295, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P006045', 'ACTIVE', 'EA', 87153, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (296, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '화장품 - 퍼퓸 롤온 10ml', '퍼퓸 롤온 10ml', 'P006046', 'ACTIVE', 'EA', 54757, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (297, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '클렌징 - 쉐이빙폼 150ml', '쉐이빙폼 150ml', 'P006047', 'ACTIVE', 'EA', 69680, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (298, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '아이 메이크업 - 롱래쉬 마스카라 8ml', '롱래쉬 마스카라 8ml', 'P006048', 'ACTIVE', 'EA', 2994, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (299, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '클렌징 - 약산성 클렌징폼 120ml', '약산성 클렌징폼 120ml', 'P006049', 'ACTIVE', 'EA', 69156, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (300, '2024-07-07 09:00:00', '2024-07-07 09:00:00', '스킨케어 보습 - 맨즈 선크림 50ml', '맨즈 선크림 50ml', 'P006050', 'ACTIVE', 'EA', 20870, 6);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (301, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '아이 메이크업 - 리퀴드 아이라이너 5ml', '리퀴드 아이라이너 5ml', 'P007001', 'ACTIVE', 'EA', 78128, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (302, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 집중관리 - 프로폴리스 앰플 30ml', '프로폴리스 앰플 30ml', 'P007002', 'ACTIVE', 'EA', 70680, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (303, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '클렌징 - 폼클렌징 150ml', '폼클렌징 150ml', 'P007003', 'ACTIVE', 'EA', 43645, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (304, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '화장품 - 메이크업 픽서 80ml', '메이크업 픽서 80ml', 'P007004', 'ACTIVE', 'EA', 78081, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (305, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '마스크팩 - 히알루론산 수면팩 80ml', '히알루론산 수면팩 80ml', 'P007005', 'ACTIVE', 'EA', 22457, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (306, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 집중관리 - 맨즈 에센스 50ml', '맨즈 에센스 50ml', 'P007006', 'ACTIVE', 'EA', 60962, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (307, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '아이 메이크업 - 아이섀도우 팔레트 10색', '아이섀도우 팔레트 10색', 'P007007', 'ACTIVE', 'EA', 55340, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (308, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '헤어케어 - 헤어스프레이 300ml', '헤어스프레이 300ml', 'P007008', 'ACTIVE', 'EA', 58621, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (309, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '아이 메이크업 - 아이섀도우 메가팔레트 40색', '아이섀도우 메가팔레트 40색', 'P007009', 'ACTIVE', 'EA', 4220, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (310, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '아이 메이크업 - 리퀴드 아이라이너 5ml', '리퀴드 아이라이너 5ml', 'P007010', 'ACTIVE', 'EA', 49726, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (311, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '클렌징 - 모공케어 클렌징 150ml', '모공케어 클렌징 150ml', 'P007011', 'ACTIVE', 'EA', 87842, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (312, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '클렌징 - 더블 클렌징 세트', '더블 클렌징 세트', 'P007012', 'ACTIVE', 'EA', 4585, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (313, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P007013', 'ACTIVE', 'EA', 51912, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (314, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 집중관리 - 프로폴리스 앰플마스크 10매', '프로폴리스 앰플마스크 10매', 'P007014', 'ACTIVE', 'EA', 47337, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (315, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '화장품 - 스킨케어 기획세트', '스킨케어 기획세트', 'P007015', 'ACTIVE', 'EA', 89362, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (316, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '립 메이크업 - 립브러쉬 1개', '립브러쉬 1개', 'P007016', 'ACTIVE', 'EA', 71898, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (317, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '바디케어 - 바디스크럽 200ml', '바디스크럽 200ml', 'P007017', 'ACTIVE', 'EA', 87249, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (318, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P007018', 'ACTIVE', 'EA', 78893, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (319, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '클렌징 - 폼클렌징 150ml', '폼클렌징 150ml', 'P007019', 'ACTIVE', 'EA', 3233, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (320, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '화장품 - 오드뚜왈렛 100ml', '오드뚜왈렛 100ml', 'P007020', 'ACTIVE', 'EA', 42843, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (321, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '화장품 - 글로우 스틱 8g', '글로우 스틱 8g', 'P007021', 'ACTIVE', 'EA', 62635, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (322, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '립 메이크업 - 립 컬렉션 세트', '립 컬렉션 세트', 'P007022', 'ACTIVE', 'EA', 58362, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (323, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '화장품 - 샘플 세트 10종', '샘플 세트 10종', 'P007023', 'ACTIVE', 'EA', 6995, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (324, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '마스크팩 - 슬리핑팩 100ml', '슬리핑팩 100ml', 'P007024', 'ACTIVE', 'EA', 42813, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (325, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 보습 - 필링젤 120ml', '필링젤 120ml', 'P007025', 'ACTIVE', 'EA', 42054, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (326, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '헤어케어 - 샴푸 500ml', '샴푸 500ml', 'P007026', 'ACTIVE', 'EA', 52049, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (327, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 보습 - 선크림 SPF50+ 50ml', '선크림 SPF50+ 50ml', 'P007027', 'ACTIVE', 'EA', 40120, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (328, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 보습 - 무기자차 선크림 50ml', '무기자차 선크림 50ml', 'P007028', 'ACTIVE', 'EA', 17444, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (329, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '립 메이크업 - 매트 립크레용 2.5g', '매트 립크레용 2.5g', 'P007029', 'ACTIVE', 'EA', 50770, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (330, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P007030', 'ACTIVE', 'EA', 75104, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (331, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P007031', 'ACTIVE', 'EA', 82596, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (332, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '마스크팩 - 진정 마스크 10매', '진정 마스크 10매', 'P007032', 'ACTIVE', 'EA', 8434, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (333, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 - 알로에 수딩 토너 300ml', '알로에 수딩 토너 300ml', 'P007033', 'ACTIVE', 'EA', 75744, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (334, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '아이 메이크업 - 컬링 마스카라 8ml', '컬링 마스카라 8ml', 'P007034', 'ACTIVE', 'EA', 15395, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (335, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '립 메이크업 - 립 앤 치크 4g', '립 앤 치크 4g', 'P007035', 'ACTIVE', 'EA', 64723, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (336, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '화장품 - 맨즈 올인원 150ml', '맨즈 올인원 150ml', 'P007036', 'ACTIVE', 'EA', 16557, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (337, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '아이 메이크업 - 컬링 마스카라 8ml', '컬링 마스카라 8ml', 'P007037', 'ACTIVE', 'EA', 13636, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (338, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 보습 - 필링젤 120ml', '필링젤 120ml', 'P007038', 'ACTIVE', 'EA', 81581, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (339, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 보습 - 수분 크림 50ml', '수분 크림 50ml', 'P007039', 'ACTIVE', 'EA', 23821, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (340, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '마스크팩 - 진정 마스크 10매', '진정 마스크 10매', 'P007040', 'ACTIVE', 'EA', 5359, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (341, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '립 메이크업 - 립밤 10g', '립밤 10g', 'P007041', 'ACTIVE', 'EA', 7712, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (342, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '베이스 메이크업 - 파우더 쿠션 15g', '파우더 쿠션 15g', 'P007042', 'ACTIVE', 'EA', 41481, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (343, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 - 아하BHA 토너 150ml', '아하BHA 토너 150ml', 'P007043', 'ACTIVE', 'EA', 29375, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (344, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 보습 - 바디로션 300ml', '바디로션 300ml', 'P007044', 'ACTIVE', 'EA', 69822, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (345, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '화장품 - 뷰러 1개', '뷰러 1개', 'P007045', 'ACTIVE', 'EA', 13642, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (346, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '스킨케어 - 바디미스트 200ml', '바디미스트 200ml', 'P007046', 'ACTIVE', 'EA', 61351, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (347, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '선케어 - 쿨링 선스틱 20g', '쿨링 선스틱 20g', 'P007047', 'ACTIVE', 'EA', 66439, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (348, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '마스크팩 - 미백 마스크팩 10매', '미백 마스크팩 10매', 'P007048', 'ACTIVE', 'EA', 62485, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (349, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '화장품 - 화장솜 80매', '화장솜 80매', 'P007049', 'ACTIVE', 'EA', 8718, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (350, '2024-07-08 09:00:00', '2024-07-08 09:00:00', '립 메이크업 - 립플럼퍼 3ml', '립플럼퍼 3ml', 'P007050', 'ACTIVE', 'EA', 56490, 7);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (351, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '클렌징 - 맨즈 클렌징폼 150ml', '맨즈 클렌징폼 150ml', 'P008001', 'ACTIVE', 'EA', 29842, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (352, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '바디케어 - 바디클렌저 300ml', '바디클렌저 300ml', 'P008002', 'ACTIVE', 'EA', 30113, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (353, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 보습 - 크림 아이섀도우 5g', '크림 아이섀도우 5g', 'P008003', 'ACTIVE', 'EA', 44191, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (354, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 보습 - 풋크림 100ml', '풋크림 100ml', 'P008004', 'ACTIVE', 'EA', 98667, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (355, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '아이 메이크업 - 아이섀도우 팔레트 10색', '아이섀도우 팔레트 10색', 'P008005', 'ACTIVE', 'EA', 22250, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (356, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 보습 - 바디로션 300ml', '바디로션 300ml', 'P008006', 'ACTIVE', 'EA', 51226, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (357, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 듀얼 브로우 펜슬 0.6g', '듀얼 브로우 펜슬 0.6g', 'P008007', 'ACTIVE', 'EA', 78088, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (358, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P008008', 'ACTIVE', 'EA', 72208, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (359, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '베이스 메이크업 - 파우더 쿠션 15g', '파우더 쿠션 15g', 'P008009', 'ACTIVE', 'EA', 32678, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (360, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 애프터쉐이브 100ml', '애프터쉐이브 100ml', 'P008010', 'ACTIVE', 'EA', 90919, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (361, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '립 메이크업 - 매트 립스틱 3.5g', '매트 립스틱 3.5g', 'P008011', 'ACTIVE', 'EA', 62809, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (362, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '립 메이크업 - 립브러쉬 1개', '립브러쉬 1개', 'P008012', 'ACTIVE', 'EA', 24647, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (363, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '마스크팩 - 모공팩 100ml', '모공팩 100ml', 'P008013', 'ACTIVE', 'EA', 28324, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (364, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '립 메이크업 - 벨벳 틴트 4g', '벨벳 틴트 4g', 'P008014', 'ACTIVE', 'EA', 73573, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (365, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 트리플 팔레트 18g', '트리플 팔레트 18g', 'P008015', 'ACTIVE', 'EA', 76284, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (366, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 탑코트 10ml', '탑코트 10ml', 'P008016', 'ACTIVE', 'EA', 73241, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (367, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 보습 - 바디로션 300ml', '바디로션 300ml', 'P008017', 'ACTIVE', 'EA', 84867, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (368, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 컨투어링 팔레트 10g', '컨투어링 팔레트 10g', 'P008018', 'ACTIVE', 'EA', 29033, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (369, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 - 바디미스트 200ml', '바디미스트 200ml', 'P008019', 'ACTIVE', 'EA', 21891, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (370, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 - 바디미스트 200ml', '바디미스트 200ml', 'P008020', 'ACTIVE', 'EA', 89180, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (371, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 멀티 스틱 9g', '멀티 스틱 9g', 'P008021', 'ACTIVE', 'EA', 96990, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (372, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 보습 - 레티놀 크림 30ml', '레티놀 크림 30ml', 'P008022', 'ACTIVE', 'EA', 60696, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (373, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '클렌징 - 바디오일 100ml', '바디오일 100ml', 'P008023', 'ACTIVE', 'EA', 2894, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (374, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 블러셔 6g', '블러셔 6g', 'P008024', 'ACTIVE', 'EA', 86276, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (375, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 메이크업베이스 35ml', '메이크업베이스 35ml', 'P008025', 'ACTIVE', 'EA', 26548, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (376, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '클렌징 - 큐티클 오일 5ml', '큐티클 오일 5ml', 'P008026', 'ACTIVE', 'EA', 10596, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (377, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '클렌징 - 쉐이빙폼 150ml', '쉐이빙폼 150ml', 'P008027', 'ACTIVE', 'EA', 10142, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (378, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '클렌징 - 딥클렌징 오일 200ml', '딥클렌징 오일 200ml', 'P008028', 'ACTIVE', 'EA', 74476, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (379, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 보습 - 선크림 SPF50+ 50ml', '선크림 SPF50+ 50ml', 'P008029', 'ACTIVE', 'EA', 17031, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (380, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '헤어케어 - 샴푸 500ml', '샴푸 500ml', 'P008030', 'ACTIVE', 'EA', 13381, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (381, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 보습 - 무기자차 선크림 50ml', '무기자차 선크림 50ml', 'P008031', 'ACTIVE', 'EA', 35767, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (382, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 - 바디미스트 향수 200ml', '바디미스트 향수 200ml', 'P008032', 'ACTIVE', 'EA', 75297, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (383, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '헤어케어 - 샴푸 500ml', '샴푸 500ml', 'P008033', 'ACTIVE', 'EA', 31895, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (384, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 - 바디미스트 200ml', '바디미스트 200ml', 'P008034', 'ACTIVE', 'EA', 28995, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (385, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '클렌징 - 큐티클 오일 5ml', '큐티클 오일 5ml', 'P008035', 'ACTIVE', 'EA', 37388, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (386, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '아이 메이크업 - 롱래쉬 마스카라 8ml', '롱래쉬 마스카라 8ml', 'P008036', 'ACTIVE', 'EA', 30533, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (387, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 - 히알루론산 토너 150ml', '히알루론산 토너 150ml', 'P008037', 'ACTIVE', 'EA', 66230, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (388, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P008038', 'ACTIVE', 'EA', 49512, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (389, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '클렌징 - 페이셜 오일 30ml', '페이셜 오일 30ml', 'P008039', 'ACTIVE', 'EA', 97231, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (390, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 오드퍼퓸 50ml', '오드퍼퓸 50ml', 'P008040', 'ACTIVE', 'EA', 91312, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (391, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 수딩 선스프레이 150ml', '수딩 선스프레이 150ml', 'P008041', 'ACTIVE', 'EA', 59554, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (392, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '아이 메이크업 - 아이섀도우 팔레트 10색', '아이섀도우 팔레트 10색', 'P008042', 'ACTIVE', 'EA', 87922, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (393, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 집중관리 - 히알루론산 세럼 30ml', '히알루론산 세럼 30ml', 'P008043', 'ACTIVE', 'EA', 53893, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (394, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '헤어케어 - 헤어왁스 100g', '헤어왁스 100g', 'P008044', 'ACTIVE', 'EA', 74687, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (395, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '립 메이크업 - 립 트리트먼트 15g', '립 트리트먼트 15g', 'P008045', 'ACTIVE', 'EA', 33654, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (396, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '립 메이크업 - 립스크럽 15g', '립스크럽 15g', 'P008046', 'ACTIVE', 'EA', 86285, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (397, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 집중관리 - 시카 리페어 세럼 50ml', '시카 리페어 세럼 50ml', 'P008047', 'ACTIVE', 'EA', 60061, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (398, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '클렌징 - 립 글로우 오일 7ml', '립 글로우 오일 7ml', 'P008048', 'ACTIVE', 'EA', 67117, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (399, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '화장품 - 스킨케어 체험 세트', '스킨케어 체험 세트', 'P008049', 'ACTIVE', 'EA', 15214, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (400, '2024-07-09 09:00:00', '2024-07-09 09:00:00', '스킨케어 집중관리 - 병풀 앰플 30ml', '병풀 앰플 30ml', 'P008050', 'ACTIVE', 'EA', 68912, 8);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (401, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 집중관리 - 나이아신아마이드 세럼 30ml', '나이아신아마이드 세럼 30ml', 'P009001', 'ACTIVE', 'EA', 4948, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (402, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 향수 기획세트', '향수 기획세트', 'P009002', 'ACTIVE', 'EA', 68223, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (403, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 보습 - 영양 크림 50ml', '영양 크림 50ml', 'P009003', 'ACTIVE', 'EA', 71805, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (404, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 - 헤어미스트 150ml', '헤어미스트 150ml', 'P009004', 'ACTIVE', 'EA', 90245, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (405, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 보습 - 비비크림 50ml', '비비크림 50ml', 'P009005', 'ACTIVE', 'EA', 49231, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (406, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '헤어케어 - 린스 500ml', '린스 500ml', 'P009006', 'ACTIVE', 'EA', 32304, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (407, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '바디케어 - 바디워시 500ml', '바디워시 500ml', 'P009007', 'ACTIVE', 'EA', 53389, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (408, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 - 바디미스트 200ml', '바디미스트 200ml', 'P009008', 'ACTIVE', 'EA', 65646, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (409, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '바디케어 - 바디버터 200ml', '바디버터 200ml', 'P009009', 'ACTIVE', 'EA', 90772, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (410, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 보습 - 넥크림 50ml', '넥크림 50ml', 'P009010', 'ACTIVE', 'EA', 11802, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (411, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 보습 - 시카 크림 50ml', '시카 크림 50ml', 'P009011', 'ACTIVE', 'EA', 56248, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (412, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 하이라이터 4g', '하이라이터 4g', 'P009012', 'ACTIVE', 'EA', 62021, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (413, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 - 헤어미스트 150ml', '헤어미스트 150ml', 'P009013', 'ACTIVE', 'EA', 15552, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (414, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '마스크팩 - 미백 마스크팩 10매', '미백 마스크팩 10매', 'P009014', 'ACTIVE', 'EA', 43959, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (415, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '립 메이크업 - 립밤 10g', '립밤 10g', 'P009015', 'ACTIVE', 'EA', 33665, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (416, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 면봉 200개입', '면봉 200개입', 'P009016', 'ACTIVE', 'EA', 59224, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (417, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 미니 향수 세트 5ml x 5개', '미니 향수 세트 5ml x 5개', 'P009017', 'ACTIVE', 'EA', 40809, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (418, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '아이 메이크업 - 롱래쉬 마스카라 8ml', '롱래쉬 마스카라 8ml', 'P009018', 'ACTIVE', 'EA', 56657, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (419, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 집중관리 - 비타민C 세럼 50ml', '비타민C 세럼 50ml', 'P009019', 'ACTIVE', 'EA', 75212, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (420, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 듀얼 브로우 펜슬 0.6g', '듀얼 브로우 펜슬 0.6g', 'P009020', 'ACTIVE', 'EA', 17332, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (421, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 - 병풀 진정 토너 250ml', '병풀 진정 토너 250ml', 'P009021', 'ACTIVE', 'EA', 23440, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (422, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 - 바디미스트 향수 200ml', '바디미스트 향수 200ml', 'P009022', 'ACTIVE', 'EA', 29569, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (423, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 보습 - 스포츠 선크림 70ml', '스포츠 선크림 70ml', 'P009023', 'ACTIVE', 'EA', 96503, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (424, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '아이 메이크업 - 단색 아이섀도우 2g', '단색 아이섀도우 2g', 'P009024', 'ACTIVE', 'EA', 81852, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (425, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P009025', 'ACTIVE', 'EA', 51442, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (426, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '마스크팩 - 슬리핑팩 100ml', '슬리핑팩 100ml', 'P009026', 'ACTIVE', 'EA', 35370, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (427, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 샘플 세트 10종', '샘플 세트 10종', 'P009027', 'ACTIVE', 'EA', 75752, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (428, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '아이 메이크업 - 아이브로우 펜슬 0.3g', '아이브로우 펜슬 0.3g', 'P009028', 'ACTIVE', 'EA', 84394, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (429, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P009029', 'ACTIVE', 'EA', 24069, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (430, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 보습 - 세라마이드 크림 80ml', '세라마이드 크림 80ml', 'P009030', 'ACTIVE', 'EA', 83459, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (431, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '바디케어 - 바디워시 500ml', '바디워시 500ml', 'P009031', 'ACTIVE', 'EA', 1733, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (432, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 뷰러 1개', '뷰러 1개', 'P009032', 'ACTIVE', 'EA', 68701, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (433, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 향수 기획세트', '향수 기획세트', 'P009033', 'ACTIVE', 'EA', 96967, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (434, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 - 바디미스트 200ml', '바디미스트 200ml', 'P009034', 'ACTIVE', 'EA', 95437, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (435, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 샘플 세트 10종', '샘플 세트 10종', 'P009035', 'ACTIVE', 'EA', 37212, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (436, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 집중관리 - 스네일 에센스 50ml', '스네일 에센스 50ml', 'P009036', 'ACTIVE', 'EA', 4113, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (437, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P009037', 'ACTIVE', 'EA', 63824, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (438, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 애프터쉐이브 100ml', '애프터쉐이브 100ml', 'P009038', 'ACTIVE', 'EA', 44555, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (439, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 - 라벤더 워터 토너 200ml', '라벤더 워터 토너 200ml', 'P009039', 'ACTIVE', 'EA', 91940, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (440, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 오드퍼퓸 50ml', '오드퍼퓸 50ml', 'P009040', 'ACTIVE', 'EA', 83731, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (441, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 보습 - 바디로션 300ml', '바디로션 300ml', 'P009041', 'ACTIVE', 'EA', 27426, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (442, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 하이라이터 4g', '하이라이터 4g', 'P009042', 'ACTIVE', 'EA', 82999, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (443, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 - 헤어미스트 150ml', '헤어미스트 150ml', 'P009043', 'ACTIVE', 'EA', 40611, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (444, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 맨즈 올인원 150ml', '맨즈 올인원 150ml', 'P009044', 'ACTIVE', 'EA', 4686, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (445, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 맨즈 올인원 150ml', '맨즈 올인원 150ml', 'P009045', 'ACTIVE', 'EA', 96305, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (446, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 베이스코트 10ml', '베이스코트 10ml', 'P009046', 'ACTIVE', 'EA', 53127, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (447, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P009047', 'ACTIVE', 'EA', 49106, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (448, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 보습 - 맨즈 선크림 50ml', '맨즈 선크림 50ml', 'P009048', 'ACTIVE', 'EA', 29228, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (449, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '스킨케어 보습 - 영양 크림 50ml', '영양 크림 50ml', 'P009049', 'ACTIVE', 'EA', 74562, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (450, '2024-07-10 09:00:00', '2024-07-10 09:00:00', '화장품 - 오드퍼퓸 50ml', '오드퍼퓸 50ml', 'P009050', 'ACTIVE', 'EA', 33824, 9);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (451, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 비비크림 50ml', '비비크림 50ml', 'P010001', 'ACTIVE', 'EA', 31205, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (452, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 집중관리 - 프로폴리스 앰플마스크 10매', '프로폴리스 앰플마스크 10매', 'P010002', 'ACTIVE', 'EA', 13095, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (453, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 맨즈 아이크림 30ml', '맨즈 아이크림 30ml', 'P010003', 'ACTIVE', 'EA', 27742, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (454, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 베이비 선크림 100ml', '베이비 선크림 100ml', 'P010004', 'ACTIVE', 'EA', 33934, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (455, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 맨즈 아이크림 30ml', '맨즈 아이크림 30ml', 'P010005', 'ACTIVE', 'EA', 74362, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (456, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '립 메이크업 - 매트 립크레용 2.5g', '매트 립크레용 2.5g', 'P010006', 'ACTIVE', 'EA', 1766, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (457, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 집중관리 - 비타민C 세럼 50ml', '비타민C 세럼 50ml', 'P010007', 'ACTIVE', 'EA', 3169, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (458, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P010008', 'ACTIVE', 'EA', 20835, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (459, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 글로우 스틱 8g', '글로우 스틱 8g', 'P010009', 'ACTIVE', 'EA', 74854, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (460, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 집중관리 - 시카 리페어 세럼 50ml', '시카 리페어 세럼 50ml', 'P010010', 'ACTIVE', 'EA', 77288, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (461, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 집중관리 - 비타민C 세럼 50ml', '비타민C 세럼 50ml', 'P010011', 'ACTIVE', 'EA', 18472, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (462, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '클렌징 - 클렌징밤 100ml', '클렌징밤 100ml', 'P010012', 'ACTIVE', 'EA', 44042, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (463, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 콜라겐 크림 50ml', '콜라겐 크림 50ml', 'P010013', 'ACTIVE', 'EA', 28943, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (464, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 트리플 팔레트 18g', '트리플 팔레트 18g', 'P010014', 'ACTIVE', 'EA', 17830, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (465, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 필링젤 120ml', '필링젤 120ml', 'P010015', 'ACTIVE', 'EA', 80885, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (466, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 하이라이터 4g', '하이라이터 4g', 'P010016', 'ACTIVE', 'EA', 82656, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (467, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '마스크팩 - 비타민 마스크 10매', '비타민 마스크 10매', 'P010017', 'ACTIVE', 'EA', 41174, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (468, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P010018', 'ACTIVE', 'EA', 67873, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (469, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 커버 컨실러 6ml', '커버 컨실러 6ml', 'P010019', 'ACTIVE', 'EA', 38462, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (470, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 프라이머 30ml', '프라이머 30ml', 'P010020', 'ACTIVE', 'EA', 4800, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (471, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '바디케어 - 바디클렌저 300ml', '바디클렌저 300ml', 'P010021', 'ACTIVE', 'EA', 28540, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (472, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 풋크림 100ml', '풋크림 100ml', 'P010022', 'ACTIVE', 'EA', 57195, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (473, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '클렌징 - 네일케어 오일 10ml', '네일케어 오일 10ml', 'P010023', 'ACTIVE', 'EA', 52553, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (474, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 - 헤어미스트 150ml', '헤어미스트 150ml', 'P010024', 'ACTIVE', 'EA', 90418, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (475, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 - 티트리 토너 200ml', '티트리 토너 200ml', 'P010025', 'ACTIVE', 'EA', 77158, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (476, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 집중관리 - 프로폴리스 앰플마스크 10매', '프로폴리스 앰플마스크 10매', 'P010026', 'ACTIVE', 'EA', 53631, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (477, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 스틱형 선크림 18g', '스틱형 선크림 18g', 'P010027', 'ACTIVE', 'EA', 85731, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (478, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '마스크팩 - 수면팩 미니 30ml', '수면팩 미니 30ml', 'P010028', 'ACTIVE', 'EA', 84940, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (479, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '클렌징 - 바디오일 100ml', '바디오일 100ml', 'P010029', 'ACTIVE', 'EA', 96397, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (480, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P010030', 'ACTIVE', 'EA', 87573, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (481, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 세라마이드 크림 80ml', '세라마이드 크림 80ml', 'P010031', 'ACTIVE', 'EA', 58692, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (482, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 선크림 SPF50+ 50ml', '선크림 SPF50+ 50ml', 'P010032', 'ACTIVE', 'EA', 75814, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (483, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '마스크팩 - 슬리핑팩 100ml', '슬리핑팩 100ml', 'P010033', 'ACTIVE', 'EA', 74724, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (484, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 퍼프 5개입', '퍼프 5개입', 'P010034', 'ACTIVE', 'EA', 37697, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (485, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 - 그린티 프레시 토너 200ml', '그린티 프레시 토너 200ml', 'P010035', 'ACTIVE', 'EA', 66807, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (486, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 컨투어 팔레트 15g', '컨투어 팔레트 15g', 'P010036', 'ACTIVE', 'EA', 38023, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (487, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 프라이머 30ml', '프라이머 30ml', 'P010037', 'ACTIVE', 'EA', 71409, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (488, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 컨투어링 팔레트 10g', '컨투어링 팔레트 10g', 'P010038', 'ACTIVE', 'EA', 10585, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (489, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '마스크팩 - 미백 마스크팩 10매', '미백 마스크팩 10매', 'P010039', 'ACTIVE', 'EA', 87287, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (490, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '아이 메이크업 - 아이섀도우 팔레트 10색', '아이섀도우 팔레트 10색', 'P010040', 'ACTIVE', 'EA', 63559, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (491, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '립 메이크업 - 립브러쉬 1개', '립브러쉬 1개', 'P010041', 'ACTIVE', 'EA', 93005, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (492, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P010042', 'ACTIVE', 'EA', 64248, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (493, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P010043', 'ACTIVE', 'EA', 86056, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (494, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 멀티밤 20g', '멀티밤 20g', 'P010044', 'ACTIVE', 'EA', 21796, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (495, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 주름개선 크림 50ml', '주름개선 크림 50ml', 'P010045', 'ACTIVE', 'EA', 56312, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (496, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 보습 - 아이크림 30ml', '아이크림 30ml', 'P010046', 'ACTIVE', 'EA', 7226, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (497, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '헤어케어 - 헤어스프레이 300ml', '헤어스프레이 300ml', 'P010047', 'ACTIVE', 'EA', 93210, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (498, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '마스크팩 - 히알루론산 수면팩 80ml', '히알루론산 수면팩 80ml', 'P010048', 'ACTIVE', 'EA', 13888, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (499, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '화장품 - 브러쉬 세트 7종', '브러쉬 세트 7종', 'P010049', 'ACTIVE', 'EA', 97038, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (500, '2024-07-11 09:00:00', '2024-07-11 09:00:00', '스킨케어 - 히알루론산 토너 150ml', '히알루론산 토너 150ml', 'P010050', 'ACTIVE', 'EA', 16628, 10);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (501, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '마스크팩 - 병풀 마스크팩 10매', '병풀 마스크팩 10매', 'P011001', 'ACTIVE', 'EA', 35912, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (502, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '클렌징 - 저자극 클렌징폼 150ml', '저자극 클렌징폼 150ml', 'P011002', 'ACTIVE', 'EA', 87963, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (503, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '아이 메이크업 - 아이브로우 펜슬 0.3g', '아이브로우 펜슬 0.3g', 'P011003', 'ACTIVE', 'EA', 42250, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (504, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '클렌징 - 폼클렌징 150ml', '폼클렌징 150ml', 'P011004', 'ACTIVE', 'EA', 55096, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (505, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '아이 메이크업 - 리퀴드 아이라이너 5ml', '리퀴드 아이라이너 5ml', 'P011005', 'ACTIVE', 'EA', 96938, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (506, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P011006', 'ACTIVE', 'EA', 52428, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (507, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '립 메이크업 - 매트 립크레용 2.5g', '매트 립크레용 2.5g', 'P011007', 'ACTIVE', 'EA', 63496, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (508, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '클렌징 - 블랙헤드 클렌징 오일 200ml', '블랙헤드 클렌징 오일 200ml', 'P011008', 'ACTIVE', 'EA', 13150, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (509, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 - 바디미스트 향수 200ml', '바디미스트 향수 200ml', 'P011009', 'ACTIVE', 'EA', 52086, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (510, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 미니 향수 세트 5ml x 5개', '미니 향수 세트 5ml x 5개', 'P011010', 'ACTIVE', 'EA', 91228, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (511, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '클렌징 - 더블 클렌징 세트', '더블 클렌징 세트', 'P011011', 'ACTIVE', 'EA', 85199, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (512, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P011012', 'ACTIVE', 'EA', 16882, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (513, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 탑코트 10ml', '탑코트 10ml', 'P011013', 'ACTIVE', 'EA', 97923, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (514, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 보습 - 아이크림 30ml', '아이크림 30ml', 'P011014', 'ACTIVE', 'EA', 57478, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (515, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '립 메이크업 - 립플럼퍼 3ml', '립플럼퍼 3ml', 'P011015', 'ACTIVE', 'EA', 31130, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (516, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 브로우 파우더 4g', '브로우 파우더 4g', 'P011016', 'ACTIVE', 'EA', 82353, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (517, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 보습 - 수분 선젤 50ml', '수분 선젤 50ml', 'P011017', 'ACTIVE', 'EA', 1956, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (518, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '헤어케어 - 샴푸 500ml', '샴푸 500ml', 'P011018', 'ACTIVE', 'EA', 99448, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (519, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 - 병풀 진정 토너 250ml', '병풀 진정 토너 250ml', 'P011019', 'ACTIVE', 'EA', 61142, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (520, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '아이 메이크업 - 아이패치 60매', '아이패치 60매', 'P011020', 'ACTIVE', 'EA', 21384, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (521, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '베이스 메이크업 - 쿠션 본품+리필 세트', '쿠션 본품+리필 세트', 'P011021', 'ACTIVE', 'EA', 83174, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (522, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 쉐딩 6g', '쉐딩 6g', 'P011022', 'ACTIVE', 'EA', 2877, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (523, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P011023', 'ACTIVE', 'EA', 47655, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (524, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 퍼프 5개입', '퍼프 5개입', 'P011024', 'ACTIVE', 'EA', 21987, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (525, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '아이 메이크업 - 단색 아이섀도우 2g', '단색 아이섀도우 2g', 'P011025', 'ACTIVE', 'EA', 89988, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (526, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 수딩 선스프레이 150ml', '수딩 선스프레이 150ml', 'P011026', 'ACTIVE', 'EA', 36371, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (527, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 퍼프 5개입', '퍼프 5개입', 'P011027', 'ACTIVE', 'EA', 19932, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (528, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '립 메이크업 - 매트 립스틱 3.5g', '매트 립스틱 3.5g', 'P011028', 'ACTIVE', 'EA', 51759, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (529, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 - 픽서 미스트 80ml', '픽서 미스트 80ml', 'P011029', 'ACTIVE', 'EA', 22023, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (530, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P011030', 'ACTIVE', 'EA', 41894, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (531, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 스킨케어 체험 세트', '스킨케어 체험 세트', 'P011031', 'ACTIVE', 'EA', 43271, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (532, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '베이스 메이크업 - 파운데이션 30ml', '파운데이션 30ml', 'P011032', 'ACTIVE', 'EA', 83216, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (533, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '아이 메이크업 - 아이섀도우 메가팔레트 40색', '아이섀도우 메가팔레트 40색', 'P011033', 'ACTIVE', 'EA', 79751, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (534, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '립 메이크업 - 립밤 10g', '립밤 10g', 'P011034', 'ACTIVE', 'EA', 42443, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (535, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 향수 기획세트', '향수 기획세트', 'P011035', 'ACTIVE', 'EA', 57348, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (536, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '헤어케어 - 린스 500ml', '린스 500ml', 'P011036', 'ACTIVE', 'EA', 6139, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (537, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 집중관리 - 비타민C 세럼 50ml', '비타민C 세럼 50ml', 'P011037', 'ACTIVE', 'EA', 47423, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (538, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 메이크업 스펀지 10개입', '메이크업 스펀지 10개입', 'P011038', 'ACTIVE', 'EA', 33149, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (539, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '헤어케어 - 린스 500ml', '린스 500ml', 'P011039', 'ACTIVE', 'EA', 91531, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (540, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 집중관리 - 히알루론산 세럼 30ml', '히알루론산 세럼 30ml', 'P011040', 'ACTIVE', 'EA', 79714, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (541, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '마스크팩 - 슬리핑팩 100ml', '슬리핑팩 100ml', 'P011041', 'ACTIVE', 'EA', 61004, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (542, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 집중관리 - 병풀 앰플 30ml', '병풀 앰플 30ml', 'P011042', 'ACTIVE', 'EA', 4504, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (543, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '스킨케어 - 로즈워터 토너 300ml', '로즈워터 토너 300ml', 'P011043', 'ACTIVE', 'EA', 46468, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (544, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '베이스 메이크업 - 커버 쿠션 15g', '커버 쿠션 15g', 'P011044', 'ACTIVE', 'EA', 88988, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (545, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 애프터쉐이브 100ml', '애프터쉐이브 100ml', 'P011045', 'ACTIVE', 'EA', 52401, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (546, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '화장품 - 블러셔 6g', '블러셔 6g', 'P011046', 'ACTIVE', 'EA', 66250, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (547, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '립 메이크업 - 아이브로우 틴트 5g', '아이브로우 틴트 5g', 'P011047', 'ACTIVE', 'EA', 18972, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (548, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '마스크팩 - 파우더 팩트 10g', '파우더 팩트 10g', 'P011048', 'ACTIVE', 'EA', 80567, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (549, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '아이 메이크업 - 컬링 마스카라 8ml', '컬링 마스카라 8ml', 'P011049', 'ACTIVE', 'EA', 50025, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (550, '2024-07-12 09:00:00', '2024-07-12 09:00:00', '마스크팩 - 히알루론산 수면팩 80ml', '히알루론산 수면팩 80ml', 'P011050', 'ACTIVE', 'EA', 91436, 11);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (551, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '립 메이크업 - 물들임 립틴트 5ml', '물들임 립틴트 5ml', 'P012001', 'ACTIVE', 'EA', 75421, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (552, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 집중관리 - 레티놀 세럼 30ml', '레티놀 세럼 30ml', 'P012002', 'ACTIVE', 'EA', 40147, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (553, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P012003', 'ACTIVE', 'EA', 72759, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (554, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '립 메이크업 - 아이브로우 틴트 5g', '아이브로우 틴트 5g', 'P012004', 'ACTIVE', 'EA', 18339, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (555, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '아이 메이크업 - 마스카라 블랙 10ml', '마스카라 블랙 10ml', 'P012005', 'ACTIVE', 'EA', 66391, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (556, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 시카 크림 50ml', '시카 크림 50ml', 'P012006', 'ACTIVE', 'EA', 60169, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (557, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 - 그린티 프레시 토너 200ml', '그린티 프레시 토너 200ml', 'P012007', 'ACTIVE', 'EA', 91692, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (558, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P012008', 'ACTIVE', 'EA', 2461, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (559, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '아이 메이크업 - 마스카라 블랙 10ml', '마스카라 블랙 10ml', 'P012009', 'ACTIVE', 'EA', 62115, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (560, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '헤어케어 - 헤어왁스 100g', '헤어왁스 100g', 'P012010', 'ACTIVE', 'EA', 99971, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (561, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '클렌징 - 저자극 클렌징폼 150ml', '저자극 클렌징폼 150ml', 'P012011', 'ACTIVE', 'EA', 49181, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (562, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '아이 메이크업 - 마스카라 블랙 10ml', '마스카라 블랙 10ml', 'P012012', 'ACTIVE', 'EA', 31245, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (563, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '화장품 - 메이크업 픽서 80ml', '메이크업 픽서 80ml', 'P012013', 'ACTIVE', 'EA', 54668, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (564, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 아이크림 30ml', '아이크림 30ml', 'P012014', 'ACTIVE', 'EA', 62839, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (565, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P012015', 'ACTIVE', 'EA', 30547, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (566, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 시카 크림 50ml', '시카 크림 50ml', 'P012016', 'ACTIVE', 'EA', 81833, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (567, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 젤네일 10ml', '젤네일 10ml', 'P012017', 'ACTIVE', 'EA', 67612, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (568, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '립 메이크업 - 매트 립크레용 2.5g', '매트 립크레용 2.5g', 'P012018', 'ACTIVE', 'EA', 45571, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (569, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P012019', 'ACTIVE', 'EA', 65433, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (570, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '화장품 - 뷰러 1개', '뷰러 1개', 'P012020', 'ACTIVE', 'EA', 39729, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (571, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '클렌징 - 모공케어 클렌징 150ml', '모공케어 클렌징 150ml', 'P012021', 'ACTIVE', 'EA', 79010, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (572, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 집중관리 - 나이아신아마이드 세럼 30ml', '나이아신아마이드 세럼 30ml', 'P012022', 'ACTIVE', 'EA', 30962, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (573, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 세라마이드 크림 80ml', '세라마이드 크림 80ml', 'P012023', 'ACTIVE', 'EA', 55450, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (574, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 - 티트리 토너 200ml', '티트리 토너 200ml', 'P012024', 'ACTIVE', 'EA', 42895, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (575, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 젤 아이라이너 2.5g', '젤 아이라이너 2.5g', 'P012025', 'ACTIVE', 'EA', 13777, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (576, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '화장품 - 멀티밤 20g', '멀티밤 20g', 'P012026', 'ACTIVE', 'EA', 20653, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (577, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 크림 아이섀도우 5g', '크림 아이섀도우 5g', 'P012027', 'ACTIVE', 'EA', 25341, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (578, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P012028', 'ACTIVE', 'EA', 70970, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (579, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 - 에센스 미스트 100ml', '에센스 미스트 100ml', 'P012029', 'ACTIVE', 'EA', 7066, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (580, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 넥크림 50ml', '넥크림 50ml', 'P012030', 'ACTIVE', 'EA', 93716, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (581, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '립 메이크업 - 립앤아이 리무버 100ml', '립앤아이 리무버 100ml', 'P012031', 'ACTIVE', 'EA', 90923, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (582, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '립 메이크업 - 립앤아이 리무버 100ml', '립앤아이 리무버 100ml', 'P012032', 'ACTIVE', 'EA', 99914, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (583, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '화장품 - 듀얼 브로우 펜슬 0.6g', '듀얼 브로우 펜슬 0.6g', 'P012033', 'ACTIVE', 'EA', 17114, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (584, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P012034', 'ACTIVE', 'EA', 51723, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (585, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 시카 크림 50ml', '시카 크림 50ml', 'P012035', 'ACTIVE', 'EA', 17404, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (586, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '아이 메이크업 - 단색 아이섀도우 2g', '단색 아이섀도우 2g', 'P012036', 'ACTIVE', 'EA', 49563, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (587, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '베이스 메이크업 - 쿠션 본품+리필 세트', '쿠션 본품+리필 세트', 'P012037', 'ACTIVE', 'EA', 9408, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (588, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '화장품 - 트리플 팔레트 18g', '트리플 팔레트 18g', 'P012038', 'ACTIVE', 'EA', 27267, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (589, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P012039', 'ACTIVE', 'EA', 87386, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (590, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '클렌징 - 큐티클 오일 5ml', '큐티클 오일 5ml', 'P012040', 'ACTIVE', 'EA', 29189, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (591, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '화장품 - 컨투어링 팔레트 10g', '컨투어링 팔레트 10g', 'P012041', 'ACTIVE', 'EA', 1150, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (592, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '베이스 메이크업 - 커버 쿠션 15g', '커버 쿠션 15g', 'P012042', 'ACTIVE', 'EA', 13536, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (593, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '화장품 - 맨즈 스킨 150ml', '맨즈 스킨 150ml', 'P012043', 'ACTIVE', 'EA', 45179, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (594, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '립 메이크업 - 아이브로우 틴트 5g', '아이브로우 틴트 5g', 'P012044', 'ACTIVE', 'EA', 35188, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (595, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '립 메이크업 - 립스틱 세트 5개입', '립스틱 세트 5개입', 'P012045', 'ACTIVE', 'EA', 78026, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (596, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '클렌징 - 블랙헤드 클렌징 오일 200ml', '블랙헤드 클렌징 오일 200ml', 'P012046', 'ACTIVE', 'EA', 33637, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (597, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '마스크팩 - 슬리핑팩 100ml', '슬리핑팩 100ml', 'P012047', 'ACTIVE', 'EA', 86515, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (598, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '립 메이크업 - 립스틱 세트 5개입', '립스틱 세트 5개입', 'P012048', 'ACTIVE', 'EA', 71551, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (599, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P012049', 'ACTIVE', 'EA', 81687, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (600, '2024-07-13 09:00:00', '2024-07-13 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P012050', 'ACTIVE', 'EA', 37292, 12);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (601, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '클렌징 - 페이셜 오일 30ml', '페이셜 오일 30ml', 'P013001', 'ACTIVE', 'EA', 81407, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (602, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 보습 - 미백 크림 50g', '미백 크림 50g', 'P013002', 'ACTIVE', 'EA', 76111, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (603, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P013003', 'ACTIVE', 'EA', 41702, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (604, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 - 딥클렌징 워터 500ml', '딥클렌징 워터 500ml', 'P013004', 'ACTIVE', 'EA', 46444, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (605, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '마스크팩 - 모공팩 100ml', '모공팩 100ml', 'P013005', 'ACTIVE', 'EA', 42286, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (606, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '헤어케어 - 린스 500ml', '린스 500ml', 'P013006', 'ACTIVE', 'EA', 52341, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (607, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 보습 - 선크림 SPF50+ 50ml', '선크림 SPF50+ 50ml', 'P013007', 'ACTIVE', 'EA', 3808, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (608, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 스킨케어 체험 세트', '스킨케어 체험 세트', 'P013008', 'ACTIVE', 'EA', 77154, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (609, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 집중관리 - 비타민C 세럼 50ml', '비타민C 세럼 50ml', 'P013009', 'ACTIVE', 'EA', 16867, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (610, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 - 바디미스트 향수 200ml', '바디미스트 향수 200ml', 'P013010', 'ACTIVE', 'EA', 78163, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (611, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '헤어케어 - 샴푸 500ml', '샴푸 500ml', 'P013011', 'ACTIVE', 'EA', 58432, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (612, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '마스크팩 - 티트리 마스크 10매', '티트리 마스크 10매', 'P013012', 'ACTIVE', 'EA', 58705, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (613, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '립 메이크업 - 매트 립스틱 3.5g', '매트 립스틱 3.5g', 'P013013', 'ACTIVE', 'EA', 85111, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (614, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '립 메이크업 - 립앤아이 리무버 100ml', '립앤아이 리무버 100ml', 'P013014', 'ACTIVE', 'EA', 42356, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (615, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '마스크팩 - 투웨이 팩트 12g', '투웨이 팩트 12g', 'P013015', 'ACTIVE', 'EA', 31891, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (616, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 애프터쉐이브 100ml', '애프터쉐이브 100ml', 'P013016', 'ACTIVE', 'EA', 34438, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (617, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 집중관리 - 시카 리페어 세럼 50ml', '시카 리페어 세럼 50ml', 'P013017', 'ACTIVE', 'EA', 14032, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (618, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 보습 - 맨즈 선크림 50ml', '맨즈 선크림 50ml', 'P013018', 'ACTIVE', 'EA', 23440, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (619, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 메이크업 픽서 80ml', '메이크업 픽서 80ml', 'P013019', 'ACTIVE', 'EA', 90776, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (620, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 - 에센스 미스트 100ml', '에센스 미스트 100ml', 'P013020', 'ACTIVE', 'EA', 39003, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (621, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '클렌징 - 바디오일 100ml', '바디오일 100ml', 'P013021', 'ACTIVE', 'EA', 89109, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (622, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 커버 컨실러 6ml', '커버 컨실러 6ml', 'P013022', 'ACTIVE', 'EA', 8973, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (623, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 - 라벤더 워터 토너 200ml', '라벤더 워터 토너 200ml', 'P013023', 'ACTIVE', 'EA', 66586, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (624, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '클렌징 - 딥클렌징 오일 200ml', '딥클렌징 오일 200ml', 'P013024', 'ACTIVE', 'EA', 17865, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (625, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 보습 - 영양 크림 50ml', '영양 크림 50ml', 'P013025', 'ACTIVE', 'EA', 19474, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (626, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P013026', 'ACTIVE', 'EA', 70182, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (627, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '마스크팩 - 마스크 시트 50매', '마스크 시트 50매', 'P013027', 'ACTIVE', 'EA', 26809, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (628, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '아이 메이크업 - 단색 아이섀도우 2g', '단색 아이섀도우 2g', 'P013028', 'ACTIVE', 'EA', 92908, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (629, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '바디케어 - 바디스크럽 200ml', '바디스크럽 200ml', 'P013029', 'ACTIVE', 'EA', 36140, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (630, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 수딩 선스프레이 150ml', '수딩 선스프레이 150ml', 'P013030', 'ACTIVE', 'EA', 28655, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (631, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P013031', 'ACTIVE', 'EA', 34450, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (632, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 보습 - 비비크림 50ml', '비비크림 50ml', 'P013032', 'ACTIVE', 'EA', 47982, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (633, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 보습 - 레티놀 크림 30ml', '레티놀 크림 30ml', 'P013033', 'ACTIVE', 'EA', 7181, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (634, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 메이크업 스펀지 10개입', '메이크업 스펀지 10개입', 'P013034', 'ACTIVE', 'EA', 11433, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (635, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '마스크팩 - 수면팩 미니 30ml', '수면팩 미니 30ml', 'P013035', 'ACTIVE', 'EA', 92917, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (636, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '아이 메이크업 - 섀도우 스틱 1.5g', '섀도우 스틱 1.5g', 'P013036', 'ACTIVE', 'EA', 19526, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (637, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 커버 컨실러 6ml', '커버 컨실러 6ml', 'P013037', 'ACTIVE', 'EA', 98141, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (638, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 보습 - 레티놀 크림 30ml', '레티놀 크림 30ml', 'P013038', 'ACTIVE', 'EA', 31576, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (639, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '마스크팩 - 투웨이 팩트 12g', '투웨이 팩트 12g', 'P013039', 'ACTIVE', 'EA', 94285, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (640, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '헤어케어 - 헤어왁스 100g', '헤어왁스 100g', 'P013040', 'ACTIVE', 'EA', 6849, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (641, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 보습 - 베이비 선크림 100ml', '베이비 선크림 100ml', 'P013041', 'ACTIVE', 'EA', 19267, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (642, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 멀티 스틱 9g', '멀티 스틱 9g', 'P013042', 'ACTIVE', 'EA', 3578, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (643, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 보습 - 톤업 선크림 50ml', '톤업 선크림 50ml', 'P013043', 'ACTIVE', 'EA', 5690, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (644, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 - 병풀 진정 토너 250ml', '병풀 진정 토너 250ml', 'P013044', 'ACTIVE', 'EA', 19868, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (645, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '마스크팩 - 투웨이 팩트 12g', '투웨이 팩트 12g', 'P013045', 'ACTIVE', 'EA', 50544, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (646, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '스킨케어 - 비타민C 토너 200ml', '비타민C 토너 200ml', 'P013046', 'ACTIVE', 'EA', 56623, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (647, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P013047', 'ACTIVE', 'EA', 76963, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (648, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '화장품 - 탑코트 10ml', '탑코트 10ml', 'P013048', 'ACTIVE', 'EA', 56161, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (649, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '클렌징 - 클렌징밤 100ml', '클렌징밤 100ml', 'P013049', 'ACTIVE', 'EA', 4231, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (650, '2024-07-14 09:00:00', '2024-07-14 09:00:00', '립 메이크업 - 립스틱 세트 5개입', '립스틱 세트 5개입', 'P013050', 'ACTIVE', 'EA', 23699, 13);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (651, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '클렌징 - 립 글로우 오일 7ml', '립 글로우 오일 7ml', 'P014001', 'ACTIVE', 'EA', 21238, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (652, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 집중관리 - 병풀 앰플 30ml', '병풀 앰플 30ml', 'P014002', 'ACTIVE', 'EA', 89185, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (653, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P014003', 'ACTIVE', 'EA', 67850, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (654, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 - 헤어미스트 150ml', '헤어미스트 150ml', 'P014004', 'ACTIVE', 'EA', 68722, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (655, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 - 미셀라워터 500ml', '미셀라워터 500ml', 'P014005', 'ACTIVE', 'EA', 19911, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (656, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 - 미셀라워터 500ml', '미셀라워터 500ml', 'P014006', 'ACTIVE', 'EA', 65478, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (657, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 집중관리 - 레티놀 세럼 30ml', '레티놀 세럼 30ml', 'P014007', 'ACTIVE', 'EA', 14729, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (658, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 집중관리 - 비타민C 세럼 50ml', '비타민C 세럼 50ml', 'P014008', 'ACTIVE', 'EA', 47719, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (659, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P014009', 'ACTIVE', 'EA', 99012, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (660, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P014010', 'ACTIVE', 'EA', 10813, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (661, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 하이라이터 4g', '하이라이터 4g', 'P014011', 'ACTIVE', 'EA', 98194, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (662, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 향수 기획세트', '향수 기획세트', 'P014012', 'ACTIVE', 'EA', 21441, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (663, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '클렌징 - 립 글로우 오일 7ml', '립 글로우 오일 7ml', 'P014013', 'ACTIVE', 'EA', 3939, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (664, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '아이 메이크업 - 글리터 아이섀도우 4g', '글리터 아이섀도우 4g', 'P014014', 'ACTIVE', 'EA', 10418, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (665, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '아이 메이크업 - 아이섀도우 메가팔레트 40색', '아이섀도우 메가팔레트 40색', 'P014015', 'ACTIVE', 'EA', 47442, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (666, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '립 메이크업 - 벨벳 틴트 4g', '벨벳 틴트 4g', 'P014016', 'ACTIVE', 'EA', 18320, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (667, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 보습 - 콜라겐 크림 50ml', '콜라겐 크림 50ml', 'P014017', 'ACTIVE', 'EA', 48297, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (668, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '아이 메이크업 - 리퀴드 아이라이너 5ml', '리퀴드 아이라이너 5ml', 'P014018', 'ACTIVE', 'EA', 45835, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (669, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P014019', 'ACTIVE', 'EA', 28769, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (670, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '아이 메이크업 - 롱래쉬 마스카라 8ml', '롱래쉬 마스카라 8ml', 'P014020', 'ACTIVE', 'EA', 39605, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (671, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 보습 - 세라마이드 크림 80ml', '세라마이드 크림 80ml', 'P014021', 'ACTIVE', 'EA', 26666, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (672, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 보습 - 젤네일 10ml', '젤네일 10ml', 'P014022', 'ACTIVE', 'EA', 71976, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (673, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 보습 - 무기자차 선크림 50ml', '무기자차 선크림 50ml', 'P014023', 'ACTIVE', 'EA', 44455, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (674, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 - 알로에 수딩 토너 300ml', '알로에 수딩 토너 300ml', 'P014024', 'ACTIVE', 'EA', 54184, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (675, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '립 메이크업 - 립라이너 0.3g', '립라이너 0.3g', 'P014025', 'ACTIVE', 'EA', 10271, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (676, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '베이스 메이크업 - 쿠션 본품+리필 세트', '쿠션 본품+리필 세트', 'P014026', 'ACTIVE', 'EA', 44458, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (677, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 보습 - CC크림 50ml', 'CC크림 50ml', 'P014027', 'ACTIVE', 'EA', 22299, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (678, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '클렌징 - 딥클렌징 오일 200ml', '딥클렌징 오일 200ml', 'P014028', 'ACTIVE', 'EA', 33937, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (679, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '베이스 메이크업 - 파우더 쿠션 15g', '파우더 쿠션 15g', 'P014029', 'ACTIVE', 'EA', 62934, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (680, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 각질제거 패드 60매', '각질제거 패드 60매', 'P014030', 'ACTIVE', 'EA', 73377, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (681, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 집중관리 - 펩타이드 세럼 30ml', '펩타이드 세럼 30ml', 'P014031', 'ACTIVE', 'EA', 23227, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (682, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 집중관리 - 레티놀 세럼 30ml', '레티놀 세럼 30ml', 'P014032', 'ACTIVE', 'EA', 74076, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (683, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 컨투어 팔레트 15g', '컨투어 팔레트 15g', 'P014033', 'ACTIVE', 'EA', 94803, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (684, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 브로우 파우더 4g', '브로우 파우더 4g', 'P014034', 'ACTIVE', 'EA', 18301, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (685, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 보습 - 스틱형 선크림 18g', '스틱형 선크림 18g', 'P014035', 'ACTIVE', 'EA', 51416, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (686, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 수딩 선스프레이 150ml', '수딩 선스프레이 150ml', 'P014036', 'ACTIVE', 'EA', 4225, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (687, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 맨즈 스킨 150ml', '맨즈 스킨 150ml', 'P014037', 'ACTIVE', 'EA', 59240, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (688, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 퍼프 5개입', '퍼프 5개입', 'P014038', 'ACTIVE', 'EA', 20231, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (689, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 - 티트리 토너 200ml', '티트리 토너 200ml', 'P014039', 'ACTIVE', 'EA', 34577, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (690, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 쉐딩 6g', '쉐딩 6g', 'P014040', 'ACTIVE', 'EA', 18870, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (691, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P014041', 'ACTIVE', 'EA', 90608, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (692, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 커버 컨실러 6ml', '커버 컨실러 6ml', 'P014042', 'ACTIVE', 'EA', 21249, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (693, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '클렌징 - 더블 클렌징 세트', '더블 클렌징 세트', 'P014043', 'ACTIVE', 'EA', 73810, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (694, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '아이 메이크업 - 리퀴드 아이라이너 5ml', '리퀴드 아이라이너 5ml', 'P014044', 'ACTIVE', 'EA', 97257, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (695, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '아이 메이크업 - 아이섀도우 메가팔레트 40색', '아이섀도우 메가팔레트 40색', 'P014045', 'ACTIVE', 'EA', 79652, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (696, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 메이크업 스펀지 10개입', '메이크업 스펀지 10개입', 'P014046', 'ACTIVE', 'EA', 34142, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (697, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '화장품 - 샘플 세트 10종', '샘플 세트 10종', 'P014047', 'ACTIVE', 'EA', 91648, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (698, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '스킨케어 보습 - 스포츠 선크림 70ml', '스포츠 선크림 70ml', 'P014048', 'ACTIVE', 'EA', 34510, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (699, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '마스크팩 - 모공팩 100ml', '모공팩 100ml', 'P014049', 'ACTIVE', 'EA', 38986, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (700, '2024-07-15 09:00:00', '2024-07-15 09:00:00', '베이스 메이크업 - 파운데이션 30ml', '파운데이션 30ml', 'P014050', 'ACTIVE', 'EA', 93084, 14);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (701, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 오드퍼퓸 50ml', '오드퍼퓸 50ml', 'P015001', 'ACTIVE', 'EA', 1299, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (702, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P015002', 'ACTIVE', 'EA', 68834, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (703, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 보디파우더 100g', '보디파우더 100g', 'P015003', 'ACTIVE', 'EA', 75005, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (704, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '립 메이크업 - 립라이너 0.3g', '립라이너 0.3g', 'P015004', 'ACTIVE', 'EA', 49305, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (705, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '마스크팩 - 티트리 마스크 10매', '티트리 마스크 10매', 'P015005', 'ACTIVE', 'EA', 94252, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (706, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 브러쉬 세트 7종', '브러쉬 세트 7종', 'P015006', 'ACTIVE', 'EA', 53572, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (707, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P015007', 'ACTIVE', 'EA', 73494, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (708, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 집중관리 - 프로폴리스 앰플마스크 10매', '프로폴리스 앰플마스크 10매', 'P015008', 'ACTIVE', 'EA', 27523, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (709, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 브러쉬 세트 7종', '브러쉬 세트 7종', 'P015009', 'ACTIVE', 'EA', 50377, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (710, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 집중관리 - 비타민C 앰플 30ml', '비타민C 앰플 30ml', 'P015010', 'ACTIVE', 'EA', 14216, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (711, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 프라이머 30ml', '프라이머 30ml', 'P015011', 'ACTIVE', 'EA', 15285, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (712, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P015012', 'ACTIVE', 'EA', 84927, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (713, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 보습 - 맨즈 아이크림 30ml', '맨즈 아이크림 30ml', 'P015013', 'ACTIVE', 'EA', 71681, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (714, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P015014', 'ACTIVE', 'EA', 23262, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (715, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 - 에센스 미스트 100ml', '에센스 미스트 100ml', 'P015015', 'ACTIVE', 'EA', 61807, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (716, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 - 딥클렌징 워터 500ml', '딥클렌징 워터 500ml', 'P015016', 'ACTIVE', 'EA', 66773, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (717, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 메이크업 스펀지 10개입', '메이크업 스펀지 10개입', 'P015017', 'ACTIVE', 'EA', 25212, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (718, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 보습 - 베이비 선크림 100ml', '베이비 선크림 100ml', 'P015018', 'ACTIVE', 'EA', 10831, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (719, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '마스크팩 - 마스크 시트 50매', '마스크 시트 50매', 'P015019', 'ACTIVE', 'EA', 87804, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (720, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 보습 - 선크림 SPF50+ 50ml', '선크림 SPF50+ 50ml', 'P015020', 'ACTIVE', 'EA', 77892, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (721, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '아이 메이크업 - 아이패치 60매', '아이패치 60매', 'P015021', 'ACTIVE', 'EA', 15295, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (722, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P015022', 'ACTIVE', 'EA', 15129, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (723, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 스킨케어 기획세트', '스킨케어 기획세트', 'P015023', 'ACTIVE', 'EA', 55035, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (724, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '립 메이크업 - 립 컬렉션 세트', '립 컬렉션 세트', 'P015024', 'ACTIVE', 'EA', 20933, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (725, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '클렌징 - 쉐이빙폼 150ml', '쉐이빙폼 150ml', 'P015025', 'ACTIVE', 'EA', 95252, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (726, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P015026', 'ACTIVE', 'EA', 6955, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (727, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '립 메이크업 - 벨벳 틴트 4g', '벨벳 틴트 4g', 'P015027', 'ACTIVE', 'EA', 59875, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (728, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 집중관리 - 히알루론산 세럼 30ml', '히알루론산 세럼 30ml', 'P015028', 'ACTIVE', 'EA', 84420, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (729, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '립 메이크업 - 립앤아이 리무버 100ml', '립앤아이 리무버 100ml', 'P015029', 'ACTIVE', 'EA', 16868, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (730, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 - 비타민C 토너 200ml', '비타민C 토너 200ml', 'P015030', 'ACTIVE', 'EA', 53975, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (731, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '립 메이크업 - 립브러쉬 1개', '립브러쉬 1개', 'P015031', 'ACTIVE', 'EA', 34829, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (732, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P015032', 'ACTIVE', 'EA', 38435, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (733, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P015033', 'ACTIVE', 'EA', 18347, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (734, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 - 그린티 프레시 토너 200ml', '그린티 프레시 토너 200ml', 'P015034', 'ACTIVE', 'EA', 69680, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (735, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 메이크업베이스 35ml', '메이크업베이스 35ml', 'P015035', 'ACTIVE', 'EA', 69309, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (736, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 집중관리 - 펩타이드 세럼 30ml', '펩타이드 세럼 30ml', 'P015036', 'ACTIVE', 'EA', 30512, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (737, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 글로우 스틱 8g', '글로우 스틱 8g', 'P015037', 'ACTIVE', 'EA', 98278, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (738, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 보습 - 풋크림 100ml', '풋크림 100ml', 'P015038', 'ACTIVE', 'EA', 24110, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (739, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 보습 - 풋크림 100ml', '풋크림 100ml', 'P015039', 'ACTIVE', 'EA', 84502, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (740, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P015040', 'ACTIVE', 'EA', 13832, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (741, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '헤어케어 - 헤어왁스 100g', '헤어왁스 100g', 'P015041', 'ACTIVE', 'EA', 56948, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (742, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 보습 - 바디로션 300ml', '바디로션 300ml', 'P015042', 'ACTIVE', 'EA', 20305, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (743, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 보습 - 선크림 SPF50+ 50ml', '선크림 SPF50+ 50ml', 'P015043', 'ACTIVE', 'EA', 37498, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (744, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 블러셔 6g', '블러셔 6g', 'P015044', 'ACTIVE', 'EA', 32971, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (745, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 보습 - 맨즈 아이크림 30ml', '맨즈 아이크림 30ml', 'P015045', 'ACTIVE', 'EA', 16693, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (746, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '클렌징 - 클렌징밤 100ml', '클렌징밤 100ml', 'P015046', 'ACTIVE', 'EA', 88977, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (747, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '베이스 메이크업 - 파운데이션 30ml', '파운데이션 30ml', 'P015047', 'ACTIVE', 'EA', 42160, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (748, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '화장품 - 샘플 세트 10종', '샘플 세트 10종', 'P015048', 'ACTIVE', 'EA', 87980, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (749, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '스킨케어 - 미셀라워터 500ml', '미셀라워터 500ml', 'P015049', 'ACTIVE', 'EA', 52918, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (750, '2024-07-16 09:00:00', '2024-07-16 09:00:00', '클렌징 - 저자극 클렌징폼 150ml', '저자극 클렌징폼 150ml', 'P015050', 'ACTIVE', 'EA', 74166, 15);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (751, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P016001', 'ACTIVE', 'EA', 97997, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (752, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '아이 메이크업 - 섀도우 스틱 1.5g', '섀도우 스틱 1.5g', 'P016002', 'ACTIVE', 'EA', 78185, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (753, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 보습 - 무기자차 선크림 50ml', '무기자차 선크림 50ml', 'P016003', 'ACTIVE', 'EA', 35516, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (754, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '립 메이크업 - 립라이너 0.3g', '립라이너 0.3g', 'P016004', 'ACTIVE', 'EA', 28983, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (755, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 스킨케어 체험 세트', '스킨케어 체험 세트', 'P016005', 'ACTIVE', 'EA', 49960, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (756, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 오드뚜왈렛 100ml', '오드뚜왈렛 100ml', 'P016006', 'ACTIVE', 'EA', 52184, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (757, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P016007', 'ACTIVE', 'EA', 41598, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (758, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P016008', 'ACTIVE', 'EA', 1686, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (759, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 보습 - 톤업 선크림 50ml', '톤업 선크림 50ml', 'P016009', 'ACTIVE', 'EA', 39229, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (760, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 뷰러 1개', '뷰러 1개', 'P016010', 'ACTIVE', 'EA', 94265, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (761, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '마스크팩 - 진정 마스크 10매', '진정 마스크 10매', 'P016011', 'ACTIVE', 'EA', 93990, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (762, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '마스크팩 - 미백 마스크팩 10매', '미백 마스크팩 10매', 'P016012', 'ACTIVE', 'EA', 81429, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (763, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 보습 - 젤네일 10ml', '젤네일 10ml', 'P016013', 'ACTIVE', 'EA', 57790, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (764, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 집중관리 - 맨즈 에센스 50ml', '맨즈 에센스 50ml', 'P016014', 'ACTIVE', 'EA', 60101, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (765, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 집중관리 - 스네일 에센스 50ml', '스네일 에센스 50ml', 'P016015', 'ACTIVE', 'EA', 55849, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (766, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 오드퍼퓸 50ml', '오드퍼퓸 50ml', 'P016016', 'ACTIVE', 'EA', 64620, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (767, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 오드퍼퓸 50ml', '오드퍼퓸 50ml', 'P016017', 'ACTIVE', 'EA', 14781, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (768, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 - 라벤더 워터 토너 200ml', '라벤더 워터 토너 200ml', 'P016018', 'ACTIVE', 'EA', 63186, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (769, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P016019', 'ACTIVE', 'EA', 63200, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (770, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 보습 - 세라마이드 크림 80ml', '세라마이드 크림 80ml', 'P016020', 'ACTIVE', 'EA', 29852, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (771, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 보습 - 수분 선젤 50ml', '수분 선젤 50ml', 'P016021', 'ACTIVE', 'EA', 78046, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (772, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P016022', 'ACTIVE', 'EA', 7034, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (773, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '마스크팩 - 히알루론산 수면팩 80ml', '히알루론산 수면팩 80ml', 'P016023', 'ACTIVE', 'EA', 46910, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (774, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '립 메이크업 - 립라이너 0.3g', '립라이너 0.3g', 'P016024', 'ACTIVE', 'EA', 23890, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (775, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 속눈썹 집게 1개', '속눈썹 집게 1개', 'P016025', 'ACTIVE', 'EA', 67483, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (776, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P016026', 'ACTIVE', 'EA', 25860, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (777, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '클렌징 - 립 글로우 오일 7ml', '립 글로우 오일 7ml', 'P016027', 'ACTIVE', 'EA', 29678, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (778, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '아이 메이크업 - 마스카라 블랙 10ml', '마스카라 블랙 10ml', 'P016028', 'ACTIVE', 'EA', 99433, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (779, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '마스크팩 - 수면팩 미니 30ml', '수면팩 미니 30ml', 'P016029', 'ACTIVE', 'EA', 11095, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (780, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '립 메이크업 - 매트 립크레용 2.5g', '매트 립크레용 2.5g', 'P016030', 'ACTIVE', 'EA', 77387, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (781, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P016031', 'ACTIVE', 'EA', 73699, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (782, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 쉐딩 6g', '쉐딩 6g', 'P016032', 'ACTIVE', 'EA', 28348, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (783, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 메이크업 스펀지 10개입', '메이크업 스펀지 10개입', 'P016033', 'ACTIVE', 'EA', 24256, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (784, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 보습 - 콜라겐 크림 50ml', '콜라겐 크림 50ml', 'P016034', 'ACTIVE', 'EA', 18303, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (785, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 블러셔 6g', '블러셔 6g', 'P016035', 'ACTIVE', 'EA', 23985, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (786, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 두피스케일러 200ml', '두피스케일러 200ml', 'P016036', 'ACTIVE', 'EA', 85138, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (787, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '립 메이크업 - 립스틱 세트 5개입', '립스틱 세트 5개입', 'P016037', 'ACTIVE', 'EA', 1610, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (788, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 탑코트 10ml', '탑코트 10ml', 'P016038', 'ACTIVE', 'EA', 14366, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (789, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 집중관리 - 스네일 에센스 50ml', '스네일 에센스 50ml', 'P016039', 'ACTIVE', 'EA', 17907, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (790, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 집중관리 - 시카 리페어 세럼 50ml', '시카 리페어 세럼 50ml', 'P016040', 'ACTIVE', 'EA', 2884, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (791, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '립 메이크업 - 립 트리트먼트 15g', '립 트리트먼트 15g', 'P016041', 'ACTIVE', 'EA', 8693, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (792, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 - 미셀라워터 500ml', '미셀라워터 500ml', 'P016042', 'ACTIVE', 'EA', 35267, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (793, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 집중관리 - 펩타이드 세럼 30ml', '펩타이드 세럼 30ml', 'P016043', 'ACTIVE', 'EA', 16994, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (794, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 집중관리 - 히알루론산 세럼 30ml', '히알루론산 세럼 30ml', 'P016044', 'ACTIVE', 'EA', 70876, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (795, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P016045', 'ACTIVE', 'EA', 40136, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (796, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 보습 - 비비크림 50ml', '비비크림 50ml', 'P016046', 'ACTIVE', 'EA', 2700, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (797, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '아이 메이크업 - 글리터 아이섀도우 4g', '글리터 아이섀도우 4g', 'P016047', 'ACTIVE', 'EA', 64115, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (798, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '클렌징 - 큐티클 오일 5ml', '큐티클 오일 5ml', 'P016048', 'ACTIVE', 'EA', 80742, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (799, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '클렌징 - 페이셜 오일 30ml', '페이셜 오일 30ml', 'P016049', 'ACTIVE', 'EA', 77631, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (800, '2024-07-17 09:00:00', '2024-07-17 09:00:00', '스킨케어 - 에센스 미스트 100ml', '에센스 미스트 100ml', 'P016050', 'ACTIVE', 'EA', 30459, 16);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (801, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 애프터쉐이브 100ml', '애프터쉐이브 100ml', 'P017001', 'ACTIVE', 'EA', 45362, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (802, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '립 메이크업 - 아이브로우 틴트 5g', '아이브로우 틴트 5g', 'P017002', 'ACTIVE', 'EA', 84343, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (803, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '아이 메이크업 - 아이라이너 펜슬 0.5g', '아이라이너 펜슬 0.5g', 'P017003', 'ACTIVE', 'EA', 13208, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (804, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '아이 메이크업 - 단색 아이섀도우 2g', '단색 아이섀도우 2g', 'P017004', 'ACTIVE', 'EA', 4285, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (805, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '립 메이크업 - 립앤아이 리무버 100ml', '립앤아이 리무버 100ml', 'P017005', 'ACTIVE', 'EA', 2710, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (806, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '아이 메이크업 - 롱래쉬 마스카라 8ml', '롱래쉬 마스카라 8ml', 'P017006', 'ACTIVE', 'EA', 85833, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (807, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 메이크업 픽서 80ml', '메이크업 픽서 80ml', 'P017007', 'ACTIVE', 'EA', 54994, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (808, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '클렌징 - 모공케어 클렌징 150ml', '모공케어 클렌징 150ml', 'P017008', 'ACTIVE', 'EA', 14079, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (809, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P017009', 'ACTIVE', 'EA', 41518, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (810, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '바디케어 - 바디스크럽 200ml', '바디스크럽 200ml', 'P017010', 'ACTIVE', 'EA', 59146, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (811, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 - 비타민C 토너 200ml', '비타민C 토너 200ml', 'P017011', 'ACTIVE', 'EA', 10171, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (812, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '마스크팩 - 마스크 시트 50매', '마스크 시트 50매', 'P017012', 'ACTIVE', 'EA', 10629, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (813, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 멀티 스틱 9g', '멀티 스틱 9g', 'P017013', 'ACTIVE', 'EA', 51279, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (814, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '베이스 메이크업 - 파우더 쿠션 15g', '파우더 쿠션 15g', 'P017014', 'ACTIVE', 'EA', 21446, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (815, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 보습 - 핸드크림 50ml', '핸드크림 50ml', 'P017015', 'ACTIVE', 'EA', 60137, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (816, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '헤어케어 - 헤어스프레이 300ml', '헤어스프레이 300ml', 'P017016', 'ACTIVE', 'EA', 43987, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (817, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 - 아하BHA 토너 150ml', '아하BHA 토너 150ml', 'P017017', 'ACTIVE', 'EA', 62546, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (818, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 집중관리 - 프로폴리스 앰플 30ml', '프로폴리스 앰플 30ml', 'P017018', 'ACTIVE', 'EA', 97965, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (819, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 보습 - 비비크림 50ml', '비비크림 50ml', 'P017019', 'ACTIVE', 'EA', 87391, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (820, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '아이 메이크업 - 컬링 마스카라 8ml', '컬링 마스카라 8ml', 'P017020', 'ACTIVE', 'EA', 19839, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (821, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 보디파우더 100g', '보디파우더 100g', 'P017021', 'ACTIVE', 'EA', 84049, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (822, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 보습 - 핸드크림 50ml', '핸드크림 50ml', 'P017022', 'ACTIVE', 'EA', 69621, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (823, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '립 메이크업 - 벨벳 틴트 4g', '벨벳 틴트 4g', 'P017023', 'ACTIVE', 'EA', 50188, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (824, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 집중관리 - 프로폴리스 앰플마스크 10매', '프로폴리스 앰플마스크 10매', 'P017024', 'ACTIVE', 'EA', 33574, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (825, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '마스크팩 - 숯 클레이 마스크 100ml', '숯 클레이 마스크 100ml', 'P017025', 'ACTIVE', 'EA', 54846, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (826, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '마스크팩 - 히알루론산 수면팩 80ml', '히알루론산 수면팩 80ml', 'P017026', 'ACTIVE', 'EA', 19894, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (827, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 보습 - 세라마이드 크림 80ml', '세라마이드 크림 80ml', 'P017027', 'ACTIVE', 'EA', 57697, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (828, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 집중관리 - 헤어에센스 100ml', '헤어에센스 100ml', 'P017028', 'ACTIVE', 'EA', 90821, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (829, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 커버 컨실러 6ml', '커버 컨실러 6ml', 'P017029', 'ACTIVE', 'EA', 47815, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (830, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P017030', 'ACTIVE', 'EA', 93234, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (831, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 퍼퓸 롤온 10ml', '퍼퓸 롤온 10ml', 'P017031', 'ACTIVE', 'EA', 30522, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (832, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 집중관리 - 레티놀 세럼 30ml', '레티놀 세럼 30ml', 'P017032', 'ACTIVE', 'EA', 52142, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (833, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '마스크팩 - 투웨이 팩트 12g', '투웨이 팩트 12g', 'P017033', 'ACTIVE', 'EA', 2815, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (834, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 보습 - 맨즈 아이크림 30ml', '맨즈 아이크림 30ml', 'P017034', 'ACTIVE', 'EA', 61518, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (835, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 보습 - 수분 선젤 50ml', '수분 선젤 50ml', 'P017035', 'ACTIVE', 'EA', 46069, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (836, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '클렌징 - 립 글로우 오일 7ml', '립 글로우 오일 7ml', 'P017036', 'ACTIVE', 'EA', 16531, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (837, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '아이 메이크업 - 리퀴드 아이라이너 5ml', '리퀴드 아이라이너 5ml', 'P017037', 'ACTIVE', 'EA', 92499, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (838, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '마스크팩 - 수면팩 미니 30ml', '수면팩 미니 30ml', 'P017038', 'ACTIVE', 'EA', 63650, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (839, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '헤어케어 - 린스 500ml', '린스 500ml', 'P017039', 'ACTIVE', 'EA', 49228, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (840, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 컨투어링 팔레트 10g', '컨투어링 팔레트 10g', 'P017040', 'ACTIVE', 'EA', 16701, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (841, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P017041', 'ACTIVE', 'EA', 80746, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (842, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 - 그린티 프레시 토너 200ml', '그린티 프레시 토너 200ml', 'P017042', 'ACTIVE', 'EA', 36820, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (843, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 트리플 팔레트 18g', '트리플 팔레트 18g', 'P017043', 'ACTIVE', 'EA', 10950, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (844, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '마스크팩 - 헤어팩 200ml', '헤어팩 200ml', 'P017044', 'ACTIVE', 'EA', 69946, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (845, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '마스크팩 - 비타민 마스크 10매', '비타민 마스크 10매', 'P017045', 'ACTIVE', 'EA', 27539, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (846, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 탑코트 10ml', '탑코트 10ml', 'P017046', 'ACTIVE', 'EA', 4449, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (847, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '화장품 - 멀티밤 20g', '멀티밤 20g', 'P017047', 'ACTIVE', 'EA', 14635, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (848, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '아이 메이크업 - 아이패치 60매', '아이패치 60매', 'P017048', 'ACTIVE', 'EA', 53757, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (849, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P017049', 'ACTIVE', 'EA', 86946, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (850, '2024-07-18 09:00:00', '2024-07-18 09:00:00', '스킨케어 - 비타민C 토너 200ml', '비타민C 토너 200ml', 'P017050', 'ACTIVE', 'EA', 43392, 17);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (851, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '립 메이크업 - 아이브로우 틴트 5g', '아이브로우 틴트 5g', 'P018001', 'ACTIVE', 'EA', 74112, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (852, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 집중관리 - 레티놀 세럼 30ml', '레티놀 세럼 30ml', 'P018002', 'ACTIVE', 'EA', 65810, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (853, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '마스크팩 - 수분 시트마스크 10매', '수분 시트마스크 10매', 'P018003', 'ACTIVE', 'EA', 86035, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (854, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 보습 - 미백 크림 50g', '미백 크림 50g', 'P018004', 'ACTIVE', 'EA', 24890, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (855, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 보습 - 레티놀 크림 30ml', '레티놀 크림 30ml', 'P018005', 'ACTIVE', 'EA', 32448, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (856, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 보습 - 크림 아이섀도우 5g', '크림 아이섀도우 5g', 'P018006', 'ACTIVE', 'EA', 99271, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (857, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 보습 - 시카 크림 50ml', '시카 크림 50ml', 'P018007', 'ACTIVE', 'EA', 36147, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (858, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '아이 메이크업 - 컬링 마스카라 8ml', '컬링 마스카라 8ml', 'P018008', 'ACTIVE', 'EA', 57042, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (859, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 오드퍼퓸 50ml', '오드퍼퓸 50ml', 'P018009', 'ACTIVE', 'EA', 4222, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (860, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P018010', 'ACTIVE', 'EA', 20306, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (861, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 브로우 파우더 4g', '브로우 파우더 4g', 'P018011', 'ACTIVE', 'EA', 16946, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (862, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P018012', 'ACTIVE', 'EA', 23391, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (863, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 보습 - 필링젤 120ml', '필링젤 120ml', 'P018013', 'ACTIVE', 'EA', 50997, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (864, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '베이스 메이크업 - 커버 쿠션 15g', '커버 쿠션 15g', 'P018014', 'ACTIVE', 'EA', 31609, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (865, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '아이 메이크업 - 롱래쉬 마스카라 8ml', '롱래쉬 마스카라 8ml', 'P018015', 'ACTIVE', 'EA', 15281, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (866, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 집중관리 - 맨즈 에센스 50ml', '맨즈 에센스 50ml', 'P018016', 'ACTIVE', 'EA', 25677, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (867, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 집중관리 - 히알루론산 세럼 30ml', '히알루론산 세럼 30ml', 'P018017', 'ACTIVE', 'EA', 96344, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (868, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 보습 - 맨즈 아이크림 30ml', '맨즈 아이크림 30ml', 'P018018', 'ACTIVE', 'EA', 54451, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (869, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 오드뚜왈렛 100ml', '오드뚜왈렛 100ml', 'P018019', 'ACTIVE', 'EA', 87132, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (870, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '헤어케어 - 린스 500ml', '린스 500ml', 'P018020', 'ACTIVE', 'EA', 2680, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (871, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 샘플 세트 10종', '샘플 세트 10종', 'P018021', 'ACTIVE', 'EA', 25630, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (872, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 - 딥클렌징 워터 500ml', '딥클렌징 워터 500ml', 'P018022', 'ACTIVE', 'EA', 78172, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (873, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 속눈썹 집게 1개', '속눈썹 집게 1개', 'P018023', 'ACTIVE', 'EA', 59569, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (874, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '마스크팩 - 히알루론산 수면팩 80ml', '히알루론산 수면팩 80ml', 'P018024', 'ACTIVE', 'EA', 56156, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (875, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '마스크팩 - 티트리 마스크 10매', '티트리 마스크 10매', 'P018025', 'ACTIVE', 'EA', 66851, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (876, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '아이 메이크업 - 아이패치 60매', '아이패치 60매', 'P018026', 'ACTIVE', 'EA', 44410, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (877, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '바디케어 - 바디워시 500ml', '바디워시 500ml', 'P018027', 'ACTIVE', 'EA', 74862, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (878, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '클렌징 - 모공케어 클렌징 150ml', '모공케어 클렌징 150ml', 'P018028', 'ACTIVE', 'EA', 52096, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (879, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 - 쌀 토너 150ml', '쌀 토너 150ml', 'P018029', 'ACTIVE', 'EA', 56073, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (880, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 오드뚜왈렛 100ml', '오드뚜왈렛 100ml', 'P018030', 'ACTIVE', 'EA', 36747, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (881, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 - 쌀 토너 150ml', '쌀 토너 150ml', 'P018031', 'ACTIVE', 'EA', 54488, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (882, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '클렌징 - 약산성 클렌징폼 120ml', '약산성 클렌징폼 120ml', 'P018032', 'ACTIVE', 'EA', 8067, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (883, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '베이스 메이크업 - 파운데이션 30ml', '파운데이션 30ml', 'P018033', 'ACTIVE', 'EA', 25218, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (884, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '립 메이크업 - 립앤아이 리무버 100ml', '립앤아이 리무버 100ml', 'P018034', 'ACTIVE', 'EA', 86994, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (885, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '스킨케어 집중관리 - 펩타이드 세럼 30ml', '펩타이드 세럼 30ml', 'P018035', 'ACTIVE', 'EA', 94396, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (886, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P018036', 'ACTIVE', 'EA', 94904, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (887, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 메이크업 스펀지 10개입', '메이크업 스펀지 10개입', 'P018037', 'ACTIVE', 'EA', 13718, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (888, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '아이 메이크업 - 단색 아이섀도우 2g', '단색 아이섀도우 2g', 'P018038', 'ACTIVE', 'EA', 49027, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (889, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '베이스 메이크업 - 파우더 쿠션 15g', '파우더 쿠션 15g', 'P018039', 'ACTIVE', 'EA', 59070, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (890, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 메이크업베이스 35ml', '메이크업베이스 35ml', 'P018040', 'ACTIVE', 'EA', 2524, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (891, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 탑코트 10ml', '탑코트 10ml', 'P018041', 'ACTIVE', 'EA', 41310, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (892, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 미니 스킨케어 세트 5종', '미니 스킨케어 세트 5종', 'P018042', 'ACTIVE', 'EA', 7401, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (893, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '베이스 메이크업 - 톤업 선쿠션 15g', '톤업 선쿠션 15g', 'P018043', 'ACTIVE', 'EA', 61495, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (894, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '화장품 - 트리플 팔레트 18g', '트리플 팔레트 18g', 'P018044', 'ACTIVE', 'EA', 87756, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (895, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '립 메이크업 - 매트 립크레용 2.5g', '매트 립크레용 2.5g', 'P018045', 'ACTIVE', 'EA', 72466, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (896, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '헤어케어 - 린스 500ml', '린스 500ml', 'P018046', 'ACTIVE', 'EA', 86956, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (897, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '베이스 메이크업 - 톤업 선쿠션 15g', '톤업 선쿠션 15g', 'P018047', 'ACTIVE', 'EA', 14624, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (898, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '마스크팩 - 콜라겐 마스크팩 20매', '콜라겐 마스크팩 20매', 'P018048', 'ACTIVE', 'EA', 68887, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (899, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '마스크팩 - 모공팩 100ml', '모공팩 100ml', 'P018049', 'ACTIVE', 'EA', 59587, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (900, '2024-07-19 09:00:00', '2024-07-19 09:00:00', '립 메이크업 - 벨벳 틴트 4g', '벨벳 틴트 4g', 'P018050', 'ACTIVE', 'EA', 57940, 18);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (901, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P019001', 'ACTIVE', 'EA', 18230, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (902, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '아이 메이크업 - 섀도우 스틱 1.5g', '섀도우 스틱 1.5g', 'P019002', 'ACTIVE', 'EA', 6486, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (903, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 시카 크림 50ml', '시카 크림 50ml', 'P019003', 'ACTIVE', 'EA', 12206, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (904, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '클렌징 - 페이셜 오일 30ml', '페이셜 오일 30ml', 'P019004', 'ACTIVE', 'EA', 22680, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (905, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P019005', 'ACTIVE', 'EA', 21272, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (906, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '클렌징 - 폼클렌징 150ml', '폼클렌징 150ml', 'P019006', 'ACTIVE', 'EA', 58512, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (907, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '베이스 메이크업 - 글로우 쿠션 15g', '글로우 쿠션 15g', 'P019007', 'ACTIVE', 'EA', 75298, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (908, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '마스크팩 - 수면팩 미니 30ml', '수면팩 미니 30ml', 'P019008', 'ACTIVE', 'EA', 58456, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (909, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 스킨케어 체험 세트', '스킨케어 체험 세트', 'P019009', 'ACTIVE', 'EA', 4595, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (910, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 - 비타민C 토너 200ml', '비타민C 토너 200ml', 'P019010', 'ACTIVE', 'EA', 42710, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (911, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 맨즈 선크림 50ml', '맨즈 선크림 50ml', 'P019011', 'ACTIVE', 'EA', 54999, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (912, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 집중관리 - 비타민C 세럼 50ml', '비타민C 세럼 50ml', 'P019012', 'ACTIVE', 'EA', 43826, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (913, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '립 메이크업 - 벨벳 틴트 4g', '벨벳 틴트 4g', 'P019013', 'ACTIVE', 'EA', 46022, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (914, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P019014', 'ACTIVE', 'EA', 55168, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (915, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 풋크림 100ml', '풋크림 100ml', 'P019015', 'ACTIVE', 'EA', 74586, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (916, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 오드뚜왈렛 100ml', '오드뚜왈렛 100ml', 'P019016', 'ACTIVE', 'EA', 72672, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (917, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 영양 크림 50ml', '영양 크림 50ml', 'P019017', 'ACTIVE', 'EA', 65035, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (918, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 집중관리 - 펩타이드 세럼 30ml', '펩타이드 세럼 30ml', 'P019018', 'ACTIVE', 'EA', 35609, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (919, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 세라마이드 크림 80ml', '세라마이드 크림 80ml', 'P019019', 'ACTIVE', 'EA', 84240, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (920, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 스킨케어 기획세트', '스킨케어 기획세트', 'P019020', 'ACTIVE', 'EA', 43354, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (921, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 집중관리 - 스네일 에센스 50ml', '스네일 에센스 50ml', 'P019021', 'ACTIVE', 'EA', 56572, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (922, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 - 로즈워터 토너 300ml', '로즈워터 토너 300ml', 'P019022', 'ACTIVE', 'EA', 11452, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (923, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '마스크팩 - 마스크 시트 50매', '마스크 시트 50매', 'P019023', 'ACTIVE', 'EA', 24524, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (924, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '클렌징 - 바디오일 100ml', '바디오일 100ml', 'P019024', 'ACTIVE', 'EA', 33585, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (925, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P019025', 'ACTIVE', 'EA', 65090, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (926, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '립 메이크업 - 립 트리트먼트 15g', '립 트리트먼트 15g', 'P019026', 'ACTIVE', 'EA', 64168, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (927, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '립 메이크업 - 립플럼퍼 3ml', '립플럼퍼 3ml', 'P019027', 'ACTIVE', 'EA', 96865, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (928, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 글로우 스틱 8g', '글로우 스틱 8g', 'P019028', 'ACTIVE', 'EA', 75994, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (929, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '마스크팩 - 파우더 팩트 10g', '파우더 팩트 10g', 'P019029', 'ACTIVE', 'EA', 71220, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (930, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '클렌징 - 맨즈 클렌징폼 150ml', '맨즈 클렌징폼 150ml', 'P019030', 'ACTIVE', 'EA', 12664, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (931, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 하이라이터 4g', '하이라이터 4g', 'P019031', 'ACTIVE', 'EA', 45365, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (932, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 컨투어링 팔레트 10g', '컨투어링 팔레트 10g', 'P019032', 'ACTIVE', 'EA', 36237, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (933, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '아이 메이크업 - 아이섀도우 팔레트 10색', '아이섀도우 팔레트 10색', 'P019033', 'ACTIVE', 'EA', 72281, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (934, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 바디로션 300ml', '바디로션 300ml', 'P019034', 'ACTIVE', 'EA', 42964, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (935, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 선크림 SPF50+ 50ml', '선크림 SPF50+ 50ml', 'P019035', 'ACTIVE', 'EA', 64257, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (936, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '립 메이크업 - 립 앤 치크 4g', '립 앤 치크 4g', 'P019036', 'ACTIVE', 'EA', 46414, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (937, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '립 메이크업 - 립스틱 세트 5개입', '립스틱 세트 5개입', 'P019037', 'ACTIVE', 'EA', 73256, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (938, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 수분 크림 50ml', '수분 크림 50ml', 'P019038', 'ACTIVE', 'EA', 41612, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (939, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '클렌징 - 립 글로우 오일 7ml', '립 글로우 오일 7ml', 'P019039', 'ACTIVE', 'EA', 91538, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (940, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '마스크팩 - 수면팩 미니 30ml', '수면팩 미니 30ml', 'P019040', 'ACTIVE', 'EA', 70676, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (941, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P019041', 'ACTIVE', 'EA', 47279, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (942, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 면봉 200개입', '면봉 200개입', 'P019042', 'ACTIVE', 'EA', 91751, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (943, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 - 아하BHA 토너 150ml', '아하BHA 토너 150ml', 'P019043', 'ACTIVE', 'EA', 24855, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (944, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 - 비타민C 토너 200ml', '비타민C 토너 200ml', 'P019044', 'ACTIVE', 'EA', 45397, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (945, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 젤 아이라이너 2.5g', '젤 아이라이너 2.5g', 'P019045', 'ACTIVE', 'EA', 10780, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (946, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P019046', 'ACTIVE', 'EA', 14399, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (947, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '스킨케어 보습 - 비비크림 50ml', '비비크림 50ml', 'P019047', 'ACTIVE', 'EA', 61050, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (948, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '립 메이크업 - 글로시 틴트 4ml', '글로시 틴트 4ml', 'P019048', 'ACTIVE', 'EA', 57840, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (949, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '마스크팩 - 헤어팩 200ml', '헤어팩 200ml', 'P019049', 'ACTIVE', 'EA', 61233, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (950, '2024-07-20 09:00:00', '2024-07-20 09:00:00', '아이 메이크업 - 아이브로우 펜슬 0.3g', '아이브로우 펜슬 0.3g', 'P019050', 'ACTIVE', 'EA', 60101, 19);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (951, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 보습 - 비비크림 50ml', '비비크림 50ml', 'P020001', 'ACTIVE', 'EA', 96941, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (952, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '클렌징 - 딥클렌징 오일 200ml', '딥클렌징 오일 200ml', 'P020002', 'ACTIVE', 'EA', 94323, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (953, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 - 바디미스트 200ml', '바디미스트 200ml', 'P020003', 'ACTIVE', 'EA', 76284, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (954, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 보습 - 크림 아이섀도우 5g', '크림 아이섀도우 5g', 'P020004', 'ACTIVE', 'EA', 27740, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (955, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 뷰러 1개', '뷰러 1개', 'P020005', 'ACTIVE', 'EA', 56977, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (956, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '립 메이크업 - 물들임 립틴트 5ml', '물들임 립틴트 5ml', 'P020006', 'ACTIVE', 'EA', 30261, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (957, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 - 쌀 토너 150ml', '쌀 토너 150ml', 'P020007', 'ACTIVE', 'EA', 90932, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (958, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 베이스코트 10ml', '베이스코트 10ml', 'P020008', 'ACTIVE', 'EA', 32768, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (959, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 5종 미니어처 세트', '5종 미니어처 세트', 'P020009', 'ACTIVE', 'EA', 47293, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (960, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 집중관리 - 스네일 에센스 50ml', '스네일 에센스 50ml', 'P020010', 'ACTIVE', 'EA', 61205, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (961, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '아이 메이크업 - 브로우 마스카라 5ml', '브로우 마스카라 5ml', 'P020011', 'ACTIVE', 'EA', 42895, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (962, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '클렌징 - 약산성 클렌징폼 120ml', '약산성 클렌징폼 120ml', 'P020012', 'ACTIVE', 'EA', 58113, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (963, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 - 쌀 토너 150ml', '쌀 토너 150ml', 'P020013', 'ACTIVE', 'EA', 54328, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (964, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 미니 스킨케어 세트 5종', '미니 스킨케어 세트 5종', 'P020014', 'ACTIVE', 'EA', 69838, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (965, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 보습 - 수분 선젤 50ml', '수분 선젤 50ml', 'P020015', 'ACTIVE', 'EA', 13737, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (966, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '립 메이크업 - 립 앤 치크 4g', '립 앤 치크 4g', 'P020016', 'ACTIVE', 'EA', 4211, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (967, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 보습 - 수딩젤 크림 100ml', '수딩젤 크림 100ml', 'P020017', 'ACTIVE', 'EA', 94189, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (968, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 집중관리 - 펩타이드 세럼 30ml', '펩타이드 세럼 30ml', 'P020018', 'ACTIVE', 'EA', 47228, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (969, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 - 아하BHA 토너 150ml', '아하BHA 토너 150ml', 'P020019', 'ACTIVE', 'EA', 96716, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (970, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '립 메이크업 - 립 컬렉션 세트', '립 컬렉션 세트', 'P020020', 'ACTIVE', 'EA', 90472, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (971, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '립 메이크업 - 립라이너 0.3g', '립라이너 0.3g', 'P020021', 'ACTIVE', 'EA', 58376, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (972, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 보습 - 미백 크림 50g', '미백 크림 50g', 'P020022', 'ACTIVE', 'EA', 3947, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (973, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 - 헤어미스트 150ml', '헤어미스트 150ml', 'P020023', 'ACTIVE', 'EA', 88331, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (974, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 - 티트리 토너 200ml', '티트리 토너 200ml', 'P020024', 'ACTIVE', 'EA', 32824, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (975, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 트래블 키트 7종', '트래블 키트 7종', 'P020025', 'ACTIVE', 'EA', 88304, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (976, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '아이 메이크업 - 마스카라 블랙 10ml', '마스카라 블랙 10ml', 'P020026', 'ACTIVE', 'EA', 5941, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (977, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '클렌징 - 헤어오일 70ml', '헤어오일 70ml', 'P020027', 'ACTIVE', 'EA', 19764, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (978, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 멀티 스틱 9g', '멀티 스틱 9g', 'P020028', 'ACTIVE', 'EA', 49920, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (979, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '클렌징 - 약산성 클렌징폼 120ml', '약산성 클렌징폼 120ml', 'P020029', 'ACTIVE', 'EA', 77682, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (980, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 각질제거 패드 60매', '각질제거 패드 60매', 'P020030', 'ACTIVE', 'EA', 83261, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (981, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 브러쉬 세트 7종', '브러쉬 세트 7종', 'P020031', 'ACTIVE', 'EA', 1025, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (982, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 스킨케어 체험 세트', '스킨케어 체험 세트', 'P020032', 'ACTIVE', 'EA', 26586, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (983, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 네일폴리쉬 10ml', '네일폴리쉬 10ml', 'P020033', 'ACTIVE', 'EA', 4394, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (984, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 보습 - 시카 크림 50ml', '시카 크림 50ml', 'P020034', 'ACTIVE', 'EA', 39117, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (985, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 멀티 스틱 9g', '멀티 스틱 9g', 'P020035', 'ACTIVE', 'EA', 89894, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (986, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 보습 - 아이크림 30ml', '아이크림 30ml', 'P020036', 'ACTIVE', 'EA', 52946, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (987, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 - 병풀 진정 토너 250ml', '병풀 진정 토너 250ml', 'P020037', 'ACTIVE', 'EA', 66697, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (988, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 스킨케어 기획세트', '스킨케어 기획세트', 'P020038', 'ACTIVE', 'EA', 85760, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (989, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '립 메이크업 - 립밤 10g', '립밤 10g', 'P020039', 'ACTIVE', 'EA', 24622, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (990, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 집중관리 - 스네일 에센스 50ml', '스네일 에센스 50ml', 'P020040', 'ACTIVE', 'EA', 27316, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (991, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '립 메이크업 - 매트 립크레용 2.5g', '매트 립크레용 2.5g', 'P020041', 'ACTIVE', 'EA', 91438, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (992, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 - 그린티 프레시 토너 200ml', '그린티 프레시 토너 200ml', 'P020042', 'ACTIVE', 'EA', 44438, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (993, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 퍼퓸 롤온 10ml', '퍼퓸 롤온 10ml', 'P020043', 'ACTIVE', 'EA', 42628, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (994, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '립 메이크업 - 매트 립크레용 2.5g', '매트 립크레용 2.5g', 'P020044', 'ACTIVE', 'EA', 45736, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (995, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 글로우 스틱 8g', '글로우 스틱 8g', 'P020045', 'ACTIVE', 'EA', 56348, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (996, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 집중관리 - 프로폴리스 앰플마스크 10매', '프로폴리스 앰플마스크 10매', 'P020046', 'ACTIVE', 'EA', 33091, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (997, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 집중관리 - 나이아신아마이드 세럼 30ml', '나이아신아마이드 세럼 30ml', 'P020047', 'ACTIVE', 'EA', 26342, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (998, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '스킨케어 보습 - 풋크림 100ml', '풋크림 100ml', 'P020048', 'ACTIVE', 'EA', 62198, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (999, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '화장품 - 스킨케어 기획세트', '스킨케어 기획세트', 'P020049', 'ACTIVE', 'EA', 1309, 20);
INSERT INTO product (product_id, created_at, updated_at, description, name, product_code, status, unit, unit_price, vendor_id) VALUES (1000, '2024-07-21 09:00:00', '2024-07-21 09:00:00', '클렌징 - 클렌징 타올 30매', '클렌징 타올 30매', 'P020050', 'ACTIVE', 'EA', 31562, 20);

-- member (20)
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (1, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'admin@warehouse.com', '2024-06-04 09:00:00', 'admin', '$2b$12$60UWK1FT21XZmTOR87MSGuKB63.cJX7Q2Nbpnz3ht4IoSlxN7HXPO', '010-2000-0001', 'ADMIN', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (2, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'seoyun@warehouse.com', '2024-06-07 09:00:00', '이서윤', '$2b$12$GkUbjleeegcTYZMft.fYBOSiJYa31S/IsacPOgL6...veWaTUVc3.', '010-2000-0002', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (3, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'jiho@warehouse.com', '2024-06-10 09:00:00', '박지호', '$2b$12$sWxPva5yADG0kd/plvKPSOGYK6X3v/.ppJeIWG0S5ETtwqIj4wRM.', '010-2000-0003', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (4, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'sujin@warehouse.com', '2024-06-13 09:00:00', '최수진', '$2b$12$MDEAQvx5FfpPJK2zKJBT3uDD5fuxpzsn/EWIfocpe3RujQ8UhLcUe', '010-2000-0004', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (5, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'yejun@warehouse.com', '2024-06-16 09:00:00', '정예준', '$2b$12$DcIiif71XvSHkePrhxsCBeS51MYbLcKFSovGU29nS2Czyeuzx9Uai', '010-2000-0005', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (6, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'haeun@warehouse.com', '2024-06-19 09:00:00', '강하은', '$2b$12$bGNeDw0shTict1Yi.lw33.PTmhaOi56innF0kxSEolw9WwTrEDfEy', '010-2000-0006', 'MANAGER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (7, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'minjae@warehouse.com', '2024-06-22 09:00:00', '조민재', '$2b$12$ZbMLtyq5LCaujhARGPT2eO0eonmfG5W7A1.4i0pf9giFDIKjBdWxG', '010-2000-0007', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (8, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'seoyeon@warehouse.com', '2024-06-25 09:00:00', '윤서연', '$2b$12$XdxSaak58LOLDMVWxGT60eka7ZSSk9vzA4TIeh4XbCXZ1HjRtLga6', '010-2000-0008', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (9, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'junseo@warehouse.com', '2024-06-28 09:00:00', '장준서', '$2b$12$iuJpBhkV5Fe9jOw4SHbRY.ceUpkxX5Rw39kPAayduJnA5OQHE8YP.', '010-2000-0009', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (10, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'jiwoo@warehouse.com', '2024-07-01 09:00:00', '임지우', '$2b$12$15s57Uzf161woUUdg5nP6exFoBe7q9FNSkyO7XgT1FMhPjXAZegS6', '010-2000-0010', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (11, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'seohyun@warehouse.com', '2024-07-04 09:00:00', '한서현', '$2b$12$.DvoNdWHAZTJqQA11frq2.G0E5iDhtwKSe8.xXNYvqd3pFbAswrW2', '010-2000-0011', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (12, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'yeeun@warehouse.com', '2024-07-07 09:00:00', '오예은', '$2b$12$PuNtP0e70NS21CkHzLbCU.blURtU3iKX7ujPk4HZ/EqcWzUpvolxi', '010-2000-0012', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (13, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'doyun@warehouse.com', '2024-07-10 09:00:00', '신도윤', '$2b$12$xMv124NaCBp/mQY9SmjtJeuCihRl3WHUXPDVPbDLarNXxD78NF3RK', '010-2000-0013', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (14, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'siwoo@warehouse.com', '2024-07-13 09:00:00', '권시우', '$2b$12$YWASwyefugD1ILj/.hTE7uNF6wcfNv5Vk/iZ.yx6PBZ5m6UhiYl4C', '010-2000-0014', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (15, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'seoa@warehouse.com', '2024-07-16 09:00:00', '황서아', '$2b$12$GyZ2iMgB9S1i4d9TZ8RtoeY.CBgHPL2YMT8zcIKdrzhaAvM0z/B82', '010-2000-0015', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (16, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'jihoon@warehouse.com', '2024-07-19 09:00:00', '배지훈', '$2b$12$gfYqCz5AS3XlWLuIIMQ1reQ2BYI53zaNqyEa2kJM57xfbHamxvs9a', '010-2000-0016', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (17, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'hayoon@warehouse.com', '2024-07-22 09:00:00', '송하윤', '$2b$12$.rjkWRu0sfQRuVcF2g5MOOB2St2NEIJgC/p13025/JJCi9acvWqNm', '010-2000-0017', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (18, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'minseo@warehouse.com', '2024-07-25 09:00:00', '안민서', '$2b$12$Hi5Pw.ptQdthwW1BjUZyRejChyTg6IIvMCSce7MWlNysQijVZ9DuC', '010-2000-0018', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (19, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'yujin@warehouse.com', '2024-07-28 09:00:00', '홍유진', '$2b$12$Ecp3VvNadOqeVL2N4pF01u/77yCfwInrg4Sx4/CkFTsvFzsYRcJ8S', '010-2000-0019', 'WORKER', 'ACTIVE');
INSERT INTO member (id, created_at, updated_at, email, join_at, name, password, phone_number, role, status) VALUES (20, '2024-07-31 09:00:00', '2024-07-31 09:00:00', 'taemin@warehouse.com', '2024-07-31 09:00:00', '김태민', '$2b$12$co9h7ispwE5j2ZRljF/U6.swAUKyfenD74U715exbAxONsttHn19e', '010-2000-0020', 'WORKER', 'ACTIVE');

-- warehouse (5)
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (1, '2024-01-15 09:00:00', '2024-01-15 09:00:00', b'1',      '경기도 이천시', 'Korea', '이천테크노밸리 A동 3층', '부발읍 경충대로', '17405', 'icheon.wh@fourweekdays.com', '이천 중앙물류센터', '031-634-2000');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (2, '2024-02-01 09:00:00', '2024-02-01 09:00:00', b'1', '경기도 김포시', 'Korea', '한강신도시 물류단지 B동 2층', '대곶면 김포대로', '10048', 'gimpo.wh@fourweekdays.com', '김포 한강물류센터', '031-988-5500');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (3, '2024-02-20 09:00:00', '2024-02-20 09:00:00', b'1', '경기도 용인시', 'Korea', '처인구 백암일반산업단지 C동 1층', '백암면 용천로', '17172', 'yongin.wh@fourweekdays.com', '용인 백암물류센터', '031-322-7700');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (4, '2024-03-10 09:00:00', '2024-03-10 09:00:00', b'1', '경기도 평택시', 'Korea', '포승읍 만호리 물류단지 D동 전층', '평택항로', '17959', 'pyeongtaek.wh@fourweekdays.com', '평택 포승물류센터', '031-683-9900');
INSERT INTO warehouse (id, created_at, updated_at, active, city, country, detail, street, zipcode, email, name, phone_number) VALUES (5, '2024-03-25 09:00:00', '2024-03-25 09:00:00', b'1', '경기도 안성시', 'Korea', '공도읍 산업단지 E동 2-3층', '서동대로', '17565', 'anseong.wh@fourweekdays.com', '안성 공도물류센터', '031-676-4400');

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
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (1, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 강남구', 'Korea', '강남역 1번 출구', '강남대로', '06236', 'API_KEY_FS_20240825_BZFQY2', '강남점 - 강남역 1번 출구', '아모레퍼시픽@cosmetic.com', '아모레퍼시픽', '강남점', '010-4000-0001', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (2, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 마포구', 'Korea', '홍대입구역 9번 출구', '양화로', '04044', 'API_KEY_FS_20240825_OT5GIB', '홍대점 - 홍대입구역 9번 출구', 'lg생활건강@cosmetic.com', 'LG생활건강', '홍대점', '010-4000-0002', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (3, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 용산구', 'Korea', '이태원역 1번 출구', '이태원로', '04348', 'API_KEY_FS_20240825_JRCMCA', '이태원점 - 이태원역 1번 출구', '토니모리@cosmetic.com', '토니모리', '이태원점', '010-4000-0003', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (4, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 중구', 'Korea', '명동역 6번 출구', '명동8길', '04536', 'API_KEY_FS_20240825_5OV4IS', '명동점 - 명동역 6번 출구', '미샤@cosmetic.com', '미샤', '명동점', '010-4000-0004', 'INACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (5, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 종로구', 'Korea', '광화문역 5번 출구', '세종대로', '03171', 'API_KEY_FS_20240825_MPQMSO', '광화문점 - 광화문역 5번 출구', '더페이스샵@cosmetic.com', '더페이스샵', '광화문점', '010-4000-0005', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (6, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 송파구', 'Korea', '잠실역 2번 출구', '올림픽로', '05554', 'API_KEY_FS_20240825_TEZK7G', '잠실점 - 잠실역 2번 출구', '이니스프리@cosmetic.com', '이니스프리', '잠실점', '010-4000-0006', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (7, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 서대문구', 'Korea', '신촌역 3번 출구', '신촌역로', '03789', 'API_KEY_FS_20240825_COD1SB', '신촌점 - 신촌역 3번 출구', '에뛰드하우스@cosmetic.com', '에뛰드하우스', '신촌점', '010-4000-0007', 'INACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (8, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 종로구', 'Korea', '혜화역 2번 출구', '대학로', '03086', 'API_KEY_FS_20240825_RJWIR8', '대학로점 - 혜화역 2번 출구', '스킨푸드@cosmetic.com', '스킨푸드', '대학로점', '010-4000-0008', 'INACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (9, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 강남구', 'Korea', '청담역 13번 출구', '선릉로', '06061', 'API_KEY_FS_20240825_ISF3IT', '청담점 - 청담역 13번 출구', '네이처리퍼블릭@cosmetic.com', '네이처리퍼블릭', '청담점', '010-4000-0009', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (10, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 강남구', 'Korea', '압구정역 5번 출구', '압구정로', '06001', 'API_KEY_FS_20240825_9B0R7O', '압구정점 - 압구정역 5번 출구', '더샘@cosmetic.com', '더샘', '압구정점', '010-4000-0010', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (11, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 영등포구', 'Korea', '여의도역 3번 출구', '여의대로', '07335', 'API_KEY_FS_20240825_W6QZ7S', '여의도점 - 여의도역 3번 출구', '코스알엑스@cosmetic.com', '코스알엑스', '여의도점', '010-4000-0011', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (12, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 중구', 'Korea', '을지로3가역 11번 출구', '을지로', '04560', 'API_KEY_FS_20240825_6EUR8N', '을지로점 - 을지로3가역 11번 출구', '메디힐@cosmetic.com', '메디힐', '을지로점', '010-4000-0012', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (13, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 종로구', 'Korea', '종각역 4번 출구', '종로', '03188', 'API_KEY_FS_20240825_D8F040', '종로점 - 종각역 4번 출구', 'cnp차앤박@cosmetic.com', 'CNP차앤박', '종로점', '010-4000-0013', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (14, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 서초구', 'Korea', '교대역 10번 출구', '서초대로', '06621', 'API_KEY_FS_20240825_8URS19', '서초점 - 교대역 10번 출구', '닥터지@cosmetic.com', '닥터지', '서초점', '010-4000-0014', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (15, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 송파구', 'Korea', '석촌역 8번 출구', '송파대로', '05854', 'API_KEY_FS_20240825_BVAS9K', '송파점 - 석촌역 8번 출구', '클리오@cosmetic.com', '클리오', '송파점', '010-4000-0015', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (16, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 구로구', 'Korea', '구로디지털단지역 1번 출구', '디지털로', '08389', 'API_KEY_FS_20240825_UHX8BQ', '구로점 - 구로디지털단지역 1번 출구', '아리따움@cosmetic.com', '아리따움', '구로점', '010-4000-0016', 'SUSPENDED');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (17, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 노원구', 'Korea', '노원역 1번 출구', '동일로', '01780', 'API_KEY_FS_20240825_I78A4Z', '노원점 - 노원역 1번 출구', '페리페라@cosmetic.com', '페리페라', '노원점', '010-4000-0017', 'INACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (18, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 강서구', 'Korea', '발산역 4번 출구', '강서로', '07774', 'API_KEY_FS_20240825_LUJ3QL', '강서점 - 발산역 4번 출구', '투쿨포스쿨@cosmetic.com', '투쿨포스쿨', '강서점', '010-4000-0018', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (19, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 마포구', 'Korea', '마포역 1번 출구', '마포대로', '04213', 'API_KEY_FS_20240825_RU3LLY', '마포점 - 마포역 1번 출구', '바닐라코@cosmetic.com', '바닐라코', '마포점', '010-4000-0019', 'ACTIVE');
INSERT INTO franchise_store (id, created_at, updated_at, city, country, detail, street, zipcode, api_key, description, email, franchise_code, name, phone_number, status) VALUES (20, '2024-08-25 09:00:00', '2024-08-25 09:00:00', '서울특별시 용산구', 'Korea', '용산역 1번 출구', '한강대로', '04377', 'API_KEY_FS_20240825_7G8IQ6', '용산점 - 용산역 1번 출구', '헉슬리@cosmetic.com', '헉슬리', '용산점', '010-4000-0020', 'INACTIVE');

-- purchase_order (20)
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (1, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '네일 제품 트렌드 컬러 발주', '2024-09-20 09:00:00', 'PO-20240904-MSF89G', '2024-08-31 09:00:00', 'COMPLETED', 591509, 7);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (2, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '헤어케어 세트 기획전용', '2024-09-21 09:00:00', 'PO-20240904-ERS1MV', '2024-09-01 09:00:00', 'AWAITING_DELIVERY', 539398, 6);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (3, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '메이크업베이스 정기 보충', '2024-09-22 09:00:00', 'PO-20240904-FHCTUW', '2024-09-02 09:00:00', 'AWAITING_DELIVERY', 475871, 5);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (4, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '민감성 피부용 제품군', '2024-09-23 09:00:00', 'PO-20240904-7LMQ8L', '2024-09-03 09:00:00', 'APPROVED', 549394, 15);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (5, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '바디로션 대용량 시즌 발주', '2024-09-24 09:00:00', 'PO-20240904-KPYKG0', '2024-09-04 09:00:00', 'CANCELLED', 361793, 10);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (6, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '세럼/앰플 특가 행사용 발주', '2024-09-25 09:00:00', 'PO-20240904-UUAIDN', '2024-09-05 09:00:00', 'CANCELLED', 358828, 3);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (7, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '네일 제품 트렌드 컬러 발주', '2024-09-26 09:00:00', 'PO-20240904-694NU6', '2024-09-06 09:00:00', 'CANCELLED', 668510, 6);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (8, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '아이섀도우 팔레트 신상품 발주', '2024-09-27 09:00:00', 'PO-20240904-MOZMRN', '2024-09-07 09:00:00', 'COMPLETED', 110239, 17);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (9, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '메이크업베이스 정기 보충', '2024-09-28 09:00:00', 'PO-20240904-3SDAXE', '2024-09-08 09:00:00', 'COMPLETED', 388342, 11);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (10, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '베스트셀러 재고 긴급 보충', '2024-09-29 09:00:00', 'PO-20240904-YITMXE', '2024-09-09 09:00:00', 'CANCELLED', 428242, 1);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (11, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '맨즈케어 라인 신규 입고', '2024-09-30 09:00:00', 'PO-20240904-OXJ998', '2024-09-10 09:00:00', 'CANCELLED', 607143, 9);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (12, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '미백 기능성 화장품 발주', '2024-10-01 09:00:00', 'PO-20240904-77U4OC', '2024-09-11 09:00:00', 'REQUESTED', 453765, 9);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (13, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '베스트셀러 재고 긴급 보충', '2024-10-02 09:00:00', 'PO-20240904-77JNIZ', '2024-09-12 09:00:00', 'APPROVED', 107695, 18);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (14, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '마스크팩 기획전 물량 확보', '2024-10-03 09:00:00', 'PO-20240904-G3BO2R', '2024-09-13 09:00:00', 'REQUESTED', 240943, 12);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (15, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '립틴트 신제품 시즌 발주', '2024-10-04 09:00:00', 'PO-20240904-EBYCKV', '2024-09-14 09:00:00', 'APPROVED', 790506, 6);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (16, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '쿠션 팩트 긴급 재고 보충', '2024-10-05 09:00:00', 'PO-20240904-LB20WD', '2024-09-15 09:00:00', 'AWAITING_DELIVERY', 632957, 13);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (17, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '아이크림 안티에이징 라인', '2024-10-06 09:00:00', 'PO-20240904-R8SJ7M', '2024-09-16 09:00:00', 'REQUESTED', 721929, 15);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (18, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '맨즈케어 라인 신규 입고', '2024-10-07 09:00:00', 'PO-20240904-SF5YTR', '2024-09-17 09:00:00', 'REQUESTED', 498984, 12);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (19, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '립틴트 신제품 시즌 발주', '2024-10-08 09:00:00', 'PO-20240904-MQSAZ1', '2024-09-18 09:00:00', 'REQUESTED', 694619, 19);
INSERT INTO purchase_order (id, created_at, updated_at, description, expected_date, order_code, order_date, status, total_amount, vendor_id) VALUES (20, '2024-09-04 09:00:00', '2024-09-04 09:00:00', '가을 시즌 스킨케어 정기 발주', '2024-10-09 09:00:00', 'PO-20240904-BEZMFZ', '2024-09-19 09:00:00', 'CANCELLED', 213753, 3);

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
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-9MVTUV', '입고 사전 통지 - 정상 입고 예정', '2024-09-30 09:00:00', 'ACCEPTED', 1, 7);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-655Y11', '입고 사전 통지 - 창고 입고 준비', '2024-10-01 09:00:00', 'ACCEPTED', 2, 6);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-0Y1CGX', '입고 사전 통지 - 품질 검수 대기', '2024-10-02 09:00:00', 'REJECTED', 3, 5);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-PIXH1L', '입고 사전 통지 - 물량 확인 완료', '2024-10-03 09:00:00', 'ACCEPTED', 4, 15);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-6L8L2E', '입고 사전 통지 - 품질 검수 대기', '2024-10-04 09:00:00', 'REJECTED', 5, 10);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-SM5ZUE', '입고 사전 통지 - 정상 입고 예정', '2024-10-05 09:00:00', 'ACCEPTED', 6, 3);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-SIDZT9', '입고 사전 통지 - 물량 확인 완료', '2024-10-06 09:00:00', 'ACCEPTED', 7, 6);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-4B7T9L', '입고 사전 통지 - 품질 검수 대기', '2024-10-07 09:00:00', 'REJECTED', 8, 17);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-QZJOMM', '입고 사전 통지 - 정상 입고 예정', '2024-10-08 09:00:00', 'ACCEPTED', 9, 11);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-TS5IIK', '입고 사전 통지 - 검수 후 입고', '2024-10-09 09:00:00', 'ACCEPTED', 10, 1);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-ALMDSD', '입고 사전 통지 - 검수 후 입고', '2024-10-10 09:00:00', 'REJECTED', 11, 9);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-27VHFC', '입고 사전 통지 - 검수 후 입고', '2024-10-11 09:00:00', 'ACCEPTED', 12, 9);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-G415NU', '입고 사전 통지 - 정상 입고 예정', '2024-10-12 09:00:00', 'REJECTED', 13, 18);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-ZXXB9U', '입고 사전 통지 - 물량 확인 완료', '2024-10-13 09:00:00', 'ACCEPTED', 14, 12);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (15, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-KL17BH', '입고 사전 통지 - 검수 후 입고', '2024-10-14 09:00:00', 'ACCEPTED', 15, 6);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (16, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-BXVWGP', '입고 사전 통지 - 정상 입고 예정', '2024-10-15 09:00:00', 'ACCEPTED', 16, 13);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (17, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-5LHH2I', '입고 사전 통지 - 품질 검수 대기', '2024-10-16 09:00:00', 'REJECTED', 17, 15);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (18, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-ZW3CK8', '입고 사전 통지 - 물량 확인 완료', '2024-10-17 09:00:00', 'ACCEPTED', 18, 12);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (19, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-RDEGXL', '입고 사전 통지 - 정상 입고 예정', '2024-10-18 09:00:00', 'ACCEPTED', 19, 19);
INSERT INTO asn (id, created_at, updated_at, asn_code, description, expected_date, status, purchase_order_id, vendor_id) VALUES (20, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'ASN-20240601-DJ2ZRJ', '입고 사전 통지 - 검수 후 입고', '2024-10-19 09:00:00', 'ACCEPTED', 20, 3);

-- inbound
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'LG생활건강 신제품 입고', 'IB-20240601-DE5WA2', '권시우', '2024-10-05 09:00:00', 'CREATED', '배수아', 1);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '스킨푸드 천연 화장품', 'IB-20240601-8O6LMO', '장준서', '2024-10-06 09:00:00', 'CREATED', '윤재원', 2);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', 'CNP 안티에이징 라인', 'IB-20240601-SNICKU', '권시우', '2024-10-08 09:00:00', 'PUTAWAY', '장예린', 4);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '코스알엑스 각질 케어', 'IB-20240601-5ZSOFY', '배지훈', '2024-10-10 09:00:00', 'PUTAWAY', '정시현', 6);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '에뛰드하우스 색조 입고', 'IB-20240601-2M14MA', '이서윤', '2024-10-11 09:00:00', 'COMPLETED', '신주원', 7);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '스킨푸드 천연 화장품', 'IB-20240601-4SCVWW', '정예준', '2024-10-13 09:00:00', 'SCHEDULED', '이하준', 9);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '토니모리 시즌 신상 입고', 'IB-20240601-XTB6X5', '한서현', '2024-10-14 09:00:00', 'ARRIVED', '김서율', 10);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '에뛰드하우스 색조 입고', 'IB-20240601-SYR0DL', '조민재', '2024-10-16 09:00:00', 'PUTAWAY', '정시현', 12);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '미샤 베스트셀러 보충', 'IB-20240601-1MSM1E', '김태민', '2024-10-18 09:00:00', 'PUTAWAY', '강민석', 14);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '네이처리퍼블릭 알로에 라인', 'IB-20240601-KCCO7F', '송하윤', '2024-10-19 09:00:00', 'COMPLETED', '조서진', 15);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '네이처리퍼블릭 알로에 라인', 'IB-20240601-W0ZBA0', '조민재', '2024-10-20 09:00:00', 'ARRIVED', '신주원', 16);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '코스알엑스 각질 케어', 'IB-20240601-I2X8O2', '윤서연', '2024-10-22 09:00:00', 'CREATED', '송윤서', 18);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '더샘 커버력 화장품', 'IB-20240601-FJNNTK', '강하은', '2024-10-23 09:00:00', 'CREATED', '안지환', 19);
INSERT INTO inbound (id, created_at, updated_at, description, inbound_code, manager_name, scheduled_date, status, worker_name, purchase_order_id) VALUES (14, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '에뛰드하우스 색조 입고', 'IB-20240601-ERR3UQ', '임지우', '2024-10-24 09:00:00', 'CREATED', '배수아', 20);

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
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (1, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '압구정점 럭셔리 라인 주문', '2024-09-10 09:00:00', 'ORD-20240830-H05CK0', '2024-08-21 09:00:00', 'REQUESTED', 1);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (2, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '송파점 가족 단위 바디케어', '2024-09-11 09:00:00', 'ORD-20240830-ICI9FD', '2024-08-22 09:00:00', 'CANCELLED', 2);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (3, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '압구정점 럭셔리 라인 주문', '2024-09-12 09:00:00', 'ORD-20240830-YF3JRS', '2024-08-23 09:00:00', 'CANCELLED', 3);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (4, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '홍대점 긴급 보충 - 립틴트/쿠션', '2024-09-13 09:00:00', 'ORD-20240830-67HKDF', '2024-08-24 09:00:00', 'SHIPPED', 4);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (5, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '강남점 정기 주문 - 스킨케어 중심', '2024-09-14 09:00:00', 'ORD-20240830-4ITTKC', '2024-08-25 09:00:00', 'APPROVED', 5);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (6, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '노원점 지역 맞춤 선케어', '2024-09-15 09:00:00', 'ORD-20240830-AJ5IK7', '2024-08-26 09:00:00', 'APPROVED', 6);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (7, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '이태원점 외국인 관광객용', '2024-09-16 09:00:00', 'ORD-20240830-6C1PP3', '2024-08-27 09:00:00', 'CANCELLED', 7);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (8, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '노원점 지역 맞춤 선케어', '2024-09-17 09:00:00', 'ORD-20240830-AT582S', '2024-08-28 09:00:00', 'SHIPPED', 8);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (9, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '청담점 프리미엄 제품 특별 주문', '2024-09-18 09:00:00', 'ORD-20240830-K8ADK8', '2024-08-29 09:00:00', 'DELIVERED', 9);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (10, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '홍대점 긴급 보충 - 립틴트/쿠션', '2024-09-19 09:00:00', 'ORD-20240830-O5CKJA', '2024-08-30 09:00:00', 'APPROVED', 10);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (11, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '강서점 베스트셀러 위주', '2024-09-20 09:00:00', 'ORD-20240830-22WLX0', '2024-08-31 09:00:00', 'CANCELLED', 11);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (12, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '용산점 올인원 제품 중심', '2024-09-21 09:00:00', 'ORD-20240830-KQA6BG', '2024-09-01 09:00:00', 'SHIPPED', 12);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (13, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '여의도점 직장인 기초 화장품', '2024-09-22 09:00:00', 'ORD-20240830-6BGP96', '2024-09-02 09:00:00', 'SHIPPED', 13);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (14, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '송파점 가족 단위 바디케어', '2024-09-23 09:00:00', 'ORD-20240830-HYIO5H', '2024-09-03 09:00:00', 'CANCELLED', 14);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (15, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '신촌점 학생 타겟 메이크업 주문', '2024-09-24 09:00:00', 'ORD-20240830-J6HDSL', '2024-09-04 09:00:00', 'APPROVED', 15);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (16, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '노원점 지역 맞춤 선케어', '2024-09-25 09:00:00', 'ORD-20240830-MIY8GG', '2024-09-05 09:00:00', 'SHIPPED', 16);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (17, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '구로점 맨즈케어 특화 주문', '2024-09-26 09:00:00', 'ORD-20240830-CTCF26', '2024-09-06 09:00:00', 'SHIPPED', 17);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (18, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '송파점 가족 단위 바디케어', '2024-09-27 09:00:00', 'ORD-20240830-S6IYZV', '2024-09-07 09:00:00', 'REQUESTED', 18);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (19, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '송파점 가족 단위 바디케어', '2024-09-28 09:00:00', 'ORD-20240830-MFG2ZT', '2024-09-08 09:00:00', 'DELIVERED', 19);
INSERT INTO orders (order_id, created_at, updated_at, description, due_date, order_code, order_date, status, franchise_store_id) VALUES (20, '2024-08-30 09:00:00', '2024-08-30 09:00:00', '명동점 관광 시즌 대비 대량 주문', '2024-09-29 09:00:00', 'ORD-20240830-1B3XYH', '2024-09-09 09:00:00', 'REQUESTED', 20);

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
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (1, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '잠실점 주말 대비 출고', 'OB-20240601-7KM9TZ', 'SALE', '2024-10-20 09:00:00', 'APPROVED', 1, 1);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (2, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '홍대점 긴급 출고 - 당일 배송', 'OB-20240601-34SGTH', 'SALE', '2024-10-22 09:00:00', 'PACKING', 3, 3);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (3, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '노원점 지역 맞춤 출고', 'OB-20240601-SE9O0W', 'SALE', '2024-10-23 09:00:00', 'PICKING', 4, 4);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (4, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '강남점 정기 배송 - 오전 출고', 'OB-20240601-ONA4CH', 'SALE', '2024-10-26 09:00:00', 'APPROVED', 7, 7);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (5, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '홍대점 긴급 출고 - 당일 배송', 'OB-20240601-SI05R9', 'SALE', '2024-10-27 09:00:00', 'PICKING', 8, 8);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (6, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '신촌점 신학기 특수 출고', 'OB-20240601-HX9CZW', 'SALE', '2024-10-31 09:00:00', 'APPROVED', 12, 12);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (7, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '여의도점 정기 배송', 'OB-20240601-2X4KUA', 'SALE', '2024-11-01 09:00:00', 'PICKING', 13, 13);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (8, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '잠실점 주말 대비 출고', 'OB-20240601-A0MZEW', 'SALE', '2024-11-02 09:00:00', 'PICKING', 14, 14);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (9, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '대학로점 젊은층 타겟 출고', 'OB-20240601-97XBQY', 'SALE', '2024-11-03 09:00:00', 'SHIPPED', 15, 15);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (10, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '강남점 정기 배송 - 오전 출고', 'OB-20240601-S1N20X', 'SALE', '2024-11-04 09:00:00', 'SHIPPED', 16, 16);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (11, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '잠실점 주말 대비 출고', 'OB-20240601-LTTEHY', 'SALE', '2024-11-06 09:00:00', 'SHIPPED', 18, 18);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (12, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '여의도점 정기 배송', 'OB-20240601-I9CFJB', 'SALE', '2024-11-07 09:00:00', 'PACKING', 19, 19);
INSERT INTO outbound (outbound_id, created_at, updated_at, description, outbound_code, outbound_type, scheduled_date, status, order_id, member_id) VALUES (13, '2024-06-01 09:00:00', '2024-06-01 09:00:00', '여의도점 정기 배송', 'OB-20240601-EK8NTD', 'SALE', '2024-11-08 09:00:00', 'APPROVED', 20, 20);

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
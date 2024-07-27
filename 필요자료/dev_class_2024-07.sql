# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 192.168.219.100 (MySQL 5.5.5-10.5.8-MariaDB-1:10.5.8+maria~focal)
# Database: dev_class
# Generation Time: 2021-02-04 00:39:04 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# mysql ERROR 1366 (HY000) at line 17: Incorrect string value: '\xEC\x9B\x90' 에러발생시
# ALTER TABLE (테이블명) convert to charset utf8;
# DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;



# ------------------------------------------------------------
# Dump of table t_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `type` int(1) NOT NULL DEFAULT 1 COMMENT '1-buyer, 2-seller',
  `nickname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `t_user` WRITE;

INSERT INTO `t_user` (`email`, `type`, `nickname`) 
 VALUES ('seungwon.go@gmail.com',1,'고승원');
UNLOCK TABLES;
select * from  t_user ;


# ------------------------------------------------------------
# Dump of table t_category
# ------------------------------------------------------------
DROP TABLE IF EXISTS `t_category`;

CREATE TABLE `t_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category1` varchar(50) NOT NULL DEFAULT '',
  `category2` varchar(50) NOT NULL DEFAULT '',
  `category3` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `t_category` WRITE;

INSERT INTO `t_category` (`id`, `category1`, `category2`, `category3`)
VALUES
	(1,'전자제품','컴퓨터','악세사리'),
	(2,'전자제품','컴퓨터','노트북'),
	(3,'전자제품','컴퓨터','조립식'),
	(4,'전자제품','가전제품','텔레비전'),
	(5,'전자제품','가전제품','냉장고'),
	(6,'생필품','주방용품','조리도구'),
	(7,'생필품','주방용품','식기');
UNLOCK TABLES;
select * from  t_category;


# ------------------------------------------------------------
# Dump of table t_seller
# ------------------------------------------------------------
DROP TABLE IF EXISTS `t_seller`;
CREATE TABLE `t_seller` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `t_seller` WRITE;

INSERT INTO `t_seller` (`id`, `name`, `email`, `phone`) 
 VALUES (1,'개발자의품격','seungwon.go@gmail.com','010-1111-1111');
UNLOCK TABLES;
select * from  t_seller;


# ------------------------------------------------------------
# Dump of table t_product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `t_product`;

CREATE TABLE `t_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(50) NOT NULL DEFAULT '',
  `product_price` int(11) NOT NULL DEFAULT 0,
  `delivery_price` int(11) NOT NULL DEFAULT 0,
  `add_delivery_price` int(11) NOT NULL DEFAULT 0,
  `tags` varchar(50) DEFAULT NULL,
  `outbound_days` int(2) NOT NULL DEFAULT 5,
  `seller_id` int(11) unsigned NOT NULL,
  `category_id` int(11) unsigned NOT NULL,
  `active_yn` enum('Y','N') NOT NULL DEFAULT 'Y',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `seller_id` (`seller_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`seller_id`) REFERENCES `t_seller` (`id`),
  CONSTRAINT `t_product_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `t_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `t_product` WRITE;

INSERT INTO `t_product` (`id`, `product_name`, `product_price`, `delivery_price`, `add_delivery_price`, `tags`, `outbound_days`, `seller_id`, `category_id`, `active_yn`, `created_date`) 
 VALUES
	(1,'K70 RGB MK.2 BROWN 기계식 게이밍 키보드 갈축',219000,2500,5000,'키보드,기계식,게이밍',5,1,1,'Y','2024-07-05 00:00:00'),
	(2,'로지텍 MX VERTICAL 인체공학 무선 마우스',11900,2500,5000,'마우스',5,1,1,'Y','2024-07-05 00:00:00'),
	(3,'테스트 제품 AAA', 79000,5000, 7800,'특모니터',  5,1,1,'Y', '2024-07-27 00:41:14'),
	(4,'테스트 제품 BBB', 34000,5000, 3200,'신선식품',  5,1,6,'Y', '2024-07-27 01:19:28');

	
UNLOCK TABLES;
select * from  t_product;

# ------------------------------------------------------------
# Dump of table t_image
# ------------------------------------------------------------

DROP TABLE IF EXISTS `t_image`;

CREATE TABLE `t_image` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned NOT NULL,
  `type` int NOT NULL DEFAULT '1' COMMENT '1-썸네일, 2-제품이미지, 3-제품설명이미지',
  `path` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),  
  CONSTRAINT `t_image_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `t_product` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;
LOCK TABLES `t_image` WRITE;

 INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(1,1,1,'keyboard1.jpg');
 INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(2,1,2,'keyboard2.jpg');
 INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(3,1,2,'keyboard3.jpg');
 INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(4,1,3,'detail.jpg');
 
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(5,2,1,'mouse2.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(6,2,2,'mouse3.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(7,2,2,'mouse1.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(8,2,3,'ipad_detail.jpg');


  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(10,3,1,'mousepad1.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(11,3,2,'mousepad3.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(12,3,2,'mousepad2.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(13,3,2,'keyboard1.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(14,3,3,'homecam_detail.jpg');

  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(15,4,1,'top.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(16,4,2,'melon.png');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(17,4,2,'bg02.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(18,4,2,'prod1.jpg');
  INSERT INTO `t_image` (`id`, `product_id`, `type`, `path`) VALUES(19,4,3,'bg03.jpg');
 
 commit ;
 select * from t_image;










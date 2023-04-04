-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: fashionstore
-- ------------------------------------------------------
-- Server version	8.0.31-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

create database fashionstore;
go
use fashionstore;
go

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `count` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3d704slv66tw6x5hmbm6p2x3u` (`product_id`),
  KEY `FKl70asp4l4w0jmbm1tqyofho4o` (`user_id`),
  CONSTRAINT `FK3d704slv66tw6x5hmbm6p2x3u` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FKl70asp4l4w0jmbm1tqyofho4o` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,2,1,'trieu');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Đồ ăn'),(2,'Phụ kiện'),(3,'Vật dụng'),(4,'chuồng'),(5,'chăm sóc');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `address` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `country` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `fullname` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `note` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `payment_method` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `total` int DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcpl0mjoeqhxvgeeeq5piwpd3i` (`user_id`),
  CONSTRAINT `FKcpl0mjoeqhxvgeeeq5piwpd3i` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `count` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKs234mi6jususbx4b37k44cipy` (`order_id`),
  KEY `FK551losx9j75ss5d6bfsqvijna` (`product_id`),
  CONSTRAINT `FK551losx9j75ss5d6bfsqvijna` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FKs234mi6jususbx4b37k44cipy` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` date DEFAULT NULL,
  `description` varchar(11111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `is_selling` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `product_name` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `sold` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1mtsbur82frn64de7balymq9s` (`category_id`),
  CONSTRAINT `FK1mtsbur82frn64de7balymq9s` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'2023-03-21','Balo địu thú cưng SONICE Pet Carrier - Hỗ trợ mang thú cưng đi dạo Petmall.',1,1,500000,'Balo địu thú cưng SONICE Pet Carrier - Hỗ trợ mang thú cưng đi dạo Petmall',100,20,3),(2,'2023-03-21','Lồng Cho Cho Di Động Cao Cấp Bằng Sắt Mã D222A',1,1,4300000,'Lồng Cho Cho Di Động Cao Cấp Bằng Sắt Mã D222A',100,20,4),(3,'2023-03-21','Thông tin sản phẩm thức ăn Cho Mèo trưởng thành trên 12 tháng tuổi\n\nCó 3 vị Cá Ngừ và vị Hải Sản và Vị Cá Thu\n\nBảo đảm an toàn, không bị hư hỏng khi để bên ngoài và thời gian bảo quản sử dụng lâu (18 tháng), giúp giữ vệ sinh, giảm sự tích tụ cao răng làm hư răng và đặc biệt nhất là giúp chất thải (phân) của thú cưng giảm hẳn những mùi hôi khó chịu.',1,1,430000,'Thức Ăn Cho Mèo Me-O Bao Xá 7kg',100,20,1),(4,'2023-03-21','MÁY LỌC NƯỚC CHO MÈO PAKEWAY 2.5L\nMáy lọc nước với 4 lớp lọc giúp tạo ra nguồn nước chất lượng cho mèo\nDung tích lớn 2.5L trữ được đủ lượng nước cung cấp cho mèo trưởng thành đến 10 ngày\nThiết kế dễ tháo rời, dễ vệ sinh và thay nước\nTiếng ồn thấp\nKích thước 20x20x15cm',1,1,270000,'Máy Lọc Nước Cho Chó Mèo PAKEWAY 2.5L',100,20,3),(5,'2023-03-21','BÁT ĂN CHO MÈO - TÔ NHỰA ĐÔI MÈO CHO CHÓ MÈO\nĐược làm từ chất liệu nhựa an toàn tuyệt đối cho chó mèo, giúp cho bé cưng nhà bạn có những bữa ăn ngon miệng, sạch sẽ\n\nThích hợp cho chó mèo giống nhỏ dưới 5kg',1,1,50000,'Tô Ăn Cho Chó Mèo - Tô Nhựa Đôi Mèo',99,20,3),(6,'2023-03-21','Chất Liệu: silicone siêu mềm\n\nCó nhiều lỗ thoáng khí, không làm cho chó bị ngộp\n\nĐược thiết kế khóa điều chỉnh size cho phù hợp mõm của thú cưng.\n\nRọ mõm giúp ngăn chặn thú cưng sủa, cắn, liếm vết thương, thói quen ăn bậy của thú cưng',1,1,160000,'Rọ Mõm Silicon Cho Chó',100,20,5),(7,'2023-03-21','Giày được làm bằng cao su dẻo thích hợp cho các bé trong mùa mưa này.Giày được thiết kế gọn nhẹ,tạo cảm giác thoải mái khi mang,hợp thời trang',1,1,100000,'Giày Nhựa Đi Mưa Cho Chó Mèo',100,20,2),(8,'2023-03-21','Vòng cổ có chất liệu là vải dù chắc chắc, bền đẹp nhưng vẫn mang đến cảm giác thoải mái cho thú cưng khi đeo\n\nĐiểm nhấn của vòng cổ là chiếc nơ xinh xắn cùng màu và chiếc lục lạc phát ra tiếng kêu khi thú cưng di chuyển\n\nChắc chắn chiếc vòng cổ là món phụ kiện tuyệt vời có thể phối hợp với nhiều loại trang phục khác nhau',1,1,32000,'Vòng Cổ Cho Chó Mèo Nơ Caro',64,11,3),(9,'2023-03-21','Sữa tắm trị viêm da, ghẻ cho chó Bio Derma có công dụng phòng & trị bệnh ghẻ do demodex, sarcoptes, bọ chét trên chó kết hợp với nấm da gây triệu chứng: hôi lông, rụng lông, khô da hoặc chảy dịch vàng, chảy máu trên da \n\nCách dùng: làm ướt toàn bộ lông, cho dầu tắm lên lông và xát đều trong 1-2 phút, để yên 5 phút rồi tắm sạch bằng nước thường. Mỗi tuần tắm 1 lần',1,1,83000,'Sữa Tắm Trị Viêm Da Cho Chó Bio Derma 200ml',100,20,3),(10,'2023-03-21','Vòng cổ phối khăn cho chó mèo có 2 size:\n\nS: dành cho thú cưng dưới 5kg\n\nM: dành cho thú cưng dưới 8kg\n\nVòng cổ kết hợp với khăn mang đến phong cách ngộ nghĩnh, đáng yêu cho thú cưng\n\nChất liệu vòng cổ bằng vải nhung, còn phần khăn là vải polyester có độ bền cao',1,1,30000,'Vòng Cổ Cho Chó Mèo Phối Khăn Họa Tiết',100,20,3),(11,'2023-04-03','ashdgfhsghdfsdf',1,1,60000,'tat den',1,0,2);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_image`
--

DROP TABLE IF EXISTS `product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url_image` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6oo0cvcdtb6qmwsga468uuukk` (`product_id`),
  CONSTRAINT `FK6oo0cvcdtb6qmwsga468uuukk` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_image`
--

LOCK TABLES `product_image` WRITE;
/*!40000 ALTER TABLE `product_image` DISABLE KEYS */;
INSERT INTO `product_image` VALUES (1,'https://product.hstatic.net/1000356051/product/6_f91bb0daee904c089144ffc4a378076a_master.png',1),(2,'https://product.hstatic.net/1000356051/product/4_2ceb0ba0af3e4f17bf3b87d98be1b53a_master.png',1),(3,'https://product.hstatic.net/1000356051/product/6_f91bb0daee904c089144ffc4a378076a_master.png',1),(4,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/long-sat-di-dong-cao-cap-d222a-df739880-5b25-404d-957d-812e7b4204e6.jpg?v=1669103411093',2),(5,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/thuc-an-cho-meo-me-o-7kg-vi-ca-ngu-bao-xa.jpg?v=1676431634633',3),(6,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/thuc-an-cho-meo-me-o-7kg-vi-ca-thu-bao-xa.jpg?v=1676431641013',3),(7,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/thuc-an-cho-meo-me-o-7kg-vi-hai-san-bao-xa.jpg?v=1676431648093',3),(8,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/bo-loc-nuoc10.jpg?v=1669279674153',4),(9,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/bo-loc-nuoc15.jpg?v=1669279683137',4),(10,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/bo-loc-nuoc11.jpg?v=1669279690073',4),(11,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/to-doi-meo-nhua5.jpg?v=1669279968107',5),(12,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/to-doi-meo-nhua7.jpg?v=1669279974087',5),(13,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/to-doi-meo-nhua4.jpg?v=1669279978923',5),(14,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/ro-mom-silicon-cho-cho-2.jpg?v=1618462128880',6),(15,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/ro-mom-silicon-cho-cho-1.jpg?v=1618462128880',6),(16,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/ro-mom-silicon-cho-cho-2-f386c664-3bd5-4305-9aad-d9ee44bd6a0b.jpg?v=1618462128880',6),(17,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/giay-nhua-di-mua-1.jpg?v=1618373508023',7),(18,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/giay-nhua-di-mua-2.jpg?v=1618373508023',7),(19,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/giay-nhua-di-mua-5.jpg?v=1618373508023',7),(20,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/vong-co-no-caro-cho-cho-meo.jpg?v=1677220133730',8),(21,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/sua-tam-tri-ghe-nam-da-bio-derma-cho-cho-200ml.jpg?v=1677480928930',9),(22,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/sua-tam-tri-ghe-va-nam-da-bio-derma-cho-cho-200ml.jpg?v=1677480934710',9),(23,'https://bizweb.dktcdn.net/thumb/large/100/092/840/products/vong-co-phoi-khan-cho-cho-meo.jpg?v=1677215277510',10),(24,'http://res.cloudinary.com/drlroexjl/image/upload/v1680517462/eakwk6gqnugpahndhxos.jpg',11);
/*!40000 ALTER TABLE `product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(255) NOT NULL,
  `avatar` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `email` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `login_type` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `password` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone_number` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `role` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `user_name` varchar(1111) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','https://haycafe.vn/wp-content/uploads/2022/02/Avatar-trang-den.png','admin@gmail.com','default','MQ==','0799197703','admin','admin'),('trieu','https://haycafe.vn/wp-content/uploads/2022/02/Avatar-trang-den.png','trieu@gmail.com','default','MQ==','0799197703','user','Phan quoc trieu');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-03 20:46:35

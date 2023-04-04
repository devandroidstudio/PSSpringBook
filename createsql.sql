
create database fashionstore;
use fashionstore;
-- Tạo bảng
create table cart (id integer not null auto_increment, count integer not null, product_id integer, user_id varchar(255), primary key (id)) engine=InnoDB;
create table category (id integer not null auto_increment, category_name nvarchar(1111), primary key (id)) engine=InnoDB;
create table `order` (id integer not null auto_increment, address nvarchar(1111), booking_date date, country nvarchar(1111), email nvarchar(1111), fullname nvarchar(1111), note nvarchar(1111), payment_method nvarchar(1111), phone nvarchar(1111), status nvarchar(1111), total integer, user_id varchar(255), primary key (id)) engine=InnoDB;
create table order_item (id integer not null auto_increment, count integer, order_id integer, product_id integer, primary key (id)) engine=InnoDB;
create table product (id integer not null auto_increment, created_at date, description nvarchar(11111), is_active integer, is_selling integer, price integer, product_name nvarchar(1111), quantity integer, sold integer, category_id integer, primary key (id)) engine=InnoDB;
create table product_image (id integer not null auto_increment, url_image nvarchar(1111), product_id integer, primary key (id)) engine=InnoDB;
create table user (id varchar(255) not null, avatar nvarchar(1111), email nvarchar(1111), login_type nvarchar(1111), password nvarchar(1111), phone_number nvarchar(1111), role nvarchar(1111), user_name nvarchar(1111), primary key (id)) engine=InnoDB;
alter table cart add constraint FK3d704slv66tw6x5hmbm6p2x3u foreign key (product_id) references product (id);
alter table cart add constraint FKl70asp4l4w0jmbm1tqyofho4o foreign key (user_id) references user (id);
alter table `order` add constraint FKcpl0mjoeqhxvgeeeq5piwpd3i foreign key (user_id) references user (id);
alter table order_item add constraint FKs234mi6jususbx4b37k44cipy foreign key (order_id) references `order` (id);
alter table order_item add constraint FK551losx9j75ss5d6bfsqvijna foreign key (product_id) references product (id);
alter table product add constraint FK1mtsbur82frn64de7balymq9s foreign key (category_id) references category (id);
alter table product_image add constraint FK6oo0cvcdtb6qmwsga468uuukk foreign key (product_id) references product (id);

-- Insert dữ liệu
INSERT INTO `fashionstore`.`user` (`id`, `login_Type`, `role`, `password`, `user_Name`, `avatar`, `email`, `phone_Number`) VALUES ('trieu', 'default', 'user', 'MQ==', 'Phan quoc trieu', 'https://haycafe.vn/wp-content/uploads/2022/02/Avatar-trang-den.png', 'trieu@gmail.com', '0799197703');
INSERT INTO `fashionstore`.`user` (`id`, `login_Type`, `role`, `password`, `user_Name`, `avatar`, `email`, `phone_Number`) VALUES ('admin', 'default', 'admin', 'MQ==', 'admin', 'https://haycafe.vn/wp-content/uploads/2022/02/Avatar-trang-den.png', 'admin@gmail.com', '0799197703');
-- user name = trieu pass=1
-- admin name = admin pass=1

INSERT INTO `fashionstore`.`category` (`category_Name`) VALUES ('Đồ ăn');
INSERT INTO `fashionstore`.`category` (`category_Name`) VALUES ('Phụ kiện');
INSERT INTO `fashionstore`.`category` (`category_Name`) VALUES ('Vật dụng');
INSERT INTO `fashionstore`.`category` (`category_Name`) VALUES ('chuồng');
INSERT INTO `fashionstore`.`category` (`category_Name`) VALUES ('chăm sóc');

INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'Balo địu thú cưng SONICE Pet Carrier - Hỗ trợ mang thú cưng đi dạo Petmall.', '1', '1', '500000', 'Balo địu thú cưng SONICE Pet Carrier - Hỗ trợ mang thú cưng đi dạo Petmall', '100', '20', '3');

INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'Lồng Cho Cho Di Động Cao Cấp Bằng Sắt Mã D222A', '1', '1', '4300000', 'Lồng Cho Cho Di Động Cao Cấp Bằng Sắt Mã D222A', '100', '20', '4');

INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'Thông tin sản phẩm thức ăn Cho Mèo trưởng thành trên 12 tháng tuổi

Có 3 vị Cá Ngừ và vị Hải Sản và Vị Cá Thu

Bảo đảm an toàn, không bị hư hỏng khi để bên ngoài và thời gian bảo quản sử dụng lâu (18 tháng), giúp giữ vệ sinh, giảm sự tích tụ cao răng làm hư răng và đặc biệt nhất là giúp chất thải (phân) của thú cưng giảm hẳn những mùi hôi khó chịu.', '1', '1', '430000', 'Thức Ăn Cho Mèo Me-O Bao Xá 7kg', '100', '20', '1');
INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'MÁY LỌC NƯỚC CHO MÈO PAKEWAY 2.5L
Máy lọc nước với 4 lớp lọc giúp tạo ra nguồn nước chất lượng cho mèo
Dung tích lớn 2.5L trữ được đủ lượng nước cung cấp cho mèo trưởng thành đến 10 ngày
Thiết kế dễ tháo rời, dễ vệ sinh và thay nước
Tiếng ồn thấp
Kích thước 20x20x15cm', '1', '1', '270000', 'Máy Lọc Nước Cho Chó Mèo PAKEWAY 2.5L', '100', '20', '3');

INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'BÁT ĂN CHO MÈO - TÔ NHỰA ĐÔI MÈO CHO CHÓ MÈO
Được làm từ chất liệu nhựa an toàn tuyệt đối cho chó mèo, giúp cho bé cưng nhà bạn có những bữa ăn ngon miệng, sạch sẽ

Thích hợp cho chó mèo giống nhỏ dưới 5kg', '1', '1', '50000', 'Tô Ăn Cho Chó Mèo - Tô Nhựa Đôi Mèo', '99', '20', '3');

INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'Chất Liệu: silicone siêu mềm

Có nhiều lỗ thoáng khí, không làm cho chó bị ngộp

Được thiết kế khóa điều chỉnh size cho phù hợp mõm của thú cưng.

Rọ mõm giúp ngăn chặn thú cưng sủa, cắn, liếm vết thương, thói quen ăn bậy của thú cưng', '1', '1', '160000', 'Rọ Mõm Silicon Cho Chó', '100', '20', '5');

INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'Giày được làm bằng cao su dẻo thích hợp cho các bé trong mùa mưa này.Giày được thiết kế gọn nhẹ,tạo cảm giác thoải mái khi mang,hợp thời trang', '1', '1', '100000', 'Giày Nhựa Đi Mưa Cho Chó Mèo', '100', '20', '2');

INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'Vòng cổ có chất liệu là vải dù chắc chắc, bền đẹp nhưng vẫn mang đến cảm giác thoải mái cho thú cưng khi đeo

Điểm nhấn của vòng cổ là chiếc nơ xinh xắn cùng màu và chiếc lục lạc phát ra tiếng kêu khi thú cưng di chuyển

Chắc chắn chiếc vòng cổ là món phụ kiện tuyệt vời có thể phối hợp với nhiều loại trang phục khác nhau', '1', '1', '32000', 'Vòng Cổ Cho Chó Mèo Nơ Caro', '64', '11', '3');

INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'Sữa tắm trị viêm da, ghẻ cho chó Bio Derma có công dụng phòng & trị bệnh ghẻ do demodex, sarcoptes, bọ chét trên chó kết hợp với nấm da gây triệu chứng: hôi lông, rụng lông, khô da hoặc chảy dịch vàng, chảy máu trên da 

Cách dùng: làm ướt toàn bộ lông, cho dầu tắm lên lông và xát đều trong 1-2 phút, để yên 5 phút rồi tắm sạch bằng nước thường. Mỗi tuần tắm 1 lần', '1', '1', '83000', 'Sữa Tắm Trị Viêm Da Cho Chó Bio Derma 200ml', '100', '20', '3');

INSERT INTO `fashionstore`.`product` (`created_at`, `description`, `is_active`, `is_selling`, `price`, `product_name`, `quantity`, `sold`, `category_id`) VALUES ('2023-03-21', 'Vòng cổ phối khăn cho chó mèo có 2 size:

S: dành cho thú cưng dưới 5kg

M: dành cho thú cưng dưới 8kg

Vòng cổ kết hợp với khăn mang đến phong cách ngộ nghĩnh, đáng yêu cho thú cưng

Chất liệu vòng cổ bằng vải nhung, còn phần khăn là vải polyester có độ bền cao', '1', '1', '30000', 'Vòng Cổ Cho Chó Mèo Phối Khăn Họa Tiết', '100', '20', '3');

INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://product.hstatic.net/1000356051/product/6_f91bb0daee904c089144ffc4a378076a_master.png', '1');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://product.hstatic.net/1000356051/product/4_2ceb0ba0af3e4f17bf3b87d98be1b53a_master.png', '1');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://product.hstatic.net/1000356051/product/6_f91bb0daee904c089144ffc4a378076a_master.png', '1');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/long-sat-di-dong-cao-cap-d222a-df739880-5b25-404d-957d-812e7b4204e6.jpg?v=1669103411093', '2');

INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/thuc-an-cho-meo-me-o-7kg-vi-ca-ngu-bao-xa.jpg?v=1676431634633', '3');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/thuc-an-cho-meo-me-o-7kg-vi-ca-thu-bao-xa.jpg?v=1676431641013', '3');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/thuc-an-cho-meo-me-o-7kg-vi-hai-san-bao-xa.jpg?v=1676431648093', '3');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/bo-loc-nuoc10.jpg?v=1669279674153', '4');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/bo-loc-nuoc15.jpg?v=1669279683137', '4');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/bo-loc-nuoc11.jpg?v=1669279690073', '4');

INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/to-doi-meo-nhua5.jpg?v=1669279968107', '5');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/to-doi-meo-nhua7.jpg?v=1669279974087', '5');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/to-doi-meo-nhua4.jpg?v=1669279978923', '5');

INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/ro-mom-silicon-cho-cho-2.jpg?v=1618462128880', '6');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/ro-mom-silicon-cho-cho-1.jpg?v=1618462128880', '6');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/ro-mom-silicon-cho-cho-2-f386c664-3bd5-4305-9aad-d9ee44bd6a0b.jpg?v=1618462128880', '6');

INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/giay-nhua-di-mua-1.jpg?v=1618373508023', '7');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/giay-nhua-di-mua-2.jpg?v=1618373508023', '7');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/giay-nhua-di-mua-5.jpg?v=1618373508023', '7');

INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/vong-co-no-caro-cho-cho-meo.jpg?v=1677220133730', '8');

INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/sua-tam-tri-ghe-nam-da-bio-derma-cho-cho-200ml.jpg?v=1677480928930', '9');
INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/sua-tam-tri-ghe-va-nam-da-bio-derma-cho-cho-200ml.jpg?v=1677480934710', '9');

INSERT INTO `fashionstore`.`product_image` (`url_image`, `product_id`) VALUES ('https://bizweb.dktcdn.net/thumb/large/100/092/840/products/vong-co-phoi-khan-cho-cho-meo.jpg?v=1677215277510', '10');


INSERT INTO `fashionstore`.`cart` (`count`, `product_id`, `user_id`) VALUES ('2', '1', 'trieu');

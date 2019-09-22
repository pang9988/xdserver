#设置客户端连接服务器端的编码
SET NAMES UTF8;
#先丢弃数据库,如果存在的话 
DROP DATABASE IF EXISTS xindan;
#创建新的数据库xindan, 设置储存的编码
CREATE DATABASE xindan CHARSET=UTF8;
#进入数据库xindan
USE xindan;

#创建表xd_login
CREATE TABLE xd_login(
id INT PRIMARY KEY AUTO_INCREMENT,
uname VARCHAR(50),
upwd VARCHAR(32),
email VARCHAR(64),
phone VARCHAR(16),
);
#添加测试数据 
INSERT INTO xd_login VALUES(null,'pang',md5('123'),'pang@qq.com','13812345678');
INSERT INTO xd_login VALUES(null,'tom',md5('123'),'tom@qq.com','13888888888');


###功能商品添加
#功能三:向商品表中添加一列 img_url
USE xindan;
ALTER TABLE xd_laptop ADD img_url VARCHAR(255);
#更新商品表图片 01.jpg 02.jpg
UPDATE xd_laptop SET img_url='lvbo1.jpg'
WHERE lid = 1;
UPDATE xd_laptop SET img_url='lvbo2.jpg'
WHERE lid = 2;
UPDATE xd_laptop SET img_url='lvbo3.jpg'
WHERE lid = 3;


#创建表 购物车
#DECIMAL 高精度浮点数 2.00-1.99=0.01
#INT 199分 /100 无误差
#lid 商品编号/price 价格/count数量
#lname 商品名称/uid用户编号
CREATE TABLE xd_cart(
id INT PRIMARY KEY AUTO_INCREMENT,
lid INT,
price DECIMAL(10,2),
count INT,
lname VARCHAR(255),
uid INT
);


###功能商品添加
#功能三:向商品表中添加一列 img_url
USE xindan;
ALTER TABLE xd_laptop ADD img_url VARCHAR(255);
#更新商品表图片 01.jpg 02.jpg
UPDATE xd_laptop SET img_url='lvbo1.jpg'
WHERE lid = 1;
UPDATE xd_laptop SET img_url='lvbo2.jpg'
WHERE lid = 2;
UPDATE xd_laptop SET img_url='lvbo3.jpg'
WHERE lid = 3;


#创建表 购物车
#DECIMAL 高精度浮点数 2.00-1.99=0.01
#INT     199分 /100  无误差
#lid 商品编号/price 价格/count数量
#lname 商品名称/uid用户编号
CREATE TABLE xd_cart(
  id     INT PRIMARY KEY AUTO_INCREMENT,
  lid    INT,
  price  DECIMAL(10,2),
  count  INT,
  lname  VARCHAR(255),
  uid    INT
);


#轮播图片
DROP TABLE IF EXISTS `xd_index_carousel`;
CREATE TABLE `xd_index_carousel` (
  `cid` int(11) NOT NULL auto_increment,
  `img` varchar(128) default NULL,
  `title` varchar(64) default NULL,
  PRIMARY KEY  (`cid`)
) 
ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xd_index_carousel
-- ----------------------------
INSERT INTO `xd_index_carousel` VALUES ('1', 'lvbo/lvbo1.png', '轮播广告商品1');
INSERT INTO `xd_index_carousel` VALUES ('2', 'lvbo/lvbo2.png', '轮播广告商品2');
INSERT INTO `xd_index_carousel` VALUES ('3', 'lvbo/lvbo3.png', '轮播广告商品3');


###/*为你推荐*/
CREATE TABLE new_list(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(40),
img_url VARCHAR(90),
price DECIMAL(10,2)

);
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/1.jpg','3099');
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/2.jpg','2199');
###/*循环测试数据*/
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/3.jpg','3129');
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/4.jpg','4199');
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/5.jpg','6199');
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/6.jpg','3199');
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/7.jpg','3109');
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/8.jpg','3999');
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/9.jpg','199')


###/*新品上市*/
CREATE TABLE xinpinsha(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(40),
img_url VARCHAR(90),
price DECIMAL(10,2)
);
INSERT INTO xinpinsha VALUES(null,'Apple iPhone11耳机','./img/xinpinsha/5.jpg','6199.52');
INSERT INTO xinpinsha VALUES(null,'Apple iPhone12手机','./img/xinpinsha/6.jpg','3199.41');
INSERT INTO xinpinsha VALUES(null,'Apple 那良村毛绒抱枕手机','./img/xinpinsha/7.jpg','3109.85');
INSERT INTO xinpinsha VALUES(null,'Apple iPhone廉江红橙','./img/xinpinsha/8.jpg','3999.88');
INSERT INTO xinpinsha VALUES(null,'Apple iPhone廉江樱花公园','./img/xinpinsha/9.jpg','199.66')


###/*人气推荐*/
CREATE TABLE ren_qi(
id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(40),
img_url VARCHAR(90),
price DECIMAL(10,2)
);
INSERT INTO ren_qi VALUES(null,'Apple iPhone熊猫耳机','./img/renqi/5.jpg','6199.52');
INSERT INTO ren_qi VALUES(null,'Apple iPhone90后毛绒抱枕手机','./img/renqi/6.jpg','3199.41');
INSERT INTO ren_qi VALUES(null,'Apple iPhone那良村毛绒抱枕手机','./img/renqi/7.jpg','3109.85');
INSERT INTO ren_qi VALUES(null,'Apple iPhone廉江电饭煲','./img/renqi/8.jpg','3999.88');
INSERT INTO ren_qi VALUES(null,'Apple iPhone廉江热水库','./img/renqi/9.jpg','199.66')




##/*商品列表*/
CREATE TABLE shangpin_list(
   id INT PRIMARY KEY AUTO_INCREMENT,
   title VARCHAR(40),
   details VARCHAR(40),
   img_url VARCHAR(90),
   price DECIMAL(10,2)
);
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1000-30元','./img/productlist/1.jpg','5199.52');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone廉江热水库','输入蛋券sw07,满1000-30元','./img/productlist/2.jpg','6159.55');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满100-30元','./img/productlist/3.jpg','6189.52');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone廉江热水库','输入蛋券sw07,满1000-30元','./img/productlist/4.jpg','6159.54');
INSERT INTO shangpin_list VALUES(null,'Apple Apple iPhone廉江电饭煲','输入蛋券sw07,满1000-30元','./img/productlist/5.jpg','6499.59');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1000-30元','./img/productlist/6.jpg','6179.42');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone廉江热水库','输入蛋券sw07,满9000-30元','./img/productlist/7.jpg','6129.62');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1000-30元','./img/productlist/8.jpg','6179.42');
INSERT INTO shangpin_list VALUES(null,'Apple Apple iPhone廉江电饭煲','输入蛋券sw07,满1000-30元','./img/productlist/9.jpg','5199.62');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone廉江热水库','输入蛋券sw07,满1000-30元','./img/productlist/10.jpg','4199.52');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw007,满1000-30元','./img/productlist/11.jpg','9199.42');
INSERT INTO shangpin_list VALUES(null,'Apple Apple iPhone廉江电饭煲','输入蛋券sw07,满1000-30元','./img/productlist/12.jpg','61449.12');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1000-30元','./img/productlist/13.jpg','5199.82');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1500-30元','./img/productlist/14.jpg','6889.99');

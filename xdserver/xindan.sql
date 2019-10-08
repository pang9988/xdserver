#设置客户端连接服务器端的编码
SET NAMES UTF8;
#先丢弃数据库,如果存在的话 
DROP DATABASE IF EXISTS xindan;
#创建新的数据库xindan, 设置储存的编码
CREATE DATABASE xindan CHARSET=UTF8;
#进入数据库xindan
USE xindan;

#创建表xd_login
#Drop table IF EXISTS xd_login
CREATE TABLE xd_login(
id INT PRIMARY KEY AUTO_INCREMENT,
uname VARCHAR(50),
upwd VARCHAR(32),
email VARCHAR(64),
phone VARCHAR(16)
);
#添加测试数据 
INSERT INTO xd_login VALUES(null,'pang',md5('123'),'pang@qq.com','13812345678');
INSERT INTO xd_login VALUES(null,'tom',md5('123'),'tom@qq.com','13888888888');

########################################
#创建表xd_login
#Drop table IF EXISTS xd_laptop
CREATE TABLE xd_laptop(
id INT PRIMARY KEY AUTO_INCREMENT,
lid INT,
img_url VARCHAR(128)
);
INSERT INTO xd_laptop VALUES(null,1,'lvbo1.jpg');
INSERT INTO xd_laptop VALUES(null,2,'lvbo2.jpg');
INSERT INTO xd_laptop VALUES(null,3,'lvbo3.jpg');


###功能商品添加
#功能三:向商品表中添加一列 img_url
#ALTER TABLE xd_laptop ADD img_url VARCHAR(255);
#更新商品表图片 01.jpg 02.jpg
#UPDATE xd_laptop SET img_url='lvbo1.jpg'
#WHERE lid = 1;
#UPDATE xd_laptop SET img_url='lvbo2.jpg'
#WHERE lid = 2;
#UPDATE xd_laptop SET img_url='lvbo3.jpg'
#WHERE lid = 3;

#轮播图片
#DROP TABLE IF EXISTS `xd_index_carousel`;
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
#Drop table IF EXISTS new_list
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
INSERT INTO new_list VALUES(null,'Apple iPhone熊猫毛绒抱枕手机','./img/newlist/9.jpg','199');



###/*新品上市*/
#Drop table IF EXISTS xinpinshashi
CREATE TABLE xinpinshashi(
id INT PRIMARY KEY AUTO_INCREMENT,
lid INT,              #商品编号
title VARCHAR(40),
img_url VARCHAR(128),
img_lo  VARCHAR(128),
img_big  VARCHAR(128),
price DECIMAL(10,2)
);
INSERT INTO xinpinshashi VALUES(null,1,'Apple iPhone11耳机','./img/xinpinsha/11.jpg','./img/xinpinsha_lo/14.jpg','./img/xinpinsha_big/14.jpg','6199.52');
INSERT INTO xinpinshashi VALUES(null,2,'Apple 那良村毛绒抱枕手机','./img/xinpinsha/12.jpg','./img/xinpinsha_lo/21.jpg','./img/xinpinsha_big/21.jpg','3109.85');
INSERT INTO xinpinshashi VALUES(null,3,'Apple iPhone廉江红橙','./img/xinpinsha/13.jpg','./img/xinpinsha_lo/31.jpg','./img/xinpinsha_big/31.jpg','6199.52');
INSERT INTO xinpinshashi VALUES(null,4,'Apple iPhone廉江樱花公园','./img/xinpinsha/14.jpg','./img/xinpinsha_lo/41.jpg','./img/xinpinsha_big/41.jpg','6129.52');

#INSERT INTO xinpinshashi VALUES(null,5,'Apple iPhone11耳机','./img/xinpinsha/11.jpg','./img/xinpinsha_lo/14.jpg','./img/xinpinsha_big/14.jpg','6199.52');

#INSERT INTO xinpinshashi VALUES(null,6,'Apple 那良村毛绒抱枕手机','./img/xinpinsha/12.jpg','./img/xinpinsha_lo/21.jpg','./img/xinpinsha_big/21.jpg','3109.85');
#INSERT INTO xinpinshashi VALUES(null,7,'Apple iPhone廉江红橙','./img/xinpinsha/13.jpg','./img/xinpinsha_lo/31.jpg','./img/xinpinsha_big/31.jpg','6199.52');
#INSERT INTO xinpinshashi VALUES(null,8,'Apple iPhone廉江樱花公园','./img/xinpinsha/14.jpg','./img/xinpinsha_lo/41.jpg','./img/xinpinsha_big/41.jpg','6129.52');

#INSERT INTO xinpinshashi VALUES(null,9,'Apple iPhone11耳机','./img/xinpinsha/11.jpg','./img/xinpinsha_lo/14.jpg','./img/xinpinsha_big/14.jpg','6199.52');
#INSERT INTO xinpinshashi VALUES(null,10,'Apple 那良村毛绒抱枕手机','./img/xinpinsha/12.jpg','./img/xinpinsha_lo/21.jpg','./img/xinpinsha_big/21.jpg','3109.85');
#INSERT INTO xinpinshashi VALUES(null,11,'Apple iPhone廉江红橙','./img/xinpinsha/13.jpg','./img/xinpinsha_lo/31.jpg','./img/xinpinsha_big/31.jpg','6199.52');
#INSERT INTO xinpinshashi VALUES(null,12,'Apple iPhone廉江樱花公园','./img/xinpinsha/14.jpg','./img/xinpinsha_lo/41.jpg','./img/xinpinsha_big/41.jpg','6129.52');
#INSERT INTO xinpinshashi VALUES(null,13,'Apple iPhone11耳机','./img/xinpinsha/11.jpg','./img/xinpinsha_lo/14.jpg','./img/xinpinsha_big/14.jpg','6199.52');
#INSERT INTO xinpinshashi VALUES(null,14,'Apple 那良村毛绒抱枕手机','./img/xinpinsha/12.jpg','./img/xinpinsha_lo/21.jpg','./img/xinpinsha_big/21.jpg','3109.85');
#INSERT INTO xinpinshashi VALUES(null,15,'Apple iPhone廉江红橙','./img/xinpinsha/13.jpg','./img/xinpinsha_lo/31.jpg','./img/xinpinsha_big/31.jpg','6199.52');
#INSERT INTO xinpinshashi VALUES(null,16,'Apple iPhone廉江樱花公园','./img/xinpinsha/14.jpg','./img/xinpinsha_lo/41.jpg','./img/xinpinsha_big/41.jpg','6129.52');



###/*人气推荐*/
#Drop table IF EXISTS ren_qi
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
INSERT INTO ren_qi VALUES(null,'Apple iPhone廉江热水库','./img/renqi/9.jpg','199.66');




##/*商品列表*/
#Drop table IF EXISTS shangpin_list
CREATE TABLE shangpin_list(
   id INT PRIMARY KEY AUTO_INCREMENT,
   title VARCHAR(40),
   details VARCHAR(40),
   img_url VARCHAR(90),
   img_lo  VARCHAR(128),
   img_big  VARCHAR(128),
   price DECIMAL(10,2)
);
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1000-30元','./img/productlist/1.jpg','./img/xinpinsha_lo/45.jpg','./img/xinpinsha_big/45.jpg','5199.52');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone廉江热水库','输入蛋券sw07,满1000-30元','./img/productlist/2.jpg','./img/xinpinsha_lo/46.jpg','./img/xinpinsha_big/46.jpg','6159.55');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满100-30元','./img/productlist/3.jpg','./img/xinpinsha_lo/47.jpg','./img/xinpinsha_big/47.jpg','6189.52');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone廉江热水库','输入蛋券sw07,满1000-30元','./img/productlist/4.jpg','./img/xinpinsha_lo/48.jpg','./img/xinpinsha_big/48.jpg','6159.54');
INSERT INTO shangpin_list VALUES(null,'Apple Apple iPhone廉江电饭煲','输入蛋券sw07,满1000-30元','./img/productlist/5.jpg','./img/xinpinsha_lo/49.jpg','./img/xinpinsha_big/49.jpg','6499.59');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1000-30元','./img/productlist/6.jpg','./img/xinpinsha_lo/50.jpg','./img/xinpinsha_big/50.jpg','6179.42');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone廉江热水库','输入蛋券sw07,满9000-30元','./img/productlist/7.jpg','./img/xinpinsha_lo/51.jpg','./img/xinpinsha_big/51.jpg','6129.62');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1000-30元','./img/productlist/8.jpg','./img/xinpinsha_lo/52.jpg','./img/xinpinsha_big/52.jpg','6179.42');
INSERT INTO shangpin_list VALUES(null,'Apple Apple iPhone廉江电饭煲','输入蛋券sw07,满1000-30元','./img/productlist/9.jpg','./img/xinpinsha_lo/53.jpg','./img/xinpinsha_big/53.jpg','5199.62');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone廉江热水库','输入蛋券sw07,满1000-30元','./img/productlist/10.jpg','./img/xinpinsha_lo/54.jpg','./img/xinpinsha_big/54.jpg','4199.52');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw007,满1000-30元','./img/productlist/11.jpg','./img/xinpinsha_lo/55.jpg','./img/xinpinsha_big/55.jpg','9199.42');
INSERT INTO shangpin_list VALUES(null,'Apple Apple iPhone廉江电饭煲','输入蛋券sw07,满1000-30元','./img/productlist/12.jpg','./img/xinpinsha_lo/56.jpg','./img/xinpinsha_big/56.jpg','61449.12');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1000-30元','./img/productlist/13.jpg','./img/xinpinsha_lo/57.jpg','./img/xinpinsha_big/57.jpg','5199.82');
INSERT INTO shangpin_list VALUES(null,'Apple iPhone熊猫耳机','输入蛋券sw07,满1500-30元','./img/productlist/14.jpg','./img/xinpinsha_lo/58.jpg','./img/xinpinsha_big/59.jpg','6889.99');




#创建表 购物车
#DECIMAL 高精度浮点数 2.00-1.99=0.01
#INT     199分 /100  无误差
#lid 商品编号/price 价格/count数量
#title 商品名称/uid用户编号
#img_url  商品图片
#Drop table IF EXISTS xinpin_cart
CREATE TABLE xinpin_cart(
  id     INT PRIMARY KEY AUTO_INCREMENT,
  lid    INT,
  price  DECIMAL(10,2),
  count  INT,
  title  VARCHAR(255),
  uid    INT,
  imgurl VARCHAR(128)
);

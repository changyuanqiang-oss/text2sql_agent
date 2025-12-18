/*
 Navicat Premium Dump SQL

 Source Server         : 本地数据库
 Source Server Type    : MySQL
 Source Server Version : 80405 (8.4.5)
 Source Host           : localhost:3306
 Source Schema         : book

 Target Server Type    : MySQL
 Target Server Version : 80405 (8.4.5)
 File Encoding         : 65001

 Date: 18/12/2025 17:08:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for Orders
-- ----------------------------
DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
  `Row ID` int DEFAULT NULL COMMENT '行号',
  `Order ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单id',
  `Order Date` date DEFAULT NULL COMMENT '订单日期',
  `Ship Date` date DEFAULT NULL COMMENT '快递日期',
  `Ship Mode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '快递模式',
  `Customer ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户id',
  `Customer Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户姓名',
  `Segment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '段',
  `Country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '国家',
  `City` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '城市',
  `State` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '州',
  `Postal Code` int DEFAULT NULL COMMENT '邮编',
  `Region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区域',
  `Product ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '产品id',
  `Category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '类目',
  `Sub-Category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '大类目',
  `Product Name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '产品名称',
  `Sales` double DEFAULT NULL COMMENT '售价',
  `Quantity` int DEFAULT NULL COMMENT '数量',
  `Discount` double DEFAULT NULL COMMENT '折扣',
  `Profit` double unsigned zerofill DEFAULT NULL COMMENT '利润',
  PRIMARY KEY (`Order ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单明细表，这张表里记录了所有订单明细。';

-- ----------------------------
-- Records of Orders
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for People
-- ----------------------------
DROP TABLE IF EXISTS `People`;
CREATE TABLE `People` (
  `Person` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区域经理姓名',
  `Region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区域'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='区域经理和区域的关系表';

-- ----------------------------
-- Records of People
-- ----------------------------
BEGIN;
INSERT INTO `People` (`Person`, `Region`) VALUES ('Anna Andreadi', 'West');
INSERT INTO `People` (`Person`, `Region`) VALUES ('Chuck Magee', 'East');
INSERT INTO `People` (`Person`, `Region`) VALUES ('Kelly Williams', 'Central');
INSERT INTO `People` (`Person`, `Region`) VALUES ('Cassandra Brandow', 'South');
COMMIT;

-- ----------------------------
-- Table structure for Returns
-- ----------------------------
DROP TABLE IF EXISTS `Returns`;
CREATE TABLE `Returns` (
  `Returned` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '是否返还',
  `Order ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '订单id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单返还表，记录了所有订单有没有返还。';

-- ----------------------------
-- Records of Returns
-- ----------------------------
BEGIN;
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-153822');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-129707');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-152345');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-156440');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-155999');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-157924');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-131807');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-124527');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-135692');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-123225');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-145772');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2014-105137');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-101805');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-111682');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-131492');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-104129');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-117926');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-115952');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-155761');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-100111');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-156349');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-118899');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-108294');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-123834');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-168480');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-122007');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-128965');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-169397');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-168564');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-102652');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-112340');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-114727');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-151827');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-152814');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-114230');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-146486');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-116092');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-118542');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-140984');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-127306');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-119284');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-150609');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-136651');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-136539');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-110786');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-126403');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-157280');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-162138');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-114307');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-123498');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-142398');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-161956');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-134194');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-134075');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-156986');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-105578');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-131149');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-147886');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-126361');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-141929');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-145583');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-154970');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-167759');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-109085');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-142769');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-107888');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-109918');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-131618');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-109253');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-130631');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-118087');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-126732');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-144057');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-168921');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-109806');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-104829');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-147375');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-134726');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-117513');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2014-138758');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-126522');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-115994');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-138282');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-161459');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-136483');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-116547');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-130785');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-165008');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2015-137008');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-169894');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-105270');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-165330');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-111871');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-157812');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-145982');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-166142');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-127131');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-143084');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-151547');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-138674');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-169019');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-100762');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2014-164406');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-118500');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-143490');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-115427');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-124058');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-132346');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-150077');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-124401');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-137414');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-142867');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-157196');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-149342');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-112123');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-147998');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-103716');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-144267');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-109869');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-166898');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-169327');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-169859');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-137085');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-154074');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-130477');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-134775');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-105046');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-136924');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-166093');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-106950');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-145128');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-114293');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-137099');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-133319');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-103744');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-161627');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-142601');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-112144');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-164861');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2015-128090');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-108609');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-147452');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-123568');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-102519');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-121853');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-132374');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2014-150574');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-148614');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-165491');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-133802');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-112865');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-130680');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-114048');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-108931');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-136308');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-126529');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-135699');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-146255');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-140053');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-143336');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-159954');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-105291');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-158729');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-101273');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-123085');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-131828');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-113670');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-135580');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-157490');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-142888');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-153150');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-152051');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-103940');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-159345');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-162015');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-148873');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-167395');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-127425');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-142342');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-159212');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-116736');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-128671');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-112753');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-148957');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-110814');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-164721');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2015-136987');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-151372');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-151127');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2015-110569');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-153220');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-117212');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-101574');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-151323');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-166744');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-119046');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-105158');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-103380');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-161746');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-111948');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-138163');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-134201');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2015-126214');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-140816');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-133690');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-120873');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-103247');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-155712');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-108455');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-104689');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-152660');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2015-136749');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-143602');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-134803');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-139269');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-123253');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-162159');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-135720');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-159338');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-136679');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-113628');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-107825');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-160766');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-118311');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-130456');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-148950');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-119214');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-119907');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-137428');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-108861');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-130638');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-143238');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-109736');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-124688');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-133368');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-168193');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-135657');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-105081');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-154214');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-107678');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-144064');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-101700');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-113341');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-139731');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-132941');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-146262');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-115917');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-111528');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-142328');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-141593');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-121258');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-141726');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-167003');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2015-160857');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-145261');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-112725');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-145919');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-140151');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-164882');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-123491');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-127012');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-123526');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-161557');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-150875');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-150770');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2014-140452');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-149650');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-100867');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-140186');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-156391');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-157770');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-140963');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-154949');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-166275');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2014-143287');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-151162');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2017-103828');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-143840');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-160773');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-111556');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-140585');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-103373');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-159023');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-145492');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-118122');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2014-116785');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2014-164763');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-122504');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-150910');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-162166');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'US-2016-140172');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-101910');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2017-156958');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-105585');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2016-148796');
INSERT INTO `Returns` (`Returned`, `Order ID`) VALUES ('Yes', 'CA-2015-149636');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

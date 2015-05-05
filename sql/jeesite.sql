-- --------------------------------------------------------
-- 主机:                           192.168.1.111
-- 服务器版本:                        5.5.32 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  8.2.0.4675
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 导出 jeesite 的数据库结构
DROP DATABASE IF EXISTS `jeesite`;
CREATE DATABASE IF NOT EXISTS `jeesite` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jeesite`;


-- 导出  表 jeesite.approach_aim 结构
DROP TABLE IF EXISTS `approach_aim`;
CREATE TABLE IF NOT EXISTS `approach_aim` (
  `ID` varchar(64) NOT NULL,
  `NAME` varchar(64) DEFAULT NULL,
  `REMARKS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='进场目的';

-- 正在导出表  jeesite.approach_aim 的数据：~11 rows (大约)
/*!40000 ALTER TABLE `approach_aim` DISABLE KEYS */;
INSERT INTO `approach_aim` (`ID`, `NAME`, `REMARKS`) VALUES
	('1', '暂存', '暂存目的'),
	('10', '清洁检验', '清洁检验'),
	('11', '年检检验', '年检检验'),
	('2', '清洗', '清洗'),
	('3', '修理', '修理'),
	('4', '改装', '改装'),
	('5', '加热', '加热'),
	('6', '翻新', '翻新'),
	('7', '充氮 ', '充氮'),
	('8', '实验测试', '实验测试'),
	('9', '估价', '估价');
/*!40000 ALTER TABLE `approach_aim` ENABLE KEYS */;


-- 导出  表 jeesite.approach_aim_task 结构
DROP TABLE IF EXISTS `approach_aim_task`;
CREATE TABLE IF NOT EXISTS `approach_aim_task` (
  `APPROACH_AIM_ID` varchar(64) NOT NULL,
  `TASK_ID` varchar(64) NOT NULL,
  KEY `FK1FEDAEF6A3B2685E` (`TASK_ID`),
  KEY `FK1FEDAEF6ED4BD205` (`APPROACH_AIM_ID`),
  CONSTRAINT `FK1FEDAEF6A3B2685E` FOREIGN KEY (`TASK_ID`) REFERENCES `task` (`ID`),
  CONSTRAINT `FK1FEDAEF6ED4BD205` FOREIGN KEY (`APPROACH_AIM_ID`) REFERENCES `approach_aim` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务进场目的关联表';

-- 正在导出表  jeesite.approach_aim_task 的数据：~12 rows (大约)
/*!40000 ALTER TABLE `approach_aim_task` DISABLE KEYS */;
INSERT INTO `approach_aim_task` (`APPROACH_AIM_ID`, `TASK_ID`) VALUES
	('1', '1'),
	('1', '2'),
	('2', '3'),
	('3', '4'),
	('4', '5'),
	('5', '6'),
	('6', '7'),
	('7', '8'),
	('8', '9'),
	('9', '10'),
	('10', '11'),
	('11', '12');
/*!40000 ALTER TABLE `approach_aim_task` ENABLE KEYS */;


-- 导出  表 jeesite.approach_examination 结构
DROP TABLE IF EXISTS `approach_examination`;
CREATE TABLE IF NOT EXISTS `approach_examination` (
  `ID` varchar(64) NOT NULL,
  `PRO_ORDER_RECORDER_ID` varchar(64) DEFAULT NULL,
  `TANK_ID` varchar(64) NOT NULL,
  `AIR_VALVE_TYPE` varchar(32) DEFAULT NULL,
  `TOP_VALVE_TYPE` varchar(32) DEFAULT NULL,
  `HAVE_SAFETY_VALVE` char(4) DEFAULT NULL,
  `HAVE_ELECTRIC_HEAT` char(4) DEFAULT NULL,
  `HAVE_PRESSURE_GAUGE` char(4) DEFAULT NULL,
  `HAVE_THERMOMTER` char(4) DEFAULT NULL,
  `ACCESSORIES_COMMENTS` text,
  `TANK_LEFT_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_RIGHT_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_TOP_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_BOTTOM_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_FRONT_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_BACK_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_ENTRY_HOLE_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_AIR_VALVE_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_BOTTOM_VALVE_PICTURE` varchar(255) DEFAULT NULL,
  `DELIVERY_PICTURE` varchar(255) DEFAULT NULL,
  `DAMAGE_PICTURE_PACKAGE` text,
  `PICTURE_COMMENTS` text,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `SYS_USER_ID` varchar(64) NOT NULL,
  `EXAMINE_RESULT` varchar(255) DEFAULT NULL,
  `IS_DAMAGED` char(2) DEFAULT '0',
  `HAVE_NOTIFIED_CLIENT` char(2) DEFAULT '0',
  `NOTIFIED_CLIENT_TIME` timestamp NULL DEFAULT NULL,
  `CLIENT_COMMENTS` varchar(255) DEFAULT NULL,
  `IS_PROCESS_SETTED` char(2) DEFAULT NULL,
  `PROCESS_SETTED_TIME` timestamp NULL DEFAULT NULL,
  `REMARKS` text,
  `AIR_VALUE_TYPE` varchar(255) DEFAULT NULL,
  `PHOTO_COMMENTS` varchar(255) DEFAULT NULL,
  `HAVE_SAFETY_VALUE` int(11) DEFAULT NULL,
  `TOP_VALUE_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_bt59kphy0jhjjunero9jn0rqh` (`PRO_ORDER_RECORDER_ID`),
  KEY `FK_cutwl7rnu74vlvjq5364f2q0j` (`TANK_ID`),
  KEY `FK_8a16aphaaxc471klk7fafauy0` (`SYS_USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='进场箱检';

-- 正在导出表  jeesite.approach_examination 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `approach_examination` DISABLE KEYS */;
INSERT INTO `approach_examination` (`ID`, `PRO_ORDER_RECORDER_ID`, `TANK_ID`, `AIR_VALVE_TYPE`, `TOP_VALVE_TYPE`, `HAVE_SAFETY_VALVE`, `HAVE_ELECTRIC_HEAT`, `HAVE_PRESSURE_GAUGE`, `HAVE_THERMOMTER`, `ACCESSORIES_COMMENTS`, `TANK_LEFT_PICTURE`, `TANK_RIGHT_PICTURE`, `TANK_TOP_PICTURE`, `TANK_BOTTOM_PICTURE`, `TANK_FRONT_PICTURE`, `TANK_BACK_PICTURE`, `TANK_ENTRY_HOLE_PICTURE`, `TANK_AIR_VALVE_PICTURE`, `TANK_BOTTOM_VALVE_PICTURE`, `DELIVERY_PICTURE`, `DAMAGE_PICTURE_PACKAGE`, `PICTURE_COMMENTS`, `CREATED_TIME`, `SYS_USER_ID`, `EXAMINE_RESULT`, `IS_DAMAGED`, `HAVE_NOTIFIED_CLIENT`, `NOTIFIED_CLIENT_TIME`, `CLIENT_COMMENTS`, `IS_PROCESS_SETTED`, `PROCESS_SETTED_TIME`, `REMARKS`, `AIR_VALUE_TYPE`, `PHOTO_COMMENTS`, `HAVE_SAFETY_VALUE`, `TOP_VALUE_TYPE`) VALUES
	('0dd8d5acb304431a92b205086b16bcd3', 'dd0023a2f96048389bf16cb6426ab81d', '59b949cce29140c193082a2222e34f2f', '0', '0', '1', '1', '1', '1', '', '/upload/SNTU7402890/approachexamine/20150228/产品模型.png', '/upload/SNTU7402890/approachexamine/20150228/系统.png', '/upload/SNTU7402890/approachexamine/20150228/客户管理.png', '/upload/SNTU7402890/approachexamine/20150228/技术.bmp', '', '', '', '', '', '/upload/SNTU7402890/approachexamine/20150228/进出场管理.png', '/upload/SNTU7402890/approachexamine/20150228/技术.bmp,/upload/SNTU7402890/approachexamine/20150228/公司管理.png,', NULL, '2015-02-28 00:00:00', '1', NULL, '1', NULL, NULL, NULL, '1', '2015-02-28 17:54:38', '', '0', NULL, 1, '0'),
	('185dd3af76514b30abf082c0f818a6ec', '9b7e0146bafd410d936acc7ac7e77c7d', '09ac9ee28ea2408088c4c4dc15cf6cff', '0', '0', '1', '1', '1', '1', '配件信息说明', '', '', '', '', '', '', '', '', '', '/upload/FOTU1250423/approachexamine/20150228/delivery.jpg', '', NULL, '2015-02-28 00:00:00', '1', NULL, NULL, NULL, NULL, NULL, '1', '2015-02-28 14:42:50', '无破损信息', NULL, NULL, NULL, NULL),
	('794bb60091b44554b37b3f442de697b0', '3fe043aab9e040fd914f2841ba27d286', 'ca35d1c6e1894455b0bf9eab99a79c56', NULL, NULL, NULL, '0', '1', '1', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2015-02-28 14:17:11', '1', NULL, '0', '0', NULL, NULL, '1', '2015-02-28 14:18:34', '无损', '0', '', 0, '0'),
	('9ed98fd2497a4435b638b2462f7bf44f', '2ae0500e278842c782f022328d2e483e', '59b949cce29140c193082a2222e34f2f', '0', '0', '1', '1', '1', '1', '', '', '', '', '', '', '', '', '', '', '', '', NULL, '2015-02-28 00:00:00', '1', NULL, NULL, NULL, NULL, NULL, '1', '2015-02-28 16:54:56', '无破损', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `approach_examination` ENABLE KEYS */;


-- 导出  表 jeesite.charge_detail 结构
DROP TABLE IF EXISTS `charge_detail`;
CREATE TABLE IF NOT EXISTS `charge_detail` (
  `ID` varchar(64) NOT NULL,
  `CHARGE_INFO_ID` varchar(64) DEFAULT NULL,
  `PROCESS_ID` varchar(64) DEFAULT NULL,
  `CHARGE_NAME` varchar(255) DEFAULT NULL,
  `CHARGE_PRICE` int(11) DEFAULT NULL,
  `CURRENCY_TYPE` char(4) DEFAULT NULL,
  `RECORD_USER_ID` varchar(64) DEFAULT NULL,
  `RECORD_TIME` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `UPDATE_USER_ID` varchar(64) DEFAULT NULL,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  `REMARKS` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收费明细';

-- 正在导出表  jeesite.charge_detail 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `charge_detail` DISABLE KEYS */;
INSERT INTO `charge_detail` (`ID`, `CHARGE_INFO_ID`, `PROCESS_ID`, `CHARGE_NAME`, `CHARGE_PRICE`, `CURRENCY_TYPE`, `RECORD_USER_ID`, `RECORD_TIME`, `UPDATE_USER_ID`, `UPDATE_TIME`, `REMARKS`) VALUES
	('526d9c08491f4c68803d52b00561c271', '41611b831a6e4068bb9d6fe777faeb80', '770db676539e456982f87b8fbe51dd47', '翻新费', 125, '0', '1', '2015-02-28 14:32:30', NULL, NULL, NULL),
	('a9531950563e4047b14723fb36fbc193', '41611b831a6e4068bb9d6fe777faeb80', 'da5a1ac1b4b3449bbb9be8e7fa4530d0', '清洗费', 500, '0', '1', '2015-02-28 14:32:30', NULL, NULL, NULL),
	('aed903bb2bb84ee69c3369e3d6f5846d', '41611b831a6e4068bb9d6fe777faeb80', '43ba8af51af34b89b246e15c150f578d', '堆存费', 0, '0', '1', '2015-02-28 14:32:30', NULL, NULL, NULL),
	('e675e971d8794b5b868a4c5c852c182f', '41611b831a6e4068bb9d6fe777faeb80', 'e9c86a3173894e0093c6d17f2a1db889', '修理费', 1000, '0', '1', '2015-02-28 14:32:30', NULL, NULL, NULL);
/*!40000 ALTER TABLE `charge_detail` ENABLE KEYS */;


-- 导出  表 jeesite.charge_info 结构
DROP TABLE IF EXISTS `charge_info`;
CREATE TABLE IF NOT EXISTS `charge_info` (
  `ID` varchar(64) NOT NULL,
  `CLIENT_ID` varchar(64) DEFAULT NULL,
  `PRO_ORDER_RECORDER_ID` varchar(64) DEFAULT NULL,
  `PROCESS_IVENTORY_ID` varchar(64) DEFAULT NULL,
  `TANK_ID` varchar(64) DEFAULT NULL,
  `TOTAL_RMB_PRICE` int(11) DEFAULT NULL,
  `TOTAL_USD_PRICE` int(11) DEFAULT NULL,
  `TOTAL_PRICE` int(11) DEFAULT NULL,
  `IS_SUBMITTED` char(4) DEFAULT '0',
  `SUBMIT_TIME` timestamp NULL DEFAULT NULL,
  `SUBMIT_USER_ID` varchar(64) DEFAULT NULL,
  `REMARKS` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='收费信息';

-- 正在导出表  jeesite.charge_info 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `charge_info` DISABLE KEYS */;
INSERT INTO `charge_info` (`ID`, `CLIENT_ID`, `PRO_ORDER_RECORDER_ID`, `PROCESS_IVENTORY_ID`, `TANK_ID`, `TOTAL_RMB_PRICE`, `TOTAL_USD_PRICE`, `TOTAL_PRICE`, `IS_SUBMITTED`, `SUBMIT_TIME`, `SUBMIT_USER_ID`, `REMARKS`) VALUES
	('41611b831a6e4068bb9d6fe777faeb80', '003edba645ef4efc82b93ffcec0a0510', '3fe043aab9e040fd914f2841ba27d286', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 1625, 0, 1625, '0', NULL, NULL, NULL);
/*!40000 ALTER TABLE `charge_info` ENABLE KEYS */;


-- 导出  表 jeesite.client_base_info 结构
DROP TABLE IF EXISTS `client_base_info`;
CREATE TABLE IF NOT EXISTS `client_base_info` (
  `ID` varchar(64) NOT NULL,
  `COMPANY_CHINESE_NAME` varchar(100) NOT NULL,
  `COMPANY_ENGLISH_NAME` varchar(100) DEFAULT NULL,
  `COMPANY_SHORT_NAME` varchar(50) DEFAULT NULL,
  `TELEPHONE` varchar(50) DEFAULT NULL,
  `FAX` varchar(50) DEFAULT NULL,
  `ADDRESS` varchar(255) DEFAULT NULL,
  `EMAIL` varchar(50) DEFAULT NULL,
  `WEBSITE` varchar(100) DEFAULT NULL,
  `CONTACT_PERSON_ID` varchar(64) DEFAULT NULL,
  `LOGO_URL` varchar(100) DEFAULT NULL,
  `DEL_FLAG` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户公司基本信息';

-- 正在导出表  jeesite.client_base_info 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `client_base_info` DISABLE KEYS */;
INSERT INTO `client_base_info` (`ID`, `COMPANY_CHINESE_NAME`, `COMPANY_ENGLISH_NAME`, `COMPANY_SHORT_NAME`, `TELEPHONE`, `FAX`, `ADDRESS`, `EMAIL`, `WEBSITE`, `CONTACT_PERSON_ID`, `LOGO_URL`, `DEL_FLAG`) VALUES
	('003edba645ef4efc82b93ffcec0a0510', '宁波远洋', 'NBWY', 'NBWY', '0574-23456712', '0574-23456712', '宁波市江东区创业大厦504', 'service@nvwy.com', 'http://www.nbyunyang.net', '', '', '0'),
	('20fb04e84e604b0dab50f0425058264e', '宁波远东', 'NBWD', 'NBWD', '0574-88725632', '0574-88725631', '宁波市鄞州区科技大厦5号', 'service@nbwd.com', 'http://www.nbwd.com/', '', '/upload/logo.jpg', '0');
/*!40000 ALTER TABLE `client_base_info` ENABLE KEYS */;


-- 导出  表 jeesite.client_employee 结构
DROP TABLE IF EXISTS `client_employee`;
CREATE TABLE IF NOT EXISTS `client_employee` (
  `ID` varchar(64) NOT NULL,
  `CLIENT_ID` varchar(64) NOT NULL,
  `CHINESE_NAME` varchar(50) DEFAULT NULL,
  `ENGLISH_NAME` varchar(50) DEFAULT NULL,
  `POSITION` varchar(32) DEFAULT NULL,
  `EMAIL` varchar(64) DEFAULT NULL,
  `TELEPHONE` varchar(32) DEFAULT NULL,
  `FAX` varchar(32) DEFAULT NULL,
  `MOBILEPHONE` varchar(32) DEFAULT NULL,
  `QQ_NUM` varchar(32) DEFAULT NULL,
  `PHOTO_URL` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `DEL_FLAG` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FKDE5338A2DF19360A` (`CLIENT_ID`),
  CONSTRAINT `FKDE5338A2DF19360A` FOREIGN KEY (`CLIENT_ID`) REFERENCES `client_base_info` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户公司员工';

-- 正在导出表  jeesite.client_employee 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `client_employee` DISABLE KEYS */;
INSERT INTO `client_employee` (`ID`, `CLIENT_ID`, `CHINESE_NAME`, `ENGLISH_NAME`, `POSITION`, `EMAIL`, `TELEPHONE`, `FAX`, `MOBILEPHONE`, `QQ_NUM`, `PHOTO_URL`, `DESCRIPTION`, `DEL_FLAG`) VALUES
	('4627b4b00eb14619bcd31c2280d9cbad', '20fb04e84e604b0dab50f0425058264e', 'Test', '1231', '1321', '12312', '12323', '123123', '12321', '12321', '', '12321', NULL),
	('8bbbdecdec984436a4388ca7d46452f1', '20fb04e84e604b0dab50f0425058264e', '俞超', 'Jack', '开发', 'chaochaoyuyu@126.com', '87786532', '87786534', '12456731234', '1792671212', '', '俞超的测试描述信息', NULL),
	('b47cf62101ff4db8885364c9236a67cf', '003edba645ef4efc82b93ffcec0a0510', '俞超', 'Jack', '客服经理', 'chaochaoyuyu@126.com', '0574-88725632', '0574-23456712', '18367451211', '1891232123123', '', '测试', NULL);
/*!40000 ALTER TABLE `client_employee` ENABLE KEYS */;


-- 导出  表 jeesite.client_finance_info 结构
DROP TABLE IF EXISTS `client_finance_info`;
CREATE TABLE IF NOT EXISTS `client_finance_info` (
  `ID` varchar(64) NOT NULL,
  `CLIENT_ID` varchar(64) NOT NULL,
  `DOMESTIC_INVOICE_TITLE` varchar(255) DEFAULT NULL,
  `DOMESTIC_TAX_NUM` varchar(100) DEFAULT NULL,
  `DOMESTIC_ADDRESS` varchar(255) DEFAULT NULL,
  `DOMESTIC_RECEIPT_ID` varchar(64) DEFAULT NULL,
  `DOMESTIC_ORGANIZTION_CODE` varchar(255) DEFAULT NULL,
  `DOMESTIC_BUSSINESS_LICENCE` varchar(255) DEFAULT NULL,
  `DOMESTIC_TAX_REGISTER_LICENCE` varchar(255) DEFAULT NULL,
  `OVERSEA_INVOICE_TITLE` varchar(255) DEFAULT NULL,
  `PROFORMA_INVOICE_TITLE` varchar(255) DEFAULT NULL,
  `PROFORMA_INVOICE_ADDRESS` varchar(255) DEFAULT NULL,
  `PROFORMA_INVOICE_RECEIPT_ID` varchar(64) DEFAULT NULL,
  `DEL_FLAG` char(1) DEFAULT '0',
  `REMARKS` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK13AFDDE7DF19360A` (`CLIENT_ID`),
  KEY `FK13AFDDE74B27FA0C` (`DOMESTIC_RECEIPT_ID`),
  KEY `FK13AFDDE7276E27AC` (`PROFORMA_INVOICE_RECEIPT_ID`),
  CONSTRAINT `FK13AFDDE7276E27AC` FOREIGN KEY (`PROFORMA_INVOICE_RECEIPT_ID`) REFERENCES `client_employee` (`ID`),
  CONSTRAINT `FK13AFDDE74B27FA0C` FOREIGN KEY (`DOMESTIC_RECEIPT_ID`) REFERENCES `client_employee` (`ID`),
  CONSTRAINT `FK13AFDDE7DF19360A` FOREIGN KEY (`CLIENT_ID`) REFERENCES `client_base_info` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户公司财务信息';

-- 正在导出表  jeesite.client_finance_info 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `client_finance_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_finance_info` ENABLE KEYS */;


-- 导出  表 jeesite.client_report_template 结构
DROP TABLE IF EXISTS `client_report_template`;
CREATE TABLE IF NOT EXISTS `client_report_template` (
  `ID` varchar(64) NOT NULL,
  `CLIENT_ID` varchar(64) NOT NULL,
  `DAILY_DISPLAY_FIELDS` text,
  `DAILY_SEND_USER_IDS` text,
  `IS_DAILY_SEND` char(1) DEFAULT '0',
  `DAILY_SEND_TIME` time DEFAULT NULL,
  `DAILY_REPORT_TEMPLATE_URL` varchar(255) DEFAULT NULL,
  `ESTIMATE_REPORT_TEMPLATE_URL` varchar(255) DEFAULT NULL,
  `ESTIMATE_SEND_USER_IDS` text,
  `MONTHLY_REPORT_USER_IDS` text,
  `MONTHLY_REPORT_TEMPLATE_URL` text,
  `DEL_FLAG` char(1) DEFAULT '0',
  `REMARKS` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户公司报表模块';

-- 正在导出表  jeesite.client_report_template 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `client_report_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `client_report_template` ENABLE KEYS */;


-- 导出  表 jeesite.comment 结构
DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `ID` varchar(64) NOT NULL,
  `PROCESS_ID` varchar(64) DEFAULT NULL,
  `CONTENT` text,
  `GENERATE_USER_ID` varchar(64) DEFAULT NULL,
  `GENERATE_TIME` timestamp NULL DEFAULT NULL,
  `REMARKS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论表';

-- 正在导出表  jeesite.comment 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` (`ID`, `PROCESS_ID`, `CONTENT`, `GENERATE_USER_ID`, `GENERATE_TIME`, `REMARKS`) VALUES
	('0605cd4d155641e595e0cff4a862f016', 'baad919377c64cabb0ba49ace948b5a8', '123123213', '1', '2015-02-28 16:21:19', NULL),
	('868780e7ece04b4b8c95d808b2ddd959', '4fe4b2f071ce4c67b4dfbf99090d8128', '评论内容~~', '1', '2015-02-28 14:43:41', NULL),
	('b9fb396a32844bf1b356eb1306e7bc94', 'baad919377c64cabb0ba49ace948b5a8', '评论评论', '1', '2015-02-28 16:21:12', NULL),
	('eed20eb3b5ba480097c79ecaddcc0712', '4fe4b2f071ce4c67b4dfbf99090d8128', '点击发表评论12312', '1', '2015-02-28 14:44:34', NULL);
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;


-- 导出  表 jeesite.comment_affix 结构
DROP TABLE IF EXISTS `comment_affix`;
CREATE TABLE IF NOT EXISTS `comment_affix` (
  `ID` varchar(64) NOT NULL,
  `COMMENT_ID` varchar(64) DEFAULT NULL,
  `AFFIX_NAME` varchar(1024) DEFAULT NULL,
  `AFFIX_URL` varchar(2048) DEFAULT NULL,
  `TYPE` char(16) DEFAULT NULL,
  `ICON` varchar(32) DEFAULT NULL,
  `GENERATE_TIME` timestamp NULL DEFAULT NULL,
  `SYS_USER__ID` varchar(64) DEFAULT NULL,
  `REMARKS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='评论附件';

-- 正在导出表  jeesite.comment_affix 的数据：~9 rows (大约)
/*!40000 ALTER TABLE `comment_affix` DISABLE KEYS */;
INSERT INTO `comment_affix` (`ID`, `COMMENT_ID`, `AFFIX_NAME`, `AFFIX_URL`, `TYPE`, `ICON`, `GENERATE_TIME`, `SYS_USER__ID`, `REMARKS`) VALUES
	('09ab5283e9d044d0a342305cfb12a22b', 'b9fb396a32844bf1b356eb1306e7bc94', '动作统计.sql', '/upload/SNTU7402890/comments/20150228/动作统计.sql', 'others', NULL, '2015-02-28 16:21:12', '1', NULL),
	('1581fa7935404085856436c049702673', 'eed20eb3b5ba480097c79ecaddcc0712', '新建 Microsoft Excel 工作表.xls', '/upload/FOTU1250423/comments/20150228/新建 Microsoft Excel 工作表.xls', 'xls', NULL, '2015-02-28 14:44:34', '1', NULL),
	('43e6022c314f44e494cb019d7f14f597', 'b9fb396a32844bf1b356eb1306e7bc94', 'tank006.jpg', '/upload/SNTU7402890/comments/20150228/tank006.jpg', 'jpg', NULL, '2015-02-28 16:21:12', '1', NULL),
	('52b8fe5d86e540a191b302d072b015b1', '0605cd4d155641e595e0cff4a862f016', 'tank008.jpg', '/upload/SNTU7402890/comments/20150228/tank008.jpg', 'jpg', NULL, '2015-02-28 16:21:19', '1', NULL),
	('8b1fbcca67394740b80d517a8d0faa43', '868780e7ece04b4b8c95d808b2ddd959', 'delivery.jpg', '/upload/FOTU1250423/comments/20150228/delivery.jpg', 'jpg', NULL, '2015-02-28 14:43:41', '1', NULL),
	('8bea7352d8644ab9aa8e816cdb079f5c', '868780e7ece04b4b8c95d808b2ddd959', 'tank002.png', '/upload/FOTU1250423/comments/20150228/tank002.png', 'png', NULL, '2015-02-28 14:43:41', '1', NULL),
	('b23d2fdd6c9f4b5d8f31d04722c922e2', 'eed20eb3b5ba480097c79ecaddcc0712', 'USP_POWER.txt', '/upload/FOTU1250423/comments/20150228/USP_POWER.txt', 'txt', NULL, '2015-02-28 14:44:34', '1', NULL),
	('d95c0e3e876b4cb89f68ac545ec02f1f', '868780e7ece04b4b8c95d808b2ddd959', 'tank.jpg', '/upload/FOTU1250423/comments/20150228/tank.jpg', 'jpg', NULL, '2015-02-28 14:43:41', '1', NULL),
	('e13adfd280d1452c8140b84fa6b4e074', 'b9fb396a32844bf1b356eb1306e7bc94', 'tank005.jpg', '/upload/SNTU7402890/comments/20150228/tank005.jpg', 'jpg', NULL, '2015-02-28 16:21:12', '1', NULL);
/*!40000 ALTER TABLE `comment_affix` ENABLE KEYS */;


-- 导出  表 jeesite.company_charge_info 结构
DROP TABLE IF EXISTS `company_charge_info`;
CREATE TABLE IF NOT EXISTS `company_charge_info` (
  `id` varchar(64) NOT NULL,
  `company_id` varchar(64) DEFAULT NULL,
  `charge_name` varchar(100) DEFAULT NULL,
  `charge_short_name` varchar(32) DEFAULT NULL,
  `task_id` varchar(64) DEFAULT NULL,
  `unit_price` int(11) DEFAULT NULL,
  `charge_unit` varchar(32) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_by` varchar(64) DEFAULT NULL,
  `update_by` varchar(64) DEFAULT NULL,
  `del_flag` varchar(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `remarks` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKB976529749B6237A` (`update_by`),
  KEY `FKB97652979976E67B` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司收费标准表';

-- 正在导出表  jeesite.company_charge_info 的数据：~12 rows (大约)
/*!40000 ALTER TABLE `company_charge_info` DISABLE KEYS */;
INSERT INTO `company_charge_info` (`id`, `company_id`, `charge_name`, `charge_short_name`, `task_id`, `unit_price`, `charge_unit`, `create_date`, `update_date`, `create_by`, `update_by`, `del_flag`, `description`, `remarks`) VALUES
	('0962a45bc75e423ebccc97e1a1b29ce5', '1', '实验测试费', 'SYCXF', NULL, 300, '次', '2015-01-19 20:59:52', '2015-01-19 20:59:52', '1', '1', '0', '实验测试费描述信息', '实验测试费备注信息'),
	('15cacdd725494df3b2f616b0d43c0174', '1', '年检检验费', 'NJJYF', NULL, 800, '次', '2015-01-19 20:55:43', '2015-01-19 20:55:43', '1', '1', '0', '年检检验费描述信息', '年检检验费备注信息'),
	('64fdbbc9da764d29901a3ffb6cf492f1', '1', '应急维修费', 'YJWXF', NULL, 800, '次', '2015-02-28 09:49:14', '2015-02-28 09:49:23', '1', '1', '0', '应急维修费用', '应急维修费用'),
	('71337c502b9e4a419e2cee02faec42e3', '1', '修理费', 'XLF', NULL, 1000, '次', '2015-01-17 15:22:56', '2015-01-17 15:22:56', '1', '1', '0', '修理费描述', '备注信息'),
	('71ed95ada1734795b2602f447e722d4e', '1', '清洗费', 'QXF', NULL, 500, '次', '2015-01-17 15:21:39', '2015-01-17 15:22:15', '1', '1', '0', '清洗费描述信息', '备注信息'),
	('7351d7165e8b4e07b4bd541f6bd05f46', '1', '清洁检验费', 'QJJYF', NULL, 1000, '次', '2015-01-19 20:54:29', '2015-01-19 20:54:29', '1', '1', '0', '清洁检验费描述信息', '清洁检验费备注'),
	('9c70b17e906c4aa493e3d7bc67fea221', '1', '估价费', 'GJF', NULL, 500, '次', '2015-01-19 20:55:04', '2015-01-19 20:55:04', '1', '1', '0', '估价费描述', '估价费备注'),
	('a9e52243fd924cdbb3eed0ea288abef8', '1', '改装费', 'GZF', NULL, 500, '次', '2015-01-19 20:57:38', '2015-01-19 20:57:38', '1', '1', '0', '改装费描述信息', '改装费备注信息'),
	('b75336fc14684c2db530249f5e60cfa5', '1', '翻新费', 'FXF', NULL, 125, '次', '2015-01-19 20:58:40', '2015-01-19 20:58:40', '1', '1', '0', '翻新费描述信息', '翻新费备注信息'),
	('b903a42e6c314c2c860247d2db34beb9', '1', '充氮费', 'CDF', NULL, 250, '次', '2015-01-19 20:59:20', '2015-01-19 20:59:20', '1', '1', '0', '充氮费描述信息', '充氮费备注信息'),
	('bdf80af3fc7f4a5e9fc9eaa30e19a566', '1', '堆存费', 'DCF', NULL, 100, '天', '2015-01-13 12:52:25', '2015-01-17 15:22:04', '1', '1', '0', '堆存费描述信息', '备注信息'),
	('be57475bd227402ea94dae9fe6fb2150', '1', '加热费', 'JLF', NULL, 400, '次', '2015-01-19 20:58:09', '2015-01-19 20:58:09', '1', '1', '0', '加热费描述信息', '加热费备注信息');
/*!40000 ALTER TABLE `company_charge_info` ENABLE KEYS */;


-- 导出  表 jeesite.company_finance_info 结构
DROP TABLE IF EXISTS `company_finance_info`;
CREATE TABLE IF NOT EXISTS `company_finance_info` (
  `ID` varchar(64) NOT NULL,
  `COMPANY_ID` varchar(64) DEFAULT NULL,
  `RMB_ACCOUNT` varchar(255) DEFAULT NULL,
  `RMB_DEPOSIT_BANK` varchar(255) DEFAULT NULL,
  `USD_ACCOUNT` varchar(255) DEFAULT NULL,
  `USD_DEPOSIT_BANK` varchar(255) DEFAULT NULL,
  `TAX_NUM` varchar(45) DEFAULT NULL,
  `ORGANIZATION_CODE` varchar(100) DEFAULT NULL,
  `FINANCE_CONTACT_USER_ID` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK2786C675D1FED678` (`FINANCE_CONTACT_USER_ID`),
  KEY `FK2786C6759976E67B` (`COMPANY_ID`),
  CONSTRAINT `FK2786C6759976E67B` FOREIGN KEY (`COMPANY_ID`) REFERENCES `sys_office` (`id`),
  CONSTRAINT `FK2786C675D1FED678` FOREIGN KEY (`FINANCE_CONTACT_USER_ID`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司财务信息';

-- 正在导出表  jeesite.company_finance_info 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `company_finance_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_finance_info` ENABLE KEYS */;


-- 导出  表 jeesite.depart_examination 结构
DROP TABLE IF EXISTS `depart_examination`;
CREATE TABLE IF NOT EXISTS `depart_examination` (
  `ID` varchar(64) NOT NULL,
  `PRO_ORDER_RECORDER_ID` varchar(64) DEFAULT NULL,
  `APPROACH_EXAMINATION_ID` varchar(64) DEFAULT NULL,
  `PROCESS_IVENTORY_ID` varchar(64) DEFAULT NULL,
  `DEPART_PROCESS_ID` varchar(64) DEFAULT NULL,
  `TANK_ID` varchar(64) DEFAULT NULL,
  `AIR_VALVE_TYPE` varchar(32) DEFAULT NULL,
  `TOP_VALVE_TYPE` varchar(32) DEFAULT NULL,
  `HAVE_SAFETY_VALVE` char(4) DEFAULT NULL,
  `HAVE_ELECTRIC_HEAT` char(4) DEFAULT NULL,
  `HAVE_PRESSURE_GAUGE` char(4) DEFAULT NULL,
  `HAVE_THERMOMTER` char(4) DEFAULT NULL,
  `ACCESSORIES_COMMENTS` text,
  `TANK_LEFT_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_RIGHT_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_TOP_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_BOTTOM_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_FRONT_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_BACK_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_ENTRY_HOLE_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_AIR_VALVE_PICTURE` varchar(255) DEFAULT NULL,
  `TANK_BOTTOM_VALVE_PICTURE` varchar(255) DEFAULT NULL,
  `DELIVERY_PICTURE` varchar(255) DEFAULT NULL,
  `DAMAGE_PICTURE_PACKAGE` text,
  `PICTURE_COMMENTS` text,
  `CREATED_TIME` timestamp NULL DEFAULT NULL,
  `SYS_USER_ID` varchar(64) DEFAULT NULL,
  `PLANNED_DEPART_TIME` timestamp NULL DEFAULT NULL,
  `IS_EXAMINED` char(2) DEFAULT '0',
  `EXAMINED_TIME` timestamp NULL DEFAULT NULL,
  `EXAMINE_RESULT` varchar(255) DEFAULT NULL,
  `IS_DAMAGED` char(2) DEFAULT '0',
  `HAVE_NOTIFIED_CLIENT` char(2) DEFAULT '0',
  `NOTIFIED_CLIENT_TIME` timestamp NULL DEFAULT NULL,
  `CLIENT_COMMENTS` varchar(255) DEFAULT NULL,
  `REMARKS` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='出场箱检';

-- 正在导出表  jeesite.depart_examination 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `depart_examination` DISABLE KEYS */;
INSERT INTO `depart_examination` (`ID`, `PRO_ORDER_RECORDER_ID`, `APPROACH_EXAMINATION_ID`, `PROCESS_IVENTORY_ID`, `DEPART_PROCESS_ID`, `TANK_ID`, `AIR_VALVE_TYPE`, `TOP_VALVE_TYPE`, `HAVE_SAFETY_VALVE`, `HAVE_ELECTRIC_HEAT`, `HAVE_PRESSURE_GAUGE`, `HAVE_THERMOMTER`, `ACCESSORIES_COMMENTS`, `TANK_LEFT_PICTURE`, `TANK_RIGHT_PICTURE`, `TANK_TOP_PICTURE`, `TANK_BOTTOM_PICTURE`, `TANK_FRONT_PICTURE`, `TANK_BACK_PICTURE`, `TANK_ENTRY_HOLE_PICTURE`, `TANK_AIR_VALVE_PICTURE`, `TANK_BOTTOM_VALVE_PICTURE`, `DELIVERY_PICTURE`, `DAMAGE_PICTURE_PACKAGE`, `PICTURE_COMMENTS`, `CREATED_TIME`, `SYS_USER_ID`, `PLANNED_DEPART_TIME`, `IS_EXAMINED`, `EXAMINED_TIME`, `EXAMINE_RESULT`, `IS_DAMAGED`, `HAVE_NOTIFIED_CLIENT`, `NOTIFIED_CLIENT_TIME`, `CLIENT_COMMENTS`, `REMARKS`) VALUES
	('3d12f61774fa43c6acf4474ed97b8c8b', NULL, NULL, 'ce64131134764cdcad342227e49c9515', '60720ccc57cf485e905c34e34003e78b', '09ac9ee28ea2408088c4c4dc15cf6cff', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2015-02-28 14:45:32', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('90817d7d83174a8d8d7fe6c89bbac1c7', NULL, NULL, '9141df78760c489398bdff6e4213bb6e', '3b864d4623af4346a5ed5b10740bfb26', '59b949cce29140c193082a2222e34f2f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2015-02-28 17:15:44', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('b65b51d4df4e4aa4a5baad1db600400c', NULL, NULL, '69acfb89f1264011a1d9a77964364473', '45fcfb4a0e184865aedf3b7c83b7a384', '59b949cce29140c193082a2222e34f2f', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2015-02-28 16:31:31', NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `depart_examination` ENABLE KEYS */;


-- 导出  表 jeesite.dynamic_message 结构
DROP TABLE IF EXISTS `dynamic_message`;
CREATE TABLE IF NOT EXISTS `dynamic_message` (
  `ID` varchar(64) NOT NULL,
  `FROM_USER_ID` varchar(64) DEFAULT NULL,
  `TO_USER_ID` varchar(64) DEFAULT NULL,
  `BUSSINESS_ID` varchar(64) DEFAULT NULL,
  `TYPE` char(4) DEFAULT '0',
  `ICON` varchar(64) DEFAULT '0',
  `MESSAGE_CONTENT` text,
  `GENERATE_TIME` timestamp NULL DEFAULT NULL,
  `IS_READED` char(4) DEFAULT '0',
  `READED_TIME` timestamp NULL DEFAULT NULL,
  `REMARKS` varchar(255) DEFAULT NULL,
  `target_id` varchar(255) DEFAULT NULL,
  `target_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_hlaodk6nk2o5dim9dnm9hvxu5` (`TO_USER_ID`),
  CONSTRAINT `FK_hlaodk6nk2o5dim9dnm9hvxu5` FOREIGN KEY (`TO_USER_ID`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='动态消息';

-- 正在导出表  jeesite.dynamic_message 的数据：~19 rows (大约)
/*!40000 ALTER TABLE `dynamic_message` DISABLE KEYS */;
INSERT INTO `dynamic_message` (`ID`, `FROM_USER_ID`, `TO_USER_ID`, `BUSSINESS_ID`, `TYPE`, `ICON`, `MESSAGE_CONTENT`, `GENERATE_TIME`, `IS_READED`, `READED_TIME`, `REMARKS`, `target_id`, `target_type`) VALUES
	('125c52b82aed4c0dbf4f967a59cbfccf', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '60720ccc57cf485e905c34e34003e78b', NULL, NULL, 'thinkgem分配出场任务给俞超 箱号 【FOTU1250423】', '2015-02-28 14:45:32', '0', NULL, NULL, NULL, NULL),
	('1e67497e02da4039a47aaee1fa8bbd8d', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '1', '4fe4b2f071ce4c67b4dfbf99090d8128', NULL, NULL, '俞超完成清洗任务 箱号 【FOTU1250423】', '2015-02-28 14:45:16', '0', NULL, NULL, NULL, NULL),
	('224864187b6d4ffea386f1c3f269be20', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '868780e7ece04b4b8c95d808b2ddd959', '1', NULL, 'thinkgem发表评论', '2015-02-28 14:43:41', '0', NULL, NULL, NULL, NULL),
	('2deb4b0c52c0463181f4428b03c80e83', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '1', '45fcfb4a0e184865aedf3b7c83b7a384', NULL, NULL, '俞超完成出场任务 箱号 【SNTU7402890】', '2015-02-28 16:31:34', '0', NULL, NULL, NULL, NULL),
	('3e6fde2e972a4d7cbeb8cd1594f17a87', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', 'a0a1e053a0f047309fcdd0438e0f79fe', NULL, NULL, 'thinkgem分配修理任务给俞超 箱号 【SNTU7402890】', '2015-02-28 16:31:22', '0', NULL, NULL, NULL, NULL),
	('405c86f8cdd0433296e93816d348f422', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '4fe4b2f071ce4c67b4dfbf99090d8128', NULL, NULL, 'thinkgem分配清洗任务给俞超 箱号 【FOTU1250423】', '2015-02-28 14:43:07', '0', NULL, NULL, NULL, NULL),
	('554bbd20f9f544a8807f173a33cae695', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', 'b9fb396a32844bf1b356eb1306e7bc94', '1', NULL, 'thinkgem发表评论', '2015-02-28 16:21:12', '0', NULL, NULL, NULL, NULL),
	('5a49c88d288c4cd58d342728d8898b8b', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '1', '0ddc9bcd30db467e84c1b186f736ea7c', NULL, NULL, '俞超完成估价任务 箱号 【SNTU7402890】', '2015-02-28 16:25:39', '0', NULL, NULL, NULL, NULL),
	('8477387470ca4ffb92f7f688fd72548d', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', 'baad919377c64cabb0ba49ace948b5a8', NULL, NULL, 'thinkgem分配清洗任务给俞超 箱号 【SNTU7402890】', '2015-02-28 16:20:36', '0', NULL, NULL, NULL, NULL),
	('8dedc1da10c34c9fa59a3a263beac6a0', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '1', 'baad919377c64cabb0ba49ace948b5a8', NULL, NULL, '俞超完成清洗任务 箱号 【SNTU7402890】', '2015-02-28 16:21:47', '0', NULL, NULL, NULL, NULL),
	('9ff94b9040c0473ea95ba779aafd86ac', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', 'e304aaea7258446db2a3608a005c641a', NULL, NULL, 'thinkgem分配估价任务给俞超 箱号 【FOTU1250423】', '2015-02-28 14:45:23', '0', NULL, NULL, NULL, NULL),
	('a6d8c1e901324b40a0e1eaee2b3d3fa5', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '1', 'e304aaea7258446db2a3608a005c641a', NULL, NULL, '俞超完成估价任务 箱号 【FOTU1250423】', '2015-02-28 14:45:25', '0', NULL, NULL, NULL, NULL),
	('b938e672b0024aaa9bfe9290aa2bf6f8', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', 'eed20eb3b5ba480097c79ecaddcc0712', '1', NULL, 'thinkgem发表评论', '2015-02-28 14:44:34', '0', NULL, NULL, NULL, NULL),
	('bbed97ab46ae4dccb515ce1f29322a9c', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '1', '60720ccc57cf485e905c34e34003e78b', NULL, NULL, '俞超完成出场任务 箱号 【FOTU1250423】', '2015-02-28 14:45:34', '0', NULL, NULL, NULL, NULL),
	('c5b4a2fa51ea413e91e1c937e2508df0', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '3b864d4623af4346a5ed5b10740bfb26', NULL, NULL, 'thinkgem分配出场任务给俞超 箱号 【SNTU7402890】', '2015-02-28 17:15:44', '0', NULL, NULL, NULL, NULL),
	('d0882c9ddff74db6a6de890581b0611c', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '0605cd4d155641e595e0cff4a862f016', '1', NULL, 'thinkgem发表评论', '2015-02-28 16:21:20', '0', NULL, NULL, NULL, NULL),
	('d0d37d7e002a4d7db881cff7ad08579b', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '45fcfb4a0e184865aedf3b7c83b7a384', NULL, NULL, 'thinkgem分配出场任务给俞超 箱号 【SNTU7402890】', '2015-02-28 16:31:31', '0', NULL, NULL, NULL, NULL),
	('d3b8b99e482741a5953876b12cc52faa', '1', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '0ddc9bcd30db467e84c1b186f736ea7c', NULL, NULL, 'thinkgem分配估价任务给俞超 箱号 【SNTU7402890】', '2015-02-28 16:24:03', '0', NULL, NULL, NULL, NULL),
	('e923464b1ca340dda650130b52da2da0', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '1', 'a0a1e053a0f047309fcdd0438e0f79fe', NULL, NULL, '俞超完成修理任务 箱号 【SNTU7402890】', '2015-02-28 16:31:25', '0', NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `dynamic_message` ENABLE KEYS */;


-- 导出  表 jeesite.emergency_maintenance 结构
DROP TABLE IF EXISTS `emergency_maintenance`;
CREATE TABLE IF NOT EXISTS `emergency_maintenance` (
  `ID` varchar(64) NOT NULL,
  `CLIENT_ID` varchar(64) DEFAULT NULL,
  `CLIENT_CONTACTER_ID` varchar(64) DEFAULT NULL,
  `TANK_ID` varchar(64) DEFAULT NULL,
  `TANK_CODE` varchar(255) DEFAULT NULL,
  `GENERATE_USER_ID` varchar(64) DEFAULT NULL,
  `GENERATE_TIME` timestamp NULL DEFAULT NULL,
  `ASSIGN_TO` varchar(64) DEFAULT NULL,
  `DEL_FLAG` char(1) DEFAULT '0',
  `REMARKS` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='应急维修';

-- 正在导出表  jeesite.emergency_maintenance 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `emergency_maintenance` DISABLE KEYS */;
/*!40000 ALTER TABLE `emergency_maintenance` ENABLE KEYS */;


-- 导出  表 jeesite.order_images 结构
DROP TABLE IF EXISTS `order_images`;
CREATE TABLE IF NOT EXISTS `order_images` (
  `id` varchar(255) NOT NULL,
  `created` datetime DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `orderExam_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rnrn6p966548cm8fl5bx3bn79` (`orderExam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 正在导出表  jeesite.order_images 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `order_images` DISABLE KEYS */;
INSERT INTO `order_images` (`id`, `created`, `path`, `type`, `orderExam_id`) VALUES
	('78d15fcccdb54b55923eb25dd5c7c890', '2015-02-28 16:52:47', 'public/uploads/2015-02/28/1425113567905.jpg', 'exam', '0dd8d5acb304431a92b205086b16bcd3'),
	('78fb17a85b134d5bb293c702585d5339', '2015-02-28 14:17:48', 'public/uploads/2015-02/28/1425104268619.jpg', 'exam', '794bb60091b44554b37b3f442de697b0'),
	('ac129377fc964b71a5d565513b1d7466', '2015-02-28 14:17:48', 'public/uploads/2015-02/28/1425104268544.jpg', 'exam', '794bb60091b44554b37b3f442de697b0');
/*!40000 ALTER TABLE `order_images` ENABLE KEYS */;


-- 导出  表 jeesite.pre_order_aim 结构
DROP TABLE IF EXISTS `pre_order_aim`;
CREATE TABLE IF NOT EXISTS `pre_order_aim` (
  `PRE_ORDER_RECORD_ID` varchar(64) NOT NULL,
  `APPROACH_AIM_ID` varchar(64) NOT NULL,
  KEY `FK_lu0vfc3v5vtt0u0n401iqmgjh` (`APPROACH_AIM_ID`),
  KEY `FK_77hgocebv4er9yfipcaojb78n` (`PRE_ORDER_RECORD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预录单进场目的关联表';

-- 正在导出表  jeesite.pre_order_aim 的数据：~8 rows (大约)
/*!40000 ALTER TABLE `pre_order_aim` DISABLE KEYS */;
INSERT INTO `pre_order_aim` (`PRE_ORDER_RECORD_ID`, `APPROACH_AIM_ID`) VALUES
	('3fe043aab9e040fd914f2841ba27d286', '1'),
	('3fe043aab9e040fd914f2841ba27d286', '2'),
	('9b7e0146bafd410d936acc7ac7e77c7d', '1'),
	('9b7e0146bafd410d936acc7ac7e77c7d', '2'),
	('dd0023a2f96048389bf16cb6426ab81d', '1'),
	('dd0023a2f96048389bf16cb6426ab81d', '2'),
	('2ae0500e278842c782f022328d2e483e', '1'),
	('2ae0500e278842c782f022328d2e483e', '2');
/*!40000 ALTER TABLE `pre_order_aim` ENABLE KEYS */;


-- 导出  表 jeesite.pre_order_record 结构
DROP TABLE IF EXISTS `pre_order_record`;
CREATE TABLE IF NOT EXISTS `pre_order_record` (
  `ID` varchar(64) NOT NULL,
  `ORDER_CODE` varchar(32) NOT NULL,
  `TANK_ID` varchar(64) NOT NULL,
  `CLIENT_ID` varchar(64) DEFAULT NULL,
  `CLIENT_CONTACTER_ID` varchar(64) DEFAULT NULL,
  `CLEAN_GOODS_ID` varchar(64) DEFAULT NULL,
  `EXPECTED_APPROACH_TIME` timestamp NULL DEFAULT NULL,
  `EXPECTED_DEPART_TIME` timestamp NULL DEFAULT NULL,
  `APPROACH_TIME` timestamp NULL DEFAULT NULL,
  `IS_APPROACH_EXAMINED` char(1) DEFAULT NULL,
  `DEPART_TIME` timestamp NULL DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT NULL,
  `CREATE_USER_ID` varchar(64) DEFAULT NULL,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  `UPDATE_USER_ID` varchar(64) DEFAULT NULL,
  `DEL_FLAG` char(1) NOT NULL DEFAULT '0',
  `REMARKS` varchar(64) DEFAULT NULL,
  `STEP` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_m6taxibe37fge7elh3k95xb2l` (`CLIENT_ID`),
  KEY `FK_77ueo1blx5g7gno1a45kthiob` (`CLEAN_GOODS_ID`),
  KEY `FK_7a5woy7nl2ohki2r9b0pfvk5s` (`TANK_ID`),
  KEY `FK_8a66ilioxu27ne5k04ima3kqb` (`CREATE_USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='预录单';

-- 正在导出表  jeesite.pre_order_record 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `pre_order_record` DISABLE KEYS */;
INSERT INTO `pre_order_record` (`ID`, `ORDER_CODE`, `TANK_ID`, `CLIENT_ID`, `CLIENT_CONTACTER_ID`, `CLEAN_GOODS_ID`, `EXPECTED_APPROACH_TIME`, `EXPECTED_DEPART_TIME`, `APPROACH_TIME`, `IS_APPROACH_EXAMINED`, `DEPART_TIME`, `CREATE_TIME`, `CREATE_USER_ID`, `UPDATE_TIME`, `UPDATE_USER_ID`, `DEL_FLAG`, `REMARKS`, `STEP`) VALUES
	('2ae0500e278842c782f022328d2e483e', '20150228160747', '59b949cce29140c193082a2222e34f2f', '20fb04e84e604b0dab50f0425058264e', '8bbbdecdec984436a4388ca7d46452f1', '9415b82bdfde410697d8253df4c721dc', '2015-03-02 00:00:00', NULL, '2015-02-28 16:14:10', '0', NULL, '2015-02-28 16:07:47', '1', NULL, NULL, '0', '', NULL),
	('3fe043aab9e040fd914f2841ba27d286', '20150228141712', 'ca35d1c6e1894455b0bf9eab99a79c56', '003edba645ef4efc82b93ffcec0a0510', 'b47cf62101ff4db8885364c9236a67cf', '9415b82bdfde410697d8253df4c721dc', '2015-03-01 00:00:00', NULL, '2015-02-28 14:17:48', '1', NULL, '2015-02-28 14:17:12', '1', NULL, NULL, '0', '第一个预录单', NULL),
	('9b7e0146bafd410d936acc7ac7e77c7d', '20150228143915', '09ac9ee28ea2408088c4c4dc15cf6cff', '20fb04e84e604b0dab50f0425058264e', '8bbbdecdec984436a4388ca7d46452f1', '9415b82bdfde410697d8253df4c721dc', '2015-03-02 00:00:00', NULL, '2015-02-28 14:40:35', '0', NULL, '2015-02-28 14:39:15', '1', NULL, NULL, '0', '', NULL),
	('dd0023a2f96048389bf16cb6426ab81d', '20150228160018', '59b949cce29140c193082a2222e34f2f', '003edba645ef4efc82b93ffcec0a0510', '8bbbdecdec984436a4388ca7d46452f1', 'f1ad14ed64d44a01bc3164446e3b6297', '2015-03-01 00:00:00', NULL, '2015-02-28 16:52:47', '1', NULL, '2015-02-28 16:00:18', '1', NULL, NULL, '0', '1242424', NULL);
/*!40000 ALTER TABLE `pre_order_record` ENABLE KEYS */;


-- 导出  表 jeesite.process 结构
DROP TABLE IF EXISTS `process`;
CREATE TABLE IF NOT EXISTS `process` (
  `ID` varchar(64) NOT NULL,
  `PROCESS_IVENTORY_ID` varchar(64) DEFAULT NULL,
  `NAME` varchar(64) DEFAULT NULL,
  `NEXT_PROCESS_ID` varchar(64) DEFAULT NULL,
  `SORT` int(11) DEFAULT '0',
  `CHARGE_INFO_ID` varchar(64) DEFAULT NULL,
  `GOODS_CLEAN_CHARGE` int(11) DEFAULT NULL,
  `OTHER_ADDITIONAL_CHARGE` int(11) DEFAULT NULL,
  `STATE` char(4) DEFAULT '0',
  `TASK_ID` varchar(64) DEFAULT NULL,
  `IS_VIRTUAL` char(2) DEFAULT '0',
  `START_TIME` timestamp NULL DEFAULT NULL,
  `START_USER_ID` varchar(64) DEFAULT NULL,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  `DEADLINE` timestamp NULL DEFAULT NULL,
  `END_TIME` timestamp NULL DEFAULT NULL,
  `END_USER_ID` varchar(64) DEFAULT NULL,
  `FINISHED_USER_ID` varchar(64) DEFAULT NULL,
  `AFFIX_FILES` text,
  `REMARKS` text,
  `WORKER_USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_6epdc64s68ewelv7s16xfa4a2` (`PROCESS_IVENTORY_ID`),
  KEY `FK_n8s0uxr9hoh9n0jab6xr58alu` (`START_USER_ID`),
  KEY `FK_n7poejinqfrltj2vhfh0wky5g` (`TASK_ID`),
  KEY `FK_7kg6914ryglaibaur22k1kt9g` (`WORKER_USER_ID`),
  KEY `FK_gcl1en8k7c95hxtgbmk1sp85x` (`END_USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程表';

-- 正在导出表  jeesite.process 的数据：~22 rows (大约)
/*!40000 ALTER TABLE `process` DISABLE KEYS */;
INSERT INTO `process` (`ID`, `PROCESS_IVENTORY_ID`, `NAME`, `NEXT_PROCESS_ID`, `SORT`, `CHARGE_INFO_ID`, `GOODS_CLEAN_CHARGE`, `OTHER_ADDITIONAL_CHARGE`, `STATE`, `TASK_ID`, `IS_VIRTUAL`, `START_TIME`, `START_USER_ID`, `UPDATE_TIME`, `DEADLINE`, `END_TIME`, `END_USER_ID`, `FINISHED_USER_ID`, `AFFIX_FILES`, `REMARKS`, `WORKER_USER_ID`) VALUES
	('010d821cf5664870aa1eae77e0161e05', '9141df78760c489398bdff6e4213bb6e', '翻新流程', '3b864d4623af4346a5ed5b10740bfb26', 4, 'b75336fc14684c2db530249f5e60cfa5', NULL, NULL, '2', '7', NULL, '2015-02-28 17:01:48', '1', '2015-02-28 17:04:35', '2015-02-26 00:00:00', '2015-02-28 17:04:35', '1', NULL, NULL, '', NULL),
	('047bbba9779f46e58e660808b9922038', '51b649b2687941a1bcdfc59ebba4900a', '清洗流程', '555a045f55fc4519b3c0a7a95f063b46', 2, '71ed95ada1734795b2602f447e722d4e', 100, 100, '0', '3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('055de8cfb49c40d9a39ea6871b0e6d58', '9141df78760c489398bdff6e4213bb6e', '进场流程', 'b6f826f3d51b47fabf498023cf86c912', 1, 'bdf80af3fc7f4a5e9fc9eaa30e19a566', NULL, NULL, '2', '1', NULL, '2015-02-28 00:00:00', NULL, NULL, NULL, '2015-02-28 16:54:56', '1', NULL, NULL, '无破损', NULL),
	('0ddc9bcd30db467e84c1b186f736ea7c', '69acfb89f1264011a1d9a77964364473', '估价流程', 'a0a1e053a0f047309fcdd0438e0f79fe', 3, '9c70b17e906c4aa493e3d7bc67fea221', NULL, NULL, '2', '10', NULL, '2015-02-28 16:24:03', '1', NULL, '2015-03-09 00:00:00', '2015-02-28 16:25:39', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, NULL, NULL),
	('13dad85ae92b47cd830d211963f437d8', '9141df78760c489398bdff6e4213bb6e', '修理流程', '010d821cf5664870aa1eae77e0161e05', 3, '71337c502b9e4a419e2cee02faec42e3', NULL, NULL, '2', '4', NULL, '2015-02-28 16:56:38', '1', '2015-02-28 16:57:15', '2015-03-28 00:00:00', '2015-02-28 16:57:15', '1', NULL, NULL, '', NULL),
	('3b864d4623af4346a5ed5b10740bfb26', '9141df78760c489398bdff6e4213bb6e', '出场流程', NULL, 5, NULL, NULL, NULL, '1', '2', NULL, '2015-02-28 17:15:44', '1', NULL, '2015-03-02 00:00:00', NULL, 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, NULL, NULL),
	('434bb9aac9554c5aaca30c8893d166bf', 'ce64131134764cdcad342227e49c9515', '进场流程', '4fe4b2f071ce4c67b4dfbf99090d8128', 1, 'bdf80af3fc7f4a5e9fc9eaa30e19a566', NULL, NULL, '2', '1', NULL, '2015-02-28 00:00:00', NULL, NULL, NULL, '2015-02-28 14:42:50', '1', NULL, NULL, '无破损信息', NULL),
	('43ba8af51af34b89b246e15c150f578d', 'b774dc68d6c449239fcd4f7ed4bbb2f5', '进场流程', 'da5a1ac1b4b3449bbb9be8e7fa4530d0', 1, 'bdf80af3fc7f4a5e9fc9eaa30e19a566', NULL, NULL, '2', '1', NULL, '2015-02-28 14:17:11', NULL, NULL, NULL, '2015-02-28 14:18:34', '1', NULL, NULL, '无损', NULL),
	('45fcfb4a0e184865aedf3b7c83b7a384', '69acfb89f1264011a1d9a77964364473', '出场流程', NULL, 5, NULL, NULL, NULL, '2', '2', NULL, '2015-02-28 16:31:31', '1', NULL, '2015-03-24 00:00:00', '2015-02-28 16:31:33', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, NULL, NULL),
	('4fe4b2f071ce4c67b4dfbf99090d8128', 'ce64131134764cdcad342227e49c9515', '清洗流程', 'e304aaea7258446db2a3608a005c641a', 2, '71ed95ada1734795b2602f447e722d4e', 0, 0, '2', '3', NULL, '2015-02-28 14:43:07', '1', NULL, '2015-03-09 00:00:00', '2015-02-28 14:45:16', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, NULL, NULL),
	('555a045f55fc4519b3c0a7a95f063b46', '51b649b2687941a1bcdfc59ebba4900a', '出场流程', NULL, 3, NULL, NULL, NULL, '0', '2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	('60720ccc57cf485e905c34e34003e78b', 'ce64131134764cdcad342227e49c9515', '出场流程', NULL, 4, NULL, NULL, NULL, '2', '2', NULL, '2015-02-28 14:45:32', '1', NULL, '2015-03-16 00:00:00', '2015-02-28 14:45:34', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, NULL, NULL),
	('770db676539e456982f87b8fbe51dd47', 'b774dc68d6c449239fcd4f7ed4bbb2f5', '翻新流程', '9242e92bdd124b248d1e1034eedd94bf', 4, 'b75336fc14684c2db530249f5e60cfa5', NULL, NULL, '2', '7', NULL, NULL, NULL, '2015-02-28 14:20:18', '2015-02-28 00:00:00', '2015-02-28 14:20:18', '1', NULL, NULL, '', NULL),
	('8c06e7891bac4f4ebd091a6831fae31c', '69acfb89f1264011a1d9a77964364473', '进场流程', 'baad919377c64cabb0ba49ace948b5a8', 1, 'bdf80af3fc7f4a5e9fc9eaa30e19a566', NULL, NULL, '2', '1', NULL, '2015-02-28 00:00:00', NULL, NULL, NULL, '2015-02-28 16:18:17', '1', NULL, NULL, '', NULL),
	('9242e92bdd124b248d1e1034eedd94bf', 'b774dc68d6c449239fcd4f7ed4bbb2f5', '出场流程', NULL, 5, NULL, NULL, NULL, '2', '2', NULL, NULL, NULL, '2015-02-28 14:20:43', '2015-02-28 00:00:00', '2015-02-28 14:20:43', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, '', NULL),
	('924500e96e354a1d819290f258d707d0', '51b649b2687941a1bcdfc59ebba4900a', '进场流程', '047bbba9779f46e58e660808b9922038', 1, 'bdf80af3fc7f4a5e9fc9eaa30e19a566', NULL, NULL, '2', '1', NULL, '2015-02-28 00:00:00', NULL, NULL, NULL, '2015-02-28 17:54:38', '1', NULL, NULL, '', NULL),
	('a0a1e053a0f047309fcdd0438e0f79fe', '69acfb89f1264011a1d9a77964364473', '修理流程', '45fcfb4a0e184865aedf3b7c83b7a384', 4, '71337c502b9e4a419e2cee02faec42e3', NULL, NULL, '2', '4', NULL, '2015-02-28 16:31:22', '1', NULL, '2015-03-02 00:00:00', '2015-02-28 16:31:25', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, NULL, NULL),
	('b6f826f3d51b47fabf498023cf86c912', '9141df78760c489398bdff6e4213bb6e', '清洗流程', '13dad85ae92b47cd830d211963f437d8', 2, '71ed95ada1734795b2602f447e722d4e', 0, 0, '2', '3', NULL, '2015-02-28 16:56:08', '1', '2015-02-28 16:56:24', '2015-03-01 00:00:00', '2015-02-28 16:56:24', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, '', NULL),
	('baad919377c64cabb0ba49ace948b5a8', '69acfb89f1264011a1d9a77964364473', '清洗流程', '0ddc9bcd30db467e84c1b186f736ea7c', 2, '71ed95ada1734795b2602f447e722d4e', 100, 100, '2', '3', NULL, '2015-02-28 16:20:36', '1', NULL, '2015-03-03 00:00:00', '2015-02-28 16:21:47', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, NULL, NULL),
	('da5a1ac1b4b3449bbb9be8e7fa4530d0', 'b774dc68d6c449239fcd4f7ed4bbb2f5', '清洗流程', 'e9c86a3173894e0093c6d17f2a1db889', 2, '71ed95ada1734795b2602f447e722d4e', 0, 0, '2', '3', NULL, NULL, NULL, '2015-02-28 14:19:03', '2015-02-28 00:00:00', '2015-02-28 14:19:03', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, '', NULL),
	('e304aaea7258446db2a3608a005c641a', 'ce64131134764cdcad342227e49c9515', '估价流程', '60720ccc57cf485e905c34e34003e78b', 3, '9c70b17e906c4aa493e3d7bc67fea221', NULL, NULL, '2', '10', NULL, '2015-02-28 14:45:23', '1', NULL, '2015-03-16 00:00:00', '2015-02-28 14:45:25', 'ac3b8ca5e7e242acac6b1acedcafd3e3', NULL, NULL, NULL, NULL),
	('e9c86a3173894e0093c6d17f2a1db889', 'b774dc68d6c449239fcd4f7ed4bbb2f5', '修理流程', '770db676539e456982f87b8fbe51dd47', 3, '71337c502b9e4a419e2cee02faec42e3', NULL, NULL, '2', '4', NULL, NULL, NULL, '2015-02-28 14:19:57', '2015-02-28 00:00:00', '2015-02-28 14:19:57', '1', NULL, NULL, '', NULL);
/*!40000 ALTER TABLE `process` ENABLE KEYS */;


-- 导出  表 jeesite.process_iventory 结构
DROP TABLE IF EXISTS `process_iventory`;
CREATE TABLE IF NOT EXISTS `process_iventory` (
  `ID` varchar(64) NOT NULL,
  `PRO_ORDER_RECORDER_ID` varchar(64) DEFAULT NULL,
  `APPROACH_EXAMINE_ID` varchar(64) DEFAULT NULL,
  `EMERGENCY_MAINTENANCE_ID` varchar(64) DEFAULT NULL,
  `TANK_ID` varchar(64) DEFAULT NULL,
  `CURRENT_PROCESS_ID` varchar(64) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `IS_ENDED` char(2) DEFAULT NULL,
  `IS_CHARGE_SUBMITTED` char(2) DEFAULT '0',
  `END_TIME` timestamp NULL DEFAULT NULL,
  `PLANNED_DEPART_TIME` timestamp NULL DEFAULT NULL,
  `SYS_USER_ID` varchar(64) DEFAULT NULL,
  `REMARKS` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_65qywprm61voecwoaxaa56ws0` (`PRO_ORDER_RECORDER_ID`),
  KEY `FK_sykrqxalokjn4s196dtk580vi` (`TANK_ID`),
  KEY `FK_mdknr2xcrqk1f2aly6agye3n` (`SYS_USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程清单表';

-- 正在导出表  jeesite.process_iventory 的数据：~5 rows (大约)
/*!40000 ALTER TABLE `process_iventory` DISABLE KEYS */;
INSERT INTO `process_iventory` (`ID`, `PRO_ORDER_RECORDER_ID`, `APPROACH_EXAMINE_ID`, `EMERGENCY_MAINTENANCE_ID`, `TANK_ID`, `CURRENT_PROCESS_ID`, `NAME`, `CREATE_TIME`, `IS_ENDED`, `IS_CHARGE_SUBMITTED`, `END_TIME`, `PLANNED_DEPART_TIME`, `SYS_USER_ID`, `REMARKS`) VALUES
	('51b649b2687941a1bcdfc59ebba4900a', 'dd0023a2f96048389bf16cb6426ab81d', '0dd8d5acb304431a92b205086b16bcd3', NULL, '59b949cce29140c193082a2222e34f2f', NULL, '任务清单20150228', '2015-02-28 17:54:37', NULL, '0', NULL, '2015-03-11 00:00:00', '1', NULL),
	('69acfb89f1264011a1d9a77964364473', 'dd0023a2f96048389bf16cb6426ab81d', '0dd8d5acb304431a92b205086b16bcd3', NULL, '59b949cce29140c193082a2222e34f2f', NULL, '任务清单20150228', '2015-02-28 16:18:17', '1', '0', '2015-02-28 16:31:34', NULL, '1', NULL),
	('9141df78760c489398bdff6e4213bb6e', '2ae0500e278842c782f022328d2e483e', '9ed98fd2497a4435b638b2462f7bf44f', NULL, '59b949cce29140c193082a2222e34f2f', '3b864d4623af4346a5ed5b10740bfb26', '任务清单20150228', '2015-02-28 16:54:56', NULL, '0', NULL, '2015-03-18 00:00:00', '1', NULL),
	('b774dc68d6c449239fcd4f7ed4bbb2f5', '3fe043aab9e040fd914f2841ba27d286', '794bb60091b44554b37b3f442de697b0', NULL, 'ca35d1c6e1894455b0bf9eab99a79c56', NULL, '任务清单20150228', '2015-02-28 14:18:34', '1', '0', '2015-02-28 14:28:12', '2015-03-02 00:00:00', '1', NULL),
	('ce64131134764cdcad342227e49c9515', '9b7e0146bafd410d936acc7ac7e77c7d', '185dd3af76514b30abf082c0f818a6ec', NULL, '09ac9ee28ea2408088c4c4dc15cf6cff', NULL, '任务清单20150228', '2015-02-28 14:42:50', '1', '0', '2015-02-28 14:45:34', NULL, '1', NULL);
/*!40000 ALTER TABLE `process_iventory` ENABLE KEYS */;


-- 导出  表 jeesite.sys_area 结构
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE IF NOT EXISTS `sys_area` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `name` varchar(100) NOT NULL COMMENT '区域名称',
  `type` char(1) DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_area_parent_id` (`parent_id`),
  KEY `sys_area_parent_ids` (`parent_ids`(255)),
  KEY `sys_area_del_flag` (`del_flag`),
  KEY `FK749F02BFE18EEA67` (`create_by`),
  KEY `FK749F02BF49B6237A` (`update_by`),
  CONSTRAINT `FK749F02BF49B6237A` FOREIGN KEY (`update_by`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `FK749F02BFE18EEA67` FOREIGN KEY (`create_by`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域表';

-- 正在导出表  jeesite.sys_area 的数据：~7 rows (大约)
/*!40000 ALTER TABLE `sys_area` DISABLE KEYS */;
INSERT INTO `sys_area` (`id`, `parent_id`, `parent_ids`, `code`, `name`, `type`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES
	('1', '0', '0,', '100000', '中国', '1', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('2', '1', '0,1,', '110000', '浙江省', '2', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('3', '2', '0,1,2,', '110101', '宁波市', '3', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('4', '3', '0,1,2,3,', '110102', '鄞州区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('5', '3', '0,1,2,3,', '110103', '江东区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('6', '3', '0,1,2,3,', '110104', '海曙区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('7', '3', '0,1,2,3,', '110105', '江北区', '4', '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0');
/*!40000 ALTER TABLE `sys_area` ENABLE KEYS */;


-- 导出  表 jeesite.sys_dict 结构
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE IF NOT EXISTS `sys_dict` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `label` varchar(100) NOT NULL COMMENT '标签名',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `type` varchar(100) NOT NULL COMMENT '类型',
  `description` varchar(100) NOT NULL COMMENT '描述',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`label`),
  KEY `sys_dict_del_flag` (`del_flag`),
  KEY `FK74A03DE8E18EEA67` (`create_by`),
  KEY `FK74A03DE849B6237A` (`update_by`),
  CONSTRAINT `FK74A03DE849B6237A` FOREIGN KEY (`update_by`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `FK74A03DE8E18EEA67` FOREIGN KEY (`create_by`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字典表';

-- 正在导出表  jeesite.sys_dict 的数据：~35 rows (大约)
/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;
INSERT INTO `sys_dict` (`id`, `label`, `value`, `type`, `description`, `sort`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES
	('1', '正常', '0', 'del_flag', '删除标记', 10, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('10', '黄色', 'yellow', 'color', '颜色值', 40, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '1'),
	('11', '橙色', 'orange', 'color', '颜色值', 50, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '1'),
	('17', '国家', '1', 'sys_area_type', '区域类型', 10, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('18', '省份、直辖市', '2', 'sys_area_type', '区域类型', 20, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('19', '地市', '3', 'sys_area_type', '区域类型', 30, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('2', '删除', '1', 'del_flag', '删除标记', 20, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('20', '区县', '4', 'sys_area_type', '区域类型', 40, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('21', '公司', '1', 'sys_office_type', '机构类型', 60, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('22', '部门', '2', 'sys_office_type', '机构类型', 70, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('23', '一级', '1', 'sys_office_grade', '机构等级', 10, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('24', '二级', '2', 'sys_office_grade', '机构等级', 20, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('25', '三级', '3', 'sys_office_grade', '机构等级', 30, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('26', '四级', '4', 'sys_office_grade', '机构等级', 40, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('27', '所有数据', '1', 'sys_data_scope', '数据范围', 10, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('28', '所在公司及以下数据', '2', 'sys_data_scope', '数据范围', 20, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('29', '所在公司数据', '3', 'sys_data_scope', '数据范围', 30, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('2aac07160ad44a9d83b7e97157e9dd85', '一般化工品', '0', 'sys_wash', '一般化工品', 10, '1', '2014-12-17 10:22:31', '1', '2014-12-17 10:22:31', NULL, '0'),
	('3', '显示', '1', 'show_hide', '显示/隐藏', 10, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('30', '所在部门及以下数据', '4', 'sys_data_scope', '数据范围', 40, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('31', '所在部门数据', '5', 'sys_data_scope', '数据范围', 50, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('32', '仅本人数据', '8', 'sys_data_scope', '数据范围', 90, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('33', '按明细设置', '9', 'sys_data_scope', '数据范围', 100, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '1'),
	('34', '系统管理', '1', 'sys_user_type', '用户类型', 10, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('35', '部门经理', '2', 'sys_user_type', '用户类型', 20, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('36', '普通用户', '3', 'sys_user_type', '用户类型', 30, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('4', '隐藏', '0', 'show_hide', '显示/隐藏', 20, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('5', '是', '1', 'yes_no', '是/否', 10, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('6', '否', '0', 'yes_no', '是/否', 20, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('62', '接入日志', '1', 'sys_log_type', '日志类型', 30, '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', NULL, '0'),
	('63', '异常日志', '2', 'sys_log_type', '日志类型', 40, '1', '2013-06-03 08:00:00', '1', '2013-06-03 08:00:00', NULL, '0'),
	('7', '红色', 'red', 'color', '颜色值', 10, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '1'),
	('8', '绿色', 'green', 'color', '颜色值', 20, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '1'),
	('9', '蓝色', 'blue', 'color', '颜色值', 30, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '1'),
	('e099b5db184740e09ed2382c0495fc27', '危险品', '1', 'sys_wash', '危险品', 10, '1', '2014-12-05 17:02:51', '1', '2014-12-05 17:02:51', NULL, '0');
/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;


-- 导出  表 jeesite.sys_log 结构
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE IF NOT EXISTS `sys_log` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `type` char(1) DEFAULT '1' COMMENT '日志类型',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `remote_addr` varchar(255) DEFAULT NULL COMMENT '操作IP地址',
  `user_agent` varchar(255) DEFAULT NULL COMMENT '用户代理',
  `request_uri` varchar(255) DEFAULT NULL COMMENT '请求URI',
  `method` varchar(5) DEFAULT NULL COMMENT '操作方式',
  `params` text COMMENT '操作提交的数据',
  `exception` text COMMENT '异常信息',
  PRIMARY KEY (`id`),
  KEY `sys_log_create_by` (`create_by`),
  KEY `sys_log_request_uri` (`request_uri`),
  KEY `sys_log_type` (`type`),
  KEY `sys_log_create_date` (`create_date`),
  KEY `FK986862D2E18EEA67` (`create_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志表';

-- 正在导出表  jeesite.sys_log 的数据：~17 rows (大约)
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;
INSERT INTO `sys_log` (`id`, `type`, `create_by`, `create_date`, `remote_addr`, `user_agent`, `request_uri`, `method`, `params`, `exception`) VALUES
	('0cfdb9bdbf6b425db1e4878ca579d95a', '1', '1', '2015-02-28 14:43:41', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/workbench/customService/4fe4b2f071ce4c67b4dfbf99090d8128/comments/save', 'POST', 'content=评论内容~~&process.id=4fe4b2f071ce4c67b4dfbf99090d8128&damagePicturePackageFile=tank002.png&affixFileName=delivery.jpg&affixFileType=jpg&affixFileUrl=/upload/FOTU1250423/comments/20150228/delivery.jpg', ''),
	('0fc42f19b75a47c0bded01b28837ad20', '1', '1', '2015-02-28 16:14:10', '192.168.1.100', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/approachExamination/save', 'POST', 'id=&tank.tankCode=SNTU7402890&preorder.id=2ae0500e278842c782f022328d2e483e&tank.client.companyChineseName=宁波远洋&tank.client.id=003edba645ef4efc82b93ffcec0a0510&createdTime=2015-02-28&tank.tankCapacity=200&tank.tankWeight=200&tank.tankType=0&tank.manufacturedTime=2010-01-03&tank.lastAnnualInspectTime=2015-02-02&tank.nextAnnualInspectTime=2015-02-02&tank.annualInspectComments=&tank.remarks=&airValveType=0&topValveType=0&haveSafetyValve=1&haveElectricHeat=1&havePressureGauge=1&haveThermomter=1&accessoriesComments=&tankLeftPicture=&tankRightPicture=&tankTopPicture=&tankBottomPicture=&tankFrontPicture=&tankBackPicture=&tankEntryHolePicture=&tankAirValvePicture=&tankBottomValvePicture=&deliveryPicture=&damagePicturePackage=&remarks=无破损', ''),
	('198074e77e61488eba1a41215cf1b56e', '1', '1', '2015-02-28 17:54:38', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:35.0) Gecko/20100101 Firefox/35.0', '/jeesite/admin/process/assignment/save', 'POST', 'id=0dd8d5acb304431a92b205086b16bcd3&list1SortOrder=1,3,2&plannedDepartTime=2015-03-11', ''),
	('1f74681cd45e445e8632630b73453b18', '1', '1', '2015-02-28 16:21:12', '192.168.1.100', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/workbench/customService/baad919377c64cabb0ba49ace948b5a8/comments/save', 'POST', 'process.id=baad919377c64cabb0ba49ace948b5a8&content=评论评论&affixFileUrl=/upload/SNTU7402890/comments/20150228/动作统计.sql&affixFileName=动作统计.sql&affixFileType=others&damagePicturePackageFile=tank006.jpg', ''),
	('29f98b74486241faa553bc03d6297e08', '1', '1', '2015-02-28 16:54:56', '192.168.1.100', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/assignment/save', 'POST', 'id=9ed98fd2497a4435b638b2462f7bf44f&list1SortOrder=1,3,4,7,2', ''),
	('3a1c82d4e24d4d9eb95b65fab600a61d', '1', '1', '2015-02-28 14:44:34', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/workbench/customService/4fe4b2f071ce4c67b4dfbf99090d8128/comments/save', 'POST', 'process.id=4fe4b2f071ce4c67b4dfbf99090d8128&affixFileName=USP_POWER.txt&affixFileUrl=/upload/FOTU1250423/comments/20150228/USP_POWER.txt&content=点击发表评论12312&damagePicturePackageFile=新建 Microsoft Excel 工作表.xls&affixFileType=txt', ''),
	('5073397ed80b4fbc916b8b8efcb2aa3d', '1', '1', '2015-02-28 14:18:34', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/assignment/save', 'POST', 'id=794bb60091b44554b37b3f442de697b0&list1SortOrder=1,3,4,7,2', ''),
	('581fc7f1a00345629daa1a1439148e26', '1', '1', '2015-02-28 16:18:17', '192.168.1.100', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/assignment/save', 'POST', 'id=0dd8d5acb304431a92b205086b16bcd3&list1SortOrder=1,3,10,4,2', ''),
	('5de826bd6a364bd7aa56d4cd481054fb', '1', '1', '2015-02-28 14:17:12', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/preorder/save', 'POST', 'cleanGoods.name=Acetone/丙酮&remarks=第一个预录单&cleanGoods.dangerousGoodsCode=Class8/Unifoorm&tank.tankCode=CBHU3202732&_approachAimIdList=on&cleanGoods.id=9415b82bdfde410697d8253df4c721dc&expectedApproachTime=2015-03-01&id=&isValidateTankCode=on&client.companyChineseName=宁波远洋-NBWY&clientContacter.id=b47cf62101ff4db8885364c9236a67cf&client.id=003edba645ef4efc82b93ffcec0a0510&approachAimIdList=1', ''),
	('82fb23ce906d4726af24251405bb204f', '1', '1', '2015-02-28 14:42:50', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/assignment/save', 'POST', 'id=185dd3af76514b30abf082c0f818a6ec&list1SortOrder=1,3,10,2', ''),
	('94ab1358d00d42fba3b93353187d6c19', '1', '1', '2015-02-28 14:32:30', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/workbench/customService/charge/save', 'POST', 'chargeDeatilList[2].chargeName=修理费&chargeDeatilList[0].chargePrice=0&chargeDeatilList[0].currencyType=0&chargeDeatilList[3].process.id=770db676539e456982f87b8fbe51dd47&chargeDeatilList[0].process.id=43ba8af51af34b89b246e15c150f578d&chargeDeatilList[1].currencyType=0&chargeDeatilList[2].process.id=e9c86a3173894e0093c6d17f2a1db889&chargeDeatilList[3].chargeName=翻新费&chargeDeatilList[1].chargeName=清洗费&chargeDeatilList[1].process.id=da5a1ac1b4b3449bbb9be8e7fa4530d0&processIventory.id=b774dc68d6c449239fcd4f7ed4bbb2f5&chargeDeatilList[2].chargePrice=1000&chargeDeatilList[3].currencyType=0&chargeDeatilList[3].chargePrice=125&chargeDeatilList[1].chargePrice=500&chargeDeatilList[2].currencyType=0&chargeDeatilList[0].chargeName=堆存费', ''),
	('9894951d26fa42dfbbf249a766bcab5c', '1', '1', '2015-02-28 16:07:47', '192.168.1.100', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/preorder/save', 'POST', 'id=&tank.tankCode=SNTU7402890&isValidateTankCode=on&client.companyChineseName=宁波远东-NBWD&client.id=20fb04e84e604b0dab50f0425058264e&clientContacter.id=8bbbdecdec984436a4388ca7d46452f1&cleanGoods.name=Acetone/丙酮&cleanGoods.id=9415b82bdfde410697d8253df4c721dc&cleanGoods.dangerousGoodsCode=Class8/Unifoorm&expectedApproachTime=2015-03-02&approachAimIdList=1&_approachAimIdList=on&remarks=', ''),
	('bdb8ca23e58a46e58e17cb99c5de7ad2', '1', '1', '2015-02-28 14:39:15', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/preorder/save', 'POST', 'cleanGoods.name=Acetone/丙酮&remarks=&cleanGoods.dangerousGoodsCode=Class8/Unifoorm&tank.tankCode=FOTU1250423&_approachAimIdList=on&cleanGoods.id=9415b82bdfde410697d8253df4c721dc&expectedApproachTime=2015-03-02&id=&isValidateTankCode=on&client.companyChineseName=宁波远东-NBWD&clientContacter.id=8bbbdecdec984436a4388ca7d46452f1&client.id=20fb04e84e604b0dab50f0425058264e&approachAimIdList=1', ''),
	('ded157e5cb0c46f096a397bf78aa9588', '1', '1', '2015-02-28 16:00:18', '192.168.1.108', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/600.2.5 (KHTML, like Gecko) Version/8.0.2 Safari/600.2.5', '/jeesite/admin/process/preorder/save', 'POST', 'id=&tank.tankCode=SNTU7402890&client.companyChineseName=宁波远洋-NBWY&client.id=003edba645ef4efc82b93ffcec0a0510&clientContacter.id=8bbbdecdec984436a4388ca7d46452f1&cleanGoods.name=Alcohol/酒精&cleanGoods.id=f1ad14ed64d44a01bc3164446e3b6297&cleanGoods.dangerousGoodsCode=Class8/Unicode&expectedApproachTime=2015-03-01&approachAimIdList=1&_approachAimIdList=on&remarks=1242424', ''),
	('ef14938250904aabac0117e9b6160840', '1', '1', '2015-02-28 16:21:20', '192.168.1.100', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/workbench/customService/baad919377c64cabb0ba49ace948b5a8/comments/save', 'POST', 'process.id=baad919377c64cabb0ba49ace948b5a8&content=123123213&affixFileUrl=/upload/SNTU7402890/comments/20150228/tank008.jpg&affixFileName=tank008.jpg&affixFileType=jpg&damagePicturePackageFile=tank008.jpg', ''),
	('f090314b056644fcbaafa43a187346e8', '1', '1', '2015-02-28 16:05:30', '192.168.1.108', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/600.2.5 (KHTML, like Gecko) Version/8.0.2 Safari/600.2.5', '/jeesite/admin/process/approachExamination/save', 'POST', 'id=&tank.tankCode=SNTU7402890&preorder.id=dd0023a2f96048389bf16cb6426ab81d&tank.client.companyChineseName=宁波远洋&tank.client.id=003edba645ef4efc82b93ffcec0a0510&createdTime=2015-02-28&tank.tankCapacity=200&tank.tankWeight=200&tank.tankType=0&tank.manufacturedTime=2010-01-03&tank.lastAnnualInspectTime=2015-02-02&tank.nextAnnualInspectTime=2015-02-02&tank.annualInspectComments=&tank.remarks=&airValveType=0&topValveType=0&haveSafetyValve=1&haveElectricHeat=1&havePressureGauge=1&haveThermomter=1&accessoriesComments=&tankLeftPictureFile=产品模型.png&tankLeftPicture=/upload/SNTU7402890/approachexamine/20150228/产品模型.png&tankRightPictureFile=系统.png&tankRightPicture=/upload/SNTU7402890/approachexamine/20150228/系统.png&tankTopPictureFile=客户管理.png&tankTopPicture=/upload/SNTU7402890/approachexamine/20150228/客户管理.png&tankBottomPictureFile=技术.bmp&tankBottomPicture=/upload/SNTU7402890/approachexamine/20150228/技术.bmp&tankFrontPicture=&tankBackPicture=&tankEntryHolePicture=&tankAirValvePicture=&tankBottomValvePicture=&deliveryPictureFile=进出场管理.png&deliveryPicture=/upload/SNTU7402890/approachexamine/20150228/进出场管理.png&damagePicturePackageFile=技术.bmp&damagePicturePackage=/upload/SNTU7402890/approachexamine/20150228/技术.bmp,/upload/SNTU7402890/approachexamine/2015022...&remarks=', ''),
	('f090a68b2b0148f98f43c61c8c12e7bc', '1', '1', '2015-02-28 14:40:35', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.115 Safari/537.36', '/jeesite/admin/process/approachExamination/save', 'POST', 'tank.tankCapacity=300&tank.annualInspectComments=5年检&deliveryPictureFile=delivery.jpg&tankLeftPicture=&remarks=无破损信息&tank.tankCode=FOTU1250423&tank.client.id=20fb04e84e604b0dab50f0425058264e&preorder.id=9b7e0146bafd410d936acc7ac7e77c7d&id=&tank.remarks=简单信息&tankAirValvePicture=&deliveryPicture=/upload/FOTU1250423/approachexamine/20150228/delivery.jpg&tankFrontPicture=&haveThermomter=1&tank.client.companyChineseName=宁波远东&haveSafetyValve=1&havePressureGauge=1&tankBackPicture=&accessoriesComments=配件信息说明&airValveType=0&createdTime=2015-02-28&tank.manufacturedTime=2009-01-04&tank.nextAnnualInspectTime=2015-02-18&topValveType=0&tankEntryHolePicture=&tankBottomValvePicture=&tankBottomPicture=&haveElectricHeat=1&tank.tankWeight=200&tank.lastAnnualInspectTime=2010-01-03&tankTopPicture=&tankRightPicture=&damagePicturePackage=&tank.tankType=0', '');
/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;


-- 导出  表 jeesite.sys_menu 结构
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE IF NOT EXISTS `sys_menu` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `name` varchar(100) NOT NULL COMMENT '菜单名称',
  `href` varchar(255) DEFAULT NULL COMMENT '链接',
  `target` varchar(20) DEFAULT NULL COMMENT '目标',
  `icon` varchar(100) DEFAULT NULL COMMENT '图标',
  `sort` int(11) NOT NULL COMMENT '排序（升序）',
  `is_show` char(1) NOT NULL COMMENT '是否在菜单中显示',
  `is_activiti` char(1) DEFAULT NULL COMMENT '是否同步工作流',
  `is_slide` char(1) DEFAULT '0' COMMENT '是否是左侧显示按钮',
  `is_new_menu` char(1) DEFAULT '0' COMMENT '是否属于新建菜单',
  `permission` varchar(200) DEFAULT NULL COMMENT '权限标识',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_menu_parent_id` (`parent_id`),
  KEY `sys_menu_parent_ids` (`parent_ids`(255)),
  KEY `sys_menu_del_flag` (`del_flag`),
  KEY `FK74A44791E18EEA67` (`create_by`),
  KEY `FK74A4479149B6237A` (`update_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='菜单表';

-- 正在导出表  jeesite.sys_menu 的数据：~35 rows (大约)
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` (`id`, `parent_id`, `parent_ids`, `name`, `href`, `target`, `icon`, `sort`, `is_show`, `is_activiti`, `is_slide`, `is_new_menu`, `permission`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES
	('1', '0', '0,', '顶级菜单', NULL, NULL, NULL, 0, '1', '0', '0', '0', NULL, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('10', '2', '0,1,2,', '字典管理', '/sys/dict/', NULL, 'th-list', 17, '1', '0', '0', '0', NULL, '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('11', '10', '0,1,2,10,', '查看', NULL, NULL, NULL, 18, '0', '0', '0', '0', 'sys:dict:view', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('12', '10', '0,1,2,10,', '修改', NULL, NULL, NULL, 19, '0', '0', '0', '0', 'sys:dict:edit', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('17', '2', '0,1,2,', '机构管理', '/sys/office/', NULL, 'th-large', 11, '1', '0', '0', '0', NULL, '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('18', '17', '0,1,2,17,', '查看', NULL, NULL, NULL, 12, '0', '0', '0', '0', 'sys:office:view', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('19', '17', '0,1,2,17,', '修改', NULL, NULL, NULL, 13, '0', '0', '0', '0', 'sys:office:edit', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('2', '1', '0,1,', '系统设置', NULL, NULL, NULL, 4, '1', '0', '0', '0', NULL, '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:10', NULL, '0'),
	('20', '2', '0,1,2,', '用户管理', '/sys/user/', NULL, 'user', 8, '1', '0', '0', '0', NULL, '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('21', '20', '0,1,2,20,', '查看', NULL, NULL, NULL, 9, '0', '0', '0', '0', 'sys:user:view', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('22', '20', '0,1,2,20,', '修改', NULL, NULL, NULL, 10, '0', '0', '0', '0', 'sys:user:edit', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('22a29fc72f934839a8c331844b73abaf', '24', '0,1,23,24,', '员工列表', '', '', NULL, 25, '0', NULL, '0', '0', 'client:clientEmployee:edit', '1', '2014-12-08 10:26:21', '1', '2014-12-08 19:44:10', NULL, '0'),
	('23', '1', '0,1,', '客户管理', NULL, NULL, NULL, 2, '1', '0', '0', '0', NULL, '1', '2014-11-28 13:43:27', '1', '2014-12-08 19:44:10', NULL, '0'),
	('24', '23', '0,1,23,', '客户公司管理', '/client/client', '', NULL, 3, '1', '0', '0', '0', '', '1', '2014-11-28 13:44:50', '1', '2014-12-08 19:44:10', NULL, '0'),
	('25', '24', '0,1,23,24,', '编辑', '', '', NULL, 21, '0', NULL, '0', '0', 'client:client:edit', '1', '2014-11-29 22:30:14', '1', '2014-12-08 19:44:10', NULL, '0'),
	('26', '24', '0,1,23,24,', '查看', '', '', NULL, 20, '0', NULL, '0', '0', 'client:client:view', '1', '2014-11-29 22:29:53', '1', '2014-12-08 19:44:10', NULL, '0'),
	('27', '1', '0,1,', '我的工作台', '/admin', '', NULL, 1, '1', '0', '1', '0', '', '1', '2013-05-27 08:00:00', '1', '2015-01-28 21:46:22', NULL, '1'),
	('4', '2', '0,1,2,', '菜单管理', '/sys/menu/', NULL, 'list-alt', 5, '1', '0', '0', '0', NULL, '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:10', NULL, '0'),
	('4364f688a4364b7fb23db5b0c16161cf', '4fd107e48a6346a1ba0ed5df849d7d3e', '0,1,4fd107e48a6346a1ba0ed5df849d7d3e,', '出场箱检', '/process/departExamination', '', NULL, 36, '1', NULL, '0', '0', '', '1', '2014-12-08 19:45:07', '1', '2015-01-18 21:39:38', NULL, '0'),
	('4fd107e48a6346a1ba0ed5df849d7d3e', '1', '0,1,', '进出场操作', '', '', NULL, 28, '1', NULL, '0', '0', '', '1', '2014-12-08 19:41:03', '1', '2014-12-08 19:44:12', NULL, '0'),
	('5', '4', '0,1,2,4,', '查看', NULL, NULL, NULL, 6, '0', '0', '0', '0', 'sys:menu:view', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:10', NULL, '0'),
	('6', '4', '0,1,2,4,', '修改', NULL, NULL, NULL, 7, '0', '0', '0', '0', 'sys:menu:edit', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:10', NULL, '0'),
	('7', '2', '0,1,2,', '角色管理', '/sys/role/', NULL, 'lock', 14, '1', '0', '0', '0', NULL, '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('7b9895c5d43d41af8c52aa56b03eba00', '4fd107e48a6346a1ba0ed5df849d7d3e', '0,1,4fd107e48a6346a1ba0ed5df849d7d3e,', '进场预录单', '/process/preorder', '', NULL, 32, '1', NULL, '0', '0', '', '1', '2014-12-08 19:42:38', '1', '2014-12-09 10:32:57', NULL, '0'),
	('8', '7', '0,1,2,7,', '查看', NULL, NULL, NULL, 15, '0', '0', '0', '0', 'sys:role:view', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('9', '7', '0,1,2,7,', '修改', NULL, NULL, NULL, 16, '0', '0', '0', '0', 'sys:role:edit', '1', '2013-05-27 08:00:00', '1', '2014-12-08 19:44:11', NULL, '0'),
	('b8cebd3c768048528f128c22415484b5', 'db00c76db5014e31b104a33592690b30', '0,1,de7057c1970b43bcac30dfb7f855c670,db00c76db5014e31b104a33592690b30,', '修改', '', '', NULL, 30, '0', NULL, '0', '0', 'sys:companyChargeInfo:edit', '1', '2014-12-17 14:58:12', '1', '2014-12-17 17:06:17', NULL, '0'),
	('bd1041cba3b14ff0ae34351990a4b16b', '4fd107e48a6346a1ba0ed5df849d7d3e', '0,1,4fd107e48a6346a1ba0ed5df849d7d3e,', '进场任务安排', '/process/assignment', '', NULL, 35, '1', NULL, '0', '0', '', '1', '2014-12-08 19:43:47', '1', '2014-12-24 10:45:25', NULL, '0'),
	('be87e013fca44215b55513e81c316be2', '4fd107e48a6346a1ba0ed5df849d7d3e', '0,1,4fd107e48a6346a1ba0ed5df849d7d3e,', '进场箱检', '/process/preorder/preapproach', '', NULL, 32, '1', NULL, '0', '0', '', '1', '2014-12-08 19:43:09', '1', '2014-12-20 12:40:13', NULL, '0'),
	('d875756e76c84e4a9889dc2c08d5a99c', 'de7057c1970b43bcac30dfb7f855c670', '0,1,de7057c1970b43bcac30dfb7f855c670,', '清洗货物', '/sys/wash/', '', NULL, 23, '1', NULL, '0', '0', 'sys:wash', '1', '2014-12-03 20:44:33', '1', '2014-12-17 10:16:56', NULL, '0'),
	('db00c76db5014e31b104a33592690b30', 'de7057c1970b43bcac30dfb7f855c670', '0,1,de7057c1970b43bcac30dfb7f855c670,', '收费信息', '/sys/companyChargeInfo/', '', NULL, 22, '1', NULL, '0', '0', '', '1', '2014-12-03 20:44:11', '1', '2014-12-17 17:06:17', NULL, '0'),
	('de7057c1970b43bcac30dfb7f855c670', '1', '0,1,', '公司管理', '', '', NULL, 20, '1', NULL, '0', '0', '', '1', '2014-12-03 20:43:35', '1', '2014-12-08 19:44:11', NULL, '0'),
	('deac1cc474764521a013f425b4d0b105', 'de7057c1970b43bcac30dfb7f855c670', '0,1,de7057c1970b43bcac30dfb7f855c670,', '财务信息', '/sys/companyfinance/', '', NULL, 21, '1', NULL, '0', '0', '', '1', '2014-12-03 20:43:56', '1', '2014-12-17 10:13:45', NULL, '0'),
	('e4e9d70615e04929a1d18dbe7d1f59ba', 'deac1cc474764521a013f425b4d0b105', '0,1,de7057c1970b43bcac30dfb7f855c670,deac1cc474764521a013f425b4d0b105,', '查看', '', '', NULL, 33, '0', NULL, '0', '0', 'sys:companyfinance:view', '1', '2014-12-17 10:14:41', '1', '2014-12-17 10:14:41', NULL, '0'),
	('f90eef810d424328a156fc4de9eb10f3', 'deac1cc474764521a013f425b4d0b105', '0,1,de7057c1970b43bcac30dfb7f855c670,deac1cc474764521a013f425b4d0b105,', '修改', '', '', NULL, 34, '0', NULL, '0', '0', 'sys:companyfinance:edit', '1', '2014-12-17 10:15:17', '1', '2014-12-17 10:15:17', NULL, '0');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;


-- 导出  表 jeesite.sys_office 结构
DROP TABLE IF EXISTS `sys_office`;
CREATE TABLE IF NOT EXISTS `sys_office` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `parent_id` varchar(64) NOT NULL COMMENT '父级编号',
  `parent_ids` varchar(2000) NOT NULL COMMENT '所有父级编号',
  `area_id` varchar(64) NOT NULL COMMENT '归属区域',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `name` varchar(100) NOT NULL COMMENT '机构名称',
  `type` char(1) NOT NULL COMMENT '机构类型',
  `grade` char(1) NOT NULL COMMENT '机构等级',
  `address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `zip_code` varchar(100) DEFAULT NULL COMMENT '邮政编码',
  `master` varchar(100) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `fax` varchar(200) DEFAULT NULL COMMENT '传真',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_office_parent_id` (`parent_id`),
  KEY `sys_office_parent_ids` (`parent_ids`(255)),
  KEY `sys_office_del_flag` (`del_flag`),
  KEY `FKE024AC6EE18EEA67` (`create_by`),
  KEY `FKE024AC6E49B6237A` (`update_by`),
  KEY `FKE024AC6E915D2ABC` (`area_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构表';

-- 正在导出表  jeesite.sys_office 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `sys_office` DISABLE KEYS */;
INSERT INTO `sys_office` (`id`, `parent_id`, `parent_ids`, `area_id`, `code`, `name`, `type`, `grade`, `address`, `zip_code`, `master`, `phone`, `fax`, `email`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES
	('1', '0', '0,', '3', '100000', 'XX场堆清理公司', '1', '1', NULL, NULL, NULL, NULL, NULL, NULL, '1', '2013-05-27 08:00:00', '1', '2013-05-27 08:00:00', NULL, '0'),
	('2', '1', '0,1,', '3', '100003', '技术组', '2', '1', '', '', '', '', '', '', '1', '2015-01-06 20:49:28', '1', '2015-02-06 22:36:30', '', '0'),
	('3', '1', '0,1,', '3', '100002', '客服组', '2', '1', '', '', '', '', '', '', '1', '2013-05-27 08:00:00', '1', '2015-01-06 20:49:09', '', '0');
/*!40000 ALTER TABLE `sys_office` ENABLE KEYS */;


-- 导出  表 jeesite.sys_role 结构
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE IF NOT EXISTS `sys_role` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `office_id` varchar(64) DEFAULT NULL COMMENT '归属机构',
  `name` varchar(100) NOT NULL COMMENT '角色名称',
  `data_scope` char(1) DEFAULT NULL COMMENT '数据范围',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_role_del_flag` (`del_flag`),
  KEY `FK74A6B2A8E18EEA67` (`create_by`),
  KEY `FK74A6B2A849B6237A` (`update_by`),
  KEY `FK74A6B2A845EC47DC` (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色表';

-- 正在导出表  jeesite.sys_role 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` (`id`, `office_id`, `name`, `data_scope`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`) VALUES
	('1', '1', '系统管理员', '1', '1', '2013-05-27 08:00:00', '1', '2015-02-06 22:47:53', NULL, '0'),
	('2', '1', '总经理', '4', '1', '2013-05-27 08:00:00', '1', '2015-02-06 22:47:26', NULL, '0'),
	('3', '3', '客服人员', '8', '1', '2013-05-27 08:00:00', '1', '2015-02-06 22:47:34', NULL, '0'),
	('4', '2', '技术人员', '8', '1', '2013-05-27 08:00:00', '1', '2015-02-06 22:47:42', NULL, '0'),
	('5', '1', '客服主管', '4', '1', '2015-02-06 22:51:14', '1', '2015-02-06 22:51:14', NULL, '0'),
	('6', '2', '技术主管', '4', '1', '2015-02-06 22:50:59', '1', '2015-02-06 22:50:59', NULL, '0');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;


-- 导出  表 jeesite.sys_role_menu 结构
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE IF NOT EXISTS `sys_role_menu` (
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  `menu_id` varchar(64) NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`role_id`,`menu_id`),
  KEY `FK65D48496FF4B61C` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-菜单';

-- 正在导出表  jeesite.sys_role_menu 的数据：~35 rows (大约)
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES
	('1', '1'),
	('1', '10'),
	('1', '11'),
	('1', '12'),
	('1', '17'),
	('1', '18'),
	('1', '19'),
	('1', '2'),
	('1', '20'),
	('1', '21'),
	('1', '22'),
	('1', '22a29fc72f934839a8c331844b73abaf'),
	('1', '23'),
	('1', '24'),
	('1', '25'),
	('1', '26'),
	('1', '27'),
	('1', '4'),
	('1', '4364f688a4364b7fb23db5b0c16161cf'),
	('1', '4fd107e48a6346a1ba0ed5df849d7d3e'),
	('1', '5'),
	('1', '6'),
	('1', '7'),
	('1', '7b9895c5d43d41af8c52aa56b03eba00'),
	('1', '8'),
	('1', '9'),
	('1', 'b8cebd3c768048528f128c22415484b5'),
	('1', 'bd1041cba3b14ff0ae34351990a4b16b'),
	('1', 'be87e013fca44215b55513e81c316be2'),
	('1', 'd875756e76c84e4a9889dc2c08d5a99c'),
	('1', 'db00c76db5014e31b104a33592690b30'),
	('1', 'de7057c1970b43bcac30dfb7f855c670'),
	('1', 'deac1cc474764521a013f425b4d0b105'),
	('1', 'e4e9d70615e04929a1d18dbe7d1f59ba'),
	('1', 'f90eef810d424328a156fc4de9eb10f3');
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;


-- 导出  表 jeesite.sys_role_office 结构
DROP TABLE IF EXISTS `sys_role_office`;
CREATE TABLE IF NOT EXISTS `sys_role_office` (
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  `office_id` varchar(64) NOT NULL COMMENT '机构编号',
  PRIMARY KEY (`role_id`,`office_id`),
  KEY `FK4639BC3345EC47DC` (`office_id`),
  KEY `FK4639BC33FF4B61C` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色-机构';

-- 正在导出表  jeesite.sys_role_office 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `sys_role_office` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_office` ENABLE KEYS */;


-- 导出  表 jeesite.sys_user 结构
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE IF NOT EXISTS `sys_user` (
  `id` varchar(64) NOT NULL COMMENT '编号',
  `company_id` varchar(64) NOT NULL COMMENT '归属公司',
  `office_id` varchar(64) NOT NULL COMMENT '归属部门',
  `login_name` varchar(100) NOT NULL COMMENT '登录名',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `no` varchar(100) DEFAULT NULL COMMENT '工号',
  `name` varchar(100) NOT NULL COMMENT '姓名',
  `email` varchar(200) DEFAULT NULL COMMENT '邮箱',
  `email_password` varchar(200) DEFAULT NULL COMMENT '邮箱密码用于发送邮件',
  `phone` varchar(200) DEFAULT NULL COMMENT '电话',
  `mobile` varchar(200) DEFAULT NULL COMMENT '手机',
  `user_type` char(1) DEFAULT NULL COMMENT '用户类型',
  `PHOTO` varchar(255) DEFAULT NULL COMMENT '头像照片',
  `login_ip` varchar(100) DEFAULT NULL COMMENT '最后登陆IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  `token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sys_user_office_id` (`office_id`),
  KEY `sys_user_login_name` (`login_name`),
  KEY `sys_user_company_id` (`company_id`),
  KEY `sys_user_update_date` (`update_date`),
  KEY `sys_user_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- 正在导出表  jeesite.sys_user 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` (`id`, `company_id`, `office_id`, `login_name`, `password`, `no`, `name`, `email`, `email_password`, `phone`, `mobile`, `user_type`, `PHOTO`, `login_ip`, `login_date`, `create_by`, `create_date`, `update_by`, `update_date`, `remarks`, `del_flag`, `token`) VALUES
	('1', '1', '1', 'thinkgem', 'c1f2271b85269ca8b087eb729c8b6f3ec9a2ba1cd15648af5ae2e91b', '0001', 'thinkgem', 'tunny_880105@163.com', 'yuchao313108', '057487345678', '13488754845', '', NULL, '192.168.1.100', '2015-02-28 16:44:12', '1', '2013-05-27 08:00:00', '1', '2015-01-13 22:24:50', '最高管理员', '0', 'a8a53345582a44889a8a5304b013ef2a'),
	('ac3b8ca5e7e242acac6b1acedcafd3e3', '1', '2', 'yuchao', '010be595dad2ed233410a9bcca1c9c9af8d8a63ee09fa4b8cc1e35ee', '1000001', '俞超', 'chaochaoyuyu@126.com', 'yuchao1116', '889327812', '13488754966', '3', NULL, NULL, NULL, '1', '2015-02-06 23:27:01', '1', '2015-02-06 23:27:01', '测试技术组用户', '0', NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;


-- 导出  表 jeesite.sys_user_role 结构
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE IF NOT EXISTS `sys_user_role` (
  `user_id` varchar(64) NOT NULL COMMENT '用户编号',
  `role_id` varchar(64) NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `FK660C5178FF4B61C` (`role_id`),
  KEY `FK660C5178B51F79FC` (`user_id`),
  CONSTRAINT `FK660C5178B51F79FC` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `FK660C5178FF4B61C` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户-角色';

-- 正在导出表  jeesite.sys_user_role 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES
	('1', '1'),
	('ac3b8ca5e7e242acac6b1acedcafd3e3', '4');
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;


-- 导出  表 jeesite.sys_wash_info 结构
DROP TABLE IF EXISTS `sys_wash_info`;
CREATE TABLE IF NOT EXISTS `sys_wash_info` (
  `ID` varchar(64) NOT NULL,
  `COMPANY_ID` varchar(64) NOT NULL,
  `GOODS_CHINESE_NAME` varchar(255) NOT NULL,
  `GOODS_ENGLISH_NAME` varchar(255) DEFAULT NULL,
  `GOODS_SHORT_NAME` varchar(32) DEFAULT NULL,
  `TYPE` char(1) DEFAULT '0',
  `DANGEROUS_GOODS_CODE` varchar(255) DEFAULT NULL,
  `REFERENCE_CLEAN_PRICE` int(11) DEFAULT '0',
  `ADDITIONAL_CLEAN_PRICE` int(11) DEFAULT '0',
  `DEL_FLAG` char(1) DEFAULT '0',
  `REMARKS` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='清洗货物表';

-- 正在导出表  jeesite.sys_wash_info 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `sys_wash_info` DISABLE KEYS */;
INSERT INTO `sys_wash_info` (`ID`, `COMPANY_ID`, `GOODS_CHINESE_NAME`, `GOODS_ENGLISH_NAME`, `GOODS_SHORT_NAME`, `TYPE`, `DANGEROUS_GOODS_CODE`, `REFERENCE_CLEAN_PRICE`, `ADDITIONAL_CLEAN_PRICE`, `DEL_FLAG`, `REMARKS`) VALUES
	('9415b82bdfde410697d8253df4c721dc', '1', '丙酮', 'Acetone', 'ACET', '0', 'Class8/Unifoorm', 0, 0, '0', '丙酮'),
	('f1ad14ed64d44a01bc3164446e3b6297', '1', '酒精', 'Alcohol', 'DETA', '0', 'Class8/Unicode', 100, 100, '0', '');
/*!40000 ALTER TABLE `sys_wash_info` ENABLE KEYS */;


-- 导出  表 jeesite.tank 结构
DROP TABLE IF EXISTS `tank`;
CREATE TABLE IF NOT EXISTS `tank` (
  `ID` varchar(64) NOT NULL,
  `PARENT_ID` varchar(64) DEFAULT NULL,
  `PARENT_IDS` varchar(2048) DEFAULT NULL,
  `CLIENT_ID` varchar(64) DEFAULT NULL,
  `TANK_CODE` varchar(255) NOT NULL,
  `TANK_CAPACITY` int(11) DEFAULT NULL,
  `TANK_WEIGHT` int(11) DEFAULT NULL,
  `TANK_TYPE` char(1) DEFAULT NULL,
  `MANUFACTURED_TIME` timestamp NULL DEFAULT NULL,
  `LAST_ANNUAL_INSPECT_TIME` timestamp NULL DEFAULT NULL,
  `NEXT_ANNUAL_INSPECT_TIME` timestamp NULL DEFAULT NULL,
  `ANNUAL_INSPECT_COMMENTS` varchar(32) DEFAULT NULL,
  `CHANGE_DATE` timestamp NULL DEFAULT NULL,
  `CHANGE_USER_ID` varchar(64) DEFAULT NULL,
  `REMARKS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_iw2e69384wbscky67xxm36l48` (`CLIENT_ID`),
  CONSTRAINT `FK_iw2e69384wbscky67xxm36l48` FOREIGN KEY (`CLIENT_ID`) REFERENCES `client_base_info` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='罐箱表';

-- 正在导出表  jeesite.tank 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `tank` DISABLE KEYS */;
INSERT INTO `tank` (`ID`, `PARENT_ID`, `PARENT_IDS`, `CLIENT_ID`, `TANK_CODE`, `TANK_CAPACITY`, `TANK_WEIGHT`, `TANK_TYPE`, `MANUFACTURED_TIME`, `LAST_ANNUAL_INSPECT_TIME`, `NEXT_ANNUAL_INSPECT_TIME`, `ANNUAL_INSPECT_COMMENTS`, `CHANGE_DATE`, `CHANGE_USER_ID`, `REMARKS`) VALUES
	('09ac9ee28ea2408088c4c4dc15cf6cff', NULL, NULL, '20fb04e84e604b0dab50f0425058264e', 'FOTU1250423', 300, 200, '0', '2009-01-04 00:00:00', '2010-01-03 00:00:00', '2015-02-18 00:00:00', '5年检', NULL, NULL, '简单信息'),
	('59b949cce29140c193082a2222e34f2f', NULL, NULL, '003edba645ef4efc82b93ffcec0a0510', 'SNTU7402890', 8000, 2080, '1', '2010-02-03 00:00:00', '2015-02-02 00:00:00', '2017-08-02 00:00:00', '5年检', NULL, NULL, ''),
	('ca35d1c6e1894455b0bf9eab99a79c56', NULL, NULL, '003edba645ef4efc82b93ffcec0a0510', 'CBHU3202732', 5000, 8000, '0', '2010-01-01 00:00:00', '2013-02-28 00:00:00', '2015-08-28 00:00:00', '5年检', NULL, NULL, NULL);
/*!40000 ALTER TABLE `tank` ENABLE KEYS */;


-- 导出  表 jeesite.tank_change_history 结构
DROP TABLE IF EXISTS `tank_change_history`;
CREATE TABLE IF NOT EXISTS `tank_change_history` (
  `ID` varchar(64) NOT NULL,
  `OLD_TANK_ID` varchar(64) DEFAULT NULL,
  `NEW_TANK_ID` varchar(64) DEFAULT NULL,
  `UPDATE_USER_ID` varchar(64) DEFAULT NULL,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  `REMARKS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='箱子变更历史表';

-- 正在导出表  jeesite.tank_change_history 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `tank_change_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `tank_change_history` ENABLE KEYS */;


-- 导出  表 jeesite.tank_operation_log 结构
DROP TABLE IF EXISTS `tank_operation_log`;
CREATE TABLE IF NOT EXISTS `tank_operation_log` (
  `ID` varchar(64) NOT NULL,
  `PROCESS_IVENTORY_ID` varchar(64) DEFAULT NULL,
  `TANK_ID` varchar(64) NOT NULL,
  `OPERATION_LOG` text,
  `SYS_USER_ID` varchar(64) DEFAULT NULL,
  `OPERATION_TIME` timestamp NULL DEFAULT NULL,
  `REMARKS` text,
  PRIMARY KEY (`ID`),
  KEY `FK_tjvwm18ik6au8o4asr5b05vhv` (`PROCESS_IVENTORY_ID`),
  KEY `FK_qn3ql5qwdy3epo5a9qm6a09q3` (`TANK_ID`),
  KEY `FK_3ypyv0vdgesq3h2xjeuvahv6c` (`SYS_USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='箱子操作日志表';

-- 正在导出表  jeesite.tank_operation_log 的数据：~39 rows (大约)
/*!40000 ALTER TABLE `tank_operation_log` DISABLE KEYS */;
INSERT INTO `tank_operation_log` (`ID`, `PROCESS_IVENTORY_ID`, `TANK_ID`, `OPERATION_LOG`, `SYS_USER_ID`, `OPERATION_TIME`, `REMARKS`) VALUES
	('071d57cefc1c47f4b4c3d090d17314d9', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem完成预录单提交', '1', '2015-02-28 14:17:12', NULL),
	('0aef4426e50244d5919a5863379e73fc', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem分配了一个清洗的任务给俞超.', '1', '2015-02-28 14:18:44', NULL),
	('0f589255f22c4f48b77eebf9bc678d56', 'ce64131134764cdcad342227e49c9515', '09ac9ee28ea2408088c4c4dc15cf6cff', '俞超完成估价任务', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '2015-02-28 14:45:25', NULL),
	('13cc67f72c3140f996e3b332469b4b60', '9141df78760c489398bdff6e4213bb6e', '59b949cce29140c193082a2222e34f2f', 'thinkgem分配了一个修理的任务给thinkgem.', '1', '2015-02-28 16:56:38', NULL),
	('1d4450c2b72c4858aa3bcf1eda21389b', 'ce64131134764cdcad342227e49c9515', '09ac9ee28ea2408088c4c4dc15cf6cff', 'thinkgem完成预录单提交', '1', '2015-02-28 14:39:15', NULL),
	('229b8033e9744765b07d7487228806e2', '9141df78760c489398bdff6e4213bb6e', '59b949cce29140c193082a2222e34f2f', 'thinkgem启动出场任务，分配给俞超完成', '1', '2015-02-28 17:15:44', NULL),
	('331b659927a54c3095422472108a4dd0', '51b649b2687941a1bcdfc59ebba4900a', '59b949cce29140c193082a2222e34f2f', 'thinkgem完成预录单提交', '1', '2015-02-28 16:00:18', NULL),
	('43b247a7c3b34e2b88b0aaef1daa4fc2', 'ce64131134764cdcad342227e49c9515', '09ac9ee28ea2408088c4c4dc15cf6cff', 'thinkgem启动估价任务，分配给俞超完成', '1', '2015-02-28 14:45:23', NULL),
	('483e6dbceb6045fa846b583d7b137cfb', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem分配了一个出场的任务给俞超.', '1', '2015-02-28 14:20:34', NULL),
	('4c83ffc4ad344efe9e5c195c01becdd0', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', '俞超完成出场任务', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '2015-02-28 16:31:34', NULL),
	('4dfad1c707be41598063e838db2e72ec', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem完成了出场的任务.', '1', '2015-02-28 14:20:43', NULL),
	('51574a02ffce4cf2b82a69681144705c', 'ce64131134764cdcad342227e49c9515', '09ac9ee28ea2408088c4c4dc15cf6cff', '俞超完成出场任务', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '2015-02-28 14:45:34', NULL),
	('671e07fc03484c19ba840ae340d74a2b', 'ce64131134764cdcad342227e49c9515', '09ac9ee28ea2408088c4c4dc15cf6cff', 'thinkgem完成箱检', '1', '2015-02-28 00:00:00', NULL),
	('67963165040c4f3684a71cfc65015f3f', '9141df78760c489398bdff6e4213bb6e', '59b949cce29140c193082a2222e34f2f', 'thinkgem完成了清洗的任务.', '1', '2015-02-28 16:56:24', NULL),
	('6910876edcbd4152b5c1941e77697adc', 'ce64131134764cdcad342227e49c9515', '09ac9ee28ea2408088c4c4dc15cf6cff', '俞超完成清洗任务', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '2015-02-28 14:45:16', NULL),
	('6edf2e5ee4b84044bab85f4b30f73819', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', '俞超完成修理任务', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '2015-02-28 16:31:25', NULL),
	('7d04356eda1749c6b3745d60b337b484', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', '俞超完成清洗任务', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '2015-02-28 16:21:47', NULL),
	('808266d2c66244c8bea07f3ede885b7f', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', '俞超完成估价任务', 'ac3b8ca5e7e242acac6b1acedcafd3e3', '2015-02-28 16:25:39', NULL),
	('8444377957f743639a66e9ff230379ec', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem完成了翻新的任务.', '1', '2015-02-28 14:20:18', NULL),
	('8955e65928b14ff7a90c169ccc26bb60', '9141df78760c489398bdff6e4213bb6e', '59b949cce29140c193082a2222e34f2f', 'thinkgem分配了一个翻新的任务给thinkgem.', '1', '2015-02-28 17:01:48', NULL),
	('95fa1e52870b4470b8325b41611e5579', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', 'thinkgem完成箱检', '1', '2015-02-28 00:00:00', NULL),
	('9dcfe79912ec408f8a3baaec8b79daef', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', 'thinkgem完成预录单提交', '1', '2015-02-28 16:00:18', NULL),
	('a31204e1a4dc4af6bb49fe993cc59df0', '9141df78760c489398bdff6e4213bb6e', '59b949cce29140c193082a2222e34f2f', 'thinkgem完成预录单提交', '1', '2015-02-28 16:07:47', NULL),
	('a38a78597ea34cecbd43b3d7a7aacc55', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem完成箱检', '1', '2015-02-28 14:17:11', NULL),
	('a6764b69576c460ebb01de508393ad25', '9141df78760c489398bdff6e4213bb6e', '59b949cce29140c193082a2222e34f2f', 'thinkgem完成箱检', '1', '2015-02-28 00:00:00', NULL),
	('a7bbe6d901b24732b12e17b44dcf16c7', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem分配了一个翻新的任务给thinkgem.', '1', '2015-02-28 14:20:08', NULL),
	('a9c7b81a0e9f4169b2d1ee0415265942', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem完成了清洗的任务.', '1', '2015-02-28 14:19:04', NULL),
	('b19b9b6108c8440cb805ecccd2e565d1', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', 'thinkgem启动出场任务，分配给俞超完成', '1', '2015-02-28 16:31:31', NULL),
	('b7b47594dc044111a143cc92b4cd541d', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', 'thinkgem启动修理任务，分配给俞超完成', '1', '2015-02-28 16:31:23', NULL),
	('c862d8ca5bf34744af980098838fcaa6', '9141df78760c489398bdff6e4213bb6e', '59b949cce29140c193082a2222e34f2f', 'thinkgem完成了翻新的任务.', '1', '2015-02-28 17:04:35', NULL),
	('c8bd3087a22d4dd1acfe52abd538ac2f', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', 'thinkgem启动估价任务，分配给俞超完成', '1', '2015-02-28 16:24:03', NULL),
	('ccea157b44e64bd0b0cda672f0cd73c3', '9141df78760c489398bdff6e4213bb6e', '59b949cce29140c193082a2222e34f2f', 'thinkgem完成了修理的任务.', '1', '2015-02-28 16:57:15', NULL),
	('d00583c44ed84068821eda8d8aa07f2a', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem完成了修理的任务.', '1', '2015-02-28 14:19:57', NULL),
	('d16f822b57994e8f9c972931fb371d5c', 'b774dc68d6c449239fcd4f7ed4bbb2f5', 'ca35d1c6e1894455b0bf9eab99a79c56', 'thinkgem分配了一个修理的任务给thinkgem.', '1', '2015-02-28 14:19:21', NULL),
	('d1e1e824c51048c68763fa9d32fc1e68', '69acfb89f1264011a1d9a77964364473', '59b949cce29140c193082a2222e34f2f', 'thinkgem启动清洗任务，分配给俞超完成', '1', '2015-02-28 16:20:36', NULL),
	('d3722ad207774565aeb86d646c875561', 'ce64131134764cdcad342227e49c9515', '09ac9ee28ea2408088c4c4dc15cf6cff', 'thinkgem启动清洗任务，分配给俞超完成', '1', '2015-02-28 14:43:07', NULL),
	('d3f06798466f4a19ba4905009f6cbe04', '9141df78760c489398bdff6e4213bb6e', '59b949cce29140c193082a2222e34f2f', 'thinkgem分配了一个清洗的任务给俞超.', '1', '2015-02-28 16:56:08', NULL),
	('e0c21e94f99c4109859081d4f7d21831', '51b649b2687941a1bcdfc59ebba4900a', '59b949cce29140c193082a2222e34f2f', 'thinkgem完成箱检', '1', '2015-02-28 00:00:00', NULL),
	('e1692cbe023b48febf674c345b2b5468', 'ce64131134764cdcad342227e49c9515', '09ac9ee28ea2408088c4c4dc15cf6cff', 'thinkgem启动出场任务，分配给俞超完成', '1', '2015-02-28 14:45:32', NULL);
/*!40000 ALTER TABLE `tank_operation_log` ENABLE KEYS */;


-- 导出  表 jeesite.task 结构
DROP TABLE IF EXISTS `task`;
CREATE TABLE IF NOT EXISTS `task` (
  `ID` varchar(64) NOT NULL,
  `TASK_NAME` varchar(100) DEFAULT NULL,
  `COMPANY_CHARGE_INFO_ID` varchar(64) DEFAULT NULL,
  `IS_SHOW` char(4) DEFAULT '1',
  `SORT` int(11) DEFAULT NULL,
  `REMARKS` varchar(255) DEFAULT NULL,
  `app_show` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务表';

-- 正在导出表  jeesite.task 的数据：~13 rows (大约)
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` (`ID`, `TASK_NAME`, `COMPANY_CHARGE_INFO_ID`, `IS_SHOW`, `SORT`, `REMARKS`, `app_show`) VALUES
	('1', '进场', 'bdf80af3fc7f4a5e9fc9eaa30e19a566', '1', 0, '进场任务', NULL),
	('10', '估价', '9c70b17e906c4aa493e3d7bc67fea221', '1', 2, '估价任务', NULL),
	('11', '清洁检验', '7351d7165e8b4e07b4bd541f6bd05f46', '1', 4, '清洁检验', NULL),
	('12', '年检检验', '15cacdd725494df3b2f616b0d43c0174', '1', 2, '年检检验', NULL),
	('13', '应急维修', '64fdbbc9da764d29901a3ffb6cf492f1', '0', 13, '应急维修', NULL),
	('2', '出场', NULL, '1', 2, '出场任务', NULL),
	('3', '清洗', '71ed95ada1734795b2602f447e722d4e', '1', 1, '清洗任务', NULL),
	('4', '修理', '71337c502b9e4a419e2cee02faec42e3', '1', 2, '修理任务', NULL),
	('5', '改装', 'a9e52243fd924cdbb3eed0ea288abef8', '1', 3, '改装任务', NULL),
	('6', '加热', 'be57475bd227402ea94dae9fe6fb2150', '1', 6, '加热任务', NULL),
	('7', '翻新', 'b75336fc14684c2db530249f5e60cfa5', '1', 3, '翻新任务', NULL),
	('8', '充氮', 'b903a42e6c314c2c860247d2db34beb9', '1', 4, '充氮任务', NULL),
	('9', '实验测试', '0962a45bc75e423ebccc97e1a1b29ce5', '1', 7, '实验测试', NULL);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

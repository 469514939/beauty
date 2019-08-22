/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : beauty

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-08-23 00:28:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `order` int(11) NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
INSERT INTO `admin_menu` VALUES ('1', '0', '1', 'Dashboard', 'fa-bar-chart', '/', null, null, null);
INSERT INTO `admin_menu` VALUES ('2', '0', '2', 'Admin', 'fa-tasks', '', null, null, null);
INSERT INTO `admin_menu` VALUES ('3', '2', '3', 'Users', 'fa-users', 'auth/users', null, null, null);
INSERT INTO `admin_menu` VALUES ('4', '2', '4', 'Roles', 'fa-user', 'auth/roles', null, null, null);
INSERT INTO `admin_menu` VALUES ('5', '2', '5', 'Permission', 'fa-ban', 'auth/permissions', null, null, null);
INSERT INTO `admin_menu` VALUES ('6', '2', '6', 'Menu', 'fa-bars', 'auth/menu', null, null, null);
INSERT INTO `admin_menu` VALUES ('7', '2', '7', 'Operation log', 'fa-history', 'auth/logs', null, null, null);

-- ----------------------------
-- Table structure for admin_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `admin_operation_log`;
CREATE TABLE `admin_operation_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `input` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_operation_log_user_id_index` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_operation_log
-- ----------------------------
INSERT INTO `admin_operation_log` VALUES ('1', '1', 'admin', 'GET', '127.0.0.1', '[]', '2019-08-13 15:56:44', '2019-08-13 15:56:44');
INSERT INTO `admin_operation_log` VALUES ('2', '1', 'admin', 'GET', '127.0.0.1', '[]', '2019-08-14 14:58:00', '2019-08-14 14:58:00');
INSERT INTO `admin_operation_log` VALUES ('3', '1', 'admin', 'GET', '127.0.0.1', '[]', '2019-08-14 15:04:05', '2019-08-14 15:04:05');
INSERT INTO `admin_operation_log` VALUES ('4', '1', 'admin/auth/users', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2019-08-14 15:04:07', '2019-08-14 15:04:07');
INSERT INTO `admin_operation_log` VALUES ('5', '1', 'admin/auth/permissions', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2019-08-14 15:04:14', '2019-08-14 15:04:14');
INSERT INTO `admin_operation_log` VALUES ('6', '1', 'admin', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2019-08-14 15:05:26', '2019-08-14 15:05:26');
INSERT INTO `admin_operation_log` VALUES ('7', '1', 'admin', 'GET', '127.0.0.1', '[]', '2019-08-14 15:07:29', '2019-08-14 15:07:29');
INSERT INTO `admin_operation_log` VALUES ('8', '1', 'admin/auth/users', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2019-08-14 15:39:21', '2019-08-14 15:39:21');
INSERT INTO `admin_operation_log` VALUES ('9', '1', 'admin/users', 'GET', '127.0.0.1', '[]', '2019-08-14 15:48:13', '2019-08-14 15:48:13');
INSERT INTO `admin_operation_log` VALUES ('10', '1', 'admin/users', 'GET', '127.0.0.1', '[]', '2019-08-14 15:48:37', '2019-08-14 15:48:37');
INSERT INTO `admin_operation_log` VALUES ('11', '1', 'admin/movies', 'GET', '127.0.0.1', '[]', '2019-08-14 15:55:03', '2019-08-14 15:55:03');
INSERT INTO `admin_operation_log` VALUES ('12', '1', 'admin/movies', 'GET', '127.0.0.1', '[]', '2019-08-14 15:55:33', '2019-08-14 15:55:33');
INSERT INTO `admin_operation_log` VALUES ('13', '1', 'admin', 'GET', '127.0.0.1', '[]', '2019-08-15 13:36:28', '2019-08-15 13:36:28');
INSERT INTO `admin_operation_log` VALUES ('14', '1', 'admin/movies', 'GET', '127.0.0.1', '[]', '2019-08-15 13:43:38', '2019-08-15 13:43:38');
INSERT INTO `admin_operation_log` VALUES ('15', '1', 'admin/movies/create', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2019-08-15 13:43:42', '2019-08-15 13:43:42');
INSERT INTO `admin_operation_log` VALUES ('16', '1', 'admin/movies', 'POST', '127.0.0.1', '{\"title\":\"1\",\"director\":\"12\",\"describe\":\"\\u63cf\\u8ff0\",\"rate\":\"off\",\"released\":null,\"release_at\":\"2019-08-15 13:43:42\",\"_token\":\"xQfzHAgNy3nZqDQhiTvu2arC8jLNtnc6Pefb5Wdj\",\"_previous_\":\"http:\\/\\/beauty.cm\\/admin\\/movies\"}', '2019-08-15 13:44:19', '2019-08-15 13:44:19');
INSERT INTO `admin_operation_log` VALUES ('17', '1', 'admin/movies/create', 'GET', '127.0.0.1', '[]', '2019-08-15 13:44:20', '2019-08-15 13:44:20');
INSERT INTO `admin_operation_log` VALUES ('18', '1', 'admin/movies', 'POST', '127.0.0.1', '{\"title\":\"1\",\"director\":\"12\",\"describe\":\"\\u63cf\\u8ff0\",\"rate\":\"off\",\"released\":\"abc\",\"release_at\":\"2019-08-15 13:43:42\",\"_token\":\"xQfzHAgNy3nZqDQhiTvu2arC8jLNtnc6Pefb5Wdj\"}', '2019-08-15 13:44:36', '2019-08-15 13:44:36');
INSERT INTO `admin_operation_log` VALUES ('19', '1', 'admin/movies', 'GET', '127.0.0.1', '[]', '2019-08-15 13:44:36', '2019-08-15 13:44:36');
INSERT INTO `admin_operation_log` VALUES ('20', '1', 'admin/movies/create', 'GET', '127.0.0.1', '[]', '2019-08-15 13:44:36', '2019-08-15 13:44:36');
INSERT INTO `admin_operation_log` VALUES ('21', '1', 'admin', 'GET', '127.0.0.1', '[]', '2019-08-15 13:45:54', '2019-08-15 13:45:54');
INSERT INTO `admin_operation_log` VALUES ('22', '1', 'admin/users', 'GET', '127.0.0.1', '[]', '2019-08-15 13:46:06', '2019-08-15 13:46:06');
INSERT INTO `admin_operation_log` VALUES ('23', '1', 'admin/users/create', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2019-08-15 13:46:08', '2019-08-15 13:46:08');
INSERT INTO `admin_operation_log` VALUES ('24', '1', 'admin/users', 'POST', '127.0.0.1', '{\"name\":\"test1\",\"email\":null,\"password\":\"123456\",\"remember_token\":null,\"_token\":\"xQfzHAgNy3nZqDQhiTvu2arC8jLNtnc6Pefb5Wdj\",\"_previous_\":\"http:\\/\\/beauty.cm\\/admin\\/users\"}', '2019-08-15 13:46:20', '2019-08-15 13:46:20');
INSERT INTO `admin_operation_log` VALUES ('25', '1', 'admin/users/create', 'GET', '127.0.0.1', '[]', '2019-08-15 13:46:21', '2019-08-15 13:46:21');
INSERT INTO `admin_operation_log` VALUES ('26', '1', 'admin/users', 'POST', '127.0.0.1', '{\"name\":\"test1\",\"email\":\"469514939@qq.com\",\"password\":\"admin\",\"remember_token\":null,\"_token\":\"xQfzHAgNy3nZqDQhiTvu2arC8jLNtnc6Pefb5Wdj\"}', '2019-08-15 13:46:35', '2019-08-15 13:46:35');
INSERT INTO `admin_operation_log` VALUES ('27', '1', 'admin/users', 'GET', '127.0.0.1', '[]', '2019-08-15 13:46:36', '2019-08-15 13:46:36');
INSERT INTO `admin_operation_log` VALUES ('28', '1', 'admin/movies/create', 'GET', '127.0.0.1', '[]', '2019-08-15 13:46:50', '2019-08-15 13:46:50');
INSERT INTO `admin_operation_log` VALUES ('29', '1', 'admin/movies', 'GET', '127.0.0.1', '[]', '2019-08-15 13:46:57', '2019-08-15 13:46:57');
INSERT INTO `admin_operation_log` VALUES ('30', '1', 'admin/movies', 'GET', '127.0.0.1', '[]', '2019-08-15 13:47:30', '2019-08-15 13:47:30');
INSERT INTO `admin_operation_log` VALUES ('31', '1', 'admin/movies', 'GET', '127.0.0.1', '[]', '2019-08-15 13:48:46', '2019-08-15 13:48:46');
INSERT INTO `admin_operation_log` VALUES ('32', '1', 'admin/movies/1', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2019-08-15 14:14:54', '2019-08-15 14:14:54');
INSERT INTO `admin_operation_log` VALUES ('33', '1', 'admin/movies', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2019-08-15 14:14:56', '2019-08-15 14:14:56');
INSERT INTO `admin_operation_log` VALUES ('34', '1', 'admin/movies', 'GET', '127.0.0.1', '[]', '2019-08-15 14:16:35', '2019-08-15 14:16:35');
INSERT INTO `admin_operation_log` VALUES ('35', '1', 'admin/movies', 'GET', '127.0.0.1', '{\"id\":null,\"created_at\":{\"start\":\"2019-08-14 00:00:00\",\"end\":\"2019-08-14 00:00:00\"},\"_pjax\":\"#pjax-container\"}', '2019-08-15 14:16:54', '2019-08-15 14:16:54');
INSERT INTO `admin_operation_log` VALUES ('36', '1', 'admin/movies', 'GET', '127.0.0.1', '{\"_pjax\":\"#pjax-container\"}', '2019-08-15 14:16:55', '2019-08-15 14:16:55');
INSERT INTO `admin_operation_log` VALUES ('37', '1', 'admin/users', 'GET', '127.0.0.1', '[]', '2019-08-15 14:49:07', '2019-08-15 14:49:07');
INSERT INTO `admin_operation_log` VALUES ('38', '1', 'admin/posts', 'GET', '127.0.0.1', '[]', '2019-08-15 14:50:48', '2019-08-15 14:50:48');
INSERT INTO `admin_operation_log` VALUES ('39', '1', 'admin/posts', 'GET', '127.0.0.1', '[]', '2019-08-15 14:51:31', '2019-08-15 14:51:31');

-- ----------------------------
-- Table structure for admin_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `http_path` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_permissions_name_unique` (`name`),
  UNIQUE KEY `admin_permissions_slug_unique` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_permissions
-- ----------------------------
INSERT INTO `admin_permissions` VALUES ('1', 'All permission', '*', '', '*', null, null);
INSERT INTO `admin_permissions` VALUES ('2', 'Dashboard', 'dashboard', 'GET', '/', null, null);
INSERT INTO `admin_permissions` VALUES ('3', 'Login', 'auth.login', '', '/auth/login\r\n/auth/logout', null, null);
INSERT INTO `admin_permissions` VALUES ('4', 'User setting', 'auth.setting', 'GET,PUT', '/auth/setting', null, null);
INSERT INTO `admin_permissions` VALUES ('5', 'Auth management', 'auth.management', '', '/auth/roles\r\n/auth/permissions\r\n/auth/menu\r\n/auth/logs', null, null);

-- ----------------------------
-- Table structure for admin_roles
-- ----------------------------
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_roles_name_unique` (`name`),
  UNIQUE KEY `admin_roles_slug_unique` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_roles
-- ----------------------------
INSERT INTO `admin_roles` VALUES ('1', 'Administrator', 'administrator', '2019-08-13 15:53:14', '2019-08-13 15:53:14');

-- ----------------------------
-- Table structure for admin_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu` (
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_menu_role_id_menu_id_index` (`role_id`,`menu_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_role_menu
-- ----------------------------
INSERT INTO `admin_role_menu` VALUES ('1', '2', null, null);

-- ----------------------------
-- Table structure for admin_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permissions`;
CREATE TABLE `admin_role_permissions` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_role_permissions
-- ----------------------------
INSERT INTO `admin_role_permissions` VALUES ('1', '1', null, null);

-- ----------------------------
-- Table structure for admin_role_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_users`;
CREATE TABLE `admin_role_users` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_users_role_id_user_id_index` (`role_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_role_users
-- ----------------------------
INSERT INTO `admin_role_users` VALUES ('1', '1', null, null);

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_username_unique` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES ('1', 'admin', '$2y$10$fGTmlOZvEQ2yxuVeXh7Ol.wiRffJ8Lg5yixwihU1Uu0QqIf96LTCS', 'Administrator', null, '7KUqAPdGHYeO1twQcGHQDjFpj3t22MqQVXP63YYWuWIBmxzlKyDxbCaFyoAw', '2019-08-13 15:53:14', '2019-08-13 15:53:14');

-- ----------------------------
-- Table structure for admin_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_permissions`;
CREATE TABLE `admin_user_permissions` (
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_user_permissions_user_id_permission_id_index` (`user_id`,`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int(10) unsigned NOT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of comments
-- ----------------------------

-- ----------------------------
-- Table structure for dycms_goods
-- ----------------------------
DROP TABLE IF EXISTS `dycms_goods`;
CREATE TABLE `dycms_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` int(11) DEFAULT '0' COMMENT '产品分类id号',
  `name` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `code` varchar(32) DEFAULT '' COMMENT '产品编码',
  `type_id` int(11) DEFAULT '0' COMMENT '产品类型',
  `brand_id` int(11) DEFAULT '0' COMMENT '品牌id号',
  `unit` varchar(10) NOT NULL DEFAULT '' COMMENT '单位',
  `status` tinyint(4) DEFAULT '0' COMMENT '会员状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `content` text,
  `img` varchar(255) DEFAULT NULL,
  `keyword` varchar(255) DEFAULT '' COMMENT '商品关键词',
  `special_price` float(10,2) DEFAULT '0.00' COMMENT '特价',
  `sell_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '零售价',
  `market_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `cost_price` float(10,2) DEFAULT '0.00' COMMENT '成本价',
  `store_nums` int(11) DEFAULT '0' COMMENT '库存量',
  `warning_line` int(11) DEFAULT '0' COMMENT '预警线',
  `seo_title` varchar(255) DEFAULT NULL COMMENT '页面标题',
  `seo_keywords` varchar(255) DEFAULT NULL COMMENT '页面关键词',
  `seo_description` varchar(255) DEFAULT NULL COMMENT '页面描述',
  `weight` int(11) DEFAULT '0' COMMENT '重量',
  `point` int(11) DEFAULT '0' COMMENT '积分',
  `visit` int(11) DEFAULT '0' COMMENT '查看次数',
  `favorite` int(11) DEFAULT '0' COMMENT '收藏数',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `is_online` tinyint(1) DEFAULT '0' COMMENT '是否上架',
  `sale_protection` text COMMENT '售后保障',
  `pro_no` varchar(20) DEFAULT '' COMMENT '商品规格编号',
  `products` text COMMENT '产品价格json数据',
  `mainpic` varchar(255) DEFAULT NULL COMMENT '图片',
  `publish_time` int(1) DEFAULT '0' COMMENT '发布时间',
  `album_id` int(11) DEFAULT NULL COMMENT '相册id号',
  `tags` varchar(255) DEFAULT '' COMMENT '商品标签',
  `description` varchar(255) DEFAULT NULL COMMENT '商品简介',
  `like_count` int(10) DEFAULT '0' COMMENT '喜欢数',
  `is_book` tinyint(1) DEFAULT '0' COMMENT '是否预约',
  `expiry` int(11) DEFAULT NULL COMMENT '有效期',
  `expirytime` int(11) DEFAULT NULL COMMENT '有效期',
  `limit_start` int(11) DEFAULT NULL COMMENT '限购开始时间',
  `limit_end` int(11) DEFAULT NULL COMMENT '限购结束时间',
  `delivery` tinyint(2) DEFAULT '2' COMMENT '发货方式(1=自动发货，2=手动发货)',
  `bind_content` text COMMENT '绑定内容(编码后数据)',
  `etype` tinyint(2) DEFAULT '0' COMMENT '实体类型(1=普通产品，2=套餐)',
  `is_top` tinyint(1) DEFAULT '0' COMMENT '是否置顶',
  `is_recommend` tinyint(1) DEFAULT '0' COMMENT '是否推荐',
  `is_hot` tinyint(1) DEFAULT '0' COMMENT '是否热销',
  `display_type` tinyint(2) DEFAULT '1' COMMENT '实体类型(0=商城不显示，1=商城显示)',
  `is_discount` tinyint(1) DEFAULT NULL COMMENT '是否打折',
  `shop_count` int(10) DEFAULT '0' COMMENT '商城销售数',
  `need_express_fee` tinyint(1) DEFAULT '1' COMMENT '是否需要邮费',
  `express_fee_rate` float(10,2) DEFAULT '1.00' COMMENT '邮费系数',
  `is_distribution` int(11) DEFAULT '0' COMMENT '是否参与分销，0=不参与，1=参与',
  `is_agent` int(11) DEFAULT '0' COMMENT '是否参与代理 0=不参与 1=参与',
  `is_needwarrant` int(11) DEFAULT '1' COMMENT '商品是否需要授权 0=不需要 1=需要',
  `express_fee_rule` varchar(3000) DEFAULT NULL COMMENT '运费规则',
  `min_price` float(10,2) DEFAULT '0.00' COMMENT '最低价',
  `max_price` float(10,2) DEFAULT '0.00' COMMENT '最高价',
  `instructions` text COMMENT '使用说明',
  `use_case` text COMMENT '使用案例',
  `qrcode` varchar(256) DEFAULT NULL COMMENT '二维码链接',
  `inventory_operate` tinyint(4) DEFAULT '0' COMMENT '库存操作类型（1=扣库存锁库存，2=扣库存不锁库存，3=不扣库存不锁库存）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10021 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品表';

-- ----------------------------
-- Records of dycms_goods
-- ----------------------------
INSERT INTO `dycms_goods` VALUES ('10012', '6', '黄玉姜粉', 'P010101', '1', '3', '瓶', '1', '1494550975', '1566403996', '1', '1', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-24/594e830016883.png\" title=\"\" alt=\"1.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-28/5953ad8157911.png\" title=\"\" alt=\"5.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f0fe479fc2.png\" title=\"\" alt=\"2.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f0f8523256.png\" title=\"\" alt=\"3.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f21ee91d85.png\" title=\"\" alt=\"4.png\"/></p>', null, '黄玉姜粉,黄玉姜茶,和煦堂', '0.00', '0.00', '68.00', null, '534', null, null, null, null, '380', '68', '0', '0', '98', '1', null, 'P010101_3', 'W3siaWQiOiIxMiIsIm5hbWUiOiLlh4Dph40iLCJ0eXBlIjoiMSIsInNwZWN2YWwiOltbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMCIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiI1MDBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9XSxbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMSIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIzODBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9XSxbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIyNjBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9XV19XQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', '0', '0', '黄玉姜粉', '精选无硫黄玉姜，自然晾晒，手工研磨，零添加，粉质细腻，汤色亮黄，姜味浓郁', '912', '0', null, null, '0', '0', '2', '', '1', '0', '0', '1', '0', '1', '0', '1', '1.00', '1', '1', '0', '', '68.00', '68.00', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-29/59550a8fa59dc.png\" title=\"\" alt=\"食用方法.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-28/5953b4209e42f.png\" title=\"\" alt=\"注意事项.png\"/></p>', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-01/5956f349b4f73.png\" title=\"\" alt=\"使用实例_标题.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-01/5956f3637c3e0.png\" title=\"\" alt=\"使用实例_日常保健，消化不良.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-01/5956f8560c59c.png\" title=\"\" alt=\"使用实例_感冒咳嗽.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-01/5956fbc064b90.png\" title=\"\" alt=\"使用实例_小儿咳嗽，咽喉肿痛.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-01/59577256e013f.png\" title=\"\" alt=\"使用实例_宫冷不孕， 痛经.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-01/595793f0b9c5e.png\" title=\"\" alt=\"使用实例_面部暗疮， 脚臭.png\"/></p>', '/Uploads/qrcode/d/4/d41d8cd98f00b204e9800998ecf8427e.png', '1');
INSERT INTO `dycms_goods` VALUES ('10013', '6', '黄玉姜片', 'P010102', '1', '3', '瓶', '1', '1494551292', '1504257625', '1', '1', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594fa45f5a1cb.png\" title=\"\" alt=\"1.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-28/5953adba11c36.png\" title=\"\" alt=\"5.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594fa4680e33b.png\" title=\"\" alt=\"2.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594fa47551139.png\" title=\"\" alt=\"3.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594fa4adbb360.png\" title=\"\" alt=\"4.png\"/></p>', null, '黄玉姜片,和煦堂', '0.00', '0.00', '48.00', null, '820', null, null, null, null, '260', '48', '0', '0', '97', '1', null, 'P010102_1', 'W3siaWQiOiIxMiIsIm5hbWUiOiLlh4Dph40iLCJ0eXBlIjoiMSIsInNwZWN2YWwiOltbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIyNjBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9XV19XQ==', '/Uploads/Image/Goods/2017-06-23/594d2fe5d58a4.png', '0', '0', '黄玉姜片', '精选无硫黄玉姜，自然晾晒，零添加，甄选小姜切片，姜丝可见，富含纤维，汤色淡黄，味微辣芳香', '806', '0', null, null, '0', '0', '2', '', '1', '0', '0', '0', '0', '0', '0', '1', '1.00', '1', '1', '0', '', '48.00', '48.00', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-30/59561f3b70acc.png\" title=\"\" alt=\"食用方法.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-28/5953b439da3ba.png\" title=\"\" alt=\"注意事项.png\"/></p>', '', '/Uploads/qrcode/d/4/d41d8cd98f00b204e9800998ecf8427e.png', '3');
INSERT INTO `dycms_goods` VALUES ('10014', '7', '轻松灸', 'P020101', '1', '3', '盒', '1', '1494551368', '1566403754', '1', '1', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f75f121b51.png\" title=\"\" alt=\"1.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-27/5951b2be43515.png\" title=\"\" alt=\"6.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f76929244a.png\" title=\"\" alt=\"2.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f7615c5efe.png\" title=\"\" alt=\"3.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f77ea07b5f.png\" title=\"\" alt=\"4.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f7629acd51.png\" title=\"\" alt=\"4.png\"/></p>', null, '轻松灸,和煦堂,千年艾,艾艾贴,贴身灸', '0.00', '0.00', '168.00', null, '821', null, null, null, null, '800', '168', '0', '0', '99', '1', null, 'P020101_1', 'W3siaWQiOiIxMiIsIm5hbWUiOiLlh4Dph40iLCJ0eXBlIjoiMSIsInNwZWN2YWwiOltbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMCIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiI1MDBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9XSxbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMSIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIzODBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9XSxbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIyNjBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9XSxbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIyNTBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9XSxbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwNCIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjIwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIyMDBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjIwMGciLCJzcGVjaWQiOiIxMiJ9XV19XQ==', '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', '0', '0', '轻松灸', '甄选正宗陈年蕲艾，零添加，非遗传承，使用简单，效果显著，居家旅行，随时随地，轻松一灸！', '923', '0', null, null, '0', '0', '0', '', '1', '0', '1', '1', '1', '0', '0', '1', '1.00', '1', '1', '0', '', '168.00', '168.00', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f998387e1e.png\" title=\"\" alt=\"使用方法.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-26/59511ef0cc808.png\" title=\"\" alt=\"注意事项.png\"/></p>', '<p><strong>使用轻松灸，轻轻松松在家进行保健理疗：</strong></p><p><strong>一、消化系统</strong></p><p><a href=\"http://wei.hexutang.cn/Case/info/artid/397/cate/case.html\" target=\"_self\" style=\"white-space: normal;\">● 慢性腹泻</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/138/cate/case.html\" target=\"_self\">● 胃痛</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/118/cate/case.html\" target=\"_self\">● 急性肠胃炎</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/119/cate/case.html\" target=\"_self\">● 慢性肠胃炎</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/121/cate/case.html\" target=\"_self\">● 胃溃疡</a></p><p><br/></p><p><strong>二、妇科问题</strong></p><p><a href=\"http://wei.hexutang.cn/Case/info/artid/403/cate/case.html\" target=\"_self\">● 宫寒</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/128/cate/case.html\" target=\"_self\">● 乳腺增生</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/92/cate/case.html\" target=\"_self\">● 乳腺炎</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/127/cate/case.html\" target=\"_self\">● 痛经</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/123/cate/case.html\" target=\"_self\">● 月经不调</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/124/cate/case.html\" target=\"_self\">● 崩漏</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/122/cate/case.html\" target=\"_self\">● 附件炎</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/104/cate/case.html\" target=\"_self\">● 子宫肌瘤</a></p><p><br/></p><p><strong>三、呼吸系统</strong></p><p><a href=\"http://wei.hexutang.cn/Case/info/artid/130/cate/case.html\" target=\"_self\">● 感冒流鼻涕</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/86/cate/case.html\" target=\"_self\">● 咳喘</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/134/cate/case.html\" target=\"_self\">● 鼻炎</a>&nbsp;&nbsp;&nbsp;&nbsp;</p><p><br/></p><p><strong>四、生殖泌尿系统</strong></p><p><a href=\"http://wei.hexutang.cn/Case/info/artid/131/cate/case.html\" target=\"_self\">● 慢性肾炎</a>&nbsp;&nbsp;&nbsp;&nbsp;</p><p><br/></p><p><strong>五、神经系统</strong></p><p><a href=\"http://wei.hexutang.cn/Case/info/artid/404/cate/case.html\" target=\"_self\">● 坐骨神经痛</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/214/cate/case.html\" target=\"_self\">● 失眠</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/136/cate/case.html\" target=\"_self\">● 忧郁症</a>&nbsp;&nbsp;&nbsp;&nbsp;</p><p><br/></p><p><strong>六、其他</strong></p><p><a href=\"http://wei.hexutang.cn/Case/info/artid/141/cate/case.html\" target=\"_self\">● 发烧</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/135/cate/case.html\" target=\"_self\">● 荨麻疹</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/91/cate/case.html\" target=\"_self\">● 皮肤病</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/88/cate/case.html\" target=\"_self\">● 暑湿症</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"http://wei.hexutang.cn/Case/info/artid/83/cate/case.html\" target=\"_self\">● 空调病</a></p>', '/Uploads/qrcode/d/4/d41d8cd98f00b204e9800998ecf8427e.png', '0');
INSERT INTO `dycms_goods` VALUES ('10015', '8', '红糖粉', 'P030101', '1', '3', '瓶', '1', '1494551442', '1504257635', '1', '1', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f3ecfa509d.png\" title=\"\" alt=\"1.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-27/5951fcf71cfcc.png\" title=\"\" alt=\"5.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f3eda6f6f6.png\" title=\"\" alt=\"3.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f3ee6b0b86.png\" title=\"\" alt=\"3.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-25/594f3ef024458.png\" title=\"\" alt=\"4.png\"/></p>', null, '红糖,和煦堂', '0.00', '0.00', '36.00', null, '816', null, null, null, null, '500', '36', '0', '0', '96', '1', null, 'P030101_1', 'W3siaWQiOiIxMiIsIm5hbWUiOiLlh4Dph40iLCJ0eXBlIjoiMSIsInNwZWN2YWwiOltbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMCIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiI1MDBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9XSxbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIyNTBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9XV19XQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', '0', '0', '红糖粉', '精选廉江荻蔗榨取，手工熬制而成，零添加，保留营养，原汁原味，色泽呈豆沙红，口感浓香，甜而不腻', '802', '0', null, null, '0', '0', '2', '', '1', '0', '0', '0', '0', '0', '0', '1', '1.00', '1', '1', '0', '', '20.00', '36.00', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-30/5955fa840540a.png\" title=\"\" alt=\"食用方法.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-06-27/59526f1998a89.png\" title=\"\" alt=\"注意事项.png\"/></p>', '', '/Uploads/qrcode/d/4/d41d8cd98f00b204e9800998ecf8427e.png', '3');
INSERT INTO `dycms_goods` VALUES ('10016', '10', '红参片', 'P040101', '1', '3', '瓶', '-1', '1494982132', '1504582457', '1', '1', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/59587a189f744.png\" title=\"\" alt=\"1.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/59587a2a7a7b3.png\" title=\"\" alt=\"5.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/59587a382b1e3.png\" title=\"\" alt=\"2.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/59587a4aaed3f.png\" title=\"\" alt=\"3.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/59587a58c96a0.png\" title=\"\" alt=\"4.png\"/></p>', null, '红参片,长白山,不添糖,和煦堂', '0.00', '0.00', '686.00', null, '999', null, null, null, null, '380', '686', '0', '0', '0', '0', null, 'P040101_1', 'W3siaWQiOiIxMiIsIm5hbWUiOiLlh4Dph40iLCJ0eXBlIjoiMSIsInNwZWN2YWwiOltbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMSIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIzODBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9XV19XQ==', '/Uploads/Image/Goods/2017-07-01/5957ae443c956.png', '0', '0', '红参片', '精选长白山红参，参龄足，零添加，甄选切片，黄皮红心菊花纹，干度高不粘手，微苦回甘，参香浓郁。不添糖，真滋补！', '757', '0', null, null, '0', '0', '2', '', '1', '0', '0', '0', '0', '0', '0', '0', '1.00', '0', '0', '0', '', '686.00', '686.00', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/59587f88cf530.png\" title=\"\" alt=\"食用方法.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/595887abe932e.png\" title=\"\" alt=\"注意事项.png\"/></p>', '<p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/5959030f6c862.png\" title=\"\" alt=\"红参食谱_标题.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/5959032abeaa0.png\" title=\"\" alt=\"使用实例_红参茶.png\"/></p><p style=\"text-align: center;\"><img src=\"/Uploads/Editor/Image/2017-07-02/595908ea07181.png\" title=\"\" alt=\"使用实例_红参炖鸡汤.png\"/></p>', '/Uploads/qrcode/d/4/d41d8cd98f00b204e9800998ecf8427e.png', '3');
INSERT INTO `dycms_goods` VALUES ('10017', '7', '艾贴', 'goods1495174043247', '1', '3', '', '-1', '1495174043', '1504582452', '107', '1', '', null, '艾贴', '0.00', '0.00', '48.00', '0.00', '97', '0', null, null, null, '0', '0', '0', '0', '0', '0', null, 'goods1495174043247_0', null, '/Uploads/Image/Goods/2017-05-23/5923a054ea043.jpg', '0', '0', '艾贴', '', '0', '0', null, null, '0', '0', '2', '', '1', '0', '0', '0', '0', '1', '0', '0', '1.00', '0', '0', '0', '', '48.00', '48.00', '', '', '/Uploads/qrcode/d/4/d41d8cd98f00b204e9800998ecf8427e.png', '3');
INSERT INTO `dycms_goods` VALUES ('10018', '9', '黄土球温敷披肩', 'goods1495174273708', '1', '3', '', '-1', '1495174272', '1504582443', '107', '1', '', null, '黄土球温敷披肩', '0.00', '0.00', '28.00', '0.00', '64', '0', null, null, null, '0', '0', '0', '0', '0', '0', null, 'goods1495174273708_0', null, '/Uploads/Image/Goods/2017-05-24/59253dee81010.png', '0', '0', '黄土球温敷披', '黄土球温敷披肩', '0', '0', null, null, '0', '0', '2', '', '1', '0', '0', '0', '0', '1', '0', '0', '1.00', '0', '0', '0', '', '28.00', '28.00', '', '', '/Uploads/qrcode/d/4/d41d8cd98f00b204e9800998ecf8427e.png', '3');
INSERT INTO `dycms_goods` VALUES ('10019', '6', '姜贴', 'goods1495175628700', '1', '3', '', '-1', '1495175628', '1504582437', '107', '1', '<p>1</p>', null, '姜贴', '0.00', '0.00', '88.00', '0.00', '100', '0', null, null, null, '0', '0', '0', '0', '0', '0', null, 'goods1495175628700_0', null, '/Uploads/Image/Goods/2017-05-23/5923a06a83a28.jpg', '0', '0', '姜贴', '姜贴', '0', '0', null, null, '0', '0', '2', '', '1', '0', '0', '0', '0', '0', '0', '0', '1.00', '0', '0', '0', '', '88.00', '88.00', '<p>说明1<br/></p>', '', '/Uploads/qrcode/d/4/d41d8cd98f00b204e9800998ecf8427e.png', '3');
INSERT INTO `dycms_goods` VALUES ('10020', '8', '红糖粉', 'P030101', '1', '3', '', '-2', '1498545465', '1498545465', '1', '1', '<p style=\"text-align: center;\"><img src=\"/Uploads/E', null, '红糖,和煦堂', '0.00', '0.00', '36.00', null, '884', null, null, null, null, '500', '36', '0', '0', '96', '1', null, 'P030101_1', 'W3siaWQiOiIxMiIsIm5hbWUiOiLlh4Dph40iLCJ0eXBlIjoiMSIsInNwZWN2YWwiOltbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMCIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiI1MDBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9XSxbeyJuYW1lIjoidmFsX2lkIiwidmFsdWUiOiIxMDAwMyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoidmFsX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9uYW1lIiwidmFsdWUiOiIyNTBnIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJjaGFuZ2VfaW1nIiwidmFsdWUiOiIiLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6InNwZWNfdmFsdWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9XV19XQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', '0', '0', '红糖粉', '精选廉江荻蔗榨取，手工熬制而成，零添加，保留营养，原汁原味，色泽呈豆沙红，口感浓香，甜而不腻', '0', '0', null, null, '0', '0', '2', '', '1', '0', '1', '0', '1', '0', '0', '1', '1.00', '1', '1', '0', '', '20.00', '36.00', null, null, null, '0');

-- ----------------------------
-- Table structure for dycms_goodsbrand
-- ----------------------------
DROP TABLE IF EXISTS `dycms_goodsbrand`;
CREATE TABLE `dycms_goodsbrand` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '名称',
  `status` tinyint(4) DEFAULT '0' COMMENT '会员状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `url` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `content` text,
  `sort` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品品牌';

-- ----------------------------
-- Records of dycms_goodsbrand
-- ----------------------------
INSERT INTO `dycms_goodsbrand` VALUES ('3', '和煦堂', '1', '1494550942', '1494550942', '1', '1', 'www.hexutang.cn', '/Uploads/Image/GoodsBrand/2017-05-12/59150999434ce.png', null, '0');

-- ----------------------------
-- Table structure for dycms_goodscate
-- ----------------------------
DROP TABLE IF EXISTS `dycms_goodscate`;
CREATE TABLE `dycms_goodscate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '分类名',
  `alias` varchar(200) NOT NULL DEFAULT '' COMMENT '别名',
  `pid` int(11) DEFAULT '0' COMMENT '父分类id号',
  `type_id` int(11) DEFAULT '0' COMMENT '产品类型id号',
  `status` tinyint(4) DEFAULT '0' COMMENT '会员状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `cate_description` varchar(200) DEFAULT NULL COMMENT '描述',
  `coverpic` varchar(200) DEFAULT NULL COMMENT '促销封面',
  `mainpic` varchar(200) DEFAULT NULL COMMENT '分类图片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品目录分类';

-- ----------------------------
-- Records of dycms_goodscate
-- ----------------------------
INSERT INTO `dycms_goodscate` VALUES ('6', '姜', '姜系列', '0', '0', '1', '1494550448', '1498392171', '1', '1', '1', '姜茶，姜片，姜贴等', '/Uploads/Image/Category/2017-06-04/59337c87acdae.jpg', '/Uploads/Image/Category/2017-05-24/5924ed95a4b46.jpg');
INSERT INTO `dycms_goodscate` VALUES ('7', '艾', '艾系列', '0', '0', '1', '1494550505', '1498392178', '1', '1', '2', '艾贴，轻松灸等', '/Uploads/Image/Category/2017-06-04/59337c961f199.jpg', '/Uploads/Image/Category/2017-05-24/5924ee4f4de90.jpg');
INSERT INTO `dycms_goodscate` VALUES ('8', '伴侣', '伴侣系列', '0', '0', '1', '1494550527', '1498392136', '1', '1', '3', '红糖等', '/Uploads/Image/Category/2017-06-04/59337ca2484bd.jpg', '/Uploads/Image/Category/2017-05-24/5924ee60625ea.jpg');
INSERT INTO `dycms_goodscate` VALUES ('9', '温敷', '温敷系列', '0', '0', '0', '1494550551', '1499409941', '1', '114', '5', '黄土球温敷床垫，黄土球温敷枕头等', '', '/Uploads/Image/Category/2017-05-24/59253ba5ca908.jpg');
INSERT INTO `dycms_goodscate` VALUES ('10', '红参', '红参系列', '0', '0', '0', '1494915870', '1499409950', '1', '114', '2', '精选长白山特产红参，地道原料，传统工艺，甄选切片，纹理清晰，参香浓郁，味道微甘。不添糖，真滋补！', '/Uploads/Image/Category/2017-06-04/59337ccd66ec6.jpg', '/Uploads/Image/Category/2017-05-24/592537d085982.jpg');

-- ----------------------------
-- Table structure for dycms_goodsspec
-- ----------------------------
DROP TABLE IF EXISTS `dycms_goodsspec`;
CREATE TABLE `dycms_goodsspec` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '规格名称',
  `status` tinyint(4) DEFAULT '0' COMMENT '会员状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `type` tinyint(1) DEFAULT '1' COMMENT '类型（1=文字，2=图片）',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品规格类型表';

-- ----------------------------
-- Records of dycms_goodsspec
-- ----------------------------
INSERT INTO `dycms_goodsspec` VALUES ('12', '净重', '0', '1495615180', '1495772363', '1', '1', '1', '净重');

-- ----------------------------
-- Table structure for dycms_goodsspec_value
-- ----------------------------
DROP TABLE IF EXISTS `dycms_goodsspec_value`;
CREATE TABLE `dycms_goodsspec_value` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '规格名称',
  `spec_id` int(11) DEFAULT '0' COMMENT '规格id号',
  `status` tinyint(4) DEFAULT '0' COMMENT '会员状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `img` varchar(255) DEFAULT '' COMMENT '备注',
  `sort` int(11) DEFAULT '0',
  `value` varchar(256) DEFAULT NULL COMMENT '规格值',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10005 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品规格值表';

-- ----------------------------
-- Records of dycms_goodsspec_value
-- ----------------------------
INSERT INTO `dycms_goodsspec_value` VALUES ('10000', '500g', '12', '1', '1495615180', '1495772363', '1', '1', '', '1', '500g');
INSERT INTO `dycms_goodsspec_value` VALUES ('10001', '380g', '12', '1', '1495615180', '1495772363', '1', '1', '', '2', '380g');
INSERT INTO `dycms_goodsspec_value` VALUES ('10002', '260g', '12', '1', '1495772363', '1495772363', '1', '1', '', '3', '260g');
INSERT INTO `dycms_goodsspec_value` VALUES ('10003', '250g', '12', '1', '1495772363', '1495772363', '1', '1', '', '4', '250g');
INSERT INTO `dycms_goodsspec_value` VALUES ('10004', '200g', '12', '1', '1495772363', '1495772363', '1', '1', '', '5', '200g');

-- ----------------------------
-- Table structure for dycms_goodstype
-- ----------------------------
DROP TABLE IF EXISTS `dycms_goodstype`;
CREATE TABLE `dycms_goodstype` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) DEFAULT '' COMMENT '名称',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商品品类型';

-- ----------------------------
-- Records of dycms_goodstype
-- ----------------------------
INSERT INTO `dycms_goodstype` VALUES ('1', '销售产品', '1', '1452645751', '1462344291', null, '1', '0');
INSERT INTO `dycms_goodstype` VALUES ('2', '服务产品', '0', '1452743769', '1481863048', null, '1', '0');

-- ----------------------------
-- Table structure for dycms_goods_like
-- ----------------------------
DROP TABLE IF EXISTS `dycms_goods_like`;
CREATE TABLE `dycms_goods_like` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) DEFAULT '0' COMMENT '用户id号',
  `goods_id` int(11) DEFAULT '0' COMMENT '商品d号',
  `status` tinyint(4) DEFAULT '0' COMMENT '会员状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `openid` varchar(255) DEFAULT NULL COMMENT '微信用户id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10037 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='喜欢商品关系表';

-- ----------------------------
-- Records of dycms_goods_like
-- ----------------------------

-- ----------------------------
-- Table structure for dycms_order
-- ----------------------------
DROP TABLE IF EXISTS `dycms_order`;
CREATE TABLE `dycms_order` (
  `id` int(11) unsigned NOT NULL,
  `order_no` varchar(20) NOT NULL COMMENT '订单编码',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '下单类型：1：购物，2：代理商，3：服务 ',
  PRIMARY KEY (`id`),
  KEY `order_no` (`order_no`) USING BTREE,
  KEY `type` (`type`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dycms_order
-- ----------------------------
INSERT INTO `dycms_order` VALUES ('1706109549', '14170610593b5509d31a', '14');
INSERT INTO `dycms_order` VALUES ('1706109420', '14170610593b5e4b793c', '14');
INSERT INTO `dycms_order` VALUES ('1706104274', '12170610593b75fc1a28', '12');
INSERT INTO `dycms_order` VALUES ('1706103654', '170610593be18e7e115', '1');
INSERT INTO `dycms_order` VALUES ('1706101199', '170610593beb8233847', '1');
INSERT INTO `dycms_order` VALUES ('1706108591', '12170610593bf270c9aa', '12');
INSERT INTO `dycms_order` VALUES ('1706106017', '12170610593bf2afe916', '12');
INSERT INTO `dycms_order` VALUES ('1706106881', '170610593bf355bfe29', '1');
INSERT INTO `dycms_order` VALUES ('1706119746', '14170611593c8f44a52a', '14');
INSERT INTO `dycms_order` VALUES ('1706118181', '12170611593ca62d0adc', '12');
INSERT INTO `dycms_order` VALUES ('1706111392', '170611593ce500b2a62', '1');
INSERT INTO `dycms_order` VALUES ('1706117992', '170611593d067bb5b95', '1');
INSERT INTO `dycms_order` VALUES ('1706115644', '14170611593d06c8a943', '14');
INSERT INTO `dycms_order` VALUES ('1706119373', 'AO1706488520', '2');
INSERT INTO `dycms_order` VALUES ('170611350', 'AD1706581899', '4');
INSERT INTO `dycms_order` VALUES ('1706115818', '14170611593d0aa2cf9b', '14');
INSERT INTO `dycms_order` VALUES ('1706118652', 'AO1706385437', '2');
INSERT INTO `dycms_order` VALUES ('1706112582', 'AD1706756425', '4');
INSERT INTO `dycms_order` VALUES ('1706116491', '14170611593d3a2b2c4f', '14');
INSERT INTO `dycms_order` VALUES ('1706117406', '14170611593d412a516b', '14');
INSERT INTO `dycms_order` VALUES ('1706125182', '12170612593e336017d6', '12');
INSERT INTO `dycms_order` VALUES ('1706129941', '14170612593e39f4b5c4', '14');
INSERT INTO `dycms_order` VALUES ('1706123398', '14170612593e3ae9a705', '14');
INSERT INTO `dycms_order` VALUES ('1706123814', '14170612593e3bf3199a', '14');
INSERT INTO `dycms_order` VALUES ('1706123152', 'AO1706450762', '2');
INSERT INTO `dycms_order` VALUES ('1706122579', 'AD1706142623', '4');
INSERT INTO `dycms_order` VALUES ('1706124156', 'AO1706503333', '2');
INSERT INTO `dycms_order` VALUES ('1706128381', '170612593e8213e5b9a', '1');
INSERT INTO `dycms_order` VALUES ('17061294', '12170612593ea315e20c', '12');
INSERT INTO `dycms_order` VALUES ('1706135258', 'AO1706565916', '2');
INSERT INTO `dycms_order` VALUES ('1706139743', 'AD1706671788', '4');
INSERT INTO `dycms_order` VALUES ('1706134030', '12170613593f49502283', '12');
INSERT INTO `dycms_order` VALUES ('1706131724', '14170613593f8c2ee188', '14');
INSERT INTO `dycms_order` VALUES ('170613247', '14170613593fceb0a1a9', '14');
INSERT INTO `dycms_order` VALUES ('1706135630', '14170613593ffb93b841', '14');
INSERT INTO `dycms_order` VALUES ('1706147204', '1417061459408abca34e', '14');
INSERT INTO `dycms_order` VALUES ('1706149407', '1417061459408c56c4d1', '14');
INSERT INTO `dycms_order` VALUES ('1706147394', '1417061459408d7ddc1b', '14');
INSERT INTO `dycms_order` VALUES ('1706149553', '14170614594091439643', '14');
INSERT INTO `dycms_order` VALUES ('1706145639', '141706145940959c2e78', '14');
INSERT INTO `dycms_order` VALUES ('170614423', '12170614594099557166', '12');
INSERT INTO `dycms_order` VALUES ('1706147342', '141706145940a30783e3', '14');
INSERT INTO `dycms_order` VALUES ('170614564', '141706145940a5fe6e1d', '14');
INSERT INTO `dycms_order` VALUES ('1706146834', '141706145940ab467e6c', '14');
INSERT INTO `dycms_order` VALUES ('1706143032', 'AO1706081018', '2');
INSERT INTO `dycms_order` VALUES ('1706142863', 'AD1706917527', '4');
INSERT INTO `dycms_order` VALUES ('1706148642', '141706145940c2a776ce', '14');
INSERT INTO `dycms_order` VALUES ('1706145427', '1217061459411791e645', '12');
INSERT INTO `dycms_order` VALUES ('1706146378', '17061459413a9423211', '1');
INSERT INTO `dycms_order` VALUES ('170614214', 'AO1706519674', '2');
INSERT INTO `dycms_order` VALUES ('1706144998', '17061459413b6a06655', '1');
INSERT INTO `dycms_order` VALUES ('1706142447', '17061459413c6618a7c', '1');
INSERT INTO `dycms_order` VALUES ('1706142956', '17061459413cdc0d72d', '1');
INSERT INTO `dycms_order` VALUES ('1706148667', '17061459413de248fa2', '1');
INSERT INTO `dycms_order` VALUES ('1706143770', '17061459413e917764e', '1');
INSERT INTO `dycms_order` VALUES ('1706147967', '17061459414013b9c95', '1');
INSERT INTO `dycms_order` VALUES ('1706145717', '1217061459414280c8fb', '12');
INSERT INTO `dycms_order` VALUES ('1706146547', '170614594142a959264', '1');
INSERT INTO `dycms_order` VALUES ('1706149302', '12170614594147c935b0', '12');
INSERT INTO `dycms_order` VALUES ('1706141631', 'AO1706277164', '2');
INSERT INTO `dycms_order` VALUES ('1706148820', 'AO1706207183', '2');
INSERT INTO `dycms_order` VALUES ('1706155851', 'AO1706774185', '2');
INSERT INTO `dycms_order` VALUES ('1706158944', 'AO1706175031', '2');
INSERT INTO `dycms_order` VALUES ('1706155707', '121706155941ea7c5dbf', '12');
INSERT INTO `dycms_order` VALUES ('170615967', '170615594211b47a3dc', '1');
INSERT INTO `dycms_order` VALUES ('1706158726', '121706155942308da0fb', '12');
INSERT INTO `dycms_order` VALUES ('1706154966', 'AO1706571113', '2');
INSERT INTO `dycms_order` VALUES ('1706154379', 'AD1706821231', '4');
INSERT INTO `dycms_order` VALUES ('1706153452', '1417061559424fb36802', '14');
INSERT INTO `dycms_order` VALUES ('1706155630', 'AO1706043672', '2');
INSERT INTO `dycms_order` VALUES ('1706159139', 'AD1706580946', '4');
INSERT INTO `dycms_order` VALUES ('1706152357', 'AO1706450497', '2');
INSERT INTO `dycms_order` VALUES ('1706158122', 'AO1706262107', '2');
INSERT INTO `dycms_order` VALUES ('170615494', 'AO1706017406', '2');
INSERT INTO `dycms_order` VALUES ('1706155815', 'AD1706253652', '4');
INSERT INTO `dycms_order` VALUES ('1706151126', 'AO1706637327', '2');
INSERT INTO `dycms_order` VALUES ('1706151451', 'AO1706464460', '2');
INSERT INTO `dycms_order` VALUES ('1706159430', 'AD1706068643', '4');
INSERT INTO `dycms_order` VALUES ('1706153875', 'AO1706630030', '2');
INSERT INTO `dycms_order` VALUES ('1706159355', 'AO1706801611', '2');
INSERT INTO `dycms_order` VALUES ('1706167375', '1217061659433bf74dfc', '12');
INSERT INTO `dycms_order` VALUES ('170616674', '1417061659435e7e5a9a', '14');
INSERT INTO `dycms_order` VALUES ('1706163554', 'AO1706691424', '2');
INSERT INTO `dycms_order` VALUES ('1706166959', '12170616594363b9181d', '12');
INSERT INTO `dycms_order` VALUES ('1706163022', 'AO1706323854', '2');
INSERT INTO `dycms_order` VALUES ('1706162570', 'AD1706087219', '4');
INSERT INTO `dycms_order` VALUES ('1706161762', '14170616594382182bee', '14');
INSERT INTO `dycms_order` VALUES ('1706163831', 'AO1706732662', '2');
INSERT INTO `dycms_order` VALUES ('1706167843', 'AD1706172832', '4');
INSERT INTO `dycms_order` VALUES ('1706161454', 'AO1706266348', '2');
INSERT INTO `dycms_order` VALUES ('1706164632', '141706165943b16ac116', '14');
INSERT INTO `dycms_order` VALUES ('1706163432', 'AO1706962316', '2');
INSERT INTO `dycms_order` VALUES ('1706169666', 'AD1706763309', '4');
INSERT INTO `dycms_order` VALUES ('170616233', 'AO1706930354', '2');
INSERT INTO `dycms_order` VALUES ('170616678', '121706165943ed0aabc1', '12');
INSERT INTO `dycms_order` VALUES ('1706162004', 'AC1706014264', '14');
INSERT INTO `dycms_order` VALUES ('1706174325', '1706175944054525e3f', '1');
INSERT INTO `dycms_order` VALUES ('1706176612', 'AC1706910489', '14');
INSERT INTO `dycms_order` VALUES ('1706174663', 'AC1706306927', '14');
INSERT INTO `dycms_order` VALUES ('1706171759', 'AC1706169454', '14');
INSERT INTO `dycms_order` VALUES ('1706171701', 'AC1706471040', '14');
INSERT INTO `dycms_order` VALUES ('1706172803', 'AC1706710295', '14');
INSERT INTO `dycms_order` VALUES ('1706179091', '1217061759448e3e5515', '12');
INSERT INTO `dycms_order` VALUES ('1706171568', 'AO1706362156', '2');
INSERT INTO `dycms_order` VALUES ('1706173874', 'AO1706502114', '2');
INSERT INTO `dycms_order` VALUES ('1706174827', 'AD1706800025', '4');
INSERT INTO `dycms_order` VALUES ('170618966', '121706185945df010be0', '12');
INSERT INTO `dycms_order` VALUES ('170619589', 'AO1706113411', '2');
INSERT INTO `dycms_order` VALUES ('1706197214', 'AO1706429278', '2');
INSERT INTO `dycms_order` VALUES ('1706195555', 'AO1706345323', '2');
INSERT INTO `dycms_order` VALUES ('1706196006', 'AO1706651269', '2');
INSERT INTO `dycms_order` VALUES ('1706191597', 'AD1706758369', '4');
INSERT INTO `dycms_order` VALUES ('1706193668', 'AD1706118527', '4');
INSERT INTO `dycms_order` VALUES ('1706191347', 'AD1706929535', '4');
INSERT INTO `dycms_order` VALUES ('1706193762', 'AD1706925819', '4');
INSERT INTO `dycms_order` VALUES ('1706199069', 'AD1706062767', '4');
INSERT INTO `dycms_order` VALUES ('1706193615', 'AD1706248707', '4');
INSERT INTO `dycms_order` VALUES ('1706192563', 'AD1706079570', '4');
INSERT INTO `dycms_order` VALUES ('1706199220', 'AD1706665468', '4');
INSERT INTO `dycms_order` VALUES ('1706193704', 'AD1706263986', '4');
INSERT INTO `dycms_order` VALUES ('1706193294', 'AO1706961224', '2');
INSERT INTO `dycms_order` VALUES ('1706197444', 'AO1706694449', '2');
INSERT INTO `dycms_order` VALUES ('1706194888', 'AO1706203646', '2');
INSERT INTO `dycms_order` VALUES ('1706196593', 'AD1706335793', '4');
INSERT INTO `dycms_order` VALUES ('1706191464', 'AD1706919555', '4');
INSERT INTO `dycms_order` VALUES ('1706194110', 'AD1706477521', '4');
INSERT INTO `dycms_order` VALUES ('1706193342', '1217061959478e62ed7f', '12');
INSERT INTO `dycms_order` VALUES ('1706209796', '1706205948637fa22b9', '1');
INSERT INTO `dycms_order` VALUES ('1706206575', '1417062059487eb9d0bb', '14');
INSERT INTO `dycms_order` VALUES ('1706208143', '17062059487ff3bc712', '1');
INSERT INTO `dycms_order` VALUES ('1706209072', '12170620594882758ac9', '12');
INSERT INTO `dycms_order` VALUES ('1706203008', 'AO1706140010', '2');
INSERT INTO `dycms_order` VALUES ('1706205522', 'AD1706703386', '4');
INSERT INTO `dycms_order` VALUES ('1706206322', 'AO1706487243', '2');
INSERT INTO `dycms_order` VALUES ('1706207352', 'AO1706361634', '2');
INSERT INTO `dycms_order` VALUES ('1706208108', 'AO1706215462', '2');
INSERT INTO `dycms_order` VALUES ('1706204457', 'AO1706592044', '2');
INSERT INTO `dycms_order` VALUES ('1706209414', 'AD1706002810', '4');
INSERT INTO `dycms_order` VALUES ('1706206850', '141706205948eba4d543', '14');
INSERT INTO `dycms_order` VALUES ('1706209289', 'AO1706071852', '2');
INSERT INTO `dycms_order` VALUES ('1706205298', 'AO1706835517', '2');
INSERT INTO `dycms_order` VALUES ('1706217391', '121706215949d36f2295', '12');
INSERT INTO `dycms_order` VALUES ('1706219225', '141706215949e4585674', '14');
INSERT INTO `dycms_order` VALUES ('1706217667', '141706215949ebe020bf', '14');
INSERT INTO `dycms_order` VALUES ('1706218971', '12170621594a19a323ec', '12');
INSERT INTO `dycms_order` VALUES ('1706217541', '14170621594a7fda8808', '14');
INSERT INTO `dycms_order` VALUES ('1706226946', 'AO1706762710', '2');
INSERT INTO `dycms_order` VALUES ('1706229285', 'AO1706355298', '2');
INSERT INTO `dycms_order` VALUES ('1706225914', 'AD1706498268', '4');
INSERT INTO `dycms_order` VALUES ('1706229250', '12170622594b24f201ce', '12');
INSERT INTO `dycms_order` VALUES ('1706229877', '170622594b40e0c31de', '1');
INSERT INTO `dycms_order` VALUES ('170622883', 'AO1706448771', '2');
INSERT INTO `dycms_order` VALUES ('1706222755', 'AD1706549919', '4');
INSERT INTO `dycms_order` VALUES ('1706229209', 'AD1706364146', '4');
INSERT INTO `dycms_order` VALUES ('170622362', '14170622594b9f7bb258', '14');
INSERT INTO `dycms_order` VALUES ('1706220', '14170622594ba0401d7c', '14');
INSERT INTO `dycms_order` VALUES ('1706227794', 'AD1706072335', '4');
INSERT INTO `dycms_order` VALUES ('1706233744', 'AO1706926947', '2');
INSERT INTO `dycms_order` VALUES ('1706232035', 'AD1706625550', '4');
INSERT INTO `dycms_order` VALUES ('1706237753', 'AD1706347803', '4');
INSERT INTO `dycms_order` VALUES ('1706234284', 'AD1706500180', '4');
INSERT INTO `dycms_order` VALUES ('1706235019', 'AO1706935005', '2');
INSERT INTO `dycms_order` VALUES ('1706232153', 'AD1706911170', '4');
INSERT INTO `dycms_order` VALUES ('1706236622', 'AO1706609013', '2');
INSERT INTO `dycms_order` VALUES ('1706233970', 'AD1706980951', '4');
INSERT INTO `dycms_order` VALUES ('1706253510', 'AD1706986569', '4');
INSERT INTO `dycms_order` VALUES ('1706256400', 'AO1706349443', '2');
INSERT INTO `dycms_order` VALUES ('1706255943', 'AD1706368063', '4');
INSERT INTO `dycms_order` VALUES ('1706257893', 'AO1706492269', '2');
INSERT INTO `dycms_order` VALUES ('1706253837', 'AO1706769731', '2');
INSERT INTO `dycms_order` VALUES ('1706255417', 'AO1706349189', '2');
INSERT INTO `dycms_order` VALUES ('170626759', '170626595053b3d00c8', '1');
INSERT INTO `dycms_order` VALUES ('1706261423', 'AD1706513656', '4');
INSERT INTO `dycms_order` VALUES ('1706262878', 'AD1706877487', '4');
INSERT INTO `dycms_order` VALUES ('1706265313', 'AD1706183088', '4');
INSERT INTO `dycms_order` VALUES ('170626313', 'AD1706512184', '4');
INSERT INTO `dycms_order` VALUES ('1706263881', 'AD1706532915', '4');
INSERT INTO `dycms_order` VALUES ('1706263408', 'AD1706292427', '4');
INSERT INTO `dycms_order` VALUES ('1706262661', '170626595097fa99eea', '1');
INSERT INTO `dycms_order` VALUES ('1706269348', 'AO1706574468', '2');
INSERT INTO `dycms_order` VALUES ('170626113', '121706265950e06169ee', '12');
INSERT INTO `dycms_order` VALUES ('1706266496', 'AO1706366415', '2');
INSERT INTO `dycms_order` VALUES ('1706268296', 'AD1706926608', '4');
INSERT INTO `dycms_order` VALUES ('1706277786', 'AD1706156006', '4');
INSERT INTO `dycms_order` VALUES ('1706273668', '12170627595207d2ed3f', '12');
INSERT INTO `dycms_order` VALUES ('1706272314', 'AD1706349360', '4');
INSERT INTO `dycms_order` VALUES ('1706279778', 'AO1706895123', '2');
INSERT INTO `dycms_order` VALUES ('1706284981', '1706285952fbba2f84f', '1');
INSERT INTO `dycms_order` VALUES ('170628208', 'AD1706336117', '4');
INSERT INTO `dycms_order` VALUES ('1706288732', '1217062859535412b24d', '12');
INSERT INTO `dycms_order` VALUES ('1706283665', '1706285953570d3f594', '1');
INSERT INTO `dycms_order` VALUES ('1706283238', 'AD1706736298', '4');
INSERT INTO `dycms_order` VALUES ('1706299571', '17062959548fa976a6a', '1');
INSERT INTO `dycms_order` VALUES ('1706294049', '17062959549778c22b8', '1');
INSERT INTO `dycms_order` VALUES ('1706298007', 'AD1706987151', '4');
INSERT INTO `dycms_order` VALUES ('170629138', 'AD1706456647', '4');
INSERT INTO `dycms_order` VALUES ('170629561', 'AD1706724239', '4');
INSERT INTO `dycms_order` VALUES ('1706291105', '121706295954a5894139', '12');
INSERT INTO `dycms_order` VALUES ('1706294937', 'AO1706710178', '2');
INSERT INTO `dycms_order` VALUES ('1706296937', 'AD1706736101', '4');
INSERT INTO `dycms_order` VALUES ('1706294224', 'AO1706342660', '2');
INSERT INTO `dycms_order` VALUES ('1706297456', 'AD1706388114', '4');
INSERT INTO `dycms_order` VALUES ('1706293986', 'AO1706596838', '2');
INSERT INTO `dycms_order` VALUES ('170630142', '1706305955c199578da', '1');
INSERT INTO `dycms_order` VALUES ('1706306308', '1706305955c28467559', '1');
INSERT INTO `dycms_order` VALUES ('1706307750', '1706305955c2c9cafba', '1');
INSERT INTO `dycms_order` VALUES ('1706302263', '17063059560005684b3', '1');
INSERT INTO `dycms_order` VALUES ('1706308501', 'AD1706145430', '4');
INSERT INTO `dycms_order` VALUES ('1706308940', 'AD1706191615', '4');
INSERT INTO `dycms_order` VALUES ('1706309687', '1217063059563b61cdfb', '12');
INSERT INTO `dycms_order` VALUES ('1706303566', 'AD1706985560', '4');
INSERT INTO `dycms_order` VALUES ('1706307364', 'AD1706288417', '4');
INSERT INTO `dycms_order` VALUES ('1707018186', '12170701595713871d36', '12');
INSERT INTO `dycms_order` VALUES ('1707012279', '121707015957489113d8', '12');
INSERT INTO `dycms_order` VALUES ('1707011633', 'AD1707815748', '4');
INSERT INTO `dycms_order` VALUES ('1707025631', 'AD1707157295', '4');
INSERT INTO `dycms_order` VALUES ('1707028462', 'AO1707873720', '2');
INSERT INTO `dycms_order` VALUES ('170702971', '1217070259590a87cea4', '12');
INSERT INTO `dycms_order` VALUES ('170702171', '1217070259590b3d904c', '12');
INSERT INTO `dycms_order` VALUES ('1707031385', '121707035959a8e0046b', '12');
INSERT INTO `dycms_order` VALUES ('170703950', 'AD1707000233', '4');
INSERT INTO `dycms_order` VALUES ('1707034280', '170703595a5df6e1677', '1');
INSERT INTO `dycms_order` VALUES ('1707031326', '170703595a5ec5cf5f0', '1');
INSERT INTO `dycms_order` VALUES ('1707042542', 'AD1707188904', '4');
INSERT INTO `dycms_order` VALUES ('1707041724', '12170704595af6c9a45a', '12');
INSERT INTO `dycms_order` VALUES ('1707048681', 'AO1707214252', '2');
INSERT INTO `dycms_order` VALUES ('1707046426', 'AD1707586790', '4');
INSERT INTO `dycms_order` VALUES ('1707048877', '12170704595b3d075699', '12');
INSERT INTO `dycms_order` VALUES ('1707044099', 'AD1707842637', '4');
INSERT INTO `dycms_order` VALUES ('1707041892', 'AO1707754597', '2');
INSERT INTO `dycms_order` VALUES ('1707042814', '170704595ba0ead670e', '1');
INSERT INTO `dycms_order` VALUES ('1707045602', '170704595ba6c3c6c3e', '1');
INSERT INTO `dycms_order` VALUES ('1707043707', '170704595ba7db6cc6b', '1');
INSERT INTO `dycms_order` VALUES ('1707052718', '12170705595c4d7f7ba5', '12');
INSERT INTO `dycms_order` VALUES ('1707059509', '170705595cf6dbda7ca', '1');
INSERT INTO `dycms_order` VALUES ('1707051251', 'AD1707090753', '4');
INSERT INTO `dycms_order` VALUES ('170706626', '12170706595da20538ac', '12');
INSERT INTO `dycms_order` VALUES ('1707063714', '12170706595da6a00044', '12');
INSERT INTO `dycms_order` VALUES ('1707067773', 'AD1707838148', '4');
INSERT INTO `dycms_order` VALUES ('1707063068', 'AD1707215239', '4');
INSERT INTO `dycms_order` VALUES ('170706822', 'AO1707126138', '2');
INSERT INTO `dycms_order` VALUES ('1707065523', 'AO1707840316', '2');
INSERT INTO `dycms_order` VALUES ('1707073894', '12170707595eeb6be290', '12');
INSERT INTO `dycms_order` VALUES ('1707073701', '12170707595f31931482', '12');
INSERT INTO `dycms_order` VALUES ('1707074349', 'AD1707699374', '4');
INSERT INTO `dycms_order` VALUES ('170708231', 'AD1707275605', '4');
INSERT INTO `dycms_order` VALUES ('1707085404', '1217070859608445a107', '12');
INSERT INTO `dycms_order` VALUES ('1707092534', 'AO1707295496', '2');
INSERT INTO `dycms_order` VALUES ('1707094787', 'AO1707494693', '2');
INSERT INTO `dycms_order` VALUES ('1707096806', 'AD1707855745', '4');
INSERT INTO `dycms_order` VALUES ('1707095489', '121707095961a5dcef49', '12');
INSERT INTO `dycms_order` VALUES ('1707098466', 'AD1707176989', '4');
INSERT INTO `dycms_order` VALUES ('1707094576', '121707095961d48d9c45', '12');
INSERT INTO `dycms_order` VALUES ('170709727', 'AO1707970675', '2');
INSERT INTO `dycms_order` VALUES ('1707092763', 'AD1707900249', '4');
INSERT INTO `dycms_order` VALUES ('1707094241', 'AO1707887729', '2');
INSERT INTO `dycms_order` VALUES ('170709860', 'AD1707479824', '4');
INSERT INTO `dycms_order` VALUES ('170709531', 'AO1707344795', '2');
INSERT INTO `dycms_order` VALUES ('1707105598', '121707105962e04f7327', '12');
INSERT INTO `dycms_order` VALUES ('1707102080', '121707105962e04fdf45', '12');
INSERT INTO `dycms_order` VALUES ('1707103849', 'AD1707372035', '4');
INSERT INTO `dycms_order` VALUES ('170710626', '12170710596326100d3a', '12');
INSERT INTO `dycms_order` VALUES ('1707119809', '1217071159643e9944da', '12');
INSERT INTO `dycms_order` VALUES ('1707115134', '17071159645bf4bd22b', '1');
INSERT INTO `dycms_order` VALUES ('1707113562', '170711596471cd04289', '1');
INSERT INTO `dycms_order` VALUES ('1707116405', '141707115964745abf66', '14');
INSERT INTO `dycms_order` VALUES ('1707119404', '121707115964ea120ddf', '12');
INSERT INTO `dycms_order` VALUES ('1707121056', '12170712596582fdd26e', '12');
INSERT INTO `dycms_order` VALUES ('1707125723', '121707125965a0906187', '12');
INSERT INTO `dycms_order` VALUES ('1707125030', '1707125965b39b83b5e', '1');
INSERT INTO `dycms_order` VALUES ('1707128426', 'AD1707223819', '4');
INSERT INTO `dycms_order` VALUES ('1707131123', '121707135966d45f026e', '12');
INSERT INTO `dycms_order` VALUES ('1707135160', '1707135966e11a60ae6', '1');
INSERT INTO `dycms_order` VALUES ('1707134613', '121707135967164909d6', '12');
INSERT INTO `dycms_order` VALUES ('1707135783', 'AD1707965688', '4');
INSERT INTO `dycms_order` VALUES ('1707138384', 'AD1707287584', '4');
INSERT INTO `dycms_order` VALUES ('1707145955', '12170714596825db7d3e', '12');
INSERT INTO `dycms_order` VALUES ('1707142551', 'AD1707485598', '4');
INSERT INTO `dycms_order` VALUES ('17071412', 'AO1707420841', '2');
INSERT INTO `dycms_order` VALUES ('1707157577', '121707155969774ed7a3', '12');
INSERT INTO `dycms_order` VALUES ('170715515', '121707155969bd8e4a74', '12');
INSERT INTO `dycms_order` VALUES ('1707165547', '12170716596ae253c9dc', '12');
INSERT INTO `dycms_order` VALUES ('1707174682', '12170717596c1a4ce1e9', '12');
INSERT INTO `dycms_order` VALUES ('170717691', '12170717596ca0c3290e', '12');
INSERT INTO `dycms_order` VALUES ('1707173072', 'AO1707359422', '2');
INSERT INTO `dycms_order` VALUES ('1707182837', '12170718596d6c1a6adc', '12');
INSERT INTO `dycms_order` VALUES ('1707188141', 'AD1707998108', '4');
INSERT INTO `dycms_order` VALUES ('1707184827', '12170718596db21a7b00', '12');
INSERT INTO `dycms_order` VALUES ('1707182687', '170718596db97ec9844', '1');
INSERT INTO `dycms_order` VALUES ('1707185376', 'AD1707210616', '4');
INSERT INTO `dycms_order` VALUES ('1707182539', 'AD1707365742', '4');
INSERT INTO `dycms_order` VALUES ('1707185478', 'AD1707085399', '4');
INSERT INTO `dycms_order` VALUES ('1707198424', '12170719596ebd87669b', '12');
INSERT INTO `dycms_order` VALUES ('1707196619', '12170719596ebd994b15', '12');
INSERT INTO `dycms_order` VALUES ('170719757', '12170719596f03cbf0f0', '12');
INSERT INTO `dycms_order` VALUES ('1707208865', '1217072059700f0070a0', '12');
INSERT INTO `dycms_order` VALUES ('1707208951', '121707205970551990a1', '12');
INSERT INTO `dycms_order` VALUES ('1707207121', '121707205970669b4046', '12');
INSERT INTO `dycms_order` VALUES ('1707207143', '121707205970670abbb3', '12');
INSERT INTO `dycms_order` VALUES ('1707207226', '12170720597067fabd7c', '12');
INSERT INTO `dycms_order` VALUES ('1707203455', '121707205970689f3a69', '12');
INSERT INTO `dycms_order` VALUES ('1707202276', '1217072059706bd29e1d', '12');
INSERT INTO `dycms_order` VALUES ('1707201887', '1217072059706c459421', '12');
INSERT INTO `dycms_order` VALUES ('1707209219', '1217072059706d02b416', '12');
INSERT INTO `dycms_order` VALUES ('1707205058', '12170720597076536c9d', '12');
INSERT INTO `dycms_order` VALUES ('1707209501', '12170720597077a486bb', '12');
INSERT INTO `dycms_order` VALUES ('170720341', 'AD1707626966', '4');
INSERT INTO `dycms_order` VALUES ('1707202872', 'AO1707131534', '2');
INSERT INTO `dycms_order` VALUES ('170720173', 'AO1707985312', '2');
INSERT INTO `dycms_order` VALUES ('1707205753', 'AO1707840448', '2');
INSERT INTO `dycms_order` VALUES ('170721735', '121707215971604b626c', '12');
INSERT INTO `dycms_order` VALUES ('1707213826', '12170721597166b00c3b', '12');
INSERT INTO `dycms_order` VALUES ('1707218772', '1217072159716d845eda', '12');
INSERT INTO `dycms_order` VALUES ('1707212329', '1217072159716d980e98', '12');
INSERT INTO `dycms_order` VALUES ('1707216203', '121707215971702692e6', '12');
INSERT INTO `dycms_order` VALUES ('170721564', '121707215971711ed369', '12');
INSERT INTO `dycms_order` VALUES ('1707214304', '12170721597179b2958a', '12');
INSERT INTO `dycms_order` VALUES ('1707216018', '12170721597179c9641b', '12');
INSERT INTO `dycms_order` VALUES ('1707218810', '1217072159717a755d0d', '12');
INSERT INTO `dycms_order` VALUES ('1707212887', 'AD1707296268', '4');
INSERT INTO `dycms_order` VALUES ('170721874', '121707215971a68eb018', '12');
INSERT INTO `dycms_order` VALUES ('1707214183', '1707215971d2e226822', '1');
INSERT INTO `dycms_order` VALUES ('1707212355', '141707215971f05edc2e', '14');
INSERT INTO `dycms_order` VALUES ('1707218071', '121707215971f21c43bd', '12');
INSERT INTO `dycms_order` VALUES ('1707216416', 'AD1707197315', '4');
INSERT INTO `dycms_order` VALUES ('170721272', '141707215971f3f8c845', '14');
INSERT INTO `dycms_order` VALUES ('1707213170', '141707215971f8e1d35b', '14');
INSERT INTO `dycms_order` VALUES ('1707215840', '12170721597201c6761e', '12');
INSERT INTO `dycms_order` VALUES ('1707211124', '12170721597201e770a6', '12');
INSERT INTO `dycms_order` VALUES ('1707213073', '121707215972025c8824', '12');
INSERT INTO `dycms_order` VALUES ('1707214796', '170721597203ca01306', '1');
INSERT INTO `dycms_order` VALUES ('1707212234', '1417072159720a58a413', '14');
INSERT INTO `dycms_order` VALUES ('1707219340', '1217072159720a993bfe', '12');
INSERT INTO `dycms_order` VALUES ('1707212077', 'AO1707398582', '2');
INSERT INTO `dycms_order` VALUES ('1707225887', '121707225972b2098705', '12');
INSERT INTO `dycms_order` VALUES ('1707227841', 'AO1707989840', '2');
INSERT INTO `dycms_order` VALUES ('1707222133', '141707225972e0aa5119', '14');
INSERT INTO `dycms_order` VALUES ('1707225942', '121707225972f8106506', '12');
INSERT INTO `dycms_order` VALUES ('1707226196', '1707225973155754281', '1');
INSERT INTO `dycms_order` VALUES ('1707224951', 'AD1707891230', '4');
INSERT INTO `dycms_order` VALUES ('1707239789', '121707235974036b8510', '12');
INSERT INTO `dycms_order` VALUES ('1707233609', 'AO1707267068', '2');
INSERT INTO `dycms_order` VALUES ('1707234633', 'AD1707527280', '4');
INSERT INTO `dycms_order` VALUES ('1707248750', '12170724597554c8d7bb', '12');
INSERT INTO `dycms_order` VALUES ('1707246257', '1217072459755b98553a', '12');
INSERT INTO `dycms_order` VALUES ('1707244581', '1217072459759b13118b', '12');
INSERT INTO `dycms_order` VALUES ('1707244059', '170724597615d5d1abf', '1');
INSERT INTO `dycms_order` VALUES ('1707248139', '17072459761672e87ae', '1');
INSERT INTO `dycms_order` VALUES ('1707247719', 'AO1707979401', '2');
INSERT INTO `dycms_order` VALUES ('1707259415', '121707255976a661ead8', '12');
INSERT INTO `dycms_order` VALUES ('170725202', 'AD1707372637', '4');
INSERT INTO `dycms_order` VALUES ('17072549', 'AD1707049233', '4');
INSERT INTO `dycms_order` VALUES ('1707257250', '1217072559771550bafd', '12');
INSERT INTO `dycms_order` VALUES ('1707263878', 'AD1707594380', '4');
INSERT INTO `dycms_order` VALUES ('1707262776', 'AD1707788394', '4');
INSERT INTO `dycms_order` VALUES ('1707263420', '121707265977f8001055', '12');
INSERT INTO `dycms_order` VALUES ('1707268310', 'AD1707546696', '4');
INSERT INTO `dycms_order` VALUES ('1707262548', '1217072659783e1153b3', '12');
INSERT INTO `dycms_order` VALUES ('1707269279', '1707265978a5681c2fc', '1');
INSERT INTO `dycms_order` VALUES ('1707271886', '1217072759794950bc83', '12');
INSERT INTO `dycms_order` VALUES ('1707272901', '17072759798101e74fa', '1');
INSERT INTO `dycms_order` VALUES ('1707276476', '1217072759798f9b8e8d', '12');
INSERT INTO `dycms_order` VALUES ('1707276751', 'AO1707823062', '2');
INSERT INTO `dycms_order` VALUES ('1707276340', 'AD1707604797', '4');
INSERT INTO `dycms_order` VALUES ('1707279644', '1707275979e7f3d0e94', '1');
INSERT INTO `dycms_order` VALUES ('1707279904', 'AD1707564019', '4');
INSERT INTO `dycms_order` VALUES ('1707284859', '12170728597a9af0875f', '12');
INSERT INTO `dycms_order` VALUES ('1707283101', 'AD1707925048', '4');
INSERT INTO `dycms_order` VALUES ('1707285775', '12170728597ae10ac84d', '12');
INSERT INTO `dycms_order` VALUES ('1707283916', 'AD1707640911', '4');
INSERT INTO `dycms_order` VALUES ('1707283956', '170728597b0ef621a83', '1');
INSERT INTO `dycms_order` VALUES ('1707292380', 'AO1707914844', '2');
INSERT INTO `dycms_order` VALUES ('1707299256', '12170729597befe81ba1', '12');
INSERT INTO `dycms_order` VALUES ('1707305497', '12170730597d3dc5f10a', '12');
INSERT INTO `dycms_order` VALUES ('1707311665', '12170731597e8f61160d', '12');
INSERT INTO `dycms_order` VALUES ('1707313368', '14170731597e9d4e3e0f', '14');
INSERT INTO `dycms_order` VALUES ('1707316055', 'AO1707466206', '2');
INSERT INTO `dycms_order` VALUES ('1707315616', '12170731597ed5941c57', '12');
INSERT INTO `dycms_order` VALUES ('1707311440', '12170731597ed5942dbf', '12');
INSERT INTO `dycms_order` VALUES ('1707314825', 'AD1707340759', '4');
INSERT INTO `dycms_order` VALUES ('1708019658', '12170801597fe1540125', '12');
INSERT INTO `dycms_order` VALUES ('1708016286', '121708015980270e3e95', '12');
INSERT INTO `dycms_order` VALUES ('170801779', 'AO1708606381', '2');
INSERT INTO `dycms_order` VALUES ('1708011065', '17080159807f0b4ff93', '1');
INSERT INTO `dycms_order` VALUES ('1708023016', '12170802598132505320', '12');
INSERT INTO `dycms_order` VALUES ('1708027472', 'AO1708545774', '2');
INSERT INTO `dycms_order` VALUES ('1708024678', 'AD1708259607', '4');
INSERT INTO `dycms_order` VALUES ('1708024047', '12170802598178a78cf9', '12');
INSERT INTO `dycms_order` VALUES ('170803127', '12170803598283ea3871', '12');
INSERT INTO `dycms_order` VALUES ('1708039058', '121708035982ca0b6890', '12');
INSERT INTO `dycms_order` VALUES ('1708047388', '121708045983d54adad0', '12');
INSERT INTO `dycms_order` VALUES ('1708046927', '1217080459841b93d1a0', '12');
INSERT INTO `dycms_order` VALUES ('1708042316', 'AD1708615987', '4');
INSERT INTO `dycms_order` VALUES ('1708051167', '1217080559852bd2cfe7', '12');
INSERT INTO `dycms_order` VALUES ('170805910', '1217080559856d18189b', '12');
INSERT INTO `dycms_order` VALUES ('1708059531', '1217080559856d18d57d', '12');
INSERT INTO `dycms_order` VALUES ('1708063018', 'AO1708645488', '2');
INSERT INTO `dycms_order` VALUES ('1708069321', 'AD1708772526', '4');
INSERT INTO `dycms_order` VALUES ('1708069172', 'AD1708884706', '4');
INSERT INTO `dycms_order` VALUES ('170806453', '1217080659873949809d', '12');
INSERT INTO `dycms_order` VALUES ('1708078006', '121708075987cc45e824', '12');
INSERT INTO `dycms_order` VALUES ('1708075081', '121708075988100b7052', '12');
INSERT INTO `dycms_order` VALUES ('1708076549', 'AD1708702954', '4');
INSERT INTO `dycms_order` VALUES ('1708076883', 'AD1708270568', '4');
INSERT INTO `dycms_order` VALUES ('1708078180', 'AO1708830240', '2');
INSERT INTO `dycms_order` VALUES ('1708085912', '1217080859892eb836e3', '12');
INSERT INTO `dycms_order` VALUES ('1708082333', '12170808598961ab17fc', '12');
INSERT INTO `dycms_order` VALUES ('1708084858', 'AD1708693124', '4');
INSERT INTO `dycms_order` VALUES ('1708099893', '12170809598a6cd01b41', '12');
INSERT INTO `dycms_order` VALUES ('1708091238', '12170809598ab322bc05', '12');
INSERT INTO `dycms_order` VALUES ('1708092270', 'AD1708623646', '4');
INSERT INTO `dycms_order` VALUES ('1708091105', '12170809598ade5b42a4', '12');
INSERT INTO `dycms_order` VALUES ('1708109919', '14170810598bb6897319', '14');
INSERT INTO `dycms_order` VALUES ('1708107900', '12170810598bc2ff0602', '12');
INSERT INTO `dycms_order` VALUES ('1708108290', '12170810598c048cedb0', '12');
INSERT INTO `dycms_order` VALUES ('1708106256', '12170810598c04b1e0c4', '12');
INSERT INTO `dycms_order` VALUES ('1708112179', '12170811598d10758430', '12');
INSERT INTO `dycms_order` VALUES ('1708118216', 'AO1708433476', '2');
INSERT INTO `dycms_order` VALUES ('1708118970', 'AD1708763813', '4');
INSERT INTO `dycms_order` VALUES ('1708115697', 'AD1708502173', '4');
INSERT INTO `dycms_order` VALUES ('1708114661', 'AD1708825602', '4');
INSERT INTO `dycms_order` VALUES ('1708116438', '170811598d533b64e41', '1');
INSERT INTO `dycms_order` VALUES ('1708116227', '12170811598d54423573', '12');
INSERT INTO `dycms_order` VALUES ('1708117571', 'AO1708992313', '2');
INSERT INTO `dycms_order` VALUES ('170811849', '170811598d9bdc1fddb', '1');
INSERT INTO `dycms_order` VALUES ('1708125672', '12170812598e61bd6a40', '12');
INSERT INTO `dycms_order` VALUES ('1708122972', 'AO1708897478', '2');
INSERT INTO `dycms_order` VALUES ('1708121684', 'AO1708751662', '2');
INSERT INTO `dycms_order` VALUES ('1708132441', 'AO1708590678', '2');
INSERT INTO `dycms_order` VALUES ('1708133452', 'AD1708910666', '4');
INSERT INTO `dycms_order` VALUES ('170813750', '12170813598fe36fbf29', '12');
INSERT INTO `dycms_order` VALUES ('1708138539', 'AD1708944119', '4');
INSERT INTO `dycms_order` VALUES ('1708139995', 'AD1708297788', '4');
INSERT INTO `dycms_order` VALUES ('1708138454', 'AD1708790363', '4');
INSERT INTO `dycms_order` VALUES ('1708144507', '121708145991046857ac', '12');
INSERT INTO `dycms_order` VALUES ('1708148965', 'AO1708786089', '2');
INSERT INTO `dycms_order` VALUES ('1708149702', 'AD1708376232', '4');
INSERT INTO `dycms_order` VALUES ('1708143735', 'AD1708285539', '4');
INSERT INTO `dycms_order` VALUES ('1708147260', 'AO1708579245', '2');
INSERT INTO `dycms_order` VALUES ('1708142868', '1217081459914a8f28d7', '12');
INSERT INTO `dycms_order` VALUES ('1708156373', '121708155992560dedcc', '12');
INSERT INTO `dycms_order` VALUES ('1708153105', '1217081559929b6fd9f1', '12');
INSERT INTO `dycms_order` VALUES ('1708154491', 'AD1708898108', '4');
INSERT INTO `dycms_order` VALUES ('1708152810', 'AO1708434601', '2');
INSERT INTO `dycms_order` VALUES ('170815847', 'AD1708726721', '4');
INSERT INTO `dycms_order` VALUES ('1708162616', '121708165993a78f42b5', '12');
INSERT INTO `dycms_order` VALUES ('1708165151', '121708165993ed8fbba0', '12');
INSERT INTO `dycms_order` VALUES ('170816485', 'AD1708051575', '4');
INSERT INTO `dycms_order` VALUES ('1708173092', '121708175994f8e48ed2', '12');
INSERT INTO `dycms_order` VALUES ('1708176176', '1417081759950ffb95f2', '14');
INSERT INTO `dycms_order` VALUES ('1708179141', '1217081759953f0e52ef', '12');
INSERT INTO `dycms_order` VALUES ('1708187159', '1217081859964a5a42da', '12');
INSERT INTO `dycms_order` VALUES ('170818419', 'AO1708974801', '2');
INSERT INTO `dycms_order` VALUES ('1708184679', 'AD1708610706', '4');
INSERT INTO `dycms_order` VALUES ('1708185965', '1217081859969097627b', '12');
INSERT INTO `dycms_order` VALUES ('1708185102', 'AD1708610757', '4');
INSERT INTO `dycms_order` VALUES ('1708182023', 'AD1708866418', '4');
INSERT INTO `dycms_order` VALUES ('1708185477', '121708185996bd5bb564', '12');
INSERT INTO `dycms_order` VALUES ('1708186051', '121708185996bd6876f1', '12');
INSERT INTO `dycms_order` VALUES ('170818560', 'AO1708078179', '2');
INSERT INTO `dycms_order` VALUES ('1708185467', 'AO1708141813', '2');
INSERT INTO `dycms_order` VALUES ('1708184992', 'AD1708884741', '4');
INSERT INTO `dycms_order` VALUES ('1708185084', 'AO1708552008', '2');
INSERT INTO `dycms_order` VALUES ('1708194052', '1217081959979bc6a47d', '12');
INSERT INTO `dycms_order` VALUES ('1708199226', 'AD1708219056', '4');
INSERT INTO `dycms_order` VALUES ('1708208780', '121708205998ed6eca27', '12');
INSERT INTO `dycms_order` VALUES ('1708219011', '12170821599a3ed4f134', '12');
INSERT INTO `dycms_order` VALUES ('1708212409', 'AD1708877403', '4');
INSERT INTO `dycms_order` VALUES ('1708216430', 'AD1708537135', '4');
INSERT INTO `dycms_order` VALUES ('1708212889', '12170821599a850a63c0', '12');
INSERT INTO `dycms_order` VALUES ('1708212369', '14170821599a97c05677', '14');
INSERT INTO `dycms_order` VALUES ('1708219465', '12170821599a98883174', '12');
INSERT INTO `dycms_order` VALUES ('1708212327', '12170821599a9dd87433', '12');
INSERT INTO `dycms_order` VALUES ('170821548', '170821599ab42d87276', '1');
INSERT INTO `dycms_order` VALUES ('1708212793', 'AD1708080737', '4');
INSERT INTO `dycms_order` VALUES ('1708223389', '12170822599b90bfdd19', '12');
INSERT INTO `dycms_order` VALUES ('1708224557', '14170822599bd4aec362', '14');
INSERT INTO `dycms_order` VALUES ('1708229490', 'AD1708009563', '4');
INSERT INTO `dycms_order` VALUES ('1708222786', '12170822599bd6a0a69d', '12');
INSERT INTO `dycms_order` VALUES ('1708235483', '12170823599d26845a07', '12');
INSERT INTO `dycms_order` VALUES ('1708234143', 'AO1708073826', '2');
INSERT INTO `dycms_order` VALUES ('1708242842', '12170824599e3371d0f3', '12');
INSERT INTO `dycms_order` VALUES ('1708248552', '12170824599e79247d44', '12');
INSERT INTO `dycms_order` VALUES ('1708245117', 'AD1708644439', '4');
INSERT INTO `dycms_order` VALUES ('1708258942', '12170825599f854a00a0', '12');
INSERT INTO `dycms_order` VALUES ('1708252333', '12170825599fcb28185b', '12');
INSERT INTO `dycms_order` VALUES ('1708256203', 'AD1708952449', '4');
INSERT INTO `dycms_order` VALUES ('1708256974', 'AO1708428598', '2');
INSERT INTO `dycms_order` VALUES ('1708257097', 'AD1708910557', '4');
INSERT INTO `dycms_order` VALUES ('1708268634', '1217082659a0d658c115', '12');
INSERT INTO `dycms_order` VALUES ('1708267794', 'AD1708160245', '4');
INSERT INTO `dycms_order` VALUES ('1708263621', 'AD1708161000', '4');
INSERT INTO `dycms_order` VALUES ('1708269948', 'AO1708011589', '2');
INSERT INTO `dycms_order` VALUES ('1708263589', '1217082659a11c969c55', '12');
INSERT INTO `dycms_order` VALUES ('1708269654', 'AD1708046179', '4');
INSERT INTO `dycms_order` VALUES ('1708269469', 'AD1708646834', '4');
INSERT INTO `dycms_order` VALUES ('1708268533', '1217082659a13688eb35', '12');
INSERT INTO `dycms_order` VALUES ('1708267331', 'AD1708630190', '4');
INSERT INTO `dycms_order` VALUES ('1708264583', 'AD1708634350', '4');
INSERT INTO `dycms_order` VALUES ('1708274253', '1217082759a2281a0149', '12');
INSERT INTO `dycms_order` VALUES ('170827607', 'AD1708246082', '4');
INSERT INTO `dycms_order` VALUES ('1708284360', '1217082859a3797f67f0', '12');
INSERT INTO `dycms_order` VALUES ('1708286936', '1217082859a3bf938add', '12');
INSERT INTO `dycms_order` VALUES ('1708287146', '1417082859a3c2e79ef5', '14');
INSERT INTO `dycms_order` VALUES ('1708282091', 'AO1708765378', '2');
INSERT INTO `dycms_order` VALUES ('1708285344', 'AD1708641537', '4');
INSERT INTO `dycms_order` VALUES ('1708286624', '17082859a405b770103', '1');
INSERT INTO `dycms_order` VALUES ('1708286143', '17082859a405e87e12e', '1');
INSERT INTO `dycms_order` VALUES ('170828793', '17082859a411e8e33e3', '1');
INSERT INTO `dycms_order` VALUES ('1708285320', 'AO1708388949', '2');
INSERT INTO `dycms_order` VALUES ('1708281888', 'AO1708354952', '2');
INSERT INTO `dycms_order` VALUES ('1708282921', 'AD1708536103', '4');
INSERT INTO `dycms_order` VALUES ('1708289481', '17082859a41a6d0c1ca', '1');
INSERT INTO `dycms_order` VALUES ('1708288781', 'AO1708761466', '2');
INSERT INTO `dycms_order` VALUES ('1708286014', 'AO1708728188', '2');
INSERT INTO `dycms_order` VALUES ('1708298551', '1217082959a4cac7ca7c', '12');
INSERT INTO `dycms_order` VALUES ('1708295593', '1217082959a5110ab18e', '12');
INSERT INTO `dycms_order` VALUES ('1708307070', '1217083059a61c4b622d', '12');
INSERT INTO `dycms_order` VALUES ('1708307835', 'AD1708014680', '4');
INSERT INTO `dycms_order` VALUES ('1708302657', 'AO1708826643', '2');
INSERT INTO `dycms_order` VALUES ('1708308858', 'AD1708057779', '4');
INSERT INTO `dycms_order` VALUES ('1708306372', 'AD1708572968', '4');
INSERT INTO `dycms_order` VALUES ('1708305864', '1417083059a64cf6b7b2', '14');
INSERT INTO `dycms_order` VALUES ('1708307093', 'AD1708775735', '4');
INSERT INTO `dycms_order` VALUES ('1708308356', 'AD1708811752', '4');
INSERT INTO `dycms_order` VALUES ('1708305829', 'AO1708929899', '2');
INSERT INTO `dycms_order` VALUES ('1708309219', '1217083059a67fac82ab', '12');
INSERT INTO `dycms_order` VALUES ('1708313728', '1217083159a769b7a7f1', '12');
INSERT INTO `dycms_order` VALUES ('1708314160', '1217083159a76dce48f0', '12');
INSERT INTO `dycms_order` VALUES ('1708311042', 'AO1708372286', '2');
INSERT INTO `dycms_order` VALUES ('1708314399', 'AD1708646715', '4');
INSERT INTO `dycms_order` VALUES ('1708315635', 'AD1708602580', '4');
INSERT INTO `dycms_order` VALUES ('1708317993', 'AD1708895180', '4');
INSERT INTO `dycms_order` VALUES ('1708317062', 'AD1708366422', '4');
INSERT INTO `dycms_order` VALUES ('1708314215', 'AD1708765295', '4');
INSERT INTO `dycms_order` VALUES ('1709013508', 'AO1709508019', '2');
INSERT INTO `dycms_order` VALUES ('1709015372', 'AD1709443098', '4');
INSERT INTO `dycms_order` VALUES ('1709014342', 'AO1709757450', '2');
INSERT INTO `dycms_order` VALUES ('1709016435', 'AD1709149811', '4');
INSERT INTO `dycms_order` VALUES ('1709014016', 'AO1709779983', '2');
INSERT INTO `dycms_order` VALUES ('1709019254', '1417090159a934d92ec1', '14');
INSERT INTO `dycms_order` VALUES ('1709019481', '17090159a93514b6321', '1');
INSERT INTO `dycms_order` VALUES ('1709019781', 'AD1709102019', '4');
INSERT INTO `dycms_order` VALUES ('1709012306', 'AO1709132565', '2');
INSERT INTO `dycms_order` VALUES ('1709011009', 'AD1709448841', '4');
INSERT INTO `dycms_order` VALUES ('1709017526', '17090159a97a79bc88b', '1');
INSERT INTO `dycms_order` VALUES ('1709014029', 'AO1709746467', '2');
INSERT INTO `dycms_order` VALUES ('170902494', '1417090259aa83ba403d', '14');
INSERT INTO `dycms_order` VALUES ('1709024074', 'AO1709491278', '2');
INSERT INTO `dycms_order` VALUES ('1709023096', 'AO1709195752', '2');
INSERT INTO `dycms_order` VALUES ('1709023221', 'AD1709844378', '4');
INSERT INTO `dycms_order` VALUES ('1709037743', 'AD1709590892', '4');
INSERT INTO `dycms_order` VALUES ('1709041060', 'AO1709815604', '2');
INSERT INTO `dycms_order` VALUES ('1709048265', '1417090459acc63e5ce2', '14');
INSERT INTO `dycms_order` VALUES ('1709041920', 'AO1709807972', '2');
INSERT INTO `dycms_order` VALUES ('1709046551', 'AO1709398248', '2');
INSERT INTO `dycms_order` VALUES ('170904461', 'AD1709827645', '4');
INSERT INTO `dycms_order` VALUES ('17090438', '1417090459acf19904a1', '14');
INSERT INTO `dycms_order` VALUES ('1709041534', 'AO1709004052', '2');
INSERT INTO `dycms_order` VALUES ('1709048839', 'AO1709956101', '2');
INSERT INTO `dycms_order` VALUES ('170904620', 'AD1709797680', '4');
INSERT INTO `dycms_order` VALUES ('1709042418', 'AD1709807714', '4');
INSERT INTO `dycms_order` VALUES ('1709056209', 'AD1709123562', '4');
INSERT INTO `dycms_order` VALUES ('1709056917', 'AD1709157225', '4');
INSERT INTO `dycms_order` VALUES ('1709056504', 'AD1709317138', '4');
INSERT INTO `dycms_order` VALUES ('1709055227', 'AD1709898579', '4');
INSERT INTO `dycms_order` VALUES ('1709078504', '1217090759b0a806cb90', '12');
INSERT INTO `dycms_order` VALUES ('1709072364', 'AD1709329383', '4');
INSERT INTO `dycms_order` VALUES ('1709084818', 'AD1709310855', '4');
INSERT INTO `dycms_order` VALUES ('1709088584', '17090859b289a38f1f9', '1');
INSERT INTO `dycms_order` VALUES ('1709086672', '17090859b2b426801f5', '1');
INSERT INTO `dycms_order` VALUES ('1709096647', 'AD1709025590', '4');
INSERT INTO `dycms_order` VALUES ('1709094360', 'AO1709704374', '2');
INSERT INTO `dycms_order` VALUES ('170909294', 'AD1709114406', '4');
INSERT INTO `dycms_order` VALUES ('170909760', 'AD1709999113', '4');
INSERT INTO `dycms_order` VALUES ('1709096222', 'AD1709735219', '4');
INSERT INTO `dycms_order` VALUES ('1709102720', '1417091059b4bb45199a', '14');
INSERT INTO `dycms_order` VALUES ('170910187', 'AD1709755249', '4');
INSERT INTO `dycms_order` VALUES ('1709105390', 'AO1709878542', '2');
INSERT INTO `dycms_order` VALUES ('1709106038', 'AO1709223410', '2');
INSERT INTO `dycms_order` VALUES ('170910692', 'AD1709219511', '4');
INSERT INTO `dycms_order` VALUES ('1709108768', 'AO1709122871', '2');
INSERT INTO `dycms_order` VALUES ('1709101868', 'AO1709029182', '2');
INSERT INTO `dycms_order` VALUES ('1709105225', 'AO1709929213', '2');
INSERT INTO `dycms_order` VALUES ('1709107589', 'AO1709639278', '2');
INSERT INTO `dycms_order` VALUES ('1709109333', 'AO1709789007', '2');
INSERT INTO `dycms_order` VALUES ('1709101966', 'AO1709984411', '2');
INSERT INTO `dycms_order` VALUES ('1709101503', 'AO1709167269', '2');
INSERT INTO `dycms_order` VALUES ('1709101437', 'AO1709120849', '2');
INSERT INTO `dycms_order` VALUES ('170910224', 'AO1709159334', '2');
INSERT INTO `dycms_order` VALUES ('1709109534', 'AO1709386085', '2');
INSERT INTO `dycms_order` VALUES ('1709103406', 'AO1709063584', '2');
INSERT INTO `dycms_order` VALUES ('1709101256', 'AO1709002824', '2');
INSERT INTO `dycms_order` VALUES ('1709104279', 'AO1709629891', '2');
INSERT INTO `dycms_order` VALUES ('1709107933', 'AO1709385326', '2');
INSERT INTO `dycms_order` VALUES ('1709109753', 'AO1709304150', '2');
INSERT INTO `dycms_order` VALUES ('1709107046', 'AO1709023448', '2');
INSERT INTO `dycms_order` VALUES ('1709109569', 'AO1709687234', '2');
INSERT INTO `dycms_order` VALUES ('1709108804', 'AO1709567133', '2');
INSERT INTO `dycms_order` VALUES ('1709108259', 'AO1709361789', '2');
INSERT INTO `dycms_order` VALUES ('1709107936', 'AO1709452818', '2');
INSERT INTO `dycms_order` VALUES ('1709108714', 'AO1709718545', '2');
INSERT INTO `dycms_order` VALUES ('1709102807', 'AO1709365883', '2');
INSERT INTO `dycms_order` VALUES ('1709108188', 'AO1709293422', '2');
INSERT INTO `dycms_order` VALUES ('1709108082', 'AO1709337979', '2');
INSERT INTO `dycms_order` VALUES ('1709104990', 'AO1709669523', '2');
INSERT INTO `dycms_order` VALUES ('1709106464', 'AO1709746542', '2');
INSERT INTO `dycms_order` VALUES ('170911409', 'AD1709629521', '4');
INSERT INTO `dycms_order` VALUES ('1709111256', 'AO1709499945', '2');
INSERT INTO `dycms_order` VALUES ('1709117863', 'AO1709540648', '2');
INSERT INTO `dycms_order` VALUES ('1709111503', 'AD1709062620', '4');
INSERT INTO `dycms_order` VALUES ('1709116078', 'AD1709534338', '4');
INSERT INTO `dycms_order` VALUES ('1709128160', 'AO1709703690', '2');
INSERT INTO `dycms_order` VALUES ('1709129642', 'AD1709049979', '4');
INSERT INTO `dycms_order` VALUES ('1709142870', 'AD1709160564', '4');
INSERT INTO `dycms_order` VALUES ('1709155329', 'AO1709310059', '2');
INSERT INTO `dycms_order` VALUES ('17091579', 'AO1709709996', '2');
INSERT INTO `dycms_order` VALUES ('1709158739', 'AD1709072259', '4');
INSERT INTO `dycms_order` VALUES ('1709151534', 'AD1709457145', '4');
INSERT INTO `dycms_order` VALUES ('1709154666', 'AO1709826776', '2');
INSERT INTO `dycms_order` VALUES ('1709156240', 'AO1709493238', '2');
INSERT INTO `dycms_order` VALUES ('1709161356', 'AD1709009859', '4');
INSERT INTO `dycms_order` VALUES ('170916515', '1417091659bcd16e185c', '14');
INSERT INTO `dycms_order` VALUES ('1709161268', 'AO1709864807', '2');
INSERT INTO `dycms_order` VALUES ('1709164034', 'AO1709836993', '2');
INSERT INTO `dycms_order` VALUES ('1709163737', 'AD1709175174', '4');
INSERT INTO `dycms_order` VALUES ('1709189972', 'AD1709914955', '4');
INSERT INTO `dycms_order` VALUES ('170918948', 'AD1709094364', '4');
INSERT INTO `dycms_order` VALUES ('1709185057', 'AD1709910348', '4');
INSERT INTO `dycms_order` VALUES ('1709188490', 'AD1709677491', '4');
INSERT INTO `dycms_order` VALUES ('170919164', 'AD1709399862', '4');
INSERT INTO `dycms_order` VALUES ('1709192498', 'AD1709592768', '4');
INSERT INTO `dycms_order` VALUES ('1709197469', 'AD1709042593', '4');
INSERT INTO `dycms_order` VALUES ('1709199838', 'AD1709010472', '4');
INSERT INTO `dycms_order` VALUES ('1709193196', 'AD1709465915', '4');
INSERT INTO `dycms_order` VALUES ('1709206307', '17092059c2782236f7e', '1');
INSERT INTO `dycms_order` VALUES ('1709287636', 'AD1709383349', '4');
INSERT INTO `dycms_order` VALUES ('1709281725', 'AD1709337615', '4');
INSERT INTO `dycms_order` VALUES ('1709295205', 'AO1709068995', '2');
INSERT INTO `dycms_order` VALUES ('1709299566', 'AD1709674361', '4');
INSERT INTO `dycms_order` VALUES ('1709295383', 'AO1709902911', '2');
INSERT INTO `dycms_order` VALUES ('1709302589', 'AD1709916913', '4');
INSERT INTO `dycms_order` VALUES ('1710011480', 'AD1710257107', '4');
INSERT INTO `dycms_order` VALUES ('1710029570', '17100259d2440689e25', '1');
INSERT INTO `dycms_order` VALUES ('1710055897', '17100559d562eeeca67', '1');
INSERT INTO `dycms_order` VALUES ('1710053612', '17100559d563a31cfc6', '1');
INSERT INTO `dycms_order` VALUES ('1710068356', 'AO1710153309', '2');
INSERT INTO `dycms_order` VALUES ('1710065940', 'AO1710814990', '2');
INSERT INTO `dycms_order` VALUES ('1710068037', 'AD1710493355', '4');
INSERT INTO `dycms_order` VALUES ('1710065040', 'AO1710150552', '2');
INSERT INTO `dycms_order` VALUES ('1710067357', 'AO1710666234', '2');
INSERT INTO `dycms_order` VALUES ('1710062851', 'AO1710027035', '2');
INSERT INTO `dycms_order` VALUES ('1710066613', 'AO1710545125', '2');
INSERT INTO `dycms_order` VALUES ('1710065300', 'AO1710933667', '2');
INSERT INTO `dycms_order` VALUES ('1710067646', 'AO1710707941', '2');
INSERT INTO `dycms_order` VALUES ('1710069577', 'AD1710137557', '4');
INSERT INTO `dycms_order` VALUES ('1710066714', 'AD1710202507', '4');
INSERT INTO `dycms_order` VALUES ('1710064408', 'AD1710545132', '4');
INSERT INTO `dycms_order` VALUES ('1710062274', 'AD1710139246', '4');
INSERT INTO `dycms_order` VALUES ('1710062686', 'AD1710688007', '4');
INSERT INTO `dycms_order` VALUES ('1710068642', 'AD1710184244', '4');
INSERT INTO `dycms_order` VALUES ('1710072742', 'AD1710757866', '4');
INSERT INTO `dycms_order` VALUES ('1710077505', 'AD1710200641', '4');
INSERT INTO `dycms_order` VALUES ('1710106276', 'AD1710138760', '4');
INSERT INTO `dycms_order` VALUES ('1710105806', 'AD1710711688', '4');
INSERT INTO `dycms_order` VALUES ('1710108008', 'AO1710655551', '2');
INSERT INTO `dycms_order` VALUES ('1710109521', '17101059dc5d12a2374', '1');
INSERT INTO `dycms_order` VALUES ('1710104738', '17101059dc5d58f198c', '1');
INSERT INTO `dycms_order` VALUES ('1710106400', 'AD1710311886', '4');
INSERT INTO `dycms_order` VALUES ('1710104417', 'AD1710683590', '4');
INSERT INTO `dycms_order` VALUES ('1710104309', 'AD1710120426', '4');
INSERT INTO `dycms_order` VALUES ('1710107936', 'AD1710494734', '4');
INSERT INTO `dycms_order` VALUES ('1710105721', 'AD1710549508', '4');
INSERT INTO `dycms_order` VALUES ('1710108924', 'AD1710182537', '4');
INSERT INTO `dycms_order` VALUES ('171010688', 'AD1710932049', '4');
INSERT INTO `dycms_order` VALUES ('17101176', '17101159dd85f4eb1da', '1');
INSERT INTO `dycms_order` VALUES ('1710123160', 'AD1710664252', '4');
INSERT INTO `dycms_order` VALUES ('1710133409', 'AO1710739313', '2');
INSERT INTO `dycms_order` VALUES ('171013380', 'AO1710865885', '2');
INSERT INTO `dycms_order` VALUES ('1710139563', 'AO1710991908', '2');
INSERT INTO `dycms_order` VALUES ('171013999', 'AD1710402764', '4');
INSERT INTO `dycms_order` VALUES ('1710134647', '17101359e063ef05c3d', '1');
INSERT INTO `dycms_order` VALUES ('1710135889', 'AD1710585050', '4');
INSERT INTO `dycms_order` VALUES ('1710134209', 'AO1710484293', '2');
INSERT INTO `dycms_order` VALUES ('1710137500', 'AD1710565294', '4');
INSERT INTO `dycms_order` VALUES ('1710136758', 'AD1710966548', '4');
INSERT INTO `dycms_order` VALUES ('1710139267', 'AD1710567575', '4');
INSERT INTO `dycms_order` VALUES ('1710138543', 'AD1710827006', '4');
INSERT INTO `dycms_order` VALUES ('1710136069', 'AO1710574517', '2');
INSERT INTO `dycms_order` VALUES ('1710135080', 'AD1710646588', '4');
INSERT INTO `dycms_order` VALUES ('171013710', 'AO1710898417', '2');
INSERT INTO `dycms_order` VALUES ('1710141939', '1417101459e17e0670f2', '14');
INSERT INTO `dycms_order` VALUES ('1710157632', 'AD1710664669', '4');
INSERT INTO `dycms_order` VALUES ('1710153500', 'AD1710266638', '4');
INSERT INTO `dycms_order` VALUES ('1710157797', 'AD1710231576', '4');
INSERT INTO `dycms_order` VALUES ('1710157843', 'AO1710916468', '2');
INSERT INTO `dycms_order` VALUES ('1710152075', 'AD1710503970', '4');
INSERT INTO `dycms_order` VALUES ('171016543', 'AO1710239487', '2');
INSERT INTO `dycms_order` VALUES ('1710168564', 'AO1710963275', '2');
INSERT INTO `dycms_order` VALUES ('171016743', 'AD1710321066', '4');
INSERT INTO `dycms_order` VALUES ('171016420', 'AD1710623453', '4');
INSERT INTO `dycms_order` VALUES ('1710166009', 'AD1710954236', '4');
INSERT INTO `dycms_order` VALUES ('1710165355', 'AD1710085421', '4');
INSERT INTO `dycms_order` VALUES ('1710163777', 'AD1710509511', '4');
INSERT INTO `dycms_order` VALUES ('1710167466', 'AD1710105072', '4');
INSERT INTO `dycms_order` VALUES ('1710166353', 'AD1710745742', '4');
INSERT INTO `dycms_order` VALUES ('1710166545', 'AD1710698321', '4');
INSERT INTO `dycms_order` VALUES ('1710164393', 'AO1710997030', '2');
INSERT INTO `dycms_order` VALUES ('1710166651', 'AO1710098169', '2');
INSERT INTO `dycms_order` VALUES ('1710172731', '1417101759e55b237c6e', '14');
INSERT INTO `dycms_order` VALUES ('171017535', '1417101759e55b60541b', '14');
INSERT INTO `dycms_order` VALUES ('1710176912', '1417101759e55bad45b4', '14');
INSERT INTO `dycms_order` VALUES ('171017345', 'AO1710337737', '2');
INSERT INTO `dycms_order` VALUES ('1710177125', 'AO1710442694', '2');
INSERT INTO `dycms_order` VALUES ('1710173200', 'AO1710595910', '2');
INSERT INTO `dycms_order` VALUES ('1710176483', 'AO1710252986', '2');
INSERT INTO `dycms_order` VALUES ('1710178143', 'AO1710925343', '2');
INSERT INTO `dycms_order` VALUES ('171017991', 'AO1710960903', '2');
INSERT INTO `dycms_order` VALUES ('1710171827', 'AO1710266166', '2');
INSERT INTO `dycms_order` VALUES ('1710179113', 'AD1710568557', '4');
INSERT INTO `dycms_order` VALUES ('1710174370', '17101759e5aad847ae1', '1');
INSERT INTO `dycms_order` VALUES ('1710179652', 'AO1710710583', '2');
INSERT INTO `dycms_order` VALUES ('171017810', 'AO1710456802', '2');
INSERT INTO `dycms_order` VALUES ('1710173305', 'AO1710998369', '2');
INSERT INTO `dycms_order` VALUES ('1710175614', 'AD1710206782', '4');
INSERT INTO `dycms_order` VALUES ('1710189279', 'AD1710548894', '4');
INSERT INTO `dycms_order` VALUES ('1710189316', 'AD1710092686', '4');
INSERT INTO `dycms_order` VALUES ('1710184141', 'AD1710385299', '4');
INSERT INTO `dycms_order` VALUES ('1710182826', 'AO1710046165', '2');
INSERT INTO `dycms_order` VALUES ('1710188301', 'AO1710763519', '2');
INSERT INTO `dycms_order` VALUES ('1710182589', 'AO1710502803', '2');
INSERT INTO `dycms_order` VALUES ('1710182438', 'AO1710864765', '2');
INSERT INTO `dycms_order` VALUES ('171018576', 'AD1710065397', '4');
INSERT INTO `dycms_order` VALUES ('1710188905', '17101859e748c06437c', '1');
INSERT INTO `dycms_order` VALUES ('1710194064', 'AO1710807736', '2');
INSERT INTO `dycms_order` VALUES ('1710199004', 'AD1710854972', '4');
INSERT INTO `dycms_order` VALUES ('171019897', 'AD1710637481', '4');
INSERT INTO `dycms_order` VALUES ('1710191426', 'AO1710658704', '2');
INSERT INTO `dycms_order` VALUES ('1710191408', 'AO1710992740', '2');
INSERT INTO `dycms_order` VALUES ('1710196938', 'AD1710500268', '4');
INSERT INTO `dycms_order` VALUES ('1710197635', 'AD1710763945', '4');
INSERT INTO `dycms_order` VALUES ('1710208285', 'AD1710653777', '4');
INSERT INTO `dycms_order` VALUES ('1710201867', 'AD1710312681', '4');
INSERT INTO `dycms_order` VALUES ('1710203329', '17102059e97f7d92660', '1');
INSERT INTO `dycms_order` VALUES ('1710208151', '1417102059e9ec32b0c3', '14');
INSERT INTO `dycms_order` VALUES ('1710201487', 'AO1710942218', '2');
INSERT INTO `dycms_order` VALUES ('1710208191', 'AO1710748999', '2');
INSERT INTO `dycms_order` VALUES ('1710219638', 'AD1710543546', '4');
INSERT INTO `dycms_order` VALUES ('171021606', 'AD1710842841', '4');
INSERT INTO `dycms_order` VALUES ('1710211556', '17102159eaed10c1857', '1');
INSERT INTO `dycms_order` VALUES ('1710221925', 'AD1710109649', '4');
INSERT INTO `dycms_order` VALUES ('1710226063', 'AD1710294051', '4');
INSERT INTO `dycms_order` VALUES ('1710229697', 'AD1710597297', '4');
INSERT INTO `dycms_order` VALUES ('1710235341', 'AO1710988551', '2');
INSERT INTO `dycms_order` VALUES ('1710232554', 'AD1710228862', '4');
INSERT INTO `dycms_order` VALUES ('1710237795', '17102359edfb618b2ff', '1');
INSERT INTO `dycms_order` VALUES ('1710232365', '17102359ee0f5c444d8', '1');

-- ----------------------------
-- Table structure for dycms_products
-- ----------------------------
DROP TABLE IF EXISTS `dycms_products`;
CREATE TABLE `dycms_products` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) DEFAULT '0' COMMENT '商品id号',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `special_price` float(10,2) DEFAULT '0.00' COMMENT '特价',
  `sell_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '零售价',
  `market_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `cost_price` float(10,2) DEFAULT '0.00' COMMENT '成本价',
  `store_nums` int(11) DEFAULT '0' COMMENT '库存量',
  `warning_line` int(11) DEFAULT '0' COMMENT '预警线',
  `weight` int(11) DEFAULT '0' COMMENT '重量',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `pro_no` varchar(20) DEFAULT '' COMMENT '商品规格编号',
  `spec` text COMMENT '序列化规格',
  `specs_key` varchar(255) DEFAULT NULL COMMENT '规格序列化key',
  `album_id` int(11) DEFAULT NULL COMMENT '相册id号',
  `coupon_module_id` int(11) DEFAULT NULL COMMENT '兑换券模板id号',
  `point` float(10,2) DEFAULT NULL COMMENT '积分',
  `product_name` varchar(200) DEFAULT NULL COMMENT '产品名称',
  `etype` tinyint(2) DEFAULT '0' COMMENT '实体类型(1=优惠券，2=课程)',
  `entityid` int(11) DEFAULT '0' COMMENT '实体ID号',
  `delivery` tinyint(2) DEFAULT '2' COMMENT '发货方式(1=自动发货，2=手动发货)',
  `bind_content` text COMMENT '绑定内容(编码后数据)',
  `package_products` text COMMENT '套餐内容(编码后数据)',
  `shop_count` int(10) DEFAULT '0' COMMENT '商城销售数',
  `agency_price` float(10,2) DEFAULT '0.00' COMMENT '代理价',
  `inventory_operate` tinyint(4) DEFAULT '0' COMMENT '库存操作类型（1=扣库存锁库存，2=扣库存不锁库存，3=不扣库存不锁库存）',
  PRIMARY KEY (`id`),
  KEY `goods_id` (`goods_id`,`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10032 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商城货品表';

-- ----------------------------
-- Records of dycms_products
-- ----------------------------
INSERT INTO `dycms_products` VALUES ('10012', '10012', '-2', '1494551276', '1495614757', '1', '1', '0.00', '0.00', '26.00', null, '73', null, null, '1', 'goods1494550975867_0', null, null, '0', null, '0.00', '黄玉姜粉', '0', '0', '2', '', '', '75', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10013', '10013', '-2', '1494551352', '1495703218', '1', '1', '0.00', '0.00', '88.00', null, '96', null, null, '1', 'goods1494551292545_0', null, null, '0', null, '0.00', '黄玉姜片', '0', '0', '2', '', '', '18', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10014', '10014', '-2', '1494551421', '1496027210', '1', '103', '0.00', '0.00', '58.00', null, '98', null, null, '1', 'goods1494551368232_0', null, null, '0', null, '0.00', '轻松灸', '0', '0', '2', '', '', '33', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10015', '10015', '-2', '1494551499', '1495703231', '1', '1', '0.00', '0.00', '98.00', null, '107', null, null, '1', 'goods1494551442672_0', null, null, '0', null, '0.00', '红糖粉', '0', '0', '2', '', '', '1', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10016', '10016', '-2', '1494982300', '1498917587', '1', '114', '0.00', '0.00', '180.00', null, '0', null, '0', '1', 'goods1494982132445_0', null, null, '0', null, '0.00', '红参', '0', '0', '2', '', '', '0', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10017', '10017', '1', '1495174160', '1504257855', '107', '1', '0.00', '0.00', '48.00', null, '97', null, '0', '1', 'goods1495174043247_0', null, null, '0', null, '0.00', '艾贴', '0', '0', '2', '', '', '3', '0.00', '3');
INSERT INTO `dycms_products` VALUES ('10018', '10018', '1', '1495174597', '1504257671', '107', '1', '0.00', '0.00', '28.00', null, '64', null, '0', '1', 'goods1495174273708_0', null, null, '0', null, '0.00', '黄土球温敷披肩', '0', '0', '2', '', '', '41', '0.00', '3');
INSERT INTO `dycms_products` VALUES ('10019', '10019', '1', '1495175664', '1504257659', '107', '1', '0.00', '0.00', '88.00', null, '100', null, '0', '1', 'goods1495175628700_0', null, null, '0', null, '0.00', '姜贴', '0', '0', '2', '', '', '0', '0.00', '3');
INSERT INTO `dycms_products` VALUES ('10029', '10016', '1', '1498917821', '1504257646', '114', '1', '0.00', '0.00', '686.00', null, '999', null, '380', '1', 'P040101_1', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '686.00', '红参片（大）', '0', '0', '2', '', null, '1', '0.00', '3');
INSERT INTO `dycms_products` VALUES ('10020', '10012', '1', '1495615256', '1566403996', '1', '1', '0.00', '0.00', '68.00', null, '534', null, '380', '1', 'P010101_3', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAyIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '68.00', '111', '0', '0', '2', '', null, '420', '0.00', '1');
INSERT INTO `dycms_products` VALUES ('10030', '10012', '1', '1566403984', '1566403996', '1', '1', '0.00', '0.00', '68.00', null, '534', null, '380', '1', 'P010101_1', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '68.00', '222', '0', '0', '2', '', null, '0', '0.00', '1');
INSERT INTO `dycms_products` VALUES ('10021', '10012', '-2', '1495615256', '1566403928', '1', '1', '0.00', '0.00', '68.00', null, '534', null, '380', '1', 'P010101_5', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDA0Iiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjIwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '68.00', '', '0', '0', '0', '', null, '191', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10022', '10012', '-2', '1495772215', '1495772215', '1', '1', '0.00', '0.00', '0.00', null, '0', null, null, '1', 'goods1495772155802_0', null, null, '0', null, '0.00', '黄玉姜粉', '0', '0', '2', '', '', '0', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10023', '10013', '1', '1495772551', '1504257625', '1', '1', '0.00', '0.00', '48.00', null, '820', null, '260', '1', 'P010102_1', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAyIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '48.00', '黄玉姜片（大）', '0', '0', '2', '', null, '123', '0.00', '3');
INSERT INTO `dycms_products` VALUES ('10024', '10015', '1', '1495772619', '1508409524', '1', '10022', '0.00', '0.00', '36.00', null, '816', null, '500', '1', 'P030101_1', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '36.00', '红糖粉（大）', '0', '0', '2', '', null, '144', '0.00', '3');
INSERT INTO `dycms_products` VALUES ('10025', '10015', '1', '1495772619', '1504507164', '1', '10075', '0.00', '0.00', '20.00', null, '828', null, '250', '1', 'P030101_2', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '20.00', '红糖粉（小）', '0', '0', '2', '', null, '119', '0.00', '3');
INSERT INTO `dycms_products` VALUES ('10026', '10014', '1', '1496039749', '1566403754', '1', '1', '0.00', '0.00', '168.00', null, '821', null, '800', '1', 'P020101_5', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDA0Iiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjIwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '168.00', '', '0', '0', '0', '', null, '271', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10027', '10015', '-3', '1498545465', '1498574621', '1', '114', '0.00', '0.00', '36.00', null, '884', null, '500', '1', 'P030101_1', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '36.00', '红糖粉（大）', '0', '0', '2', '', null, '1', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10028', '10015', '-3', '1498545465', '1498574621', '1', '114', '0.00', '0.00', '20.00', null, '903', null, '250', '1', 'P030101_2', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '20.00', '红糖粉（小）', '0', '0', '2', '', null, '1', '0.00', '0');
INSERT INTO `dycms_products` VALUES ('10031', '10012', '1', '1566403984', '1566403996', '1', '1', '0.00', '0.00', '68.00', null, '534', null, '380', '1', 'P010101_2', 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', null, '0', null, '68.00', '333', '0', '0', '2', '', null, '0', '0.00', '1');

-- ----------------------------
-- Table structure for dycms_products_spec
-- ----------------------------
DROP TABLE IF EXISTS `dycms_products_spec`;
CREATE TABLE `dycms_products_spec` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) DEFAULT '0' COMMENT '商品id号',
  `status` tinyint(4) DEFAULT '0' COMMENT '会员状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `spec_id` int(11) DEFAULT '0' COMMENT '规格id号',
  `attr_id` int(11) DEFAULT '0' COMMENT '属性id',
  `product_id` int(11) DEFAULT '0' COMMENT '货品id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=230 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='商城货品-规格表';

-- ----------------------------
-- Records of dycms_products_spec
-- ----------------------------
INSERT INTO `dycms_products_spec` VALUES ('1', '10012', '-2', '1495615256', '1495615256', '1', '1', '12', '10000', '10020');
INSERT INTO `dycms_products_spec` VALUES ('2', '10012', '-2', '1495615256', '1495615256', '1', '1', '12', '10001', '10021');
INSERT INTO `dycms_products_spec` VALUES ('3', '10012', '-2', '1495615381', '1495615381', '1', '1', '12', '10000', '10020');
INSERT INTO `dycms_products_spec` VALUES ('4', '10012', '-2', '1495615381', '1495615381', '1', '1', '12', '10001', '10021');
INSERT INTO `dycms_products_spec` VALUES ('5', '10012', '-2', '1495615419', '1495615419', '1', '1', '12', '10000', '10020');
INSERT INTO `dycms_products_spec` VALUES ('6', '10012', '-2', '1495615419', '1495615419', '1', '1', '12', '10001', '10021');
INSERT INTO `dycms_products_spec` VALUES ('7', '10012', '-2', '1495615510', '1495615510', '1', '1', '12', '10000', '10020');
INSERT INTO `dycms_products_spec` VALUES ('8', '10012', '-2', '1495615510', '1495615510', '1', '1', '12', '10001', '10021');
INSERT INTO `dycms_products_spec` VALUES ('9', '10012', '-2', '1495703190', '1495703190', '1', '1', '12', '10000', '10020');
INSERT INTO `dycms_products_spec` VALUES ('10', '10012', '-2', '1495703190', '1495703190', '1', '1', '12', '10001', '10021');
INSERT INTO `dycms_products_spec` VALUES ('11', '10012', '-2', '1495772153', '1495772153', '1', '1', '12', '10001', '10021');
INSERT INTO `dycms_products_spec` VALUES ('12', '10012', '-2', '1495772437', '1495772437', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('13', '10012', '-2', '1495772437', '1495772437', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('14', '10013', '-2', '1495772551', '1495772551', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('15', '10015', '-2', '1495772619', '1495772619', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('16', '10015', '-2', '1495772619', '1495772619', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('17', '10012', '-2', '1495799471', '1495799471', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('18', '10012', '-2', '1495799471', '1495799471', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('19', '10012', '-2', '1496562527', '1496562527', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('20', '10012', '-2', '1496562527', '1496562527', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('21', '10013', '-2', '1496562578', '1496562578', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('22', '10015', '-2', '1496562785', '1496562785', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('23', '10015', '-2', '1496562785', '1496562785', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('24', '10012', '-2', '1496715460', '1496715460', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('25', '10012', '-2', '1496715460', '1496715460', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('26', '10012', '-2', '1496720409', '1496720409', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('27', '10012', '-2', '1496720409', '1496720409', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('28', '10012', '-2', '1496732448', '1496732448', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('29', '10012', '-2', '1496732448', '1496732448', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('30', '10012', '-2', '1496733563', '1496733563', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('31', '10012', '-2', '1496733563', '1496733563', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('32', '10012', '-2', '1496733715', '1496733715', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('33', '10012', '-2', '1496733715', '1496733715', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('34', '10012', '-2', '1496733788', '1496733788', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('35', '10012', '-2', '1496733788', '1496733788', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('36', '10012', '-2', '1496745862', '1496745862', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('37', '10012', '-2', '1496745862', '1496745862', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('38', '10013', '-2', '1496745936', '1496745936', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('39', '10015', '-2', '1496746063', '1496746063', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('40', '10015', '-2', '1496746063', '1496746063', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('41', '10013', '-2', '1496839160', '1496839160', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('42', '10015', '-2', '1496839233', '1496839233', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('43', '10015', '-2', '1496839233', '1496839233', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('44', '10012', '-2', '1496887817', '1496887817', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('45', '10012', '-2', '1496887817', '1496887817', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('46', '10012', '-2', '1496888400', '1496888400', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('47', '10012', '-2', '1496888400', '1496888400', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('48', '10012', '-2', '1496888659', '1496888659', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('49', '10012', '-2', '1496888659', '1496888659', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('50', '10012', '-2', '1496888859', '1496888859', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('51', '10012', '-2', '1496888859', '1496888859', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('52', '10012', '-2', '1496889084', '1496889084', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('53', '10012', '-2', '1496889084', '1496889084', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('54', '10012', '-2', '1496889279', '1496889279', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('55', '10012', '-2', '1496889279', '1496889279', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('56', '10012', '-2', '1496889529', '1496889529', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('57', '10012', '-2', '1496889529', '1496889529', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('58', '10012', '-2', '1496889555', '1496889555', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('59', '10012', '-2', '1496889555', '1496889555', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('60', '10013', '-2', '1496890634', '1496890634', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('61', '10013', '-2', '1496890758', '1496890758', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('62', '10013', '-2', '1496890892', '1496890892', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('63', '10013', '-2', '1496890992', '1496890992', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('64', '10013', '-2', '1496891170', '1496891170', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('65', '10013', '-2', '1496891205', '1496891205', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('66', '10012', '-2', '1496891319', '1496891319', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('67', '10012', '-2', '1496891319', '1496891319', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('68', '10013', '-2', '1496891467', '1496891467', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('69', '10013', '-2', '1496891501', '1496891501', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('70', '10015', '-2', '1496891928', '1496891928', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('71', '10015', '-2', '1496891928', '1496891928', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('72', '10015', '-2', '1496892122', '1496892122', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('73', '10015', '-2', '1496892122', '1496892122', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('74', '10015', '-2', '1496892279', '1496892279', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('75', '10015', '-2', '1496892279', '1496892279', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('76', '10015', '-2', '1496892390', '1496892390', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('77', '10015', '-2', '1496892390', '1496892390', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('78', '10015', '-2', '1496892563', '1496892563', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('79', '10015', '-2', '1496892563', '1496892563', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('80', '10015', '-2', '1496892619', '1496892619', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('81', '10015', '-2', '1496892619', '1496892619', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('82', '10015', '-2', '1496894222', '1496894222', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('83', '10015', '-2', '1496894222', '1496894222', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('84', '10012', '-2', '1496894423', '1496894423', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('85', '10012', '-2', '1496894423', '1496894423', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('86', '10013', '-2', '1496894431', '1496894431', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('87', '10015', '-2', '1496894445', '1496894445', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('88', '10015', '-2', '1496894445', '1496894445', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('89', '10012', '-2', '1498230073', '1498230073', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('90', '10012', '-2', '1498230073', '1498230073', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('91', '10013', '-2', '1498230475', '1498230475', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('92', '10013', '-2', '1498230759', '1498230759', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('93', '10015', '-2', '1498230888', '1498230888', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('94', '10015', '-2', '1498230888', '1498230888', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('95', '10012', '-2', '1498316652', '1498316652', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('96', '10012', '-2', '1498316652', '1498316652', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('97', '10012', '-2', '1498316816', '1498316816', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('98', '10012', '-2', '1498316816', '1498316816', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('99', '10012', '-2', '1498316962', '1498316962', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('100', '10012', '-2', '1498316962', '1498316962', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('101', '10012', '-2', '1498317272', '1498317272', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('102', '10012', '-2', '1498317272', '1498317272', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('103', '10012', '-2', '1498317578', '1498317578', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('104', '10012', '-2', '1498317578', '1498317578', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('105', '10012', '-2', '1498318416', '1498318416', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('106', '10012', '-2', '1498318416', '1498318416', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('107', '10012', '-2', '1498318481', '1498318481', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('108', '10012', '-2', '1498318481', '1498318481', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('109', '10012', '-2', '1498353544', '1498353544', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('110', '10012', '-2', '1498353544', '1498353544', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('111', '10012', '-2', '1498353639', '1498353639', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('112', '10012', '-2', '1498353639', '1498353639', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('113', '10012', '-2', '1498357275', '1498357275', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('114', '10012', '-2', '1498357275', '1498357275', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('115', '10012', '-2', '1498358255', '1498358255', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('116', '10012', '-2', '1498358255', '1498358255', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('117', '10015', '-2', '1498365683', '1498365683', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('118', '10015', '-2', '1498365683', '1498365683', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('119', '10015', '-2', '1498365799', '1498365799', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('120', '10015', '-2', '1498365799', '1498365799', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('121', '10013', '-2', '1498391730', '1498391730', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('122', '10012', '-2', '1498461232', '1498461232', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('123', '10012', '-2', '1498461232', '1498461232', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('124', '10012', '-2', '1498461314', '1498461314', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('125', '10012', '-2', '1498461314', '1498461314', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('126', '10012', '-2', '1498461471', '1498461471', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('127', '10012', '-2', '1498461471', '1498461471', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('128', '10013', '-2', '1498462204', '1498462204', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('129', '10013', '-2', '1498462331', '1498462331', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('130', '10015', '-2', '1498462574', '1498462574', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('131', '10015', '-2', '1498462574', '1498462574', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('132', '10012', '-2', '1498536086', '1498536086', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('133', '10012', '-2', '1498536086', '1498536086', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('134', '10012', '-2', '1498536303', '1498536303', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('135', '10012', '-2', '1498536303', '1498536303', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('136', '10012', '-2', '1498536423', '1498536423', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('137', '10012', '-2', '1498536423', '1498536423', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('138', '10013', '-2', '1498536800', '1498536800', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('139', '10013', '-2', '1498536861', '1498536861', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('140', '10015', '-2', '1498545409', '1498545409', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('141', '10015', '-2', '1498545409', '1498545409', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('142', '10020', '1', '1498545465', '1498545465', '1', '1', '12', '10000', '10027');
INSERT INTO `dycms_products_spec` VALUES ('143', '10020', '1', '1498545465', '1498545465', '1', '1', '12', '10003', '10028');
INSERT INTO `dycms_products_spec` VALUES ('144', '10015', '-2', '1498549619', '1498549619', '114', '114', '12', '10000', '10027');
INSERT INTO `dycms_products_spec` VALUES ('145', '10015', '-2', '1498549619', '1498549619', '114', '114', '12', '10003', '10028');
INSERT INTO `dycms_products_spec` VALUES ('146', '10015', '-2', '1498574621', '1498574621', '114', '114', '12', '10000', '10027');
INSERT INTO `dycms_products_spec` VALUES ('147', '10015', '-2', '1498574621', '1498574621', '114', '114', '12', '10003', '10028');
INSERT INTO `dycms_products_spec` VALUES ('148', '10012', '-2', '1498656141', '1498656141', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('149', '10012', '-2', '1498656141', '1498656141', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('150', '10013', '-2', '1498656191', '1498656191', '114', '114', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('151', '10012', '-2', '1498657831', '1498657831', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('152', '10012', '-2', '1498657831', '1498657831', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('153', '10013', '-2', '1498657853', '1498657853', '114', '114', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('154', '10012', '-2', '1498745281', '1498745281', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('155', '10012', '-2', '1498745281', '1498745281', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('156', '10012', '-2', '1498745491', '1498745491', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('157', '10012', '-2', '1498745491', '1498745491', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('158', '10012', '-2', '1498806243', '1498806243', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('159', '10012', '-2', '1498806243', '1498806243', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('160', '10015', '-2', '1498806926', '1498806926', '114', '114', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('161', '10015', '-2', '1498806926', '1498806926', '114', '114', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('162', '10012', '-2', '1498815657', '1498815657', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('163', '10012', '-2', '1498815657', '1498815657', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('164', '10013', '-2', '1498816325', '1498816325', '114', '114', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('165', '10012', '-2', '1498869300', '1498869300', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('166', '10012', '-2', '1498869300', '1498869300', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('167', '10012', '-2', '1498870633', '1498870633', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('168', '10012', '-2', '1498870633', '1498870633', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('169', '10012', '-2', '1498870761', '1498870761', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('170', '10012', '-2', '1498870761', '1498870761', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('171', '10012', '-2', '1498871895', '1498871895', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('172', '10012', '-2', '1498871895', '1498871895', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('173', '10012', '-2', '1498872769', '1498872769', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('174', '10012', '-2', '1498872769', '1498872769', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('175', '10012', '-2', '1498903129', '1498903129', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('176', '10012', '-2', '1498903129', '1498903129', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('177', '10012', '-2', '1498911732', '1498911732', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('178', '10012', '-2', '1498911732', '1498911732', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('179', '10012', '-2', '1498917541', '1498917541', '114', '114', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('180', '10012', '-2', '1498917541', '1498917541', '114', '114', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('181', '10013', '-2', '1498917553', '1498917553', '114', '114', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('182', '10015', '-2', '1498917566', '1498917566', '114', '114', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('183', '10015', '-2', '1498917566', '1498917566', '114', '114', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('184', '10016', '-2', '1498917821', '1498917821', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('185', '10016', '-2', '1498917895', '1498917895', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('186', '10016', '-2', '1498918037', '1498918037', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('187', '10016', '-2', '1498918471', '1498918471', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('188', '10016', '-2', '1498970719', '1498970719', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('189', '10016', '-2', '1498972048', '1498972048', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('190', '10016', '-2', '1498974126', '1498974126', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('191', '10016', '-2', '1498974522', '1498974522', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('192', '10013', '-2', '1498975191', '1498975191', '114', '114', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('193', '10016', '-2', '1499005755', '1499005755', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('194', '10016', '-2', '1499007215', '1499007215', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('195', '10016', '-2', '1499139542', '1499139542', '114', '114', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('196', '10016', '-2', '1504257333', '1504257333', '1', '1', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('197', '10015', '-2', '1504257347', '1504257347', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('198', '10015', '-2', '1504257347', '1504257347', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('199', '10013', '-2', '1504257513', '1504257513', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('200', '10012', '-2', '1504257522', '1504257522', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('201', '10012', '-2', '1504257522', '1504257522', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('202', '10012', '-2', '1504257618', '1504257618', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('203', '10012', '-2', '1504257618', '1504257618', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('204', '10013', '1', '1504257625', '1504257625', '1', '1', '12', '10002', '10023');
INSERT INTO `dycms_products_spec` VALUES ('205', '10015', '1', '1504257635', '1504257635', '1', '1', '12', '10000', '10024');
INSERT INTO `dycms_products_spec` VALUES ('206', '10015', '1', '1504257635', '1504257635', '1', '1', '12', '10003', '10025');
INSERT INTO `dycms_products_spec` VALUES ('207', '10016', '1', '1504257646', '1504257646', '1', '1', '12', '10001', '10029');
INSERT INTO `dycms_products_spec` VALUES ('208', '10014', '1', '1566403754', '1566403754', '1', '1', '12', '10000', '10026');
INSERT INTO `dycms_products_spec` VALUES ('209', '10014', '1', '1566403754', '1566403754', '1', '1', '12', '10001', '10026');
INSERT INTO `dycms_products_spec` VALUES ('210', '10014', '1', '1566403754', '1566403754', '1', '1', '12', '10002', '10026');
INSERT INTO `dycms_products_spec` VALUES ('211', '10014', '1', '1566403754', '1566403754', '1', '1', '12', '10003', '10026');
INSERT INTO `dycms_products_spec` VALUES ('212', '10014', '1', '1566403754', '1566403754', '1', '1', '12', '10004', '10026');
INSERT INTO `dycms_products_spec` VALUES ('213', '10012', '-2', '1566403846', '1566403846', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('214', '10012', '-2', '1566403846', '1566403846', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('215', '10012', '-2', '1566403897', '1566403897', '1', '1', '12', '10000', '10020');
INSERT INTO `dycms_products_spec` VALUES ('216', '10012', '-2', '1566403897', '1566403897', '1', '1', '12', '10001', '10021');
INSERT INTO `dycms_products_spec` VALUES ('217', '10012', '-2', '1566403897', '1566403897', '1', '1', '12', '10002', '10021');
INSERT INTO `dycms_products_spec` VALUES ('218', '10012', '-2', '1566403897', '1566403897', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('219', '10012', '-2', '1566403928', '1566403928', '1', '1', '12', '10000', '10020');
INSERT INTO `dycms_products_spec` VALUES ('220', '10012', '-2', '1566403928', '1566403928', '1', '1', '12', '10001', '10020');
INSERT INTO `dycms_products_spec` VALUES ('221', '10012', '-2', '1566403928', '1566403928', '1', '1', '12', '10002', '10020');
INSERT INTO `dycms_products_spec` VALUES ('222', '10012', '-2', '1566403928', '1566403928', '1', '1', '12', '10003', '10021');
INSERT INTO `dycms_products_spec` VALUES ('223', '10012', '-2', '1566403928', '1566403928', '1', '1', '12', '10004', '10021');
INSERT INTO `dycms_products_spec` VALUES ('224', '10012', '-2', '1566403984', '1566403984', '1', '1', '12', '10000', '10030');
INSERT INTO `dycms_products_spec` VALUES ('225', '10012', '-2', '1566403984', '1566403984', '1', '1', '12', '10001', '10031');
INSERT INTO `dycms_products_spec` VALUES ('226', '10012', '-2', '1566403984', '1566403984', '1', '1', '12', '10002', '10020');
INSERT INTO `dycms_products_spec` VALUES ('227', '10012', '1', '1566403996', '1566403996', '1', '1', '12', '10002', '10020');
INSERT INTO `dycms_products_spec` VALUES ('228', '10012', '1', '1566403996', '1566403996', '1', '1', '12', '10000', '10030');
INSERT INTO `dycms_products_spec` VALUES ('229', '10012', '1', '1566403996', '1566403996', '1', '1', '12', '10001', '10031');

-- ----------------------------
-- Table structure for dycms_products_virtual
-- ----------------------------
DROP TABLE IF EXISTS `dycms_products_virtual`;
CREATE TABLE `dycms_products_virtual` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `virtual_no` varchar(64) DEFAULT NULL COMMENT '发货绑定编码',
  `product_id` int(11) DEFAULT '0' COMMENT '产品ID号',
  `etype` tinyint(2) DEFAULT '0' COMMENT '实体类型(1=券，2=培训,3=套餐)',
  `entityid` int(11) DEFAULT '0' COMMENT '实体ID号',
  `num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='虚拟产品详情表';

-- ----------------------------
-- Records of dycms_products_virtual
-- ----------------------------
INSERT INTO `dycms_products_virtual` VALUES ('4', 'pro_vr_1496715442573_1', '10020', '1', '10026', '10', '1', '-1', '0', '1496715460', '1496715460', '1', '1');
INSERT INTO `dycms_products_virtual` VALUES ('5', 'pro_vr_1496715442573_1', '10020', '1', '10026', '10', '1', '-1', '0', '1496732448', '1496732448', '1', '1');
INSERT INTO `dycms_products_virtual` VALUES ('6', 'pro_vr_1496715442573_1', '10020', '1', '10026', '10', '1', '1', '0', '1496733715', '1496733715', '1', '1');

-- ----------------------------
-- Table structure for dycms_shopcart
-- ----------------------------
DROP TABLE IF EXISTS `dycms_shopcart`;
CREATE TABLE `dycms_shopcart` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0',
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `sort` varchar(225) DEFAULT '' COMMENT '排序',
  `parameters` varchar(225) DEFAULT '' COMMENT '参数',
  `price` decimal(50,2) NOT NULL DEFAULT '0.00',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对应产品id',
  `status` tinyint(4) DEFAULT '0' COMMENT '会员状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10068 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='登录用户购物车表';

-- ----------------------------
-- Records of dycms_shopcart
-- ----------------------------
INSERT INTO `dycms_shopcart` VALUES ('10000', '10015', '10011', '6', '', '', '20.00', '0', '10025', '-1', '1497095089', '1497096564', '10011', '10011');
INSERT INTO `dycms_shopcart` VALUES ('10001', '10015', '10011', '2', '', '', '36.00', '0', '10024', '-1', '1497095137', '1497096565', '10011', '10011');
INSERT INTO `dycms_shopcart` VALUES ('10002', '10013', '10011', '1', '', '', '48.00', '0', '10023', '-1', '1497096410', '1497096566', '10011', '10011');
INSERT INTO `dycms_shopcart` VALUES ('10003', '10015', '10011', '1', '', '', '20.00', '0', '10025', '-1', '1497096583', '1497096590', '10011', '10011');
INSERT INTO `dycms_shopcart` VALUES ('10004', '10013', '10007', '3', '', '', '48.00', '0', '10023', '-1', '1497096665', '1497098485', '10007', '10007');
INSERT INTO `dycms_shopcart` VALUES ('10005', '10012', '10007', '2', '', '', '68.00', '0', '10020', '-1', '1497096673', '1497098485', '10007', '10007');
INSERT INTO `dycms_shopcart` VALUES ('10006', '10015', '10007', '1', '', '', '20.00', '0', '10025', '-1', '1497098302', '1497099138', '10007', '10007');
INSERT INTO `dycms_shopcart` VALUES ('10007', '10015', '10007', '2', '', '', '36.00', '0', '10024', '-1', '1497098470', '1497098484', '10007', '10007');
INSERT INTO `dycms_shopcart` VALUES ('10008', '10015', '10006', '1', '', '', '20.00', '0', '10025', '-1', '1497100949', '1497101141', '10006', '10006');
INSERT INTO `dycms_shopcart` VALUES ('10009', '10013', '10007', '2', '', '', '48.00', '0', '10023', '-1', '1497135642', '1497135651', '10007', '10007');
INSERT INTO `dycms_shopcart` VALUES ('10010', '10013', '10007', '2', '', '', '48.00', '0', '10023', '-1', '1497135654', '1497135672', '10007', '10007');
INSERT INTO `dycms_shopcart` VALUES ('10011', '10013', '10007', '5', '', '', '48.00', '0', '10023', '-1', '1497135685', '1497138757', '10007', '10007');
INSERT INTO `dycms_shopcart` VALUES ('10012', '10015', '10007', '1', '', '', '20.00', '0', '10025', '1', '1497144673', '1497162998', '10007', '10007');
INSERT INTO `dycms_shopcart` VALUES ('10013', '10012', '10094', '1', '', '', '68.00', '0', '10020', '-1', '1497447038', '1497447060', '10094', '10094');
INSERT INTO `dycms_shopcart` VALUES ('10014', '10015', '10094', '1', '', '', '36.00', '0', '10024', '-1', '1497447050', '1497447060', '10094', '10094');
INSERT INTO `dycms_shopcart` VALUES ('10015', '10014', '10053', '2', '', '', '168.00', '0', '10026', '-1', '1497447510', '1497448081', '10053', '10053');
INSERT INTO `dycms_shopcart` VALUES ('10016', '10015', '10278', '1', '', '', '36.00', '0', '10024', '-1', '1497916255', '1497916287', '10278', '10278');
INSERT INTO `dycms_shopcart` VALUES ('10017', '10012', '10040', '1', '', '', '38.00', '0', '10021', '-1', '1497923446', '1497923571', '10040', '10040');
INSERT INTO `dycms_shopcart` VALUES ('10018', '10015', '10040', '1', '', '', '36.00', '0', '10024', '1', '1497923474', '1497923474', '10040', '10040');
INSERT INTO `dycms_shopcart` VALUES ('10019', '10015', '10040', '1', '', '', '20.00', '0', '10025', '-1', '1497923485', '1497923571', '10040', '10040');
INSERT INTO `dycms_shopcart` VALUES ('10020', '10012', '10094', '1', '', '', '68.00', '0', '10020', '-1', '1498436480', '1498436531', '10094', '10094');
INSERT INTO `dycms_shopcart` VALUES ('10021', '10015', '10094', '1', '', '', '36.00', '0', '10024', '-1', '1498436503', '1498436531', '10094', '10094');
INSERT INTO `dycms_shopcart` VALUES ('10022', '10012', '10180', '1', '', '', '38.00', '0', '10021', '-1', '1498713940', '1498714025', '10180', '10180');
INSERT INTO `dycms_shopcart` VALUES ('10023', '10015', '10180', '1', '', '', '20.00', '0', '10025', '-1', '1498713995', '1498714025', '10180', '10180');
INSERT INTO `dycms_shopcart` VALUES ('10024', '10015', '10411', '1', '', '', '36.00', '0', '10024', '-1', '1498792532', '1498792580', '10411', '10411');
INSERT INTO `dycms_shopcart` VALUES ('10025', '10012', '10572', '1', '', '', '38.00', '0', '10021', '1', '1498887823', '1498887823', '10572', '10572');
INSERT INTO `dycms_shopcart` VALUES ('10026', '10014', '10572', '1', '', '', '168.00', '0', '10026', '1', '1498887884', '1498887884', '10572', '10572');
INSERT INTO `dycms_shopcart` VALUES ('10027', '10014', '10661', '1', '', '', '168.00', '0', '10026', '1', '1499089998', '1499089998', '10661', '10661');
INSERT INTO `dycms_shopcart` VALUES ('10028', '10014', '10666', '2', '', '', '168.00', '0', '10026', '-1', '1499094460', '1499094518', '10666', '10666');
INSERT INTO `dycms_shopcart` VALUES ('10029', '10013', '10666', '2', '', '', '48.00', '0', '10023', '-1', '1499094710', '1499094725', '10666', '10666');
INSERT INTO `dycms_shopcart` VALUES ('10030', '10012', '10673', '1', '', '', '68.00', '0', '10020', '-1', '1499177060', '1499177194', '10673', '10673');
INSERT INTO `dycms_shopcart` VALUES ('10031', '10014', '10673', '1', '', '', '168.00', '0', '10026', '-1', '1499177101', '1499177194', '10673', '10673');
INSERT INTO `dycms_shopcart` VALUES ('10032', '10014', '10174', '2', '', '', '168.00', '0', '10026', '-1', '1499178596', '1499178691', '10174', '10174');
INSERT INTO `dycms_shopcart` VALUES ('10033', '10012', '10021', '1', '', '', '68.00', '0', '10020', '-1', '1499332677', '1503713642', '10021', '10021');
INSERT INTO `dycms_shopcart` VALUES ('10034', '10014', '10055', '2', '', '', '168.00', '0', '10026', '-1', '1499749117', '1499752653', '10055', '10055');
INSERT INTO `dycms_shopcart` VALUES ('10035', '10014', '10237', '2', '', '', '168.00', '0', '10026', '-1', '1499837137', '1499837339', '10237', '10237');
INSERT INTO `dycms_shopcart` VALUES ('10036', '10012', '10006', '4', '', '', '68.00', '0', '10020', '-1', '1499909291', '1504495724', '10006', '10006');
INSERT INTO `dycms_shopcart` VALUES ('10037', '10012', '10038', '1', '', '', '68.00', '0', '10020', '1', '1500809203', '1500809203', '10038', '10038');
INSERT INTO `dycms_shopcart` VALUES ('10038', '10014', '10410', '1', '', '', '168.00', '0', '10026', '-1', '1500911141', '1500911218', '10410', '10410');
INSERT INTO `dycms_shopcart` VALUES ('10039', '10012', '10410', '1', '', '', '68.00', '0', '10020', '-1', '1500911179', '1500911218', '10410', '10410');
INSERT INTO `dycms_shopcart` VALUES ('10040', '10015', '10410', '1', '', '', '36.00', '0', '10024', '-1', '1500911188', '1500911218', '10410', '10410');
INSERT INTO `dycms_shopcart` VALUES ('10041', '10013', '10410', '1', '', '', '48.00', '0', '10023', '-1', '1500911211', '1500911218', '10410', '10410');
INSERT INTO `dycms_shopcart` VALUES ('10042', '10014', '10886', '1', '', '', '168.00', '0', '10026', '1', '1501059297', '1501059297', '10886', '10886');
INSERT INTO `dycms_shopcart` VALUES ('10043', '10014', '10410', '2', '', '', '168.00', '0', '10026', '-1', '1501135096', '1501135105', '10410', '10410');
INSERT INTO `dycms_shopcart` VALUES ('10044', '10014', '10197', '1', '', '', '168.00', '0', '10026', '1', '1501149485', '1501149485', '10197', '10197');
INSERT INTO `dycms_shopcart` VALUES ('10045', '10014', '10939', '1', '', '', '168.00', '0', '10026', '1', '1501381326', '1501381326', '10939', '10939');
INSERT INTO `dycms_shopcart` VALUES ('10046', '10015', '11199', '1', '', '', '36.00', '0', '10024', '-1', '1503921544', '1503921591', '11199', '11199');
INSERT INTO `dycms_shopcart` VALUES ('10047', '10014', '11199', '1', '', '', '168.00', '0', '10026', '-1', '1503921559', '1503921591', '11199', '11199');
INSERT INTO `dycms_shopcart` VALUES ('10048', '10015', '11199', '1', '', '', '36.00', '0', '10024', '-1', '1503921613', '1503921640', '11199', '11199');
INSERT INTO `dycms_shopcart` VALUES ('10049', '10014', '11199', '1', '', '', '168.00', '0', '10026', '-1', '1503921623', '1503921640', '11199', '11199');
INSERT INTO `dycms_shopcart` VALUES ('10050', '10014', '10452', '2', '', '', '168.00', '0', '10026', '-1', '1503924542', '1503924712', '10452', '10452');
INSERT INTO `dycms_shopcart` VALUES ('10051', '10012', '10442', '1', '', '', '68.00', '0', '10020', '1', '1503924821', '1504000732', '10442', '10442');
INSERT INTO `dycms_shopcart` VALUES ('10052', '10015', '10442', '1', '', '', '20.00', '0', '10025', '1', '1503924837', '1503924837', '10442', '10442');
INSERT INTO `dycms_shopcart` VALUES ('10053', '10015', '10442', '1', '', '', '36.00', '0', '10024', '1', '1503924871', '1503924871', '10442', '10442');
INSERT INTO `dycms_shopcart` VALUES ('10054', '10012', '10442', '1', '', '', '38.00', '0', '10021', '1', '1503924891', '1503924891', '10442', '10442');
INSERT INTO `dycms_shopcart` VALUES ('10055', '10012', '10155', '3', '', '', '38.00', '0', '10021', '-1', '1503926780', '1503926893', '10155', '10155');
INSERT INTO `dycms_shopcart` VALUES ('10056', '10012', '10155', '1', '', '', '68.00', '0', '10020', '-1', '1503926801', '1503926830', '10155', '10155');
INSERT INTO `dycms_shopcart` VALUES ('10057', '10014', '10351', '1', '', '', '168.00', '0', '10026', '1', '1504277241', '1504277241', '10351', '10351');
INSERT INTO `dycms_shopcart` VALUES ('10058', '10014', '11199', '1', '', '', '168.00', '0', '10026', '1', '1504347536', '1504347536', '11199', '11199');
INSERT INTO `dycms_shopcart` VALUES ('10059', '10014', '10000', '1', '', '', '168.00', '0', '10026', '1', '1504397559', '1504397559', '10000', '10000');
INSERT INTO `dycms_shopcart` VALUES ('10060', '10014', '10006', '1', '', '', '168.00', '0', '10026', '-1', '1504495770', '1507983518', '10006', '10006');
INSERT INTO `dycms_shopcart` VALUES ('10061', '10014', '11269', '1', '', '', '168.00', '0', '10026', '1', '1504498799', '1504498799', '11269', '11269');
INSERT INTO `dycms_shopcart` VALUES ('10062', '10014', '11339', '2', '', '', '168.00', '0', '10026', '1', '1504753930', '1504753934', '11339', '11339');
INSERT INTO `dycms_shopcart` VALUES ('10063', '10014', '11342', '1', '', '', '168.00', '0', '10026', '1', '1506475205', '1506475205', '11342', '11342');
INSERT INTO `dycms_shopcart` VALUES ('10064', '10014', '10723', '1', '', '', '168.00', '0', '10026', '1', '1506476608', '1506476622', '10723', '10723');
INSERT INTO `dycms_shopcart` VALUES ('10065', '10014', '11716', '1', '', '', '168.00', '0', '10026', '1', '1507156596', '1507156596', '11716', '11716');
INSERT INTO `dycms_shopcart` VALUES ('10066', '10014', '11883', '1', '', '', '168.00', '0', '10026', '1', '1508196592', '1508196592', '11883', '11883');
INSERT INTO `dycms_shopcart` VALUES ('10067', '10014', '10157', '1', '', '', '168.00', '0', '10026', '1', '1508596571', '1508596571', '10157', '10157');

-- ----------------------------
-- Table structure for dycms_shop_order
-- ----------------------------
DROP TABLE IF EXISTS `dycms_shop_order`;
CREATE TABLE `dycms_shop_order` (
  `id` int(11) unsigned NOT NULL,
  `order_no` varchar(20) NOT NULL COMMENT '订单编码',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户id号',
  `pay_code` varchar(255) DEFAULT NULL,
  `payment` varchar(64) DEFAULT NULL COMMENT '支付方式',
  `express` int(11) DEFAULT '0' COMMENT '配送方式id号',
  `pay_status` tinyint(1) DEFAULT NULL COMMENT '支付状态,1待付款2已付款3待退款4已退款',
  `delivery_status` tinyint(1) DEFAULT '0' COMMENT '发货状态（0=未发货1=部分发货2=已发货）',
  `payable_amount` float(10,2) DEFAULT '0.00' COMMENT '应付总金额',
  `real_amount` float(10,2) DEFAULT '0.00' COMMENT '实付总金额',
  `payable_freight` float(10,2) DEFAULT '0.00' COMMENT '配送费用',
  `real_freight` float(10,2) DEFAULT '0.00' COMMENT '实际配送费用',
  `pay_time` int(11) DEFAULT '0' COMMENT '支付时间',
  `send_time` int(11) DEFAULT '0' COMMENT '发货时间',
  `completion_time` int(11) DEFAULT NULL COMMENT '订单完成时间',
  `handling_fee` float(10,2) DEFAULT '0.00' COMMENT '支付手续费',
  `invoice_type` tinyint(6) DEFAULT '1' COMMENT '发票类型 1 = 个人 2=公司',
  `invoice_title` varchar(255) DEFAULT '' COMMENT '发票抬头',
  `taxes` float(10,2) DEFAULT '0.00' COMMENT '发票税金',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `discount_amount` float(10,2) DEFAULT '0.00' COMMENT '活动优惠金额',
  `adjust_amount` float(10,2) DEFAULT '0.00' COMMENT '订单折扣或涨价',
  `order_amount` float(10,2) DEFAULT '0.00' COMMENT '调整后订单总金额',
  `order_status` tinyint(8) DEFAULT '0' COMMENT '订单状态 0=取消1=下单成功2=已经支付3=商品出库4=交易成功',
  `cancel_time` int(11) DEFAULT NULL COMMENT '取消时间',
  `delivery_time` int(11) DEFAULT NULL COMMENT '发货时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `pay_name` varchar(64) DEFAULT NULL COMMENT '支付方式名称',
  `order_origin_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '下单来源 1=admin 2=web 3=wap',
  `express_fee` float(10,2) DEFAULT '0.00' COMMENT '邮费',
  `coupon_id` int(11) NOT NULL DEFAULT '0' COMMENT '使用的优惠券id--结算时候才真正扣除',
  `coupon_off` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '使用代金券抵消',
  `coupon_name` varchar(512) DEFAULT '' COMMENT '券名',
  `coupon_type` int(11) NOT NULL DEFAULT '0' COMMENT '优惠券类型：1：代金券，2兑换券',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '下单类型：1：购物，2：兑换券，3为提货，4为发货到仓库,10：旧系统数据',
  `is_new` tinyint(4) DEFAULT '1' COMMENT '是否为新订单；0：不是新，1：新',
  `order_time` int(11) DEFAULT NULL COMMENT '下单时间',
  `exception_status` tinyint(1) DEFAULT '0' COMMENT '异常状态,31：提交中，32：审核中，33：审核通过，34审核不通过',
  `agent_id` int(11) DEFAULT NULL COMMENT '代理商id',
  `delivery_store_id` int(11) DEFAULT NULL COMMENT '库存id',
  `delivery_handler` varchar(255) DEFAULT NULL COMMENT '审核人',
  `delivery_reason` varchar(255) DEFAULT NULL COMMENT '原因',
  `member_product_amount` float(10,2) DEFAULT '0.00' COMMENT '会员产品总金额-参与优惠和兑换券抵消',
  `origin_product_amount` float(10,2) DEFAULT '0.00' COMMENT '原始产品总金额-参与优惠和兑换券抵消',
  `take_type` int(11) DEFAULT NULL COMMENT '提货,1:快递；2：自提',
  `pick_up_store_id` int(11) DEFAULT NULL COMMENT '自提店id',
  `pick_up_store_name` varchar(255) DEFAULT NULL COMMENT '自提店名',
  `pick_up_store_address` varchar(512) DEFAULT NULL COMMENT '自提店地址',
  `pick_up_store_phone` varchar(255) DEFAULT NULL COMMENT '自提店电话',
  `pick_up_code` varchar(255) DEFAULT '' COMMENT '自提码',
  `pick_up_time` int(11) DEFAULT NULL COMMENT '取货时间',
  `cancel_handler` varchar(255) DEFAULT NULL COMMENT '取消操作人',
  `cancel_reason` varchar(255) DEFAULT NULL COMMENT '取消原因',
  PRIMARY KEY (`id`),
  KEY `order_no` (`order_no`,`status`) USING BTREE,
  KEY `uid` (`uid`,`status`) USING BTREE,
  KEY `coupon` (`coupon_id`) USING BTREE,
  KEY `status` (`status`) USING BTREE,
  KEY `order_status` (`order_status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10000 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商城订单';

-- ----------------------------
-- Records of dycms_shop_order
-- ----------------------------
INSERT INTO `dycms_shop_order` VALUES ('1706103654', '170610593be18e7e115', '10011', '148031161220170610201004', 'wxpay', '0', '2', '2', '30.00', '30.00', '0.00', '0.00', '1497096610', '0', '1497096916', '0.00', '1', '', '0.00', '1', '1497096590', '1497096634', '10011', '1', null, '0.00', '0.00', '4', null, '1497096683', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1497096590', '0', '0', null, null, null, '0.00', '0.00', '1', null, null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706101199', '170610593beb8233847', '10007', '148031161220170610205226', 'wxpay', '0', '2', '2', '30.00', '30.00', '0.00', '0.00', '1497099153', '0', '1497099544', '0.00', '1', '', '0.00', '1', '1497099138', '1508396129', '10007', '1', null, '0.00', '0.00', '4', null, '1497099532', '我要成为推广员', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1497099138', '0', '0', null, null, null, '0.00', '0.00', '1', null, null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706106881', '170610593bf355bfe29', '10006', '20170610212546', 'balancepay', '0', '2', '2', '30.00', '30.00', '0.00', '0.00', '1497101151', '0', '1497101401', '0.00', '1', '', '0.00', '1', '1497101141', '1497249256', '10006', '1', null, '0.00', '0.00', '4', null, '1497101394', '线上支付', '余额支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1497101141', '0', '0', null, null, null, '0.00', '0.00', '1', null, null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706111392', '170611593ce500b2a62', '10007', null, null, '0', '1', '0', '20.00', '0.00', '0.00', '0.00', '0', '0', '1497172572', '0.00', '1', '', '0.00', '1', '1497163008', '1497172572', '10007', '10007', '0.00', '0.00', '0.00', '0', '1497172572', null, '', null, '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497163008', '0', '100', null, null, null, '20.00', '20.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706117992', '170611593d067bb5b95', '10026', '148031161220170611170007', 'wxpay', '0', '2', '2', '48.00', '48.00', '0.00', '0.00', '1497171617', '0', '1497171721', '0.00', '1', '', '0.00', '1', '1497171579', '1497843501', '10026', '1', null, '0.00', '0.00', '4', null, '1497171692', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497171579', '0', '100', null, null, null, '48.00', '48.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '619064', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706128381', '170612593e8213e5b9a', '10060', '148031161220170612195927', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1497268775', '0', '1497444507', '0.00', '1', '', '0.00', '1', '1497268755', '1497490039', '10060', '1', null, '0.00', '0.00', '4', null, '1497327493', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497268755', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706146378', '17061459413a9423211', '10094', '20170614222913', 'balancepay', '0', '2', '2', '104.00', '104.00', '0.00', '0.00', '1497450553', '0', '1498211680', '0.00', '1', '', '0.00', '1', '1497447060', '1503278676', '10094', '114', null, '0.00', '0.00', '4', null, '1497535785', '', '用户余额支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497447060', '0', '10008', null, null, null, '104.00', '104.00', '1', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '423544', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706144998', '17061459413b6a06655', '10053', null, null, '0', '1', '0', '178.00', '0.00', '0.00', '0.00', '0', '0', '1497450606', '0.00', '1', '', '0.00', '1', '1497447274', '1497450606', '10053', '10053', '0.00', '0.00', '0.00', '0', '1497450606', null, '', null, '2', '10.00', '0', '0.00', '', '0', '1', '0', '1497447274', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706142447', '17061459413c6618a7c', '10053', null, null, '0', '1', '0', '336.00', '0.00', '0.00', '0.00', '0', '0', '1497450610', '0.00', '1', '', '0.00', '1', '1497447526', '1497489994', '10053', '1', '0.00', '0.00', '0.00', '0', '1497450610', null, '', null, '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497447526', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706142956', '17061459413cdc0d72d', '10053', null, null, '0', '1', '0', '336.00', '0.00', '0.00', '0.00', '0', '0', '1497450616', '0.00', '1', '', '0.00', '1', '1497447644', '1497503749', '10053', '1', '0.00', '0.00', '0.00', '0', '1497450616', null, '', null, '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497447644', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706148667', '17061459413de248fa2', '10053', null, null, '0', '1', '0', '336.00', '0.00', '0.00', '0.00', '0', '0', '1497450628', '0.00', '1', '', '0.00', '1', '1497447906', '1497489992', '10053', '1', '0.00', '0.00', '0.00', '0', '1497450628', null, '', null, '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497447906', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706143770', '17061459413e917764e', '10053', null, null, '0', '1', '0', '336.00', '0.00', '0.00', '0.00', '0', '0', '1497450632', '0.00', '1', '', '0.00', '1', '1497448081', '1497450632', '10053', '10053', '0.00', '0.00', '0.00', '0', '1497450632', null, '', null, '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497448081', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706147967', '17061459414013b9c95', '10053', '148031161220170614223047', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1497450664', '0', '1497855221', '0.00', '1', '', '0.00', '1', '1497448467', '1497845141', '10053', '1', null, '0.00', '0.00', '4', null, '1497496208', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497448467', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706146547', '170614594142a959264', '10006', null, null, '0', '1', '0', '30.00', '0.00', '0.00', '0.00', '0', '0', '1497491465', '0.00', '1', '', '0.00', '1', '1497449129', '1497491465', '10006', '10006', '0.00', '0.00', '0.00', '0', '1497491465', null, '', null, '2', '10.00', '0', '0.00', '', '0', '1', '0', '1497449129', '0', '10015', null, null, null, '20.00', '20.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('170615967', '170615594211b47a3dc', '10038', '148031161220170615125032', 'wxpay', '0', '2', '2', '20.00', '20.00', '0.00', '0.00', '1497502237', '0', '1497502383', '0.00', '1', '', '0.00', '1', '1497502132', '1498211708', '10038', '1', null, '0.00', '0.00', '4', null, '1497502356', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1497502132', '0', '10012', null, null, null, '20.00', '20.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '207839', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706174325', '1706175944054525e3f', '10006', null, null, '0', '1', '0', '78.00', '0.00', '0.00', '0.00', '0', '0', '1497630034', '0.00', '1', '', '0.00', '1', '1497630021', '1497661674', '10006', '1', '0.00', '0.00', '0.00', '0', '1497630034', null, '', null, '2', '10.00', '0', '0.00', '', '0', '1', '0', '1497630021', '0', '10015', null, null, null, '68.00', '68.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706209796', '1706205948637fa22b9', '10278', '148031161220170620173125', 'wxpay', '0', '2', '2', '46.00', '46.00', '0.00', '0.00', '1497951091', '0', '1498640129', '0.00', '1', '', '0.00', '1', '1497916287', '1498737599', '10278', '114', null, '0.00', '0.00', '4', null, '1498035311', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1497916287', '0', '10015', null, null, null, '36.00', '36.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706208143', '17062059487ff3bc712', '10040', '148031161220170620095748', 'wxpay', '0', '2', '2', '68.00', '68.00', '0.00', '0.00', '1497923873', '0', '1498122825', '0.00', '1', '', '0.00', '1', '1497923571', '1497941510', '10040', '1', null, '0.00', '0.00', '4', null, '1497945854', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1497923571', '0', '10015', null, null, null, '58.00', '58.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706229877', '170622594b40e0c31de', '10365', '148031161220170622120043', 'wxpay', '0', '2', '2', '123.00', '123.00', '0.00', '0.00', '1498104051', '0', '1499066304', '0.00', '1', '', '0.00', '1', '1498104032', '1498211688', '10365', '1', null, '0.00', '0.00', '4', null, '1498215079', '', '微信支付', '2', '15.00', '0', '0.00', '', '0', '1', '0', '1498104032', '0', '10052', null, null, null, '108.00', '108.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('170626759', '170626595053b3d00c8', '10094', '148031161220170626082218', 'wxpay', '0', '2', '2', '114.00', '114.00', '0.00', '0.00', '1498436547', '0', '1499066305', '0.00', '1', '', '0.00', '1', '1498436531', '1498455287', '10094', '1', null, '0.00', '0.00', '4', null, '1498455970', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1498436531', '0', '10008', null, null, null, '104.00', '104.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706262661', '170626595097fa99eea', '10039', '148031161220170626131354', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1498454040', '0', '1499094608', '0.00', '1', '', '0.00', '1', '1498454010', '1498455197', '10039', '1', null, '0.00', '0.00', '4', null, '1498471152', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1498454010', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706284981', '1706285952fbba2f84f', '10491', '148031161220170628084403', 'wxpay', '0', '2', '2', '46.00', '46.00', '0.00', '0.00', '1498610651', '0', '1499237849', '0.00', '1', '', '0.00', '1', '1498610618', '1498623035', '10491', '114', null, '0.00', '0.00', '4', null, '1498620219', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1498610618', '0', '10015', null, null, null, '36.00', '36.00', '1', '4', null, null, null, '', '2017', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706283665', '1706285953570d3f594', '10043', '148031161220170628151325', 'wxpay', '0', '2', '2', '36.00', '36.00', '0.00', '0.00', '1498634012', '0', '1499265091', '0.00', '1', '', '0.00', '1', '1498633997', '1498659360', '10043', '1', null, '0.00', '0.00', '4', null, '1498637999', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1498633997', '0', '10015', null, null, null, '36.00', '36.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '643323', '2017', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706299571', '17062959548fa976a6a', '10180', '148031161220170629132714', 'wxpay', '0', '2', '2', '68.00', '68.00', '0.00', '0.00', '1498714046', '0', '1499336050', '0.00', '1', '', '0.00', '1', '1498714025', '1498720461', '10180', '114', null, '0.00', '0.00', '4', null, '1498731205', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1498714025', '0', '10015', null, null, null, '58.00', '58.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706294049', '17062959549778c22b8', '10039', '148031161220170629140027', 'wxpay', '0', '2', '2', '78.00', '78.00', '0.00', '0.00', '1498716032', '0', '1499336051', '0.00', '1', '', '0.00', '1', '1498716024', '1498722274', '10039', '1', null, '0.00', '0.00', '4', null, '1498731218', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1498716024', '0', '10015', null, null, null, '68.00', '68.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('170630142', '1706305955c199578da', '10411', null, null, '0', '1', '0', '78.00', '0.00', '0.00', '0.00', '0', '0', '1498792618', '0.00', '1', '', '0.00', '1', '1498792345', '1499133778', '10411', '114', '0.00', '0.00', '0.00', '0', '1498792618', null, '', null, '2', '10.00', '0', '0.00', '', '0', '1', '0', '1498792345', '0', '10012', null, null, null, '68.00', '68.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706306308', '1706305955c28467559', '10411', null, null, '0', '1', '0', '46.00', '0.00', '0.00', '0.00', '0', '0', '1498792614', '0.00', '1', '', '0.00', '1', '1498792580', '1498808031', '10411', '1', '0.00', '0.00', '0.00', '0', '1498792614', null, '', null, '2', '10.00', '0', '0.00', '', '0', '1', '0', '1498792580', '0', '10012', null, null, null, '36.00', '36.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706307750', '1706305955c2c9cafba', '10411', '148031161220170630111954', 'wxpay', '0', '2', '2', '78.00', '78.00', '0.00', '0.00', '1498792803', '0', '1499409843', '0.00', '1', '', '0.00', '1', '1498792649', '1498793125', '10411', '113', null, '0.00', '0.00', '4', null, '1498796616', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1498792649', '0', '10012', null, null, null, '68.00', '68.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1706302263', '17063059560005684b3', '10596', '148031161220170630153909', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1498808365', '0', '1499044027', '0.00', '1', '', '0.00', '1', '1498808325', '1498816679', '10596', '113', null, '0.00', '0.00', '4', null, '1498816873', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1498808325', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707034280', '170703595a5df6e1677', '10666', '148031161220170703230843', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1499094528', '0', '1499819701', '0.00', '1', '', '0.00', '1', '1499094518', '1499525318', '10666', '114', null, '0.00', '0.00', '4', null, '1499158329', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1499094518', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707031326', '170703595a5ec5cf5f0', '10666', '148031161220170703231208', 'wxpay', '0', '2', '2', '96.00', '96.00', '0.00', '0.00', '1499094733', '0', '1499819703', '0.00', '1', '', '0.00', '1', '1499094725', '1499525233', '10666', '114', null, '0.00', '0.00', '4', null, '1499158340', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1499094725', '0', '10015', null, null, null, '96.00', '96.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '047121', '1499011200', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707042814', '170704595ba0ead670e', '10673', '148031161220170704220645', 'wxpay', '0', '2', '2', '246.00', '246.00', '0.00', '0.00', '1499177213', '0', '1499525211', '0.00', '1', '', '0.00', '1', '1499177194', '1499525370', '10673', '114', null, '0.00', '0.00', '4', null, '1499238223', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1499177194', '0', '10012', null, null, null, '236.00', '236.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707045602', '170704595ba6c3c6c3e', '10174', null, null, '0', '1', '0', '336.00', '0.00', '0.00', '0.00', '0', '0', '1507963612', '0.00', '1', '', '0.00', '1', '1499178691', null, '10174', null, '0.00', '0.00', '0.00', '0', '1507963612', null, '', null, '2', '0.00', '0', '0.00', '', '0', '1', '1', '1499178691', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, '梁裕苏', '超时作废');
INSERT INTO `dycms_shop_order` VALUES ('1707043707', '170704595ba7db6cc6b', '10174', '148031161220170704223621', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1499178988', '0', '1499846740', '0.00', '1', '', '0.00', '1', '1499178971', '1499525392', '10174', '114', null, '0.00', '0.00', '4', null, '1499238132', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1499178971', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707059509', '170705595cf6dbda7ca', '10679', '148031161220170705222540', 'wxpay', '0', '2', '2', '48.00', '48.00', '0.00', '0.00', '1499264747', '0', '1500027884', '0.00', '1', '', '0.00', '1', '1499264731', '1499525056', '10679', '114', null, '0.00', '0.00', '4', null, '1499332833', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1499264731', '0', '10012', null, null, null, '38.00', '38.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707115134', '17071159645bf4bd22b', '10391', '148031161220170711130250', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1499749378', '0', '1500367622', '0.00', '1', '', '0.00', '1', '1499749364', '1499751203', '10391', '113', null, '0.00', '0.00', '4', null, '1499752155', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1499749364', '0', '10052', null, null, null, '336.00', '336.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '377307', '1499702400', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707113562', '170711596471cd04289', '10753', '148031161220170711143604', 'wxpay', '0', '2', '2', '168.00', '168.00', '0.00', '0.00', '1499754971', '0', '1500631576', '0.00', '1', '', '0.00', '1', '1499754957', '1499840457', '10753', '113', null, '0.00', '0.00', '4', null, '1499840567', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1499754957', '0', '10015', null, null, null, '168.00', '168.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '668697', '1499702400', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707125030', '1707125965b39b83b5e', '10237', '148031161220170712132917', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1499837379', '0', '1500638808', '0.00', '1', '', '0.00', '1', '1499837339', '1499846417', '10237', '113', null, '0.00', '0.00', '4', null, '1499846560', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1499837339', '0', '10049', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707135160', '1707135966e11a60ae6', '10196', '148031161220170713105530', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1499914536', '0', '1500638809', '0.00', '1', '', '0.00', '1', '1499914522', '1500027895', '10196', '1', null, '0.00', '0.00', '4', null, '1499942031', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1499914522', '0', '10072', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707182687', '170718596db97ec9844', '10808', '148031161220170718153219', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1500363146', '0', '1501047202', '0.00', '1', '', '0.00', '1', '1500363134', '1500426288', '10808', '114', null, '0.00', '0.00', '4', null, '1500437180', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1500363134', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707214183', '1707215971d2e226822', '10753', '148031161220170721180943', 'wxpay', '0', '2', '2', '36.00', '36.00', '0.00', '0.00', '1500631790', '0', '1507963470', '0.00', '1', '', '0.00', '1', '1500631778', '1507514650', '10753', '113', null, '0.00', '0.00', '4', null, '1507943277', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1500631778', '0', '10015', null, null, null, '36.00', '36.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '485108', '1500566400', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707214796', '170721597203ca01306', '10009', null, null, '0', '1', '0', '48.00', '0.00', '0.00', '0.00', '0', '0', '1500646531', '0.00', '1', '', '0.00', '1', '1500644298', '1501117431', '10009', '113', '0.00', '0.00', '0.00', '0', '1500646531', null, '', null, '2', '0.00', '0', '0.00', '', '0', '1', '0', '1500644298', '0', '10015', null, null, null, '48.00', '48.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '', '1500566400', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707226196', '1707225973155754281', '10501', '148031161220170722170531', 'wxpay', '0', '2', '2', '78.00', '78.00', '0.00', '0.00', '1500714343', '0', '1501053448', '0.00', '1', '', '0.00', '1', '1500714327', '1501117439', '10501', '113', null, '0.00', '0.00', '4', null, '1500778249', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1500714327', '0', '10072', null, null, null, '68.00', '68.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707244059', '170724597615d5d1abf', '10410', null, null, '0', '1', '0', '178.00', '0.00', '0.00', '0.00', '0', '0', '1500911272', '0.00', '1', '', '0.00', '1', '1500911061', '1501117440', '10410', '113', '0.00', '0.00', '0.00', '0', '1500911272', null, '', null, '2', '10.00', '0', '0.00', '', '0', '1', '0', '1500911061', '0', '10012', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707248139', '17072459761672e87ae', '10410', '148031161220170724234708', 'wxpay', '0', '2', '2', '320.00', '320.00', '0.00', '0.00', '1500911234', '0', '1501666728', '0.00', '1', '', '0.00', '1', '1500911218', '1500952436', '10410', '113', null, '0.00', '0.00', '4', null, '1500953912', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1500911218', '0', '10012', null, null, null, '320.00', '320.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707269279', '1707265978a5681c2fc', '10366', '148031161220170726222150', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1501078916', '0', '1502078481', '0.00', '1', '', '0.00', '1', '1501078888', '1501117413', '10366', '113', null, '0.00', '0.00', '4', null, '1501127536', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1501078888', '0', '10052', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707272901', '17072759798101e74fa', '10410', '148031161220170727135829', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1501135115', '0', '1502078482', '0.00', '1', '', '0.00', '1', '1501135105', '1501145697', '10410', '114', null, '0.00', '0.00', '4', null, '1501216299', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1501135105', '0', '10012', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707279644', '1707275979e7f3d0e94', '10841', '148031161220170727211851', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1501161539', '0', '1502078482', '0.00', '1', '', '0.00', '1', '1501161459', '1501220053', '10841', '113', null, '0.00', '0.00', '4', null, '1501234331', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1501161459', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1707283956', '170728597b0ef621a83', '10197', '148031161220170728181853', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1501237142', '0', '1502078482', '0.00', '1', '', '0.00', '1', '1501236982', null, '10197', null, null, '0.00', '0.00', '4', null, '1501244660', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '1', '1501236982', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1708011065', '17080159807f0b4ff93', '10957', '148031161220170801212100', 'wxpay', '0', '2', '2', '168.00', '168.00', '0.00', '0.00', '1501593674', '0', '1502349333', '0.00', '1', '', '0.00', '1', '1501593355', '1501666732', '10957', '114', null, '0.00', '0.00', '4', null, '1501666825', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1501593355', '0', '10052', null, null, null, '168.00', '168.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '233810', '1501516800', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1708116438', '170811598d533b64e41', '11025', '148031161220170811144841', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1502434135', '0', '1503278634', '0.00', '1', '', '0.00', '1', '1502434107', '1502447511', '11025', '1', null, '0.00', '0.00', '4', null, '1502444358', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1502434107', '0', '10796', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('170811849', '170811598d9bdc1fddb', '10885', null, null, '0', '1', '0', '168.00', '0.00', '0.00', '0.00', '0', '0', '1503719821', '0.00', '1', '', '0.00', '1', '1502452700', '1503719821', '10885', '10885', '0.00', '0.00', '0.00', '0', '1503719821', null, '', null, '2', '0.00', '0', '0.00', '', '0', '1', '1', '1502452700', '0', null, null, null, null, '168.00', '168.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '', '1502380800', null, null);
INSERT INTO `dycms_shop_order` VALUES ('170821548', '170821599ab42d87276', '10302', '148031161220170821182236', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1503310970', '0', '1503921785', '0.00', '1', '', '0.00', '1', '1503310893', '1504144520', '10302', '1', null, '0.00', '0.00', '4', null, '1503316273', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1503310893', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1708286624', '17082859a405b770103', '11199', null, null, '0', '1', '0', '214.00', '0.00', '0.00', '0.00', '0', '0', '1503921672', '0.00', '1', '', '0.00', '1', '1503921591', '1504144516', '11199', '1', '0.00', '0.00', '0.00', '0', '1503921672', null, '', null, '2', '10.00', '0', '0.00', '', '0', '1', '0', '1503921591', '0', '10012', null, null, null, '204.00', '204.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1708286143', '17082859a405e87e12e', '11199', '148031161220170828200047', 'wxpay', '0', '2', '2', '214.00', '214.00', '0.00', '0.00', '1503921656', '0', '1504236403', '0.00', '1', '', '0.00', '1', '1503921640', '1504236352', '11199', '1', null, '0.00', '0.00', '4', null, '1503985249', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1503921640', '0', '10012', null, null, null, '204.00', '204.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('170828793', '17082859a411e8e33e3', '10452', '148031161220170828205207', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1503924735', '0', '1504236401', '0.00', '1', '', '0.00', '1', '1503924712', '1503976978', '10452', '113', null, '0.00', '0.00', '4', null, '1503985240', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1503924712', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1708289481', '17082859a41a6d0c1ca', '10155', '148031161220170828212822', 'wxpay', '0', '2', '2', '114.00', '114.00', '0.00', '0.00', '1503926916', '0', '1504236339', '0.00', '1', '', '0.00', '1', '1503926893', '1503927020', '10155', '114', null, '0.00', '0.00', '4', null, '1504005772', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1503926893', '0', '10015', null, null, null, '114.00', '114.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '438351', '1503936000', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1709019481', '17090159a93514b6321', '11226', '148031161220170901182344', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1504261436', '0', '1505122250', '0.00', '1', '', '0.00', '1', '1504261396', '1504276877', '11226', '1', null, '0.00', '0.00', '4', null, '1504322055', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1504261396', '0', '10052', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1709017526', '17090159a97a79bc88b', '11214', '148031161220170901231936', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1504279189', '0', '1504742847', '0.00', '1', '', '0.00', '1', '1504279161', null, '11214', null, null, '0.00', '0.00', '4', null, '1504327624', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '1', '1504279161', '0', '10018', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1709088584', '17090859b289a38f1f9', '10027', '148031161220170908201449', 'wxpay', '0', '2', '2', '272.00', '272.00', '0.00', '0.00', '1504872901', '0', '1507528621', '0.00', '1', '', '0.00', '1', '1504872867', '1505275642', '10027', '1', null, '0.00', '0.00', '4', null, '1504945139', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1504872867', '0', '10024', null, null, null, '272.00', '272.00', '2', '4', '盛安源店', '东莞市南城区簪花路凯名轩A16铺', '0769-23029777', '981001', '1504800000', null, null);
INSERT INTO `dycms_shop_order` VALUES ('1709086672', '17090859b2b426801f5', '11376', '148031161220170908231556', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1504883764', '0', '1507528621', '0.00', '1', '', '0.00', '1', '1504883750', null, '11376', null, null, '0.00', '0.00', '4', null, '1504942058', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '1', '1504883750', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1709206307', '17092059c2782236f7e', '11506', '148031161220170920221657', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1505917032', '0', '1507528621', '0.00', '1', '', '0.00', '1', '1505916962', '1507616113', '11506', '1', null, '0.00', '0.00', '4', null, '1505979493', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1505916962', '0', '10016', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710029570', '17100259d2440689e25', '11701', '148031161220171002215015', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1506952222', '0', '1507615572', '0.00', '1', '', '0.00', '1', '1506952198', '1506994039', '11701', '1', null, '0.00', '0.00', '4', null, '1507000366', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1506952198', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710055897', '17100559d562eeeca67', '11716', null, null, '0', '1', '0', '178.00', '0.00', '0.00', '0.00', '0', '0', '1507156881', '0.00', '1', '', '0.00', '1', '1507156718', '1507156881', '11716', '11716', '0.00', '0.00', '0.00', '0', '1507156881', null, '', null, '2', '10.00', '0', '0.00', '', '0', '1', '1', '1507156718', '0', '100', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710053612', '17100559d563a31cfc6', '11716', '148031161220171005064216', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1507156942', '0', '1507943000', '0.00', '1', '', '0.00', '1', '1507156899', '1507530621', '11716', '1', null, '0.00', '0.00', '4', null, '1507254891', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1507156899', '0', '100', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710109521', '17101059dc5d12a2374', '10781', '148031161220171010133937', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1507613986', '0', '1507963467', '0.00', '1', '', '0.00', '1', '1507613970', '1507616739', '10781', '113', null, '0.00', '0.00', '4', null, '1507624826', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1507613970', '0', '10015', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710104738', '17101059dc5d58f198c', '10302', null, null, '0', '1', '0', '1008.00', '0.00', '0.00', '0.00', '0', '0', '1507963583', '0.00', '1', '', '0.00', '1', '1507614040', null, '10302', null, '0.00', '0.00', '0.00', '0', '1507963583', null, '', null, '2', '0.00', '0', '0.00', '', '0', '1', '1', '1507614040', '0', '10298', null, null, null, '1008.00', '1008.00', '1', '4', null, null, null, '', null, '梁裕苏', '超时作废');
INSERT INTO `dycms_shop_order` VALUES ('17101176', '17101159dd85f4eb1da', '11517', '148031161220171011104632', 'wxpay', '0', '2', '2', '178.00', '178.00', '0.00', '0.00', '1507689998', '0', '1507963462', '0.00', '1', '', '0.00', '1', '1507689972', '1507953686', '11517', '1', null, '0.00', '0.00', '4', null, '1507691760', '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '0', '1507689972', '0', '10809', null, null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710134647', '17101359e063ef05c3d', '11762', '148031161220171013145755', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1507877882', '0', '1507963460', '0.00', '1', '', '0.00', '1', '1507877871', '1507879331', '11762', '113', null, '0.00', '0.00', '4', null, '1507889026', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1507877871', '0', '10015', null, null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710174370', '17101759e5aad847ae1', '11939', '148031161220171017150506', 'wxpay', '0', '2', '2', '504.00', '504.00', '0.00', '0.00', '1508223914', '0', '1508470147', '0.00', '1', '', '0.00', '1', '1508223704', '1508232550', '11939', '114', null, '0.00', '0.00', '4', null, '1508238940', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1508223704', '0', '11887', '4', null, null, '504.00', '504.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710188905', '17101859e748c06437c', '11962', '148031161220171018203135', 'wxpay', '0', '2', '2', '176.00', '176.00', '0.00', '0.00', '1508329903', '0', null, '0.00', '1', '', '0.00', '1', '1508329664', '1508336583', '11962', '1', null, '0.00', '0.00', '3', null, '1508386217', '', '微信支付', '2', '8.00', '0', '0.00', '', '0', '1', '0', '1508329664', '0', '10018', '4', null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710203329', '17102059e97f7d92660', '12023', '148031161220171020124556', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1508474765', '0', null, '0.00', '1', '', '0.00', '1', '1508474749', null, '12023', null, null, '0.00', '0.00', '3', null, '1508490869', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '1', '1508474749', '0', '100', '4', null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710211556', '17102159eaed10c1857', '11932', '148031161220171021144602', 'wxpay', '0', '2', '2', '336.00', '336.00', '0.00', '0.00', '1508568368', '0', null, '0.00', '1', '', '0.00', '1', '1508568336', '1508570817', '11932', '1', null, '0.00', '0.00', '3', null, '1508641577', '', '微信支付', '2', '0.00', '0', '0.00', '', '0', '1', '0', '1508568336', '0', '11887', '4', null, null, '336.00', '336.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710237795', '17102359edfb618b2ff', '12141', '148031161220171023222340', 'wxpay', '0', '2', '0', '178.00', '178.00', '0.00', '0.00', '1508768636', '0', null, '0.00', '1', '', '0.00', '1', '1508768609', null, '12141', null, null, '0.00', '0.00', '2', null, null, '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '1', '1508768609', '0', '11887', '4', null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);
INSERT INTO `dycms_shop_order` VALUES ('1710232365', '17102359ee0f5c444d8', '12152', '148031161220171023234909', 'wxpay', '0', '2', '0', '178.00', '178.00', '0.00', '0.00', '1508773761', '0', null, '0.00', '1', '', '0.00', '1', '1508773724', null, '12152', null, null, '0.00', '0.00', '2', null, null, '', '微信支付', '2', '10.00', '0', '0.00', '', '0', '1', '1', '1508773724', '0', '10872', '4', null, null, '168.00', '168.00', '1', '4', null, null, null, '', null, null, null);

-- ----------------------------
-- Table structure for dycms_shop_order_product
-- ----------------------------
DROP TABLE IF EXISTS `dycms_shop_order_product`;
CREATE TABLE `dycms_shop_order_product` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sort` varchar(225) DEFAULT '' COMMENT '排序',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `goods_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对应产品id',
  `status` tinyint(4) DEFAULT '0' COMMENT '会员状态',
  `created_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `updated_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `created_by` int(11) DEFAULT NULL COMMENT '创建人',
  `updated_by` int(11) DEFAULT NULL COMMENT '修改人',
  `product_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '对应产品id',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `delivery_num` int(10) unsigned DEFAULT '0' COMMENT '已发货数量',
  `delivery_status` tinyint(1) DEFAULT '0' COMMENT '物流状态（0=未发货 1=部分发货 3=已发货）',
  `delivery_id` tinyint(2) DEFAULT NULL COMMENT '发货方式id',
  `sell_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '销售价',
  `market_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场价',
  `member_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '会员价',
  `discount_count` int(10) DEFAULT '0' COMMENT '兑换券抵扣数',
  `discount_amount` float(10,2) DEFAULT '0.00' COMMENT '兑换券抵扣金额',
  `amount` float(10,2) DEFAULT '0.00' COMMENT '合计金额',
  `goods_name` varchar(128) DEFAULT NULL COMMENT '商品名',
  `product_name` varchar(200) DEFAULT NULL COMMENT '产品名称',
  `product_spec` text COMMENT '商品规格',
  `goods_img` varchar(255) DEFAULT NULL COMMENT '商品图片',
  `product_no` varchar(128) DEFAULT NULL COMMENT '商品规格',
  `is_discount` tinyint(1) DEFAULT NULL COMMENT '是否打折',
  `vipdiscount` float(10,2) NOT NULL DEFAULT '1.00' COMMENT '优惠折扣,小数值 0.98=98%',
  `goods_tags` varchar(255) DEFAULT '' COMMENT '商品标签',
  `goods_keyword` varchar(255) DEFAULT '' COMMENT '商品关键词',
  `agency_price` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '代理价',
  `shop_discount` int(11) DEFAULT NULL,
  `cate_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`status`) USING BTREE,
  KEY `goods_id` (`goods_id`,`status`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10085 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='商城订单产品';

-- ----------------------------
-- Records of dycms_shop_order_product
-- ----------------------------
INSERT INTO `dycms_shop_order_product` VALUES ('10000', '1706103654', '', '0', '10015', '1', '1497096590', '1497096683', '10011', '1', '10025', '1', '1', '2', '2', '0.00', '20.00', '20.00', '0', '0.00', '20.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10001', '1706101199', '', '0', '10015', '1', '1497099138', '1497099532', '10007', '1', '10025', '1', '1', '2', '2', '0.00', '20.00', '20.00', '0', '0.00', '20.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10002', '1706106881', '', '0', '10015', '1', '1497101141', '1497101394', '10006', '1', '10025', '1', '1', '2', '2', '0.00', '20.00', '20.00', '0', '0.00', '20.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10003', '1706111392', '', '0', '10015', '1', '1497163008', null, '10007', null, '10025', '1', '0', '0', '2', '0.00', '20.00', '20.00', '0', '0.00', '20.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10004', '1706117992', '', '0', '10013', '1', '1497171579', '1497171692', '10026', '1', '10023', '1', '1', '2', '2', '0.00', '48.00', '48.00', '0', '0.00', '48.00', '黄玉姜片', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAyIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bb90db8dc.jpg', 'P010102_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10005', '1706128381', '', '0', '10014', '1', '1497268755', '1497327493', '10060', '1', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-08/5938c617ec945.jpg', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10006', '1706146378', '', '0', '10012', '1', '1497447060', '1497535785', '10094', '1', '10020', '1', '1', '2', '2', '0.00', '68.00', '68.00', '0', '0.00', '68.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bb5cae037.jpg', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10007', '1706146378', '', '0', '10015', '1', '1497447060', '1497535785', '10094', '1', '10024', '1', '1', '2', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10008', '1706144998', '', '0', '10014', '1', '1497447274', null, '10053', null, '10026', '1', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-08/5938c617ec945.jpg', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10009', '1706142447', '', '0', '10014', '1', '1497447526', null, '10053', null, '10026', '2', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-08/5938c617ec945.jpg', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10010', '1706142956', '', '0', '10014', '1', '1497447644', null, '10053', null, '10026', '2', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-08/5938c617ec945.jpg', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10011', '1706148667', '', '0', '10014', '1', '1497447906', null, '10053', null, '10026', '2', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-08/5938c617ec945.jpg', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10012', '1706143770', '', '0', '10014', '1', '1497448081', null, '10053', null, '10026', '2', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-08/5938c617ec945.jpg', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10013', '1706147967', '', '0', '10014', '1', '1497448467', '1497496208', '10053', '1', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-08/5938c617ec945.jpg', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10014', '1706146547', '', '0', '10015', '1', '1497449129', null, '10006', null, '10025', '1', '0', '0', '2', '0.00', '20.00', '20.00', '0', '0.00', '20.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10015', '170615967', '', '0', '10015', '1', '1497502132', '1497502356', '10038', '1', '10025', '1', '1', '2', '2', '0.00', '20.00', '20.00', '0', '0.00', '20.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10016', '1706174325', '', '0', '10012', '1', '1497630021', null, '10006', null, '10020', '1', '0', '0', '2', '0.00', '68.00', '68.00', '0', '0.00', '68.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bb5cae037.jpg', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10017', '1706209796', '', '0', '10015', '1', '1497916287', '1498035311', '10278', '1', '10024', '1', '1', '2', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10018', '1706208143', '', '0', '10012', '1', '1497923571', '1497945854', '10040', '1', '10021', '1', '1', '2', '2', '0.00', '38.00', '38.00', '0', '0.00', '38.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDA0Iiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjIwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bb5cae037.jpg', 'P010101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10019', '1706208143', '', '0', '10015', '1', '1497923571', '1497945854', '10040', '1', '10025', '1', '1', '2', '2', '0.00', '20.00', '20.00', '0', '0.00', '20.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10020', '1706229877', '', '0', '10015', '1', '1498104032', '1498215079', '10365', '1', '10024', '3', '3', '2', '2', '0.00', '36.00', '36.00', '0', '0.00', '108.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-04/5933bc6072d5f.jpg', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10021', '170626759', '', '0', '10012', '1', '1498436531', '1498455970', '10094', '1', '10020', '1', '1', '2', '2', '0.00', '68.00', '68.00', '0', '0.00', '68.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10022', '170626759', '', '0', '10015', '1', '1498436531', '1498455970', '10094', '1', '10024', '1', '1', '2', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10023', '1706262661', '', '0', '10014', '1', '1498454010', '1498471152', '10039', '1', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10024', '1706284981', '', '0', '10015', '1', '1498610618', '1498620219', '10491', '113', '10024', '1', '1', '2', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10025', '1706283665', '', '0', '10015', '1', '1498633997', '1498637999', '10043', '113', '10024', '1', '1', '2', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10026', '1706299571', '', '0', '10012', '1', '1498714025', '1498731205', '10180', '114', '10021', '1', '1', '2', '2', '0.00', '38.00', '38.00', '0', '0.00', '38.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDA0Iiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjIwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10027', '1706299571', '', '0', '10015', '1', '1498714025', '1498731205', '10180', '114', '10025', '1', '1', '2', '2', '0.00', '20.00', '20.00', '0', '0.00', '20.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAzIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI1MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjUwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', 'P030101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10028', '1706294049', '', '0', '10012', '1', '1498716024', '1498731218', '10039', '114', '10020', '1', '1', '2', '2', '0.00', '68.00', '68.00', '0', '0.00', '68.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10029', '170630142', '', '0', '10012', '1', '1498792345', null, '10411', null, '10020', '1', '0', '0', '2', '0.00', '68.00', '68.00', '0', '0.00', '68.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10030', '1706306308', '', '0', '10015', '1', '1498792580', null, '10411', null, '10024', '1', '0', '0', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10031', '1706307750', '', '0', '10012', '1', '1498792649', '1498796616', '10411', '113', '10020', '1', '1', '2', '2', '0.00', '68.00', '68.00', '0', '0.00', '68.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10032', '1706302263', '', '0', '10014', '1', '1498808325', '1498816873', '10596', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10033', '1707034280', '', '0', '10014', '1', '1499094518', '1499158329', '10666', '113', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10034', '1707031326', '', '0', '10013', '1', '1499094725', '1499158340', '10666', '113', '10023', '2', '2', '2', '2', '0.00', '48.00', '48.00', '0', '0.00', '96.00', '黄玉姜片', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAyIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2fe5d58a4.png', 'P010102_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10035', '1707042814', '', '0', '10012', '1', '1499177194', '1499238223', '10673', '114', '10020', '1', '1', '2', '2', '0.00', '68.00', '68.00', '0', '0.00', '68.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10036', '1707042814', '', '0', '10014', '1', '1499177194', '1499238223', '10673', '114', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10037', '1707045602', '', '0', '10014', '1', '1499178691', null, '10174', null, '10026', '2', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10038', '1707043707', '', '0', '10014', '1', '1499178971', '1499238132', '10174', '114', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10039', '1707059509', '', '0', '10012', '1', '1499264731', '1499332833', '10679', '113', '10021', '1', '1', '2', '2', '0.00', '38.00', '38.00', '0', '0.00', '38.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDA0Iiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjIwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10040', '1707115134', '', '0', '10014', '1', '1499749364', '1499752155', '10391', '113', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10041', '1707113562', '', '0', '10014', '1', '1499754957', '1499840567', '10753', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10042', '1707125030', '', '0', '10014', '1', '1499837339', '1499846560', '10237', '113', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10043', '1707135160', '', '0', '10014', '1', '1499914522', '1499942031', '10196', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10044', '1707182687', '', '0', '10014', '1', '1500363134', '1500437180', '10808', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10045', '1707214183', '', '0', '10015', '1', '1500631778', '1507943277', '10753', '114', '10024', '1', '1', '2', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10046', '1707214796', '', '0', '10013', '1', '1500644298', null, '10009', null, '10023', '1', '0', '0', '2', '0.00', '48.00', '48.00', '0', '0.00', '48.00', '黄玉姜片', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAyIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2fe5d58a4.png', 'P010102_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10047', '1707226196', '', '0', '10012', '1', '1500714327', '1500778249', '10501', '113', '10020', '1', '1', '2', '2', '0.00', '68.00', '68.00', '0', '0.00', '68.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10048', '1707244059', '', '0', '10014', '1', '1500911061', null, '10410', null, '10026', '1', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10049', '1707248139', '', '0', '10014', '1', '1500911218', '1500953912', '10410', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10050', '1707248139', '', '0', '10012', '1', '1500911218', '1500953912', '10410', '113', '10020', '1', '1', '2', '2', '0.00', '68.00', '68.00', '0', '0.00', '68.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10051', '1707248139', '', '0', '10015', '1', '1500911218', '1500953912', '10410', '113', '10024', '1', '1', '2', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10052', '1707248139', '', '0', '10013', '1', '1500911218', '1500953912', '10410', '113', '10023', '1', '1', '2', '2', '0.00', '48.00', '48.00', '0', '0.00', '48.00', '黄玉姜片', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAyIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjI2MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjYwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2fe5d58a4.png', 'P010102_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10053', '1707269279', '', '0', '10014', '1', '1501078888', '1501127536', '10366', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10054', '1707272901', '', '0', '10014', '1', '1501135105', '1501216299', '10410', '113', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10055', '1707279644', '', '0', '10014', '1', '1501161459', '1501234331', '10841', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10056', '1707283956', '', '0', '10014', '1', '1501236982', '1501244660', '10197', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10057', '1708011065', '', '0', '10014', '1', '1501593355', '1501666825', '10957', '114', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10058', '1708116438', '', '0', '10014', '1', '1502434107', '1502444358', '11025', '114', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10059', '170811849', '', '0', '10014', '1', '1502452700', null, '10885', null, '10026', '1', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10060', '170821548', '', '0', '10014', '1', '1503310893', '1503316273', '10302', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10061', '1708286624', '', '0', '10015', '1', '1503921591', null, '11199', null, '10024', '1', '0', '0', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10062', '1708286624', '', '0', '10014', '1', '1503921591', null, '11199', null, '10026', '1', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10063', '1708286143', '', '0', '10015', '1', '1503921640', '1503985249', '11199', '113', '10024', '1', '1', '2', '2', '0.00', '36.00', '36.00', '0', '0.00', '36.00', '红糖粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAwIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjUwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiNTAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d3066c7f32.png', 'P030101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10064', '1708286143', '', '0', '10014', '1', '1503921640', '1503985249', '11199', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10065', '170828793', '', '0', '10014', '1', '1503924712', '1503985240', '10452', '113', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10066', '1708289481', '', '0', '10012', '1', '1503926893', '1504005772', '10155', '113', '10021', '3', '3', '2', '2', '0.00', '38.00', '38.00', '0', '0.00', '114.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDA0Iiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjIwMGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMjAwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_2', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10067', '1709019481', '', '0', '10014', '1', '1504261396', '1504322055', '11226', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10068', '1709017526', '', '0', '10014', '1', '1504279161', '1504327624', '11214', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-06-23/594cb3b7d136a.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10069', '1709088584', '', '0', '10012', '1', '1504872867', '1504945139', '10027', '113', '10020', '4', '4', '2', '2', '0.00', '68.00', '68.00', '0', '0.00', '272.00', '黄玉姜粉', null, 'W1t7Im5hbWUiOiJ2YWxfaWQiLCJ2YWx1ZSI6IjEwMDAxIiwic3BlY2lkIjoiMTIifSx7Im5hbWUiOiJ2YWxfbmFtZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoiY2hhbmdlX25hbWUiLCJ2YWx1ZSI6IjM4MGciLCJzcGVjaWQiOiIxMiJ9LHsibmFtZSI6ImNoYW5nZV9pbWciLCJ2YWx1ZSI6IiIsInNwZWNpZCI6IjEyIn0seyJuYW1lIjoic3BlY192YWx1ZSIsInZhbHVlIjoiMzgwZyIsInNwZWNpZCI6IjEyIn1dXQ==', '/Uploads/Image/Goods/2017-06-23/594d2d37128e9.png', 'P010101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10070', '1709086672', '', '0', '10014', '1', '1504883750', '1504942058', '11376', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10071', '1709206307', '', '0', '10014', '1', '1505916962', '1505979493', '11506', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10072', '1710029570', '', '0', '10014', '1', '1506952198', '1507000366', '11701', '1', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10073', '1710055897', '', '0', '10014', '1', '1507156719', null, '11716', null, '10026', '1', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10074', '1710053612', '', '0', '10014', '1', '1507156899', '1507254891', '11716', '113', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10075', '1710109521', '', '0', '10014', '1', '1507613970', '1507624826', '10781', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10076', '1710104738', '', '0', '10014', '1', '1507614040', null, '10302', null, '10026', '6', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '1008.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10077', '17101176', '', '0', '10014', '1', '1507689972', '1507691760', '11517', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10078', '1710134647', '', '0', '10014', '1', '1507877871', '1507889026', '11762', '113', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10079', '1710174370', '', '0', '10014', '1', '1508223704', '1508238940', '11939', '113', '10026', '3', '3', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '504.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10080', '1710188905', '', '0', '10014', '1', '1508329664', '1508386217', '11962', '113', '10026', '1', '1', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10081', '1710203329', '', '0', '10014', '1', '1508474749', '1508490869', '12023', '113', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10082', '1710211556', '', '0', '10014', '1', '1508568336', '1508641577', '11932', '113', '10026', '2', '2', '2', '2', '0.00', '168.00', '168.00', '0', '0.00', '336.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10083', '1710237795', '', '0', '10014', '1', '1508768609', null, '12141', null, '10026', '1', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);
INSERT INTO `dycms_shop_order_product` VALUES ('10084', '1710232365', '', '0', '10014', '1', '1508773724', null, '12152', null, '10026', '1', '0', '0', '2', '0.00', '168.00', '168.00', '0', '0.00', '168.00', '轻松灸', null, null, '/Uploads/Image/Goods/2017-09-05/59ae12ec775b6.png', 'P020101_1', null, '1.00', null, '', '0.00', null, null, null, null);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES ('1', '2014_10_12_000000_create_users_table', '1');
INSERT INTO `migrations` VALUES ('2', '2014_10_12_100000_create_password_resets_table', '1');
INSERT INTO `migrations` VALUES ('3', '2016_01_04_173148_create_admin_tables', '1');

-- ----------------------------
-- Table structure for movies
-- ----------------------------
DROP TABLE IF EXISTS `movies`;
CREATE TABLE `movies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `director` int(10) unsigned NOT NULL,
  `describe` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rate` tinyint(3) unsigned NOT NULL,
  `released` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `release_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of movies
-- ----------------------------
INSERT INTO `movies` VALUES ('1', '1', '1', '描述', '0', 'abc', '2019-08-15 13:43:42', '2019-08-15 13:44:36', '2019-08-15 13:44:36');

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of posts
-- ----------------------------

-- ----------------------------
-- Table structure for profiles
-- ----------------------------
DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `age` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of profiles
-- ----------------------------
INSERT INTO `profiles` VALUES ('1', '1', '15', '20', '2019-08-15 22:48:49', '2019-08-15 22:48:52');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'test1', '469514939@qq.com', 'admin', '1', '2019-08-15 13:46:35', '2019-08-15 13:46:35');

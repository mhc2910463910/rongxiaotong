/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80032
Source Host           : localhost:3306
Source Database       : rongxiaotong

Target Server Type    : MYSQL
Target Server Version : 80032
File Encoding         : 65001

Date: 2023-10-17 14:34:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_address
-- ----------------------------
DROP TABLE IF EXISTS `tb_address`;
CREATE TABLE `tb_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `own_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '属于哪个用户的地址',
  `consignee` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收货人',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `address_detail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收货地址',
  `is_default` tinyint DEFAULT '0' COMMENT '是否默认，0，不是，默认是1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_address
-- ----------------------------
INSERT INTO `tb_address` VALUES ('192', 'lisi', '李思', '15266448844', '山东省济南市历下区历下小区2号楼', '1');
INSERT INTO `tb_address` VALUES ('193', 'zhangsan', '张思睿', '15266448844', '山东省济南市历下区历下小区2号楼', '1');

-- ----------------------------
-- Table structure for tb_bank
-- ----------------------------
DROP TABLE IF EXISTS `tb_bank`;
CREATE TABLE `tb_bank` (
  `bank_id` int NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `introduce` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bank_phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `money` decimal(65,2) NOT NULL,
  `rate` decimal(65,2) NOT NULL,
  `repayment` int NOT NULL,
  PRIMARY KEY (`bank_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_bank
-- ----------------------------
INSERT INTO `tb_bank` VALUES ('1001', '青岛银行', '“青易贷”，是青岛银行小微企业融资产品服务品牌。为助力小微企业成长发展，青岛银行为广大小微企业打造全面金融服务品牌体系——“青易贷”，紧贴小微企业融资需求特点，紧跟市场经济发展变化，不断创新完善融资产品，形成特色产品体系，力争全方位地满足不同行业、不同成长阶段的小微企业各类融资需求。', '96588', '100000.00', '1.10', '24');
INSERT INTO `tb_bank` VALUES ('1002', '中国银行', '中国银行金融市场业务，包括国内、国际本外币金融市场相关交易、投资、理财、托管等业务，为公司、个人以及金融同业提供全面、完善、专业的各项金融市场服务。', '95566', '100000.00', '1.20', '36');
INSERT INTO `tb_bank` VALUES ('1004', '中国工商银行', '工商银行向小微企业主发放的，用于满足其生产经营资金需求或置换生产经营过程中产生的负债性资金的人民币贷款。', '95588', '150000.00', '1.10', '30');
INSERT INTO `tb_bank` VALUES ('1005', '日照银行', '“阳光”系列个人消费贷款业务是日照银行向符合规定条件的自然人发放的用于个人消费用途的人民币贷款业务，旨在以快捷方便的审批流程和优质的服务满足客户在大件商品或服务消费等个人资金需求，如住房装修、购家具家电、购车、婚庆、学习进修、旅游等。“阳光”系列个人消费贷款业务包含“阳光贷”、“金领贷”、“阳光·房易贷”、“阳光·保易贷”、“阳光·车易贷”“阳光·出国贷”等。', '96588', '100000.00', '2.00', '24');
INSERT INTO `tb_bank` VALUES ('1006', '华夏银行', '华夏银行作为债务融资工具全国首批主承销商之一，已从业十余载，连续十三年获“全国银行间同业拆借中心优秀交易成员”称号，承销团队经验丰富，专业高效，竭诚为广大企业服务。', '95577', '160000.00', '1.80', '36');
INSERT INTO `tb_bank` VALUES ('1007', '中国建设银行', '“诚贷通”小额无抵押贷款“诚贷通”小额无抵押贷款是建设银行为小企业客户发放，由企业主或企业实际控制人提供个人连带责任保证，无需抵（质）押物，用于小企业客户生产经营资金周转的人民币循环额度贷款。', '95533', '200000.00', '3.60', '36');
INSERT INTO `tb_bank` VALUES ('1008', '浦发银行', '点贷是我行面向符合条件的客户通过互联网在线受理、在线签约，并即时发放贷款的业务模式。', '95528', '150000.00', '1.10', '24');
INSERT INTO `tb_bank` VALUES ('1009', '中国平安银行', '“数保贷”平安银行与担保公司、担保基金、保险公司等联合开发的面向诚信纳税的中小企业法人或企业主的互联网信用贷款', '95511', '160000.00', '1.20', '36');
INSERT INTO `tb_bank` VALUES ('1010', '中国民生银行', '为进一步丰富金融服务乡村振兴的内涵，民生银行在持续迭代“农贷通”产品的基础上，通过与中国银联强强联合，将借记卡产品与贷款产品相融合，以科技赋能，将现代金融服务延伸到广大农村区域。“农贷通”卡满载10项特色涉农权益，为农户提供多样化增值服务。', '95568', '200000.00', '1.60', '24');

-- ----------------------------
-- Table structure for tb_bank_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_bank_user`;
CREATE TABLE `tb_bank_user` (
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `bank_id` int NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `real_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`user_name`) USING BTREE,
  KEY `bank_id` (`bank_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_bank_user
-- ----------------------------
INSERT INTO `tb_bank_user` VALUES ('buser01', '1001', '$2a$10$AC1gCsk1V5Ov7n.zvkxxvuMM4f3BnWmJqr4jNNYtVAm8j4nBdxIUq', '王家明', '13236963696', 'user', '2022-04-02 16:19:10', '2022-04-02 16:19:13');
INSERT INTO `tb_bank_user` VALUES ('buser02', '1006', '$2a$10$AC1gCsk1V5Ov7n.zvkxxvuMM4f3BnWmJqr4jNNYtVAm8j4nBdxIUq', '刘璐', '13236963696', 'user', '2022-04-02 16:19:10', '2022-04-02 16:19:13');
INSERT INTO `tb_bank_user` VALUES ('buser03', '1001', '$2a$10$AC1gCsk1V5Ov7n.zvkxxvuMM4f3BnWmJqr4jNNYtVAm8j4nBdxIUq', '李涵', '13236963696', 'user', '2022-04-02 16:19:10', '2022-04-02 16:19:13');

-- ----------------------------
-- Table structure for tb_discuss
-- ----------------------------
DROP TABLE IF EXISTS `tb_discuss`;
CREATE TABLE `tb_discuss` (
  `discuss_id` int NOT NULL AUTO_INCREMENT,
  `knowledge_id` int NOT NULL,
  `own_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY (`discuss_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_discuss
-- ----------------------------

-- ----------------------------
-- Table structure for tb_expert
-- ----------------------------
DROP TABLE IF EXISTS `tb_expert`;
CREATE TABLE `tb_expert` (
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `real_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `profession` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `position` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `belong` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`user_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_expert
-- ----------------------------
INSERT INTO `tb_expert` VALUES ('expert', '李专家', '13191929394', '生物化学', '高级工程师', '青岛生物研究所');
INSERT INTO `tb_expert` VALUES ('wangwu', '王五', '17898765432', '生物化学', '高级工程师', '青岛生物研究所');

-- ----------------------------
-- Table structure for tb_finance
-- ----------------------------
DROP TABLE IF EXISTS `tb_finance`;
CREATE TABLE `tb_finance` (
  `finance_id` int NOT NULL AUTO_INCREMENT,
  `bank_id` int NOT NULL,
  `own_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `real_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `id_num` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `status` int NOT NULL,
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `money` decimal(65,2) NOT NULL,
  `rate` decimal(65,2) NOT NULL,
  `repayment` int NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `combination_name1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `combination_phone1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `combination_idnum1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `combination_name2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `combination_phone2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `combination_idnum2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `file_info` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`finance_id`) USING BTREE,
  KEY `bank_id` (`bank_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_finance
-- ----------------------------
INSERT INTO `tb_finance` VALUES ('143', '1005', 'lisi', '李思', '15266448844', '123456', '0', null, '1000.00', '2.00', '6', '2023-10-17 10:42:03', '2023-10-17 10:42:03', null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for tb_financing_intention
-- ----------------------------
DROP TABLE IF EXISTS `tb_financing_intention`;
CREATE TABLE `tb_financing_intention` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `real_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `amount` int NOT NULL,
  `application` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `repayment_period` int NOT NULL,
  `area` int NOT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tb_financing_intention
-- ----------------------------
INSERT INTO `tb_financing_intention` VALUES ('8', 'zhangsan', '张三', '山东省青岛市', '10000', '种芒果', '芒果', '12', '100', '15266448844', '2023-10-17 10:40:25', '2023-10-17 10:40:25');

-- ----------------------------
-- Table structure for tb_knowledge
-- ----------------------------
DROP TABLE IF EXISTS `tb_knowledge`;
CREATE TABLE `tb_knowledge` (
  `knowledge_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `pic_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `own_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '发布者名字',
  `create_time` time NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`knowledge_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_knowledge
-- ----------------------------
INSERT INTO `tb_knowledge` VALUES ('22', '水稻种植全过程', '水稻种植第一步：晒种\n水稻种植第二步：选种\n水稻种植第三步：整秧版\n水稻种植第四步：播种\n水稻种植第五步：插秧\n水稻种植第六步：缓苗\n水稻种植第七步：田间管理（关键）', '2cc2479866734c8980d88c86db7dbdc7.webp', 'expert', '16:33:59', '2021-08-27 16:33:59');
INSERT INTO `tb_knowledge` VALUES ('23', '玉米种植过程详解 ', '玉米一直都被誉为长寿食品，含有丰富的蛋白质、脂肪、维生素、微量元素、纤维素等，具有开发高营养、高生物学功能食品的巨大潜力。但由于其遗传性较为复杂，变异种类丰富，在常规的育种过程中存在着周期过长、变异系数过大、影响子代生长发育的缺点，而现代生物育种技术不但克服了上述缺点和不足，同时也提高了育种速度和质量。玉米出苗后，要及时检查出苗情况，发现缺苗断垄要及时补种、补栽。3叶期前缺苗，用饱满种子浸种催芽后浇水补种。3叶期后缺苗用带土移栽法补苗(播种时可在行间播预备苗)，另外，缺苗处也可在附近留双株补救。', 'cb0d06358f8c40628b6dca273f881875.jpeg', 'expert', '09:31:37', '2021-08-30 09:31:37');
INSERT INTO `tb_knowledge` VALUES ('24', '大豆种植', '大豆可分为黄豆、青豆和黑豆。可大家都认为大豆只是黄豆。富含蛋白质,大豆磷脂由大豆提取出来的精华,大豆中提取的纯磷脂精华物质,对人体健康有着极大的帮助，并无副作用。对于黄大豆，它需要较长的生产时间，也非常得能耐寒冷，北方地区的气候条件适合种植;然而青豆的生长时间较短，适宜把', '12be19984e374bcfbf06561571365d07.jpg', 'expert', '09:37:43', '2021-08-30 09:37:43');
INSERT INTO `tb_knowledge` VALUES ('25', '永泰李干的制作过程', '福州特色农产品，永泰李干的制作过程，100％还原！暑期在家帮父母晒李干，永泰李干虽是福建名产，但是市场占有率很低，“养在深山人未识”。我家李干的口感、品质都是不错的，欢迎大家购买品尝！', '7765f8705bc54a2086bc295f3bd7217c.jpg', 'expert', '09:39:56', '2021-08-30 09:39:56');
INSERT INTO `tb_knowledge` VALUES ('26', '葡萄种植', '葡萄是我们生活中最常见的水果之一。如今，市场上出现了许多葡萄品种，一些葡萄正处于管理的关键阶段。这种葡萄管理说简单其实也简单，说复杂也复杂，会者不难，难者不会。掌握基本要点，就能实现“一年树，两年果，三年高产”的愿望。', 'd50a95115e7d4b2d832fbcc50e35944b.jpg', 'expert', '09:44:24', '2021-08-30 09:44:24');
INSERT INTO `tb_knowledge` VALUES ('27', '【农业种植 • 园艺】《天天学农（农技知识）》', '天天学农创始团队在过去的数年中走遍中国广大农村，与农民深入交谈，了解越多就越觉得必须要去为农民做点实事。我们中很多人是农民的孩子，知道中国农民真是一群非常勤劳的人，但缺乏生产技术，往往事倍功半，他们也渴望学习。农民是朴实的，像庄稼地一样，种下什么就收获什么。视频涵盖了大棚草莓、猕猴桃、苹果树等方方面面，是农民朋友切实需要的教学视频，我们将提供大量的农业技术教学视频，方便大家学习，不断提高农业技术，创造美好生活。', '5722cfcd93c84a9083720d2cb072c5a0.jpg', 'expert', '09:46:37', '2021-08-30 09:46:37');
INSERT INTO `tb_knowledge` VALUES ('28', '西瓜种植', '西瓜露地早春栽培，一般以地温稳定在15℃左右时为露地播种的适宜时间。播种的最佳时间，还应根据品种、栽培季节、栽培方式以及消费季节等条件来确定。一般月中下旬播种育苗，4月中下旬定植，6月下旬开始收获上市；秋西瓜7月上中旬播种，9月下旬开始采收上市。', 'c3a51b37a70348ccaa6347783975f8ef.png', 'expert', '09:54:19', '2021-08-30 09:54:19');
INSERT INTO `tb_knowledge` VALUES ('29', '生姜的一生｜现代农业种植和收获生姜', '两千多年来生姜一直活跃在餐桌上。一般做酱菜和小吃用嫩姜，做调料和药用以老姜为佳。传说，神农氏四处尝百草。有一次，误食毒蘑菇，吃了一株长着尖细叶子的青草，神农氏一阵腹泻，感觉死而复生。神农氏姓姜，他将这株救命的植物，叫做生姜。', '4265868e71a44832a3e39a4547dc307c.jpg', 'expert', '09:55:54', '2021-08-30 09:55:54');
INSERT INTO `tb_knowledge` VALUES ('30', '人工种植蘑菇', '黄伞伞，白杆杆，吃完一起开厂厂！一天卖2吨蘑菇的奥地利现代种植工厂赚钱全过程', '1aff704b6fa94e91b58bdda36f9db166.jpg', 'expert', '10:00:02', '2021-08-30 10:00:02');

-- ----------------------------
-- Table structure for tb_order
-- ----------------------------
DROP TABLE IF EXISTS `tb_order`;
CREATE TABLE `tb_order` (
  `order_id` int NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '需求标题',
  `price` decimal(65,2) DEFAULT NULL COMMENT '期望价格',
  `content` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '内容',
  `order_status` int NOT NULL DEFAULT '0' COMMENT '订单状态，0表示待合作，1表示待发货，2表示完成，3表示完成但未评价',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '1销售订单，2需求订单',
  `picture` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `own_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '发起订单人',
  `cooperation_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '合作人名字',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '订单收货地址',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_order
-- ----------------------------
INSERT INTO `tb_order` VALUES ('66', '地瓜粉红薯淀粉', '123.00', '福建闽南泉州官桥正宗农家手工自制地瓜粉红薯淀粉番薯粉无添加剂', '1', 'goods', '6c1c2f5b38ac4be190dfc4a421d65f73.jpg', 'wyn3', null, '2021-08-27 16:15:00', '2021-08-27 16:15:00', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('67', '新疆小红杏吊干杏', '45.00', '新疆小红杏吊干杏新鲜杏子农产品应季1斤装水果特甜小白杏净重4斤', '1', 'goods', 'a5ffef69b838400695cf8f4203e6626a.jpg', 'wyn3', null, '2021-08-27 16:17:10', '2021-08-27 16:17:10', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('68', '云南特产大香蕉', '23.00', '云南特产冬季水果大香蕉新鲜当季10斤农产品直销土特产农家孕妇水', '1', 'goods', 'a4418dc8694a4c51875e18c045169697.jpg', 'wyn3', null, '2021-08-27 16:19:03', '2021-08-27 16:19:03', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('69', '山东大葱', '34.00', '山东大葱新鲜5斤时令蔬菜东北香葱包邮蘸酱铁杆章丘10号助农产品', '1', 'goods', '8781c37f24d24376bfd037fcbcb44dc5.jpg', 'wyn3', null, '2021-08-27 16:20:15', '2021-08-27 16:20:15', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('70', '大别山野生羊肚菌', '345.00', '高端消费人群厨房食材 大别山野生羊肚菌干货煲汤菌菇类特产50克', '1', 'goods', '2004039df5b64028bec5d06bdad06f6b.jpg', 'wyn3', null, '2021-08-27 16:28:52', '2021-08-27 16:28:52', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('71', '苹果', '22.81', '东北鸡心果5斤锦绣海棠果特产玫瑰小苹果花红沙果孕妇新鲜水果。原产地直发，酸甜可口', '0', 'goods', '4f9d706af7be455cb246c6615a56b631.jpg', 'wyn3', null, '2021-08-27 16:30:06', '2022-07-22 10:01:19', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('72', '白溪豆腐干香', '56.00', '白溪豆腐干香干湖南新化特产农家石磨手工风味柴火烟熏非武冈豆干', '1', 'goods', 'c1300fb2e1a34873a8f0ff6274df5dd8.jpg', 'wyn3', null, '2021-08-27 16:30:43', '2021-08-27 16:30:43', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('73', '红柚', '23.80', '福建平和红心柚子9斤红肉蜜柚水果新鲜密柚当季琯溪孕妇整箱包邮', '1', 'goods', '3b39708a162f4e6881e3e4e502a2e3a6.jpg', 'wyn3', null, '2021-08-27 16:30:48', '2021-08-27 16:30:48', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('74', '百香果', '14.90', '广西百香果9斤特大果新鲜水果紫皮百果香果酱白香果5一级10包邮', '1', 'goods', '905b6a28de85432c9c969c6d3e06fff7.jpg', 'wyn3', null, '2021-08-27 16:31:51', '2021-08-27 16:31:51', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('76', '白葡萄', '79.00', '新疆无核白葡萄无籽水果新鲜当季整箱马奶提子青吐鲁番小葡萄5斤', '1', 'goods', '1dd2029058a547419b32814b9abf2969.jpg', 'wyn3', null, '2021-08-27 16:33:11', '2021-08-27 16:33:11', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('77', '榴莲', '65.80', '顺丰空运 泰国a级金枕头榴莲新鲜带壳巴掌当季进口水果整箱包邮', '0', 'goods', '6734e3ec36bd4ebc8348a358603de955.jpg', 'wyn3', null, '2021-08-27 16:33:36', '2021-08-27 16:33:36', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('78', '石榴', '15.80', '突尼斯软籽石榴水果新鲜10斤包邮无籽应季特大果会理甜红石榴一级', '0', 'goods', '87fabaebe89f4a66a3e29f1ada41c92b.jpg', 'zhangxukun', null, '2021-08-27 16:34:54', '2021-08-27 16:34:54', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('79', '车厘子', '138.00', '新鲜车厘子5斤装高端进口大樱桃包邮山东整箱一箱10当季孕妇水果', '0', 'goods', '4218be16396a44718fc8ed79d3fdfbfa.jpg', 'zhangxukun', null, '2021-08-27 16:35:15', '2021-08-27 16:35:15', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('80', '芋头新鲜小芋头', '324.00', '芋头新鲜小芋头江西农家蔬菜包邮毛芋仔梗芋子滑糯芋艿净重10斤', '0', 'goods', '5c888733b8ff4cb3a6ac2628b2492665.jpg', 'wyn3', null, '2021-08-27 16:35:17', '2021-08-27 16:35:17', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('81', '水蜜桃', '109.00', '正宗无锡水蜜桃湖景桃子旗舰店软桃新鲜水果礼盒装特产顺丰', '0', 'goods', '0dbd668be84a482ba2749eef5d141424.jpg', 'zhangxukun', null, '2021-08-27 16:35:53', '2021-08-27 16:35:53', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('82', '西梅', '69.00', '新疆法兰西西梅甜孕妇水果新鲜当季整箱特级李子正宗喀什西梅便秘', '0', 'goods', 'ef6dae3bb936415e849c208336537e0b.jpg', 'zhangxukun', null, '2021-08-27 16:37:42', '2021-08-27 16:37:42', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('83', '求购100斤大米', '123.00', '求购100斤大米，质量佳的优先考虑', '1', 'needs', '35b21d2ca3b1402f9ca67f917ce006c1.gif', 'lzh', null, '2021-08-27 16:38:29', '2021-08-27 17:27:49', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('84', '黄桃', '27.80', '正宗锦绣黄桃9斤桃子新鲜当季水果露天脆蜜桃带毛砀山整箱10包邮。收藏下单 拍下17.8元起 精选好果 香甜多汁~', '0', 'goods', 'd75dc206b22a48c6b9e50d81afa51cac.jpg', 'zhangxukun', null, '2021-08-27 16:38:58', '2021-08-27 16:38:58', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('86', '求购一千斤玉米', '2323.00', '急需，价低者来，请联系17826782782', '1', 'needs', '71ea0e08a7ce4bb697b1d6b87a113379.webp', 'zhangsan', null, '2021-08-27 16:40:28', '2021-08-27 16:40:28', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('87', '潮汕蓝姜', '25.00', '新鲜南姜蓝姜潮汕姜潮州姜野生山姜满包邮免运费芦苇姜 5斤25元', '0', 'goods', '8361828ce6a54b48832cf6b880961f3e.jpg', 'zhangsan', null, '2021-08-27 16:41:43', '2021-08-27 16:41:43', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('88', '小香薯', '22.80', '求购临安天目山现挖小香薯', '1', 'needs', 'a70954af69094cbf9c72f6d15eb24509.jpg', 'zhangsan', null, '2021-08-27 16:45:03', '2021-08-27 16:45:03', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('89', '青龙脆瓜', '98.00', '青龙瓜脆瓜稍瓜菜瓜烧瓜酱瓜边梁烧瓜低糖水果非八棱脆瓜三斤装', '0', 'goods', '43489c0d4a164f539fec75cfb8467de7.jpg', 'zhangsan', null, '2021-08-27 16:45:11', '2021-08-27 16:46:16', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('90', '求购90斤苹果', '2332.00', '甘甜可口，不要青苹果', '0', 'needs', 'eee99f060b4843909db360a346ddc18f.webp', 'zhangsan', null, '2021-08-27 16:45:29', '2021-08-27 16:45:29', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('91', '安徽特产米糖小吃', '30.00', '传统农家手工花生炒米糖米花糖安徽特产米糖休闲食品老式小吃零食', '0', 'goods', 'ac7937d4ff8f4eff9faf7dc25f6c2f20.jpg', 'zhangsan', null, '2021-08-27 16:48:05', '2021-08-27 16:53:21', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('92', '求购5斤红辣椒', '39.90', '求购5斤红辣椒，变态辣', '0', 'needs', 'e21080ff8f0c47ffb1dee3e236d6a5eb.jpg', 'zhangsan', null, '2021-08-27 16:48:34', '2021-08-27 16:48:34', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('93', '求购新疆西瓜', '324.00', '要甜的，昼夜温差大的环境中种植的', '0', 'needs', '38d1cf5c26ee444aa709ac2e94730812.webp', 'zhangsan', null, '2021-08-27 16:51:02', '2021-08-30 13:18:15', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('94', '求购10斤小紫薯', '48.80', '是小土豆，长不大，乒乓球大小的，但是要口感粉糯。有意者联系18312345678', '0', 'needs', '26820e36e2c449479a34b25c8a647f40.jpg', 'zhangsan', null, '2021-08-27 16:51:11', '2021-08-27 16:51:11', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('95', '来100斤茄子', '23321.00', '有的MM，价钱合理哦', '0', 'needs', 'd18b7b37555a4bbda1020d56a0626ed5.jpg', 'zhangsan', null, '2021-08-27 16:53:20', '2021-08-27 16:53:20', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('96', '甘蔗', '35.80', '广西黑皮甘蔗新鲜水果包邮当季特产脆甜杆孕妇果蔗批发整箱9-10斤', '0', 'goods', 'cf5cb1460b71490b97c3a95c71d6d5f6.jpg', 'zhangsan', null, '2021-08-27 16:54:31', '2021-08-27 16:54:31', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('97', '铁棍山药粉条', '69.00', '怀道居铁棍山药粉条河南焦作山药粉皮红薯正宗手工铁棍山药粉丝', '0', 'goods', '53fd61682e224f3abb96bff64afbd04f.jpg', 'zhangsan', null, '2021-08-27 16:55:10', '2021-08-27 16:55:10', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('98', '收100斤羊肉', '2333.00', '价钱给够，带价来，咩咩咩', '0', 'needs', '609b8a1aeef9473ca1bfd5f93098ce8f.jpg', 'zhangsan', null, '2021-08-27 16:55:57', '2021-08-27 16:55:57', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('99', '野生阳荷新鲜', '26.00', '湖北恩施现挖现新鲜阳荷姜现摘现发新鲜直达500克买2包邮送一野生', '0', 'goods', 'a258efae882540bb910f167aa1c43a8f.jpg', 'zhangsan', null, '2021-08-27 16:57:08', '2021-08-27 16:57:08', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('100', '求购青苹果', '120.00', '求购40斤青苹果，有意者私聊', '0', 'needs', 'effaf0126a2541c4a18f8431051743ac.jpg', 'zhangsan', null, '2021-08-27 16:57:29', '2021-08-27 16:57:29', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('101', '杨梅', '159.00', '求购浮宫杨梅新鲜当季孕妇水果应季非仙居东魁杨梅', '0', 'needs', 'd65fa5bfb94a4270b1e3265e34d83214.jpg', 'zhangsan', null, '2021-08-27 16:59:45', '2021-08-27 16:59:45', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('102', '洋芋蛋蛋', '12.40', '诚信求购新鲜洋芋蛋蛋', '0', 'needs', '0cb58391ab754653abe7958c6b4febc4.jpg', 'zhangsan', null, '2021-08-27 17:00:07', '2021-08-27 17:00:07', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('103', '人参果', '96.00', '求购云南人参果圆果5斤精品中果应季孕妇圆水果新鲜当季', '0', 'needs', '8e5a53c441794395b84076fa2e457f40.jpg', 'lisi', null, '2021-08-27 17:01:49', '2021-08-27 17:01:49', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('104', '求购葡萄', '89.00', '求购福安象环葡萄巨峰产地大葡萄5斤', '0', 'needs', '08ea2a0040674d6098b426ad96715fd1.jpg', 'lisi', null, '2021-08-27 17:10:07', '2021-08-27 17:10:07', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('105', '甘蓝', '26.80', '求购羽衣甘蓝新鲜沙拉西餐蔬菜食材即食健身有机蔬菜2斤', '0', 'needs', 'f3705c3686944a5bb3843d842f4f37d8.jpg', 'lisi', null, '2021-08-27 17:14:26', '2021-08-27 17:14:26', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('106', '佛手瓜', '19.90', '求购新鲜云南佛手瓜5斤', '0', 'needs', '566ae2891bf24952874058b86051f4a2.jpg', 'lisi', null, '2021-08-27 17:28:37', '2021-08-27 17:28:37', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('113', '芒果', '12.00', '芒果芒果芒果芒果芒果', '0', 'goods', '2ab1041c64d64575a51d6eafa4dfcc4e.jpg', 'lisi', null, '2021-08-31 10:18:31', '2021-08-31 10:18:31', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('139', '西瓜', '11.00', '烟台红富士本地苹果1', '0', 'goods', 'e3b03f632c4241e2addb8f56378f0aed.jpg', 'lisi', null, '2022-09-01 09:38:24', '2023-09-20 14:10:26', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('140', '西瓜', '10.00', '新疆大西瓜，又甜又脆', '1', 'goods', '9552bd6894ad48909996f59b9f21852a.jpg', 'lisi', null, '2022-09-01 11:50:29', '2022-09-01 11:50:29', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('141', '求购水蜜桃', '20.00', '求购水蜜桃', '0', 'needs', 'ff485f0e71684f6fb48c23021ebf1408.jpg', 'lisi', null, '2022-09-01 11:54:29', '2022-09-01 11:54:29', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('142', '西瓜', '30.00', '新疆大西瓜，又甜又脆', '1', 'goods', 'c43dcae086e34c80900885c11f0a9e4d.jpg', 'lisi', null, '2022-09-01 17:00:46', '2022-09-01 17:00:46', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('143', '小麦', '2.00', '出售小麦，质量好，价格低', '0', 'goods', '49e7ded3704b45aab65e2b26a1202a89.gif', 'lisi', null, '2022-09-08 10:37:27', '2022-09-08 10:37:27', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('146', '求购新鲜蔬1', '20.00', '急需一斤马铃薯，一斤西红柿，详情联系15688774455', '0', 'needs', 'e40128f83cf548499c73ac300c5ff2d7.png', 'lisi', null, '2023-09-20 10:36:08', '2023-09-20 14:06:28', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('152', '蔬菜大礼包', '30.00', '黄瓜一斤，土豆一斤，白菜一斤，洋葱一斤', '0', 'goods', '5cffe0f348c1482fbb930e1d814adafd.png', 'lisi', null, '2023-09-20 11:38:34', '2023-09-20 11:38:34', '西安市未央区沣产路二府营村');
INSERT INTO `tb_order` VALUES ('153', '蔬菜瓜果', '100.00', '求购大量新鲜蔬菜瓜果', '0', 'needs', 'd82f2fc8faee464992fa7f327ae865e4.png', 'zhangsan', null, '2023-10-17 10:36:25', '2023-10-17 10:36:25', '山东省青岛市');
INSERT INTO `tb_order` VALUES ('154', '蔬菜大礼包', '100.00', '蔬菜大礼包，啥都有啥都有好', '0', 'goods', 'e1db642c38374bb4b6f20a287b373fc3.png', 'zhangsan', null, '2023-10-17 10:37:53', '2023-10-17 10:37:53', '山东省青岛市');

-- ----------------------------
-- Table structure for tb_purchase
-- ----------------------------
DROP TABLE IF EXISTS `tb_purchase`;
CREATE TABLE `tb_purchase` (
  `purchase_id` int NOT NULL AUTO_INCREMENT,
  `own_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `purchase_type` int NOT NULL,
  `total_price` decimal(65,2) NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单收货地址',
  `purchase_status` int NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`purchase_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_purchase
-- ----------------------------
INSERT INTO `tb_purchase` VALUES ('140', 'lisi', '1', '652.00', '192', '1', '2023-10-17 10:32:25', '2023-10-17 10:32:25');
INSERT INTO `tb_purchase` VALUES ('141', 'zhangsan', '1', '60.00', '193', '1', '2023-10-17 10:35:24', '2023-10-17 10:35:24');
INSERT INTO `tb_purchase` VALUES ('142', 'lisi', '1', '200.00', '192', '1', '2023-10-17 10:38:16', '2023-10-17 10:38:16');

-- ----------------------------
-- Table structure for tb_purchase_detail
-- ----------------------------
DROP TABLE IF EXISTS `tb_purchase_detail`;
CREATE TABLE `tb_purchase_detail` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `purchase_id` int NOT NULL,
  `order_id` int NOT NULL,
  `unin_price` decimal(65,2) NOT NULL,
  `sum_price` decimal(65,2) NOT NULL,
  `count` int NOT NULL,
  PRIMARY KEY (`detail_id`) USING BTREE,
  KEY `purchase_id` (`purchase_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_purchase_detail
-- ----------------------------
INSERT INTO `tb_purchase_detail` VALUES ('145', '140', '80', '324.00', '648.00', '2');
INSERT INTO `tb_purchase_detail` VALUES ('146', '140', '143', '2.00', '4.00', '2');
INSERT INTO `tb_purchase_detail` VALUES ('147', '141', '152', '30.00', '60.00', '2');
INSERT INTO `tb_purchase_detail` VALUES ('148', '142', '154', '100.00', '200.00', '2');

-- ----------------------------
-- Table structure for tb_question
-- ----------------------------
DROP TABLE IF EXISTS `tb_question`;
CREATE TABLE `tb_question` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `expert_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '专家',
  `questioner` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '手机号',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '作物详细信息',
  `plant_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '农作物名称',
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '问题标题',
  `question` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '问题',
  `answer` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '回答',
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_question
-- ----------------------------
INSERT INTO `tb_question` VALUES ('116', 'expert', 'zhangsan', '15266448844', '大头菜', '大头菜怎么种', '大头菜怎么种，有什么注意事项', null, '0');

-- ----------------------------
-- Table structure for tb_reserve
-- ----------------------------
DROP TABLE IF EXISTS `tb_reserve`;
CREATE TABLE `tb_reserve` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `expert_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '专家',
  `questioner` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '咨询者',
  `area` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '面积',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '土地地址',
  `plant_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '农作物名称',
  `soil_condition` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '土壤条件',
  `plant_condition` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '作物条件',
  `plant_detail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '作物详细信息',
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '作物详细信息',
  `message` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '留言',
  `answer` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '回答',
  `status` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_reserve
-- ----------------------------
INSERT INTO `tb_reserve` VALUES ('215', 'wangwu', 'zhangsan', '11111', '1111', '1111', '1111', '1111', '11111', '1111', null, null, '1');

-- ----------------------------
-- Table structure for tb_sell_purchase
-- ----------------------------
DROP TABLE IF EXISTS `tb_sell_purchase`;
CREATE TABLE `tb_sell_purchase` (
  `sell_purchase_id` int NOT NULL AUTO_INCREMENT,
  `purchase_id` int NOT NULL,
  `own_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `purchase_type` int NOT NULL,
  `unin_pricee` decimal(65,2) NOT NULL,
  `sum_price` decimal(65,2) NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '订单收货地址',
  `purchase_status` int NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`sell_purchase_id`) USING BTREE,
  KEY `purchase_id` (`purchase_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_sell_purchase
-- ----------------------------
INSERT INTO `tb_sell_purchase` VALUES ('37', '140', 'wyn3', '2', '324.00', '648.00', '192', '1', '2023-10-17 10:32:25', '2023-10-17 10:32:25', '80');
INSERT INTO `tb_sell_purchase` VALUES ('38', '140', 'wangya', '2', '2.00', '4.00', '192', '1', '2023-10-17 10:32:25', '2023-10-17 10:32:25', '143');
INSERT INTO `tb_sell_purchase` VALUES ('39', '141', 'lisi', '2', '30.00', '60.00', '193', '1', '2023-10-17 10:35:24', '2023-10-17 10:35:24', '152');
INSERT INTO `tb_sell_purchase` VALUES ('40', '142', 'zhangsan', '2', '100.00', '200.00', '192', '1', '2023-10-17 10:38:16', '2023-10-17 10:38:16', '154');

-- ----------------------------
-- Table structure for tb_shoppingcart
-- ----------------------------
DROP TABLE IF EXISTS `tb_shoppingcart`;
CREATE TABLE `tb_shoppingcart` (
  `shopping_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `count` int NOT NULL,
  `own_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`shopping_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_shoppingcart
-- ----------------------------
INSERT INTO `tb_shoppingcart` VALUES ('26', '139', '2', 'expert', '2023-10-17 10:29:41', '2023-10-17 10:29:41');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `identity_num` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '地址',
  `role` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'user' COMMENT 'user普通用户，expert专家，admin管理员',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `integral` int DEFAULT '500' COMMENT '积分500',
  `credit` int DEFAULT '5' COMMENT '信誉1，2，3，4，5',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL COMMENT '头像',
  `real_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`user_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('admin', '$2a$10$m7ZTM1YKDY8EfNUzxalWN.t.YWG55AoD8lmwxe/HoCe1npFaidS/K', '管理员', '17894286579', '370343199612012718', '山东省青岛市', 'admin', '2021-09-01 09:00:51', '2022-09-01 16:35:24', '0', '0', '2ae82e5cf7ca47c9ab516d37dccab5dd.jpg', 'admin');
INSERT INTO `tb_user` VALUES ('expert', '$2a$10$m7ZTM1YKDY8EfNUzxalWN.t.YWG55AoD8lmwxe/HoCe1npFaidS/K', '李专家', '18766661439', '370343199612016352', '山东省临沂市', 'expert', '2021-08-27 16:05:20', '2023-10-17 14:32:22', '0', '0', '1d87025dd7b741e99f5311a632ad96a7.png', '高三12');
INSERT INTO `tb_user` VALUES ('lisi', '$2a$10$m7ZTM1YKDY8EfNUzxalWN.t.YWG55AoD8lmwxe/HoCe1npFaidS/K', '李思', '15623652365', '371323199601062719', '山东省临沂市', 'user', '2022-08-19 16:39:11', '2023-10-17 10:32:59', '0', '0', '67b5e824ad4147768d8bb786d429cefc.png', '李思');
INSERT INTO `tb_user` VALUES ('wangwu', '$2a$10$m7ZTM1YKDY8EfNUzxalWN.t.YWG55AoD8lmwxe/HoCe1npFaidS/K', '王武', '13456567878', '370123200001012233', '山东省青岛市', 'expert', '2021-08-31 10:13:42', '2022-08-10 15:43:58', '0', '0', '2ae82e5cf7ca47c9ab516d37dccab5dd.jpg', '王武');
INSERT INTO `tb_user` VALUES ('zhangsan', '$2a$10$m7ZTM1YKDY8EfNUzxalWN.t.YWG55AoD8lmwxe/HoCe1npFaidS/K', '张三三', '13792499274', '370343199609176060', '山东省青岛市', 'user', '2022-08-19 16:37:10', '2023-10-17 10:39:07', '0', '0', 'bd12eba3a9a24d89845ebbdb7fbff448.jpg', '张三');

-- ----------------------------
-- Function structure for sfn_GetSimilar_Rate
-- ----------------------------
DROP FUNCTION IF EXISTS `sfn_GetSimilar_Rate`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `sfn_GetSimilar_Rate`(s1 VARCHAR(64),s2 VARCHAR(64)) RETURNS float
BEGIN
declare l1 int default 0;
declare l2 int default 0;
declare i int default 0;
declare _ss varchar(2) ;
declare j int default 0;
declare sum int default 0;
set l1=CHAR_LENGTH(s1);
set l2=CHAR_LENGTH(S2);
IF l1=0 THEN RETURN 0;
END IF;
IF l2=0 THEN RETURN 0;
END IF;
SET i=0;
set sum=0;
myloop1:LOOP
	SET i=i+1;
	IF i>l1 THEN LEAVE myloop1;
	end if;
	SET _ss=substr(s1,i,1);
	SET j=0;
	myloop2:LOOP
		set j=j+1;
		if j>l2 then 
		   LEAVE myloop2;
		end if;
		if _ss=substr(s2,j,1) then 
		  set sum=sum+1;
		end if;
	END LOOP myloop2;
END LOOP myloop1;
RETURN sum/l2;
END
;;
DELIMITER ;

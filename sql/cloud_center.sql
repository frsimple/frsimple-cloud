-- ----------------------------
-- Table structure for center_branch
-- ----------------------------
DROP TABLE IF EXISTS `center_branch`;
CREATE TABLE `center_branch`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  `parentid` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '父节点id',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `tenantid` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联机构',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '组织机构信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_branch
-- ----------------------------
INSERT INTO `center_branch` VALUES ('222', '研发部门2', '1', '2022-08-03 22:51:01', 12, '1');
INSERT INTO `center_branch` VALUES ('OR20222J8A8V7B', '产品部门', '1', '2022-09-23 11:06:33', 1, '1');
INSERT INTO `center_branch` VALUES ('OR20227PX7EPT3', '研发部1', 'T2022E5OTSMLK', '2022-08-04 12:41:15', 1, 'T2022E5OTSMLK');
INSERT INTO `center_branch` VALUES ('OR202293XIOTWN', '测试1', 'OR20227PX7EPT3', '2022-08-04 12:41:29', 1, 'T2022E5OTSMLK');
INSERT INTO `center_branch` VALUES ('OR2022CP2JNFYW', '测试部', '1', '2022-08-04 12:51:50', 2, '1');
INSERT INTO `center_branch` VALUES ('OR2022V8MZZF6O', '11', '222', '2022-09-23 11:07:11', 12, '1');

-- ----------------------------
-- Table structure for center_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `center_dictionary`;
CREATE TABLE `center_dictionary`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键ID',
  `label` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '字典中文',
  `value` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '字典值',
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '字典编号',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '字典信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_dictionary
-- ----------------------------
INSERT INTO `center_dictionary` VALUES ('1', '是否启用', '#', 'SP_ISUSE', '2022-06-15 22:29:54');
INSERT INTO `center_dictionary` VALUES ('2', '是', '1', 'SP_ISUSE', '2022-06-15 22:29:57');
INSERT INTO `center_dictionary` VALUES ('3', '否', '0', 'SP_ISUSE', '2022-06-15 22:30:00');
INSERT INTO `center_dictionary` VALUES ('D20220616190625529UBU3I', '支付方式', '#', 'SP_PAYTYPE', '2022-06-16 19:06:26');
INSERT INTO `center_dictionary` VALUES ('D20220616214320068AXIY7', 'oatuh授权类型', '#', 'SP_AUTHTYPE', '2022-06-16 21:43:20');
INSERT INTO `center_dictionary` VALUES ('D202206171104054341I9GM', '客户端模式', 'client_credentials', 'SP_AUTHTYPE', '2022-06-17 11:04:05');
INSERT INTO `center_dictionary` VALUES ('D20220617110417884YQZ6A', '密码模式', 'password', 'SP_AUTHTYPE', '2022-06-17 11:04:18');
INSERT INTO `center_dictionary` VALUES ('D20220617110417884YQZ6B', '第三方模式', 'third_code', 'SP_AUTHTYPE', '2022-06-17 11:04:18');
INSERT INTO `center_dictionary` VALUES ('D2022061711042926690TE6', '授权码模式', 'authorization_code', 'SP_AUTHTYPE', '2022-06-17 11:04:29');
INSERT INTO `center_dictionary` VALUES ('D20220617110442235FZ9GF', '简化模式', 'implicit', 'SP_AUTHTYPE', '2022-06-17 11:04:42');
INSERT INTO `center_dictionary` VALUES ('D2022061711050113841874', '刷新令牌', 'refresh_token', 'SP_AUTHTYPE', '2022-06-17 11:05:01');
INSERT INTO `center_dictionary` VALUES ('D20220617110542850A6J57', '短信验证模式', 'sms_code', 'SP_AUTHTYPE', '2022-06-17 11:05:43');
INSERT INTO `center_dictionary` VALUES ('D20220618101614096H3HVX', '用户状态', '#', 'SP_USERSTATUS', '2022-06-18 10:16:14');
INSERT INTO `center_dictionary` VALUES ('D20220618101746016XNLKZ', '正常', '0', 'SP_USERSTATUS', '2022-06-18 10:17:46');
INSERT INTO `center_dictionary` VALUES ('D20220618101754375AICCV', '已锁定', '1', 'SP_USERSTATUS', '2022-06-18 10:17:54');

-- ----------------------------
-- Table structure for center_email
-- ----------------------------
DROP TABLE IF EXISTS `center_email`;
CREATE TABLE `center_email`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键id',
  `host` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '服务地址',
  `port` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '端口号',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '授权密钥',
  `sitename` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '签名',
  `isssl` int NULL DEFAULT NULL COMMENT '是否开启ssl',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '邮箱配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_email
-- ----------------------------
INSERT INTO `center_email` VALUES ('EM20228S8X6', 'smtp.163.com', '994', 'frsimple@163.com', 'YZTOJUCSCVHQKDAV', 'simple', 1);

-- ----------------------------
-- Table structure for center_logs
-- ----------------------------
DROP TABLE IF EXISTS `center_logs`;
CREATE TABLE `center_logs`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `servicename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '接口名称',
  `recource` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '服务名',
  `ip` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '请求ip地址',
  `path` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '接口路径',
  `method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '请求方式',
  `useragent` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '代理对象',
  `params` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '请求用户登录名',
  `createtime` datetime NULL DEFAULT NULL COMMENT '请求时间',
  `time` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '请求时长（ms）',
  `status` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '请求状态',
  `error` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '错误原因',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '接口请求日志表' ROW_FORMAT = DYNAMIC;
 
-- ----------------------------
-- Table structure for center_menu
-- ----------------------------
DROP TABLE IF EXISTS `center_menu`;
CREATE TABLE `center_menu`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单/按钮名称',
  `type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '菜单类型',
  `authcode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限编码',
  `path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '菜单路由地址',
  `parentid` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '父节点ID',
  `component` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '状态',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  `icon` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '图标',
  `meta` json NULL COMMENT '路由头设置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '菜单信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_menu
-- ----------------------------
INSERT INTO `center_menu` VALUES ('1', '查询', 'b', 'center:menu:query', '', '4', '', 1, '0', '2022-06-06 15:58:10', '2022-06-12 15:37:22', NULL, NULL);
INSERT INTO `center_menu` VALUES ('2', '数据概览', 'c', '', '/main', '999999', 'pages/dashboard/base/index', 1, '0', '2022-06-06 15:58:13', '2022-09-23 11:05:34', 'barcode', '{\"icon\": \"app\", \"title\": \"数据概览\", \"single\": true}');
INSERT INTO `center_menu` VALUES ('3', '系统管理', 'c', '', '/system', '999999', 'layout', 999, '0', '2022-06-06 15:58:13', '2022-06-26 11:04:32', 'barcode', '{\"icon\": \"setting\", \"title\": \"系统管理\", \"single\": false}');
INSERT INTO `center_menu` VALUES ('4', '菜单管理', 'c', '', 'menu', '3', 'pages/system/menu/index', 1, '0', '2022-06-06 15:58:13', '2022-06-06 15:58:19', 'barcode', '{\"icon\": \"root-list\", \"title\": \"菜单管理\"}');
INSERT INTO `center_menu` VALUES ('5', '角色管理', 'c', '', 'role', '3', 'pages/system/role/index', 2, '0', '2022-06-06 15:58:13', '2022-06-06 15:58:19', 'barcode', '{\"icon\": \"usergroup\", \"title\": \"角色管理\"}');
INSERT INTO `center_menu` VALUES ('6', '字典管理', 'c', '', 'dic', '3', 'pages/system/dic/index', 3, '0', '2022-06-06 15:58:13', '2022-06-15 21:48:51', 'barcode', '{\"icon\": \"books\", \"title\": \"字典管理\"}');
INSERT INTO `center_menu` VALUES ('7', '租户管理', 'c', '', 'tenant', '3', 'pages/system/tenant/index', 0, '0', '2022-06-06 15:58:13', '2022-06-17 18:17:10', 'barcode', '{\"icon\": \"home\", \"title\": \"租户管理\"}');
INSERT INTO `center_menu` VALUES ('8', '用户管理', 'c', '', 'user', '3', 'pages/system/user/index', 1, '0', '2022-06-06 15:58:13', '2022-08-03 18:25:52', 'barcode', '{\"icon\": \"user\", \"title\": \"用户管理\", \"single\": false}');
INSERT INTO `center_menu` VALUES ('BTN20220612152538483J36DD', '新增', 'b', 'center:menu:add', NULL, '4', NULL, NULL, '0', '2022-06-12 15:25:38', '2022-06-12 15:25:38', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220612152550459C55UT', '修改', 'b', 'center:menu:edit', NULL, '4', NULL, NULL, '0', '2022-06-12 15:25:50', '2022-06-12 19:29:23', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220612152604812LX3X1', '删除', 'b', 'center:menu:del', NULL, '4', NULL, NULL, '0', '2022-06-12 15:26:05', '2022-06-12 15:26:05', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624190031433TE3TK', '新增字典', 'b', 'system:dict:add', NULL, '6', NULL, NULL, '0', '2022-06-24 19:00:31', '2022-06-24 19:00:31', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624190050686OBSW3', '修改字典', 'b', 'system:dict:edit', NULL, '6', NULL, NULL, '0', '2022-06-24 19:00:51', '2022-06-24 19:00:51', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624190109272L2TGP', '删除字典项', 'b', 'system:dict:del', NULL, '6', NULL, NULL, '0', '2022-06-24 19:01:09', '2022-06-24 19:01:09', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624190211693MIG7U', '查询字典', 'b', 'system:dict:query', NULL, '6', NULL, NULL, '0', '2022-06-24 19:02:12', '2022-06-24 19:02:12', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624193556724CKSBR', '新增用户', 'b', 'system:user:add', NULL, '8', NULL, NULL, '0', '2022-06-24 19:35:57', '2022-06-24 19:35:57', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624193608163XOCV6', '修改用户', 'b', 'system:user:edit', NULL, '8', NULL, NULL, '0', '2022-06-24 19:36:08', '2022-06-24 19:36:08', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN202206241936181131YR6B', '删除用户', 'b', 'system:user:del', NULL, '8', NULL, NULL, '0', '2022-06-24 19:36:18', '2022-06-24 19:36:18', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624193628120EW0DD', '查询用户', 'b', 'system:user:query', NULL, '8', NULL, NULL, '0', '2022-06-24 19:36:28', '2022-06-24 19:36:28', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624193938973JMBB7', '查询机构', 'b', 'system:tenant:query', NULL, '7', NULL, NULL, '0', '2022-06-24 19:39:39', '2022-06-24 19:39:39', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN202206241939506085IE7O', '新增机构', 'b', 'system:tenant:add', NULL, '7', NULL, NULL, '0', '2022-06-24 19:39:51', '2022-06-24 19:39:51', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624194002776R96TI', '修改机构', 'b', 'system:tenant:edit', NULL, '7', NULL, NULL, '0', '2022-06-24 19:40:03', '2022-06-24 19:40:03', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624194010155TW62M', '删除机构', 'b', 'system:tenant:del', NULL, '7', NULL, NULL, '0', '2022-06-24 19:40:10', '2022-06-24 19:40:10', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624194038782F1L34', '新增角色', 'b', 'system:role:add', NULL, '5', NULL, NULL, '0', '2022-06-24 19:40:39', '2022-06-24 19:40:39', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN2022062419404569518A7R', '查询角色', 'b', 'system:role:query', NULL, '5', NULL, NULL, '0', '2022-06-24 19:40:46', '2022-06-24 19:40:46', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624194052770KZYIG', '修改角色', 'b', 'system:role:edit', NULL, '5', NULL, NULL, '0', '2022-06-24 19:40:53', '2022-06-24 19:40:53', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624194100377MJ83B', '删除角色', 'b', 'system:role:del', NULL, '5', NULL, NULL, '0', '2022-06-24 19:41:00', '2022-06-24 19:41:00', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624194123282RCKRE', '新增应用', 'b', 'system:oauth:add', NULL, 'MENU20220612154748064K2C40', NULL, NULL, '0', '2022-06-24 19:41:23', '2022-06-24 19:41:23', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN202206241941334727EP50', '修改应用', 'b', 'system:oauth:edit', NULL, 'MENU20220612154748064K2C40', NULL, NULL, '0', '2022-06-24 19:41:33', '2022-06-24 19:41:33', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN202206241941429035MXHR', '删除应用', 'b', 'system:oauth:del', NULL, 'MENU20220612154748064K2C40', NULL, NULL, '0', '2022-06-24 19:41:43', '2022-06-24 19:41:43', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624194152812WC5Q0', '查询应用', 'b', 'system:oauth:query', NULL, 'MENU20220612154748064K2C40', NULL, NULL, '0', '2022-06-24 19:41:53', '2022-06-24 19:41:53', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624194216415QA7LT', '查询', 'b', 'system:online:query', NULL, 'MENU20220612154353674IOIVI', NULL, NULL, '0', '2022-06-24 19:42:16', '2022-06-24 19:42:16', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220624194231107IF0U0', '踢下线', 'b', 'system:online:del', NULL, 'MENU20220612154353674IOIVI', NULL, NULL, '0', '2022-06-24 19:42:31', '2022-06-24 19:42:31', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN2022080412135175925582', '新增', 'b', 'system:organ:add', NULL, 'MENU20220803212726121GLSZ5', NULL, NULL, '0', '2022-08-04 12:13:52', '2022-08-04 12:13:52', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220804121357865WA8Z7', '修改', 'b', 'system:organ:edit', NULL, 'MENU20220803212726121GLSZ5', NULL, NULL, '0', '2022-08-04 12:13:58', '2022-08-04 12:13:58', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220804121408220HTDUS', '删除', 'b', 'system:organ:del', NULL, 'MENU20220803212726121GLSZ5', NULL, NULL, '0', '2022-08-04 12:14:08', '2022-08-04 12:14:08', NULL, NULL);
INSERT INTO `center_menu` VALUES ('BTN20220804121416757955LJ', '查询', 'b', 'system:organ:query', NULL, 'MENU20220803212726121GLSZ5', NULL, NULL, '0', '2022-08-04 12:14:17', '2022-08-04 12:14:17', NULL, NULL);
INSERT INTO `center_menu` VALUES ('MENU20220612154353674IOIVI', '在线用户', 'c', NULL, 'online', '3', 'pages/system/online/index', 100, '0', '2022-06-12 15:43:54', '2022-06-17 18:16:22', NULL, '{\"icon\": \"laptop\", \"title\": \"在线用户\"}');
INSERT INTO `center_menu` VALUES ('MENU20220612154748064K2C40', '应用管理', 'c', NULL, 'oauth', '3', 'pages/system/oauth/index', 99, '0', '2022-06-12 15:47:48', '2022-06-17 18:18:21', NULL, '{\"icon\": \"lock-on\", \"title\": \"应用管理\"}');
INSERT INTO `center_menu` VALUES ('MENU20220614192715011Q8MNB', '接口日志', 'c', NULL, 'logs', '3', 'pages/system/logs/index', 101, '0', '2022-06-14 19:27:15', '2022-06-14 21:26:57', NULL, '{\"icon\": \"root-list\", \"title\": \"接口日志\"}');
INSERT INTO `center_menu` VALUES ('MENU20220619172225564RGCC4', '文件存储', 'c', NULL, 'oss', '3', 'pages/system/oss/index', 102, '0', '2022-06-19 17:22:26', '2022-06-19 17:22:26', NULL, '{\"icon\": \"folder\", \"title\": \"文件存储\"}');
INSERT INTO `center_menu` VALUES ('MENU20220619172501019COPJ8', '短信配置', 'c', NULL, 'sms', '3', 'pages/system/sms/index', 103, '0', '2022-06-19 17:25:01', '2022-06-19 17:27:17', NULL, '{\"icon\": \"mobile\", \"title\": \"短信配置\"}');
INSERT INTO `center_menu` VALUES ('MENU20220619172616380RCPPT', '邮件配置', 'c', NULL, 'email', '3', 'pages/system/email/index', 104, '0', '2022-06-19 17:26:16', '2022-06-19 17:26:16', NULL, '{\"icon\": \"mail\", \"title\": \"邮件配置\"}');
INSERT INTO `center_menu` VALUES ('MENU20220627112455181220I1', '分布式任务调度', 'c', NULL, 'http://101.43.50.12:1100/xxl-job-admin', '3', 'link', 107, '0', '2022-06-27 11:24:55', '2022-06-27 11:31:11', NULL, '{\"icon\": \"server\", \"title\": \"分布式任务调度\", \"single\": false}');
INSERT INTO `center_menu` VALUES ('MENU20220627112455181220IT', 'nacos服务', 'c', NULL, 'http://101.43.50.12:8848/nacos', '3', 'link', 106, '0', '2022-06-27 11:24:55', '2022-06-27 11:31:11', NULL, '{\"icon\": \"server\", \"title\": \"nacos服务\", \"single\": false}');
INSERT INTO `center_menu` VALUES ('MENU20220627112455181220IU', '连接池', 'c', NULL, 'http://101.43.50.12:2000/druid/login.html', '3', 'link', 105, '0', '2022-06-27 11:24:55', '2022-06-27 11:31:11', NULL, '{\"icon\": \"server\", \"title\": \"连接池\", \"single\": false}');
INSERT INTO `center_menu` VALUES ('MENU20220730174817566HRBRX', '代码生成', 'c', NULL, 'code', '3', 'pages/system/code/index', 4, '0', '2022-07-30 17:48:18', '2022-07-30 17:48:18', NULL, '{\"icon\": \"hourglass\", \"title\": \"代码生成\", \"single\": false}');
INSERT INTO `center_menu` VALUES ('MENU20220803212726121GLSZ5', '组织机构', 'c', NULL, 'organ', '3', 'pages/system/organ/index', 0, '0', '2022-08-03 21:27:26', '2022-08-03 22:15:31', NULL, '{\"icon\": \"fork\", \"title\": \"组织机构\", \"single\": false}');

-- ----------------------------
-- Table structure for center_oss
-- ----------------------------
DROP TABLE IF EXISTS `center_oss`;
CREATE TABLE `center_oss`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键ID',
  `endpoint` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '上传地址',
  `workspace` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '空间名',
  `accesskeyid` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '授权id',
  `accesskeysecret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '授权密钥',
  `appid` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'appid',
  `region` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '地区',
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '存储类型',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '文件存储配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_oss
-- ----------------------------
INSERT INTO `center_oss` VALUES ('OSS202246ILQ', 'oss-cn-zhangjiakou.aliyuncs.com', 'pengpengyu-test', '', '', NULL, NULL, 'ALIOSS', '2022-06-20 10:39:12', '2022-06-22 13:21:37');
INSERT INTO `center_oss` VALUES ('OSS2022A0M68', 'https://simple-1303873963.cos.ap-shanghai.myqcloud.com', 'simple-1303873963', '', '', '1303873963', 'ap-shanghai', 'TENCENTCOS', '2022-06-20 12:35:38', '2022-06-20 13:02:18');
INSERT INTO `center_oss` VALUES ('OSS2022A34D2', 'http://101.43.50.12:19000', 'simple', '', '', NULL, NULL, 'MINIO', '2022-06-20 12:38:13', '2022-06-20 21:59:14');

-- ----------------------------
-- Table structure for center_platform
-- ----------------------------
DROP TABLE IF EXISTS `center_platform`;
CREATE TABLE `center_platform`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键ID',
  `openid` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '平台用户id',
  `uniopenid` varchar(0) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '平台用户唯一id',
  `avatar` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `sex` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `user` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联用户id',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '平台类型',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` datetime NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '第三方平台用户信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_platform
-- ----------------------------

-- ----------------------------
-- Table structure for center_role
-- ----------------------------
DROP TABLE IF EXISTS `center_role`;
CREATE TABLE `center_role`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色ID',
  `name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '角色说明',
  `status` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '状态',
  `code` varchar(60) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '角色编号',
  `type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '角色类型；01:公共的 02:指定机构',
  `tenants` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联机构',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `u_role_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_role
-- ----------------------------
INSERT INTO `center_role` VALUES ('1', '管理员', '管理员权限', '0', 'ROLE_ADMIN', '0', NULL, '2022-06-13 21:54:03');
INSERT INTO `center_role` VALUES ('ROLE202206736QBRVH', '普通用户', '普通用户', '0', NULL, '01', NULL, '2022-06-14 19:11:53');

-- ----------------------------
-- Table structure for center_rolemenu
-- ----------------------------
DROP TABLE IF EXISTS `center_rolemenu`;
CREATE TABLE `center_rolemenu`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `role` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色id',
  `menu` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '权限信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_rolemenu
-- ----------------------------
INSERT INTO `center_rolemenu` VALUES ('RM2023011914025529386G7I', 'ROLE202206736QBRVH', '2');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140255304LE2C1', 'ROLE202206736QBRVH', 'BTN202206241939506085IE7O');
INSERT INTO `center_rolemenu` VALUES ('RM202301191402553130FWZ2', 'ROLE202206736QBRVH', 'BTN20220624194002776R96TI');
INSERT INTO `center_rolemenu` VALUES ('RM202301191402553228R1T6', 'ROLE202206736QBRVH', 'BTN20220624193938973JMBB7');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140255330CB61B', 'ROLE202206736QBRVH', 'BTN20220624194010155TW62M');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140255339PA42B', 'ROLE202206736QBRVH', 'BTN20220804121408220HTDUS');
INSERT INTO `center_rolemenu` VALUES ('RM202301191402553488ZOZM', 'ROLE202206736QBRVH', 'BTN2022080412135175925582');
INSERT INTO `center_rolemenu` VALUES ('RM202301191402553574AK4M', 'ROLE202206736QBRVH', 'BTN20220612152550459C55UT');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140255365VHGAM', 'ROLE202206736QBRVH', 'BTN20220612152604812LX3X1');
INSERT INTO `center_rolemenu` VALUES ('RM202301191402553747YV65', 'ROLE202206736QBRVH', 'BTN20220612152538483J36DD');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140255383WPI8E', 'ROLE202206736QBRVH', '1');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140255392QI9RC', 'ROLE202206736QBRVH', 'BTN20220624190211693MIG7U');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140255400L2ND4', 'ROLE202206736QBRVH', 'BTN20220624190031433TE3TK');
INSERT INTO `center_rolemenu` VALUES ('RM202301191402554090P41H', 'ROLE202206736QBRVH', '7');
INSERT INTO `center_rolemenu` VALUES ('RM202301191402554186JAG2', 'ROLE202206736QBRVH', '3');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140255427WZBKV', 'ROLE202206736QBRVH', 'MENU20220803212726121GLSZ5');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140255436FQ4TA', 'ROLE202206736QBRVH', '4');
INSERT INTO `center_rolemenu` VALUES ('RM202301191402554465U0VN', 'ROLE202206736QBRVH', '6');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353596T557F', '1', '2');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403536056EBC1', '1', 'BTN202206241939506085IE7O');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353614FTVVI', '1', 'BTN20220624194002776R96TI');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353622ETDRF', '1', 'BTN20220624193938973JMBB7');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353631L4JDH', '1', 'BTN20220624194010155TW62M');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403536405PZEL', '1', 'BTN20220804121357865WA8Z7');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353649XTH91', '1', 'BTN20220804121416757955LJ');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403536575VGLK', '1', 'BTN20220804121408220HTDUS');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403536669I4HB', '1', 'BTN2022080412135175925582');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353675CG5DT', '1', 'BTN20220612152550459C55UT');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353684ACP99', '1', 'BTN20220612152604812LX3X1');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353693Z748O', '1', 'BTN20220612152538483J36DD');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353701SHLY0', '1', '1');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403537109GPQF', '1', 'BTN20220624193628120EW0DD');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353719T5RIH', '1', 'BTN20220624193608163XOCV6');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403537289V74G', '1', 'BTN202206241936181131YR6B');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353736QTASN', '1', 'BTN20220624193556724CKSBR');
INSERT INTO `center_rolemenu` VALUES ('RM2023011914035374518YGK', '1', 'BTN2022062419404569518A7R');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353754G980P', '1', 'BTN20220624194052770KZYIG');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353763GDHJT', '1', 'BTN20220624194038782F1L34');
INSERT INTO `center_rolemenu` VALUES ('RM2023011914035377191ZI6', '1', 'BTN20220624194100377MJ83B');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353780F1KVG', '1', 'BTN20220624190211693MIG7U');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353789KN336', '1', 'BTN20220624190031433TE3TK');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353798Z2VN8', '1', 'BTN20220624190109272L2TGP');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403538064Z5BR', '1', 'BTN20220624190050686OBSW3');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353815OEH0X', '1', 'MENU20220730174817566HRBRX');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353824FQKFO', '1', 'BTN20220624194123282RCKRE');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353832G0S6E', '1', 'BTN202206241941429035MXHR');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353841IB0QP', '1', 'BTN202206241941334727EP50');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353850TNMQ9', '1', 'BTN20220624194152812WC5Q0');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353859KEHZE', '1', 'BTN20220624194231107IF0U0');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403538677POHQ', '1', 'BTN20220624194216415QA7LT');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353876RJZN5', '1', 'MENU20220614192715011Q8MNB');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353885I7Z2M', '1', 'MENU20220619172225564RGCC4');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353894PXIWN', '1', 'MENU20220619172501019COPJ8');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353903EQSHL', '1', 'MENU20220619172616380RCPPT');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353912C17TA', '1', 'MENU20220627112455181220IU');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353920Z5LD1', '1', 'MENU20220627112455181220IT');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403539290RD60', '1', 'MENU20220627112455181220I1');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353938RLETN', '1', '7');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353947ISVJY', '1', '3');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403539558NMVB', '1', 'MENU20220803212726121GLSZ5');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353964V3WG4', '1', '4');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353973CXBT4', '1', '8');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353982VHA53', '1', '5');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353990RQZC5', '1', '6');
INSERT INTO `center_rolemenu` VALUES ('RM20230119140353999LC2DB', '1', 'MENU20220612154748064K2C40');
INSERT INTO `center_rolemenu` VALUES ('RM202301191403540088DHBA', '1', 'MENU20220612154353674IOIVI');

-- ----------------------------
-- Table structure for center_roleuser
-- ----------------------------
DROP TABLE IF EXISTS `center_roleuser`;
CREATE TABLE `center_roleuser`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键id',
  `user` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '关联用户',
  `role` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '关联角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '角色用户关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_roleuser
-- ----------------------------
INSERT INTO `center_roleuser` VALUES ('RU20220804140422784X1UC8', 'U2022W2V1BYS3', 'ROLE202206736QBRVH');
INSERT INTO `center_roleuser` VALUES ('RU20221102160710878P197J', '1', '1');

-- ----------------------------
-- Table structure for center_sms
-- ----------------------------
DROP TABLE IF EXISTS `center_sms`;
CREATE TABLE `center_sms`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '短信配置主键',
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '短信类型',
  `endpoint` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '地域域名',
  `region` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '地域',
  `appid` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'appid',
  `secretid` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `secretkey` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `sign` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '默认签名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '短信配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_sms
-- ----------------------------
INSERT INTO `center_sms` VALUES ('SMS2022D2GPP', 'TENCENT', 'sms.tencentcloudapi.com', 'ap-guangzhou', '1400467568', '', '', '');

-- ----------------------------
-- Table structure for center_tenant
-- ----------------------------
DROP TABLE IF EXISTS `center_tenant`;
CREATE TABLE `center_tenant`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '机构id',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '机构名称',
  `phone` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '机构地址',
  `status` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '状态',
  `updatedate` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `createdate` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '机构信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_tenant
-- ----------------------------
INSERT INTO `center_tenant` VALUES ('1', 'FrSimple', '18777776666', '18777776666@163.com', '上海市', '0', '2022-11-26 13:48:04', '2022-06-06 15:55:37');
INSERT INTO `center_tenant` VALUES ('T2022E5OTSMLK', '测试机构02', '18777776666', '18777776666@163.com', '上海市浦东新区', NULL, '2022-11-04 11:51:38', '2022-06-17 18:07:13');

-- ----------------------------
-- Table structure for center_user
-- ----------------------------
DROP TABLE IF EXISTS `center_user`;
CREATE TABLE `center_user`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户唯一id',
  `username` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '登录名',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `phone` varchar(18) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `status` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户状态',
  `avatar` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '头像',
  `createdate` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `updatedate` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改人',
  `logindate` datetime NULL DEFAULT NULL COMMENT '最后一次登录时间',
  `tenant` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联主机构',
  `error` int NULL DEFAULT NULL COMMENT '错误次数',
  `organ` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联组织',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '系统用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_user
-- ----------------------------
INSERT INTO `center_user` VALUES ('1', 'system', '$2a$10$Pkr/v4vIqjVgCsss8yWwluWyJo8J7J5zYqMhZEKkA9fXXfmT9O8F6', '超级管理员', '16628515672', 'frsimple@163.com', '0', 'https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/public/2022-06-26/1/电子名片.png', '2022-06-06 15:54:19', '2023-04-03 13:55:43', '2023-04-03 13:55:43', '1', 0, '1');
INSERT INTO `center_user` VALUES ('U2022W2V1BYS3', 'frsimple', '$2a$10$jWTVZK./VZbKrdZHjsRdpeJY2XnCd7pGlkYA2tvUzeYHRTxaQpkNe', 'frsimple', '18777776666', '18777776666@163.com', '0', NULL, '2022-06-18 09:19:16', '2023-02-24 09:27:46', '2022-06-18 14:32:49', 'T2022E5OTSMLK', 1, '222');

-- ----------------------------
-- Table structure for center_user_third
-- ----------------------------
DROP TABLE IF EXISTS `center_user_third`;
CREATE TABLE `center_user_third`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键ID',
  `userid` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联用户id',
  `openid` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '第三方用户id',
  `uniopenid` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '第三方用户唯一id',
  `type` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '第三方类型',
  `createtime` datetime NULL DEFAULT NULL COMMENT '绑定时间',
  `status` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '绑定状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户第三方绑定信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_user_third
-- ----------------------------
INSERT INTO `center_user_third` VALUES ('1', '1', '1', '1', '01', '2022-07-24 15:36:00', '0');

-- ----------------------------
-- Table structure for center_usertenant
-- ----------------------------
DROP TABLE IF EXISTS `center_usertenant`;
CREATE TABLE `center_usertenant`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键id',
  `tenant` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '机构id',
  `user` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '用户机构关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_usertenant
-- ----------------------------
INSERT INTO `center_usertenant` VALUES ('UT2022BVJRDP6C', '1', '1');
INSERT INTO `center_usertenant` VALUES ('UT2022T859RXQ8', 'T2022E5OTSMLK', 'U2022W2V1BYS3');

-- ----------------------------
-- Table structure for center_wqrcode
-- ----------------------------
DROP TABLE IF EXISTS `center_wqrcode`;
CREATE TABLE `center_wqrcode`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '主键ID',
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '授权码',
  `createtime` datetime NULL DEFAULT NULL COMMENT '生成时间',
  `status` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '状态',
  `openid` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT 'openid',
  `opt` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作',
  `qrtime` datetime NULL DEFAULT NULL COMMENT '扫码时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '微信小程序二维码临时表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of center_wqrcode
-- ----------------------------
INSERT INTO `center_wqrcode` VALUES ('ame5wltsi6mn', 'ame5wltsi6mn', '2022-07-23 17:11:59', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('zgr4fi3vg7uh', 'zgr4fi3vg7uh', '2022-07-23 17:17:39', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('lvastp6ded7y', 'lvastp6ded7y', '2022-07-23 18:11:53', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('jqx0gklcoehm', 'jqx0gklcoehm', '2022-07-23 18:13:20', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('tgqlvt20rn77', 'tgqlvt20rn77', '2022-07-23 18:15:03', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('2g8m0i7emb6p', '2g8m0i7emb6p', '2022-07-23 18:15:20', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('uuj3dpj5ck6d', 'uuj3dpj5ck6d', '2022-07-23 18:26:42', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('amuqmpcj6bqg', 'amuqmpcj6bqg', '2022-07-23 18:26:55', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('q2r8pnf0m0tu', 'q2r8pnf0m0tu', '2022-07-23 18:29:06', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('agkvxaxvp6pk', 'agkvxaxvp6pk', '2022-07-23 18:29:18', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('3mscnv2tn7rp', '3mscnv2tn7rp', '2022-07-23 18:33:12', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('98fcyyn80c7l', '98fcyyn80c7l', '2022-07-23 18:33:16', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('iksssllxoej3', 'iksssllxoej3', '2022-07-23 18:34:42', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('1c87e3f5b08de', '1c87e3f5b08de', '2022-07-24 10:13:07', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('828efa0a01d', '828efa0a01d', '2022-07-24 10:13:07', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('c2526bd413248', 'c2526bd413248', '2022-07-24 10:13:19', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('c2526bd413248', 'c2526bd413248', '2022-07-24 10:14:11', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('c2526bd413248', 'c2526bd413248', '2022-07-24 10:14:16', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('c2526bd413248', 'c2526bd413248', '2022-07-24 10:14:46', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('b58b67317340a', 'b58b67317340a', '2022-07-24 10:19:04', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f612766b94382', 'f612766b94382', '2022-07-24 10:19:05', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('606501b025673', '606501b025673', '2022-07-24 10:22:00', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('d3c8f6385456a', 'd3c8f6385456a', '2022-07-24 10:22:09', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('ddbe94ac98dfd', 'ddbe94ac98dfd', '2022-07-24 10:26:45', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('7e3bd122c5893', '7e3bd122c5893', '2022-07-24 10:27:26', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('467ec0d575f11', '467ec0d575f11', '2022-07-24 10:28:30', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a973c7cd848c9', 'a973c7cd848c9', '2022-07-24 10:37:30', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('063a2103448d9', '063a2103448d9', '2022-07-24 10:37:41', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('cbebdd78fab6e', 'cbebdd78fab6e', '2022-07-24 10:39:26', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('be7a85b8f047a', 'be7a85b8f047a', '2022-07-24 10:43:40', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('154890994da19', '154890994da19', '2022-07-24 10:44:25', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('8b8c7a5b36bab', '8b8c7a5b36bab', '2022-07-24 10:44:34', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('6b3f07ebf744d', '6b3f07ebf744d', '2022-07-24 10:44:46', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('8e0ceedd7fc65', '8e0ceedd7fc65', '2022-07-24 10:45:03', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('6a2edc3553f78', '6a2edc3553f78', '2022-07-24 10:45:11', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a257d2682a66e', 'a257d2682a66e', '2022-07-24 10:46:14', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('bacc0ae56ac15', 'bacc0ae56ac15', '2022-07-24 10:54:51', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('9f29ef9751e5c', '9f29ef9751e5c', '2022-07-24 10:56:15', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('e448b72a58bb8', 'e448b72a58bb8', '2022-07-24 10:56:22', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('7f0fac1a44e7b', '7f0fac1a44e7b', '2022-07-24 10:58:32', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('1eb69a7a8ddd6', '1eb69a7a8ddd6', '2022-07-24 11:02:40', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('4f0a1113ea728', '4f0a1113ea728', '2022-07-24 11:29:20', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('ec0569ae22b9d', 'ec0569ae22b9d', '2022-07-24 11:29:40', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('260fffb6309a9', '260fffb6309a9', '2022-07-24 11:29:42', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('8c50b530b1ebe', '8c50b530b1ebe', '2022-07-24 11:31:41', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f5527ed8d0ffc', 'f5527ed8d0ffc', '2022-07-24 11:31:45', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('85817dbe58186', '85817dbe58186', '2022-07-24 11:31:47', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('43ba8ce4d67db', '43ba8ce4d67db', '2022-07-24 11:33:31', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('41a6967b7f18b', '41a6967b7f18b', '2022-07-24 11:38:47', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('65b61c58aaea8', '65b61c58aaea8', '2022-07-24 11:39:07', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('d508b4e33014e', 'd508b4e33014e', '2022-07-24 11:40:28', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('d508b4e33014e', 'd508b4e33014e', '2022-07-24 11:43:28', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('d508b4e33014e', 'd508b4e33014e', '2022-07-24 11:43:49', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f5324bc2380b6', 'f5324bc2380b6', '2022-07-24 11:45:43', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('fa177fab6994f', 'fa177fab6994f', '2022-07-24 11:52:05', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('97fd593d049f6', '97fd593d049f6', '2022-07-24 11:52:58', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('e33deead32338', 'e33deead32338', '2022-07-24 11:54:20', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f8071d755ed1', 'f8071d755ed1', '2022-07-24 11:54:22', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('4e03d239f380a', '4e03d239f380a', '2022-07-24 11:54:43', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('768dfdb703c4c', '768dfdb703c4c', '2022-07-24 11:54:47', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('6db4ca0fed5c2', '6db4ca0fed5c2', '2022-07-24 11:55:51', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('0579532a9ffe7', '0579532a9ffe7', '2022-07-24 11:56:34', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('6b9586cf93a77', '6b9586cf93a77', '2022-07-24 11:58:17', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('73578d53ca2a5', '73578d53ca2a5', '2022-07-24 11:58:20', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('73578d53ca2a5', '73578d53ca2a5', '2022-07-24 11:58:24', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('de1b143a5a57a', 'de1b143a5a57a', '2022-07-24 11:58:49', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a35aac95203f5', 'a35aac95203f5', '2022-07-24 11:58:51', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a35aac95203f5', 'a35aac95203f5', '2022-07-24 11:58:53', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('48c4ef4a1586', '48c4ef4a1586', '2022-07-24 11:59:13', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('936d9aefa55e7', '936d9aefa55e7', '2022-07-24 11:59:20', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('936d9aefa55e7', '936d9aefa55e7', '2022-07-24 11:59:23', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('42c4086f166f2', '42c4086f166f2', '2022-07-24 12:09:57', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('e810cbbf04e07', 'e810cbbf04e07', '2022-07-24 12:14:04', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('8366244b34bf3', '8366244b34bf3', '2022-07-24 12:14:25', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f3eeb4973db78', 'f3eeb4973db78', '2022-07-24 12:15:23', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('08aa509c4d1f8', '08aa509c4d1f8', '2022-07-24 12:16:34', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('0cfaaf7bd3819', '0cfaaf7bd3819', '2022-07-24 12:17:45', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('5911f56f10aa', '5911f56f10aa', '2022-07-24 12:17:53', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f030421a6b2e5', 'f030421a6b2e5', '2022-07-24 12:18:47', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('e6354ffda8c3a', 'e6354ffda8c3a', '2022-07-24 12:21:31', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('d0e17fd93f5b', 'd0e17fd93f5b', '2022-07-24 12:21:42', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('4c9e66d71e5', '4c9e66d71e5', '2022-07-24 12:21:45', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('e56306ea5a092', 'e56306ea5a092', '2022-07-24 12:21:56', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('2f37aed08b1b7', '2f37aed08b1b7', '2022-07-24 12:22:21', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('571503bebbe7d', '571503bebbe7d', '2022-07-24 12:22:25', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a1f17f976cb12', 'a1f17f976cb12', '2022-07-24 12:27:45', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('e7a55b881013f', 'e7a55b881013f', '2022-07-24 12:28:45', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('12', '12', '2022-07-24 12:29:16', '-1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('76ad7b1e5f49e', '76ad7b1e5f49e', '2022-07-24 12:35:56', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('1a07682f767cc', '1a07682f767cc', '2022-07-24 12:40:19', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('5467a7f58ed47', '5467a7f58ed47', '2022-07-24 12:42:24', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f7868aaa9a2cf', 'f7868aaa9a2cf', '2022-07-24 12:48:45', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('7907667c6f5fb', '7907667c6f5fb', '2022-07-24 12:49:00', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a18ff436c49f8', 'a18ff436c49f8', '2022-07-24 12:53:49', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('e269dacecd4f1', 'e269dacecd4f1', '2022-07-24 12:57:36', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f531ad16e8c69', 'f531ad16e8c69', '2022-07-24 13:15:37', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('feca604363472', 'feca604363472', '2022-07-24 13:16:07', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('7819e1f2583fc', '7819e1f2583fc', '2022-07-24 13:16:16', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('6cdde1bfcc0b', '6cdde1bfcc0b', '2022-07-24 13:23:08', '1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a976b6ff3bbb2', 'a976b6ff3bbb2', '2022-07-24 13:24:58', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('b3ee0fcdd9968', 'b3ee0fcdd9968', '2022-07-24 13:25:13', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('263cdc659bad', '263cdc659bad', '2022-07-24 13:25:24', '1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a660cadc49c75', 'a660cadc49c75', '2022-07-24 13:26:35', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('b00bc8ff89001', 'b00bc8ff89001', '2022-07-24 13:26:36', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('c46c5c068f2dd', 'c46c5c068f2dd', '2022-07-24 13:27:08', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('dd311837c738a', 'dd311837c738a', '2022-07-24 13:27:39', '1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('e863c8b10f58c', 'e863c8b10f58c', '2022-07-24 13:27:52', '1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('19e3c65962189', '19e3c65962189', '2022-07-24 13:28:09', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('26d358dbd73c9', '26d358dbd73c9', '2022-07-24 13:30:44', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('c01b9cfc765df', 'c01b9cfc765df', '2022-07-24 13:30:48', '1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('075332bff848d', '075332bff848d', '2022-07-24 13:31:02', '1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('93fd18a96baa9', '93fd18a96baa9', '2022-07-24 13:31:15', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('93fd18a96baa9', '93fd18a96baa9', '2022-07-24 13:31:29', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('93fd18a96baa9', '93fd18a96baa9', '2022-07-24 13:31:38', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('008e050e49eae', '008e050e49eae', '2022-07-24 13:32:35', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('ee4f8e20f4a25', 'ee4f8e20f4a25', '2022-07-24 13:32:36', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('290f4652020bb', '290f4652020bb', '2022-07-24 13:32:41', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('280ae1de9494', '280ae1de9494', '2022-07-24 13:32:48', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('fbbbb5f57c25e', 'fbbbb5f57c25e', '2022-07-24 13:32:58', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a29a20e2563a5', 'a29a20e2563a5', '2022-07-24 13:52:36', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('3c090861da08b', '3c090861da08b', '2022-07-24 13:53:59', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f9f4b1890e10e', 'f9f4b1890e10e', '2022-07-24 14:07:37', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('551a4b21cf201', '551a4b21cf201', '2022-07-24 14:54:35', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('ea8a334197244', 'ea8a334197244', '2022-07-24 14:58:37', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('19afce3bcce6a', '19afce3bcce6a', '2022-07-24 15:02:43', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('fe56989b8621d', 'fe56989b8621d', '2022-07-24 15:02:45', '-1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('5e42d9a29a00e', '5e42d9a29a00e', '2022-07-24 16:08:42', '-1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('421de6afb51da', '421de6afb51da', '2022-07-24 16:28:25', '-1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('3048391b322a', '3048391b322a', '2022-07-24 16:43:38', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('d68742fb3529c', 'd68742fb3529c', '2022-07-24 16:44:23', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('875cdb81ce967', '875cdb81ce967', '2022-07-24 16:44:42', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('bff50f99d1f93', 'bff50f99d1f93', '2022-07-24 16:44:55', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('c092e99f105e8', 'c092e99f105e8', '2022-07-24 16:47:08', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('31b58c7acd925', '31b58c7acd925', '2022-07-24 16:47:58', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('1544e34cadf6d', '1544e34cadf6d', '2022-07-24 16:48:30', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('b99fa81a7a0f5', 'b99fa81a7a0f5', '2022-07-24 16:48:52', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('b0e820003f785', 'b0e820003f785', '2022-07-24 16:53:13', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('38bdad1d55d6d', '38bdad1d55d6d', '2022-07-24 16:56:08', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('07a2316d56d77', '07a2316d56d77', '2022-07-24 16:57:23', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('0e0b57e82c3ed', '0e0b57e82c3ed', '2022-07-24 16:58:23', '1', '1', '1', '2022-07-24 16:59:23');
INSERT INTO `center_wqrcode` VALUES ('6befb3a358614', '6befb3a358614', '2022-07-24 17:01:16', '1', '1', '1', '2022-07-24 17:01:25');
INSERT INTO `center_wqrcode` VALUES ('f3613e3b386e5', 'f3613e3b386e5', '2022-07-24 17:07:57', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('73fbd863fe75', '73fbd863fe75', '2022-07-24 17:08:31', '1', '1', '1', '2022-07-24 17:08:49');
INSERT INTO `center_wqrcode` VALUES ('5890b48ed19c5', '5890b48ed19c5', '2022-07-24 17:10:07', '1', '1', '1', '2022-07-24 17:10:17');
INSERT INTO `center_wqrcode` VALUES ('4bfe5a600d7', '4bfe5a600d7', '2022-07-24 17:11:06', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('1cac1ff1cd45f', '1cac1ff1cd45f', '2022-07-24 17:11:27', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('bae5bd068eacb', 'bae5bd068eacb', '2022-07-24 17:11:51', '1', '2', '1', '2022-07-24 17:12:08');
INSERT INTO `center_wqrcode` VALUES ('a8d032433653a', 'a8d032433653a', '2022-07-24 17:13:44', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('b65f904367391', 'b65f904367391', '2022-07-24 17:13:47', '1', '2', '1', '2022-07-24 17:14:03');
INSERT INTO `center_wqrcode` VALUES ('def830d5d90a9', 'def830d5d90a9', '2022-07-24 17:14:32', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('bf2693ed3ddea', 'bf2693ed3ddea', '2022-07-24 17:15:37', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('6df0266431c9a', '6df0266431c9a', '2022-07-24 17:15:39', '1', '2', '1', '2022-07-24 17:15:53');
INSERT INTO `center_wqrcode` VALUES ('3b92eb55bfe11', '3b92eb55bfe11', '2022-07-24 17:17:15', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('8727a400bc055', '8727a400bc055', '2022-07-24 17:17:16', '1', '2', '1', '2022-07-24 17:17:26');
INSERT INTO `center_wqrcode` VALUES ('c04921f2247d4', 'c04921f2247d4', '2022-07-24 17:18:05', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('497f020eef9ef', '497f020eef9ef', '2022-07-24 17:18:17', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('b7947570c8516', 'b7947570c8516', '2022-07-24 17:18:19', '1', '2', '1', '2022-07-24 17:18:29');
INSERT INTO `center_wqrcode` VALUES ('a410c7ae240d2', 'a410c7ae240d2', '2022-07-24 17:19:01', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('c8c578fb0dfe2', 'c8c578fb0dfe2', '2022-07-24 17:19:26', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('7be392d411b1d', '7be392d411b1d', '2022-07-24 17:19:30', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('d274cc9589d4f', 'd274cc9589d4f', '2022-07-24 17:23:27', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('7e9bf1a810b0e', '7e9bf1a810b0e', '2022-07-24 17:23:30', '1', '2', '1', '2022-07-24 17:23:43');
INSERT INTO `center_wqrcode` VALUES ('1cc6a7b7c57a2', '1cc6a7b7c57a2', '2022-07-24 17:24:04', '1', '1', '1', '2022-07-24 17:24:13');
INSERT INTO `center_wqrcode` VALUES ('e977df18548a2', 'e977df18548a2', '2022-07-24 17:24:49', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('8542619efb904', '8542619efb904', '2022-07-24 17:26:31', '1', '1', '1', '2022-07-24 17:26:44');
INSERT INTO `center_wqrcode` VALUES ('5fe7ef57692e7', '5fe7ef57692e7', '2022-07-24 17:27:06', '1', '1', NULL, '2022-07-24 17:27:16');
INSERT INTO `center_wqrcode` VALUES ('cf1c2f895c7e8', 'cf1c2f895c7e8', '2022-07-24 17:27:20', '1', '1', NULL, '2022-07-24 17:27:29');
INSERT INTO `center_wqrcode` VALUES ('1b6d41172d93', '1b6d41172d93', '2022-07-24 17:52:05', '1', '1', '1', '2022-07-24 17:52:15');
INSERT INTO `center_wqrcode` VALUES ('d30783ca96336', 'd30783ca96336', '2022-07-24 21:46:19', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('d55d2637676e2', 'd55d2637676e2', '2022-07-24 21:46:59', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('f8fe15fd49663', 'f8fe15fd49663', '2022-07-24 21:47:21', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('5776aaf5ab1fa', '5776aaf5ab1fa', '2022-07-24 21:47:22', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('214a771d853f8', '214a771d853f8', '2022-07-24 21:47:25', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('b368478aa942e', 'b368478aa942e', '2022-07-24 21:47:39', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('3e8ea55959b9e', '3e8ea55959b9e', '2022-07-24 21:59:40', '-1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('57f6e2db9bc06', '57f6e2db9bc06', '2022-07-24 22:59:40', '-1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a53fdca22bb44', 'a53fdca22bb44', '2022-07-25 09:35:48', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('e2894967febe8', 'e2894967febe8', '2022-07-25 09:44:12', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('a31bc0b1a34e3', 'a31bc0b1a34e3', '2022-07-25 09:52:52', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('07f3e48cc29b7', '07f3e48cc29b7', '2022-07-25 10:03:29', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('8caa325084883', '8caa325084883', '2022-07-25 10:03:36', '-1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('8c30f2b2866e4', '8c30f2b2866e4', '2022-07-25 12:15:38', '-1', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('9820967c547aa', '9820967c547aa', '2022-07-25 14:01:46', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('2536ce624d41', '2536ce624d41', '2022-07-25 14:02:20', '0', NULL, NULL, NULL);
INSERT INTO `center_wqrcode` VALUES ('74c4a593a5461', '74c4a593a5461', '2022-07-25 14:04:38', '-1', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for code_datasource
-- ----------------------------
DROP TABLE IF EXISTS `code_datasource`;
CREATE TABLE `code_datasource`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键ID',
  `url` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `user` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `pwd` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '数据源配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of code_datasource
-- ----------------------------

-- ----------------------------
-- Table structure for code_tablecfg
-- ----------------------------
DROP TABLE IF EXISTS `code_tablecfg`;
CREATE TABLE `code_tablecfg`  (
  `id` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主键ID',
  `datasource` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '关联数据源',
  `tablename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表名',
  `fix` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '表前缀',
  `pkg` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '包名',
  `auth` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '作者',
  `createtime` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `mode_desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '所属模块',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '生成表配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of code_tablecfg
-- ----------------------------
INSERT INTO `code_tablecfg` VALUES ('TC20220731115213066', '1', 'center_dictionary', 'center_', 'org.simple.plan', 'zhoupy1', '2022-07-31 11:52:13', NULL);
INSERT INTO `code_tablecfg` VALUES ('TC20220731161347517', 'DS20220731160534272', 'simple_user', 'si_', 'org.simple.plan', 'frsimple', '2022-07-31 16:13:48', NULL);
INSERT INTO `code_tablecfg` VALUES ('TC20220803214735642', 'DS20220803214655434', 'center_branch', 'center_', 'org.simple.center', 'frsimple', '2022-08-03 21:47:36', NULL);
INSERT INTO `code_tablecfg` VALUES ('TC20220803215631985', 'DS20220803215317588', 'center_branch', 'cenrer_', 'org.simple.center', 'frsimple', '2022-08-03 21:56:32', NULL);

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
CREATE TABLE `oauth_client_details`  (
  `client_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '客户端标识',
  `resource_ids` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '接入资源列表',
  `client_secret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '客户端秘钥',
  `scope` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '授权范围',
  `authorized_grant_types` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '允许授权类型',
  `web_server_redirect_uri` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '客户端的重定向URI',
  `authorities` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '客户端所拥有的权限值',
  `access_token_validity` int NULL DEFAULT NULL COMMENT '设定客户端的access_token的有效时间值(单位:秒)',
  `refresh_token_validity` int NULL DEFAULT NULL COMMENT '设定客户端的refresh_token的有效时间值(单位:秒',
  `additional_information` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '这是一个预留的字段,在Oauth的流程中没有实际的使用,可选,但若设置值,必须是JSON格式的数据,',
  `create_time` timestamp NULL DEFAULT NULL,
  `archived` tinyint(1) NULL DEFAULT NULL COMMENT '用于标识客户端是否已存档(即实现逻辑删除),默认值为’0’(即未存档)',
  `trusted` tinyint(1) NULL DEFAULT NULL COMMENT '设置客户端是否为受信任的,默认为’0’(即不受信任的,1为受信任的)',
  `autoapprove` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '设置用户是否自动Approval操作, 默认值为 ‘false’, 可选值包括 ‘true’,‘false’, ‘read’,‘write’. ',
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'Oauth2客户端账号信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
INSERT INTO `oauth_client_details` VALUES ('c1', 'simple-center,simple-plan', 'secret', 'ROLE_API,ROLE_ADMIN', 'client_credentials,password,authorization_code,implicit,refresh_token,sms_code', 'http://www.baidu.com', NULL, 300000, 31536000, NULL, '2022-06-17 14:10:07', 0, 0, 'false');
INSERT INTO `oauth_client_details` VALUES ('simple', 'simple-center,simple-plan,simple-code', 'simple', 'all', 'client_credentials,password,authorization_code,implicit,refresh_token,sms_code,third_code', 'https://www.baidu.com', NULL, 30000000, 30000000, NULL, '2022-08-06 10:57:48', 0, 0, 'false');

-- ----------------------------
-- Table structure for oauth_code
-- ----------------------------
DROP TABLE IF EXISTS `oauth_code`;
CREATE TABLE `oauth_code`  (
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据的创建时间',
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '存储服务端系统生成的code的值(未加密)',
  `authentication` blob NULL COMMENT '存储将AuthorizationRequestHolder.java对象序列化后的二进制数据.',
  INDEX `code_index`(`code` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'Oauth2.0授权信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of oauth_code
-- ----------------------------
INSERT INTO `oauth_code` VALUES ('2020-07-13 00:53:06', 'DIejHE', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002120200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000270317371007E000D74000270327871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E001678707400026331737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000474000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740014687474703A2F2F7777772E62616964752E636F6D740009636C69656E745F696471007E001974000573636F706574000A524F4C455F41444D494E78737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000171007E002478017371007E0028770C000000103F40000000000000787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0028770C000000103F4000000000000174000472657331787371007E0028770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002120200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E0032737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002120200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000F303A303A303A303A303A303A303A31740020313934304132433337454641353637343533424133413143383530353744394570737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657200000000000002120200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657371007E00164C000870617373776F726471007E000E4C0008757365726E616D6571007E000E7870010101017371007E0025737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F720000000000000212020000787077040000000271007E000F71007E00117870740004726F6F74);
INSERT INTO `oauth_code` VALUES ('2020-07-20 02:05:35', 'ka8Muk', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002120200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000270317371007E000D74000270327871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E001678707400026331737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F400000000000067708000000080000000474000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740014687474703A2F2F7777772E62616964752E636F6D740009636C69656E745F696471007E001974000573636F706574000A524F4C455F41444D494E78737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000171007E002478017371007E0028770C000000103F40000000000000787371007E001C3F40000000000000770800000010000000007871007E0021707371007E0028770C000000103F4000000000000174000472657331787371007E0028770C000000103F4000000000000171007E001F787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002120200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E0032737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002120200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000F303A303A303A303A303A303A303A31740020334539334530453241333842394137333944444441443634373046343142323570737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657200000000000002120200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657371007E00164C000870617373776F726471007E000E4C0008757365726E616D6571007E000E7870010101017371007E0025737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F720000000000000212020000787077040000000271007E000F71007E00117870740004726F6F74);
INSERT INTO `oauth_code` VALUES ('2020-07-20 02:20:25', '33d6OR', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002120200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000270317371007E000D74000270327871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E001678707400026331737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000677080000000800000005740013757365725F6F617574685F617070726F76616C7400047472756574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740014687474703A2F2F7777772E62616964752E636F6D740009636C69656E745F696471007E001974000573636F706574000A524F4C455F41444D494E78737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000171007E002678017371007E002A770C000000103F40000000000000787371007E001C3F40000000000000770800000010000000007871007E0023707371007E002A770C000000103F4000000000000174000472657331787371007E002A770C000000103F4000000000000171007E0021787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002120200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E0034737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002120200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000F303A303A303A303A303A303A303A31740020334432444633353032353135383744433042333744423444344644443945314470737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657200000000000002120200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657371007E00164C000870617373776F726471007E000E4C0008757365726E616D6571007E000E7870010101017371007E0027737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F720000000000000212020000787077040000000271007E000F71007E00117870740004726F6F74);
INSERT INTO `oauth_code` VALUES ('2020-07-20 02:22:04', 'VZpQQP', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002120200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000270317371007E000D74000270327871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E001678707400026331737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000677080000000800000005740013757365725F6F617574685F617070726F76616C7400047472756574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740014687474703A2F2F7777772E62616964752E636F6D740009636C69656E745F696471007E001974000573636F706574000A524F4C455F41444D494E78737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000171007E002678017371007E002A770C000000103F40000000000000787371007E001C3F40000000000000770800000010000000007871007E0023707371007E002A770C000000103F4000000000000174000472657331787371007E002A770C000000103F4000000000000171007E0021787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002120200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E0034737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002120200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000F303A303A303A303A303A303A303A31740020334432444633353032353135383744433042333744423444344644443945314470737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657200000000000002120200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657371007E00164C000870617373776F726471007E000E4C0008757365726E616D6571007E000E7870010101017371007E0027737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F720000000000000212020000787077040000000271007E000F71007E00117870740004726F6F74);
INSERT INTO `oauth_code` VALUES ('2020-07-20 21:08:05', 'qAFTxx', 0xACED0005737200416F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F417574683241757468656E7469636174696F6EBD400B02166252130200024C000D73746F7265645265717565737474003C4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F4F4175746832526571756573743B4C00127573657241757468656E7469636174696F6E7400324C6F72672F737072696E676672616D65776F726B2F73656375726974792F636F72652F41757468656E7469636174696F6E3B787200476F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E416273747261637441757468656E7469636174696F6E546F6B656ED3AA287E6E47640E0200035A000D61757468656E746963617465644C000B617574686F7269746965737400164C6A6176612F7574696C2F436F6C6C656374696F6E3B4C000764657461696C737400124C6A6176612F6C616E672F4F626A6563743B787000737200266A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654C697374FC0F2531B5EC8E100200014C00046C6973747400104C6A6176612F7574696C2F4C6973743B7872002C6A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65436F6C6C656374696F6E19420080CB5EF71E0200014C00016371007E00047870737200136A6176612E7574696C2E41727261794C6973747881D21D99C7619D03000149000473697A65787000000002770400000002737200426F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E617574686F726974792E53696D706C654772616E746564417574686F7269747900000000000002120200014C0004726F6C657400124C6A6176612F6C616E672F537472696E673B787074000270317371007E000D74000270327871007E000C707372003A6F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E4F41757468325265717565737400000000000000010200075A0008617070726F7665644C000B617574686F72697469657371007E00044C000A657874656E73696F6E7374000F4C6A6176612F7574696C2F4D61703B4C000B726564697265637455726971007E000E4C00077265667265736874003B4C6F72672F737072696E676672616D65776F726B2F73656375726974792F6F61757468322F70726F76696465722F546F6B656E526571756573743B4C000B7265736F7572636549647374000F4C6A6176612F7574696C2F5365743B4C000D726573706F6E7365547970657371007E0016787200386F72672E737072696E676672616D65776F726B2E73656375726974792E6F61757468322E70726F76696465722E426173655265717565737436287A3EA37169BD0200034C0008636C69656E74496471007E000E4C001172657175657374506172616D657465727371007E00144C000573636F706571007E001678707400026331737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C654D6170F1A5A8FE74F507420200014C00016D71007E00147870737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000677080000000800000005740013757365725F6F617574685F617070726F76616C7400047472756574000D726573706F6E73655F74797065740004636F646574000C72656469726563745F757269740014687474703A2F2F7777772E62616964752E636F6D740009636C69656E745F696471007E001974000573636F706574000A524F4C455F41444D494E78737200256A6176612E7574696C2E436F6C6C656374696F6E7324556E6D6F6469666961626C65536574801D92D18F9B80550200007871007E0009737200176A6176612E7574696C2E4C696E6B656448617368536574D86CD75A95DD2A1E020000787200116A6176612E7574696C2E48617368536574BA44859596B8B7340300007870770C000000103F4000000000000171007E002678017371007E002A770C000000103F40000000000000787371007E001C3F40000000000000770800000010000000007871007E0023707371007E002A770C000000103F4000000000000174000472657331787371007E002A770C000000103F4000000000000171007E0021787372004F6F72672E737072696E676672616D65776F726B2E73656375726974792E61757468656E7469636174696F6E2E557365726E616D6550617373776F726441757468656E7469636174696F6E546F6B656E00000000000002120200024C000B63726564656E7469616C7371007E00054C00097072696E636970616C71007E00057871007E0003017371007E00077371007E000B0000000277040000000271007E000F71007E00117871007E0034737200486F72672E737072696E676672616D65776F726B2E73656375726974792E7765622E61757468656E7469636174696F6E2E57656241757468656E7469636174696F6E44657461696C7300000000000002120200024C000D72656D6F74654164647265737371007E000E4C000973657373696F6E496471007E000E787074000F303A303A303A303A303A303A303A31740020333136323030394238324145463239343735353939374633333138423736364670737200326F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657200000000000002120200075A00116163636F756E744E6F6E457870697265645A00106163636F756E744E6F6E4C6F636B65645A001563726564656E7469616C734E6F6E457870697265645A0007656E61626C65644C000B617574686F72697469657371007E00164C000870617373776F726471007E000E4C0008757365726E616D6571007E000E7870010101017371007E0027737200116A6176612E7574696C2E54726565536574DD98509395ED875B0300007870737200466F72672E737072696E676672616D65776F726B2E73656375726974792E636F72652E7573657264657461696C732E5573657224417574686F72697479436F6D70617261746F720000000000000212020000787077040000000271007E000F71007E00117870740004726F6F74);

SET FOREIGN_KEY_CHECKS = 1;

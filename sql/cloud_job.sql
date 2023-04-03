/*
 Navicat Premium Data Transfer

 Source Server         : jenkins数据库
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : 1.116.163.43:3470
 Source Schema         : cloud_job

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 03/04/2023 15:04:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for xxl_job_group
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_group`;
CREATE TABLE `xxl_job_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行器AppName',
  `title` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行器名称',
  `address_type` tinyint NOT NULL DEFAULT 0 COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '执行器地址列表，多地址逗号分隔',
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_group
-- ----------------------------
INSERT INTO `xxl_job_group` VALUES (1, 'xxl-job-center', '中台服务', 0, 'http://192.17.4.1:9999/', '2023-04-03 15:03:54');

-- ----------------------------
-- Table structure for xxl_job_info
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_info`;
CREATE TABLE `xxl_job_info`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_group` int NOT NULL COMMENT '执行器主键ID',
  `job_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `add_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `author` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报警邮件',
  `schedule_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'NONE' COMMENT '调度类型',
  `schedule_conf` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '调度配置，值含义取决于调度类型',
  `misfire_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DO_NOTHING' COMMENT '调度过期策略',
  `executor_route_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_timeout` int NOT NULL DEFAULT 0 COMMENT '任务执行超时时间，单位秒',
  `executor_fail_retry_count` int NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `glue_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime NULL DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
  `trigger_status` tinyint NOT NULL DEFAULT 0 COMMENT '调度状态：0-停止，1-运行',
  `trigger_last_time` bigint NOT NULL DEFAULT 0 COMMENT '上次调度时间',
  `trigger_next_time` bigint NOT NULL DEFAULT 0 COMMENT '下次调度时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_info
-- ----------------------------
INSERT INTO `xxl_job_info` VALUES (1, 1, '测试任务1', '2018-11-03 22:21:31', '2022-09-19 09:29:52', 'XXL', '', 'FIX_RATE', '60000', 'DO_NOTHING', 'RANDOM', 'demoJobHandler', '', 'SERIAL_EXECUTION', 0, 0, 'BEAN', '', 'GLUE代码初始化', '2018-11-03 22:21:31', '', 1, 1680456952806, 1680516952806);

-- ----------------------------
-- Table structure for xxl_job_lock
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_lock`;
CREATE TABLE `xxl_job_lock`  (
  `lock_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '锁名称',
  PRIMARY KEY (`lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_lock
-- ----------------------------
INSERT INTO `xxl_job_lock` VALUES ('schedule_lock');

-- ----------------------------
-- Table structure for xxl_job_log
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_log`;
CREATE TABLE `xxl_job_log`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `job_group` int NOT NULL COMMENT '执行器主键ID',
  `job_id` int NOT NULL COMMENT '任务，主键ID',
  `executor_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
  `executor_handler` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务参数',
  `executor_sharding_param` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
  `executor_fail_retry_count` int NOT NULL DEFAULT 0 COMMENT '失败重试次数',
  `trigger_time` datetime NULL DEFAULT NULL COMMENT '调度-时间',
  `trigger_code` int NOT NULL COMMENT '调度-结果',
  `trigger_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '调度-日志',
  `handle_time` datetime NULL DEFAULT NULL COMMENT '执行-时间',
  `handle_code` int NOT NULL COMMENT '执行-状态',
  `handle_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '执行-日志',
  `alarm_status` tinyint NOT NULL DEFAULT 0 COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `I_trigger_time`(`trigger_time` ASC) USING BTREE,
  INDEX `I_handle_code`(`handle_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13235 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_log
-- ----------------------------
INSERT INTO `xxl_job_log` VALUES (13191, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-04 04:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-04 04:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13192, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-04 21:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-04 21:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13193, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-05 14:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-05 14:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13194, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-06 06:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-06 06:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13195, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-06 23:35:53', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-06 23:36:03', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13196, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-07 16:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-07 16:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13197, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-08 08:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-08 08:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13198, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-09 01:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-09 01:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13199, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-09 18:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-09 18:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13200, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-10 10:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-10 10:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13201, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-11 03:35:53', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-11 03:36:03', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13202, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-11 20:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-11 20:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13203, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-12 12:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-12 12:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13204, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-13 05:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-13 05:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13205, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-13 22:15:53', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-13 22:16:03', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13206, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-14 14:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-14 14:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13207, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-15 07:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-15 07:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13208, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-16 00:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-16 00:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13209, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-16 16:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-16 16:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13210, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-17 09:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-17 09:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13211, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-18 02:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-18 02:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13212, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-18 18:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-18 18:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13213, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-19 11:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-19 11:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13214, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-20 04:15:53', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-20 04:16:03', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13215, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-20 20:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-20 20:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13216, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-21 13:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-21 13:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13217, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-22 06:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-22 06:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13218, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-22 22:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-22 22:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13219, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-23 15:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-23 15:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13220, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-24 08:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-24 08:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13221, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-25 00:55:53', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-25 00:56:03', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13222, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-25 17:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-25 17:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13223, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-26 10:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-26 10:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13224, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-27 02:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-27 02:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13225, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-27 19:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-27 19:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13226, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-28 12:15:53', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-28 12:16:03', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13227, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-29 04:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-29 04:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13228, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-29 21:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-29 21:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13229, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-30 14:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-30 14:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13230, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-31 06:55:53', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-31 06:56:03', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13231, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-03-31 23:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-03-31 23:36:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13232, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-04-01 16:15:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-04-01 16:16:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13233, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-04-02 08:55:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-04-02 08:56:02', 200, '', 0);
INSERT INTO `xxl_job_log` VALUES (13234, 1, 1, 'http://192.17.4.1:9999/', 'demoJobHandler', '', NULL, 0, '2023-04-03 01:35:52', 200, '任务触发类型：Cron触发<br>调度机器：192.17.4.1<br>执行器-注册方式：自动注册<br>执行器-地址列表：[http://192.17.4.1:9999/]<br>路由策略：随机<br>阻塞处理策略：单机串行<br>任务超时时间：0<br>失败重试次数：0<br><br><span style=\"color:#00c0ef;\" > >>>>>>>>>>>触发调度<<<<<<<<<<< </span><br>触发调度：<br>address：http://192.17.4.1:9999/<br>code：200<br>msg：null', '2023-04-03 01:36:02', 200, '', 0);

-- ----------------------------
-- Table structure for xxl_job_log_report
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_log_report`;
CREATE TABLE `xxl_job_log_report`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `trigger_day` datetime NULL DEFAULT NULL COMMENT '调度-时间',
  `running_count` int NOT NULL DEFAULT 0 COMMENT '运行中-日志数量',
  `suc_count` int NOT NULL DEFAULT 0 COMMENT '执行成功-日志数量',
  `fail_count` int NOT NULL DEFAULT 0 COMMENT '执行失败-日志数量',
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_trigger_day`(`trigger_day` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 210 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_log_report
-- ----------------------------
INSERT INTO `xxl_job_log_report` VALUES (1, '2022-09-09 00:00:00', 0, 26, 10, NULL);
INSERT INTO `xxl_job_log_report` VALUES (2, '2022-09-08 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (3, '2022-09-07 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (4, '2022-09-10 00:00:00', 0, 821, 8, NULL);
INSERT INTO `xxl_job_log_report` VALUES (5, '2022-09-11 00:00:00', 0, 1440, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (6, '2022-09-12 00:00:00', 0, 1440, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (7, '2022-09-13 00:00:00', 0, 1440, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (8, '2022-09-14 00:00:00', 0, 1440, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (9, '2022-09-15 00:00:00', 0, 1440, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (10, '2022-09-16 00:00:00', 0, 1440, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (11, '2022-09-17 00:00:00', 0, 1440, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (12, '2022-09-18 00:00:00', 0, 1440, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (13, '2022-09-19 00:00:00', 0, 570, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (14, '2022-09-20 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (15, '2022-09-21 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (16, '2022-09-22 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (17, '2022-09-23 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (18, '2022-09-24 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (19, '2022-09-25 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (20, '2022-09-26 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (21, '2022-09-27 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (22, '2022-09-28 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (23, '2022-09-29 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (24, '2022-09-30 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (25, '2022-10-01 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (26, '2022-10-02 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (27, '2022-10-03 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (28, '2022-10-04 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (29, '2022-10-05 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (30, '2022-10-06 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (31, '2022-10-07 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (32, '2022-10-08 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (33, '2022-10-09 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (34, '2022-10-10 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (35, '2022-10-11 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (36, '2022-10-12 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (37, '2022-10-13 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (38, '2022-10-14 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (39, '2022-10-15 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (40, '2022-10-16 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (41, '2022-10-17 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (42, '2022-10-18 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (43, '2022-10-19 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (44, '2022-10-20 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (45, '2022-10-21 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (46, '2022-10-22 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (47, '2022-10-23 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (48, '2022-10-24 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (49, '2022-10-25 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (50, '2022-10-26 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (51, '2022-10-27 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (52, '2022-10-28 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (53, '2022-10-29 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (54, '2022-10-30 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (55, '2022-10-31 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (56, '2022-11-01 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (57, '2022-11-02 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (58, '2022-11-03 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (59, '2022-11-04 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (60, '2022-11-05 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (61, '2022-11-06 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (62, '2022-11-07 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (63, '2022-11-08 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (64, '2022-11-09 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (65, '2022-11-10 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (66, '2022-11-11 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (67, '2022-11-12 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (68, '2022-11-13 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (69, '2022-11-14 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (70, '2022-11-15 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (71, '2022-11-16 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (72, '2022-11-17 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (73, '2022-11-18 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (74, '2022-11-19 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (75, '2022-11-20 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (76, '2022-11-21 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (77, '2022-11-22 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (78, '2022-11-23 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (79, '2022-11-24 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (80, '2022-11-25 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (81, '2022-11-26 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (82, '2022-11-27 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (83, '2022-11-28 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (84, '2022-11-29 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (85, '2022-11-30 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (86, '2022-12-01 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (87, '2022-12-02 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (88, '2022-12-03 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (89, '2022-12-04 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (90, '2022-12-05 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (91, '2022-12-06 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (92, '2022-12-07 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (93, '2022-12-08 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (94, '2022-12-09 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (95, '2022-12-10 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (96, '2022-12-11 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (97, '2022-12-12 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (98, '2022-12-13 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (99, '2022-12-14 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (100, '2022-12-15 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (101, '2022-12-16 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (102, '2022-12-17 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (103, '2022-12-18 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (104, '2022-12-19 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (105, '2022-12-20 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (106, '2022-12-21 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (107, '2022-12-22 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (108, '2022-12-23 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (109, '2022-12-24 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (110, '2022-12-25 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (111, '2022-12-26 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (112, '2022-12-27 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (113, '2022-12-28 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (114, '2022-12-29 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (115, '2022-12-30 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (116, '2022-12-31 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (117, '2023-01-01 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (118, '2023-01-02 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (119, '2023-01-03 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (120, '2023-01-04 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (121, '2023-01-05 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (122, '2023-01-06 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (123, '2023-01-07 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (124, '2023-01-08 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (125, '2023-01-09 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (126, '2023-01-10 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (127, '2023-01-11 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (128, '2023-01-12 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (129, '2023-01-13 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (130, '2023-01-14 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (131, '2023-01-15 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (132, '2023-01-16 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (133, '2023-01-17 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (134, '2023-01-18 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (135, '2023-01-19 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (136, '2023-01-20 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (137, '2023-01-21 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (138, '2023-01-22 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (139, '2023-01-23 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (140, '2023-01-24 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (141, '2023-01-25 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (142, '2023-01-26 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (143, '2023-01-27 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (144, '2023-01-28 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (145, '2023-01-29 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (146, '2023-01-30 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (147, '2023-01-31 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (148, '2023-02-01 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (149, '2023-02-02 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (150, '2023-02-03 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (151, '2023-02-04 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (152, '2023-02-05 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (153, '2023-02-06 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (154, '2023-02-07 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (155, '2023-02-08 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (156, '2023-02-09 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (157, '2023-02-10 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (158, '2023-02-11 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (159, '2023-02-12 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (160, '2023-02-13 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (161, '2023-02-15 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (162, '2023-02-14 00:00:00', 0, 0, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (163, '2023-02-16 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (164, '2023-02-17 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (165, '2023-02-18 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (166, '2023-02-19 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (167, '2023-02-20 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (168, '2023-02-21 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (169, '2023-02-22 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (170, '2023-02-23 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (171, '2023-02-24 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (172, '2023-02-25 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (173, '2023-02-26 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (174, '2023-02-27 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (175, '2023-02-28 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (176, '2023-03-01 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (177, '2023-03-02 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (178, '2023-03-03 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (179, '2023-03-04 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (180, '2023-03-05 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (181, '2023-03-06 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (182, '2023-03-07 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (183, '2023-03-08 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (184, '2023-03-09 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (185, '2023-03-10 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (186, '2023-03-11 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (187, '2023-03-12 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (188, '2023-03-13 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (189, '2023-03-14 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (190, '2023-03-15 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (191, '2023-03-16 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (192, '2023-03-17 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (193, '2023-03-18 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (194, '2023-03-19 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (195, '2023-03-20 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (196, '2023-03-21 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (197, '2023-03-22 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (198, '2023-03-23 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (199, '2023-03-24 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (200, '2023-03-25 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (201, '2023-03-26 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (202, '2023-03-27 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (203, '2023-03-28 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (204, '2023-03-29 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (205, '2023-03-30 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (206, '2023-03-31 00:00:00', 0, 2, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (207, '2023-04-01 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (208, '2023-04-02 00:00:00', 0, 1, 0, NULL);
INSERT INTO `xxl_job_log_report` VALUES (209, '2023-04-03 00:00:00', 0, 1, 0, NULL);

-- ----------------------------
-- Table structure for xxl_job_logglue
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_logglue`;
CREATE TABLE `xxl_job_logglue`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'GLUE备注',
  `add_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_logglue
-- ----------------------------

-- ----------------------------
-- Table structure for xxl_job_registry
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_registry`;
CREATE TABLE `xxl_job_registry`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `registry_group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registry_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registry_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `i_g_k_v`(`registry_group` ASC, `registry_key` ASC, `registry_value` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_registry
-- ----------------------------
INSERT INTO `xxl_job_registry` VALUES (22, 'EXECUTOR', 'xxl-job-center', 'http://192.17.4.1:9999/', '2023-04-03 15:03:59');

-- ----------------------------
-- Table structure for xxl_job_user
-- ----------------------------
DROP TABLE IF EXISTS `xxl_job_user`;
CREATE TABLE `xxl_job_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '账号',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `role` tinyint NOT NULL COMMENT '角色：0-普通用户、1-管理员',
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限：执行器ID列表，多个逗号分割',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `i_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xxl_job_user
-- ----------------------------
INSERT INTO `xxl_job_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 1, NULL);

SET FOREIGN_KEY_CHECKS = 1;

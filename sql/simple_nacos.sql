-- MySQL dump 10.13  Distrib 5.7.27, for macos10.14 (x86_64)
--
-- Host: sh-cdb-8n8zfbbc.sql.tencentcdb.com    Database: simple_nacos
-- ------------------------------------------------------
-- Server version	8.0.22-txsql

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED='f04718d3-5da0-11ec-b290-0c42a1311dee:1-192216';

--
-- Table structure for table `config_info`
--

DROP TABLE IF EXISTS `config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin,
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info`
--

LOCK TABLES `config_info` WRITE;
/*!40000 ALTER TABLE `config_info` DISABLE KEYS */;
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (1,'application.yaml','DEFAULT_GROUP','#不校验token的接口\nauth:\n  white-urls: \n    - /center/student/grade2\n    - /center/druid/**\n    - /druid/**\n    - /job/xxl-job-admin/**\n    - /xxl-job-admin/**\n    - /job/**\nspring:\n  security: \n    user: \n      username: simple\n      password: simple\n  servlet:\n    multipart:\n      location: /Users/zhoupengyu/workspace/temp\n  # redis 相关\n  redis:\n    host: localhost\n    port: 6378\n    password: \n    database: 1\n# logging日志\nlogging:\n  level:\n    com.alibaba.nacos.client.config.impl: ERROR\n    root: info\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\nhystrix:\n  command:\n    default:\n      execution:\n        isolation:\n          strategy: SEMAPHORE\n          thread:\n            timeoutInMilliseconds: 20000\n  shareSecurityContext: true\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n# mybaits-plus配置\nmybatis-plus:\n  # MyBatis Mapper所对应的XML文件位置\n  mapper-locations: classpath:/mapper/*Mapper.xml\n  global-config:\n    sql-parser-cache: true\n    # 关闭MP3.0自带的banner\n    banner: false\n    db-config:\n      # 主键类型\n      id-type: auto\n      select-strategy: not_empty','95125dd24355dee26a22f185ca086afa','2022-06-26 07:16:04','2022-09-10 10:07:20','nacos','140.207.23.237','','','主配置文件','','','yaml','',''),(2,'simple-route.yaml','DEFAULT_GROUP','routes:\n- id: simple-grant\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /auth/**\n  filters:\n    - StripPrefix=1\n    - name: GrantFilter\n  uri: lb://simple-grant\n  order: 0\n- id: simple-center\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /center/**\n  filters:\n    - StripPrefix=1\n    - name: RequestRateLimiter\n      args: \n        key-resolver: \'#{@ipKeyResolver}\'\n        redis-rate-limiter.burstCapacity: 20\n        redis-rate-limiter.replenishRate: 20\n    - name: Hystrix\n      args: \n        fallbackUri: \'forward:/fallback\'\n        name: default\n  uri: lb://simple-center\n  order: 0\n- id: simple-code\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /gcode/**\n  filters:\n    - StripPrefix=1\n    - name: Hystrix\n      args: \n        fallbackUri: \'forward:/fallback\'\n        name: default\n  uri: lb://simple-code\n  order: 0\n- id: simple-plan\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /plan/**\n  filters:\n    - StripPrefix=1\n    - name: RequestRateLimiter\n      args: \n        key-resolver: \'#{@ipKeyResolver}\'\n        redis-rate-limiter.burstCapacity: 20\n        redis-rate-limiter.replenishRate: 20\n    - name: Hystrix\n      args: \n        fallbackUri: \'forward:/fallback\'\n        name: default\n  uri: lb://simple-plan\n  order: 0\n#xxl-job配置\n- id: simple-job\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /job/**\n  filters:\n    - StripPrefix=1\n  uri: lb://simple-job\n  order: 0\n- id: xxl-job-admin\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /xxl-job-admin/**\n  filters:\n    - StripPrefix=1\n  uri: lb://simple-job\n  order: 0','9fb46f0a60d4e097863a89a3bcd64027','2022-06-26 07:16:26','2022-09-10 10:08:03','nacos','140.207.23.237','','','动态路由','','','yaml','',''),(3,'simple-center.yaml','DEFAULT_GROUP','oauth2:\n  scope: ROLE_ADMIN\n# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: \n      url: jdbc:mysql://sh-cdb-8n8zfbbc.sql.tencentcdb.com:59296/simple_center?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n      web-stat-filter: \n        enabled: true\n      stat-view-servlet:\n        enabled: true\n        # 设置白名单，不填则允许所有访问\n        allow: \"\"\n        deny: \"\"\n        url-pattern: /druid/*\n        # 控制台管理用户名和密码\n        login-username: admin\n        login-password: 123456\n      filter:\n        stat:\n            enabled: true\n            # 慢SQL记录\n            log-slow-sql: true\n            slow-sql-millis: 1000\n            merge-sql: true\n        wall:\n            config:\n                multi-statement-allow: true\n# Logger Config sql日志\nlogging:\n  level:\n    root: info     \nxxl: \n  job:\n    admin: \n      addresses: http://localhost:1100/xxl-job-admin\n    accessToken: 8WVT2qfjh3q3bNCX\n    executor:\n      appname: xxl-job-center\n      address: \n      ip: \n      port: 0\n      logpath: /home/logs\n      logretentiondays: 30\n#seata分布式配置\n# seata:\n#   enabled: true\n#   #此处配置自定义的seata事务分组名称，和service.vgroupMapping.xxxx-seata-service-group对应\n#   tx-service-group: default-seata-service-group\n#   config:\n#     type: nacos\n#     nacos:\n#       application: seata-server\n#       server-addr: 127.0.0.1:8848\n#       group: \"SEATA_GROUP\"\n#       namespace: \"\"\n#       cluster: \"default\"\n#       username: \"nacos\"\n#       password: \"nacos\"\n#   registry:\n#     type: nacos\n#     nacos:\n#       application: seata-server\n#       server-addr: 127.0.0.1:8848\n#       group: \"SEATA_GROUP\"\n#       namespace: \"\"\n#       cluster: \"default\"\n#       username: \"nacos\"\n#       password: \"nacos\"','b9b15cb9fa231e02a1d816ebadff545b','2022-06-26 07:17:00','2022-09-10 10:11:06','nacos','140.207.23.237','','','中台系统','','','yaml','',''),(4,'simple-grant.yaml','DEFAULT_GROUP','# 数据源\nspring:\n  main: \n    allow-bean-definition-overriding: true\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: \n      url: jdbc:mysql://sh-cdb-8n8zfbbc.sql.tencentcdb.com:59296/simple_center?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n  freemarker:\n    allow-request-override: false\n    allow-session-override: false\n    cache: true\n    charset: UTF-8\n    check-template-location: true\n    content-type: text/html\n    enabled: true\n    expose-request-attributes: false\n    expose-session-attributes: false\n    expose-spring-macro-helpers: true\n    prefer-file-system-access: true\n','cb09e9faf7873e73ad15ccf6c6775f4b','2022-06-26 07:17:20','2022-07-31 16:19:58','nacos','101.87.142.230','','','','','','yaml','',''),(5,'simple-plan.yaml','DEFAULT_GROUP','oauth2:\n  scope: ROLE_ADMIN\n# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: \n      url: jdbc:mysql://sh-cdb-8n8zfbbc.sql.tencentcdb.com:59296/simple_center?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n# Logger Config sql日志\nlogging:\n  level:\n    root: info ','39dda7a767dbc4747e888e468c61688a','2022-06-26 07:17:53','2022-07-31 16:20:14','nacos','101.87.142.230','','','','','','yaml','',''),(14,'simple-code.yaml','DEFAULT_GROUP','oauth2:\n  scope: ROLE_ADMIN\n# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: \n      url: jdbc:mysql://sh-cdb-8n8zfbbc.sql.tencentcdb.com:59296/simple_center?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n# Logger Config sql日志\nlogging:\n  level:\n    root: info ','39dda7a767dbc4747e888e468c61688a','2022-08-06 10:53:28','2022-08-06 10:53:28',NULL,'101.87.142.230','','',NULL,NULL,NULL,'yaml',NULL,''),(17,'simple-job.yaml','DEFAULT_GROUP','oauth2:\n  scope: ROLE_ADMIN\n#server.port=8080\nserver:\n  servlet:\n    context-path: /xxl-job-admin\n\n### actuator\nmanagement:\n  server:\n    servlet:\n      context-path: /actuator\n  health:\n    mail:\n      enabled: false\n\n### resources\nspring:\n  mvc:\n    servlet:\n      load-on-startup: 0\n    static-path-pattern: /static/**\n  resources:\n    static-locations: classpath:/static/\n  freemarker:\n    templateLoaderPath: classpath:/templates/\n    suffix: .ftl\n    charset: UTF-8\n    request-context-attribute: request\n    settings:\n      number_format: 0.##########\n  datasource:\n    url: jdbc:mysql://sh-cdb-8n8zfbbc.sql.tencentcdb.com:59296/simple_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai\n    username: root\n    password: \n    driver-class-name: com.mysql.cj.jdbc.Driver\n    type: com.zaxxer.hikari.HikariDataSource\n    hikari:\n      minimum-idle: 10\n      maximum-pool-size: 30\n      auto-commit: true\n      idle-timeout: 30000\n      pool-name: HikariCP\n      max-lifetime: 900000\n      connection-timeout: 10000\n      connection-test-query: SELECT 1\n      validation-timeout: 1000\n  mail:\n    host: smtp.qq.com\n    port: 25\n    username: xxx@qq.com\n    from: xxx@qq.com\n    password: xxx\n    properties.mail.smtp.auth: true\n    properties.mail.smtp.starttls.enable: true\n    properties.mail.smtp.starttls.required: true\n    properties.mail.smtp.socketFactory.class: javax.net.ssl.SSLSocketFactory\n### mybatis-plus\nmybatis-plus:\n  mapper-locations: classpath:/mybatis-mapper/*Mapper.xml\n  #configuration:\n  #  log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n#mybatis.type-aliases-package=com.xxl.job.admin.core.model\n\n### xxl-job, access token\nxxl:\n  job:\n    accessToken: 8WVT2qfjh3q3bNCX\n    i18n: zh_CN\n    triggerpool: \n      fast:\n        max: 200\n      slow:\n        max: 100\n    logretentiondays: 30\n','b18a3436b69ca2441d170d574a167498','2022-09-10 10:08:46','2022-09-10 10:08:46',NULL,'140.207.23.237','','',NULL,NULL,NULL,'yaml',NULL,'');
/*!40000 ALTER TABLE `config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_aggr`
--

DROP TABLE IF EXISTS `config_info_aggr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_info_aggr` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='增加租户字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_aggr`
--

LOCK TABLES `config_info_aggr` WRITE;
/*!40000 ALTER TABLE `config_info_aggr` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_aggr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_beta`
--

DROP TABLE IF EXISTS `config_info_beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_info_beta` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_beta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_beta`
--

LOCK TABLES `config_info_beta` WRITE;
/*!40000 ALTER TABLE `config_info_beta` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_beta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_tag`
--

DROP TABLE IF EXISTS `config_info_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_info_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_info_tag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_tag`
--

LOCK TABLES `config_info_tag` WRITE;
/*!40000 ALTER TABLE `config_info_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_tags_relation`
--

DROP TABLE IF EXISTS `config_tags_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_tags_relation` (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='config_tag_relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_tags_relation`
--

LOCK TABLES `config_tags_relation` WRITE;
/*!40000 ALTER TABLE `config_tags_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_tags_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_capacity`
--

DROP TABLE IF EXISTS `group_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='集群、各Group容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_capacity`
--

LOCK TABLES `group_capacity` WRITE;
/*!40000 ALTER TABLE `group_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `his_config_info`
--

DROP TABLE IF EXISTS `his_config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `his_config_info` (
  `id` bigint unsigned NOT NULL,
  `nid` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`nid`),
  KEY `idx_gmt_create` (`gmt_create`),
  KEY `idx_gmt_modified` (`gmt_modified`),
  KEY `idx_did` (`data_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='多租户改造';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `his_config_info`
--

LOCK TABLES `his_config_info` WRITE;
/*!40000 ALTER TABLE `his_config_info` DISABLE KEYS */;
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`) VALUES (1,15,'application.yaml','DEFAULT_GROUP','','#不校验token的接口\nauth:\n  white-urls: \n    - /center/student/grade2\n    - /center/druid/**\n    - /druid/**\nspring:\n  security: \n    user: \n      username: simple\n      password: simple\n  servlet:\n    multipart:\n      location: /Users/zhoupengyu/workspace/temp\n  # redis 相关\n  redis:\n    host: localhost\n    port: 6378\n    password: \n    database: 1\n# logging日志\nlogging:\n  level:\n    com.alibaba.nacos.client.config.impl: ERROR\n    root: info\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\nhystrix:\n  command:\n    default:\n      execution:\n        isolation:\n          strategy: SEMAPHORE\n          thread:\n            timeoutInMilliseconds: 20000\n  shareSecurityContext: true\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n# mybaits-plus配置\nmybatis-plus:\n  # MyBatis Mapper所对应的XML文件位置\n  mapper-locations: classpath:/mapper/*Mapper.xml\n  configuration:\n    #打印日志\n    log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n  global-config:\n    sql-parser-cache: true\n    # 关闭MP3.0自带的banner\n    banner: false\n    db-config:\n      # 主键类型\n      id-type: auto\n      select-strategy: not_empty','5829444e82c7f22cd9fee5e24aa1502c','2022-09-10 10:07:20','2022-09-10 10:07:20','nacos','140.207.23.237','U','',''),(2,16,'simple-route.yaml','DEFAULT_GROUP','','routes:\n- id: simple-grant\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /auth/**\n  filters:\n    - StripPrefix=1\n    - name: GrantFilter\n  uri: lb://simple-grant\n  order: 0\n- id: simple-center\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /center/**\n  filters:\n    - StripPrefix=1\n    - name: RequestRateLimiter\n      args: \n        key-resolver: \'#{@ipKeyResolver}\'\n        redis-rate-limiter.burstCapacity: 20\n        redis-rate-limiter.replenishRate: 20\n    - name: Hystrix\n      args: \n        fallbackUri: \'forward:/fallback\'\n        name: default\n  uri: lb://simple-center\n  order: 0\n- id: simple-code\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /gcode/**\n  filters:\n    - StripPrefix=1\n    - name: Hystrix\n      args: \n        fallbackUri: \'forward:/fallback\'\n        name: default\n  uri: lb://simple-code\n  order: 0\n- id: simple-plan\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /plan/**\n  filters:\n    - StripPrefix=1\n    - name: RequestRateLimiter\n      args: \n        key-resolver: \'#{@ipKeyResolver}\'\n        redis-rate-limiter.burstCapacity: 20\n        redis-rate-limiter.replenishRate: 20\n    - name: Hystrix\n      args: \n        fallbackUri: \'forward:/fallback\'\n        name: default\n  uri: lb://simple-plan\n  order: 0','f6170ead48def636218ca99db01307e9','2022-09-10 10:08:03','2022-09-10 10:08:03','nacos','140.207.23.237','U','',''),(0,17,'simple-job.yaml','DEFAULT_GROUP','','oauth2:\n  scope: ROLE_ADMIN\n#server.port=8080\nserver:\n  servlet:\n    context-path: /xxl-job-admin\n\n### actuator\nmanagement:\n  server:\n    servlet:\n      context-path: /actuator\n  health:\n    mail:\n      enabled: false\n\n### resources\nspring:\n  mvc:\n    servlet:\n      load-on-startup: 0\n    static-path-pattern: /static/**\n  resources:\n    static-locations: classpath:/static/\n  freemarker:\n    templateLoaderPath: classpath:/templates/\n    suffix: .ftl\n    charset: UTF-8\n    request-context-attribute: request\n    settings:\n      number_format: 0.##########\n  datasource:\n    url: jdbc:mysql://sh-cdb-8n8zfbbc.sql.tencentcdb.com:59296/simple_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai\n    username: root\n    password: \n    driver-class-name: com.mysql.cj.jdbc.Driver\n    type: com.zaxxer.hikari.HikariDataSource\n    hikari:\n      minimum-idle: 10\n      maximum-pool-size: 30\n      auto-commit: true\n      idle-timeout: 30000\n      pool-name: HikariCP\n      max-lifetime: 900000\n      connection-timeout: 10000\n      connection-test-query: SELECT 1\n      validation-timeout: 1000\n  mail:\n    host: smtp.qq.com\n    port: 25\n    username: xxx@qq.com\n    from: xxx@qq.com\n    password: xxx\n    properties.mail.smtp.auth: true\n    properties.mail.smtp.starttls.enable: true\n    properties.mail.smtp.starttls.required: true\n    properties.mail.smtp.socketFactory.class: javax.net.ssl.SSLSocketFactory\n### mybatis-plus\nmybatis-plus:\n  mapper-locations: classpath:/mybatis-mapper/*Mapper.xml\n  #configuration:\n  #  log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n#mybatis.type-aliases-package=com.xxl.job.admin.core.model\n\n### xxl-job, access token\nxxl:\n  job:\n    accessToken: 8WVT2qfjh3q3bNCX\n    i18n: zh_CN\n    triggerpool: \n      fast:\n        max: 200\n      slow:\n        max: 100\n    logretentiondays: 30\n','b18a3436b69ca2441d170d574a167498','2022-09-10 10:08:46','2022-09-10 10:08:46',NULL,'140.207.23.237','I','',''),(3,18,'simple-center.yaml','DEFAULT_GROUP','','oauth2:\n  scope: ROLE_ADMIN\n# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: \n      url: jdbc:mysql://sh-cdb-8n8zfbbc.sql.tencentcdb.com:59296/simple_center?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n      web-stat-filter: \n        enabled: true\n      stat-view-servlet:\n        enabled: true\n        # 设置白名单，不填则允许所有访问\n        allow: \"\"\n        deny: \"\"\n        url-pattern: /druid/*\n        # 控制台管理用户名和密码\n        login-username: admin\n        login-password: 123456\n      filter:\n        stat:\n            enabled: true\n            # 慢SQL记录\n            log-slow-sql: true\n            slow-sql-millis: 1000\n            merge-sql: true\n        wall:\n            config:\n                multi-statement-allow: true\n# Logger Config sql日志\nlogging:\n  level:\n    root: info     \n#seata分布式配置\n# seata:\n#   enabled: true\n#   #此处配置自定义的seata事务分组名称，和service.vgroupMapping.xxxx-seata-service-group对应\n#   tx-service-group: default-seata-service-group\n#   config:\n#     type: nacos\n#     nacos:\n#       application: seata-server\n#       server-addr: 127.0.0.1:8848\n#       group: \"SEATA_GROUP\"\n#       namespace: \"\"\n#       cluster: \"default\"\n#       username: \"nacos\"\n#       password: \"nacos\"\n#   registry:\n#     type: nacos\n#     nacos:\n#       application: seata-server\n#       server-addr: 127.0.0.1:8848\n#       group: \"SEATA_GROUP\"\n#       namespace: \"\"\n#       cluster: \"default\"\n#       username: \"nacos\"\n#       password: \"nacos\"','1a99358f81b50caedd2e90fd8f572c43','2022-09-10 10:11:05','2022-09-10 10:11:06','nacos','140.207.23.237','U','','');
/*!40000 ALTER TABLE `his_config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `role` varchar(50) NOT NULL,
  `resource` varchar(255) NOT NULL,
  `action` varchar(8) NOT NULL,
  UNIQUE KEY `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `username` varchar(50) NOT NULL,
  `role` varchar(50) NOT NULL,
  UNIQUE KEY `idx_user_role` (`username`,`role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`username`, `role`) VALUES ('nacos','ROLE_ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_capacity`
--

DROP TABLE IF EXISTS `tenant_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenant_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='租户容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_capacity`
--

LOCK TABLES `tenant_capacity` WRITE;
/*!40000 ALTER TABLE `tenant_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_info`
--

DROP TABLE IF EXISTS `tenant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tenant_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='tenant_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_info`
--

LOCK TABLES `tenant_info` WRITE;
/*!40000 ALTER TABLE `tenant_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`username`, `password`, `enabled`) VALUES ('nacos','$2a$10$FKcfNOyGra.vtLEA3yobm.b3be.jxDXzdDVkpicAo3zqHs2yCLvuK',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-22  9:34:43

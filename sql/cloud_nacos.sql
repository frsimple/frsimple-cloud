 
-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  `encrypted_data_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_info' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'application.yaml', 'DEFAULT_GROUP', '#不校验token的接口\nauth:\n  white-urls: \n    - /center/student/grade2\n    - /center/druid/**\n    - /druid/**\n    - /job/xxl-job-admin/**\n    - /xxl-job-admin/**\n    - /job/**\nspring:\n  security: \n    user: \n      username: simple\n      password: simple\n  servlet:\n    multipart:\n      location: /Users/zhoupengyu/workspace/temp\n  # redis 相关\n  redis:\n    host: localhost\n    port: 6378\n    password: MilPNMEuzbN3orAe\n    database: 1\n# logging日志\nlogging:\n  level:\n    com.alibaba.nacos.client.config.impl: ERROR\n    root: info\n# feign 配置\nfeign:\n  hystrix:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n  compression:\n    request:\n      enabled: true\n    response:\n      enabled: true\nhystrix:\n  command:\n    default:\n      execution:\n        isolation:\n          strategy: SEMAPHORE\n          thread:\n            timeoutInMilliseconds: 20000\n  shareSecurityContext: true\n#请求处理的超时时间\nribbon:\n  ReadTimeout: 10000\n  ConnectTimeout: 10000\n# mybaits-plus配置\nmybatis-plus:\n  # MyBatis Mapper所对应的XML文件位置\n  mapper-locations: classpath:/mapper/*Mapper.xml\n  global-config:\n    sql-parser-cache: true\n    # 关闭MP3.0自带的banner\n    banner: false\n    db-config:\n      # 主键类型\n      id-type: auto\n      select-strategy: not_empty', '95125dd24355dee26a22f185ca086afa', '2022-06-26 07:16:04', '2022-09-10 10:07:20', 'nacos', '140.207.23.237', '', '', '主配置文件', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (2, 'simple-route.yaml', 'DEFAULT_GROUP', 'routes:\n- id: simple-grant\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /auth/**\n  filters:\n    - StripPrefix=1\n    - name: GrantFilter\n  uri: lb://simple-grant\n  order: 0\n- id: simple-center\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /center/**\n  filters:\n    - StripPrefix=1\n    - name: RequestRateLimiter\n      args: \n        key-resolver: \'#{@ipKeyResolver}\'\n        redis-rate-limiter.burstCapacity: 20\n        redis-rate-limiter.replenishRate: 20\n    - name: Hystrix\n      args: \n        fallbackUri: \'forward:/fallback\'\n        name: default\n  uri: lb://simple-center\n  order: 0\n- id: simple-code\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /gcode/**\n  filters:\n    - StripPrefix=1\n    - name: Hystrix\n      args: \n        fallbackUri: \'forward:/fallback\'\n        name: default\n  uri: lb://simple-code\n  order: 0\n- id: simple-plan\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /plan/**\n  filters:\n    - StripPrefix=1\n    - name: RequestRateLimiter\n      args: \n        key-resolver: \'#{@ipKeyResolver}\'\n        redis-rate-limiter.burstCapacity: 20\n        redis-rate-limiter.replenishRate: 20\n    - name: Hystrix\n      args: \n        fallbackUri: \'forward:/fallback\'\n        name: default\n  uri: lb://simple-plan\n  order: 0\n#xxl-job配置\n- id: simple-job\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /job/**\n  filters:\n    - StripPrefix=1\n  uri: lb://simple-job\n  order: 0\n- id: xxl-job-admin\n  predicates:\n  - name: Path\n    args: \n      _genkey_0: /xxl-job-admin/**\n  filters:\n    - StripPrefix=1\n  uri: lb://simple-job\n  order: 0', '9fb46f0a60d4e097863a89a3bcd64027', '2022-06-26 07:16:26', '2022-09-10 10:08:03', 'nacos', '140.207.23.237', '', '', '动态路由', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (3, 'simple-center.yaml', 'DEFAULT_GROUP', 'oauth2:\n  scope: ROLE_ADMIN\n# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://localhost:3306/cloud_center?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n      web-stat-filter: \n        enabled: true\n      stat-view-servlet:\n        enabled: true\n        # 设置白名单，不填则允许所有访问\n        allow: \"\"\n        deny: \"\"\n        url-pattern: /druid/*\n        # 控制台管理用户名和密码\n        login-username: admin\n        login-password: 123456\n      filter:\n        stat:\n            enabled: true\n            # 慢SQL记录\n            log-slow-sql: true\n            slow-sql-millis: 1000\n            merge-sql: true\n        wall:\n            config:\n                multi-statement-allow: true\n# Logger Config sql日志\nlogging:\n  level:\n    root: info     \nxxl: \n  job:\n    admin: \n      addresses: http://localhost:1100/xxl-job-admin\n    accessToken: 8WVT2qfjh3q3bNCX\n    executor:\n      appname: xxl-job-center\n      address: \n      ip: \n      port: 0\n      logpath: /home/logs\n      logretentiondays: 30\n#seata分布式配置\n# seata:\n#   enabled: true\n#   #此处配置自定义的seata事务分组名称，和service.vgroupMapping.xxxx-seata-service-group对应\n#   tx-service-group: default-seata-service-group\n#   config:\n#     type: nacos\n#     nacos:\n#       application: seata-server\n#       server-addr: 127.0.0.1:8848\n#       group: \"SEATA_GROUP\"\n#       namespace: \"\"\n#       cluster: \"default\"\n#       username: \"nacos\"\n#       password: \"nacos\"\n#   registry:\n#     type: nacos\n#     nacos:\n#       application: seata-server\n#       server-addr: 127.0.0.1:8848\n#       group: \"SEATA_GROUP\"\n#       namespace: \"\"\n#       cluster: \"default\"\n#       username: \"nacos\"\n#       password: \"nacos\"', 'e0f01a2634c89ea29bdfaa0dcfc55e11', '2022-06-26 07:17:00', '2022-12-08 20:22:53', 'nacos', '101.87.139.32', '', '', '中台系统', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (4, 'simple-grant.yaml', 'DEFAULT_GROUP', '# 数据源\nspring:\n  main: \n    allow-bean-definition-overriding: true\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://localhost:3306/cloud_center?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n  freemarker:\n    allow-request-override: false\n    allow-session-override: false\n    cache: true\n    charset: UTF-8\n    check-template-location: true\n    content-type: text/html\n    enabled: true\n    expose-request-attributes: false\n    expose-session-attributes: false\n    expose-spring-macro-helpers: true\n    prefer-file-system-access: true\n', '0c5df5f1788e5f90b773acd1dc8db0b2', '2022-06-26 07:17:20', '2022-12-08 20:22:03', 'nacos', '101.87.139.32', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (5, 'simple-plan.yaml', 'DEFAULT_GROUP', 'oauth2:\n  scope: ROLE_ADMIN\n# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://localhost:3306/cloud_center?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n# Logger Config sql日志\nlogging:\n  level:\n    root: info ', '1249a6cf699341d7d9b855f59c7858ab', '2022-06-26 07:17:53', '2022-12-08 20:23:08', 'nacos', '101.87.139.32', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (14, 'simple-code.yaml', 'DEFAULT_GROUP', 'oauth2:\n  scope: ROLE_ADMIN\n# 数据源\nspring:\n  datasource:\n    type: com.alibaba.druid.pool.DruidDataSource\n    druid:\n      driver-class-name: com.mysql.cj.jdbc.Driver\n      username: root\n      password: 123456\n      url: jdbc:mysql://localhost:3306/cloud_center?characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=false&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=GMT%2B8&allowMultiQueries=true&allowPublicKeyRetrieval=true\n# Logger Config sql日志\nlogging:\n  level:\n    root: info ', '1249a6cf699341d7d9b855f59c7858ab', '2022-08-06 10:53:28', '2022-12-08 20:23:18', 'nacos', '101.87.139.32', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (17, 'simple-job.yaml', 'DEFAULT_GROUP', 'oauth2:\n  scope: ROLE_ADMIN\n#server.port=8080\nserver:\n  servlet:\n    context-path: /xxl-job-admin\n\n### actuator\nmanagement:\n  server:\n    servlet:\n      context-path: /actuator\n  health:\n    mail:\n      enabled: false\n\n### resources\nspring:\n  mvc:\n    servlet:\n      load-on-startup: 0\n    static-path-pattern: /static/**\n  resources:\n    static-locations: classpath:/static/\n  freemarker:\n    templateLoaderPath: classpath:/templates/\n    suffix: .ftl\n    charset: UTF-8\n    request-context-attribute: request\n    settings:\n      number_format: 0.##########\n  datasource:\n    url: jdbc:mysql://localhost:3306/cloud_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai\n    username: root\n    password: 123456\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    type: com.zaxxer.hikari.HikariDataSource\n    hikari:\n      minimum-idle: 10\n      maximum-pool-size: 30\n      auto-commit: true\n      idle-timeout: 30000\n      pool-name: HikariCP\n      max-lifetime: 900000\n      connection-timeout: 10000\n      connection-test-query: SELECT 1\n      validation-timeout: 1000\n  mail:\n    host: smtp.qq.com\n    port: 25\n    username: xxx@qq.com\n    from: xxx@qq.com\n    password: xxx\n    properties.mail.smtp.auth: true\n    properties.mail.smtp.starttls.enable: true\n    properties.mail.smtp.starttls.required: true\n    properties.mail.smtp.socketFactory.class: javax.net.ssl.SSLSocketFactory\n### mybatis-plus\nmybatis-plus:\n  mapper-locations: classpath:/mybatis-mapper/*Mapper.xml\n  #configuration:\n  #  log-impl: org.apache.ibatis.logging.stdout.StdOutImpl\n#mybatis.type-aliases-package=com.xxl.job.admin.core.model\n\n### xxl-job, access token\nxxl:\n  job:\n    accessToken: 8WVT2qfjh3q3bNCX\n    i18n: zh_CN\n    triggerpool: \n      fast:\n        max: 200\n      slow:\n        max: 100\n    logretentiondays: 30\n', '7c383b111a13344704738fc27ebb178c', '2022-09-10 10:08:46', '2022-12-08 20:23:44', 'nacos', '101.87.139.32', '', '', '', '', '', 'yaml', '', '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC, `datum_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '增加租户字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_info_beta' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id` ASC, `group_id` ASC, `tenant_id` ASC, `tag_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_info_tag' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id` ASC, `tag_name` ASC, `tag_type` ASC) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'config_tag_relation' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint UNSIGNED NOT NULL,
  `nid` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL,
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create` ASC) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified` ASC) USING BTREE,
  INDEX `idx_did`(`data_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '多租户改造' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role` ASC, `resource` ASC, `action` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username` ASC, `role` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = '租户容量信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp` ASC, `tenant_id` ASC) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_bin COMMENT = 'tenant_info' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$FKcfNOyGra.vtLEA3yobm.b3be.jxDXzdDVkpicAo3zqHs2yCLvuK', 1);
INSERT INTO `users` VALUES ('nacos_admin', '$2a$10$g/1eydwWDuI/FsZS12NnGu9mJne5KY3fgvy/z28WORzeP56yrFUEi', 1);
INSERT INTO `users` VALUES ('pmonrtce', '$2a$10$rRxdP6Rt5pYHr2l6ip3O8ORUlW9emOqRWMeSFQ52FpCZlIE3I40SO', 1);
INSERT INTO `users` VALUES ('t1Es4T', '$2a$10$ep8J0XOv4psZ2MaBT8Q4w.Qb7.Tn4r25RvIeY44897MvrWreqQ1aO', 1);

SET FOREIGN_KEY_CHECKS = 1;

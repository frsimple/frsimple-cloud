#### [企业级中后台解决方案 pro版本演示地址](https://pro.frsimple.cn)

#### [SpringBoot 单体服务中后台解决方案传送门](https://gitee.com/frsimple/springboot)

#### 官网地址

[官网地址](http://frsimple.cn)

#### 前端源码地址

[vue3](https://gitee.com/frsimple/view)


#### frimsple中后台框架交流微信群 **_(获取初始化脚本)_** 



<div style="width:120px;text-align:center;" >扫码进入微信交流群</div>

![](https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/wx.jpg)

<div style="width:120px;text-align:center;" >扫码进入QQ交流群</div>

![](https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/qq.jpg)



#### 系统截图

<table>
    <tr>
        <td><img src="https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/v1.png"/></td>
        <td><img src="https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/v2.png"/></td>
    </tr>
    <tr>
        <td><img src="https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/v3.png"/></td>
        <td><img src="https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/v4.png"/></td>
    </tr>
    <tr>
        <td><img src="https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/v5.png"/></td> 
    </tr> 
</table>
 


#### 演示地址

[vue3版本](http://vue.frsimple.cn)

#### 软件架构


基础框架：SpringBoot 2| Spring Gateway | Spring Cloud Alibaba | Feign

授权认证：Spring Security Oauth2.0 (支持自定义手机验证码登录)

配置/注册中心: nacos

熔断：Hystrix

限流：Gateway令牌桶

分布式事务：Seata

高可用缓存：Redis

持久层：MyBatis Plus （支持动态数据源）

数据库连接池：Alibaba.druid

文件存储：阿里oss ｜ 腾讯cos ｜ minio

短信服务： 阿里云 ｜ 腾讯云

邮件服务： hutool工具类-MailUtil


#### 开发部署

开发工具：idea  
数据库版本： mysql8.0 
redis版本： 5.0.14
nacos版本： 2.x.x 


- 启动redis

 ![输入图片说明](https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/3271658990350_.pic.jpg)

- 启动nacos（需要修改数据库连接的配置文件）

 ![输入图片说明](https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/3281658990468_.pic.jpg)

- 下载并且解压缩代码，打开idea导出 

![输入图片说明](https://pengpengyu-test.oss-cn-zhangjiakou.aliyuncs.com/image/3261658990023_.pic.jpg)

- 启动服务 

  依次启动服务 
  RouteApp,GrantApp,CenterApp


#### 目录结构
```shell
│
├─ simple-base     //框架基础模块
│ │ ├─ simple-cache        //redis缓存
│ │ ├─ simple-common       //公共模块(短信发送，邮件发送，文件存储工具类等)
│ │ ├─ simple-datasource   //mybatis-plus持久层，数据池，动态数据源
│ │ ├─ simple-security     //spring security公共模块(所有微服务必须依赖)
│ │ ├─ simple-xxljob     //分布式任务调度(要用到任务调度的必须依赖)
│
├─ simple-center   //中台服务模块
│
├─ simple-grant    //oauth2.0授权认证模块 
│
├─ simple-route    //gateway网关模块 
│
├─ simple-plan     //二次开发demo模块
│
├─ simple-code     //代码生成模块
│
├─ simple-job     //分布式任务调度
│
```
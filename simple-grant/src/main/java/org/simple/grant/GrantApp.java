package org.simple.grant;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringCloudApplication
@EnableFeignClients
public class GrantApp {
    public static void main(String[] args) {
        SpringApplication.run(GrantApp.class, args);
    }
}

package org.simple.center;

import org.simple.security.annotation.SimpleAnnotation;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

@SpringCloudApplication
@SimpleAnnotation
public class CenterApp {
    public static void main(String[] args) {
        SpringApplication.run(CenterApp.class, args);
    }
}

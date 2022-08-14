package org.simple.code;


import org.simple.security.annotation.SimpleAnnotation;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

@SpringCloudApplication
@SimpleAnnotation
public class CodeApp {
    public static void main(String[] args) {
        SpringApplication.run(CodeApp.class, args);
    }
}

package org.simple.plan;


import org.simple.security.annotation.SimpleAnnotation;
import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

@SpringCloudApplication
@SimpleAnnotation
public class PlanApp {
    public static void main(String[] args) {
        SpringApplication.run(PlanApp.class, args);
    }
}

package org.simple.route;

import org.springframework.boot.SpringApplication;
import org.springframework.cloud.client.SpringCloudApplication;

@SpringCloudApplication
public class RouteApp {
    public static void main(String[] args) {
        SpringApplication.run(RouteApp.class, args);
    }
}

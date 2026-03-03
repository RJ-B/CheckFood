package com.checkfood.checkfoodservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients; // Nutný import
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableAsync
@EnableFeignClients
@EnableScheduling
public class CheckfoodServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(CheckfoodServiceApplication.class, args);
    }

}
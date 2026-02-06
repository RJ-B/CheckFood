package com.checkfood.checkfoodservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync // <-- PŘIDAT TOTO
public class CheckfoodServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(CheckfoodServiceApplication.class, args);
    }

}

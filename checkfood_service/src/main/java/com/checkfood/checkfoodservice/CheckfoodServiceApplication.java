package com.checkfood.checkfoodservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Vstupní bod aplikace CheckFood backend service.
 * Zapíná asynchronní zpracování, Feign klienty a plánované úlohy.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@SpringBootApplication
@EnableAsync
@EnableFeignClients
@EnableScheduling
public class CheckfoodServiceApplication {

    /**
     * Spustí Spring Boot aplikaci.
     *
     * @param args argumenty příkazové řádky
     */
    public static void main(String[] args) {
        SpringApplication.run(CheckfoodServiceApplication.class, args);
    }

}
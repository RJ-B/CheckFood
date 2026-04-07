package com.checkfood.checkfoodservice.listener.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;

/**
 * Konfigurace listener subsystému.
 * Zapíná asynchronní zpracování událostí, čímž odděluje listener execution od scheduler a request vláken.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
@EnableAsync
public class ListenerConfig {

    // TODO: definovat vlastní Executor pro listenery (ThreadPoolTaskExecutor), nastavit velikost poolu
}

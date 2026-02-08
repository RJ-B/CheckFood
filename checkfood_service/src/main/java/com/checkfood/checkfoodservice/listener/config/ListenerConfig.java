package com.checkfood.checkfoodservice.listener.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;

/**
 * Konfigurace listener subsystému.
 *
 * - zapíná async zpracování eventů
 * - odděluje listener execution od scheduleru a request threadů
 */
@Configuration
@EnableAsync
public class ListenerConfig {

    // TODO:
    // - definovat vlastní Executor pro listenery (ThreadPoolTaskExecutor)
    // - nastavit velikost poolu podle profilu
}

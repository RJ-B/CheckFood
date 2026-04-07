package com.checkfood.checkfoodservice.scheduler.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Centrální konfigurace scheduleru.
 * Zapíná plánované úlohy a poskytuje globální nastavení scheduleru. Neobsahuje business logiku.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
@EnableScheduling
public class SchedulerConfig {

    // TODO: task executor konfigurace, thread pool sizing
}

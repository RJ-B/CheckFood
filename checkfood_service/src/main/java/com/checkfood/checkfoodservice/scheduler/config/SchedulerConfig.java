package com.checkfood.checkfoodservice.scheduler.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Centrální konfigurace scheduleru.
 *
 * Zodpovědnosti:
 * - zapnutí plánovaných úloh
 * - globální nastavení scheduleru
 *
 *   Neobsahuje business logiku
 */
@Configuration
@EnableScheduling
public class SchedulerConfig {

    // TODO:
    // - task executor konfigurace
    // - thread pool sizing
}

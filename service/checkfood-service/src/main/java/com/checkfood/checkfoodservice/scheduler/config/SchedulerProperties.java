package com.checkfood.checkfoodservice.scheduler.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurační vlastnosti scheduleru.
 *
 * Mapováno z application-*.properties.
 */
@ConfigurationProperties(prefix = "scheduler")
public class SchedulerProperties {

    /**
     * Globální zapnutí scheduleru.
     */
    private boolean enabled = true;

    // TODO:
    // - cron výrazy
    // - lock timeouty

    // getters / setters
}

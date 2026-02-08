package com.checkfood.checkfoodservice.monitoring.health;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;

/**
 * Health indicator databáze.
 *
 * Sleduje:
 * - dostupnost DB
 * - schopnost vykonat jednoduchý dotaz
 */
public class DatabaseHealthIndicator implements HealthIndicator {

    @Override
    public Health health() {
        // TODO:
        // - jednoduchý DB check
        return Health.up().build();
    }
}

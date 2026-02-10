package com.checkfood.checkfoodservice.monitoring.health;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;

/**
 * Health indicator aplikace jako celku.
 *
 * Sleduje:
 * - základní dostupnost aplikace
 * - klíčové interní subsystémy
 */
public class ApplicationHealthIndicator implements HealthIndicator {

    @Override
    public Health health() {
        // TODO:
        // - základní stav aplikace
        return Health.up().build();
    }
}

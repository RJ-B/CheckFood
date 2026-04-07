package com.checkfood.checkfoodservice.monitoring.health;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;

/**
 * Health indicator sledující základní dostupnost aplikace a klíčových interních subsystémů.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class ApplicationHealthIndicator implements HealthIndicator {

    /**
     * Vrátí aktuální stav zdraví aplikace.
     *
     * @return stav zdraví aplikace
     */
    @Override
    public Health health() {
        // TODO: základní stav aplikace
        return Health.up().build();
    }
}

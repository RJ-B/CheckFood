package com.checkfood.checkfoodservice.monitoring.health;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;

/**
 * Health indicator sledující dostupnost databáze a schopnost vykonat jednoduchý dotaz.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class DatabaseHealthIndicator implements HealthIndicator {

    /**
     * Vrátí aktuální stav zdraví databáze.
     *
     * @return stav zdraví databáze
     */
    @Override
    public Health health() {
        // TODO: jednoduchý DB check
        return Health.up().build();
    }
}

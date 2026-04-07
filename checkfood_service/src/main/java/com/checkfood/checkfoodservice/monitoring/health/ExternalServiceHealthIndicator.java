package com.checkfood.checkfoodservice.monitoring.health;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;

/**
 * Health indicator sledující dostupnost externích služeb (platební brána, e-mail).
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
public class ExternalServiceHealthIndicator implements HealthIndicator {

    /**
     * Vrátí aktuální stav zdraví externích služeb.
     *
     * @return stav zdraví externích služeb
     */
    @Override
    public Health health() {
        // TODO: ping externích systémů
        return Health.unknown().build();
    }
}

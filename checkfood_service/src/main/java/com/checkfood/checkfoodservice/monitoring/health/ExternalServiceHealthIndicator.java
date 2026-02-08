package com.checkfood.checkfoodservice.monitoring.health;

import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;

/**
 * Health indicator externích služeb
 * (např. platební brána, e-mail).
 */
public class ExternalServiceHealthIndicator implements HealthIndicator {

    @Override
    public Health health() {
        // TODO:
        // - ping externích systémů
        return Health.unknown().build();
    }
}

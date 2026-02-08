package com.checkfood.checkfoodservice.monitoring.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace Spring Boot Actuatoru.
 *
 * Tato třída:
 * - centralizuje konfiguraci actuator endpointů
 * - odděluje observability od business logiky
 * - slouží jako vstupní bod pro rozšíření (security, custom endpoints)
 *
 * ❌ Neobsahuje aplikační ani business logiku
 * ❌ Neřeší autentizaci (to je v security)
 */
@Configuration
public class ActuatorConfig {

    // TODO:
    // - případné custom HealthIndicator registry
    // - custom InfoContributor
    // - groupování health endpointů
}

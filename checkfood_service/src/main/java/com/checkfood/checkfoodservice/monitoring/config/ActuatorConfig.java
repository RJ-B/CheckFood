package com.checkfood.checkfoodservice.monitoring.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace Spring Boot Actuatoru.
 * Centralizuje konfiguraci actuator endpointů a slouží jako vstupní bod pro rozšíření
 * (security, custom endpoints). Neobsahuje aplikační ani business logiku.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
public class ActuatorConfig {

    // TODO: custom HealthIndicator registry, custom InfoContributor, groupování health endpointů
}

package com.checkfood.checkfoodservice.monitoring.config;

import org.springframework.context.annotation.Configuration;

/**
 * Centrální konfigurace monitoringu aplikace.
 * Slouží jako místo pro společné monitoring beany a řídí zapnutí nebo vypnutí monitorovacích komponent.
 * Neobsahuje business logiku ani aplikační chování.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
public class MonitoringConfig {

    // TODO: Micrometer registry konfigurace, conditional beans podle profilu
}

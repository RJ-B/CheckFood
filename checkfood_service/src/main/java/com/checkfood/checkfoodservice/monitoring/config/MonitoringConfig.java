package com.checkfood.checkfoodservice.monitoring.config;

import org.springframework.context.annotation.Configuration;

/**
 * Centrální konfigurace monitoringu aplikace.
 *
 * Slouží jako:
 * - zapnutí / vypnutí monitorovacích komponent
 * - místo pro společné monitoring beany
 *
 * ❌ Neobsahuje business logiku
 * ❌ Neobsahuje aplikační chování
 */
@Configuration
public class MonitoringConfig {

    // TODO:
    // - Micrometer registry konfigurace
    // - conditional beans podle profilu
}

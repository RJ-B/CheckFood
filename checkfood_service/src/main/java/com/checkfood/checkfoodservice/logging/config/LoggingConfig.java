package com.checkfood.checkfoodservice.logging.config;

import org.springframework.context.annotation.Configuration;

/**
 * Hlavní konfigurace logging subsystému.
 *
 * Řeší:
 * - zapnutí jednotlivých logging komponent
 * - propojení MDC, filtrů a aspektů
 *
 *   Neřeší konkrétní logování dat
 */
@Configuration
public class LoggingConfig {

    // TODO:
    // - podmíněné zapnutí aspektů
    // - napojení na properties
}

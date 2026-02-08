package com.checkfood.checkfoodservice.client.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace retry mechanismů pro externí systémy.
 *
 * Řeší:
 * - opakování volání při timeoutu
 * - fallback strategie
 *
 * Service vrstva nikdy neřeší retry přímo.
 */
@Configuration
public class RetryClientConfig {

    // TODO:
    // - Spring Retry / Resilience4j
    // - retry policy podle typu klienta
}

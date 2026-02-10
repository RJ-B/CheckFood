package com.checkfood.checkfoodservice.logging.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace MDC (Mapped Diagnostic Context).
 *
 * MDC umožňuje:
 * - přidávat kontext (userId, traceId)
 * - automaticky ho mít v každém logu
 */
@Configuration
public class MdcConfig {

    // TODO:
    // - definice MDC klíčů
}

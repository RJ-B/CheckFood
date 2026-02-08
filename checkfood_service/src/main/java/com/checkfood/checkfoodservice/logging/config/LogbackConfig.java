package com.checkfood.checkfoodservice.logging.config;

import org.springframework.context.annotation.Configuration;

/**
 * Technická konfigurace Logbacku.
 *
 * Slouží jako:
 * - programová konfigurace (pokud se nepoužije XML)
 * - místo pro rozšíření logback chování
 *
 * Většinou doplněk k logback-spring.xml.
 */
@Configuration
public class LogbackConfig {

    // TODO:
    // - custom appendery
    // - async logging
}

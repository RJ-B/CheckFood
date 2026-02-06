package com.checkfood.checkfoodservice.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace persistence vrstvy (JPA / Hibernate).
 *
 * Řeší:
 * - technické chování ORM
 * - auditní timestampy
 * - naming strategy
 *
 *   Neobsahuje repository
 *   Neobsahuje query
 */

@Configuration
public class PersistenceConfig {

    // TODO:
    // - @EnableJpaAuditing
    // - custom converters
}

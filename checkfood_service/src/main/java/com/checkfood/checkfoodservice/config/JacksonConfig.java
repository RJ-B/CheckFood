package com.checkfood.checkfoodservice.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace JSON serializace a deserializace.
 *
 * Řeší:
 * - formát dat
 * - serializaci Java Time API
 * - chování při neznámých polích
 *
 * Používá se globálně pro:
 * - REST API
 * - exception responses
 */
@Configuration
public class JacksonConfig {

    // TODO:
    // - ObjectMapper bean
    // - JavaTimeModule
    // - enum serializace
}

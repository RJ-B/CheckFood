package com.checkfood.checkfoodservice.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace validačního subsystému.
 *
 * Řeší:
 * - Bean Validation (JSR 380)
 * - validační message source
 * - validační skupiny
 *
 * Validace se aplikuje zejména na DTO.
 */
@Configuration
public class ValidationConfig {

    // TODO:
    // - LocalValidatorFactoryBean
    // - MessageSource pro validační zprávy
}

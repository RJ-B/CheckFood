package com.checkfood.checkfoodservice.feature.config;

import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace feature-flag subsystému.
 *
 * Tato třída:
 * - zapíná feature management v aplikaci
 * - registruje resolvery feature flagů
 *
 *   Neobsahuje business logiku
 *   Neobsahuje rozhodování o chování aplikace
 */
@Configuration
public class FeatureConfig {

    // TODO:
    // - registrace dostupných FeatureResolver implementací
    // - případné priority resolverů
}

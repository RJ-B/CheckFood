package com.checkfood.checkfoodservice.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

/**
 * Konfigurace závislá na běhovém profilu aplikace.
 *
 * Řeší rozdíly mezi:
 * - local
 * - test
 * - prod
 *
 * Používá se k:
 * - zapínání / vypínání subsystémů
 * - přepínání implementací
 */
@Configuration
public class ProfileConfig {

    // TODO:
    // - @Profile("local") beany
    // - @Profile("test") beany
    // - @Profile("prod") beany
}

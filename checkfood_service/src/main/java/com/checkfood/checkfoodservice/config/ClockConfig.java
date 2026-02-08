package com.checkfood.checkfoodservice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.Clock;

/**
 * Poskytuje centrální instanci Clock.
 *
 * Díky této konfiguraci:
 * - je čas testovatelný
 * - lze simulovat čas v testech
 * - sjednocuje se práce s časem napříč aplikací
 *
 * Velmi důležité pro:
 * - audit
 * - scheduler
 * - business logiku
 */
@Configuration
public class ClockConfig {

    @Bean
    public Clock clock() {
        return Clock.systemUTC();
    }
}

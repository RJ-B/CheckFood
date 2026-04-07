package com.checkfood.checkfoodservice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import java.time.Clock;
import java.time.ZoneId;

/**
 * Konfigurace systémových hodin aplikace pro časové zóně Europe/Prague.
 * Poskytuje testovatelný Clock bean místo přímého volání {@code Clock.systemDefaultZone()}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
public class ClockConfig {

    /**
     * Vytvoří Clock bean nastavený na časovou zónu Europe/Prague.
     *
     * @return systémové hodiny pro zónu Europe/Prague
     */
    @Bean
    public Clock clock() {
        return Clock.system(ZoneId.of("Europe/Prague"));
    }
}
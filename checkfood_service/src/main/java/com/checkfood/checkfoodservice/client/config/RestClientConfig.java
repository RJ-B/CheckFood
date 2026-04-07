package com.checkfood.checkfoodservice.client.config;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

import java.time.Duration;

/**
 * Konfigurace REST klientů používaných pro komunikaci s externími systémy.
 * Definuje společné technické nastavení REST komunikace bez business logiky.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
public class RestClientConfig {

    /**
     * Vytvoří RestTemplate s časovými limity pro připojení a čtení.
     *
     * @param builder builder pro konfiguraci RestTemplate
     * @return nakonfigurovaný RestTemplate
     */
    @Bean
    public RestTemplate restTemplate(RestTemplateBuilder builder) {
        return builder
                .connectTimeout(Duration.ofSeconds(5))
                .readTimeout(Duration.ofSeconds(15))
                .build();
    }
}

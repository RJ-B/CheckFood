package com.checkfood.checkfoodservice.security.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.List;

/**
 * Centralizovaná konfigurace Cross-Origin Resource Sharing (CORS) pro REST API.
 * Implementuje origin whitelisting načítaný z konfigurace a nastavuje povolené metody, headers a credentials.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see CorsConfiguration
 * @see CorsConfigurationSource
 */
@Configuration
public class CorsConfig {

    /**
     * Povolené CORS origins načítané z application.properties.
     * V produkci musí být přepsány HTTPS doménami aplikace.
     */
    @org.springframework.beans.factory.annotation.Value("${cors.allowed-origins:http://localhost:3000,http://127.0.0.1:3000,http://192.168.1.199:8081,http://192.168.1.199}")
    private String allowedOrigins;

    /**
     * Definuje CORS konfigurační bean aplikovaný na všechny endpointy.
     *
     * @return nakonfigurovaný CorsConfigurationSource bean
     */
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration config = new CorsConfiguration();

        config.setAllowedOrigins(List.of(allowedOrigins.split(",")));
        config.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "DELETE", "PATCH", "OPTIONS"));
        config.setAllowedHeaders(Arrays.asList(
                "Authorization",
                "Content-Type",
                "X-Requested-With",
                "Accept",
                "Origin"
        ));
        config.setExposedHeaders(List.of("Authorization"));
        config.setAllowCredentials(true);
        config.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", config);

        return source;
    }
}
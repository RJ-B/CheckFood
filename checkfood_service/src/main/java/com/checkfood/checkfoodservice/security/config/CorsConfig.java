package com.checkfood.checkfoodservice.security.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;

import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

/**
 * Konfigurace CORS (Cross-Origin Resource Sharing) pro API.
 * Definuje povolené originy, HTTP metody a hlavičky pro cross-origin požadavky.
 * V produkčním prostředí by měly být originy načítány z konfigurace.
 */
@Configuration
public class CorsConfig {

    /**
     * Vytvoří a nakonfiguruje CORS pravidla pro všechny endpointy.
     * Povoluje požadavky z definovaných originů s credentials a cachuje preflight požadavky.
     *
     * @return nakonfigurovaný CORS configuration source
     */
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {

        CorsConfiguration config =
                new CorsConfiguration();

        config.setAllowedOrigins(
                List.of(
                        "http://localhost:3000",
                        "http://localhost:4200",
                        "http://localhost:8080"
                )
        );

        config.setAllowedMethods(
                List.of(
                        "GET",
                        "POST",
                        "PUT",
                        "DELETE",
                        "PATCH",
                        "OPTIONS"
                )
        );

        config.setAllowedHeaders(
                List.of("*")
        );

        config.setAllowCredentials(true);

        config.setMaxAge(3600L);

        UrlBasedCorsConfigurationSource source =
                new UrlBasedCorsConfigurationSource();

        source.registerCorsConfiguration(
                "/**",
                config
        );

        return source;
    }
}
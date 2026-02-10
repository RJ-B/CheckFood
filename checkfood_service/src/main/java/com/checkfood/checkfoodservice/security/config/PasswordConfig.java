package com.checkfood.checkfoodservice.security.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Konfigurace password encoderu pro bezpečné hashování hesel.
 * Používá BCrypt algoritmus se silou 12 pro ochranu uživatelských hesel v databázi.
 */
@Configuration
public class PasswordConfig {

    /**
     * Vytvoří BCrypt password encoder pro hashování a validaci hesel.
     * Síla 12 představuje dobrý kompromis mezi bezpečností a výkonem.
     *
     * @return nakonfigurovaný password encoder
     */
    @Bean
    public PasswordEncoder passwordEncoder() {

        return new BCryptPasswordEncoder(12);
    }
}
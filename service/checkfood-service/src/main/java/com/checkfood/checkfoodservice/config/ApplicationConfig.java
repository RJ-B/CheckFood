package com.checkfood.checkfoodservice.config;

import com.checkfood.checkfoodservice.security.user.repository.UserRepository;

import lombok.RequiredArgsConstructor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Hlavní aplikační konfigurace.
 * Propojuje Spring Security s databází uživatelů.
 */
@Configuration
@RequiredArgsConstructor
public class ApplicationConfig {

    private final UserRepository userRepository;

    /**
     * Definuje, jak se hledají uživatelé v DB.
     * Toto je klíčové pro Login!
     */
    @Bean
    public UserDetailsService userDetailsService() {
        return username -> userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }

    /**
     * Propojuje UserDetailsService a PasswordEncoder.
     * Řeší ověření hesla.
     */
    @Bean
    public AuthenticationProvider authenticationProvider(PasswordEncoder passwordEncoder) {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();

        // Nastavíme, jak získat uživatele (z DB)
        authProvider.setUserDetailsService(userDetailsService());

        // Nastavíme, jak ověřit heslo (BCrypt)
        authProvider.setPasswordEncoder(passwordEncoder);

        return authProvider;
    }

}
package com.checkfood.checkfoodservice.security.config;

import com.checkfood.checkfoodservice.security.module.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Konfigurace základních bezpečnostních komponent.
 * Využívá automatickou konfiguraci Spring Security pro sestavení AuthenticationProvideru.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
@RequiredArgsConstructor
public class SecurityBeansConfig {

    private final UserRepository userRepository;

    /**
     * Definuje UserDetailsService pro vyhledávání uživatelů podle e-mailu.
     * Spring Security tento bean automaticky použije pro výchozí DaoAuthenticationProvider.
     *
     * @return implementace UserDetailsService načítající uživatele z databáze
     */
    @Bean
    public UserDetailsService userDetailsService() {
        return username -> userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("Uživatel s e-mailem " + username + " nebyl nalezen."));
    }

    /**
     * Definuje algoritmus pro hašování hesel (BCrypt se silou 12).
     * Spring Security tento bean automaticky použije pro verifikaci hesel v DaoAuthenticationProvideru.
     *
     * @return BCryptPasswordEncoder s cost faktorem 12
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    /**
     * Poskytuje AuthenticationManager sestavený Spring Security z definovaných beanů
     * userDetailsService a passwordEncoder.
     *
     * @param config Spring Security authentication configuration
     * @return nakonfigurovaný AuthenticationManager
     * @throws Exception při chybě získání manageru
     */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
}
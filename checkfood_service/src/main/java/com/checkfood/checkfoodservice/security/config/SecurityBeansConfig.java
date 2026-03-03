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
 */
@Configuration
@RequiredArgsConstructor
public class SecurityBeansConfig {

    private final UserRepository userRepository;

    /**
     * Definice UserDetailsService pro vyhledávání uživatelů podle e-mailu.
     * Spring Security tento Bean automaticky použije pro výchozí DaoAuthenticationProvider.
     */
    @Bean
    public UserDetailsService userDetailsService() {
        return username -> userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("Uživatel s e-mailem " + username + " nebyl nalezen."));
    }

    /**
     * Definice algoritmu pro hašování hesel (BCrypt se silou 12).
     * Spring Security tento Bean automaticky použije pro verifikaci hesel v DaoAuthenticationProvideru.
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    /**
     * Získání AuthenticationManageru z připravené konfigurace.
     * Ten v sobě automaticky ponese DaoAuthenticationProvider nakonfigurovaný
     * pomocí Beany userDetailsService a passwordEncoder výše.
     */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
}
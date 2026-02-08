package com.checkfood.checkfoodservice.security.config;

import com.checkfood.checkfoodservice.security.module.jwt.filter.JwtAuthenticationFilter;
import com.checkfood.checkfoodservice.security.module.jwt.handler.JwtAuthenticationEntryPoint;
import com.checkfood.checkfoodservice.security.module.jwt.handler.JwtAccessDeniedHandler;
import com.checkfood.checkfoodservice.security.module.jwt.properties.JwtProperties;
import com.checkfood.checkfoodservice.security.module.oauth.properties.GoogleOAuthProperties;
import com.checkfood.checkfoodservice.security.module.oauth.properties.AppleOAuthProperties;
import com.checkfood.checkfoodservice.security.audit.properties.AuditProperties;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

/**
 * Centrální konfigurace Spring Security pro aplikaci.
 * Definuje security filter chain se stateless JWT autentizací, přístupová pravidla,
 * CORS nastavení a vlastní exception handlery pro neautorizované požadavky.
 *
 * @see JwtAuthenticationFilter
 * @see JwtAuthenticationEntryPoint
 * @see JwtAccessDeniedHandler
 */
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
@EnableConfigurationProperties({
        JwtProperties.class,
        GoogleOAuthProperties.class,
        AppleOAuthProperties.class,
        AuditProperties.class,
})
public class SecurityConfig {

    private final JwtAuthenticationFilter jwtAuthenticationFilter;
    private final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
    private final JwtAccessDeniedHandler jwtAccessDeniedHandler;

    /**
     * Konfiguruje security filter chain s JWT autentizací a přístupovými pravidly.
     * Používá stateless session management a deaktivuje CSRF pro REST API.
     * Definuje veřejné endpointy pro autentizaci, dokumentaci a monitoring.
     *
     * @param http HttpSecurity builder
     * @return nakonfigurovaný security filter chain
     * @throws Exception při chybě konfigurace
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(Customizer.withDefaults())
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))

                .exceptionHandling(exceptions -> exceptions
                        .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                        .accessDeniedHandler(jwtAccessDeniedHandler)
                )

                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(
                                "/api/auth/login",
                                "/api/auth/register",
                                "/api/auth/refresh",
                                "/api/auth/verify",
                                "/api/auth/resend-code",
                                "/api/oauth/**"
                        ).permitAll()

                        .requestMatchers(
                                "/v3/api-docs/**",
                                "/swagger-ui/**",
                                "/swagger-ui.html",
                                "/webjars/**"
                        ).permitAll()

                        .requestMatchers("/actuator/health", "/actuator/info").permitAll()

                        .anyRequest().authenticated()
                )

                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    /**
     * Poskytuje AuthenticationManager pro ruční autentizaci v service vrstvě.
     * Používá se v AuthService pro validaci přihlašovacích údajů.
     *
     * @param config konfigurace autentizace
     * @return authentication manager
     * @throws Exception při chybě získání manageru
     */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
}
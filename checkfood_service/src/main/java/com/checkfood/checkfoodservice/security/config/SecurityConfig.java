package com.checkfood.checkfoodservice.security.config;

import com.checkfood.checkfoodservice.security.module.jwt.filter.JwtAuthenticationFilter;
import com.checkfood.checkfoodservice.security.module.jwt.handler.JwtAuthenticationEntryPoint;
import com.checkfood.checkfoodservice.security.module.jwt.handler.JwtAccessDeniedHandler;
import com.checkfood.checkfoodservice.security.module.jwt.properties.JwtProperties;
import com.checkfood.checkfoodservice.security.module.oauth.module.apple.properties.AppleOAuthProperties;
import com.checkfood.checkfoodservice.security.module.oauth.module.google.properties.GoogleOAuthProperties;
import com.checkfood.checkfoodservice.security.audit.properties.AuditProperties;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

/**
 * Centrální konfigurace Spring Security.
 * CORS je řešen externě skrze CorsConfig.
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

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(Customizer.withDefaults()) // Automaticky vyhledá bean 'corsConfigurationSource'
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))

                .exceptionHandling(exceptions -> exceptions
                        .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                        .accessDeniedHandler(jwtAccessDeniedHandler)
                )

                .authorizeHttpRequests(auth -> auth
                        .requestMatchers(
                                "/api/auth/register",
                                "/api/auth/register-owner",
                                "/api/auth/login",
                                "/api/auth/verify",
                                "/api/auth/resend-code",
                                "/api/auth/refresh",
                                "/api/auth/logout",
                                "/api/oauth/**"
                        ).permitAll()

                        .requestMatchers(
                                "/v3/api-docs/**",
                                "/swagger-ui/**",
                                "/swagger-ui.html"
                        ).permitAll()

                        .requestMatchers("/actuator/health", "/actuator/info").permitAll()

                        .requestMatchers("/api/v1/internal/**").permitAll()
                        .requestMatchers("/panoramas/**").permitAll()
                        .requestMatchers("/uploads/**").permitAll()

                        .anyRequest().authenticated()
                )

                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
}
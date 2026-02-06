package com.checkfood.checkfoodservice.security.config;

import com.checkfood.checkfoodservice.security.jwt.filter.JwtAuthenticationFilter;
import com.checkfood.checkfoodservice.security.jwt.handler.JwtAuthenticationEntryPoint;
import com.checkfood.checkfoodservice.security.jwt.handler.JwtAccessDeniedHandler;
import com.checkfood.checkfoodservice.security.jwt.properties.JwtProperties;
import com.checkfood.checkfoodservice.security.oauth.properties.GoogleOAuthProperties;
import com.checkfood.checkfoodservice.security.oauth.properties.AppleOAuthProperties;
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
 * Centrální konfigurace Spring Security.
 * Definuje pravidla přístupu, politiku relací a integruje JWT autentizační řetězec.
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
                // 1. Základní nastavení (CORS, CSRF, Session)
                .cors(Customizer.withDefaults())
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))

                // 2. Centrální ošetření výjimek (401 a 403)
                .exceptionHandling(exceptions -> exceptions
                        .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                        .accessDeniedHandler(jwtAccessDeniedHandler)
                )

                // 3. Definice přístupových pravidel
                .authorizeHttpRequests(auth -> auth
                        // Veřejné endpointy pro autentizaci
                        .requestMatchers(
                                "/api/auth/login",
                                "/api/auth/register",
                                "/api/auth/refresh",
                                "/api/auth/verify",       // <--- PŘIDÁNO: Nutné pro kliknutí na odkaz z mailu
                                "/api/auth/resend-code",  // <--- PŘIDÁNO: Nutné, pokud uživatel potřebuje nový kód
                                "/api/oauth/**"
                        ).permitAll()

                        // Dokumentace (Swagger/OpenAPI)
                        .requestMatchers(
                                "/v3/api-docs/**",
                                "/swagger-ui/**",
                                "/swagger-ui.html",
                                "/webjars/**"
                        ).permitAll()

                        // Health checky a monitoring
                        .requestMatchers("/actuator/health", "/actuator/info").permitAll()

                        // Vše ostatní vyžaduje platný JWT
                        .anyRequest().authenticated()
                )

                // 4. Registrace JWT filtru do řetězce
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    /**
     * Zpřístupnění AuthenticationManageru pro AuthService.
     */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }
}
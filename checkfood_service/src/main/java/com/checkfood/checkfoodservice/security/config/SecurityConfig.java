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
import org.springframework.security.web.header.writers.ReferrerPolicyHeaderWriter;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

/**
 * Centrální konfigurace Spring Security. Definuje filter chain, povolené URL a CSRF/session politiku.
 * CORS je řešen externě skrze {@link CorsConfig}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
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
     * Gate for the anonymous Swagger UI + OpenAPI JSON endpoints. Defaults
     * to {@code false} — turn it on explicitly via
     * {@code app.swagger.public-access=true} in non-prod profiles. In prod
     * the endpoints are either hidden (requires authentication with ADMIN
     * role) or completely excluded via a profile guard on springdoc.
     * Either way, the prod bundle never advertises its full API surface to
     * anonymous clients.
     */
    @org.springframework.beans.factory.annotation.Value("${app.swagger.public-access:false}")
    private boolean swaggerPublicAccess;

    /**
     * Sestavuje hlavní security filter chain aplikace.
     *
     * @param http HttpSecurity builder pro konfiguraci pravidel
     * @return nakonfigurovaný SecurityFilterChain
     * @throws Exception při chybě sestavení filter chain
     */
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .cors(Customizer.withDefaults())
                .csrf(AbstractHttpConfigurer::disable)
                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))

                // ---------------------------------------------------------
                // Security headers (OWASP ASVS V14.4 / Secure Headers Project)
                //
                // Required because CheckFood ships a REST API consumed by a
                // mobile client, not a browser app — but Swagger UI and
                // Spring's error pages ARE served to browsers, so hardening
                // matters whenever a browser hits any endpoint.
                // ---------------------------------------------------------
                .headers(headers -> headers
                        // HSTS: enforce HTTPS for 1 year, cover subdomains.
                        // Takes effect automatically only over HTTPS — Spring
                        // skips the header on http:// (safe for local dev).
                        .httpStrictTransportSecurity(hsts -> hsts
                                .includeSubDomains(true)
                                .maxAgeInSeconds(31_536_000))
                        // Content Security Policy: lock down what Swagger UI
                        // may load. `self` + inline styles for swagger-ui's
                        // bundle + data: for icons. No eval, no unknown src.
                        .contentSecurityPolicy(csp -> csp.policyDirectives(
                                "default-src 'self'; "
                                + "script-src 'self' 'unsafe-inline'; "
                                + "style-src 'self' 'unsafe-inline'; "
                                + "img-src 'self' data: https:; "
                                + "font-src 'self' data:; "
                                + "connect-src 'self'; "
                                + "frame-ancestors 'none'; "
                                + "base-uri 'self'; "
                                + "form-action 'self'"))
                        // Referrer-Policy: don't leak full URL cross-origin.
                        .referrerPolicy(rp -> rp.policy(
                                ReferrerPolicyHeaderWriter.ReferrerPolicy.STRICT_ORIGIN_WHEN_CROSS_ORIGIN))
                        // X-Frame-Options / X-Content-Type-Options are on
                        // by default in Spring Security; leave as-is.
                )

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
                                "/api/auth/forgot-password",
                                "/api/auth/reset-password",
                                "/api/oauth/**"
                        ).permitAll()

                        // Swagger UI: anonymous access is dev-only. In prod
                        // (app.swagger.public-access=false — the default),
                        // the same matchers fall through to
                        // hasRole('ADMIN') so the endpoints still work for
                        // authenticated admins but don't expose the full
                        // API surface to casual attackers.
                        .requestMatchers(
                                "/v3/api-docs/**",
                                "/swagger-ui/**",
                                "/swagger-ui.html"
                        ).access((authenticationSupplier, ctx) -> {
                            if (swaggerPublicAccess) {
                                return new org.springframework.security.authorization.AuthorizationDecision(true);
                            }
                            var principal = authenticationSupplier.get();
                            boolean isAdmin = principal != null
                                    && principal.isAuthenticated()
                                    && principal.getAuthorities().stream()
                                            .anyMatch(a -> "ROLE_ADMIN".equals(a.getAuthority()));
                            return new org.springframework.security.authorization.AuthorizationDecision(isAdmin);
                        })

                        .requestMatchers("/actuator/health", "/actuator/health/**", "/actuator/info").permitAll()

                        // Well-known files for platform verification (Android
                        // App Links assetlinks.json, Apple App Site Association).
                        .requestMatchers("/.well-known/**").permitAll()

                        .requestMatchers("/api/v1/payments/callback").permitAll()
                        // Lokální dev — statické servírování public uploadů; v prod se nepoužívá (GCS přímo).
                        .requestMatchers("/uploads/public/**").permitAll()
                        .requestMatchers(
                                "/api/v1/restaurants/markers",
                                "/api/v1/restaurants/all-markers",
                                "/api/v1/restaurants/markers-version",
                                "/api/v1/restaurants/nearest",
                                "/api/v1/restaurants/{id}",
                                "/api/v1/restaurants/{restaurantId}/gallery",
                                "/api/v1/restaurants/{restaurantId}/menu"
                        ).permitAll()

                        .anyRequest().authenticated()
                )

                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
}
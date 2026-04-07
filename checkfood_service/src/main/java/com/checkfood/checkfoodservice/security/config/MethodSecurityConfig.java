package com.checkfood.checkfoodservice.security.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;

/**
 * Konfigurace method-level security pro jemnou autorizační kontrolu.
 * Aktivuje podporu pro anotace {@code @PreAuthorize}, {@code @PostAuthorize} a {@code @Secured}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
@EnableMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class MethodSecurityConfig {
}
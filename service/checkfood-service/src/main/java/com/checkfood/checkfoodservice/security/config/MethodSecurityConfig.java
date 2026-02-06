package com.checkfood.checkfoodservice.security.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;

/**
 * Zapíná method-level security:
 * - @PreAuthorize
 * - @PostAuthorize
 * - @Secured
 */
@Configuration
@EnableMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class MethodSecurityConfig {
}

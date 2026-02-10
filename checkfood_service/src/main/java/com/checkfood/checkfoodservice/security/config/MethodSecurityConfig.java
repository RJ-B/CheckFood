package com.checkfood.checkfoodservice.security.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;

/**
 * Konfigurace method-level security pro jemnou autorizační kontrolu.
 * Aktivuje anotace pro zabezpečení metod na úrovni service nebo controller vrstvy.
 * Podporované anotace: @PreAuthorize, @PostAuthorize, @Secured.
 */
@Configuration
@EnableMethodSecurity(prePostEnabled = true, securedEnabled = true)
public class MethodSecurityConfig {
}
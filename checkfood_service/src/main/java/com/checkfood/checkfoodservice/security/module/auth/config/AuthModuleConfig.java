package com.checkfood.checkfoodservice.security.module.auth.config;

import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace autentizačního modulu.
 * Zodpovídá za aktivaci načítání vlastností (Properties) specifických pro Auth modul.
 */
@Configuration
@ConfigurationPropertiesScan(basePackages = "com.checkfood.checkfoodservice.security.module.auth")
public class AuthModuleConfig {
    // V případě potřeby zde lze definovat specifické beany pro lokální auth proces,
    // které vyžadují manuální konfiguraci (např. Password Validator Factory).
}
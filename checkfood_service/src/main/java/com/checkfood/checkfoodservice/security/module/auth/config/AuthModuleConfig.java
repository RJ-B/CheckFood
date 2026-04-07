package com.checkfood.checkfoodservice.security.module.auth.config;

import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.context.annotation.Configuration;

/**
 * Konfigurace autentizačního modulu.
 * Aktivuje automatické načítání konfiguračních properties ze security.auth prefixu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
@ConfigurationPropertiesScan(basePackages = "com.checkfood.checkfoodservice.security.module.auth")
public class AuthModuleConfig {
}
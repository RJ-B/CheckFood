package com.checkfood.checkfoodservice.security.module.oauth.config;

import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

/**
 * Centrální konfigurace OAuth modulu.
 * Aktivuje Feign klienty pro externí API volání a skenuje vlastnosti pro sub-moduly.
 */
@Configuration
@EnableFeignClients(basePackages = "com.checkfood.checkfoodservice.security.module.oauth")
@ConfigurationPropertiesScan(basePackages = "com.checkfood.checkfoodservice.security.module.oauth")
public class OAuthModuleConfig {
    // Tato třída slouží jako orchestrátor modulu.
}
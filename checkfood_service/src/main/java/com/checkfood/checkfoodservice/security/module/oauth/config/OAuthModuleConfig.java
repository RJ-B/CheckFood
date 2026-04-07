package com.checkfood.checkfoodservice.security.module.oauth.config;

import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Configuration;

/**
 * Centrální konfigurace OAuth modulu aktivující Feign klienty a skenování konfiguračních vlastností.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 */
@Configuration
@EnableFeignClients(basePackages = "com.checkfood.checkfoodservice.security.module.oauth")
@ConfigurationPropertiesScan(basePackages = "com.checkfood.checkfoodservice.security.module.oauth")
public class OAuthModuleConfig {
}
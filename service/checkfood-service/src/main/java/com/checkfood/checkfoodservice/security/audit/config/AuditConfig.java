package com.checkfood.checkfoodservice.security.audit.config;

import com.checkfood.checkfoodservice.security.audit.properties.AuditProperties;

import org.springframework.boot.context.properties.EnableConfigurationProperties;

import org.springframework.context.annotation.Configuration;

import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Konfigurace auditního modulu.
 */
@Configuration
@EnableAsync
@EnableScheduling
@EnableConfigurationProperties(AuditProperties.class)
public class AuditConfig {
    // Aktivuje audit subsystem
}

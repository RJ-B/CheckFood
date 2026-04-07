package com.checkfood.checkfoodservice.security.audit.config;

import com.checkfood.checkfoodservice.security.audit.properties.AuditProperties;

import org.springframework.boot.context.properties.EnableConfigurationProperties;

import org.springframework.context.annotation.Configuration;

import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Konfigurace auditního modulu.
 * Aktivuje asynchronní zpracování auditních událostí, plánované úlohy pro údržbu
 * auditních záznamů a načítání konfiguračních vlastností z {@link AuditProperties}.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuditProperties
 */
@Configuration
@EnableAsync
@EnableScheduling
@EnableConfigurationProperties(AuditProperties.class)
public class AuditConfig {
}
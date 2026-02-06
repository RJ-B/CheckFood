package com.checkfood.checkfoodservice.security.audit.properties;

import lombok.Getter;
import lombok.Setter;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurace auditního modulu.
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.audit")
public class AuditProperties {

    /**
     * Zapnutí / vypnutí auditu.
     */
    private boolean enabled = true;

    /**
     * Retence dat ve dnech.
     * Default: 30 dní
     */
    private int retentionDays = 30;

}

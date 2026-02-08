package com.checkfood.checkfoodservice.security.audit.properties;

import lombok.Getter;
import lombok.Setter;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Konfigurační properties pro auditní modul.
 * Načítá hodnoty z application properties s prefixem "security.audit".
 *
 * @see com.checkfood.checkfoodservice.security.audit.config.AuditConfig
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "security.audit")
public class AuditProperties {

    /**
     * Určuje, zda je auditní modul aktivní.
     * Výchozí hodnota: true
     */
    private boolean enabled = true;

    /**
     * Počet dní, po které jsou auditní záznamy uchovávány v databázi.
     * Starší záznamy jsou automaticky mazány úklidem.
     * Výchozí hodnota: 30 dní
     */
    private int retentionDays = 30;

}
package com.checkfood.checkfoodservice.security.audit.event;

import lombok.Getter;

import org.springframework.context.ApplicationEvent;

/**
 * Událost reprezentující bezpečnostní akci v systému.
 */
@Getter
public class AuditEvent extends ApplicationEvent {

    // ID uživatele (null pokud anonym)
    private final Long userId;

    // Typ akce
    private final AuditAction action;

    // Výsledek
    private final AuditStatus status;

    // IP adresa
    private final String ipAddress;

    // User-Agent / zařízení
    private final String userAgent;


    public AuditEvent(
            Object source,
            Long userId,
            AuditAction action,
            AuditStatus status,
            String ipAddress,
            String userAgent
    ) {
        super(source);

        this.userId = userId;
        this.action = action;
        this.status = status;
        this.ipAddress = ipAddress;
        this.userAgent = userAgent;
    }

}

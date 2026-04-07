package com.checkfood.checkfoodservice.security.audit.event;

import lombok.Getter;

import org.springframework.context.ApplicationEvent;

/**
 * Spring ApplicationEvent reprezentující bezpečnostní akci v systému.
 * Slouží pro asynchronní zpracování auditních událostí prostřednictvím event publishingu.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see AuditAction
 * @see AuditStatus
 */
@Getter
public class AuditEvent extends ApplicationEvent {

    /**
     * ID uživatele, který provedl akci.
     * Hodnota null reprezentuje anonymní nebo systémovou akci.
     */
    private final Long userId;

    /**
     * Typ provedené akce.
     */
    private final AuditAction action;

    /**
     * Výsledek provedené akce.
     */
    private final AuditStatus status;

    /**
     * IP adresa, ze které byla akce provedena.
     */
    private final String ipAddress;

    /**
     * User agent klienta, který provedl akci.
     */
    private final String userAgent;


    /**
     * Vytvoří novou auditní událost.
     *
     * @param source zdroj události
     * @param userId ID uživatele (null pro anonymní akce)
     * @param action typ provedené akce
     * @param status výsledek akce
     * @param ipAddress IP adresa klienta
     * @param userAgent user agent klienta
     */
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
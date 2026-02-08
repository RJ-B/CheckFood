package com.checkfood.checkfoodservice.security.audit.entity;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;

import jakarta.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

/**
 * JPA entita reprezentující auditní záznam v databázi.
 * Ukládá informace o provedených akcích v systému včetně kontextu a výsledku.
 * Tabulka je indexována pro efektivní vyhledávání podle uživatele, času a typu akce.
 *
 * @see AuditAction
 * @see AuditStatus
 */
@Getter
@Setter
@Entity
@Table(
        name = "audit_logs",
        indexes = {

                @Index(
                        name = "idx_audit_user_id",
                        columnList = "user_id"
                ),

                @Index(
                        name = "idx_audit_created_at",
                        columnList = "created_at"
                ),

                @Index(
                        name = "idx_audit_action",
                        columnList = "action"
                )
        }
)
public class AuditLogEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * ID uživatele, který provedl akci.
     * Hodnota null reprezentuje anonymní nebo systémovou akci.
     */
    @Column(name = "user_id")
    private Long userId;

    /**
     * Typ provedené akce.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private AuditAction action;

    /**
     * Výsledek provedené akce.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private AuditStatus status;

    /**
     * IP adresa, ze které byla akce provedena.
     * Podporuje IPv4 i IPv6 formát.
     */
    @Column(name = "ip_address", length = 45)
    private String ipAddress;

    /**
     * User agent klienta, který provedl akci.
     */
    @Column(name = "user_agent", length = 255)
    private String userAgent;

    /**
     * Timestamp vytvoření auditního záznamu.
     * Automaticky nastaven při persistenci entity.
     */
    @Column(
            name = "created_at",
            nullable = false,
            updatable = false
    )
    private Instant createdAt;


    /**
     * JPA lifecycle callback pro automatické nastavení času vytvoření.
     */
    @PrePersist
    protected void onCreate() {
        this.createdAt = Instant.now();
    }

}
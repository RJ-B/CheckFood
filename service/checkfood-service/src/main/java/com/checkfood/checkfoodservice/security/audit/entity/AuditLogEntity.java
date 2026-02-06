package com.checkfood.checkfoodservice.security.audit.entity;

import com.checkfood.checkfoodservice.security.audit.event.AuditAction;
import com.checkfood.checkfoodservice.security.audit.event.AuditStatus;

import jakarta.persistence.*;

import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

/**
 * Entita auditního záznamu.
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
     * ID uživatele (null = anonymní akce).
     */
    @Column(name = "user_id")
    private Long userId;

    /**
     * Typ akce.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private AuditAction action;

    /**
     * Výsledek akce.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private AuditStatus status;

    /**
     * IP adresa.
     */
    @Column(name = "ip_address", length = 45)
    private String ipAddress;

    /**
     * User agent.
     */
    @Column(name = "user_agent", length = 255)
    private String userAgent;

    /**
     * Čas vytvoření záznamu.
     */
    @Column(
            name = "created_at",
            nullable = false,
            updatable = false
    )
    private Instant createdAt;


    @PrePersist
    protected void onCreate() {
        this.createdAt = Instant.now();
    }

}

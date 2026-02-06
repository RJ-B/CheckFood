package com.checkfood.checkfoodservice.security.user.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

/**
 * Entita reprezentující zařízení nebo relaci uživatele.
 * Slouží pro správu přihlášených zařízení, zabezpečení účtu a audit přístupů.
 */
@Entity
@Table(
        name = "devices",
        indexes = {
                @Index(name = "idx_device_user", columnList = "user_id"),
                @Index(name = "idx_device_identifier", columnList = "device_identifier")
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DeviceEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Jedinečný identifikátor zařízení (např. UUID vygenerované aplikací nebo HW ID).
     */
    @Column(name = "device_identifier", nullable = false, unique = true)
    private String deviceIdentifier;

    /**
     * Typ zařízení (např. "ANDROID", "IOS", "WEB").
     */
    @Column(name = "device_type")
    private String deviceType;

    /**
     * Čitelný název zařízení (např. "Samsung Galaxy S23", "Chrome na macOS").
     */
    @Column(name = "device_name")
    private String deviceName;

    /**
     * IP adresa posledního přístupu (podpora pro IPv4 i IPv6).
     */
    @Column(name = "last_ip_address", length = 45)
    private String lastIpAddress;

    /**
     * PŘIDÁNO: Kompletní User-Agent řetězec pro hloubkový audit a opravu chyby v Service.
     */
    @Column(name = "user_agent", length = 512)
    private String userAgent;

    /**
     * PŘEJMENOVÁNO z 'lastLogin': Čas poslední aktivity zařízení.
     * Service vrstva používá název 'lastActiveAt', proto to musí sedět.
     */
    @Column(name = "last_active_at", nullable = false)
    private LocalDateTime lastActiveAt;

    /**
     * Vztah k uživateli. Lazy fetch je zde nezbytný pro výkon.
     */
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    // --- AUDITNÍ LOGIKA ---

    @PrePersist
    protected void onCreate() {
        if (this.lastActiveAt == null) {
            this.lastActiveAt = LocalDateTime.now();
        }
    }

    @PreUpdate
    protected void onUpdate() {
        this.lastActiveAt = LocalDateTime.now();
    }
}
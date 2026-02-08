package com.checkfood.checkfoodservice.security.module.user.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

/**
 * Entita reprezentující klientské zařízení a jeho aktivní relaci v systému.
 * Slouží jako primární zdroj dat pro auditování přístupů a správu bezpečnosti relací.
 */
@Entity
@Table(
        name = "devices",
        indexes = {
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

    @Column(name = "device_identifier", nullable = false, unique = true)
    private String deviceIdentifier;

    @Column(name = "device_type")
    private String deviceType;

    @Column(name = "device_name")
    private String deviceName;

    @Column(name = "last_ip_address", length = 45)
    private String lastIpAddress;

    @Column(name = "user_agent", length = 512)
    private String userAgent;

    /**
     * Časová značka posledního úspěšného přihlášení nebo interakce skrze toto zařízení.
     */
    @Column(name = "last_login", nullable = false)
    private LocalDateTime lastLogin;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    @PrePersist
    protected void onCreate() {
        if (this.lastLogin == null) {
            this.lastLogin = LocalDateTime.now();
        }
    }

    @PreUpdate
    protected void onUpdate() {
        this.lastLogin = LocalDateTime.now();
    }
}
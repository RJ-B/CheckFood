package com.checkfood.checkfoodservice.security.module.user.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

/**
 * JPA entita reprezentující klientské zařízení a jeho aktivní relaci v systému.
 * Slouží jako primární zdroj dat pro auditování přístupů a správu bezpečnosti relací.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserEntity
 */
@Entity
@Table(
        name = "devices",
        indexes = {
                @Index(name = "idx_device_identifier", columnList = "device_identifier")
        },
        uniqueConstraints = {
                @UniqueConstraint(name = "uk_device_identifier_user", columnNames = {"device_identifier", "user_id"})
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

    @Column(name = "device_identifier", nullable = false)
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
     * Firebase Cloud Messaging token pro push notifikace.
     * Nullable — starší zařízení nemusí mít FCM token.
     * Nastavuje se při zapnutí notifikací uživatelem.
     */
    @Column(name = "fcm_token", length = 512)
    private String fcmToken;

    /**
     * Uživatelská preference pro push notifikace na tomto zařízení.
     * {@code false} = uživatel nechce notifikace (výchozí stav).
     */
    @Builder.Default
    @Column(name = "notifications_enabled", nullable = false)
    private boolean notificationsEnabled = false;

    /**
     * Příznak aktivity zařízení.
     * {@code true} = zařízení je aktivní (přihlášeno), {@code false} = odhlášeno (zachováno v DB, soft-logout).
     * Pole pojmenováno {@code active} aby Lombok vygeneroval správný getter {@code isActive()}.
     */
    @Builder.Default
    @Column(name = "is_active", nullable = false)
    private boolean active = true;

    /**
     * Časová značka posledního úspěšného přihlášení nebo interakce skrze toto zařízení.
     */
    @Column(name = "last_login", nullable = false)
    private LocalDateTime lastLogin;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    /**
     * Nastaví výchozí hodnotu lastLogin před prvním persistováním entity.
     */
    @PrePersist
    protected void onCreate() {
        if (this.lastLogin == null) {
            this.lastLogin = LocalDateTime.now();
        }
    }

    /**
     * Aktualizuje časovou značku posledního přihlášení při každé změně entity.
     */
    @PreUpdate
    protected void onUpdate() {
        this.lastLogin = LocalDateTime.now();
    }
}
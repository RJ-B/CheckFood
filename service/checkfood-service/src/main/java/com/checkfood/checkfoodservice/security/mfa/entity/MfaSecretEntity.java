package com.checkfood.checkfoodservice.security.mfa.entity;

import com.checkfood.checkfoodservice.security.user.entity.UserEntity;

import jakarta.persistence.*;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Entita pro MFA (TOTP) tajný klíč uživatele.
 */
@Entity
@Table(
        name = "mfa_secrets",
        uniqueConstraints = {
                @UniqueConstraint(columnNames = "user_id")
        }
)
@Getter
@Setter
@NoArgsConstructor
public class MfaSecretEntity {

    // Primární klíč
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Uživatel (1:1)
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    // Base32 secret pro TOTP
    @Column(nullable = false, length = 64)
    private String secret;

    // Je MFA aktivní?
    @Column(nullable = false)
    private boolean enabled = false;

    // Typ metody (zatím TOTP)
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private MfaMethodType method = MfaMethodType.TOTP;

    // Kdy bylo MFA zapnuto
    private LocalDateTime enabledAt;

    // Kdy byl secret vytvořen
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;


    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

}

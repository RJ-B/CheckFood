package com.checkfood.checkfoodservice.security.module.mfa.entity;

import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;

import jakarta.persistence.*;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDateTime;

/**
 * JPA entita uchovávající TOTP tajný klíč a stav MFA pro konkrétního uživatele.
 * Vztah k uživateli je 1:1 — každý uživatel může mít nejvýše jeden aktivní MFA secret.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
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

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private UserEntity user;

    @Column(nullable = false, length = 64)
    private String secret;

    @Column(nullable = false)
    private boolean enabled = false;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private MfaMethodType method = MfaMethodType.TOTP;

    private LocalDateTime enabledAt;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;


    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

}

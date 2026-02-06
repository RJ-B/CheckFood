package com.checkfood.checkfoodservice.security.mfa.entity;

import com.checkfood.checkfoodservice.security.user.entity.UserEntity;

import jakarta.persistence.*;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;

/**
 * Entita pro záložní MFA kódy.
 */
@Entity
@Table(
        name = "mfa_backup_codes",
        indexes = {
                @Index(columnList = "user_id")
        }
)
@Getter
@Setter
@NoArgsConstructor
public class MfaBackupCodeEntity {

    // Primární klíč
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // Uživatel
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private UserEntity user;

    // Hash záložního kódu
    @Column(nullable = false, length = 255)
    private String codeHash;

    // Už byl použit?
    @Column(nullable = false)
    private boolean used = false;

    // Kdy byl vytvořen
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;


    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

}

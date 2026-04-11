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
 * JPA entita uchovávající záložní jednorázové kódy pro případ nedostupnosti TOTP aplikace.
 * Každý kód je uložen ve formě bcrypt hashe a po použití označen příznakem used.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
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

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    private UserEntity user;

    @Column(nullable = false, length = 255)
    private String codeHash;

    @Column(nullable = false)
    private boolean used = false;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;


    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

}

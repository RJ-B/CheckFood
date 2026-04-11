package com.checkfood.checkfoodservice.security.module.auth.entity;

import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * JPA entita pro password reset tokens s time-based expiration a single-use enforcement.
 *
 * Implementuje ManyToOne relationship s UserEntity (jeden uživatel může mít
 * více reset tokenů, ale pouze jeden platný najednou). Token lifecycle je řízen
 * přes expiration timestamp a 'used' flag pro audit trail.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserEntity
 */
@Entity
@Table(name = "password_reset_tokens", indexes = {
        @Index(name = "idx_prt_token", columnList = "token"),
        @Index(name = "idx_prt_user", columnList = "user_id")
})
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PasswordResetTokenEntity {

    /**
     * Primary key pro database identity.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Unique reset token zaslaný v emailovém odkazu.
     * UUID pro vysokou entropii a nepředvídatelnost.
     */
    @Column(nullable = false, unique = true)
    private String token;

    /**
     * Uživatel, jemuž token patří.
     *
     * EAGER fetch je vhodný protože token operace téměř vždy
     * potřebují informace o uživateli pro reset procesu.
     */
    @ManyToOne(targetEntity = UserEntity.class, fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "user_id")
    @org.hibernate.annotations.OnDelete(action = org.hibernate.annotations.OnDeleteAction.CASCADE)
    private UserEntity user;

    /**
     * Timestamp expirace tokenu pro vymáhání security policy.
     * Po expiraci nelze token použít pro reset hesla.
     */
    @Column(nullable = false)
    private LocalDateTime expiryDate;

    /**
     * Flag označující, zda byl token již použit.
     * Zabraňuje opakovanému použití a umožňuje audit trail.
     */
    @Builder.Default
    @Column(nullable = false)
    private boolean used = false;

    /**
     * Utility metoda pro výpočet data expirace.
     *
     * @param expiryTimeInMinutes platnost tokenu v minutách
     * @return vypočítaný timestamp expirace
     */
    public static LocalDateTime calculateExpiryDate(int expiryTimeInMinutes) {
        return LocalDateTime.now().plusMinutes(expiryTimeInMinutes);
    }
}

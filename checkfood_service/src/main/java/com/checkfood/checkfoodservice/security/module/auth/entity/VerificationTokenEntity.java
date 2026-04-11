package com.checkfood.checkfoodservice.security.module.auth.entity;

import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * JPA entita pro email verification tokens s time-based expiration.
 *
 * Implementuje one-to-one relationship s UserEntity pro account activation
 * workflow. Token lifecycle je managed přes expiration timestamp a automatic
 * cleanup po successful verification.
 *
 * @author Rostislav Jirák
 * @version 1.0.0
 * @see UserEntity
 */
@Entity
@Table(name = "verification_tokens")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class VerificationTokenEntity {

    /**
     * Primary key pro database identity.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Unique verification token sent v email link.
     * Typically UUID for high entropy a unpredictability.
     */
    @Column(nullable = false, unique = true)
    private String token;

    /**
     * User association pro token ownership.
     *
     * EAGER fetch je appropriate protože token operations téměř vždy
     * potřebují user information pro verification process.
     */
    @OneToOne(targetEntity = UserEntity.class, fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "user_id")
    @org.hibernate.annotations.OnDelete(action = org.hibernate.annotations.OnDeleteAction.CASCADE)
    private UserEntity user;

    /**
     * Token expiration timestamp pro security policy enforcement.
     * Po expiraci token cannot be used pro account activation.
     */
    @Column(nullable = false)
    private LocalDateTime expiryDate;

    /**
     * Utility method pro expiration date calculation.
     *
     * Poskytuje consistent expiration logic across token generation.
     * Default 24-hour window provides balance mezi user convenience a security.
     *
     * @param expiryTimeInMinutes token validity duration
     * @return calculated expiration timestamp
     */
    public static LocalDateTime calculateExpiryDate(int expiryTimeInMinutes) {
        return LocalDateTime.now().plusMinutes(expiryTimeInMinutes);
    }
}
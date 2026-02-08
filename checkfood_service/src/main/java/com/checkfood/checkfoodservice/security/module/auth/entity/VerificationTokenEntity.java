package com.checkfood.checkfoodservice.security.module.auth.entity;

import com.checkfood.checkfoodservice.security.module.user.entity.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * JPA entita pro verifikační tokeny při registraci uživatelů.
 * Udržuje vazbu mezi tokenem a uživatelským účtem včetně času expirace.
 *
 * @see UserEntity
 */
@Entity
@Table(name = "verification_tokens")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class VerificationTokenEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Jedinečný verifikační token zaslaný v emailu.
     * Typicky UUID nebo jiný náhodně vygenerovaný řetězec.
     */
    @Column(nullable = false, unique = true)
    private String token;

    /**
     * Uživatel, kterému token náleží.
     * EAGER fetch je zde vhodný, protože při načtení tokenu
     * téměř vždy potřebujeme znát přiřazeného uživatele.
     */
    @OneToOne(targetEntity = UserEntity.class, fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "user_id")
    private UserEntity user;

    /**
     * Timestamp expirace tokenu.
     * Po tomto datu již token nelze použít k aktivaci účtu.
     */
    @Column(nullable = false)
    private LocalDateTime expiryDate;

    /**
     * Vypočítá datum expirace tokenu od aktuálního času.
     *
     * @param expiryTimeInMinutes počet minut platnosti tokenu
     * @return timestamp expirace
     */
    public static LocalDateTime calculateExpiryDate(int expiryTimeInMinutes) {
        return LocalDateTime.now().plusMinutes(expiryTimeInMinutes);
    }
}
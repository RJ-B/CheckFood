package com.checkfood.checkfoodservice.security.auth.entity;

import com.checkfood.checkfoodservice.security.user.entity.UserEntity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

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

    // Samotný ověřovací kód (UUID), který pošleme emailem
    @Column(nullable = false, unique = true)
    private String token;

    // Vazba 1:1 na uživatele.
    // FetchType.EAGER je zde v pořádku, protože když načítáme token,
    // vždy chceme vědět, komu patří, abychom ho mohli aktivovat.
    @OneToOne(targetEntity = UserEntity.class, fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "user_id")
    private UserEntity user;

    // Datum, kdy token přestane platit (např. za 24 hodin)
    @Column(nullable = false)
    private LocalDateTime expiryDate;

    /**
     * Pomocná metoda pro výpočet expirace.
     * Použití: VerificationTokenEntity.calculateExpiryDate(24 * 60); // 24 hodin
     */
    public static LocalDateTime calculateExpiryDate(int expiryTimeInMinutes) {
        return LocalDateTime.now().plusMinutes(expiryTimeInMinutes);
    }
}
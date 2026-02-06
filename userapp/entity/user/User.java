package com.checkfood.checkfoodservice.application.entity.user;

import jakarta.persistence.*;
import lombok.*;

import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Doménová entita reprezentující uživatele systému.
 *
 * Uživatel je povinným aktérem všech hlavních doménových operací
 * (objednávky, rezervace, platby).
 *
 * V první verzi systému je registrace povinná.
 * Podpora anonymních (guest) uživatelů je architektonicky
 * připravena, ale funkčně zakázána.
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "app_user",
        indexes = {
                @Index(name = "idx_user_email", columnList = "email"),
                @Index(name = "idx_user_username", columnList = "username"),
                @Index(name = "idx_user_status", columnList = "status")
        }
)
public class User {

    /**
     * Primární identifikátor uživatele.
     *
     * UUID zajišťuje bezpečnost API a konzistenci napříč systémy.
     */
    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Unikátní e-mail uživatele.
     *
     * Slouží jako hlavní přihlašovací identifikátor.
     * Povinný i při registraci přes externí poskytovatele.
     */
    @Column(nullable = false, unique = true, length = 255)
    private String email;

    /**
     * Uživatelské jméno.
     *
     * Volitelné – uživatel se může přihlašovat
     * e-mailem nebo uživatelským jménem.
     */
    @Column(unique = true, length = 100)
    private String username;

    /**
     * Hash hesla.
     *
     * Vyplněno pouze při lokální registraci.
     * Pro externí identity (Google, Apple, …) může být NULL.
     */
    @Column(name = "password_hash", length = 255)
    private String passwordHash;

    /**
     * Stav uživatele z pohledu systému.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private UserStatus status;

    /**
     * Role uživatele v systému.
     *
     * Role nejsou dynamické a jsou řízeny systémově.
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private Role role;

    /**
     * Indikace guest účtu.
     *
     * V první verzi systému je vždy FALSE.
     * Pole je ponecháno kvůli budoucí rozšiřitelnosti
     * bez nutnosti změny databázového schématu.
     */
    @Column(nullable = false)
    private boolean guest;

    /**
     * Datum a čas vytvoření účtu.
     */
    @Column(nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    /**
     * Datum a čas poslední změny účtu.
     */
    @Column(nullable = false)
    private OffsetDateTime updatedAt;

    /**
     * Inicializace auditních polí při vytvoření.
     */
    @PrePersist
    protected void onCreate() {
        OffsetDateTime now = OffsetDateTime.now();
        this.createdAt = now;
        this.updatedAt = now;
        this.guest = false;
    }

    /**
     * Aktualizace času poslední změny.
     */
    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = OffsetDateTime.now();
    }

    /* =========================================================
       ROZŠIŘITELNOST (záměrně neimplementováno)
       ---------------------------------------------------------
       - externí identity (Google, Apple, Facebook, Android)
       - 2FA / MFA
       - profilové údaje (jméno, telefon)
       - deaktivace / anonymizace (GDPR)
       ========================================================= */
}

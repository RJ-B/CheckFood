package com.checkfood.checkfoodservice.application.entity.user;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

/**
 * Entita reprezentující přihlašovací identitu uživatele.
 *
 * Umožňuje jednomu uživateli mít více způsobů přihlášení
 * (email, username, Google, Apple).
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(
        name = "user_identity",
        uniqueConstraints = {
                @UniqueConstraint(
                        name = "uq_identity_provider_identifier",
                        columnNames = {"provider", "identifier"}
                )
        },
        indexes = {
                @Index(name = "idx_identity_user_id", columnList = "user_id"),
                @Index(name = "idx_identity_identifier", columnList = "identifier")
        }
)
public class UserIdentity {

    @Id
    @GeneratedValue
    private UUID id;

    /**
     * Vlastník identity.
     */
    @Column(name = "user_id", nullable = false)
    private UUID userId;

    /**
     * Poskytovatel identity (LOCAL, GOOGLE, APPLE).
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private IdentityProvider provider;

    /**
     * Typ identity (EMAIL, USERNAME, EXTERNAL).
     */
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private IdentityType type;

    /**
     * Identifikátor identity:
     * - email
     * - username
     * - Google subject ID
     */
    @Column(nullable = false, length = 255)
    private String identifier;

    /**
     * Hash hesla – pouze pro LOCAL identity.
     */
    @Column(length = 255)
    private String passwordHash;

    /**
     * Indikace, zda je identita aktivní.
     */
    @Column(nullable = false)
    private boolean active;
}

